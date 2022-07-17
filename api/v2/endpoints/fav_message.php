<?php
if (!empty($_POST['message_id']) && is_numeric($_POST['message_id']) && $_POST['message_id'] > 0 && !empty($_POST['chat_id']) && is_numeric($_POST['chat_id']) && $_POST['chat_id'] > 0 && !empty($_POST['fav']) && in_array($_POST['fav'], array('yes','no')) && !empty($_POST['type']) && in_array($_POST['type'], array('user','page','group'))) {
	$info = $db->where('user_id',$wo['user']['id'])->where('message_id',Wo_Secure($_POST['message_id']))->getOne(T_MUTE);
	if (!empty($info)) {
		$db->where('id',$info->id)->update(T_MUTE,array('fav' => Wo_Secure($_POST['fav'])));
	}
	else{
		$update_data['user_id'] = $wo['user']['id'];
		$update_data['type'] = Wo_Secure($_POST['type']);
		$update_data['time'] = time();
		$update_data['fav'] = Wo_Secure($_POST['fav']);
		$update_data['message_id'] = Wo_Secure($_POST['message_id']);
		$update_data['chat_id'] = Wo_Secure($_POST['chat_id']);
		$db->insert(T_MUTE,$update_data);
	}
	$response_data = array(
            'api_status' => 200,
            'message' => 'message updated'
        );

}
else{
	$error_code    = 4;
    $error_message = 'message_id and chat_id and fav and type can not be empty';
}