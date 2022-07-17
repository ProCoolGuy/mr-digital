<?php 
if ($f == 'resned_code_ac') {
    if (isset($_SESSION['code_id'])) {
        $user = Wo_UserData($_SESSION['code_id']);
        if (empty($user) || empty($_SESSION['code_id']) || empty($user['phone_number'])) {
            $errors[] = $error_icon . $wo['lang']['failed_to_send_code'];
        }
        if (empty($errors)) {
            $random_activation = Wo_Secure(rand(11111, 99999));
            $message           = "Your confirmation code is: {$random_activation}";
            $user_id           = $user['user_id'];
            $query             = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `sms_code` = '{$random_activation}' WHERE `user_id` = {$user_id}");
            if ($query) {
                if (Wo_SendSMSMessage($user['phone_number'], $message) === true) {
                    $data = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['sms_has_been_sent']
                    );
                } else {
                    $errors[] = $error_icon . $wo['lang']['error_while_sending_sms'];
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
