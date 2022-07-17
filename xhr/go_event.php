<?php 
if ($f == 'go_event') {
    if (!empty($_GET['event_id']) && Wo_CheckMainSession($hash_id) === true) {
        if (Wo_EventGoingExists($_GET['event_id']) === true) {
            if (Wo_UnsetEventGoingUsers($_GET['event_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => Wo_GetGoingButton($_GET['event_id'])
                );
            }
        } else {
            if (Wo_AddEventGoingUsers($_GET['event_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => Wo_GetGoingButton($_GET['event_id'])
                );
                if (Wo_CanSenEmails()) {
                    $data['can_send'] = 1;
                }
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
