<?php
$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'create',
                        'invite',
                        'check',
                        'action',
                    );

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'create') {
    	if (!empty($_POST['recipient_id']) && is_numeric($_POST['recipient_id']) && $_POST['recipient_id'] > 0 && !empty($_POST['call_type']) && in_array($_POST['call_type'], array('video','audio')) && $_POST['recipient_id'] != $wo['user']['id']) {
		    $user_2       = Wo_UserData(Wo_Secure($_POST['recipient_id']));
		    $room_script  = sha1(rand(1111111, 9999999999));
    		$wo['AgoraToken'] = null;
	        if (!empty($wo['config']['agora_chat_app_certificate']) && empty($_POST['token'])) {
	            include_once 'assets/libraries/AgoraDynamicKey/src/RtcTokenBuilder.php';
	            $appID = $wo['config']['agora_chat_app_id'];
	            $appCertificate = $wo['config']['agora_chat_app_certificate'];
	            $uid = 0;
	            $uidStr = "0";
	            $role = RtcTokenBuilder::RoleAttendee;
	            $expireTimeInSeconds = 36000000;
	            $currentTimestamp = (new DateTime("now", new DateTimeZone('UTC')))->getTimestamp();
	            $privilegeExpiredTs = $currentTimestamp + $expireTimeInSeconds;
	            $wo['AgoraToken'] = RtcTokenBuilder::buildTokenWithUid($appID, $appCertificate, $room_script, $uid, $role, $privilegeExpiredTs);
	        }
	        if (!empty($_POST['token'])) {
	        	$wo['AgoraToken'] = Wo_Secure($_POST['token']);
	        }

	        $call_type = Wo_Secure($_POST['call_type']);
	        $insertData = Wo_CreateNewAgoraCall(array(
	            'from_id' => $wo['user']['id'],
	            'to_id' => $user_2['user_id'],
	            'room_name' => $room_script,
	            'type' => $call_type,
	            'status' => 'calling',
	            'access_token' => $wo['AgoraToken']
	        ));
	        if ($insertData > 0) {
	            $wo['calling_user'] = $user_2;
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
	                            'call_type' => $call_type,
	                            'access_token_2' => '',
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
	                            'call_type' => $call_type,
	                            'access_token_2' => '',
	                            'room_name' => $room_script,
	                            'call_id' => $insertData
	                        )
	                    )
	                );
	                Wo_SendPushNotification($send_array,'android_messenger');
	            }

	            $response_data               = array(
		            'api_status' => 200,
                    'room_name' => $room_script,
                    'id' => $insertData,
                    'token' => $wo['AgoraToken']
		        );
	        }
	        else{
	        	$error_code    = 6;
			    $error_message = 'something went wrong';
	        }
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'recipient_id , call_type can not be empty';
    	}
    }
    if ($_POST['type'] == 'invite') {
    	if (!empty($_POST['room_name']) && !empty($_POST['recipient_id']) && is_numeric($_POST['recipient_id']) && $_POST['recipient_id'] > 0 && $_POST['recipient_id'] != $wo['user']['id']) {
    		$room_name = Wo_Secure($_POST['room_name']);
    		$recipient_id = Wo_Secure($_POST['recipient_id']);
    		$call = $db->where('room_name',$room_name)->where('to_id',$recipient_id,'!=')->getOne(T_AGORA);
    		if (!empty($call)) {
    			$user_2       = Wo_UserData($recipient_id);
			    $room_script  = $room_name;
	    		$wo['AgoraToken'] = $call->access_token;
		        if (!empty($_POST['token'])) {
		        	$wo['AgoraToken'] = Wo_Secure($_POST['token']);
		        }

		        $call_type = $call->type;
		        $insertData = Wo_CreateNewAgoraCall(array(
		            'from_id' => $wo['user']['id'],
		            'to_id' => $user_2['user_id'],
		            'room_name' => $room_script,
		            'type' => $call_type,
		            'status' => 'calling',
		            'access_token' => $wo['AgoraToken']
		        ));
		        if ($insertData > 0) {
		            $wo['calling_user'] = $user_2;
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
		                            'call_type' => $call_type,
		                            'access_token_2' => '',
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
		                            'call_type' => $call_type,
		                            'access_token_2' => '',
		                            'room_name' => $room_script,
		                            'call_id' => $insertData
		                        )
		                    )
		                );
		                Wo_SendPushNotification($send_array,'android_messenger');
		            }

		            $response_data               = array(
			            'api_status' => 200,
	                    'room_name' => $room_script,
	                    'id' => $insertData,
	                    'token' => $wo['AgoraToken']
			        );
		        }
    		}
    		else{
    			$error_code    = 6;
			    $error_message = 'call not found';
    		}
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'room_name , recipient_id can not be empty';
    	}
    }
    if ($_POST['type'] == 'check') {
    	if (!empty($_POST['call_id']) && is_numeric($_POST['call_id']) && $_POST['call_id'] > 0) {
    		$call_type = 'no_answer';
            $id = Wo_Secure($_POST['call_id']);
            $mysqli = mysqli_query($sqlConnect, "SELECT * FROM " . T_AGORA . " WHERE id = {$id}");
            $call_data = mysqli_fetch_assoc($mysqli);
            if (!empty($call_data)) {
            	$call_type = $call_data['status'];
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
		    $error_message = 'call_id can not be empty';
	    }
    }
    if ($_POST['type'] == 'action') {
    	if (!empty($_POST['call_id']) && is_numeric($_POST['call_id']) && $_POST['call_id'] > 0 && !empty($_POST['action']) && in_array($_POST['action'], array('answer','close','decline'))) {
    		$id = Wo_Secure($_POST['call_id']);
    		if ($_POST['action'] == 'answer') {
		        $query = mysqli_query($sqlConnect, "UPDATE " . T_AGORA . " SET `status` = 'answered' , `active` = '1' , `declined` = '0'  WHERE `id` = '$id'");
    		} else if ($_POST['action'] == 'close') {
                $query   = mysqli_query($sqlConnect, "DELETE FROM " . T_AGORA . " WHERE `from_id` = '$user_id'");
            } else if ($_POST['action'] == 'decline') {
		        $query = mysqli_query($sqlConnect, "UPDATE " . T_AGORA . " SET `status` = 'declined' , `declined` = '1' , `active` = '0' WHERE `id` = '$id'");
    		}
    		$response_data               = array(
	            'api_status' => 200
	        );
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'call_id , action can not be empty';
    	}
    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}
