<?php 
if ($f == 'join_group') {
    if (isset($_GET['group_id']) && Wo_CheckMainSession($hash_id) === true) {
        if (Wo_IsGroupJoined($_GET['group_id']) === true || Wo_IsJoinRequested($_GET['group_id'], $wo['user']['user_id']) === true) {
            if (Wo_LeaveGroup($_GET['group_id'], $wo['user']['user_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => ''
                );
            }
        } else {
            if (Wo_RegisterGroupJoin($_GET['group_id'], $wo['user']['user_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => ''
                );
                if (Wo_CanSenEmails()) {
                    $data['can_send'] = 1;
                }
            }
        }
    }
    if ($wo['loggedin'] == true) {
        Wo_CleanCache();
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
