<?php 
if ($f == 'get_follow_requests') {
    $data     = array(
        'status' => 200,
        'html' => ''
    );
    $requests = Wo_GetFollowRequests();
    $groups = GetGroupChatRequests();
    if (count($requests) > 0 || !empty($groups)) {
        if (!empty($requests)) {
            foreach ($requests as $wo['request']) {
                $data['html'] .= Wo_LoadPage('header/follow-requests');
            }
        }
        if (!empty($groups)) {
            foreach ($groups as $group) {
                $wo['group_chat'] = Wo_GroupTabData($group->group_id,false);
                $data['html'] .= Wo_LoadPage('header/group-requests');
            }
        }
    } else {
        $data['message'] = $wo['lang']['no_new_requests'];
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
