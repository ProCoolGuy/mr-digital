<?php 
if ($f == 'reset_password') {
    if (isset($_POST['id'])) {
        $user_id  = explode("_", $_POST['id']);
        if (Wo_isValidPasswordResetToken($_POST['id']) === false && Wo_isValidPasswordResetToken2($_POST['id']) === false) {
            $errors = $error_icon . $wo['lang']['invalid_token'];
        } elseif (empty($_POST['id'])) {
            $errors = $error_icon . $wo['lang']['processing_error'];
        } elseif (empty($_POST['password'])) {
            $errors = $error_icon . $wo['lang']['please_check_details'];
        } elseif (strlen($_POST['password']) < 5) {
            $errors = $error_icon . $wo['lang']['password_short'];
        } else if (Wo_TwoFactor($user_id[0], 'id') === false) {
            $_SESSION['code_id'] = $user_id[0];
            $password = $_POST['password'];
            if (Wo_ResetPassword($user_id[0], $password) === true) {
                $data               = array(
                    'status' => 600,
                    'location' => $wo['config']['site_url'] . '/unusual-login?type=two-factor'
                );
                $phone               = 1;
            }
        }
        if (empty($errors) && empty($phone)) {
            $password = $_POST['password'];
            if (Wo_ResetPassword($user_id[0], $password) === true) {
                $_SESSION['user_id'] = Wo_CreateLoginSession($user_id[0]);
            }
            $data = array(
                'status' => 200,
                'message' => $success_icon . $wo['lang']['password_changed'],
                'location' => $wo['config']['site_url']
            );
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
