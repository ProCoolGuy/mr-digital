<?php 
if ($f == "update_user_password") {
    if (isset($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && Wo_CheckSession($hash_id) === true) {
        $Userdata = Wo_UserData($_POST['user_id']);
        if (!empty($Userdata['user_id'])) {
            if ($_POST['user_id'] != $wo['user']['user_id']) {
                $_POST['current_password'] = 1;
            }
            if (empty($_POST['current_password']) OR empty($_POST['new_password']) OR empty($_POST['repeat_new_password'])) {
                $errors[] = $error_icon . $wo['lang']['please_check_details'];
            } else {
                if ($_POST['user_id'] == $wo['user']['user_id']) {
                    if (Wo_HashPassword($_POST['current_password'], $Userdata['password']) == false) {
                        $errors[] = $error_icon . $wo['lang']['current_password_mismatch'];
                    }
                }
                if ($_POST['new_password'] != $_POST['repeat_new_password']) {
                    $errors[] = $error_icon . $wo['lang']['password_mismatch'];
                }
                if (strlen($_POST['new_password']) < 6) {
                    $errors[] = $error_icon . $wo['lang']['password_short'];
                }
                if (empty($errors)) {
                    $Update_data = array(
                        'password' => password_hash($_POST['new_password'], PASSWORD_DEFAULT)
                    );
                    if (Wo_UpdateUserData($_POST['user_id'], $Update_data)) {
                        $user_id    = Wo_Secure($_POST['user_id']);
                        $session_id = (!empty($_SESSION['user_id'])) ? $_SESSION['user_id'] : $_COOKIE['user_id'];
                        $session_id = Wo_Secure($session_id);
                        $mysqli     = mysqli_query($sqlConnect, "DELETE FROM " . T_APP_SESSIONS . " WHERE `user_id` = '{$user_id}' AND `session_id` <> '{$session_id}'");
                        $data       = array(
                            'status' => 200,
                            'message' => $success_icon . $wo['lang']['setting_updated']
                        );
                    }
                }
            }
        }
    }
    header("Content-type: application/json");
    if (isset($errors)) {
        echo json_encode(array(
            'errors' => $errors
        ));
    } else {
        echo json_encode($data);
    }
    exit();
}
