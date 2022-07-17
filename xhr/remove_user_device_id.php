<?php 
if ($f == 'remove_user_device_id') {
    if (!empty($wo['user']['web_device_id'])) {
        $update = Wo_UpdateUserData($wo['user']['user_id'], array(
            'web_device_id' => ''
        ));
        if ($update) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
