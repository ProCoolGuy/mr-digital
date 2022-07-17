<?php
if ($f == "update_general_settings") {
    if (isset($_POST) && Wo_CheckSession($hash_id) === true) {
        if (empty($_POST['username']) OR empty($_POST['email'])) {
            $errors[] = $error_icon . $wo['lang']['please_check_details'];
        } else {
            $Userdata = Wo_UserData($_POST['user_id']);
            $age_data = '00-00-0000';
            if ($Userdata['birthday'] != $age_data) {
                $age_data = $Userdata['birthday'];
            }
            if (!empty($Userdata['user_id'])) {
                if ($_POST['email'] != $Userdata['email']) {
                    if (Wo_EmailExists($_POST['email'])) {
                        $errors[] = $error_icon . $wo['lang']['email_exists'];
                    }
                }
                if ($_POST['username'] != $Userdata['username']) {
                    $is_exist = Wo_IsNameExist($_POST['username'], 0);
                    if (in_array(true, $is_exist)) {
                        $errors[] = $error_icon . $wo['lang']['username_exists'];
                    }
                }
                if (in_array($_POST['username'], $wo['site_pages'])) {
                    $errors[] = $error_icon . $wo['lang']['username_invalid_characters'];
                }
                if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                    $errors[] = $error_icon . $wo['lang']['email_invalid_characters'];
                }
                if (strlen($_POST['username']) < 5 || strlen($_POST['username']) > 32) {
                    $errors[] = $error_icon . $wo['lang']['username_characters_length'];
                }
                if (!preg_match('/^[\w]+$/', $_POST['username'])) {
                    $errors[] = $error_icon . $wo['lang']['username_invalid_characters'];
                }
                if (!empty($_POST['birthday']) && preg_match('@^\s*(3[01]|[12][0-9]|0?[1-9])\-(1[012]|0?[1-9])\-((?:19|20)\d{2})\s*$@', $_POST['birthday'])) {
                    $newDate  = date("Y-m-d", strtotime($_POST['birthday']));
                    $age_data = $newDate;
                } else {
                    if (!empty($_POST['age_year']) || !empty($_POST['age_day']) || !empty($_POST['age_month'])) {
                        if (empty($_POST['age_year']) || empty($_POST['age_day']) || empty($_POST['age_month'])) {
                            $errors[] = $error_icon . $wo['lang']['please_choose_correct_date'];
                        } else {
                            $age_data = $_POST['age_year'] . '-' . $_POST['age_month'] . '-' . $_POST['age_day'];
                        }
                    }
                }
                if ($_POST['phone_number'] != $Userdata['phone_number']) {
                    $is_exist = Wo_IsPhoneExist($_POST['phone_number']);
                    if (in_array(true, $is_exist)) {
                        $errors[] = $error_icon . $wo['lang']['phonenumber_exists'];
                    }
                }
                if (!empty($_POST['phone_number'])) {
                    if (!filter_var($_POST['phone_number'], FILTER_SANITIZE_NUMBER_INT)) {
                        $errors[] = $error_icon . $wo['lang']['phone_invalid_characters'];
                    }
                }
                $active = $Userdata['active'];
                if (!empty($_POST['active'])) {
                    if ($_POST['active'] == 'active') {
                        $active = 1;
                    } else {
                        $active = 2;
                    }
                    if ($active == $Userdata['active']) {
                        $active = $Userdata['active'];
                    }
                }
                $wallet = $Userdata['wallet'];
                if (isset($_POST['wallet']) && (Wo_IsAdmin() || Wo_IsModerator())) {
                    if (is_numeric($_POST['wallet'])) {
                        $wallet = $_POST['wallet'];
                    }
                }
                $type = $Userdata['admin'];
                if (!empty($_POST['type']) && Wo_IsAdmin()) {
                    if ($_POST['type'] == 'admin') {
                        $type = 1;
                    } else if ($_POST['type'] == 'user') {
                        $type = 0;
                    } else if ($_POST['type'] == 'mod') {
                        $type = 2;
                    }
                    if ($type == $Userdata['admin']) {
                        $type = $Userdata['admin'];
                    }
                }
                $member_type = $Userdata['pro_type'];
                $member_pro  = $Userdata['is_pro'];
                $time        = $Userdata['pro_time'];
                if (!empty($_POST['pro_type']) && (Wo_IsAdmin() || Wo_IsModerator())) {
                    if ($_POST['pro_type'] == 'free') {
                        $member_type = 0;
                        $member_pro  = 0;
                        $down        = Wo_DownUpgradeUser($Userdata['user_id']);
                    } else if ($_POST['pro_type'] == 'star') {
                        $member_type = 1;
                        $member_pro  = 1;
                        $time        = time();
                    } else if ($_POST['pro_type'] == 'hot') {
                        $member_type = 2;
                        $member_pro  = 1;
                        $time        = time();
                    } else if ($_POST['pro_type'] == 'ultima') {
                        $member_type = 3;
                        $member_pro  = 1;
                        $time        = time();
                    } else if ($_POST['pro_type'] == 'vip') {
                        $member_type = 4;
                        $member_pro  = 1;
                        $time        = time();
                    }
                }
                $gender       = 'male';
                $gender_array = array(
                    'male',
                    'female'
                );
                if (!empty($_POST['gender'])) {
                    if (in_array($_POST['gender'], array_keys($wo['genders']))) {
                        $gender = $_POST['gender'];
                    }
                }
                if (empty($errors)) {
                    $save = true;
                    if (!Wo_IsAdmin()) {
                        $code      = rand(111111, 999999);
                        $hash_code = md5($code);
                        $message   = "Your confirmation code is: $code";
                        if ($_POST['email'] != $wo['user']['email'] && $wo['config']['sms_or_email'] == 'mail' && $wo['config']['emailValidation'] == 1) {
                            $send_message_data = array(
                                'from_email' => $wo['config']['siteEmail'],
                                'from_name' => $wo['config']['siteName'],
                                'to_email' => $_POST['email'],
                                'to_name' => $wo['user']['name'],
                                'subject' => 'Please verify that it’s you',
                                'charSet' => 'utf-8',
                                'message_body' => $message,
                                'is_html' => true
                            );
                            $send              = Wo_SendMessage($send_message_data);
                            if ($send) {
                                $update_code    = $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array(
                                    'email_code' => $hash_code,
                                    'new_email' => Wo_Secure($_POST['email'], 0)
                                ));
                                $save           = false;
                                $data['type']   = 'email';
                                $data['status'] = 200;
                            }
                        } elseif (!empty($_POST['phone_number']) && $_POST['phone_number'] != $wo['user']['phone_number'] && $wo['config']['sms_or_email'] == 'sms' && $wo['config']['emailValidation'] == 1) {
                            preg_match_all('/\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|
                                    2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|
                                    4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$/', $_POST['phone_number'], $matches);
                            if (empty($matches[1][0]) && empty($matches[0][0])) {
                                $errors[] = $error_icon . $wo['lang']['phone_number_error'];
                            } else {
                                $send = Wo_SendSMSMessage($_POST['phone_number'], $message);
                                if ($send) {
                                    $update_code    = $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array(
                                        'email_code' => $hash_code,
                                        'new_phone' => Wo_Secure($_POST['phone_number'])
                                    ));
                                    $save           = false;
                                    $data['type']   = 'phone';
                                    $data['status'] = 200;
                                }
                            }
                        }
                    }
                    if ($save == true) {
                        $Update_data = array(
                            'username' => $_POST['username'],
                            'email' => $_POST['email'],
                            'birthday' => $age_data,
                            'gender' => $gender,
                            'country_id' => $_POST['country'],
                            'active' => $active,
                            'admin' => $type,
                            'is_pro' => $member_pro,
                            'pro_type' => $member_type,
                            'pro_time' => $time,
                            'wallet' => $wallet
                        );
                        if ($Userdata['avatar_org'] == 'upload/photos/f-avatar.jpg' || $Userdata['avatar_org'] == 'upload/photos/d-avatar.jpg') {
                            if ($gender == 'female') {
                                $Update_data['avatar'] = 'upload/photos/f-avatar.jpg';
                            } elseif ($gender == 'male') {
                                $Update_data['avatar'] = 'upload/photos/d-avatar.jpg';
                            }
                        }
                        if (!empty($_POST['weather_unit']) && in_array($_POST['weather_unit'], array(
                            'uk',
                            'us'
                        ))) {
                            $Update_data['weather_unit'] = Wo_Secure($_POST['weather_unit']);
                        }
                        if (!empty($_POST['verified'])) {
                            if ($_POST['verified'] == 'verified') {
                                $Verification = 1;
                            } else {
                                $Verification = 0;
                            }
                            if ($Verification == $Userdata['verified']) {
                                $Verification = $Userdata['verified'];
                            }
                            $Update_data['verified'] = $Verification;
                        }
                        $unverify = false;
                        if ($Userdata['username'] != $_POST['username']) {
                            $unverify = true;
                        }
                        if (!empty($_POST['phone_number'])) {
                            $Update_data['phone_number'] = Wo_Secure($_POST['phone_number']);
                        }
                        if (Wo_UpdateUserData($_POST['user_id'], $Update_data, $unverify)) {
                            $field_data = array();
                            if (!empty($_POST['custom_fields'])) {
                                $fields = Wo_GetProfileFields('general');
                                foreach ($fields as $key => $field) {
                                    $name = $field['fid'];
                                    if (isset($_POST[$name])) {
                                        if (mb_strlen($_POST[$name]) > $field['length']) {
                                            $errors[] = $error_icon . $field['name'] . ' field max characters is ' . $field['length'];
                                        }
                                        $field_data[] = array(
                                            $name => $_POST[$name]
                                        );
                                    }
                                }
                            }
                            if (!empty($field_data)) {
                                $insert = Wo_UpdateUserCustomData($_POST['user_id'], $field_data);
                            }
                            if (empty($errors)) {
                                $data = array(
                                    'status' => 200,
                                    'message' => $success_icon . $wo['lang']['setting_updated'],
                                    'username' => Wo_SeoLink('index.php?link1=timeline&u=' . Wo_Secure($_POST['username'])),
                                    'username_or' => Wo_Secure($_POST['username'])
                                );
                            }
                        }
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
