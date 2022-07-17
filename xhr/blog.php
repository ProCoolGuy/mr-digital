<?php
if ($f == 'blog') {
    $data['status'] = 400;
    if ($s == 'register_blog_comment_reaction') {
        if (!empty($_GET['comment_id']) && !empty($_GET['reaction']) && Wo_CheckMainSession($hash_id) === true) {
            if (Wo_AddCommentBlogReactions($_GET['comment_id'], $_GET['reaction']) == 'reacted') {
                $comment = $db->where('id', Wo_Secure($_GET['comment_id']))->getOne(T_BLOG_COMM);
                $data    = array(
                    'status' => 200,
                    'reactions' => Wo_GetPostReactions($_GET['comment_id'], "comment", 'blog'),
                    'like_lang' => $wo['lang']['liked'],
                    'user_id' => $comment->user_id
                );
                if (Wo_CanSenEmails()) {
                    $data['can_send'] = 1;
                }
            }
            $data['dislike'] = 0;
        }
    }
    if ($s == 'register_reply_reaction') {
        if (!empty($_GET['reply_id']) && !empty($_GET['reaction']) && Wo_CheckMainSession($hash_id) === true) {
            if (Wo_AddBlogReplyReactions($_GET['user_id'], $_GET['reply_id'], $_GET['reaction']) == 'reacted') {
                $comment = $db->where('id', Wo_Secure($_GET['reply_id']))->getOne(T_BLOG_COMM_REPLIES);
                $data    = array(
                    'status' => 200,
                    'reactions' => Wo_GetPostReactions($_GET['reply_id'], "reply", 'blog'),
                    'like_lang' => $wo['lang']['liked'],
                    'user_id' => $comment->user_id
                );
                if (Wo_CanSenEmails()) {
                    $data['can_send'] = 1;
                }
            }
            $data['dislike'] = 0;
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
