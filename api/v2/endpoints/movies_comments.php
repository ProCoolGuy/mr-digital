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

$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'get_comments') {

        if (!empty($_POST['movie_id']) && is_numeric($_POST['movie_id']) && $_POST['movie_id'] > 0) {
            $movie_id = Wo_Secure($_POST['movie_id']);
            $comments = Wo_GetMovieComments(array('movie_id' => $movie_id,
                                                  'limit'    => $limit,
                                                  'offset'   => $offset));
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
                        if (Wo_IsMovieCommentReplyLikeExists($comments[$key2]['replies'][$key]['id'])) {
                            $comments[$key2]['replies'][$key]['is_comment_liked']    = true;
                        }
                        if (Wo_IsMovieCommentReplyDisLikeExists($comments[$key2]['replies'][$key]['id'])) {
                            $comments[$key2]['replies'][$key]['is_comment_wondered']    = true;
                        }
                    }
                }

                $comments[$key2]['is_comment_wondered'] = false;
                $comments[$key2]['is_comment_liked']    = false;
                if (Wo_IsMovieCommentLikeExists($comment['id'])) {
                    $comments[$key2]['is_comment_liked']    = true;
                }
                if (Wo_IsMovieCommentDisLikeExists($comment['id'])) {
                    $comments[$key2]['is_comment_wondered'] = true;
                }
            }
            $response_data = array(
                                'api_status' => 200,
                                'data' => $comments
                            );
        }
        else{
            $error_code    = 5;
            $error_message = 'movie_id can not be empty';
        }
    }
    if ($_POST['type'] == 'add_comment') {
        if (!empty($_POST['text']) && isset($_POST['movie_id']) && is_numeric(($_POST['movie_id'])) && $_POST['movie_id'] > 0) {
            $registration_data = array(
                'movie_id' => Wo_Secure($_POST['movie_id']),
                'user_id' => $wo['user']['id'],
                'text' => Wo_Secure($_POST['text']),
                'posted' => time()
            );
            $lastId            = Wo_RegisterMovieComment($registration_data);
            if ($lastId && is_numeric($lastId)) {
                $comments = Wo_GetMovieComments(array(
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
            $error_code    = 6;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'like') {
        if (isset($_POST['movie_id']) && is_numeric(($_POST['movie_id'])) && $_POST['movie_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0 && !empty($_POST['reaction_type']) && in_array($_POST['reaction_type'], array('like','dislike'))) {
            $movie_id = Wo_Secure($_POST['movie_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            if ($_POST['reaction_type'] == 'like') {
                Wo_AddMovieCommentLikes($comment_id, $movie_id);
                $code = 0;
                if (Wo_IsMovieCommentLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'like'
                                    );
            }
            else{
                Wo_AddMovieCommentDisLikes($comment_id, $movie_id);
                $code = 0;
                if (Wo_IsMovieCommentDisLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'dislike'
                                    );
            }
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'delete') {
        if (isset($_POST['movie_id']) && is_numeric(($_POST['movie_id'])) && $_POST['movie_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0) {
            $movie_id = Wo_Secure($_POST['movie_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            Wo_DeleteMovieComment($comment_id, $movie_id);
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

        if (isset($_POST['text']) && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0 && strlen($_POST['text']) > 2 && isset($_POST['movie_id']) && is_numeric($_POST['movie_id']) && $_POST['movie_id'] > 0) {

            $registration_data = array(
                'comm_id' => Wo_Secure($_POST['comment_id']),
                'movie_id' => Wo_Secure($_POST['movie_id']),
                'user_id' => $wo['user']['id'],
                'text' => Wo_Secure($_POST['text']),
                'posted' => time()
            );
            $lastId            = Wo_RegisterMovieCommentReply($registration_data);
            if ($lastId && is_numeric($lastId)) {
                $comments = Wo_GetMovieCommentReplies(array(
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
        if (isset($_POST['movie_id']) && is_numeric(($_POST['movie_id'])) && $_POST['movie_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0 && !empty($_POST['reaction_type']) && in_array($_POST['reaction_type'], array('like','dislike'))) {

            $movie_id = Wo_Secure($_POST['movie_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            if ($_POST['reaction_type'] == 'like') {
                Wo_AddMovieCommReplyLikes($comment_id, $movie_id);
                $code = 0;
                if (Wo_IsMovieCommentReplyLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'like'
                                    );
            }
            else{
                Wo_AddMovieCommReplyDisLikes($comment_id, $movie_id);
                $code = 0;
                if (Wo_IsMovieCommentReplyDisLikeExists($comment_id)) {
                    $code = 1;
                }
                $response_data = array(
                                        'api_status' => 200,
                                        'code' => $code,
                                        'type' => 'dislike'
                                    );
            }
        }
        else{
            $error_code    = 7;
            $error_message = 'Please check your details';
        }
    }
    if ($_POST['type'] == 'reply_delete') {
        if (isset($_POST['movie_id']) && is_numeric(($_POST['movie_id'])) && $_POST['movie_id'] > 0 && isset($_POST['comment_id']) && is_numeric(($_POST['comment_id'])) && $_POST['comment_id'] > 0) {
            $movie_id = Wo_Secure($_POST['movie_id']);
            $comment_id = Wo_Secure($_POST['comment_id']);
            Wo_DeleteMovieCommReply($comment_id, $movie_id);
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
            $comments = Wo_GetMovieCommentReplies(array(
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
                    if (Wo_IsMovieCommentReplyLikeExists($value['id'])) {
                        $comments[$key]['is_comment_liked']    = true;
                    }
                    if (Wo_IsMovieCommentReplyDisLikeExists($value['id'])) {
                        $comments[$key]['is_comment_wondered'] = true;
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