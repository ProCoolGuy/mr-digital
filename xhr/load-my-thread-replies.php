<?php 
if ($f == "load-my-thread-replies") {
    $html    = '';
    $offset  = (isset($_GET['offset'])) ? $_GET['offset'] : false;
    $replies = Wo_GetMyReplies(array(
        "offset" => $offset,
        "limit" => 10
    ));
    if (count($replies) > 0) {
        foreach ($replies as $wo['message']) {
            $html .= Wo_LoadPage('forum/includes/mymessage-list');
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
