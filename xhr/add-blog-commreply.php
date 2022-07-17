<?php 
if ($f == "add-blog-commreply") {
    $html = "";
    if (isset($_POST['text']) && isset($_POST['c_id']) && is_numeric(($_POST['c_id'])) && strlen($_POST['text']) > 2 && isset($_POST['b_id']) && is_numeric($_POST['b_id']) && $_POST['b_id'] > 0) {
        $registration_data = array(
            'comm_id' => Wo_Secure($_POST['c_id']),
            'blog_id' => Wo_Secure($_POST['b_id']),
            'user_id' => $wo['user']['id'],
            'text' => Wo_Secure($_POST['text']),
            'posted' => time()
        );
        $lastId            = Wo_RegisterBlogCommentReply($registration_data);
        if ($lastId && is_numeric($lastId)) {
            $comment = Wo_GetBlogCommentReplies(array(
                'id' => $lastId
            ));
            $main_comment = Wo_GetBlogComments(array('id' => $_POST['c_id']));
            if (!empty($main_comment) && !empty($main_comment[0])) {
                $main_comment = $main_comment[0];
            }
            if ($comment && count($comment) > 0) {
                foreach ($comment as $wo['comm-reply']) {
                    $html .= Wo_LoadPage('blog/commreplies-list');
                }
                if (!empty($main_comment) && !empty($main_comment['user_id'])) {
                    $notification_data_array = array(
                        'recipient_id' => $main_comment['user_id'],
                        'type' => 'comment_reply',
                        'blog_id' => Wo_Secure($_POST['b_id']),
                        'text' => '',
                        'url' => 'index.php?link1=read-blog&id=' . Wo_Secure($_POST['b_id'])
                    );
                    Wo_RegisterNotification($notification_data_array);
                }

                

                $data = array(
                    'status' => 200,
                    'html' => $html,
                    'comments' => Wo_GetBlogCommentsCount($_POST['b_id']),
                    'user_id' => $main_comment['user_id']
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
