<?php
if ($f == "2checkout_pro") {
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
            $pro_types_array = array(
                1,
                2,
                3,
                4
            );
            $pro_type        = 0;
            if (!isset($_POST['type']) || !in_array($_POST['type'], $pro_types_array)) {
                $data = array(
                    'status' => 400,
                    'error' => 'Pro type is not set'
                );
                header("Content-type: application/json");
                echo json_encode($data);
                exit();
            }
            $pro_type = $_POST['type'];
            $amount1  = 0;
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
            $amount1 = $amount1;
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
                                } elseif (!empty($wo['user']['ref_user_id'])) {
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
                            $data               = array(
                                'status' => 200,
                                'location' => Wo_SeoLink('index.php?link1=upgraded')
                            );
                            header("Content-type: application/json");
                            echo json_encode($data);
                            exit();
                        }
                    } else {
                        $data = array(
                            'status' => 400,
                            'error' => 'Pro type is not set2'
                        );
                        header("Content-type: application/json");
                        echo json_encode($data);
                        exit();
                    }
                } else {
                    $data = array(
                        'status' => 400,
                        'error' => 'Pro type is not set3'
                    );
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
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
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
