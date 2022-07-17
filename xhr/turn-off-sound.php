<?php 
if ($f == 'turn-off-sound') {
    if (Wo_CheckMainSession($hash_id) === true) {
        $num     = 0;
        $message = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-volume-2"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon><path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"></path></svg> ' . $wo['lang']['turn_off_notification'] . '</span>';
        if ($wo['user']['notifications_sound'] == 0) {
            $num     = 1;
            $message = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-volume-x"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon><line x1="23" y1="9" x2="17" y2="15"></line><line x1="17" y1="9" x2="23" y2="15"></line></svg> ' . $wo['lang']['turn_on_notification'] . '</span>';
        }
        $update = Wo_UpdateUserData($wo['user']['user_id'], array(
            'notifications_sound' => $num
        ));
        if ($update) {
            $data = array(
                'status' => 200,
                'message' => $message
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
