<?php
if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0 && !empty($_POST['listening'])) {
	$message_id = Wo_Secure($_POST['id']);
	$db->where('id',$message_id)->update(T_MESSAGES,array('listening' => 1));
	$response_data = array(
		                    'api_status' => 200,
		                    'message' => 'message updated'
		                );
}
else{
	$error_code    = 5;
    $error_message = 'id , listening can not be empty.';
}