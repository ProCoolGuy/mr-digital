<?php
if ($f == "yoomoney") {
	if ($s == 'create') {
		if (!empty($_GET['amount']) && is_numeric($_GET['amount']) && $_GET['amount'] > 0) {
			$amount = Wo_Secure($_GET['amount']);
			$order_id = uniqid();
			$yoomoney_hash = rand(11111,99999).rand(11111,99999);
			$receiver = $wo['config']['yoomoney_wallet_id'];
			$successURL = $wo['config']['site_url'] . "/requests.php?f=yoomoney&s=success";
			$form = '<form id="yoomoney_form" method="POST" action="https://yoomoney.ru/quickpay/confirm.xml">    
						<input type="hidden" name="receiver" value="'.$receiver.'"> 
						<input type="hidden" name="quickpay-form" value="donate"> 
						<input type="hidden" name="targets" value="transaction '.$order_id.'">   
						<input type="hidden" name="paymentType" value="PC"> 
						<input type="hidden" name="sum" value="'.$amount.'" data-type="number"> 
						<input type="hidden" name="successURL" value="'.$successURL.'">
						<input type="hidden" name="label" value="'.$yoomoney_hash.'">
					</form>';
		    $db->where('user_id',$wo['user']['user_id'])->update(T_USERS,array('yoomoney_hash' => $yoomoney_hash));
			$data['status'] = 200;
			$data['html'] = $form;
		}
		else{
	        $data['status'] = 400;
	        $data['error'] = $wo['lang']['invalid_amount_value'];
	    }
	    header("Content-type: application/json");
        echo json_encode($data);
        exit();
	}
	elseif ($s == 'success') {
		$hash = sha1($_POST['notification_type'].'&'.
		$_POST['operation_id'].'&'.
		$_POST['amount'].'&'.
		$_POST['currency'].'&'.
		$_POST['datetime'].'&'.
		$_POST['sender'].'&'.
		$_POST['codepro'].'&'.
		$wo['config']['yoomoney_notifications_secret'].'&'.
		$_POST['label']);

		if ($_POST['sha1_hash'] != $hash || $_POST['codepro'] == true || $_POST['unaccepted'] == true) {
			header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
            exit();
		}
		else{
			if (!empty($_POST['label'])) {
				$user = $db->where('yoomoney_hash',Wo_Secure($_POST['label']))->getOne(T_USERS);
				if (!empty($user)) {
					$amount = Wo_Secure($_POST['amount']);
					$db->where('user_id', $user->user_id)->update(T_USERS, array(
                        'wallet' => $db->inc($amount)
                    ));

                    $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $user->user_id . "', 'WALLET', '" . $amount . "', 'yoomoney')");
                    $db->where('user_id',$user->user_id)->update(T_USERS,array('yoomoney_hash' => ''));
	                $_SESSION['replenished_amount'] = $amount;
	                if (!empty($_COOKIE['redirect_page'])) {
	                	$redirect_page = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_COOKIE['redirect_page']);
					    $redirect_page = preg_replace('/\((.*?)\)/m', '', $redirect_page);
	                	header("Location: " . $redirect_page);
	                }
	                else{
	                	header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
	                }
	                exit();
				}
			}
			header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
			exit();
		}
	}
}