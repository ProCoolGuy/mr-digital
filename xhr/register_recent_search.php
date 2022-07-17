<?php 
if ($f == 'register_recent_search') {
    $array_type = array(
        'user',
        'page',
        'group'
    );
    if (!empty($_GET['id']) && !empty($_GET['type'])) {
        if (in_array($_GET['type'], $array_type)) {
            if ($_GET['type'] == 'user') {
                $regsiter_recent = Wo_RegsiterRecent($_GET['id'], $_GET['type']);
                $user            = Wo_UserData($regsiter_recent);
            } else if ($_GET['type'] == 'page') {
                $regsiter_recent = Wo_RegsiterRecent($_GET['id'], $_GET['type']);
                $user            = Wo_PageData($regsiter_recent);
            } else if ($_GET['type'] == 'group') {
                $regsiter_recent = Wo_RegsiterRecent($_GET['id'], $_GET['type']);
                $user            = Wo_GroupData($regsiter_recent);
            }
            if (!empty($user['url'])) {
                $data = array(
                    'status' => 200,
                    'href' => $user['url']
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
