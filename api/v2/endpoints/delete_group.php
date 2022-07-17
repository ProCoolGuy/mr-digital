<?php

if (!empty($_POST['group_id']) && !empty($_POST['password'])) {
    if (!Wo_HashPassword($_POST['password'], $wo['user']['password']) && !Wo_CheckGroupAdminPassword($_POST['password'], $_POST['group_id'])) {
        $error_code    = 7;
	    $error_message = 'current password mismatch.';
    }
    if (empty($error_message)) {
        if (Wo_DeleteGroup($_POST['group_id']) === true) {
            $response_data = array(
                'api_status' => 200,
                'message' => 'group successfully deleted'
            );
        }
        else{
        	$error_code    = 7;
		    $error_message = 'You are not the group owner';
        }
    }
}
else{
	$error_code    = 6;
    $error_message = 'Please check your details.';
}