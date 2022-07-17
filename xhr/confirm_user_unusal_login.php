<?php 
if ($f == 'confirm_user_unusal_login') { 
    if (!empty($_POST['confirm_code']) && !empty($_SESSION['code_id'])) {
        $confirm_code = $_POST['confirm_code'];
        $user_id      = $_SESSION['code_id'];
        if (empty($_POST['confirm_code'])) {
            $errors = $error_icon . $wo['lang']['please_check_details'];
        } else if (empty($_SESSION['code_id'])) {
            $errors = $error_icon . $wo['lang']['error_while_activating'];
        }
        $confirm_code = $db->where('user_id', $user_id)->where('email_code', md5($confirm_code))->getValue(T_USERS, 'count(*)');
        if (empty($confirm_code)) {
            $errors = $error_icon . $wo['lang']['wrong_confirmation_code'];
        }
        if (empty($errors) && $confirm_code > 0) {
            unset($_SESSION['code_id']);
            if (!empty($_SESSION['last_login_data'])) {
                $update_user = $db->where('user_id', $user_id)->update(T_USERS, array('last_login_data' => json_encode($_SESSION['last_login_data'])));
            } else if (!empty(get_ip_address())) {
                $getIpInfo = fetchDataFromURL("http://ip-api.com/json/" .  get_ip_address());
                $getIpInfo = json_decode($getIpInfo, true);
                if ($getIpInfo['status'] == 'success' && !empty($getIpInfo['regionName']) && !empty($getIpInfo['countryCode']) && !empty($getIpInfo['timezone']) && !empty($getIpInfo['city'])) {
                    $update_user = $db->where('user_id', $user_id)->update(T_USERS, array('last_login_data' => json_encode($getIpInfo)));
                }
            }
            $session             = Wo_CreateLoginSession($user_id);
            $data                = array(
                'status' => 200
            );
            $_SESSION['user_id'] = $session;
            if (isset($_SESSION['last_login_data'])) {
                unset($_SESSION['last_login_data']);
            }
            setcookie("user_id", $session, time() + (10 * 365 * 24 * 60 * 60));
            if (!empty($_POST['last_url'])) {
                $data['location'] = $_POST['last_url'];
            } else {
                $data['location'] = $wo['config']['site_url'];
            }
            $user_data = Wo_UserData($user_id);
            if ($wo['config']['membership_system'] == 1 && $user_data['is_pro'] == 0) {
                $data['location'] = Wo_SeoLink('index.php?link1=go-pro');
            }
        }
    }
    header("Content-type: application/json");
    if (!empty($errors)) {
        echo json_encode(array(
            'errors' => $errors
        ));
    } else {
        echo json_encode($data);
    }
    exit();
}

