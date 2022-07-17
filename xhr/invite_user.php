<?php 
if ($f == 'invite_user') {
    if (empty($_POST['email'])) {
        $errors[] = $error_icon . $wo['lang']['please_check_details'];
    } else if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
        $errors[] = $error_icon . $wo['lang']['email_invalid_characters'];
    } else if (Wo_EmailExists($_POST['email'])) {
        $errors[] = $error_icon . $wo['lang']['email_exists'];
    }
    if (empty($errors)) {
        $email             = Wo_Secure($_POST['email']);
        $message           = Wo_LoadPage('emails/invite');
        $send_message_data = array(
            'from_email' => $wo['config']['siteEmail'],
            'from_name' => $wo['config']['siteName'],
            'to_email' => $email,
            'to_name' => '',
            'subject' => 'invitation request',
            'charSet' => 'utf-8',
            'message_body' => $message,
            'is_html' => true
        );
        $send              = Wo_SendMessage($send_message_data);
        if ($send) {
            $data = array(
                'status' => 200,
                'message' => $success_icon . $wo['lang']['email_sent']
            );
        } else {
            $errors[] = $error_icon . $wo['lang']['processing_error'];
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
