<?php 
if ($f == "add-blog-comm") {
    $html = "";
    if (isset($_POST['text']) && isset($_POST['blog']) && is_numeric(($_POST['blog'])) && strlen($_POST['text']) > 2) {
        $registration_data = array(
            'blog_id' => Wo_Secure($_POST['blog']),
            'user_id' => $wo['user']['id'],
            'text' => Wo_Secure($_POST['text']),
            'posted' => time()
        );
        $get_blog          = Wo_GetArticle($_POST['blog']);
        if (empty($get_blog)) {
            exit();
        }
        $lastId = Wo_RegisterBlogComment($registration_data);
        if ($lastId && is_numeric($lastId)) {
            $comment = Wo_GetBlogComments(array(
                'id' => $lastId
            ));
            if ($comment && count($comment) > 0) {
                foreach ($comment as $wo['comment']) {
                    $html .= Wo_LoadPage('blog/comment-list');
                }
                $notification_data_array = array(
                    'recipient_id' => $get_blog['user'],
                    'type' => 'blog_commented',
                    'blog_id' => $lastId,
                    'text' => '',
                    'url' => 'index.php?link1=read-blog&id=' . $get_blog['id']
                );
                Wo_RegisterNotification($notification_data_array);
                $data = array(
                    'status' => 200,
                    'html' => $html,
                    'comments' => Wo_GetBlogCommentsCount($_POST['blog']),
                    'user_id' => $get_blog['user']
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
