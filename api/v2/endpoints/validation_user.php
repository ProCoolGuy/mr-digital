<?php
if (!empty($_POST['code']) && !empty($_POST['email'])) {
	$code   = Wo_Secure($_POST['code']);
	$email   = Wo_Secure($_POST['email']);
	if (Wo_EmailExists($email) === false) {
        $response_data       = array(
	        'api_status'     => '400',
	        'errors'         => array(
	            'error_id'   => '5',
	            'error_text' => 'wrong email'
	        )
	    );
	    echo json_encode($response_data, JSON_PRETTY_PRINT);
	    exit();
    } else if (Wo_ActivateUser($email, $code) === false) {   
        $response_data       = array(
	        'api_status'     => '400',
	        'errors'         => array(
	            'error_id'   => '6',
	            'error_text' => 'wrong data'
	        )
	    );
	    echo json_encode($response_data, JSON_PRETTY_PRINT);
	    exit();
    } else {
        $session = Wo_CreateLoginSession(Wo_UserIdFromEmail($email));
        $access_token = $session;
        if (!empty($wo['config']['auto_friend_users'])) {
            $autoFollow = Wo_AutoFollow(Wo_UserIdFromEmail($email));
        }
        if (!empty($wo['config']['auto_page_like'])) {
            Wo_AutoPageLike(Wo_UserIdFromEmail($email));
        }
        if (!empty($wo['config']['auto_group_join'])) {
            Wo_AutoGroupJoin(Wo_UserIdFromEmail($email));
        }
        $user_id = Wo_UserIdFromEmail($email);
        $time           = time();
        $cookie         = '';
        $access_token   = sha1(rand(111111111, 999999999)) . md5(microtime()) . rand(11111111, 99999999) . md5(rand(5555, 9999));
        $timezone       = 'UTC';
        $create_session = mysqli_query($sqlConnect, "INSERT INTO " . T_APP_SESSIONS . " (`user_id`, `session_id`, `platform`, `time`) VALUES ('{$user_id}', '{$access_token}', 'phone', '{$time}')");
        if (!empty($_POST['timezone'])) {
            $timezone = Wo_Secure($_POST['timezone']);
        }
        $add_timezone = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `timezone` = '{$timezone}' WHERE `user_id` = {$user_id}");
        // if (!empty($_POST['device_id'])) {
        //     $device_id = Wo_Secure($_POST['device_id']);
        //     $update    = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `device_id` = '{$device_id}' WHERE `user_id` = '{$user_id}'");
        // }
        if (!empty($_POST['android_m_device_id'])) {
            $device_id  = Wo_Secure($_POST['android_m_device_id']);
            $update  = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `android_m_device_id` = '{$device_id}' WHERE `user_id` = '{$user_id}'");
        }
        if (!empty($_POST['ios_m_device_id'])) {
            $device_id  = Wo_Secure($_POST['ios_m_device_id']);
            $update  = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `ios_m_device_id` = '{$device_id}' WHERE `user_id` = '{$user_id}'");
        }
        if (!empty($_POST['android_n_device_id'])) {
            $device_id  = Wo_Secure($_POST['android_n_device_id']);
            $update  = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `android_n_device_id` = '{$device_id}' WHERE `user_id` = '{$user_id}'");
        }
        if (!empty($_POST['ios_n_device_id'])) {
            $device_id  = Wo_Secure($_POST['ios_n_device_id']);
            $update  = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `ios_n_device_id` = '{$device_id}' WHERE `user_id` = '{$user_id}'");
        }
        if ($create_session) {
            $response_data = array(
                'api_status' => 200,
                'timezone' => $timezone,
                'access_token' => $access_token,
                'user_id' => $user_id,
            );
        }
    }

}
else{
	$error_code    = 4;
    $error_message = 'email , code can not be empty';
}