<?php
$types = array('pro','wallet','fund');
if (!empty($_POST['type']) && in_array($_POST['type'], $types)) {
	if (empty($_POST['card_number']) || empty($_POST['card_cvc']) || empty($_POST['card_month']) || empty($_POST['card_year']) || empty($_POST['token']) || empty($_POST['card_name']) || empty($_POST['card_address']) || empty($_POST['card_city']) || empty($_POST['card_state']) || empty($_POST['card_zip']) || empty($_POST['card_country']) || empty($_POST['card_email']) || empty($_POST['card_phone'])) {
		$error_code    = 4;
	    $error_message = 'card_number,card_cvc,card_month,card_year,token,card_name,card_address,card_city,card_state,card_zip,card_country,card_email,card_phone can not be empty';
	}
	else{
		require_once 'assets/libraries/2checkout/Twocheckout.php';
        Twocheckout::privateKey($wo['config']['checkout_private_key']);
        Twocheckout::sellerId($wo['config']['checkout_seller_id']);
        if ($wo['config']['checkout_mode'] == 'sandbox') {
            Twocheckout::sandbox(true);
        } else {
            Twocheckout::sandbox(false);
        }
		$amount1  = 0;
		if ($_POST['type'] == 'pro') {
			if (!empty($_POST['pro_type']) && in_array($_POST['pro_type'], array(1,2,3,4))) {
				$pro_type = $_POST['pro_type'];
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
			}
			else{
				$error_code    = 5;
			    $error_message = 'pro_type can not be empty';
			    $response_data       = array(
			        'api_status'     => '404',
			        'errors'         => array(
			            'error_id'   => $error_code,
			            'error_text' => $error_message
			        )
			    );
			    echo json_encode($response_data, JSON_PRETTY_PRINT);
			    exit();
			}
		}
		elseif ($_POST['type'] == 'fund') {
			if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0 && !empty($_POST['fund_id']) && is_numeric($_POST['fund_id']) && $_POST['fund_id'] > 0) {
				$fund_id = Wo_Secure($_POST['fund_id']);
		    	$fund = $db->where('id',$fund_id)->getOne(T_FUNDING);

		        if (!empty($fund)) {
		        	$amount1 = Wo_Secure($_POST['amount']);
		        }
		        else{
		        	$error_code    = 10;
				    $error_message = 'fund not found';
				    $response_data       = array(
				        'api_status'     => '404',
				        'errors'         => array(
				            'error_id'   => $error_code,
				            'error_text' => $error_message
				        )
				    );
				    echo json_encode($response_data, JSON_PRETTY_PRINT);
				    exit();
		        }
			}
			else{
				$error_code    = 9;
			    $error_message = 'amount , fund_id can not be empty';
			    $response_data       = array(
			        'api_status'     => '404',
			        'errors'         => array(
			            'error_id'   => $error_code,
			            'error_text' => $error_message
			        )
			    );
			    echo json_encode($response_data, JSON_PRETTY_PRINT);
			    exit();
			}
		}
		elseif ($_POST['type'] == 'wallet') {
			if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0) {
				$amount1 = Wo_Secure($_POST['amount']);
			}
			else{
				$error_code    = 9;
			    $error_message = 'amount can not be empty';
			    $response_data       = array(
			        'api_status'     => '404',
			        'errors'         => array(
			            'error_id'   => $error_code,
			            'error_text' => $error_message
			        )
			    );
			    echo json_encode($response_data, JSON_PRETTY_PRINT);
			    exit();
			}
		}

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
        	if ($_POST['type'] == 'pro') {
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
                    $is_pro = 1;
                }
                if ($stop == 0) {
                    $time = time();
                    if ($is_pro == 1) {
                        $update_array = array(
                            'is_pro' => 1,
                            'pro_time' => time(),
                            'pro_' => 1,
                            'pro_type' => $pro_type,
                            'address' => Wo_Secure($_POST['card_address']),
                            'city' => Wo_Secure($_POST['card_city']),
                            'state' => Wo_Secure($_POST['card_state']),
                            'zip' => Wo_Secure($_POST['card_zip']),
                            'country_id' => Wo_Secure($_POST['card_country'])
                        );
                        if (in_array($pro_type, array_keys($wo['pro_packages_types'])) && $wo['pro_packages'][$wo['pro_packages_types'][$pro_type]]['verified_badge'] == 1) {
                            $update_array['verified'] = 1;
                        }
                        $mysqli         = Wo_UpdateUserData($wo['user']['user_id'], $update_array);
                        $create_payment = Wo_CreatePayment($pro_type);
                        if ($mysqli) {
                            if ((!empty($_SESSION['ref']) || !empty($wo['user']['ref_user_id'])) && $wo['config']['affiliate_type'] == 1 && $wo['user']['referrer'] == 0) {
                                if (!empty($_SESSION['ref'])) {
                                    $ref_user_id = Wo_UserIdFromUsername($_SESSION['ref']);
                                }
                                elseif (!empty($wo['user']['ref_user_id'])) {
                                    $ref_user_id = Wo_UserIdFromUsername($wo['user']['ref_user_id']);
                                }


                                if ($wo['config']['amount_percent_ref'] > 0) {
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
                            $notes              = $wo['lang']['upgrade_to_pro'] . " " . $img . " : Credit Card";
                            $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'PRO', {$amount1}, '{$notes}')");
                            $response_data = array(
	                            'api_status' => 200,
	                            'message' => 'upgraded'
	                        );
                        }
                    } else {
                        $error_code    = 8;
					    $error_message = 'Pro type is not set2';
                    }
                } else {
                	$error_code    = 7;
				    $error_message = 'Pro type is not set3';
                }
        	}
        	elseif ($_POST['type'] == 'fund') {
        		$amount = $amount1;
        		Wo_UpdateUserData($wo['user']['id'], array(
                    'address' => Wo_Secure($_POST['card_address']),
                    'city' => Wo_Secure($_POST['card_city']),
                    'state' => Wo_Secure($_POST['card_state']),
                    'zip' => Wo_Secure($_POST['card_zip'])
                ));



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
	                            'message' => 'donated'
	                        );
        	}
        	elseif ($_POST['type'] == 'wallet') {
        		$amount = $amount1;
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
                $response_data = array(
	                            'api_status' => 200,
	                            'message' => 'paid'
	                        );
        	}
        }
        else{
        	$error_code    = 6;
			$error_message = 'Your payment was declined, please contact your bank or card issuer and make sure you have the require';
        }
	}
}
else{
	$error_code    = 4;
    $error_message = 'type can not be empty';
}