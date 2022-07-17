<?php 
if ($f == 'skip_step') {
    if (!empty($_GET['type'])) {
        $types = array(
            'start_up_info',
            'startup_image',
            'startup_follow'
        );
        if (in_array($_GET['type'], $types)) {
            $register_skip = Wo_UpdateUserData($wo['user']['user_id'], array(
                $_GET['type'] => 1
            ));
            if ($register_skip === true) {
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
