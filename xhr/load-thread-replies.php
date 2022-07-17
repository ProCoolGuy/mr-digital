<?php 
if ($f == "load-thread-replies" && Wo_CheckMainSession($hash_id) === true) {
    $html    = '';
    $tid     = (isset($_GET['tid'])) ? $_GET['tid'] : false;
    $offset  = (isset($_GET['offset'])) ? $_GET['offset'] : false;
    $replies = Wo_GetThreadReplies(array(
        "thread_id" => $tid,
        "offset" => $offset,
        "limit" => 10
    ));
    if (count($replies) > 0) {
        foreach ($replies as $wo['threadreply']) {
            $html .= Wo_LoadPage('forum/includes/threadreply-list');
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
