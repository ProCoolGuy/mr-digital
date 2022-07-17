<?php 
if ($f == 'pay_using_wallet') {
    $type = (isset($_POST['type']) && is_numeric($_POST['type'])) ? $_POST['type'] : false;
    $html = "";
    $data = array(
        "status" => 404,
        "html" => $html
    );
    if ($type) {
        $can_buy              = false;
        $dollar_to_point_cost = $wo['config']['dollar_to_point_cost'];
        $price                = 0;
        $points               = 0;
        $img                  = "";
        if ($wo['config']['point_level_system'] == 1) {
            switch ($type) {
                case 1:
                    $img   = $wo['lang']['star'];
                    $price = $wo['pro_packages']['star']['price'];
                    break;
                case 2:
                    $img   = $wo['lang']['hot'];
                    $price = $wo['pro_packages']['hot']['price'];
                    break;
                case 3:
                    $img   = $wo['lang']['ultima'];
                    $price = $wo['pro_packages']['ultima']['price'];
                    break;
                case 4:
                    $img   = $wo['lang']['vip'];
                    $price = $wo['pro_packages']['vip']['price'];
                    break;
            }
            if ($wo["user"]["wallet"] >= $price) {
                $can_buy = true;
            }
            $points = $price * $dollar_to_point_cost;
            //if( $wo["user"]["balance"] >= $price ){ $can_buy = true; }
            //$balance = $wo["user"]["balance"];
        }
        if ($can_buy == true) {
            $wallet_amount      = ($wo["user"]['wallet'] - $price);
            $points_amount      = ($wo['config']['point_allow_withdrawal'] == 0) ? ($wo["user"]['points'] - $points) : $wo["user"]['points'];
            $update_array       = array(
                'is_pro' => 1,
                'pro_time' => time(),
                'pro_' => 1,
                'pro_type' => $type
            );
            if (in_array($type, array_keys($wo['pro_packages_types'])) && $wo['pro_packages'][$wo['pro_packages_types'][$type]]['verified_badge'] == 1) {
                $update_array['verified'] = 1;
            }
            $mysqli             = Wo_UpdateUserData($wo['user']['user_id'], $update_array);
            $notes              = $wo['lang']['upgrade_to_pro'] . " " . $img . " : Wallet";
            $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'PRO', {$price}, '{$notes}')");
            $query_one          = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `points` = '{$points_amount}', `wallet` = '{$wallet_amount}' WHERE `user_id` = {$wo['user']['user_id']} ");
            $data['status']     = 200;
            $data['url']        = Wo_SeoLink('index.php?link1=upgraded');
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
