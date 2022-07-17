<?php
if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
	if (!empty($_POST['group_id']) || !empty($_POST['page_id']) || !empty($_POST['recipient_id'])) {
		$message = $db->where('id',Wo_Secure($_POST['id']))->ArrayBuilder()->getOne(T_MESSAGES);
		if (!empty($message)) {
			unset($message['id']);
			unset($message['broadcast_id']);
			unset($message['deleted_one']);
			unset($message['deleted_two']);
			unset($message['sent_push']);
			unset($message['notification_id']);
			unset($message['seen']);
			$message['time'] = time();
			if (!empty($_POST['group_id']) && is_numeric($_POST['group_id']) && $_POST['group_id'] > 0) {
				$message['group_id'] = Wo_Secure($_POST['group_id']);
			}
			if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0) {
				$message['page_id'] = Wo_Secure($_POST['page_id']);
			}
			if (!empty($_POST['recipient_id']) && is_numeric($_POST['recipient_id']) && $_POST['recipient_id'] > 0) {
				$message['to_id'] = Wo_Secure($_POST['recipient_id']);
			}
			$message['from_id'] = $wo['user']['id'];
			$message['forward'] = 1;
			$id = $db->insert(T_MESSAGES,$message);
			if (!empty($id)) {

				$message = GetMessageById($id);
				$message['text'] = Wo_Markup($message['or_text']);
	        	$message['time_text'] = Wo_Time_Elapsed_String($message['time']);
	            $message_po           = 'left';
	            if ($message['from_id'] == $wo['user']['user_id']) {
	                $message_po = 'right';
	            }
	            $message['position'] = $message_po;
	            $message['type']     = Wo_GetFilePosition($message['media']);
	            if (!empty($message['stickers']) && strpos($message['stickers'], '.gif') !== false) {
	                $message['type'] = 'gif';
	            }
	            if ($message['type_two'] == 'contact') {
	                $message['type']   = 'contact';
	            }
	            if (!empty($message['lng']) && !empty($message['lat'])) {
	                $message['type']   = 'map';
	            }
	            $message['type']     = $message_po . '_' . $message['type'];
	            $message['file_size'] = 0;
	            if (!empty($message['media'])) {
	                $message['file_size'] = '0MB';
	                if (file_exists($message['file_size'])) {
	                    $message['file_size'] = Wo_SizeFormat(filesize($message['media']));
	                }
	                $message['media']     = Wo_GetMedia($message['media']);
	            }
	            if (!empty($message['time'])) {
	                $time_today = time() - 86400;
	                if ($message['time'] < $time_today) {
	                    $message['time_text'] = date('m.d.y', $message['time']);
	                } else {
	                    $time = new DateTime('now', $timezone);
	                    $time->setTimestamp($message['time']);
	                    $message['time_text'] = $time->format('H:i');
	                }
	            }
	            $message['message_hash_id'] = $_POST['message_hash_id'];
	            if (!empty($message['reply'])) {
	                foreach ($non_allowed as $key => $value) {
	                   unset($message['reply']['messageUser'][$value]);
	                }

	                $message['reply']['text'] = Wo_Markup($message['reply']['or_text']);
	                $message['reply']['time_text'] = Wo_Time_Elapsed_String($message['reply']['time']);
	                $message_po           = 'left';
	                if ($message['reply']['from_id'] == $wo['user']['user_id']) {
	                    $message_po = 'right';
	                }
	                $message['reply']['position'] = $message_po;
	                $message['reply']['type']     = Wo_GetFilePosition($message['reply']['media']);
	                if (!empty($message['reply']['stickers']) && strpos($message['reply']['stickers'], '.gif') !== false) {
	                    $message['reply']['type'] = 'gif';
	                }
	                if ($message['reply']['type_two'] == 'contact') {
	                    $message['reply']['type']   = 'contact';
	                }
	                if (!empty($message['reply']['lng']) && !empty($message['reply']['lat'])) {
	                    $message['reply']['type']   = 'map';
	                }
	                $message['reply']['type']     = $message_po . '_' . $message['reply']['type'];
	                $message['reply']['file_size'] = 0;
	                if (!empty($message['reply']['media'])) {
	                    $message['reply']['file_size'] = '0MB';
	                    if (file_exists($message['reply']['file_size'])) {
	                        $message['reply']['file_size'] = Wo_SizeFormat(filesize($message['reply']['media']));
	                    }
	                    $message['reply']['media']     = Wo_GetMedia($message['reply']['media']);
	                }
	                if (!empty($message['reply']['time'])) {
	                    $time_today = time() - 86400;
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
	            $response_data = array(
	                'api_status' => 200,
	                'message_data' => $message
	            );
			}
			else{
				$error_code    = 7;
			    $error_message = 'message not inserted';
			}
		}
		else{
			$error_code    = 6;
		    $error_message = 'message not found';
		}
	}
	else{
		$error_code    = 5;
	    $error_message = 'group_id , page_id , recipient_id can not be empty';
	}
}
else{
	$error_code    = 4;
    $error_message = 'id can not be empty';
}