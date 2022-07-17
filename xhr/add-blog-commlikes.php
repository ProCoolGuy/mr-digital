<?php 
if ($f == "add-blog-commlikes") {
    $data = array(
        'status' => 304
    );
    if (isset($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0 && isset($_POST['blog_id']) && is_numeric($_POST['blog_id']) && $_POST['blog_id'] > 0) {
        $blogCommentLikes = Wo_AddBlogCommentLikes($_POST['id'], $_POST['blog_id']);
        $likes            = Wo_GetBlogCommLikes($_POST['id']);
        $dislikes         = Wo_GetBlogCommDisLikes($_POST['id']);
        if ($blogCommentLikes == true) {
            $data['status']   = 200;
            $data['likes']    = ($likes > 0) ? $likes : '';
            $data['dislikes'] = ($dislikes > 0) ? $dislikes : '';
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
