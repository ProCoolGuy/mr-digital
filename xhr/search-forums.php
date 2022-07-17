<?php 
if ($f == "search-forums") {
    $keyword = (isset($_GET['keyword'])) ? Wo_Secure($_GET['keyword']) : false;
    $result  = Wo_GetForumSec(array(
        "keyword" => $keyword,
        "search" => true,
        "forums" => true
    ));
    $html    = "";
    $data    = array(
        'status' => 404,
        'html' => $wo['lang']['no_forums_found']
    );
    if ($result && count($result) > 0) {
        foreach ($result as $wo['section']) {
            $html .= trim(Wo_LoadPage('forum/includes/section-list'));
        }
        $data['html']   = $html;
        $data['status'] = 200;
    }
    if (!$html) {
        $data['html']   = $wo['lang']['no_forums_found'];
        $data['status'] = 404;
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
