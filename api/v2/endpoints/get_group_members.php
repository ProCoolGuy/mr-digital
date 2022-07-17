<?php

$response_data = array(
    'api_status' => 400,
);
if (empty($_POST['group_id'])) {
    $error_code    = 3;
    $error_message = 'group_id (POST) is missing';
}
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
if (empty($error_code)) {
    $group_id   = Wo_Secure($_POST['group_id']);
    $members = Wo_GetGroupSettingMembers($group_id,$limit,$offset);
    foreach ($members as $key => $member) {
        foreach ($non_allowed as $key2 => $value2) {
           unset($members[$key][$value2]);
        }
        $members[$key]['is_following'] = (Wo_IsFollowing($members[$key]['user_id'], $wo['user']['user_id'])) ? 1 : 0;
        $members[$key]['is_admin'] = Wo_IsGroupOnwer($group_id,$members[$key]['user_id']) === true ? 1 : 0;
    }
        
    $response_data = array(
        'api_status' => 200,
        'users' => $members
    );
}