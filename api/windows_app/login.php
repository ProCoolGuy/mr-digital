<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2016 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$json_error_data   = array();
$json_success_data = array();
if (empty($_GET['type']) || !isset($_GET['type'])) {
    $json_error_data = array(
        'api_status' => '400',
        'api_text' => 'failed',
        'api_version' => $api_version,
        'errors' => array(
            'error_id' => '1',
            'error_text' => 'Bad request, no type specified.'
        )
    );
    header("Content-type: application/json");
    echo json_encode($json_error_data, JSON_PRETTY_PRINT);
    exit();
}
$type = Wo_Secure($_GET['type'], 0);
if ($type == 'user_login') {
    if (empty($_POST['username'])) {
        $json_error_data = array(
            'api_status' => '400',
            'api_text' => 'failed',
            'api_version' => $api_version,
            'errors' => array(
                'error_id' => '3',
                'error_text' => 'Please write your username.'
            )
        );
    } else if (empty($_POST['password'])) {
        $json_error_data = array(
            'api_status' => '400',
            'api_text' => 'failed',
            'api_version' => $api_version,
            'errors' => array(
                'error_id' => '4',
                'error_text' => 'Please write your password.'
            )
        );
    }
    if (empty($json_error_data)) {
        $username        = $_POST['username'];
        $password        = $_POST['password'];
        $user_id         = Wo_UserIdFromUsername($username);
        if (empty($user_id)) {
            $user_id     = Wo_UserIdFromEmail($username);
        }
        $user_login_data = Wo_UserData($user_id);
        if (empty($user_login_data)) {
            $json_error_data = array(
                'api_status' => '400',
                'api_text' => 'failed',
                'api_version' => $api_version,
                'errors' => array(
                    'error_id' => '6',
                    'error_text' => 'Username is not exists.'
                )
            );
            header("Content-type: application/json");
            echo json_encode($json_error_data, JSON_PRETTY_PRINT);
            exit();
        } else {
            $login = Wo_Login($username, $password);
            if (!$login) {
                $json_error_data = array(
                    'api_status' => '400',
                    'api_text' => 'failed',
                    'api_version' => $api_version,
                    'errors' => array(
                        'error_id' => '7',
                        'error_text' => 'Incorrect username or password.'
                    )
                );
                header("Content-type: application/json");
                echo json_encode($json_error_data, JSON_PRETTY_PRINT);
                exit();
            } else {

                if (Wo_TwoFactor($_POST['username']) != false) {
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
                        $add_timezone = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `timezone` = '{$timezone}' WHERE `user_id` = {$user_id}");
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
                else{
                    $json_success_data = array(
                            'api_status' => '200',
                            'api_text' => 'success',
                            'api_version' => $api_version,
                            'messages' => 'Please enter your confirmation code',
                            'user_id' => $user_id
                        );
                        header("Content-type: application/json");
                        echo json_encode($json_success_data, JSON_PRETTY_PRINT);
                        exit();
                }
            }
        }
    } else {
        header("Content-type: application/json");
        echo json_encode($json_error_data, JSON_PRETTY_PRINT);
        exit();
    }
}
header("Content-type: application/json");
echo json_encode($json_success_data);
exit();
?>