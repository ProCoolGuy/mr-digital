<?php 
if ($f == 'upgrade') {
    if (!isset($_GET['success'], $_GET['paymentId'], $_GET['PayerID'])) {
        header("Location: " . Wo_SeoLink('index.php?link1=oops'));
        exit();
    }
    $is_pro = 0;
    $stop   = 0;
    $user   = Wo_UserData($wo['user']['user_id']);
    if ($user['is_pro'] == 0) {
        $stop = 1;
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
        $payment  = Wo_CheckPayment($_GET['paymentId'], $_GET['PayerID']);
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
            $update_array   = array(
                'pro_time' => time(),
                'pro_type' => $pro_type
            );
            if (in_array($pro_type, array_keys($wo['pro_packages_types'])) && $wo['pro_packages'][$wo['pro_packages_types'][$pro_type]]['verified_badge'] == 1) {
                $update_array['verified'] = 1;
                $update_array['pro_'] = 1;
            }
            $mysqli         = Wo_UpdateUserData($wo['user']['user_id'], $update_array);
            $create_payment = Wo_CreatePayment($pro_type);
            if ($mysqli) {
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
