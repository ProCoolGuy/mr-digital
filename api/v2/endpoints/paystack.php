<?php
if (empty($_POST['request'])) {
	$error_code    = 4;
    $error_message = 'request can not be empty';
}
else{
	if ($_POST['request'] == 'initialize') {
		$types = array(
	        'week',
	        'year',
	        'month',
	        'life-time',
	        'wallet',
	        'fund'
	    );

	    if (!empty($_POST['type']) && in_array($_POST['type'], $types) && !empty($_POST['email']) && filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
    		$type = $_POST['type'];
    		$price    = $wo['config']['weekly_price'];
		    $pro_type = 1;
		    if ($type == 'week') {
		        $price    = $wo['pro_packages']['star']['price'];
		        $pro_type = 1;
		    } else if ($type == 'year') {
		        $price    = $wo['pro_packages']['ultima']['price'];
		        $pro_type = 3;
		    } else if ($type == 'month') {
		        $price    = $wo['pro_packages']['hot']['price'];
		        $pro_type = 2;
		    } else if ($type == 'life-time') {
		        $price    = $wo['pro_packages']['vip']['price'];
		        $pro_type = 4;
		    }
		    $callback_url = $wo['config']['site_url'] . "/requests.php?f=paystack&s=upgrade&pro_type=".$pro_type;

		    if ($type == 'wallet') {
		    	if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0) {
		    		$price = $_POST['amount'];
		    		$callback_url = $wo['config']['site_url'] . "/requests.php?f=paystack&s=wallet&amount=".$price;
		    	}
		    	else{
				    $response_data       = array(
				        'api_status'     => '400',
				        'errors'         => array(
				            'error_id'   => 6,
				            'error_text' => 'amount can not be empty'
				        )
				    );
				    echo json_encode($response_data, JSON_PRETTY_PRINT);
				    exit();
		    	}
		    }
		    if ($type == 'fund') {
		    	if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0 && !empty($_POST['fund_id'])) {
		    		$fund_id = Wo_Secure($_POST['fund_id']);
					$fund = $db->where('id',$fund_id)->getOne(T_FUNDING);
					if (!empty($fund)) {
						$price = $_POST['amount'];
			    		$callback_url = $wo['config']['site_url'] . "/requests.php?f=paystack&s=fund&amount=".$price."&fund_id=".$fund_id;
					}
					else{
						$response_data       = array(
					        'api_status'     => '400',
					        'errors'         => array(
					            'error_id'   => 7,
					            'error_text' => 'fund not found'
					        )
					    );
					    echo json_encode($response_data, JSON_PRETTY_PRINT);
					    exit();
					}
			    		
		    	}
		    	else{
		    		$response_data       = array(
				        'api_status'     => '400',
				        'errors'         => array(
				            'error_id'   => 8,
				            'error_text' => 'amount fund_id can not be empty'
				        )
				    );
				    echo json_encode($response_data, JSON_PRETTY_PRINT);
				    exit();
		    	}
		    }

		    $result = array();
		    $reference = uniqid();

			//Set other parameters as keys in the $postdata array
			$postdata =  array('email' => $_POST['email'], 'amount' => $price,"reference" => $reference,'callback_url' => $callback_url);
			$url = "https://api.paystack.co/transaction/initialize";

			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL,$url);
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_POSTFIELDS,json_encode($postdata));  //Post Fields
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

			$headers = [
			  'Authorization: Bearer '.$wo['config']['paystack_secret_key'],
			  'Content-Type: application/json',

			];
			curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

			$request = curl_exec ($ch);

			curl_close ($ch);

			if ($request) {
			    $result = json_decode($request, true);
			    if (!empty($result)) {
					 if (!empty($result['status']) && $result['status'] == 1 && !empty($result['data']) && !empty($result['data']['authorization_url']) && !empty($result['data']['access_code'])) {
					 	$db->where('user_id',$wo['user']['id'])->update(T_USERS,array('paystack_ref' => $reference));
					  	$response_data = array(
			                                'api_status' => 200,
			                                'url' => $result['data']['authorization_url']
			                            );
					}
					else{
				        $error_code    = 11;
					    $error_message = $result['message'];
					}
				}
				else{
				    $error_code    = 10;
				    $error_message = 'something went wrong';
				}
			}
			else{
				$error_code    = 9;
			    $error_message = 'something went wrong';
			}
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'type email can not be empty';
    	}
	}

	if ($_POST['request'] == 'upgrade') {
    	$is_pro = 0;
	    $stop   = 0;
	    $user   = Wo_UserData($wo['user']['user_id']);
	    if ($user['is_pro'] == 1) {
	        $stop = 1;
	        if ($user['pro_type'] == 1) {
	            $time_ = time() - $star_package_duration;
	            if ($user['pro_time'] > $time_) {
	                $stop = 1;
	            }
	        } else if ($user['pro_type'] == 2) {
	            $time_ = time() - $hot_package_duration;
	            if ($user['pro_time'] > $time_) {
	                $stop = 1;
	            }
	        } else if ($user['pro_type'] == 3) {
	            $time_ = time() - $ultima_package_duration;
	            if ($user['pro_time'] > $time_) {
	                $stop = 1;
	            }
	        } else if ($user['pro_type'] == 4) {
	            if ($vip_package_duration > 0) {
	                $time_ = time() - $vip_package_duration;
	                if ($user['pro_time'] > $time_) {
	                    $stop = 1;
	                }
	            }
	        }
	    }
	    if ($stop == 0) {
	        $pro_types_array = array(
	            1,
	            2,
	            3,
	            4
	        );
	        $pro_type        = 0;
	        if (!isset($_POST['pro_type']) || !in_array($_POST['pro_type'], $pro_types_array)) {
	        	$response_data       = array(
			        'api_status'     => '400',
			        'errors'         => array(
			            'error_id'   => 6,
			            'error_text' => 'pro_type can not be empty'
			        )
			    );
			    echo json_encode($response_data, JSON_PRETTY_PRINT);
			    exit();
	        }
	        $pro_type = $_POST['pro_type'];
	        $payment  = Wo_CheckPaystackPayment($_POST['reference']);
	        if ($payment) {
	        	$is_pro = 1;
	        }
	        else{
	        	$response_data       = array(
			        'api_status'     => '400',
			        'errors'         => array(
			            'error_id'   => 7,
			            'error_text' => 'something went wrong'
			        )
			    );
			    echo json_encode($response_data, JSON_PRETTY_PRINT);
			    exit();
	        }


	    }
	    if ($stop == 0) {
	        $time = time();
	        if ($is_pro == 1) {
	            $update_array = array(
	                'is_pro' => 1,
	                'pro_time' => time(),
	                'pro_' => 1,
	                'pro_type' => $pro_type
	            );
	            if (in_array($pro_type, array_keys($wo['pro_packages_types'])) && $wo['pro_packages'][$wo['pro_packages_types'][$pro_type]]['verified_badge'] == 1) {
	                $update_array['verified'] = 1;
	            }
	            $mysqli       = Wo_UpdateUserData($wo['user']['user_id'], $update_array);
	            global $sqlConnect;
	            $amount1 = 0;
	            if ($pro_type == 1) {
	                $img     = $wo['lang']['star'];
	                $amount1 = $wo['pro_packages']['star']['price'];
	            } else if ($pro_type == 2) {
	                $img     = $wo['lang']['hot'];
	                $amount1 = $wo['pro_packages']['hot']['price'];
	            } else if ($pro_type == 3) {
	                $img     = $wo['lang']['ultima'];
	                $amount1 = $wo['pro_packages']['ultima']['price'];
	            } else if ($pro_type == 4) {
	                $img     = $wo['lang']['vip'];
	                $amount1 = $wo['pro_packages']['vip']['price'];
	            }
	            $notes              = $wo['lang']['upgrade_to_pro'] . " " . $img . " : PayPal";
	            $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'PRO', {$amount1}, '{$notes}')");
	            $create_payment     = Wo_CreatePayment($pro_type);
	            if ($mysqli) {
	                //record affiliate with fixed price
	                if ((!empty($_SESSION['ref']) || !empty($wo['user']['ref_user_id'])) && $wo['config']['affiliate_type'] == 0 && $wo['user']['referrer'] == 0) {
	                    if (!empty($_SESSION['ref'])) {
	                        $ref_user_id = Wo_UserIdFromUsername($_SESSION['ref']);
	                    }
	                    elseif (!empty($wo['user']['ref_user_id'])) {
	                        $ref_user_id = Wo_UserIdFromUsername($wo['user']['ref_user_id']);
	                    }
	                    
	                    if (!empty($ref_user_id) && is_numeric($ref_user_id)) {
	                        $update_user    = Wo_UpdateUserData($wo['user']['user_id'], array(
	                            'referrer' => $ref_user_id,
	                            'src' => 'Referrer'
	                        ));
	                        $update_balance = Wo_UpdateBalance($ref_user_id, $wo['config']['amount_ref']);
	                        unset($_SESSION['ref']);
	                    }
	                }
	                //record affiliate with percentage
	                if ((!empty($_SESSION['ref']) || !empty($wo['user']['ref_user_id'])) && $wo['config']['affiliate_type'] == 1 && $wo['user']['referrer'] == 0) {
	                    if ($wo['config']['amount_percent_ref'] > 0) {
	                        if (!empty($_SESSION['ref'])) {
	                            $ref_user_id = Wo_UserIdFromUsername($_SESSION['ref']);
	                        }
	                        elseif (!empty($wo['user']['ref_user_id'])) {
	                            $ref_user_id = Wo_UserIdFromUsername($wo['user']['ref_user_id']);
	                        }
	                        if (!empty($ref_user_id) && is_numeric($ref_user_id)) {
	                            $update_user    = Wo_UpdateUserData($wo['user']['user_id'], array(
	                                'referrer' => $ref_user_id,
	                                'src' => 'Referrer'
	                            ));
	                            $ref_amount     = ($wo['config']['amount_percent_ref'] * $amount1) / 100;
	                            $update_balance = Wo_UpdateBalance($ref_user_id, $ref_amount);
	                            unset($_SESSION['ref']);
	                        }
	                    } else if ($wo['config']['amount_ref'] > 0) {
	                        if (!empty($_SESSION['ref'])) {
	                            $ref_user_id = Wo_UserIdFromUsername($_SESSION['ref']);
	                        }
	                        elseif (!empty($wo['user']['ref_user_id'])) {
	                            $ref_user_id = Wo_UserIdFromUsername($wo['user']['ref_user_id']);
	                        }
	                        if (!empty($ref_user_id) && is_numeric($ref_user_id)) {
	                            $update_user    = Wo_UpdateUserData($wo['user']['user_id'], array(
	                                'referrer' => $ref_user_id,
	                                'src' => 'Referrer'
	                            ));
	                            $update_balance = Wo_UpdateBalance($ref_user_id, $wo['config']['amount_ref']);
	                            unset($_SESSION['ref']);
	                        }
	                    }
	                }
	                $response_data = array(
			                                'api_status' => 200,
			                                'message' => 'upgraded'
			                            );
	            }
	        } else {
	            $error_code    = 9;
			    $error_message = 'something went wrong';
	        }
	    } else {
	    	$error_code    = 8;
		    $error_message = 'you are pro';
	    }
    }

    if ($_POST['request'] == 'wallet') {
    	$payment  = Wo_CheckPaystackPayment($_POST['reference']);
    	if ($payment) {
            if (Wo_ReplenishingUserBalance($_POST['amount'])) {
                $_POST['amount'] = Wo_Secure($_POST['amount']);
                $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $wo['user']['id'] . "', 'WALLET', '" . $_POST['amount'] . "', 'Paystack')");
                $_SESSION['replenished_amount'] = $_POST['amount'];
                $response_data = array(
	                                'api_status' => 200,
	                                'message' => 'payment successfully'
	                            );
            } else {
                $error_code    = 9;
			    $error_message = 'something went wrong or amount empty';
            }
        } else {
            $error_code    = 8;
		    $error_message = 'something went wrong or reference empty';
        }
    }

    if ($_POST['request'] == 'fund') {
    	$payment  = Wo_CheckPaystackPayment($_POST['reference']);
    	if ($payment) {
    		$fund_id = Wo_Secure($_POST['fund_id']);
	    	$amount = Wo_Secure($_POST['amount']);
	    	$fund = $db->where('id',$fund_id)->getOne(T_FUNDING);

	    	if (!empty($fund) && !empty($fund_id) && !empty($amount)) {

	    		$notes = "Doanted to ".mb_substr($fund->title, 0, 100, "UTF-8");

		        $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'DONATE', {$amount}, '{$notes}')");

		        $admin_com = 0;
	            if (!empty($wo['config']['donate_percentage']) && is_numeric($wo['config']['donate_percentage']) && $wo['config']['donate_percentage'] > 0) {
	                $admin_com = ($wo['config']['donate_percentage'] * $amount) / 100;
	                $amount = $amount - $admin_com;
	            }
		        $user_data = Wo_UserData($fund->user_id);
	            $db->where('user_id',$fund->user_id)->update(T_USERS,array('balance' => $user_data['balance'] + $amount));
	            $fund_raise_id = $db->insert(T_FUNDING_RAISE,array('user_id' => $wo['user']['user_id'],
	                                              'funding_id' => $fund_id,
	                                              'amount' => $amount,
	                                              'time' => time()));
	            $post_data = array(
	                'user_id' => Wo_Secure($wo['user']['user_id']),
	                'fund_raise_id' => $fund_raise_id,
	                'time' => time(),
	                'multi_image_post' => 0
	            );

	            $id = Wo_RegisterPost($post_data);

	            $notification_data_array = array(
                    'recipient_id' => $fund->user_id,
                    'type' => 'fund_donate',
                    'url' => 'index.php?link1=show_fund&id=' . $fund->hashed_id
                );
                Wo_RegisterNotification($notification_data_array);

                $response_data = array(
	                                'api_status' => 200,
	                                'message' => 'payment successfully'
	                            );
	    	}
	    	else{
	    		$error_code    = 9;
			    $error_message = 'amount fund_id empty';
	    	}
        } else {
        	$error_code    = 8;
		    $error_message = 'something went wrong or reference empty';
        }
    }




}