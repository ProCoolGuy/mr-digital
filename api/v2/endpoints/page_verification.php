<?php
$response_data = array(
    'api_status' => 400
);

if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
	$id = Wo_Secure($_POST['id']);
	if (Wo_IsVerificationRequests($id, 'Page')) {
		if (Wo_RemoveVerificationRequest($id, 'Page') === true) {
            $response_data = array(
                'api_status' => 200,
                'message' => 'Your request removed successfully',
                'code' => 0
            );
        }
        else{
        	$error_code    = 7;
            $error_message = 'wrong data or you are not the owner.';
        }
	}
	else{
		if (Wo_RequestVerification($id, 'Page') === true) {
            $response_data = array(
                'api_status' => 200,
                'message' => 'Your request sent successfully',
                'code' => 1
            );
        }
        else{
        	$error_code    = 7;
            $error_message = 'wrong data or you are not the owner.';
        }
	} 
}
else{
	$error_code    = 6;
    $error_message = 'id can not be empty.';
}