<?php
if ($wo['user']['code_sent'] > 0 && $wo['user']['code_sent'] > (time() - 120)) {
	$error_code    = 4;
    $error_message = 'you must wait for 2 min';
}
else{
	if (!Wo_TwoFactor($wo['user']['username'])) {
		$db->where('user_id',$wo['user']['id'])->update(T_USERS,array('code_sent' => time()));
		$response_data = array(
                'status' => 200,
                'message' => 'code is sent'
            );
	}
	else{
		$error_code    = 5;
	    $error_message = 'something went wrong';
	}
}