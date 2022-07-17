<?php
use SecurionPay\SecurionPayGateway;
use SecurionPay\Exception\SecurionPayException;
use SecurionPay\Request\CheckoutRequestCharge;
use SecurionPay\Request\CheckoutRequest;
if ($f == "securionpay") {
	if ($s == 'create') {
		if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0) {
			require_once 'assets/libraries/securionpay/vendor/autoload.php';
			$price = Wo_Secure($_POST['amount']);
			$securionPay = new SecurionPayGateway($wo['config']['securionpay_secret_key']);
            $user_key = rand(1111,9999).rand(11111,99999);

            $checkoutCharge = new CheckoutRequestCharge();
            $checkoutCharge->amount(($price * 100))->currency('USD')->metadata(array('user_key' => $user_key,
                                                                                     'type' => 'Top Up Wallet'));

            $checkoutRequest = new CheckoutRequest();
            $checkoutRequest->charge($checkoutCharge);

            $signedCheckoutRequest = $securionPay->signCheckoutRequest($checkoutRequest);
            if (!empty($signedCheckoutRequest)) {
                $db->where('user_id',$wo['user']['user_id'])->update(T_USERS,array('securionpay_key' => $user_key));
                $data['status'] = 200;
                $data['token'] = $signedCheckoutRequest;
            }
            else{
                $data['status'] = 400;
                $data['error'] = $wo['lang']['something_wrong'];
            }
		}
		else{
	        $data['status'] = 400;
	        $data['error'] = $wo['lang']['invalid_amount_value'];
	    }
		header("Content-type: application/json");
        echo json_encode($data);
        exit();
	}
	if ($s == 'handle') {
		if (!empty($_POST) && !empty($_POST['charge']) && !empty($_POST['charge']['id'])) {
	        $url = "https://api.securionpay.com/charges?limit=10";

	        $curl = curl_init($url);
	        curl_setopt($curl, CURLOPT_URL, $url);
	        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
	        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	        curl_setopt($curl, CURLOPT_USERPWD, $wo['config']['securionpay_secret_key'].":password");
	        $resp = curl_exec($curl);
	        curl_close($curl);
	        $resp = json_decode($resp,true);
	        if (!empty($resp) && !empty($resp['list'])) {
	            foreach ($resp['list'] as $key => $value) {
	                if ($value['id'] == $_POST['charge']['id']) {
	                    if (!empty($value['metadata']) && !empty($value['metadata']['user_key']) && !empty($value['amount'])) {
	                        if ($wo['user']['securionpay_key'] == $value['metadata']['user_key']) {
	                        	$amount = intval(Wo_Secure($value['amount'])) / 100;
	                        	if (Wo_ReplenishingUserBalance($amount)) {
	                        		$db->where('user_id',$wo['user']['user_id'])->update(T_USERS,array('securionpay_key' => ''));
		                            $create_payment_log             = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $wo['user']['id'] . "', 'WALLET', '" . $amount . "', 'securionpay')");
					                $_SESSION['replenished_amount'] = $amount;
					                $url = Wo_SeoLink('index.php?link1=wallet');
					                if (!empty($_COOKIE['redirect_page'])) {
					                    $redirect_page = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_COOKIE['redirect_page']);
					                    $redirect_page = preg_replace('/\((.*?)\)/m', '', $redirect_page);
					                    $url = $redirect_page;
					                }
					                $data['status'] = 200;
	               					$data['url'] = $url;
	                        	}
	                        }
	                    }
	                }
	            }
	        }
	        else{
	        	$data['status'] = 400;
                $data['error'] = $wo['lang']['something_wrong'];
	        }
	    }
	    else{
	    	$data['status'] = 400;
	        $data['error'] = $wo['lang']['please_check_details'];
	    }
	    header("Content-type: application/json");
        echo json_encode($data);
        exit();
	}
}