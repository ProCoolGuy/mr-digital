<?php
if (!empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0) {
	$user_id = Wo_Secure($_POST['user_id']);
	$response_data = array(
                    'api_status' => 200
                );
    if (Wo_IsFollowingNotify($user_id, $wo['user']['user_id'])) {
        $db->where('following_id',$user_id)->where('follower_id',$wo['user']['user_id'])->update(T_FOLLOWERS,array('notify' => 0));
        $response_data['code'] = 0;
    }
    else{
        $db->where('following_id',$user_id)->where('follower_id',$wo['user']['user_id'])->update(T_FOLLOWERS,array('notify' => 1));
        $response_data['code'] = 1;
    }
}
else{
	$error_code    = 4;
    $error_message = 'user_id can not be empty';
}