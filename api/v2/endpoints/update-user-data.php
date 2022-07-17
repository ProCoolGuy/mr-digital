<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data   = array(
    'api_status' => 400
);

$user_data = array();
if (!empty($_POST)) {
	$user_data = $_POST;
}

$escape = array('server_key');
$genders = array('male', 'female');
$keys = array();
$remove_from_list = array('user_id', 'background_image', 'background_image_status', 'last_data_update', 'sidebar_data', 'details', 'id'. 'following_data', 'name', 'url', 'followers_data', 'likes_data', 'groups_data', 'album_data', 'css_file', 'joined', 'admin', 'email_code', 'ip_address', 'active', 'type', 'sms_code', 'is_pro', 'balance', 'referrer', 'wallet', 'points','relationship','relationship_user');
foreach ($wo['user'] as $key => $value) {
	if (!in_array($key, $remove_from_list )) {
		$keys[] = $key;
	}
}
$keys[] = 'e_memory';
$keys = implode(', ', $keys);

if (!empty($user_data['username'])) {
	$is_exist = Wo_IsNameExist($user_data['username'], 0);
    if (in_array(true, $is_exist) && $user_data['username'] != $wo['user']['username']) {
        $error_code    = 2;
        $error_message = 'Username is already exists';
    }
    if (in_array($user_data['username'], $wo['site_pages']) || !preg_match('/^[\w]+$/', $user_data['username'])) {
        $error_code    = 3;
        $error_message = 'Invalid username characters';
    }
    if (strlen($user_data['username']) < 5 || strlen($user_data['username']) > 32) {
        $error_code    = 4;
        $error_message = 'Username must be between 5/32';
    }
}

if (!empty($user_data['email'])) {
	$is_exist = Wo_EmailExists($user_data['email']);
    if ($is_exist && $user_data['email'] != $wo['user']['email']) {
        $error_code    = 5;
        $error_message = 'E-mail is already exists';
    }
    if (!filter_var($user_data['email'], FILTER_VALIDATE_EMAIL)) {
        $error_code    = 6;
        $error_message = 'Invalid email characters';
    }
    if (empty($error_code)) {
        $code = rand(111111, 999999);
        $hash_code = md5($code);
        $message = "Your confirmation code is: $code";
        if ($user_data['email'] != $wo['user']['email'] && $wo['config']['sms_or_email'] == 'mail' && $wo['config']['emailValidation'] == 1) {
             $send_message_data       = array(
                'from_email' => $wo['config']['siteEmail'],
                'from_name' => $wo['config']['siteName'],
                'to_email' => $user_data['email'],
                'to_name' => $wo['user']['name'],
                'subject' => 'Please verify that it’s you',
                'charSet' => 'utf-8',
                'message_body' => $message,
                'is_html' => true
            );
            $send = Wo_SendMessage($send_message_data);
            if ($send) {
                $update_code =  $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('email_code' => $hash_code,
                                                                                                     'new_email'      => Wo_Secure($user_data['email'])));
                $response_data['type'] = 'code sent';
                unset($user_data['email']);
            }
            else{
                $error_code    = 7;
                $error_message = 'code not sent';
            }
        }
        elseif ($user_data['email'] != $wo['user']['email'] && $wo['config']['sms_or_email'] == 'sms' && $wo['config']['emailValidation'] == 1) {
            $send = Wo_SendSMSMessage($user_data['email'], $message);
            if ($send) {
                $update_code =  $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('email_code' => $hash_code,
                                                                                                     'new_email'  => Wo_Secure($user_data['email'])));
                $response_data['type'] = 'code sent';
                unset($user_data['email']);
            }
            else{
                $error_code    = 7;
                $error_message = 'code not sent';
            }
        }
    }
}

if (!empty($user_data['phone_number'])) {
	$is_exist = Wo_PhoneExists($user_data['phone_number']);
    if ($is_exist && $user_data['phone_number'] != $wo['user']['phone_number']) {
        $error_code    = 7;
        $error_message = 'Phone number already used';
    }
    if (empty($error_code)) {
        $code = rand(111111, 999999);
        $hash_code = md5($code);
        $message = "Your confirmation code is: $code";
        if ($user_data['phone_number'] != $wo['user']['phone_number'] && $wo['config']['sms_or_email'] == 'mail' && $wo['config']['emailValidation'] == 1) {
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
                $update_code =  $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('email_code' => $hash_code,
                                                                                                     'new_phone'      => Wo_Secure($user_data['phone_number'])));
                $response_data['type'] = 'code sent';
                unset($user_data['phone_number']);
            }
            else{
                $error_code    = 7;
                $error_message = 'code not sent';
            }
        }
        elseif ($user_data['phone_number'] != $wo['user']['phone_number'] && $wo['config']['sms_or_email'] == 'sms' && $wo['config']['emailValidation'] == 1) {
            $send = Wo_SendSMSMessage($user_data['phone_number'], $message);
            if ($send) {
                $update_code =  $db->where('user_id', $wo['user']['user_id'])->update(T_USERS, array('email_code' => $hash_code,
                                                                                                     'new_phone'  => Wo_Secure($user_data['phone_number'])));
                $response_data['type'] = 'code sent';
                unset($user_data['phone_number']);
            }
            else{
                $error_code    = 7;
                $error_message = 'code not sent';
            }
        }
    }
}

if (!empty($user_data['new_password']) && !empty($user_data['current_password'])) {
    if (Wo_HashPassword($user_data['current_password'], $wo['user']['password']) == false) {
        $error_code    = 8;
        $error_message = 'Current password not match';
    }
    if (strlen($user_data['new_password']) < 6) {
        $error_code    = 9;
        $error_message = 'Password is too short';
    }
    if (empty($error_code)) {
    	$user_data['password'] = password_hash($user_data['new_password'], PASSWORD_DEFAULT);
    	unset($user_data['new_password']);
    	unset($user_data['current_password']);
    }
}

if (!empty($user_data['gender'])) {
	$user_data['gender'] = (in_array($user_data['gender'], $genders)) ? $user_data['gender'] : $wo['user']['gender'];
}

if (!empty($user_data['follow_privacy'])) {
	$user_data['follow_privacy'] = (in_array($user_data['follow_privacy'], array(0, 1))) ? $user_data['follow_privacy'] : $wo['user']['follow_privacy'];
}

if (!empty($user_data['message_privacy'])) {
	$user_data['message_privacy'] = (in_array($user_data['message_privacy'], array(0, 1))) ? $user_data['message_privacy'] : $wo['user']['message_privacy'];
}

if (!empty($user_data['birth_privacy'])) {
	$user_data['birth_privacy'] = (in_array($user_data['birth_privacy'], array(0, 1, 2))) ? $user_data['birth_privacy'] : $wo['user']['birth_privacy'];
}

if (!empty($user_data['friend_privacy'])) {
	$user_data['friend_privacy'] = (in_array($user_data['friend_privacy'], array(0, 1, 2, 3))) ? $user_data['friend_privacy'] : $wo['user']['friend_privacy'];
}

if (!empty($user_data['post_privacy'])) {
	$user_data['post_privacy'] = (in_array($user_data['post_privacy'], array('everyone', 'ifollow', 'nobody'))) ? $user_data['post_privacy'] : $wo['user']['post_privacy'];
}

if (!empty($user_data['confirm_followers'])) {
	$user_data['confirm_followers'] = (in_array($user_data['confirm_followers'], array(0, 1))) ? $user_data['confirm_followers'] : $wo['user']['confirm_followers'];
}

if (!empty($user_data['visit_privacy'])) {
	$user_data['visit_privacy'] = (in_array($user_data['visit_privacy'], array(0, 1))) ? $user_data['visit_privacy'] : $wo['user']['visit_privacy'];
}

if (!empty($user_data['showlastseen'])) {
	$user_data['showlastseen'] = (in_array($user_data['showlastseen'], array(0, 1))) ? $user_data['showlastseen'] : $wo['user']['showlastseen'];
}

if (!empty($user_data['show_activities_privacy'])) {
	$user_data['show_activities_privacy'] = (in_array($user_data['show_activities_privacy'], array(0, 1))) ? $user_data['show_activities_privacy'] : $wo['user']['show_activities_privacy'];
}

if (!empty($user_data['share_my_location'])) {
	$user_data['share_my_location'] = (in_array($user_data['share_my_location'], array(0, 1))) ? $user_data['share_my_location'] : $wo['user']['share_my_location'];
}

if (!empty($user_data['status'])) {
	$user_data['status'] = (in_array($user_data['status'], array(0, 1))) ? $user_data['status'] : $wo['user']['status'];
}

if (!empty($_FILES["avatar"]["tmp_name"])) {
	$upload_image = Wo_UploadImage($_FILES["avatar"]["tmp_name"], $_FILES['avatar']['name'], 'avatar', $_FILES['avatar']['type'], $wo['user']['user_id']);
    if ($upload_image) {
        $response_data['api_status'] = 200;
    }
}

if (!empty($_FILES["cover"]["tmp_name"])) {
	$upload_image = Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $wo['user']['user_id']);
    if ($upload_image) {
        $response_data['api_status'] = 200;
    }
}

if (isset($user_data['server_key'])) {
	unset($user_data['server_key']);
}
if (!empty($_POST['about'])) {
    $user_data['about'] = Wo_Secure($_POST['about']);
}
if (empty($error_code)) {
    foreach ($remove_from_list as $rkey => $rvalue) {
        unset($user_data[$rvalue]);
    }
	foreach ($user_data as $key => $value) {

		if (!in_array($key, array_keys($wo['user'])) && !in_array($key, $escape) && $key != 'e_memory') {
			$error_code = 1;
			$error_message = "Key #$key not found, check Wo_Users table to get the correct information, or you can use the following keys: $keys";
			unset($user_data[$key]);
		}
	}
}
if (!empty($user_data['two_factor']) && $user_data['two_factor'] == 'off') {
    $user_data['two_factor'] = 0;
}
elseif (!empty($user_data['two_factor']) && $user_data['two_factor'] == 'on') {
    $user_data['two_factor'] = 1;
}

if (!empty($_POST['relationship'])) {
    # code...
}
else{
    $user_data['relationship_id'] = 0;
    Wo_DeleteMyRelationShip();
}

if (!empty($_POST['relationship']) && is_numeric($_POST['relationship']) && $_POST['relationship'] > 0 && $_POST['relationship'] <= 4) {
    if ($_POST['relationship'] > 1 && isset($_POST['relationship_user']) && is_numeric($_POST['relationship_user']) && $_POST['relationship_user'] > 0) {
        $relationship_user = Wo_Secure($_POST['relationship_user']);
        $user              = Wo_Secure($wo['user']['id']);
        if (!Wo_IsRelationRequestExists($user, $relationship_user, $_POST['relationship'])) {
            $registration_data = array(
                'from_id' => $user,
                'to_id' => $relationship_user,
                'relationship' => Wo_Secure($_POST['relationship']),
                'active' => 0
            );
            $registration_id   = Wo_RegisterRelationship($registration_data);
            if ($registration_id) {
                $relationship_user_data  = Wo_UserData($relationship_user);
                $notification_data_array = array(
                    'recipient_id' => $relationship_user,
                    'type' => 'added_u_as',
                    'user_id' => $wo['user']['id'],
                    'text' => $wo['lang']['relationship_request'],
                    'url' => 'index.php?link1=timeline&u=' . $relationship_user_data['username'] . '&type=requests'
                );
                Wo_RegisterNotification($notification_data_array);
            }
        }
    }
    $user_data['relationship_id'] = Wo_Secure($_POST['relationship']);
}
if (empty($error_code)) {

    if (isset($_POST['language']) AND !empty($_POST['language'])) {
        if (in_array($_POST['language'], array_keys($wo['config'])) && $wo['config'][$_POST['language']] == 1) {
            $lang_name = Wo_Secure(strtolower($_POST['language']));
            $langs                    = Wo_LangsNamesFromDB();
            if (in_array($lang_name, $langs)) {
                Wo_CleanCache();
                if ($wo['loggedin'] == true) {
                    $user_data['language'] = $lang_name;
                }
            }
        }
    }

    $e_liked             = $wo['user']['API_notification_settings']['e_liked'];
    $e_shared            = $wo['user']['API_notification_settings']['e_shared'];
    $e_wondered          = $wo['user']['API_notification_settings']['e_wondered'];
    $e_commented         = $wo['user']['API_notification_settings']['e_commented'];
    $e_followed          = $wo['user']['API_notification_settings']['e_followed'];
    $e_liked_page        = $wo['user']['API_notification_settings']['e_liked_page'];
    $e_visited           = $wo['user']['API_notification_settings']['e_visited'];
    $e_mentioned         = $wo['user']['API_notification_settings']['e_mentioned'];
    $e_joined_group      = $wo['user']['API_notification_settings']['e_joined_group'];
    $e_accepted          = $wo['user']['API_notification_settings']['e_accepted'];
    $e_profile_wall_post = $wo['user']['API_notification_settings']['e_profile_wall_post'];
    $e_memory = $wo['user']['API_notification_settings']['e_memory'];
    $array               = array(
        0,
        1
    );
    if (isset($_POST['e_liked'])) {
        if (in_array($_POST['e_liked'], $array)) {
            $e_liked = $_POST['e_liked'];
        }
    }
    if (isset($_POST['e_shared'])) {
        if (in_array($_POST['e_shared'], $array)) {
            $e_shared = $_POST['e_shared'];
        }
    }
    if (isset($_POST['e_wondered'])) {
        if (in_array($_POST['e_wondered'], $array)) {
            $e_wondered = $_POST['e_wondered'];
        }
    }
    if (isset($_POST['e_commented'])) {
        if (in_array($_POST['e_commented'], $array)) {
            $e_commented = $_POST['e_commented'];
        }
    }
    if (isset($_POST['e_followed'])) {
        if (in_array($_POST['e_followed'], $array)) {
            $e_followed = $_POST['e_followed'];
        }
    }
    if (isset($_POST['e_liked_page'])) {
        if (in_array($_POST['e_liked_page'], $array)) {
            $e_liked_page = $_POST['e_liked_page'];
        }
    }
    if (isset($_POST['e_visited'])) {
        if (in_array($_POST['e_visited'], $array)) {
            $e_visited = $_POST['e_visited'];
        }
    }
    if (isset($_POST['e_mentioned'])) {
        if (in_array($_POST['e_mentioned'], $array)) {
            $e_mentioned = $_POST['e_mentioned'];
        }
    }
    if (isset($_POST['e_joined_group'])) {
        if (in_array($_POST['e_joined_group'], $array)) {
            $e_joined_group = $_POST['e_joined_group'];
        }
    }
    if (isset($_POST['e_accepted'])) {
        if (in_array($_POST['e_accepted'], $array)) {
            $e_accepted = $_POST['e_accepted'];
        }
    }
    if (isset($_POST['e_profile_wall_post'])) {
        if (in_array($_POST['e_profile_wall_post'], $array)) {
            $e_profile_wall_post = $_POST['e_profile_wall_post'];
        }
    }
    if (isset($_POST['e_memory'])) {
        if (in_array($_POST['e_memory'], $array)) {
            $e_memory = $_POST['e_memory'];
        }
    }
    $Update_data = array(
        'e_liked' => $e_liked,
        'e_shared' => $e_shared,
        'e_wondered' => $e_wondered,
        'e_commented' => $e_commented,
        'e_followed' => $e_followed,
        'e_accepted' => $e_accepted,
        'e_mentioned' => $e_mentioned,
        'e_joined_group' => $e_joined_group,
        'e_liked_page' => $e_liked_page,
        'e_visited' => $e_visited,
        'e_profile_wall_post' => $e_profile_wall_post,
        'e_memory' => $e_memory
    );
    $Update_data = json_encode($Update_data);
    $update2 = $db->where('user_id',$wo['user']['user_id'])->update(T_USERS,array(
            'notification_settings' => $Update_data
        ));
    // $update2 = Wo_UpdateUserData($wo['user']['user_id'], array(
    //         'notification_settings' => $Update_data
    //     ));



	$update = Wo_UpdateUserData($wo['user']['user_id'], $user_data,false);

	$update_last_seen = Wo_LastSeen($wo['user']['user_id']);
	if ($update || $update2) {
		$response_data['api_status'] = 200;
		$response_data['message'] = 'Your profile was updated';
	}
}