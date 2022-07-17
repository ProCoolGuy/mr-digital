<?php

$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'get_comments',
                        'add_comment',
                        'like',
                        'delete',
                        'add_reply',
                        'reply_like',
                        'reply_delete',
                        'reply_fetch'
                    );
$reactions_types = array_keys($wo['reactions_types']);
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'get_comments') {
        if (!empty($_POST['blog_id'])) {
            $blog_id = Wo_Secure($_POST['blog_id']);
            $comments = Wo_GetBlogComments(array('blog_id'=> $blog_id,
                                                 'limit' => $limit,
                                                 'offset' => $offset));
            foreach ($comments as $key2 => $comment) {
                if (!empty($comment['user_data'])) {
                    foreach ($non_allowed as $key4 => $value4) {
                      unset($comments[$key2]['user_data'][$value4]);
                    }
                }
                if (!empty($comment['replies'])) {
                    foreach ($comment['replies'] as $key => $value) {
                        foreach ($non_allowed as $key5 => $value5) {
                            unset($comments[$key2]['replies'][$key]['user_data'][$value5]);
                        }
                        $comments[$key2]['replies'][$key]['is_comment_wondered'] = false;
                        $comments[$key2]['replies'][$key]['is_comment_liked']    = false;
                        if (Wo_IsBlogCommentReplyLikeExists($comments[$key2]['replies'][$key]['id'])) {
                            $comments[$key2]['replies'][$key]['is_comment_liked']    = true;
                        }
                        if (Wo_IsBlogCommentReplyDisLikeExists($comments[$key2]['replies'][$key]['id'])) {
                            $comments[$key2]['replies'][$key]['is_comment_wondered']    = true;
                        }
                        if ($wo['config']['second_post_button'] == 'reaction') {
                            $comments[$key2]['replies'][$key]['reaction'] = Wo_GetPostReactionsTypes($comments[$key2]['replies'][$key]['id'],"reply","blog");
                        }
                    }
                }
                $comments[$key2]['is_comment_wondered'] = false;
                $comments[$key2]['is_comment_liked']    = false;
                if (Wo_IsBlogCommentLikeExists($comment['id'])) {
                    $comments[$key2]['is_comment_liked']    = true;
                }
                if (Wo_IsBlogCommentDisLikeExists($comment['id'])) {
                    $comments[$key2]['is_comment_wondered'] = true;
                }
                if ($wo['config']['second_post_button'] == 'reaction') {
                    $comments[$key2]['reaction'] = Wo_GetPostReactionsTypes($comment['id'],"comment","blog");
                }
                
            }
            $response_data = array(
                                'api_status' => 200,
                                'data' => $comments
                            );
        }
        else{
            $error_code    = 5;
            $error_message = 'blog_id can not be empty';
        }
    }
    if ($_POST['type'] == 'add_comment') {
        if (!empty($_POST['text']) && isset($_POST['blog_id']) && is_numeric(($_POST['blog_id'])) && $_POST['blog_id'] > 0) {
            $registration_data = array(
                'blog_id' => Wo_Secure($_POST['blog_id']),
                'user_id' => $wo['user']['id'],
                'text' => Wo_Secure($_POST['text']),
                'posted' => time()
            );
            $get_blog          = Wo_GetArticle($_POST['blog_id']);
            if (!empty($get_blog)) {
                $lastId = Wo_RegisterBlogComment($registration_data);
                if ($lastId && is_numeric($lastId)) {
                    $comments = Wo_GetBlogComments(array(
                        'id' => $lastId
                    ));
                    if ($comments && count($comments) > 0) {
                        foreach ($comments as $key => $value) {
                            if (!empty($value['user_data'])) {
                                foreach ($non_allowed as $key4 => $value4) {
                                  unset($comments[$key]['user_data'][$value4]);
                                }
                            }
                        }
                        $notification_data_array = array(
                            'recipient_id' => $get_blog['user'],
                            'type' => 'blog_commented',
                            'blog_id' => $lastId,
                            'text' => '',
                            'url' => 'index.php?link1=read-blog&id=' . $get_blog['id']
                        );
                        Wo_RegisterNotification($notification_data_array);

                        $response_data = array(
                                            'api_status' => 200,
                                            'data' => $comments
                                        );
                    }
                }
            }
            else{
                $error_code    = 7;
                $error_message = 'blog not found';
            }
        }
        else{
            $error_code    = 6;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'like') {
        if (isset($_POST['blog_id']) && is_numeric(($_POST['blog_id'])) && $_POST['blog_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0 && !empty($_POST['reaction_type']) && (in_array($_POST['reaction_type'], array('like','dislike')) || in_array($_POST['reaction_type'], $reactions_types)) ) {
            $blog_id = Wo_Secure($_POST['blog_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            if ($_POST['reaction_type'] == 'like') {
                Wo_AddBlogCommentLikes($comment_id, $blog_id);
                $code = 0;
                if (Wo_IsBlogCommentLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'like'
                                    );
            }
            else if($_POST['reaction_type'] == 'dislike'){
                Wo_AddBlogCommentDisLikes($comment_id, $blog_id);
                $code = 0;
                if (Wo_IsBlogCommentDisLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'dislike'
                                    );
            }
            else{
                if (Wo_IsReacted($comment_id, $wo['user']['user_id'],'comment','blog') == true) {
                    $db->where('user_id',$wo['user']['user_id'])->where('comment_id',$comment_id)->delete(T_BLOG_REACTION);
                    $db->where('notifier_id',$wo['user']['user_id'])->where('comment_id',$comment_id)->where('type','reaction')->delete(T_NOTIFICATION);
                    $response_data = array(
                                    'api_status' => 200,
                                    'message' => "reaction successfully deleted."
                                );
                }
                else{
                    if (Wo_AddCommentBlogReactions($comment_id, $_POST['reaction_type']) == 'reacted') {
                        $comment = $db->where('id', $comment_id)->getOne(T_BLOG_COMM);
                        $response_data = array(
                            'api_status' => 200,
                            'reactions' => Wo_GetPostReactions($comment_id, "comment",'blog'),
                            'like_lang' => 'reacted',
                            'user_id' => $comment->user_id
                        );
                    }
                }
            }
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'delete') {
        if (isset($_POST['blog_id']) && is_numeric(($_POST['blog_id'])) && $_POST['blog_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0) {
            $blog_id = Wo_Secure($_POST['blog_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            Wo_DeleteBlogComment($comment_id, $blog_id);
            $response_data = array(
                                    'api_status' => 200
                                );
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'add_reply') {

        if (isset($_POST['text']) && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0 && strlen($_POST['text']) > 2 && isset($_POST['blog_id']) && is_numeric($_POST['blog_id']) && $_POST['blog_id'] > 0) {
            $registration_data = array(
                'comm_id' => Wo_Secure($_POST['comment_id']),
                'blog_id' => Wo_Secure($_POST['blog_id']),
                'user_id' => $wo['user']['id'],
                'text' => Wo_Secure($_POST['text']),
                'posted' => time()
            );
            $lastId            = Wo_RegisterBlogCommentReply($registration_data);
            if ($lastId && is_numeric($lastId)) {
                $comments = Wo_GetBlogCommentReplies(array(
                    'id' => $lastId
                ));

                if ($comments && count($comments) > 0) {
                    foreach ($comments as $key => $value) {
                        if (!empty($value['user_data'])) {
                            foreach ($non_allowed as $key4 => $value4) {
                              unset($comments[$key]['user_data'][$value4]);
                            }
                        }
                    }

                    $response_data = array(
                                        'api_status' => 200,
                                        'data' => $comments
                                    );
                }
            }
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'reply_like') {
        if (isset($_POST['blog_id']) && is_numeric(($_POST['blog_id'])) && $_POST['blog_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0 && !empty($_POST['reaction_type']) && (in_array($_POST['reaction_type'], array('like','dislike')) || in_array($_POST['reaction_type'], $reactions_types))) {

            $blog_id = Wo_Secure($_POST['blog_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            if ($_POST['reaction_type'] == 'like') {
                Wo_AddBlogCommReplyLikes($comment_id, $blog_id);
                $code = 0;
                if (Wo_IsBlogCommentReplyLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'like'
                                    );
            }
            else if($_POST['reaction_type'] == 'dislike'){
                Wo_AddBlogCommReplyDisLikes($comment_id, $blog_id);
                $code = 0;
                if (Wo_IsBlogCommentReplyDisLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'dislike'
                                    );
            }
            else{
                if (Wo_IsReacted($comment_id, $wo['user']['user_id'],'reply','blog') == true) {
                    $db->where('user_id',$wo['user']['user_id'])->where('reply_id',$comment_id)->delete(T_BLOG_REACTION);
                    $db->where('notifier_id',$wo['user']['user_id'])->where('reply_id',$comment_id)->where('type','reaction')->delete(T_NOTIFICATION);
                    $response_data = array(
                                    'api_status' => 200,
                                    'message' => "reaction successfully deleted."
                                );
                }
                else{
                    if (Wo_AddBlogReplyReactions(0, $comment_id, $_POST['reaction_type']) == 'reacted') {
                        $comment = $db->where('id', $comment_id)->getOne(T_BLOG_COMM_REPLIES);
                        $response_data = array(
                            'api_status' => 200,
                            'reactions' => Wo_GetPostReactions($comment_id, "reply",'blog'),
                            'like_lang' => 'reacted',
                            'user_id' => $comment->user_id
                        );
                    }
                }
            }
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'reply_delete') {
        if (isset($_POST['blog_id']) && is_numeric(($_POST['blog_id'])) && $_POST['blog_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0) {
            $blog_id = Wo_Secure($_POST['blog_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            Wo_DeleteBlogCommReply($comment_id, $blog_id);
            $response_data = array(
                                    'api_status' => 200
                                );
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'reply_fetch') {
        if (isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0) {
            $comment_id = Wo_Secure($_POST['comment_id']);
            $comments = Wo_GetBlogCommentReplies(array(
                                                    'comm_id' => $comment_id,
                                                    'limit'   => $limit,
                                                    'offset'  => $offset
                                                ));
            if ($comments && count($comments) > 0) {
                foreach ($comments as $key => $value) {
                    if (!empty($value['user_data'])) {
                        foreach ($non_allowed as $key4 => $value4) {
                          unset($comments[$key]['user_data'][$value4]);
                        }
                    }
                    $comments[$key]['is_comment_wondered'] = false;
                    $comments[$key]['is_comment_liked']    = false;
                    if (Wo_IsBlogCommentReplyLikeExists($value['id'])) {
                        $comments[$key]['is_comment_liked']    = true;
                    }
                    if (Wo_IsBlogCommentReplyDisLikeExists($value['id'])) {
                        $comments[$key]['is_comment_wondered'] = true;
                    }
                    if ($wo['config']['second_post_button'] == 'reaction') {
                        $comments[$key]['reaction'] = Wo_GetPostReactionsTypes($value['id'],"reply","blog");
                    }
                }

                
            }
            $response_data = array(
                                    'api_status' => 200,
                                    'data' => $comments
                                );
        }
        else{
            $error_code    = 8;
            $error_message = 'comment_id can not be empty';
        }

    }

}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}