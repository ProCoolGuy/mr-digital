<?php
if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0) {
	$post_id = Wo_Secure($_POST['post_id']);
	if (Wo_HidePost($post_id)) {
        $response_data = array(
                    'api_status' => 200,
                    'message' => 'post hidden'
                );
    }
    else{
    	$error_code    = 5;
	    $error_message = 'something went wrong';
    }
}
else{
	$error_code    = 4;
    $error_message = 'post_id can not be empty';
}