<?php 
require_once('assets/init.php');
if (!empty($_GET['first']) && !empty($_GET['action']) && $_GET['first'] == 'notify' && $_GET['action'] == 'notify') {

	if (($_POST['payment_status'] == 'Completed' || $_POST['payment_status'] == 'Processed' || $_POST['payment_status'] == 'In-Progress' || $_POST['payment_status'] == 'Pending') &&  strpos($_POST['item_name'] , 'user')) {
		
		$user_id = substr($_POST['item_name'], strpos($_POST['item_name'], 'user')+4);
		$user = Wo_UserData($user_id);
		if (!empty($user)) {
			$amount1  = Wo_Secure($_POST['mc_gross']);
			$pro_type = $user['pro_type'];

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
            if ($pro_type == 1) {
                $img     = $wo['lang']['star'];
            } else if ($pro_type == 2) {
                $img     = $wo['lang']['hot'];
            } else if ($pro_type == 3) {
                $img     = $wo['lang']['ultima'];
            } else if ($pro_type == 4) {
                $img     = $wo['lang']['vip'];
            }
            $notes              = $wo['lang']['upgrade_to_pro'] . " " . $img . " : PayPal";
            $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'PRO', {$amount1}, '{$notes}')");
            $create_payment     = Wo_CreatePayment($pro_type);
		}
	}
	elseif(($_POST['payment_status'] == 'Declined' || $_POST['payment_status'] == 'Expired' || $_POST['payment_status'] == 'Failed' || $_POST['payment_status'] == 'Refunded' || $_POST['payment_status'] == 'Reversed') &&  strpos($_POST['item_name'] , 'user')){
		$user_id = substr($_POST['item_name'], strpos($_POST['item_name'], 'user')+4);
		$user = Wo_UserData($user_id);
		if (!empty($user)) {

			$update      = Wo_UpdateUserData($user_id, array(
	            'is_pro' => 0
	        ));
	        $mysql_query = mysqli_query($sqlConnect, "UPDATE " . T_PAGES . " SET `boosted` = '0' WHERE `user_id` = {$user_id}");
	        $mysql_query = mysqli_query($sqlConnect, "UPDATE " . T_POSTS . " SET `boosted` = '0' WHERE `user_id` = {$user_id}");
	        $mysql_query = mysqli_query($sqlConnect, "UPDATE " . T_POSTS . " SET `boosted` = '0' WHERE `page_id` IN (SELECT `page_id` FROM " . T_PAGES . " WHERE `user_id` = {$user_id})");
		}
	}
}


?>

