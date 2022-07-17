<?php

if (!empty($_POST['page_id']) && !empty($_POST['password'])) {
    if (!Wo_HashPassword($_POST['password'], $wo['user']['password']) && !Wo_CheckPageAdminPassword($_POST['password'], $_POST['page_id'])) {
        $error_code    = 7;
	    $error_message = 'current password mismatch.';
    }
    if (empty($error_message)) {
        if (Wo_DeletePage($_POST['page_id']) === true) {
            $response_data = array(
                'api_status' => 200,
                'message' => 'page successfully deleted'
            );
        }
        else{
        	$error_code    = 7;
		    $error_message = 'You are not the page owner';
        }
    }
}
else{
	$error_code    = 6;
    $error_message = 'Please check your details.';
}