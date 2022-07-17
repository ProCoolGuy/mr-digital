<?php 
if ($f == 'confirm_sms_user') {
    if (!empty($_POST['confirm_code']) && !empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0) {
        $confirm_code = $_POST['confirm_code'];
        $user_id      = $_POST['user_id'];
        if (empty($_POST['confirm_code'])) {
            $errors = $error_icon . $wo['lang']['please_check_details'];
        } else if (empty($_POST['user_id'])) {
            $errors = $error_icon . $wo['lang']['error_while_activating'];
        }
        $confirm_code = Wo_ConfirmSMSUser($user_id, $confirm_code);
        if ($confirm_code === false) {
            $errors = $error_icon . $wo['lang']['wrong_confirmation_code'];
        }
        if (empty($errors) && $confirm_code === true) {
            $data = array(
                'status' => 200,
                'location' => $wo['config']['site_url'] . '/index.php?link1=reset-password&code=' . $user_id . "_" . Wo_UserData($user_id)['password']
            );
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
