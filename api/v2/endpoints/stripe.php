<?php
include_once('assets/includes/stripe_config.php');
$pro_types_array = array(
                    1,
                    2,
                    3,
                    4
                );
if (empty($_POST['request']) || empty($_POST['token'])) {
	$error_code    = 4;
    $error_message = 'request and token can not be empty';
}
else{
	if (!empty($_POST['token']) && !empty($_POST['request']) && in_array($_POST['request'], array('wallet','fund','pro')) && !empty($_POST['price']) && is_numeric($_POST['price']) && $_POST['price'] > 0) {
		try {
			$price = Wo_Secure($_POST['price']);
			$db->where('user_id',$wo['user']['id'])->update(T_USERS,array('StripeSessionId' => ''));
			$customer = \Stripe\Customer::create(array(
                'source' => $_POST['token']
            ));
            $charge   = \Stripe\Charge::create(array(
                'customer' => $customer->id,
                'amount' => $price * 100,
                'currency' => $wo['config']['stripe_currency']
            ));
            if ($charge) {
            	$result = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `wallet` = `wallet` + " . $amount . " WHERE `user_id` = '" . $wo['user']['id'] . "'");
	            if ($result) {
	                $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $wo['user']['id'] . "', 'WALLET', '" . $amount . "', 'stripe')");
	            }
				$response_data = array(
	                                'api_status' => 200,
	                                'message' => 'payment successfully'
	                            );
				echo json_encode($response_data, JSON_PRETTY_PRINT);
				exit();

            }
            else{
            	$error_code    = 5;
			    $error_message = 'something went wrong';
            }
		} catch (Exception $e) {
			$error_code    = 8;
			$error_message = $e->getMessage();
		}
	}
	else{
		$error_code    = 4;
	    $error_message = 'request must be wallet , fund , pro and toke and price can not be empty';
	}
}



