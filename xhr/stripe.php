<?php
include_once('assets/includes/stripe_config.php');
$pro_types_array = array(
                    1,
                    2,
                    3,
                    4
                );
if ($f == 'stripe') {
	if ($s == 'session') {
		$link = '';
		if (!empty($_POST['type']) && in_array($_POST['type'], array('wallet','fund','pro')) && !empty($_POST['payment_type']) && in_array($_POST['payment_type'], array('alipay','credit_card'))) {
			
			$amount = 0;
			if ($_POST['type'] == 'wallet' && !empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0) {
				$amount = $_POST['amount'] * 100;
			}
			elseif ($_POST['type'] == 'fund' && !empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0 && !empty($_POST['fund_id']) && is_numeric($_POST['fund_id']) && $_POST['fund_id'] > 0) {
				$fund_id = Wo_Secure($_POST['fund_id']);
		    	$amount = $_POST['amount'] * 100;
		    	$fund = $db->where('id',$fund_id)->getOne(T_FUNDING);

			    if (empty($fund)) {
			        $data = array(
		                'status' => 400,
		                'message' => $error_icon . $wo['lang']['something_wrong']
		            );
		            header("Content-type: application/json");
		            echo json_encode($data);
		            exit();
			    }
			    $link .= '&fund_id='.$fund_id;
			}
			elseif ($_POST['type'] == 'pro' && !empty($_POST['pro_type']) && in_array($_POST['pro_type'], $pro_types_array)) {
				$pro_type = $_POST['pro_type'];
		        if ($pro_type == 1) {
		            $amount = $wo['pro_packages']['star']['price'];
		        } else if ($pro_type == 2) {
		            $amount = $wo['pro_packages']['hot']['price'];
		        } else if ($pro_type == 3) {
		            $amount = $wo['pro_packages']['ultima']['price'];
		        } else if ($pro_type == 4) {
		            $amount = $wo['pro_packages']['vip']['price'];
		        }
		        $amount = $amount * 100;
		        $link .= '&pro_type='.$pro_type;
			}
			else{
				$data = array(
	                'status' => 400,
	                'message' => $error_icon . $wo['lang']['something_wrong']
	            );
			}
			$payment_method_types = array('card');
			if ($wo['config']['alipay'] == 'yes' && $_POST['payment_type'] == 'alipay') {
				$payment_method_types = array('alipay');
			}
			$domain_url = $wo['config']['site_url'].'/requests.php';
			try {
				$checkout_session = \Stripe\Checkout\Session::create([
				    'payment_method_types' => [implode(',', $payment_method_types)],
				    'line_items' => [[
				      'price_data' => [
				        'currency' => $wo['config']['stripe_currency'],
				        'product_data' => [
				          'name' => $_POST['type'],
				        ],
				        'unit_amount' => $amount,
				      ],
				      'quantity' => 1,
				    ]],
				    'mode' => 'payment',
				    'success_url' => $domain_url . '?f=stripe&s=success&type='.$_POST['type'].$link,
				    'cancel_url' => $domain_url . '?f=stripe&s=cancel&type='.$_POST['type'],
			    ]);
			    if (!empty($checkout_session) && !empty($checkout_session['id'])) {
			    	$db->where('user_id',$wo['user']['id'])->update(T_USERS,array('StripeSessionId' => $checkout_session['id']));
			    	$data = array(
		                'status' => 200,
		                'sessionId' => $checkout_session['id']
		            );
			    }
			    else{
			    	$data = array(
		                'status' => 400,
		                'message' => $error_icon . $wo['lang']['something_wrong']
		            );
			    }
			}
			catch (Exception $e) {
				$data = array(
	                'status' => 400,
	                'message' => $e->getMessage()
	            );
			}
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
		}
	}
	if ($s == 'success') {
		if (!$wo['loggedin']) {
			header("Location: " . Wo_SeoLink('index.php?link1=oops'));
	        exit();
		}
		if (!empty($wo['user']['StripeSessionId']) && !empty($_GET['type']) && in_array($_GET['type'], array('wallet','fund','pro'))) {
			try {
				$db->where('user_id',$wo['user']['id'])->update(T_USERS,array('StripeSessionId' => ''));
				$checkout_session = \Stripe\Checkout\Session::retrieve($wo['user']['StripeSessionId']);
				if ($checkout_session->payment_status == 'paid') {
					$amount = ($checkout_session->amount_total / 100);
					if ($_GET['type'] == 'wallet') {
						$result = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `wallet` = `wallet` + " . $amount . " WHERE `user_id` = '" . $wo['user']['id'] . "'");
			            if ($result) {
			                $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ('" . $wo['user']['id'] . "', 'WALLET', '" . $amount . "', 'stripe')");
			            }
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
					if ($_GET['type'] == 'fund' && !empty($_GET['fund_id']) && is_numeric($_GET['fund_id']) && $_GET['fund_id'] > 0) {
						$fund_id = Wo_Secure($_GET['fund_id']);
						$fund = $db->where('id',$fund_id)->getOne(T_FUNDING);

					    if (!empty($fund)) {
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
				            header("Location: " . $config['site_url'] . "/show_fund/".$fund->hashed_id);
					        exit();

					    }
					}
					elseif ($_GET['type'] == 'pro' && !empty($_GET['pro_type']) && in_array($_GET['pro_type'], $pro_types_array)) {
						
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
			                $pro_type = $_GET['pro_type'];
			                $is_pro   = 1;
			            }
			            if ($stop == 0) {
			                $time = time();
			                if ($is_pro == 1) {
			                    $update_array   = array(
			                        'is_pro' => 1,
			                        'pro_time' => time(),
			                        'pro_' => 1,
			                        'pro_type' => $pro_type
			                    );
			                    if (in_array($pro_type, array_keys($wo['pro_packages_types'])) && $wo['pro_packages'][$wo['pro_packages_types'][$pro_type]]['verified_badge'] == 1) {
			                        $update_array['verified'] = 1;
			                    }
			                    $mysqli         = Wo_UpdateUserData($wo['user']['user_id'], $update_array);
			                    $notes              = $wo['lang']['upgrade_to_pro'] . " " . $img . " : Stripe";
			                    $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'PRO', {$amount2}, '{$notes}')");
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
			                        header("Location: " . Wo_SeoLink('index.php?link1=upgraded'));
							        exit();
			                    }
			                } else {
			                    header("Location: " . Wo_SeoLink('index.php?link1=oops'));
						        exit();
			                }
			            } else {
			                header("Location: " . Wo_SeoLink('index.php?link1=oops'));
					        exit();
			            }
					}
				}
				else{
					header("Location: " . Wo_SeoLink('index.php?link1=oops'));
			        exit();
				}
				
			} catch (Exception $e) {
				header("Location: " . Wo_SeoLink('index.php?link1=oops'));
		        exit();
			}
		}
		header("Location: " . Wo_SeoLink('index.php?link1=oops'));
		exit();
	}
	if ($s == 'cancel') {
		$db->where('user_id',$wo['user']['id'])->update(T_USERS,array('StripeSessionId' => ''));
		header("Location: " . Wo_SeoLink('index.php?link1=oops'));
	    exit();
	}
}