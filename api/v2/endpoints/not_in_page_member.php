<?php

$response_data = array(
    'api_status' => 400,
);
if (empty($_POST['page_id'])) {
    $error_code    = 3;
    $error_message = 'page_id (POST) is missing';
}

if (empty($error_code)) {
    $page_id   = Wo_Secure($_POST['page_id']);
    $members = Wo_GetPageInvites($page_id);
    foreach ($members as $key => $member) {
        foreach ($non_allowed as $key2 => $value2) {
           unset($members[$key][$value2]);
        }
        $members[$key]['is_following'] = (Wo_IsFollowing($members[$key]['user_id'], $wo['user']['user_id'])) ? 1 : 0;
    }
        
    $response_data = array(
        'api_status' => 200,
        'users' => $members
    );
}