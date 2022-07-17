<?php

$response_data = array(
    'api_status' => 400,
);
if (empty($_POST['page_id'])) {
    $error_code    = 3;
    $error_message = 'page_id (POST) is missing';
}
if (empty($_POST['user_id'])) {
    $error_code    = 4;
    $error_message = 'user_id (POST) is missing';
}

if (empty($error_code)) {
    $page_id   = Wo_Secure($_POST['page_id']);
    $user_id   = Wo_Secure($_POST['user_id']);
    $register_add = Wo_RegsiterInvite($user_id, $page_id);
    if ($register_add === true) {
        $response_data = array(
            'api_status' => 200,
            'message' => 'added'
        );
    }
}