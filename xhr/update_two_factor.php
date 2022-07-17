<?php 
if ($f == 'update_two_factor') {
    $error = '';

    if ($s == 'enable') {
        if (isset($_POST) && Wo_CheckSession($hash_id) === true) {
            
            $is_phone = false;
            if (!empty($_POST['phone_number']) && ($wo['config']['two_factor_type'] == 'both' || $wo['config']['two_factor_type'] == 'phone')) {
                preg_match_all('/\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|
                                2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|
                                4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$/', $_POST['phone_number'], $matches);
                if (!empty($matches[1][0]) && !empty($matches[0][0])) {
                    $is_phone = true;
                }
            }
            if ((empty($_POST['phone_number']) && $wo['config']['two_factor_type'] == 'phone') || empty($_POST['two_factor']) || $_POST['two_factor'] != 'enable') {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            elseif (!empty($_POST['phone_number']) && ($wo['config']['two_factor_type'] == 'both' || $wo['config']['two_factor_type'] == 'phone') && $is_phone == false) {
                $error = $error_icon . $wo['lang']['phone_number_error'];
            }

            if (empty($error)) {

                $code = rand(111111, 999999);
                $hash_code = md5($code);
                $message = "Your confirmation code is: $code";
                $phone_sent = false;
                $email_sent = false;
                if (!empty($_POST['phone_number']) && ($wo['config']['two_factor_type'] == 'both' || $wo['config']['two_factor_type'] == 'phone')) {
                    $send = Wo_SendSMSMessage($_POST['phone_number'], $message);
                    if ($send) {
                        $phone_sent = true;
                        $Update_data = array(
                            'phone_number' => Wo_Secure($_POST['phone_number'])
                        );
                        Wo_UpdateUserData($wo['user']['user_id'], $Update_data);
                    }
                }
                if ($wo['config']['two_factor_type'] == 'both' || $wo['config']['two_factor_type'] == 'email') {

                    $send_message_data       = array(
                        'from_email' => $wo['config']['siteEmail'],
                        'from_name' => $wo['config']['siteName'],
                        'to_email' => $wo['user']['email'],
                        'to_name' => $wo['user']['name'],
                        'subject' => 'Please verify that it’s you',
                        'charSet' => 'utf-8',
                        'message_body' => $message,
                        'is_html' => true
                    );
                    $send = Wo_SendMessage($send_message_data);
                    if ($send) {
                        $email_sent = true;
                    }
                }
                if ($email_sent == true || $phone_sent == true) {
                    $Update_data = array(
                        'two_factor' => 0,
                        'two_factor_verified' => 0
                    );
                    Wo_UpdateUserData($wo['user']['user_id'], $Update_data);
                    $update_code =  $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('email_code' => $hash_code));
                    $data = array(
                                'status' => 200,
                                'message' => $success_icon . $wo['lang']['we_have_sent_you_code'],
                            );
                }
                else{
                    $data = array(
                                'status' => 400,
                                'message' => $error_icon . $wo['lang']['something_wrong'],
                            );
                }
            }
            else{
                $data = array(
                                'status' => 400,
                                'message' => $error,
                            );
            }
        }
    }

    if ($s == 'disable') {
        if ($_POST['two_factor'] != 'disable') {
            $error = $error_icon . $wo['lang']['please_check_details'];
            $data = array(
                            'status' => 400,
                            'message' => $error,
                        );
        }
        else{
            $Update_data = array(
                'two_factor' => 0,
                'two_factor_verified' => 0
            );
            Wo_UpdateUserData($wo['user']['user_id'], $Update_data);
            $data = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['setting_updated'],
                    );
        }

    }

    if ($s == 'verify') {
        if (empty($_POST['code'])) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        }
        else{
            $confirm_code = $db->where('user_id', $wo['user']['user_id'])->where('email_code', md5($_POST['code']))->getValue(T_USERS, 'count(*)');
            $Update_data = array();
            if (empty($confirm_code)) {
                $error = $error_icon . $wo['lang']['wrong_confirmation_code'];
            }
            if (empty($error)) {
                $message = '';
                if ($wo['config']['two_factor_type'] == 'phone') {
                    $message = $success_icon . $wo['lang']['your_phone_verified'];
                    if (!empty($_GET['setting'])) {
                        $Update_data['phone_number'] = $wo['user']['new_phone'];
                        $Update_data['new_phone'] = '';
                    }
                }
                if ($wo['config']['two_factor_type'] == 'email') {
                    $message = $success_icon . $wo['lang']['your_email_verified'];
                    if (!empty($_GET['setting'])) {
                        $Update_data['email'] = $wo['user']['new_email'];
                        $Update_data['new_email'] = '';
                    }
                }
                if ($wo['config']['two_factor_type'] == 'both') {
                    $message = $success_icon . $wo['lang']['your_phone_email_verified'];
                    if (!empty($_GET['setting'])) {
                        if (!empty($wo['user']['new_email'])) {
                            $Update_data['email'] = $wo['user']['new_email'];
                            $Update_data['new_email'] = '';
                        }
                        if (!empty($wo['user']['new_phone'])) {
                            $Update_data['phone_number'] = $wo['user']['new_phone'];
                            $Update_data['new_phone'] = '';
                        }
                    }
                }
                $Update_data['two_factor_verified'] = 1;
                $Update_data['two_factor'] = 1;
                Wo_UpdateUserData($wo['user']['user_id'], $Update_data);

                $data = array(
                            'status' => 200,
                            'message' => $message,
                        );
            }
        }
        if (!empty($error)) {
            $data = array(
                        'status' => 400,
                        'message' => $error,
                    );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
