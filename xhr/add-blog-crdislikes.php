<?php 
if ($f == "add-blog-crdislikes") {
    $data = array(
        'status' => 304
    );
    if (isset($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0 && isset($_POST['blog_id']) && is_numeric($_POST['blog_id']) && $_POST['blog_id'] > 0) {
        if (Wo_AddBlogCommReplyDisLikes($_POST['id'], $_POST['blog_id'])) {
            $likes            = Wo_GetBlogCommReplyLikes($_POST['id']);
            $dislikes         = Wo_GetBlogCommReplyDisLikes($_POST['id']);
            $data['status']   = 200;
            $data['likes']    = ($likes > 0) ? $likes : '';
            $data['dislikes'] = ($dislikes > 0) ? $dislikes : '';
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
