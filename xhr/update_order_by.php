<?php 
if ($f == 'update_order_by') {
    if (Wo_CheckMainSession($hash_id) === true) {
        $type = 0;
        if ($_GET['type'] == 1) {
            $type = 1;
        }
        $update = Wo_UpdateUserData($wo['user']['user_id'], array(
            'order_posts_by' => $type
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
