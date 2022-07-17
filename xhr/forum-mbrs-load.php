<?php 
if ($f == "forum-mbrs-load") {
    $html    = '';
    $offset  = (isset($_GET['offset'])) ? $_GET['offset'] : 0;
    $members = Wo_GetForumUsers(array(
        "offset" => $offset
    ));
    if (count($members) > 0) {
        foreach ($members as $wo['member']) {
            $html .= Wo_LoadPage('forum/includes/mbr-list');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
    } else {
        $data = array(
            'status' => 404
        );
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
