<?php 
if ($f == 'payment') {
    if (!isset($_GET['success'], $_GET['paymentId'], $_GET['PayerID']) && !isset($_GET['token'])) {
        header("Location: " . Wo_SeoLink('index.php?link1=oops'));
        exit();
    }
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
        if (!isset($_GET['pro_type']) || !in_array($_GET['pro_type'], $pro_types_array)) {
            header("Location: " . Wo_SeoLink('index.php?link1=oops'));
            exit();
        }
        $pro_type = $_GET['pro_type'];
        $time_type = '';
        if ($pro_type == 1) {
            $time_type = $wo['pro_packages']['star']['time'];
        }
        elseif ($pro_type == 2) {
            $time_type = $wo['pro_packages']['ultima']['time'];
        }
        elseif ($pro_type == 3) {
            $time_type = $wo['pro_packages']['hot']['time'];
        }
        elseif ($pro_type == 4) {
            $time_type = $wo['pro_packages']['vip']['time'];
        }
        if ($wo['config']['recurring_payment'] == 0 || $time_type == 'unlimited') {
            $payment  = Wo_CheckPayment($_GET['paymentId'], $_GET['PayerID']);
        }
        else{
            $payment  = Wo_CheckPayment(0, 0, $_GET['token']);
        }
        if (is_array($payment)) {
            if (isset($payment['name'])) {
                if ($payment['name'] == 'PAYMENT_ALREADY_DONE' || $payment['name'] == 'MAX_NUMBER_OF_PAYMENT_ATTEMPTS_EXCEEDED') {
                    $is_pro = 1;
                }
            }
        } else if ($payment === true) {
            $is_pro = 1;
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
