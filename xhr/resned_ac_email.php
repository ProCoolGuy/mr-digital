<?php 
if ($f == 'resned_ac_email') {
    if (isset($_SESSION['code_id'])) {
        $email   = 0;
        $phone   = 0;
        $user_id = $_SESSION['code_id'];
        $user    = Wo_UserData($_SESSION['code_id']);
        if (empty($user) || empty($_SESSION['code_id']) || (empty($_POST['phone_number']) && empty($_POST['email']))) {
            $errors[] = $error_icon . $wo['lang']['failed_to_send_code_fill'];
        }
        if (!empty($_POST['email'])) {
            $user2 = $db->where('email',Wo_Secure($_POST['email']))->getOne(T_USERS);
            if (empty($user2)  || (!empty($user2) && $user2->user_id != $user['user_id'])) {
                $errors[] = $error_icon . $wo['lang']['failed_to_send_code_fill'];
            }
            if (Wo_EmailExists($_POST['email']) === true && $user['email'] != $_POST['email']) {
                $errors[] = $error_icon . $wo['lang']['email_exists'];
            }
            if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                $errors[] = $error_icon . $wo['lang']['email_invalid_characters'];
            }
            if (empty($errors)) {
                $email = 1;
                $phone = 0;
            }
        } else if (!empty($_POST['phone_number'])) {
            $user2 = $db->where('phone_number',Wo_Secure($_POST['phone_number']))->getOne(T_USERS);
            if (empty($user2)  || (!empty($user2) && $user2->user_id != $user['user_id'])) {
                $errors[] = $error_icon . $wo['lang']['failed_to_send_code_fill'];
            }
            if (!preg_match('/^\+?\d+$/', $_POST['phone_number'])) {
                $errors[] = $error_icon . $wo['lang']['worng_phone_number'];
            }
            if (Wo_PhoneExists($_POST['phone_number']) === true) {
                if ($user['phone_number'] != $_POST['phone_number']) {
                    $errors[] = $error_icon . $wo['lang']['phone_already_used'];
                }
            }
            if (empty($errors)) {
                $email = 0;
                $phone = 1;
            }
        }
        if (empty($errors)) {
            if ($email == 1 && $phone == 0) {
                $wo['user']             = $_POST;
                $wo['user']['username'] = $user['username'];
                $code                   = md5(rand(1111, 9999));
                $wo['code']             = $code;
                $body                   = Wo_LoadPage('emails/activate');
                $send_message_data      = array(
                    'from_email' => $wo['config']['siteEmail'],
                    'from_name' => $wo['config']['siteName'],
                    'to_email' => $_POST['email'],
                    'to_name' => $user['username'],
                    'subject' => $wo['lang']['account_activation'],
                    'charSet' => 'utf-8',
                    'message_body' => $body,
                    'is_html' => true
                );
                //$query                  = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `email` = '" . Wo_Secure($_POST['email']) . "', `email_code` = '$code' WHERE `user_id` = {$user_id}");
                $query                  = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `email_code` = '$code' WHERE `user_id` = {$user_id}");
                $send                   = Wo_SendMessage($send_message_data);
                if ($send) {
                    $data = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['email_sent_successfully']
                    );
                }
            } else if ($email == 0 && $phone == 1) {
                $random_activation = Wo_Secure(rand(11111, 99999));
                $message           = "Your confirmation code is: {$random_activation}";
                $user_id           = $_SESSION['code_id'];
                $phone_num         = Wo_Secure($_POST['phone_number']);
                //$query             = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `phone_number` = '{$phone_num}' WHERE `user_id` = {$user_id}");
                $query             = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `sms_code` = '{$random_activation}' WHERE `user_id` = {$user_id}");
                if ($query) {
                    if (Wo_SendSMSMessage($_POST['phone_number'], $message) === true) {
                        $data = array(
                            'status' => 600,
                            'message' => $success_icon . $wo['lang']['sms_has_been_sent']
                        );
                    } else {
                        $errors[] = $error_icon . $wo['lang']['error_while_sending_sms'];
                    }
                }
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
