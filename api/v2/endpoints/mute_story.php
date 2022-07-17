<?php
if (!empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && !empty($_POST['type']) && in_array($_POST['type'], array('mute','unmute'))) {
	$user_id = Wo_Secure($_POST['user_id']);
	if ($_POST['type'] == 'mute') {
		if ($user_id != $wo['user']['id']) {
			$info = $db->where('user_id',$wo['user']['id'])->where('story_user_id',$user_id)->get(T_MUTE_STORY);
			if (empty($info)) {
				$db->insert(T_MUTE_STORY,array('user_id' => $wo['user']['id'],
			                                   'story_user_id' => $user_id,
			                                   'time' => time()));
				$response_data = array(
			                    'api_status' => 200,
			                    'message' => 'user muted'
			                );
			}
			else{
				$error_code    = 5;
			    $error_message = 'this user is already muted';
			}
		}else{
			$error_code    = 6;
			$error_message = 'you cant mute your owne story';
		}
	}
	else{
		$db->where('user_id',$wo['user']['id'])->where('story_user_id',$user_id)->delete(T_MUTE_STORY);
		$response_data = array(
		                    'api_status' => 200,
		                    'message' => 'user unmuted'
		                );
	}
}
else{
	$error_code    = 4;
    $error_message = 'user_id and type can not be empty';
}