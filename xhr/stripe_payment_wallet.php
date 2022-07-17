<?php 
if ($f == 'stripe_payment_wallet') {
    include_once('assets/includes/stripe_config.php');
    if (empty($_POST['stripeToken'])) {
        header("Location: " . Wo_SeoLink('index.php?link1=oops'));
        exit();
    }
    $token = $_POST['stripeToken'];
    try {
        $customer = \Stripe\Customer::create(array(
            'source' => $token
        ));
        $_POST['amount'] = Wo_Secure($_POST['amount']);
        $final_amount = $_POST['amount'] * 100;
        $charge   = \Stripe\Charge::create(array(
            'customer' => $customer->id,
            'amount' => $final_amount,
            'currency' => $wo['config']['stripe_currency']
        ));
        if ($charge) {
            $user   = Wo_UserData($wo['user']['user_id']);
            //encrease wallet value with posted amount
            $result = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `wallet` = `wallet` + " . $_POST['amount'] . " WHERE `user_id` = '" . $user['id'] . "'");
            if ($result) {
                $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $user['id'] . "', 'WALLET', '" . $_POST['amount'] . "', 'stripe')");
            }
            $data = array(
                'status' => 200,
                'location' => Wo_SeoLink('index.php?link1=wallet')
            );
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        }
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
