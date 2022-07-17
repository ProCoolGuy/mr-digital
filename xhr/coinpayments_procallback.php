<?php 
if ($f == 'coinpayments_procallback') {
    global $sqlConnect, $wo;
    $data  = array();
    $error = "";
    if (!isset($_POST['user_id']) || empty($_POST['user_id']) || !is_numeric($_POST['user_id']) || !isset($_POST['user_type']) || empty($_POST['user_type']) || !isset($_POST['amount1']) || !is_numeric($_POST['amount1']) || $_POST['amount1'] < 1) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    }
    if (empty($error)) {
        if ($wo['config']['coinpayments_secret'] !== "" && $wo['config']['coinpayments_id'] !== "") {
            try {
                include_once('assets/libraries/coinpayments.php');
                $CP = new \MineSQL\CoinPayments();
                $CP->setMerchantId($wo['config']['coinpayments_id']);
                $CP->setSecretKey($wo['config']['coinpayments_secret']);
                if ($CP->listen($_POST, $_SERVER)) {
                    // The payment is successful and passed all security measures
                    $user_id        = $_POST['user_id'];
                    $user_type      = $_POST['user_type'];
                    $txn_id         = $_POST['txn_id'];
                    $item_name      = $_POST['item_name'];
                    $amount1        = floatval($_POST['amount1']); //   The total amount of the payment in your original currency/coin.
                    $amount2        = floatval($_POST['amount2']); //  The total amount of the payment in the buyer's selected coin.
                    $status         = intval($_POST['status']);
                    // $impload        = "`is_pro` = '1', `pro_time` = '" . time() . "', `verified` = '1', `pro_type` = '" . $user_type . "'";
                    // $query_one      = " UPDATE " . T_USERS . " SET {$impload} WHERE `user_id` = {$user_id} ";
                    // $mysqli         = mysqli_query($sqlConnect, $query_one);
                    $update_array = array(
                        'is_pro' => 1,
                        'pro_time' => time(),
                        'pro_' => 1,
                        'pro_type' => $user_type
                    );
                    if (in_array($user_type, array_keys($wo['pro_packages_types'])) && $wo['pro_packages'][$wo['pro_packages_types'][$user_type]]['verified_badge'] == 1) {
                        $update_array['verified'] = 1;
                    }
                    $mysqli       = Wo_UpdateUserData($wo['user']['user_id'], $update_array);
                    
                    $date           = date('n') . '/' . date("Y");
                    $time = time();
                    $create_payment = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENTS . " (`user_id`, `amount`, `date`, `type`,`time`) VALUES ({$user_id}, {$amount1}, '{$date}', '{$user_type}', '{$time}')");
                    if ($user_type == 1) {
                        $img = $wo['lang']['star'];
                    } else if ($user_type == 2) {
                        $img = $wo['lang']['hot'];
                    } else if ($user_type == 3) {
                        $img = $wo['lang']['ultima'];
                    } else if ($user_type == 4) {
                        $img = $wo['lang']['vip'];
                    }
                    $notes              = $wo['lang']['upgrade_to_pro'] . " " . $img;
                    $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$user_id}, 'PRO', {$amount1}, '{$notes}')");
                    if ($mysqli) {
                        header("Location: " . Wo_SeoLink('index.php?link1=upgraded'));
                        exit();
                    }
                    $data = array(
                        'status' => 200,
                        'message' => $mysqli
                    );
                } else {
                    // the payment is pending. an exception is thrown for all other payment errors.
                    $data = array(
                        'status' => 400,
                        'error' => 'the payment is pending.'
                    );
                }
            }
            catch (Exception $e) {
                $data = array(
                    'status' => 400,
                    'error' => $e->getMessage()
                );
            }
        } else {
            $data = array(
                'status' => 400,
                'error' => 'bitcoin not set'
            );
        }
    } else {
        $data = array(
            'status' => 500,
            'error' => $error
        );
    }
    if ($data['status'] !== 200) {
        header("Location: " . Wo_SeoLink('index.php?link1=oops'));
        exit();
    } else {
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
