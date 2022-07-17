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
$response_data = array(
    'api_status' => 400
);

$required_fields = array(
    'user_id',
    'message_hash_id'
);

if (empty($_POST['product_id'])) {
    if (empty($_POST['text']) && $_POST['text'] != 0 && empty($_POST['lat']) && empty($_POST['lng'])) {
    	if (empty($_FILES['file']['name']) && empty($_POST['image_url']) && empty($_POST['gif'])) {
    	    $error_code    = 3;
    	    $error_message = 'file (STREAM FILE) AND text (POST) AND image_url AND gif (POST) are missing, at least one is required';
    	}
    }
}

foreach ($required_fields as $key => $value) {
    if (empty($_POST[$value]) && empty($error_code)) {
        $error_code    = 4;
        $error_message = $value . ' (POST) is missing';
    }
}


if (empty($error_code)) {
    $recipient_id   = Wo_Secure($_POST['user_id']);
    $recipient_data = Wo_UserData($recipient_id);
    if (empty($recipient_data)) {
        $error_code    = 6;
        $error_message = 'Recipient user not found';
    } else {
        if (empty($_POST['product_id'])) {

    	    $mediaFilename = '';
            $mediaName     = '';
            if (isset($_FILES['file']['name'])) {
                $fileInfo      = array(
                    'file' => $_FILES["file"]["tmp_name"],
                    'name' => $_FILES['file']['name'],
                    'size' => $_FILES["file"]["size"],
                    'type' => $_FILES["file"]["type"]
                );
                $media         = Wo_ShareFile($fileInfo);
                $mediaFilename = $media['filename'];
                $mediaName     = $_FILES['file']['name'];
            }
            if (!empty($_POST['image_url'])) {
            	$fileend = '_url_image';
            	if (!empty($_POST['sticker_id'])) {
            		$fileend =  '_sticker_' . Wo_Secure($_POST['sticker_id']);
            	}
                $mediaFilename = Wo_ImportImageFromUrl($_POST['image_url'], $fileend);
            }
            $gif = '';
            if (!empty($_POST['gif'])) {
                if (strpos($_POST['gif'], '.gif') !== false) {
                    $gif = Wo_Secure($_POST['gif']);
                }
            }
            $lng = 0;
            $lat = 0;
            if (!empty($_POST['lng']) && !empty($_POST['lat'])) {
                $lng = Wo_Secure($_POST['lng']);
                $lat = Wo_Secure($_POST['lat']);
            }
        	$message_data = array(
                'from_id' => Wo_Secure($wo['user']['user_id']),
                'to_id' => Wo_Secure($recipient_id),
                'media' => Wo_Secure($mediaFilename),
                'mediaFileName' => Wo_Secure($mediaName),
                'time' => time(),
                'type_two' => (!empty($_POST['contact'])) ? 'contact' : '',
                'text' => '',
                'stickers' => $gif,
                'lng' => $lng,
                'lat' => $lat,
            );
    		if (!empty($_POST['text']) || (isset($_POST['text']) && $_POST['text'] === '0') ) {
    		 	$message_data['text'] = Wo_Secure($_POST['text']);
    		}
            else{
                if (empty($lng) && empty($lat) && empty($_FILES['file']['name']) && empty($_POST['image_url']) && empty($_POST['gif'])) {
                    $error_code    = 5;
                    $error_message = 'Please check your details.';
                }
            }
            if (empty($error_message)) {
                $last_id      = Wo_RegisterMessage($message_data);
            }
        }
        else{
            $last_id = Wo_RegisterMessage(array(
                            'from_id' => Wo_Secure($wo['user']['user_id']),
                            'to_id' => $recipient_id,
                            'time' => time(),
                            'stickers' => '',
                            'product_id' => Wo_Secure($_POST['product_id'])
                        ));
        }
        if (!empty($last_id)) {
            if (!empty($_POST['reply_id']) && is_numeric($_POST['reply_id']) && $_POST['reply_id'] > 0) {
                $reply_id = Wo_Secure($_POST['reply_id']);
                $db->where('id',$last_id)->update(T_MESSAGES,array('reply_id' => $reply_id));
            }
            if (!empty($_POST['story_id']) && is_numeric($_POST['story_id']) && $_POST['story_id'] > 0) {
                $story_id = Wo_Secure($_POST['story_id']);
                $db->where('id',$last_id)->update(T_MESSAGES,array('story_id' => $story_id));
            }
        	$message_info = array(
                'user_id' => $recipient_id,
                'message_id' => $last_id
            );
            $message_info = Wo_GetMessages($message_info);
            foreach ($non_allowed as $key => $value) {
	           unset($message_info[0]['messageUser'][$value]);
	        }
	        if (empty($wo['user']['timezone'])) {
                $wo['user']['timezone'] = 'UTC';
            }
	        $timezone = new DateTimeZone($wo['user']['timezone']);
	        $messages = array();
	        foreach ($message_info as $key => $message) {
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
                array_push($messages, $message);
	        }
	        if (!empty($messages)) {
	        	$response_data = array(
	                'api_status' => 200,
	                'message_data' => $messages
	            );
	        }
        }
        else{
            $error_code    = 6;
            $error_message = 'something went wrong.';
        }
    }
}

