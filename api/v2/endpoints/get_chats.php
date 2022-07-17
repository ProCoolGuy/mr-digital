<?php
$video_call = false;
$video_call_user = array();

$audio_call = false;
$audio_call_user = array();
$messages = array();
$groups = array();
$pages = array();

$user_offset = (!empty($_POST['user_offset']) && is_numeric($_POST['user_offset']) && $_POST['user_offset'] > 0 ? Wo_Secure($_POST['user_offset']) : 0);
$user_limit = (!empty($_POST['user_limit']) && is_numeric($_POST['user_limit']) && $_POST['user_limit'] > 0 && $_POST['user_limit'] <= 50 ? Wo_Secure($_POST['user_limit']) : 20);
$user_type = (!empty($_POST['user_type']) && in_array($_POST['user_type'], array('online','offline')) ? Wo_Secure($_POST['user_type']) : '');

//$data_type = (!empty($_POST['data_type']) && in_array($_POST['data_type'], array('all','users','pages','groups')) ? Wo_Secure($_POST['data_type']) : 'all');

$group_offset = (!empty($_POST['group_offset']) && is_numeric($_POST['group_offset']) && $_POST['group_offset'] > 0 ? Wo_Secure($_POST['group_offset']) : 0);
$group_limit = (!empty($_POST['group_limit']) && is_numeric($_POST['group_limit']) && $_POST['group_limit'] > 0 && $_POST['group_limit'] <= 50 ? Wo_Secure($_POST['group_limit']) : 20);

$page_offset = (!empty($_POST['page_offset']) && is_numeric($_POST['page_offset']) && $_POST['page_offset'] > 0 ? Wo_Secure($_POST['page_offset']) : 0);
$page_limit = (!empty($_POST['page_limit']) && is_numeric($_POST['page_limit']) && $_POST['page_limit'] > 0 && $_POST['page_limit'] <= 50 ? Wo_Secure($_POST['page_limit']) : 20);
$data_type = array('all');
if (!empty($_POST['data_type'])) {
    $get_types = explode(',', $_POST['data_type']);
    if (!empty($get_types)) {
        $data_type = array();
        foreach ($get_types as $key => $value) {
            if ($value == 'users' || $value == 'pages' || $value == 'groups') {
                $data_type[] = Wo_Secure($value);
            }
        }
    }
}
$fetch_array = array(
    'user_id' => $wo['user']['id'],
    'limit' => $user_limit,
    'offset' => $user_offset,
    'type' => $user_type
);
if (in_array('all',$data_type) || in_array('users',$data_type)) {
    $messages = Wo_GetMessagesUsersAPP2($fetch_array);
}

if (in_array('all',$data_type) || in_array('groups',$data_type)) {
    $groups = Wo_GetGroupsListAPP(array('offset' => $group_offset , 'limit' => $group_limit));
}

$fetch_page_array = array(
    'user_id' => $wo['user']['id'], 
    'limit' => $page_limit,
    'offset' => $page_offset
);

if (in_array('all',$data_type) || in_array('pages',$data_type)) {
    $pages = Wo_GetMessagesPagesAPP($fetch_page_array);
}


$array = array();
if (!empty($messages)) {
    foreach ($messages as $value) {
        $value['chat_type'] = 'user';
        $value['mute'] = array('notify' => 'yes',
                               'call_chat' => 'yes',
                               'archive' => 'no',
                               'fav' => 'no',
                               'pin' => 'no');
        $mute = $db->where('user_id',$wo['user']['id'])->where('chat_id',$value['chat_id'])->where('type','user')->getOne(T_MUTE);
        if (!empty($mute)) {
            $value['mute']['notify'] = $mute->notify;
            $value['mute']['call_chat'] = $mute->call_chat;
            $value['mute']['archive'] = $mute->archive;
            $value['mute']['fav'] = $mute->fav;
            $value['mute']['pin'] = $mute->pin;
        }
        $value['last_message'] = Wo_GetMessagesHeader(array('user_id' => $value['user_id']), 'user');
        foreach ($non_allowed as $key5 => $value5) {
            if (!empty($value['last_message']['messageUser'])) {
                unset($value['last_message']['messageUser'][$value5]);
            }
          
        }
        $message = $value['last_message'];
        $message['text'] = openssl_encrypt($message['text'], "AES-128-ECB", $message['time']);
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
        $message['chat_color'] = Wo_GetChatColor($wo['user']['user_id'], $value['user_id']);
        $value['last_message'] = $message;
        $value['message_count'] = Wo_CountMessages(array('new' => true,'user_id' => $value['user_id']),'user');
        $array[] = $value;
    }
}
if (!empty($groups)) {
    foreach ($groups as $key => $value) {
        $value['mute'] = array('notify' => 'yes',
                               'call_chat' => 'yes',
                               'archive' => 'no',
                               'fav' => 'no',
                               'pin' => 'no');
        $mute = $db->where('user_id',$wo['user']['id'])->where('chat_id',$value['chat_id'])->where('type','group')->getOne(T_MUTE);
        if (!empty($mute)) {
            $value['mute']['notify'] = $mute->notify;
            $value['mute']['call_chat'] = $mute->call_chat;
            $value['mute']['archive'] = $mute->archive;
            $value['mute']['fav'] = $mute->fav;
            $value['mute']['pin'] = $mute->pin;
        }
    	if (!empty($value['user_data'])) {
            foreach ($non_allowed as $key4 => $value4) {
              unset($value['user_data'][$value4]);
            }
        }
        if (!empty($value['parts'])) {
            foreach ($value['parts'] as $key3 => $g_user) {
                if (!empty($g_user)) {
                    foreach ($non_allowed as $key5 => $value5) {
                      unset($value['parts'][$key3][$value5]);
                    }
                }
            }
        }

        if (!empty($value['last_message'])) {
            foreach ($value['last_message'] as $key3 => $g_user) {
                foreach ($non_allowed as $key5 => $value5) {
                    if (!empty($value['last_message']['user_data'])) {
                        unset($value['last_message']['user_data'][$value5]);
                    }
                  
                }
            }

            $message = $value['last_message'];
            $message['text'] = openssl_encrypt($message['text'], "AES-128-ECB", $message['time']);
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
            $value['last_message'] = $message;


        }


    	$value['chat_type'] = 'group';
        $array[] = $value;
    }
}
if (!empty($pages)) {
    foreach ($pages as $key => $value) {
    	$page = Wo_PageData($value['message']['page_id']);
        $page['chat_id'] = $value['chat_id'];
        $page['mute'] = array('notify' => 'yes',
                               'call_chat' => 'yes',
                               'archive' => 'no',
                               'fav' => 'no',
                               'pin' => 'no');
        $mute = $db->where('user_id',$wo['user']['id'])->where('chat_id',$value['chat_id'])->where('type','page')->getOne(T_MUTE);
        if (!empty($mute)) {
            $page['mute']['notify'] = $mute->notify;
            $page['mute']['call_chat'] = $mute->call_chat;
            $page['mute']['archive'] = $mute->archive;
            $page['mute']['fav'] = $mute->fav;
            $page['mute']['pin'] = $mute->pin;
        }
        if (!empty($page) && !empty($value['message']) && !empty($value['message']['page_id']) && !empty($value['message']['user_id']) && !empty($value['message']['conversation_user_id'])) {
            $user_id = $wo['user']['id'];
            $timezone = new DateTimeZone($wo['user']['timezone']);
            $message = Wo_GetPageMessages(array(
                                        'page_id' => $value['message']['page_id'],
                                        'from_id' => $value['message']['user_id'],
                                        'to_id'   => $value['message']['conversation_user_id'],
                                        'limit' => 1,
                                        'limit_type' => 1
                                    ));
            if (!empty($message) && !empty($message[0]) && !empty($message[0]['time'])) {
                $page['last_message'] = $message[0];

                $message = $page['last_message'];
                $message['text'] = openssl_encrypt($message['text'], "AES-128-ECB", $message['time']);
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
                $info_id = $message['to_id'];
                if ($message['from_id'] != $message['user_data']['user_id']) {
                    $info_id = $message['from_id'];
                }
                $message['to_data'] = Wo_UserData($info_id);

                $page['last_message'] = $message;
                $page['chat_type'] = 'page';
                $page['chat_time'] = $value['chat_time'];
                foreach ($non_allowed as $key5 => $value5) {
                    if (!empty($page['last_message']['user_data'])) {
                        unset($page['last_message']['user_data'][$value5]);
                    }
                    if (!empty($page['last_message']['to_data'])) {
                        unset($page['last_message']['to_data'][$value5]);
                    }
                  
                }

                $array[] = $page;
            }
        }
    }
}
array_multisort( array_column($array, "chat_time"), SORT_DESC, $array );


$check_calles     = Wo_CheckFroInCalls();
if ($check_calles !== false && is_array($check_calles)) {
    $video_call = true;
    $wo['video_call_user'] = Wo_UserData($check_calles['from_id']);
    $video_call_user['data'] = $check_calles;
    $video_call_user['user_id'] = $wo['video_call_user']['user_id'];
    $video_call_user['avatar'] = $wo['video_call_user']['avatar'];
    $video_call_user['name'] = $wo['video_call_user']['name'];
}

$check_audio_calles     = Wo_CheckFroInCalls('audio');
if ($check_audio_calles !== false && is_array($check_audio_calles)) {
    $audio_call = true;
    $wo['audio_call_user'] = Wo_UserData($check_audio_calles['from_id']);
    $audio_call_user['data'] = $check_audio_calles;
    $audio_call_user['user_id'] = $wo['audio_call_user']['user_id'];
    $audio_call_user['avatar'] = $wo['audio_call_user']['avatar'];
    $audio_call_user['name'] = $wo['audio_call_user']['name'];
}
$agora_call = false;
$agora_call_data = array();
$check_agora_calls     = Wo_CheckFroInCallsAgora();
if ($check_agora_calls !== false && is_array($check_agora_calls)) {
    $agora_call = true;
    $wo['agora_call_data'] = Wo_UserData($check_agora_calls['from_id']);
    $agora_call_data['data'] = $check_agora_calls;
    $agora_call_data['user_id'] = $wo['agora_call_data']['user_id'];
    $agora_call_data['avatar'] = $wo['agora_call_data']['avatar'];
    $agora_call_data['name'] = $wo['agora_call_data']['name'];
}


$response_data = array(
                    'api_status' => 200,
                    'data' => $array,
                    'video_call' => $video_call,
                    'video_call_user' => $video_call_user,
                    'audio_call' => $audio_call,
                    'audio_call_user' => $audio_call_user,
                    'agora_call' => $agora_call,
                    'agora_call_data' => $agora_call_data,
                );