<?php
if ($f == '2checkout_wallet') {
    if (empty($_POST['card_number']) || empty($_POST['card_cvc']) || empty($_POST['card_month']) || empty($_POST['card_year']) || empty($_POST['token']) || empty($_POST['card_name']) || empty($_POST['card_address']) || empty($_POST['card_city']) || empty($_POST['card_state']) || empty($_POST['card_zip']) || empty($_POST['card_country']) || empty($_POST['card_email']) || empty($_POST['card_phone'])) {
        $data = array(
            'status' => 400,
            'error' => $wo['lang']['please_check_details']
        );
    } else {
        require_once 'assets/libraries/2checkout/Twocheckout.php';
        Twocheckout::privateKey($wo['config']['checkout_private_key']);
        Twocheckout::sellerId($wo['config']['checkout_seller_id']);
        if ($wo['config']['checkout_mode'] == 'sandbox') {
            Twocheckout::sandbox(true);
        } else {
            Twocheckout::sandbox(false);
        }
        try {
            $amount1 = $_POST['amount'];
            $charge  = Twocheckout_Charge::auth(array(
                "merchantOrderId" => "123",
                "token" => $_POST['token'],
                "currency" => $wo['config']['2checkout_currency'],
                "total" => $amount1,
                "billingAddr" => array(
                    "name" => $_POST['card_name'],
                    "addrLine1" => $_POST['card_address'],
                    "city" => $_POST['card_city'],
                    "state" => $_POST['card_state'],
                    "zipCode" => $_POST['card_zip'],
                    "country" => $wo['countries_name'][$_POST['card_country']],
                    "email" => $_POST['card_email'],
                    "phoneNumber" => $_POST['card_phone']
                )
            ));
            if ($charge['response']['responseCode'] == 'APPROVED') {
                Wo_UpdateUserData($wo['user']['id'], array(
                    'address' => Wo_Secure($_POST['card_address']),
                    'city' => Wo_Secure($_POST['card_city']),
                    'state' => Wo_Secure($_POST['card_state']),
                    'zip' => Wo_Secure($_POST['card_zip'])
                ));
                $user   = Wo_UserData($wo['user']['user_id']);
                $amount = Wo_Secure($_POST['amount']);
                $result = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `wallet` = `wallet` + " . $amount . " WHERE `user_id` = '" . $user['id'] . "'");
                if ($result) {
                    $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $user['id'] . "', 'WALLET', '" . $amount . "', '2Checkout')");
                }
                $data = array(
                    'status' => 200,
                    'location' => Wo_SeoLink('index.php?link1=wallet')
                );
                header("Content-type: application/json");
                echo json_encode($data);
                exit();
            } else {
                $data = array(
                    'status' => 400,
                    'error' => $wo['lang']['2checkout_declined']
                );
                header("Content-type: application/json");
                echo json_encode($data);
                exit();
            }
        }
        catch (Twocheckout_Error $e) {
            $data = array(
                'status' => 400,
                'error' => $e->getMessage()
            );
        }
    }
}
