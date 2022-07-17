<?php 
if ($f == 'interested_event') {
    if (!empty($_GET['event_id']) && Wo_CheckMainSession($hash_id) === true) {
        if (Wo_EventInterestedExists($_GET['event_id']) === true) {
            if (Wo_UnsetEventInterestedUsers($_GET['event_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => Wo_GetInterestedButton($_GET['event_id'])
                );
            }
        } else {
            if (Wo_AddEventInterestedUsers($_GET['event_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => Wo_GetInterestedButton($_GET['event_id'])
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
