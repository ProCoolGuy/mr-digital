<?php
if ($f == 'google_login') {
    if (!empty($_SESSION['user_id'])) {
        $_SESSION['user_id'] = '';
        unset($_SESSION['user_id']);
    }
    if (!empty($_COOKIE['user_id'])) {
        $_COOKIE['user_id'] = '';
        unset($_COOKIE['user_id']);
        setcookie('user_id', null, -1);
        setcookie('user_id', null, -1, '/');
    }
    if ($wo['loggedin'] != true && $wo['config']['googleLogin'] != 0 && !empty($wo['config']['googleAppId']) && !empty($wo['config']['googleAppKey']) && !empty($_POST['id_token'])) {
        $data['status']   = 400;
        $access_token     = $_POST['id_token'];
        $get_user_details = fetchDataFromURL("https://oauth2.googleapis.com/tokeninfo?id_token={$access_token}");
        $json_data        = json_decode($get_user_details);
        if (!empty($json_data->error)) {
            $data['message'] = $error_icon . $json_data->error;
        } else if (!empty($json_data->kid)) {
            $social_id    = $json_data->kid;
            $social_email = $json_data->email;
            $social_name  = $json_data->name;
            if (empty($social_email)) {
                $social_email = 'go_' . $social_id . '@google.com';
            }
        }
        if (!empty($social_id)) {
            $create_session = false;
            if (Wo_EmailExists($social_email) === true) {
                $create_session = true;
            } else {
                $str          = md5(microtime());
                $id           = substr($str, 0, 9);
                $user_uniq_id = (Wo_UserExists($id) === false) ? $id : 'u_' . $id;
                $password     = rand(1111, 9999);
                $re_data      = array(
                    'username' => Wo_Secure($user_uniq_id, 0),
                    'email' => Wo_Secure($social_email, 0),
                    'password' => Wo_Secure(md5($password), 0),
                    'email_code' => Wo_Secure(md5(time()), 0),
                    'first_name' => Wo_Secure($social_name),
                    'src' => 'google',
                    'lastseen' => time(),
                    'social_login' => 1,
                    'active' => '1'
                );
                if (Wo_RegisterUser($re_data) === true) {
                    $create_session = true;
                }
            }
            if ($create_session == true) {
                Wo_SetLoginWithSession($social_email);
                $user_id = Wo_UserIdFromEmail($social_email);
                if (!empty($_SESSION['ref']) && $wo['config']['affiliate_type'] == 0) {
                    $ref_user_id = Wo_UserIdFromUsername($_SESSION['ref']);
                    if (!empty($ref_user_id) && is_numeric($ref_user_id)) {
                        $re_data['referrer'] = Wo_Secure($ref_user_id);
                        $re_data['src']      = Wo_Secure('Referrer');
                        if ($wo['config']['affiliate_level'] < 2) {
                            $update_balance = Wo_UpdateBalance($ref_user_id, $wo['config']['amount_ref']);
                        }
                        unset($_SESSION['ref']);
                    }
                }
                if (!empty($re_data['referrer']) && is_numeric($wo['config']['affiliate_level']) && $wo['config']['affiliate_level'] > 1) {
                    AddNewRef($re_data['referrer'], $user_id, $wo['config']['amount_ref']);
                }
                if (!empty($wo['config']['auto_friend_users'])) {
                    $autoFollow = Wo_AutoFollow($user_id);
                }
                if (!empty($wo['config']['auto_page_like'])) {
                    Wo_AutoPageLike($user_id);
                }
                if (!empty($wo['config']['auto_group_join'])) {
                    Wo_AutoGroupJoin($user_id);
                }
                $data['status']   = 200;
                $data['location'] = Wo_SeoLink('index.php?link1=start-up');
            } else {
                $data['message'] = $error_icon . $wo['lang']['something_wrong'];
            }
        } else {
            $data['message'] = $error_icon . $wo['lang']['something_wrong'];
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
