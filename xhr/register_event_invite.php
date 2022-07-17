<?php 
if ($f == 'register_event_invite') {
    $data = array(
        'status' => 500
    );
    if (!empty($_GET['user_id']) && !empty($_GET['event_id'])) {
        $register_invite = Wo_RegsiterEventInvite($_GET['user_id'], $_GET['event_id']);
        if ($register_invite === true) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
