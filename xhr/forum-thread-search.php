<?php 
if ($f == "forum-thread-search") {
    $keyword = (isset($_GET['keyword'])) ? Wo_Secure($_GET['keyword']) : false;
    $fid     = (isset($_GET['fid'])) ? Wo_Secure($_GET['fid']) : false;
    if ($fid && is_numeric($fid)) {
        $threads = Wo_GetForumThreads(array(
            "forum" => $fid,
            "subject" => $keyword,
            "search" => true,
            "order_by" => "DESC"
        ));
        $html    = "";
        $data    = array(
            'status' => 404,
            'html' => $wo['lang']['no_threads_found']
        );
        if ($threads && count($threads) > 0) {
            foreach ($threads as $wo['thread']) {
                $html .= trim(Wo_LoadPage('forum/includes/post-list'));
            }
            $data['html']   = $html;
            $data['status'] = 200;
        }
    } else {
        $data['html']   = $wo['lang']['no_threads_found'];
        $data['status'] = 404;
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
