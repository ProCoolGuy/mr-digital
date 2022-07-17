<?php 
if ($f == 'recover') {
    if (empty($_POST['recoveremail'])) {
        $errors = $error_icon . $wo['lang']['please_check_details'];
    } else {
        if (!filter_var($_POST['recoveremail'], FILTER_VALIDATE_EMAIL)) {
            $errors = $error_icon . $wo['lang']['email_invalid_characters'];
        } else if (Wo_EmailExists($_POST['recoveremail']) === false) {
            $errors = $error_icon . $wo['lang']['email_not_found'];
        } else if ($config['reCaptcha'] == 1) {
            if (!isset($_POST['g-recaptcha-response']) || empty($_POST['g-recaptcha-response'])) {
                $errors = $error_icon . $wo['lang']['reCaptcha_error'];
            }
        }
    }
    if (empty($errors)) {
        $user_recover_data         = Wo_UserData(Wo_UserIdFromEmail($_POST['recoveremail']));
        $subject                   = $config['siteName'] . ' ' . $wo['lang']['password_rest_request'];
        $code              = md5(rand(111, 999) . uniqid() . time());
        $user_recover_data['link'] = Wo_Link('index.php?link1=reset-password&code=' . $user_recover_data['user_id'] . '_' . $code);
        $time = time() + (60 * 60 * 12);
        $query                     = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `email_code` = '$code' , `time_code_sent` = '".$time."' WHERE `user_id` = {$user_recover_data['user_id']}");
        $wo['recover']             = $user_recover_data;
        $body                      = Wo_LoadPage('emails/recover');
        $send_message_data         = array(
            'from_email' => $wo['config']['siteEmail'],
            'from_name' => $wo['config']['siteName'],
            'to_email' => $_POST['recoveremail'],
            'to_name' => '',
            'subject' => $subject,
            'charSet' => 'utf-8',
            'message_body' => $body,
            'is_html' => true
        );
        $send                      = Wo_SendMessage($send_message_data);
        $data                      = array(
            'status' => 200,
            'message' => $success_icon . $wo['lang']['email_sent']
        );
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
