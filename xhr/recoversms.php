<?php 
if ($f == 'recoversms') {
    if (empty($_POST['recoverphone'])) {
        $errors = $error_icon . $wo['lang']['please_check_details'];
    } else {
        if (!filter_var($_POST['recoverphone'], FILTER_SANITIZE_NUMBER_INT)) {
            $errors = $error_icon . $wo['lang']['phone_invalid_characters'];
        }
        if (!in_array(true, Wo_IsPhoneExist($_POST['recoverphone']))) {
            $errors = $error_icon . $wo['lang']['phonenumber_not_found'];
        }
    }
    if (empty($errors)) {
        $random_activation = Wo_Secure(rand(11111, 99999));
        $message           = $wo['lang']['confirmation_code_is'] . ": {$random_activation}";
        $user_id           = Wo_UserIdFromPhoneNumber($_POST['recoverphone']);
        $code              = md5(rand(111, 999) . time());
        $time = time() + (60 * 60 * 12);
        $query             = mysqli_query($sqlConnect, "UPDATE " . T_USERS . " SET `sms_code` = '{$random_activation}', `email_code` = '$code' , `time_code_sent` = '".$time."' WHERE `user_id` = {$user_id}");
        if ($query) {
            if (Wo_SendSMSMessage($_POST['recoverphone'], $message) === true) {
                $data = array(
                    'status' => 200,
                    'message' => $success_icon . $wo['lang']['recoversms_sent'],
                    'location' => Wo_SeoLink('index.php?link1=confirm-sms-password?code=' . $code)
                );
            } else {
                $errors = $error_icon . $wo['lang']['failed_to_send_code_email'];
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
