<?php 
if ($f == "forum-posts-load" && Wo_CheckMainSession($hash_id) === true) {
    $html    = '';
    $fid     = (isset($_GET['forum']) && is_numeric($_GET['forum']) && $_GET['forum'] > 0) ? $_GET['forum'] : false;
    $offset  = (isset($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] > 0) ? $_GET['offset'] : false;
    $threads = Wo_GetForumThreads(array(
        "forum" => $fid,
        "offset" => $offset
    ));
    if (count($threads) > 0) {
        foreach ($threads as $key => $wo['thread']) {
            $html .= Wo_LoadPage('forum/includes/post-list');
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
