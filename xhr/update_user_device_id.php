<?php 
if ($f == 'update_user_device_id') {
    if (!empty($_GET['id'])) {
        $id = Wo_Secure($_GET['id']);
        if ($id != $wo['user']['web_device_id']) {
            $update = Wo_UpdateUserData($wo['user']['user_id'], array(
                'web_device_id' => $id
            ));
            if ($update) {
                $data = array(
                    'status' => 200
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
