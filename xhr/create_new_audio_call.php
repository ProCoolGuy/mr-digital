<?php 
use Twilio\Jwt\AccessToken;
use Twilio\Jwt\Grants\VideoGrant;
if ($f == 'create_new_audio_call') {
    
    if (empty($_GET['user_id2']) || empty($_GET['user_id1']) || Wo_CheckMainSession($hash_id) === false || $_GET['user_id1'] != $wo['user']['user_id']) {
        exit();
    }
    $user_1      = Wo_UserData($_GET['user_id1']);
    $user_2      = Wo_UserData($_GET['user_id2']);
    $room_script = sha1(rand(1111111, 9999999999));
    if ($wo['config']['agora_chat_video'] == 1) {
        $wo['AgoraToken'] = null;
        if (!empty($wo['config']['agora_chat_app_certificate'])) {
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
        $call_type = 'audio';

        // $insertData = Wo_CreateNewVideoCall(array(
        //     'access_token' => Wo_Secure($token_),
        //     'from_id' => Wo_Secure($_GET['user_id1']),
        //     'to_id' => Wo_Secure($_GET['user_id2']),
        //     'access_token_2' => Wo_Secure($token_2),
        //     'room_name' => $room_script
        // ));
        $insertData = Wo_CreateNewAgoraCall(array(
            'from_id' => Wo_Secure($_GET['user_id1']),
            'to_id' => Wo_Secure($_GET['user_id2']),
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
                            'call_type' => 'audio',
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
                            'call_type' => 'audio',
                            'access_token_2' => '',
                            'room_name' => $room_script,
                            'call_id' => $insertData
                        )
                    )
                );
                Wo_SendPushNotification($send_array,'android_messenger');
            }
            $data = array(
                'status' => 200,
                'access_token' => '',
                'id' => $insertData,
                'html' => Wo_LoadPage('modals/calling-audio'),
                'text_no_answer' => $wo['lang']['no_answer'],
                'text_please_try_again_later' => $wo['lang']['please_try_again_later']
            );
        }
    }
    else{
        include_once('assets/libraries/twilio/vendor/autoload.php');
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
        $insertData = Wo_CreateNewAudioCall(array(
            'access_token' => Wo_Secure($token_),
            'from_id' => Wo_Secure($_GET['user_id1']),
            'to_id' => Wo_Secure($_GET['user_id2']),
            'access_token_2' => Wo_Secure($token_2),
            'room_name' => $room_script
        ));
        if ($insertData > 0) {
            $wo['calling_user'] = Wo_UserData($_GET['user_id2']);
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
                            'access_token_2' => Wo_Secure($token_2),
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
                            'access_token_2' => Wo_Secure($token_2),
                            'room_name' => $room_script,
                            'call_id' => $insertData
                        )
                    )
                );
                Wo_SendPushNotification($send_array,'android_messenger');
            }
            $data = array(
                'status' => 200,
                'access_token' => $token_,
                'id' => $insertData,
                'html' => Wo_LoadPage('modals/calling-audio'),
                'text_no_answer' => $wo['lang']['no_answer'],
                'text_please_try_again_later' => $wo['lang']['please_try_again_later']
            );
        }
    }
        
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
