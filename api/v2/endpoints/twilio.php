<?php
use Twilio\Jwt\AccessToken;
use Twilio\Jwt\Grants\VideoGrant;
$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'create',
                        'check',
                        'action',
                    );

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'create') {
    	if (!empty($_POST['recipient_id']) && is_numeric($_POST['recipient_id']) && $_POST['recipient_id'] > 0 && !empty($_POST['call_type']) && in_array($_POST['call_type'], array('video','audio')) && $_POST['recipient_id'] != $wo['user']['id']) {
    		include_once('assets/libraries/twilio/vendor/autoload.php');
            $user_id = $wo['user']['id'];
            $recipient_id = Wo_Secure($_POST['recipient_id']);
		    $room_script  = sha1(rand(1111111, 9999999999));
		    $accountSid   = $wo['config']['video_accountSid'];
		    $apiKeySid    = $wo['config']['video_apiKeySid'];
		    $apiKeySecret = $wo['config']['video_apiKeySecret'];
		    $call_id      = substr(md5(microtime()), 0, 15);
		    $call_id_2    = substr(md5(time()), 0, 15);
		    $token        = new AccessToken($accountSid, $apiKeySid, $apiKeySecret, 3600, $call_id);
		    $grant        = new VideoGrant();
		    $grant->setRoom($room_script);
		    $token->addGrant($grant);
		    $token_ = $token->toJWT();
		    $token2 = new AccessToken($accountSid, $apiKeySid, $apiKeySecret, 3600, $call_id_2);
		    $grant2 = new VideoGrant();
		    $grant2->setRoom($room_script);
		    $token2->addGrant($grant2);
		    $token_2    = $token2->toJWT();
            $create_room_name = sha1(rand(1111111, 9999999999));
            if ($_POST['call_type'] == 'video') {
            	$insertData = Wo_CreateNewVideoCall(array(
			        'access_token' => Wo_Secure($token_),
			        'from_id' => Wo_Secure($user_id),
			        'to_id' => Wo_Secure($recipient_id),
			        'access_token_2' => Wo_Secure($token_2),
	                'room_name' => $room_script
			    ));
            }
            else{
            	$insertData = Wo_CreateNewAudioCall(array(
			        'access_token' => Wo_Secure($token_),
			        'from_id' => Wo_Secure($user_id),
			        'to_id' => $recipient_id,
			        'access_token_2' => Wo_Secure($token_2),
	                'room_name' => $room_script
			    ));
            }
			    
		    if ($insertData > 0) {
		        $wo['calling_user'] = Wo_UserData($recipient_id);
                if (!empty($wo['calling_user']['ios_m_device_id']) && $wo['config']['ios_push_messages'] == 1) {
                    $send_array = array(
                        'send_to' => array(
                            $wo['calling_user']['ios_m_device_id']
                        ),
                        'notification' => array(
                            'notification_content' => 'is calling you',
                            'notification_title' => $wo['calling_user']['name'],
                            'notification_image' => $wo['calling_user']['avatar'],
                            'notification_data' => array(
                                'call_type' => 'audio',
                                'access_token_2' => $token_2,
                                'room_name' => $room_script,
                                'call_id' => $insertData
                            )
                        )
                    );
                    Wo_SendPushNotification($send_array,'ios_messenger');
                }
                if (!empty($wo['calling_user']['android_m_device_id']) && $wo['config']['android_push_messages'] == 1) {
                    $send_array = array(
                        'send_to' => array(
                            $wo['calling_user']['android_m_device_id']
                        ),
                        'notification' => array(
                            'notification_content' => 'is calling you',
                            'notification_title' => $wo['calling_user']['name'],
                            'notification_image' => $wo['calling_user']['avatar'],
                            'notification_data' => array(
                                'call_type' => 'audio',
                                'access_token_2' => $token_2,
                                'room_name' => $room_script,
                                'call_id' => $insertData
                            )
                        )
                    );
                    Wo_SendPushNotification($send_array,'android_messenger');
                }

		        $response_data               = array(
		            'api_status' => 200,
                    'access_token' => $token_,
                    'access_token_2' => $token_2,
                    'id' => $insertData,
                    'room_name' => $room_script
		        );
                if ($_POST['call_type'] == 'video') {
                    $response_data['url'] = $wo['config']['site_url'] . '/video-call-api/' . $insertData . '?c_id=' . $_GET['access_token'] . '&user_id=' . $user_id;
                }
		    } else {
		        $error_code    = 6;
			    $error_message = "Can\'t create a video call";
		    }
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'recipient_id , call_type can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'check') {
    	if (!empty($_POST['call_id']) && is_numeric($_POST['call_id']) && $_POST['call_id'] > 0 && !empty($_POST['call_type']) && in_array($_POST['call_type'], array('video','audio'))) {
    		$call_type = 'no_answer';
            $id = Wo_Secure($_POST['call_id']);
            if ($_POST['call_type'] == 'video') {
            	$mysqli = mysqli_query($sqlConnect, "SELECT * FROM " . T_VIDEOS_CALLES . " WHERE id = {$id}");
            }
            else{
            	$mysqli = mysqli_query($sqlConnect, "SELECT * FROM " . T_AUDIO_CALLES . " WHERE id = {$id}");
            }
	            
            $call_data = mysqli_fetch_assoc($mysqli);
            if (!empty($call_data)) {
            	if ($call_data['active'] == 1) {
            		$call_type = 'answered';
            	}
            	if ($call_data['declined'] == 1) {
            		$call_type = 'declined';
            	}
            }
            $response_data               = array(
	            'api_status' => 200,
                'call_status' => $call_type
	        );
	    }
	    else{
	    	$error_code    = 5;
		    $error_message = 'call_id and call_type can not be empty';
	    }
    }
    elseif ($_POST['type'] == 'action') {
    	if (!empty($_POST['call_id']) && is_numeric($_POST['call_id']) && $_POST['call_id'] > 0 && !empty($_POST['action']) && in_array($_POST['action'], array('answer','close','decline')) && !empty($_POST['call_type']) && in_array($_POST['call_type'], array('video','audio'))) {
    		$id = Wo_Secure($_POST['call_id']);
    		$user_id = $wo['user']['id'];
    		$table = T_AUDIO_CALLES;
    		if ($_POST['call_type'] == 'video') {
    			$table = T_VIDEOS_CALLES;
    		}
    		if ($_POST['action'] == 'answer') {
		        $query = mysqli_query($sqlConnect, "UPDATE " . $table . " SET  `active` = '1' , `declined` = '0'  WHERE `id` = '$id'");
    		} else if ($_POST['action'] == 'close') {
                $query   = mysqli_query($sqlConnect, "DELETE FROM " . $table . " WHERE `from_id` = '$user_id'");
            } else if ($_POST['action'] == 'decline') {
		        $query = mysqli_query($sqlConnect, "UPDATE " . $table . " SET  `declined` = '1' , `active` = '0' WHERE `id` = '$id'");
    		}
            $call = $db->where('id',$id)->getOne($table);
    		$response_data               = array(
	            'api_status' => 200
	        );
            if (!empty($call) && $_POST['action'] == 'answer') {
                $response_data['url'] = $wo['config']['site_url'] . '/video-call-api/' . $call->id . '?c_id=' . $_GET['access_token'] . '&user_id=' . $call->to_id;
            }
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'call_id , action , call_type can not be empty';
    	}
    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}