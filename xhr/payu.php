<?php
if ($f == "payu") {
	if ($s == 'create') {
		if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0 && !empty($_POST['card_number']) && !empty($_POST['card_month']) && !empty($_POST['card_year']) && !empty($_POST['card_cvc'])) {
			require_once 'assets/libraries/PayU.php';
			$amount = Wo_Secure($_POST['amount']);
			$amount = intval($amount);
        	$arParams['ORDER_PNAME[0]'] = 'Top Up Wallet';
			$arParams['ORDER_PRICE[0]'] = $amount;
			$arParams['CC_NUMBER'] = $_POST['card_number'];
			$arParams['EXP_MONTH'] = $_POST['card_month'];
			$arParams['EXP_YEAR'] = $_POST['card_year'];
			$arParams['CC_CVV'] = $_POST['card_cvc'];
			$info = PayUPayment($arParams);
			if ($info['status'] == 200) {
				if (Wo_ReplenishingUserBalance($amount)) {
	                $create_payment_log             = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $wo['user']['id'] . "', 'WALLET', '" . $amount . "', 'payu')");
	                $_SESSION['replenished_amount'] = $amount;
	                if (!empty($_COOKIE['redirect_page'])) {
	                    $redirect_page = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_COOKIE['redirect_page']);
	                    $redirect_page = preg_replace('/\((.*?)\)/m', '', $redirect_page);
	                    header("Location: " . $redirect_page);
	                } else {
	                    header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
	                }
	                exit();
	            } else {
	                header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
	                exit();
	            }
			}
			else{
				$data['status'] = 400;
				$data['error'] = $info['error'];
			}
		}
		header("Content-type: application/json");
        echo json_encode($data);
        exit();
	}
}