<?php 
if ($f == "delete-my-blog") {
    if (Wo_CheckMainSession($hash_id) === true) {
        if (isset($_GET['id'])) {
            $id = Wo_Secure($_GET['id']);
        }
        $result         = Wo_DeleteMyBlog($id);
        $data['status'] = 404;
        if ($result) {
            $data = array(
                'status' => 200,
                "id" => $id
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
