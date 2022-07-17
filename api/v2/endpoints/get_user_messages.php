<?php 

if (!empty($_POST['recipient_id']) && is_numeric($_POST['recipient_id']) && $_POST['recipient_id'] > 0) {
	$json_success_data   = array();
	$user_id         = $wo['user']['id'];
	$user_login_data = $wo['user'];
	if (!empty($user_login_data)) {
		$recipient_id    = $_POST['recipient_id'];
        $user_login_data2 = Wo_UserData($recipient_id);
        if (!empty($user_login_data2)) {

        	$limit             = 20;
            $after_message_id  = 0;
            $before_message_id = 0;
            $message_id = 0;
            if (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0) {
                $limit = $_POST['limit'];
            }
            if (!empty($_POST['after_message_id'])) {
                $after_message_id = $_POST['after_message_id'];
            }
            if (!empty($_POST['before_message_id'])) {
                $before_message_id = $_POST['before_message_id'];
            }
            if (!empty($_POST['message_id'])) {
                $message_id = $_POST['message_id'];
            }
            $message_info = array(
                'user_id' => $user_id,
                'recipient_id' => $recipient_id,
                'before_message_id' => $before_message_id,
                'after_message_id' => $after_message_id,
                'message_id' => $message_id
            );
            $message_info = Wo_GetMessagesAPPN($message_info,$limit);
            $not_include_status = false;
            $not_include_array = array();
            if (!empty($_POST['not_include'])) {
                $not_include_array = @explode(',', $_POST['not_include']);
                $not_include_status = true;
            }
            $timezone = new DateTimeZone($user_login_data['timezone']);
            foreach ($message_info as $message) {
                $message['text'] = openssl_encrypt($message['text'], "AES-128-ECB", $message['time']);
                if ($not_include_status == true) {
                    foreach ($not_include_array as $value) {
                        if (!empty($value)) {
                            $value = Wo_Secure($value);
                            unset($message[$value]);
                        }
                    }
                }
                if (empty($message['stickers'])) {
                    $message['stickers'] = '';
                }
                $message['time_text'] = Wo_Time_Elapsed_String($message['time']);
                $message_po  = 'left';
                if ($message['from_id'] == $user_id) {
                    $message_po  = 'right';
                }
                
                $message['position']  = $message_po;
                $message['type']      = Wo_GetFilePosition($message['media']);
                if (!empty($message['stickers']) && strpos($message['stickers'], '.gif') !== false) {
                    $message['type'] = 'gif';
                }
                if ($message['type_two'] == 'contact') {
                    $message['type']   = 'contact';
                }
                $message['type']     = $message_po . '_' . $message['type'];
                $message['product']     = null;
                if (!empty($message['product_id'])) {
                    $message['type']     = $message_po . '_product';
                    $message['product'] = Wo_GetProduct($message['product_id']);
                }
                $message['file_size'] = 0;
                if (!empty($message['media'])) {
                    $message['file_size'] = '0MB';
                    if (file_exists($message['file_size'])) {
                        $message['file_size'] = Wo_SizeFormat(filesize($message['media']));
                    }
                    $message['media']     = Wo_GetMedia($message['media']);
                }
                if (!empty($message['time'])) {
                    $time_today  = time() - 86400;
                    if ($message['time'] < $time_today) {
                        $message['time_text'] = date('m.d.y', $message['time']);
                    } else {
                        $time = new DateTime('now', $timezone);
                        $time->setTimestamp($message['time']);
                        $message['time_text'] = $time->format('H:i');
                    }
                }

                if (!empty($message['reply'])) {
                    $message['reply']['text'] = openssl_encrypt($message['reply']['text'], "AES-128-ECB", $message['reply']['time']);
                    if (empty($message['reply']['stickers'])) {
                        $message['reply']['stickers'] = '';
                    }
                    $message['reply']['time_text'] = Wo_Time_Elapsed_String($message['reply']['time']);
                    $message_po  = 'left';
                    if ($message['reply']['from_id'] == $user_id) {
                        $message_po  = 'right';
                    }
                    
                    $message['reply']['position']  = $message_po;
                    $message['reply']['type']      = Wo_GetFilePosition($message['reply']['media']);
                    if (!empty($message['reply']['stickers']) && strpos($message['reply']['stickers'], '.gif') !== false) {
                        $message['reply']['type'] = 'gif';
                    }
                    if ($message['reply']['type_two'] == 'contact') {
                        $message['reply']['type']   = 'contact';
                    }
                    $message['reply']['type']     = $message_po . '_' . $message['reply']['type'];
                    $message['reply']['product']     = null;
                    if (!empty($message['reply']['product_id'])) {
                        $message['reply']['type']     = $message_po . '_product';
                        $message['reply']['product'] = Wo_GetProduct($message['reply']['product_id']);
                    }
                    $message['reply']['file_size'] = 0;
                    if (!empty($message['reply']['media'])) {
                        $message['reply']['file_size'] = '0MB';
                        if (file_exists($message['reply']['file_size'])) {
                            $message['reply']['file_size'] = Wo_SizeFormat(filesize($message['reply']['media']));
                        }
                        $message['reply']['media']     = Wo_GetMedia($message['reply']['media']);
                    }
                    if (!empty($message['reply']['time'])) {
                        $time_today  = time() - 86400;
                        if ($message['reply']['time'] < $time_today) {
                            $message['reply']['time_text'] = date('m.d.y', $message['reply']['time']);
                        } else {
                            $time = new DateTime('now', $timezone);
                            $time->setTimestamp($message['reply']['time']);
                            $message['reply']['time_text'] = $time->format('H:i');
                        }
                    }
                }
                if (!empty($message['story'])) {
                    foreach ($non_allowed as $key => $value) {
                       unset($message['story']['user_data'][$value]);
                    }
                    if (!empty($message['story']['thumb']['filename'])) {
                        $message['story']['thumbnail'] = $message['story']['thumb']['filename'];
                        unset($message['story']['thumb']);
                    } else {
                        $message['story']['thumbnail'] = $message['story']['user_data']['avatar'];
                    }
                    $message['story']['time_text'] = Wo_Time_Elapsed_String($message['story']['posted']);
                    $message['story']['view_count'] = $db->where('story_id',$message['story']['id'])->where('user_id',$message['story']['user_id'],'!=')->getValue(T_STORY_SEEN,'COUNT(*)');
                }
                array_push($json_success_data, $message);
            }
            $send_messages_to_phones = Wo_MessagesPushNotifier();
            $typing = 0;
			$check_typing = Wo_IsTyping($recipient_id);
			if ($check_typing) {
			    $typing = 1;
			}
            $is_recording = $db->where('follower_id',$wo['user']['id'])->where('following_id',$recipient_id)->where('is_typing',2)->getValue(T_FOLLOWERS,"COUNT(*)");
            $response_data = array('api_status' => 200,
            	                   'messages' => $json_success_data,
            	                   'typing' => $typing,
                                   'is_recording' => $is_recording);

        }
        else{
        	$error_code    = 5;
		    $error_message = 'recipient user not found';
        }
	}
	else{
		$error_code    = 4;
	    $error_message = 'user not found';
	}
}
else{
	$error_code    = 3;
    $error_message = 'recipient_id can not be empty';
}