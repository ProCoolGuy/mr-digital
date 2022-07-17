<?php 
if ($f == 'paypro_with_bitcoin') {
    if (empty($_GET['amount'])) {
        header("Location: " . Wo_SeoLink('index.php?link1=oops'));
        exit();
    }
    if ($wo['config']['coinpayments_secret'] !== "" && $wo['config']['coinpayments_id'] !== "") {
        try {
            include_once('assets/libraries/coinpayments.php');
            $CP = new \MineSQL\CoinPayments();
            // Set the merchant ID and secret key (can be found in account settings on CoinPayments.net)
            $CP->setMerchantId($wo['config']['coinpayments_id']);
            $CP->setSecretKey($wo['config']['coinpayments_secret']);
            //REQUIRED
            $CP->setFormElement('currency', 'USD');
            $CP->setFormElement('amountf', Wo_Secure($_GET['amount']));
            $desc = 'Replenish my Wallet balance';
            if (!empty($_GET['desc'])) {
                $desc = $_GET['desc'];
            }
            $CP->setFormElement('item_name', $desc);
            //OPTIONAL
            $CP->setFormElement('want_shipping', 0);
            $CP->setFormElement('user_id', $wo['user']['user_id']);
            $CP->setFormElement('user_type', $_GET['usertype']);
            $CP->setFormElement('ipn_url', $wo['config']['site_url'] . '/requests.php?f=coinpayments_procallback');
            $data = array(
                'status' => 200,
                'html' => $CP->createForm()
            );
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        }
        catch (Exception $e) {
            $data = array(
                'status' => 400,
                'error' => $e->getMessage()
            );
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        }
    }
}
