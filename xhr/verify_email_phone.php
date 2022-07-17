<?php
if ($f == "verify_email_phone") {
    if (empty($_POST['code'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } else {
        $confirm_code = $db->where('user_id', $wo['user']['user_id'])->where('email_code', md5($_POST['code']))->getValue(T_USERS, 'count(*)');
        $Update_data  = array();
        if (empty($confirm_code)) {
            $error = $error_icon . $wo['lang']['wrong_confirmation_code'];
        }
        if (empty($error)) {
            $message = '';
            if ($wo['config']['sms_or_email'] == 'sms') {
                $message                     = $success_icon . $wo['lang']['your_phone_verified'];
                $Update_data['phone_number'] = $wo['user']['new_phone'];
                $Update_data['new_phone']    = '';
            }
            if ($wo['config']['sms_or_email'] == 'mail') {
                $message                  = $success_icon . $wo['lang']['your_email_verified'];
                $Update_data['email']     = $wo['user']['new_email'];
                $Update_data['new_email'] = '';
            }
            Wo_UpdateUserData($wo['user']['user_id'], $Update_data);
            $data = array(
                'status' => 200,
                'message' => $message
            );
        }
    }
    if (!empty($error)) {
        $data = array(
            'status' => 400,
            'message' => $error
        );
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
