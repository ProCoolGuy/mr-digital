<?php
$chats = $db->where('user_id',$wo['user']['id'])->where('pin','yes')->where('chat_id',0,'>')->get(T_MUTE);
$array = array();
if (!empty($chats)) {
	foreach ($chats as $key => $value) {
		$chat = $db->where('id',$value->chat_id)->getOne(T_U_CHATS);
		if (!empty($chat)) {
			$new_data = Wo_UserData($chat->conversation_user_id);
            if (!empty($new_data) && !empty($new_data['username'])) {
            	foreach ($non_allowed as $key5 => $value5) {
		            if (!empty($new_data)) {
		                unset($new_data[$value5]);
		            }
		          
		        }
                //$new_data['chat_time'] = $sql_fetch_one['time'];
                if (!empty($chat->time)) {
                    $new_data['chat_time'] = $chat->time;
                }
                $new_data['chat_id'] = $chat->id;
                $new_data['chat_type'] = 'user';
		        $new_data['mute'] = array('notify' => 'yes',
		                               'call_chat' => 'yes',
		                               'archive' => 'no',
		                               'fav' => 'no',
		                               'pin' => 'no');
		        $mute = $db->where('user_id',$wo['user']['id'])->where('chat_id',$new_data['chat_id'])->where('type','user')->getOne(T_MUTE);
		        if (!empty($mute)) {
		            $new_data['mute']['notify'] = $mute->notify;
		            $new_data['mute']['call_chat'] = $mute->call_chat;
		            $new_data['mute']['archive'] = $mute->archive;
		            $new_data['mute']['fav'] = $mute->fav;
		            $new_data['mute']['pin'] = $mute->pin;
		        }
		        $new_data['last_message'] = Wo_GetMessagesHeader(array('user_id' => $new_data['user_id']), 'user');
		        foreach ($non_allowed as $key5 => $value5) {
		            if (!empty($new_data['last_message']['messageUser'])) {
		                unset($new_data['last_message']['messageUser'][$value5]);
		            }
		          
		        }
		        $message = $new_data['last_message'];
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
		        if (!empty($message['lng']) && !empty($message['lat'])) {
		            $message['type']   = 'map';
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
		        $message['chat_color'] = Wo_GetChatColor($wo['user']['user_id'], $new_data['user_id']);
		        $new_data['last_message'] = $message;
		        $new_data['message_count'] = Wo_CountMessages(array('new' => true,'user_id' => $new_data['user_id']),'user');
                $array[] = $new_data;
            }
		}
	}
}
$response_data = array(
                    'api_status' => 200,
                    'data' => $array
                );