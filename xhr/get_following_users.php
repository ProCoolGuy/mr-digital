<?php 
if ($f == 'get_following_users') {
    $html = '';
    if (!empty($_GET['user_id'])) {
        foreach (Wo_GetFollowing($_GET['user_id'], 'sidebar', 12) as $wo['UsersList']) {
            $wo['UsersList']['user_name'] = $wo['UsersList']['name'];
            if (!empty($wo['UsersList']['last_name'])) {
                $wo['UsersList']['user_name'] = $wo['UsersList']['first_name'];
            }
            $html .= Wo_LoadPage('sidebar/profile-sidebar-user-list');
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
