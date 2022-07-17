<?php
$response_data = array(
    'api_status' => 400,
);
$array_data = array();
$refs = Wo_GetReferrers();
if (!empty($refs)) {
	foreach ($refs as $key2 => $recipient_data) {
		foreach ($non_allowed as $key => $value) {
           unset($recipient_data[$value]);
        }
        $recipient_id   = $recipient_data['user_id'];
	    $logged_user_id  = $wo['user']['user_id'];
        $recipient_data['is_following'] = 0;
        $recipient_data['can_follow'] = 0;
        if (Wo_IsFollowing($recipient_id, $logged_user_id)) {
            $recipient_data['is_following'] = 1;
            $recipient_data['can_follow'] = 1;
        } else {
            if (Wo_IsFollowRequested($recipient_id, $logged_user_id)) {
                $recipient_data['is_following'] = 2;
                $recipient_data['can_follow'] = 1;
            } else {
                if ($recipient_data['follow_privacy'] == 1) {
                    if (Wo_IsFollowing($logged_user_id, $recipient_id)) {
                        $recipient_data['is_following'] = 0;
                        $recipient_data['can_follow'] = 1;
                    }
                } else if ($recipient_data['follow_privacy'] == 0) {
                    $recipient_data['can_follow'] = 1;
                }
            }
        }
        $recipient_data['is_following_me'] = (Wo_IsFollowing( $wo['user']['user_id'], $recipient_data['user_id'])) ? 1 : 0;
        $recipient_data['gender_text']        = ($recipient_data['gender'] == 'male') ? $wo['lang']['male'] : $wo['lang']['female'];
    	$recipient_data['lastseen_time_text'] = Wo_Time_Elapsed_String($recipient_data['lastseen']);
    	$recipient_data['is_blocked']         = Wo_IsBlocked($recipient_data['user_id']);
    	$array_data[] = $recipient_data;
	}
}
$response_data = array('api_status' => 200,
                       'data' => $array_data);