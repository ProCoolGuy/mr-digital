<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data   = array(
    'api_status' => 400
);

$required_fields = array(
    'user_id',
    'code'
);
foreach ($required_fields as $key => $value) {
    if (empty($_POST[$value]) && empty($error_code)) {
        $error_message = $value . ' (POST) is missing';
        $json_error_data = array(
            'api_status' => '400',
            'api_text' => 'failed',
            'api_version' => $api_version,
            'errors' => array(
                'error_id' => '3',
                'error_text' => $error_message
            )
        );
        header("Content-type: application/json");
        echo json_encode($json_error_data, JSON_PRETTY_PRINT);
        exit();
    }
}
if (empty($error_code)) {
    $confirm_code = $_POST['code'];
    $user_id      = $_POST['user_id'];
    $confirm_code = $db->where('user_id', $user_id)->where('email_code', md5($confirm_code))->getValue(T_USERS, 'count(*)');
    if (empty($confirm_code)) {
        $json_error_data = array(
            'api_status' => '400',
            'api_text' => 'failed',
            'api_version' => $api_version,
            'errors' => array(
                'error_id' => '4',
                'error_text' => 'Wrong confirmation code.'
            )
        );
        header("Content-type: application/json");
        echo json_encode($json_error_data, JSON_PRETTY_PRINT);
        exit();
    }
    else{
        $time           = time();
        $cookie         = '';
        $access_token   = sha1(rand(111111111, 999999999)) . md5(microtime()) . rand(11111111, 99999999) . md5(rand(5555, 9999));
        $add_session = mysqli_query($sqlConnect, "INSERT INTO " . T_APP_SESSIONS . " (`user_id`, `session_id`, `platform`, `time`) VALUES ('{$user_id}', '{$access_token}', 'windows', '{$time}')");
        if ($add_session) {
            if (!empty($_POST['timezone'])) {
                $timezone = Wo_Secure($_POST['timezone']);
            } else {
                $timezone = 'UTC';
            }
            $add_timezone = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `timezone` = '{$timezone}',`active` = '1' WHERE `user_id` = {$user_id}");
            $json_success_data = array(
                'api_status' => '200',
                'api_text' => 'success',
                'api_version' => $api_version,
                'user_id' => Wo_UserIdFromUsername($username),
                'messages' => 'Successfully logged in, Please wait..',
                'access_token' => $access_token,
                'user_id' => $user_id,
                'timezone' => $timezone
            );
            header("Content-type: application/json");
            echo json_encode($json_success_data, JSON_PRETTY_PRINT);
            exit();
        } else {
            $json_error_data = array(
                'api_status' => '400',
                'api_text' => 'failed',
                'api_version' => $api_version,
                'errors' => array(
                    'error_id' => '8',
                    'error_text' => 'Error found, please try again later.'
                )
            );
            header("Content-type: application/json");
            echo json_encode($json_error_data, JSON_PRETTY_PRINT);
            exit();
        }




    }

}