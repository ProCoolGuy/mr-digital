<?php
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
if (!empty($_POST['story_id']) && is_numeric($_POST['story_id']) && $_POST['story_id'] > 0) {
	if (!empty($offset)) {
		$db->where('id',$offset,'>');
	}
	$users_data = array();
	$story_id = Wo_Secure($_POST['story_id']);
	$story = $db->where('id',$story_id)->where('user_id',$wo['user']['id'])->getOne(T_USER_STORY);
	if (!empty($story)) {
		$users = $db->where('story_id',$story_id)->where('user_id',$wo['user']['id'],'!=')->get(T_STORY_SEEN,$limit);
		if (!empty($users)) {
			foreach ($users as $key => $value) {
				$user = Wo_UserData($value->user_id);
				foreach ($non_allowed as $key2 => $value2) {
			       unset($user[$value2]);
			    }
			    $user['offset_id'] = $value->id;
			    $users_data[] = $user;
			}
		}
	}
		
	$response_data = array(
	    'api_status' => 200,
	    'users' => $users_data
	);
}
else{
	$error_code    = 4;
    $error_message = 'story_id can not be empty';
}