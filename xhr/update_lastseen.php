<?php 
if ($f == 'update_lastseen') {
    if (Wo_CheckMainSession($hash_id) === true) {
        if (Wo_LastSeen($wo['user']['user_id']) === true) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
