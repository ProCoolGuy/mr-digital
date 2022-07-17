<?php 
if ($f == 'register_group_add') {
    if (!empty($_GET['user_id']) && !empty($_GET['group_id'])) {
        $register_add = Wo_RegsiterGroupAdd($_GET['user_id'], $_GET['group_id']);
        if ($register_add === true) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
