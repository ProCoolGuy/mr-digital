<?php 
if ($f == "load-my-forum-posts") {
    $html   = '';
    $offset = (isset($_GET['offset'])) ? $_GET['offset'] : false;
    $thrads = Wo_GetForumThreads(array(
        "offset" => $offset,
        "limit" => 10
    ));
    if (count($thrads) > 0) {
        foreach ($thrads as $key => $wo['thread']) {
            $html .= Wo_LoadPage('forum/includes/mythread-list');
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
