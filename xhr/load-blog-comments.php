<?php 
if ($f == "load-blog-comments") {
    $html = '';
    $data = array(
        'status' => 404,
        'html' => $wo['lang']['no_result']
    );
    if (isset($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] > 0 && isset($_GET['b_id']) && is_numeric($_GET['b_id'])) {
        $comments = Wo_GetBlogComments(array(
            "blog_id" => $_GET['b_id'],
            "offset" => $_GET['offset']
        ));
        if (count($comments)) {
            foreach ($comments as $wo['comment']) {
                $html .= Wo_LoadPage('blog/comment-list');
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
