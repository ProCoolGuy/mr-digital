<?php

$response_data = array(
    'api_status' => 400
);
if (empty($_POST['comment_id'])) {
    $error_code    = 4;
    $error_message = 'comment_id (POST) is missing';
}
if (empty($error_code)) {

	$post_data = array(
        'comment_id' => $_POST['comment_id']
    );
    $code = Wo_ReportPost($post_data);
    $response_data = array(
			            'api_status' => 200,
			            'code' => $code
			        );
}


