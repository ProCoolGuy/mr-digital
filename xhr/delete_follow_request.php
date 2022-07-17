<?php 
if ($f == 'delete_follow_request') {
    if (isset($_GET['following_id'])) {
        if (Wo_DeleteFollowRequest($_GET['following_id'], $wo['user']['user_id'])) {
            $data = array(
                'status' => 200,
                'html' => Wo_GetFollowButton($_GET['following_id'])
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
