<?php
if ($f == "coinbase") {
	if ($s == 'create') {
		if (!empty($_GET['amount']) && is_numeric($_GET['amount']) && $_GET['amount'] > 0) {
	        try {

	            $amount = Wo_Secure($_GET['amount']);
	            $coinbase_hash = rand(1111,9999).rand(11111,99999);
	            $ch = curl_init();

	            curl_setopt($ch, CURLOPT_URL, 'https://api.commerce.coinbase.com/charges');
	            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	            curl_setopt($ch, CURLOPT_POST, 1);
	            $postdata =  array('name' => 'Top Up Wallet','description' => 'Top Up Wallet','pricing_type' => 'fixed_price','local_price' => array('amount' => $amount , 'currency' => $wo['config']['currency']), 'metadata' => array('coinbase_hash' => $coinbase_hash),"redirect_url" => $wo['config']['site_url'] . "/requests.php?f=coinbase&s=coinbase_handle&coinbase_hash=".$coinbase_hash,'cancel_url' => $wo['config']['site_url'] . "/requests.php?f=coinbase&s=coinbase_cancel&coinbase_hash=".$coinbase_hash);


	            curl_setopt($ch, CURLOPT_POSTFIELDS,json_encode($postdata));

	            $headers = array();
	            $headers[] = 'Content-Type: application/json';
	            $headers[] = 'X-Cc-Api-Key: '.$wo['config']['coinbase_key'];
	            $headers[] = 'X-Cc-Version: 2018-03-22';
	            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

	            $result = curl_exec($ch);
	            if (curl_errno($ch)) {
	                $data = array(
	                    'status' => 400,
	                    'error' => curl_error($ch)
	                );
	            }
	            curl_close($ch);
	            $result = json_decode($result,true);
	            if (!empty($result) && !empty($result['data']) && !empty($result['data']['hosted_url']) && !empty($result['data']['id']) && !empty($result['data']['code'])) {
	            	$db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('coinbase_hash' => $coinbase_hash,
	                                                                                     'coinbase_code' => $result['data']['code']));
	                $data['status'] = 200;
	                $data['url'] = $result['data']['hosted_url'];
	            }
	        }
	        catch (Exception $e) {
	            $data = array(
	                'status' => 400,
	                'error' => $e->getMessage()
	            );
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
	if ($s == 'coinbase_handle') {
	    if (!empty($_GET['coinbase_hash']) && is_numeric($_GET['coinbase_hash'])) {
	        $coinbase_hash = Wo_Secure($_GET['coinbase_hash']);
	        $user_data = $db->where('coinbase_hash',$coinbase_hash)->getOne(T_USERS);
	        if (!empty($user_data)) {

	            $ch = curl_init();

	            curl_setopt($ch, CURLOPT_URL, 'https://api.commerce.coinbase.com/charges/'.$user_data->coinbase_code);
	            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	            $headers = array();
	            $headers[] = 'Content-Type: application/json';
	            $headers[] = 'X-Cc-Api-Key: '.$wo['config']['coinbase_key'];
	            $headers[] = 'X-Cc-Version: 2018-03-22';
	            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

	            $result = curl_exec($ch);
	            if (curl_errno($ch)) {
	                $url = Wo_SeoLink('index.php?link1=wallet');
	                header("Location: " . $url);
	                exit();
	            }
	            curl_close($ch);
	            $result = json_decode($result,true);
	            $update_data = array('coinbase_hash' => '',
	                                 'coinbase_code' => '');
	            if (!empty($result) && !empty($result['data']) && !empty($result['data']['pricing']) && !empty($result['data']['pricing']['local']) && !empty($result['data']['pricing']['local']['amount']) && !empty($result['data']['payments']) && !empty($result['data']['payments'][0]['status']) && $result['data']['payments'][0]['status'] == 'CONFIRMED') {
	            	$amount = (int)$result['data']['pricing']['local']['amount'];
	            	if (Wo_ReplenishingUserBalance($amount)) {
	            		$db->where('user_id', $wo['user']['user_id'])->update(T_USERS, $update_data);
		                $amount                 = Wo_Secure($amount);
		                $create_payment_log             = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $wo['user']['id'] . "', 'WALLET', '" . $amount . "', 'Coinbase')");
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
	        }
	    }
	    header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
		exit();
	}
	if ($s == 'coinbase_cancel') {
	    if (!empty($_GET['coinbase_hash']) && is_numeric($_GET['coinbase_hash'])) {
	        $coinbase_hash = Wo_Secure($_GET['coinbase_hash']);
	        $user_data = $db->where('coinbase_hash',$coinbase_hash)->getOne(T_USERS);
	        if (!empty($user_data)) {
	        	$db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('coinbase_hash' => '',
	                                                                                 'coinbase_code' => ''));
	        }
	    }
	    header("Location: " . Wo_SeoLink('index.php?link1=wallet'));
		exit();
	}
}