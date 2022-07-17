<?php 
if ($f == "del-blog-commreplies") {
    $data = array(
        'status' => 304
    );
    if (isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0 && isset($_GET['b_id']) && is_numeric($_GET['b_id'])) {
        if (Wo_DeleteBlogCommReply($_GET['id'], $_GET['b_id'])) {
            $data['status'] = 200;
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
