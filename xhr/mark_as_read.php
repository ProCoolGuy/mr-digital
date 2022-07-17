<?php 
if ($f == 'mark_as_read') {
    if (Wo_MarkAllChatsAsRead($wo['user']['user_id'])) {
        $data['status'] = 200;
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
