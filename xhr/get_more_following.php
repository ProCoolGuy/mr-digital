<?php 
if ($f == "get_more_following") {
    $html = '';
    if (isset($_GET['user_id']) && isset($_GET['after_last_id'])) {
        foreach (Wo_GetFollowing($_GET['user_id'], 'profile', 25, $_GET['after_last_id']) as $wo['UsersList']) {
            $html .= Wo_LoadPage('timeline/follow-list');
        }
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
