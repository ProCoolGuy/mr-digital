<?php
if ($f == 'live') {
    if ($s == 'create') {
        if (empty($_POST['stream_name'])) {
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        } else {
            $postPrivacy   = 0;
            $privacy_array = array(
                '0',
                '1',
                '2',
                '3',
                '4'
            );
            if (!empty($_COOKIE['post_privacy']) && in_array($_COOKIE['post_privacy'], $privacy_array)) {
                $postPrivacy = Wo_Secure($_COOKIE['post_privacy']);
            }
            $token = null;
            if (!empty($_POST['token']) && !is_null($_POST['token'])) {
                $token = Wo_Secure($_POST['token']);
            }
            $post_id = $db->insert(T_POSTS, array(
                'user_id' => $wo['user']['id'],
                'postText' => '',
                'postType' => 'live',
                'postPrivacy' => $postPrivacy,
                'agora_token' => $token,
                'stream_name' => Wo_Secure($_POST['stream_name']),
                'time' => time()
            ));
            $db->where('id', $post_id)->update(T_POSTS, array(
                'post_id' => $post_id
            ));
            if ($wo['config']['agora_live_video'] == 1 && !empty($wo['config']['agora_app_id']) && !empty($wo['config']['agora_customer_id']) && !empty($wo['config']['agora_customer_certificate']) && $wo['config']['live_video_save'] == 1) {
                if ($wo['config']['amazone_s3_2'] == 1 && !empty($wo['config']['bucket_name_2']) && !empty($wo['config']['amazone_s3_key_2']) && !empty($wo['config']['amazone_s3_s_key_2']) && !empty($wo['config']['region_2'])) {
                    $region_array = array(
                        'us-east-1' => 0,
                        'us-east-2' => 1,
                        'us-west-1' => 2,
                        'us-west-2' => 3,
                        'eu-west-1' => 4,
                        'eu-west-2' => 5,
                        'eu-west-3' => 6,
                        'eu-central-1' => 7,
                        'ap-southeast-1' => 8,
                        'ap-southeast-2' => 9,
                        'ap-northeast-1' => 10,
                        'ap-northeast-2' => 11,
                        'sa-east-1' => 12,
                        'ca-central-1' => 13,
                        'ap-south-1' => 14,
                        'cn-north-1' => 15,
                        'us-gov-west-1' => 17
                    );
                    if (in_array(strtolower($wo['config']['region_2']), array_keys($region_array))) {
                        StartCloudRecording(1, $region_array[strtolower($wo['config']['region_2'])], $wo['config']['bucket_name_2'], $wo['config']['amazone_s3_key_2'], $wo['config']['amazone_s3_s_key_2'], $_POST['stream_name'], 12, $post_id, $token);
                    }
                }
            }
            Wo_notifyUsersLive($post_id);
            $data['status']  = 200;
            $data['post_id'] = $post_id;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'check_comments') {
        if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0) {
            $post_id   = Wo_Secure($_POST['post_id']);
            $post_data = $db->where('id', $post_id)->getOne(T_POSTS);
            if (!empty($post_data)) {
                if ($post_data->live_ended == 0) {
                    $user_comment = $db->where('post_id', $post_id)->where('user_id', $wo['user']['id'])->getOne(T_COMMENTS);
                    if (!empty($user_comment)) {
                        $db->where('id', $user_comment->id, '>');
                    }
                    if (!empty($_POST['ids'])) {
                        $ids = array();
                        foreach ($_POST['ids'] as $key => $one_id) {
                            $ids[] = Wo_Secure($one_id);
                        }
                        $db->where('id', $ids, 'NOT IN')->where('id', end($ids), '>');
                    }
                    $db->where('user_id', $wo['user']['id'], '!=');
                    $comments = $db->where('post_id', $post_id)->where('text', '', '!=')->get(T_COMMENTS);
                    $html     = '';
                    $count    = 0;
                    foreach ($comments as $key => $value) {
                        if (!empty($value->text)) {
                            $wo['comment'] = Wo_GetPostComment($value->id);
                            $html .= Wo_LoadPage('story/includes/live_comment');
                            $count = $count + 1;
                            if ($count == 4) {
                                break;
                            }
                        }
                    }
                    $word = $wo['lang']['offline'];
                    if (!empty($post_data->live_time) && $post_data->live_time >= (time() - 10)) {
                        $word  = $wo['lang']['live'];
                        $count = $db->where('post_id', $post_id)->where('time', time() - 6, '>=')->getValue(T_LIVE_SUB, 'COUNT(*)');
                        if ($wo['user']['id'] == $post_data->user_id) {
                            $joined_users = $db->where('post_id', $post_id)->where('time', time() - 6, '>=')->where('is_watching', 0)->get(T_LIVE_SUB);
                            $joined_ids   = array();
                            if (!empty($joined_users)) {
                                foreach ($joined_users as $key => $value) {
                                    $joined_ids[]  = $value->user_id;
                                    $wo['comment'] = array(
                                        'id' => '',
                                        'text' => 'joined live video'
                                    );
                                    $user_data     = Wo_UserData($value->user_id);
                                    if (!empty($user_data)) {
                                        $wo['comment']['publisher'] = $user_data;
                                        $html .= Wo_LoadPage('story/includes/live_comment');
                                    }
                                }
                                if (!empty($joined_ids)) {
                                    $db->where('post_id', $post_id)->where('user_id', $joined_ids, 'IN')->update(T_LIVE_SUB, array(
                                        'is_watching' => 1
                                    ));
                                }
                            }
                            $left_users = $db->where('post_id', $post_id)->where('time', time() - 6, '<')->where('is_watching', 1)->get(T_LIVE_SUB);
                            $left_ids   = array();
                            if (!empty($left_users)) {
                                foreach ($left_users as $key => $value) {
                                    $left_ids[]    = $value->user_id;
                                    $wo['comment'] = array(
                                        'id' => '',
                                        'text' => 'left live video'
                                    );
                                    $user_data     = Wo_UserData($value->user_id);
                                    if (!empty($user_data)) {
                                        $wo['comment']['publisher'] = $user_data;
                                        $html .= Wo_LoadPage('story/includes/live_comment');
                                    }
                                }
                                if (!empty($left_ids)) {
                                    $db->where('post_id', $post_id)->where('user_id', $left_ids, 'IN')->delete(T_LIVE_SUB);
                                }
                            }
                        }
                    }
                    $still_live = 'offline';
                    if (!empty($post_data) && $post_data->live_time >= (time() - 10)) {
                        $still_live = 'live';
                    }
                    $data = array(
                        'status' => 200,
                        'html' => $html,
                        'count' => $count,
                        'word' => $word,
                        'still_live' => $still_live
                    );
                    if ($wo['user']['id'] == $post_data->user_id) {
                        if ($_POST['page'] == 'live') {
                            $time = time();
                            $db->where('id', $post_id)->update(T_POSTS, array(
                                'live_time' => $time
                            ));
                            $db->where('parent_id', $post_id)->update(T_POSTS, array(
                                'live_time' => $time
                            ));
                        }
                    } else {
                        if (!empty($post_data->live_time) && $post_data->live_time >= (time() - 10) && $_POST['page'] == 'story') {
                            $is_watching = $db->where('user_id', $wo['user']['id'])->where('post_id', $post_id)->getValue(T_LIVE_SUB, 'COUNT(*)');
                            if ($is_watching > 0) {
                                $db->where('user_id', $wo['user']['id'])->where('post_id', $post_id)->update(T_LIVE_SUB, array(
                                    'time' => time()
                                ));
                            } else {
                                $db->insert(T_LIVE_SUB, array(
                                    'user_id' => $wo['user']['id'],
                                    'post_id' => $post_id,
                                    'time' => time(),
                                    'is_watching' => 0
                                ));
                            }
                        }
                    }
                } else {
                    $data['message'] = $error_icon . $wo['lang']['please_check_details'];
                }
            } else {
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
                $data['removed'] = 'yes';
            }
        } else {
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'delete') {
        if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0) {
            $db->where('post_id', Wo_Secure($_POST['post_id']))->where('user_id', $wo['user']['id'])->update(T_POSTS, array(
                'live_ended' => 1
            ));
            if ($wo['config']['live_video_save'] == 0) {
                Wo_DeletePost(Wo_Secure($_POST['post_id']));
            } else {
                if ($wo['config']['agora_live_video'] == 1 && !empty($wo['config']['agora_app_id']) && !empty($wo['config']['agora_customer_id']) && !empty($wo['config']['agora_customer_certificate']) && $wo['config']['live_video_save'] == 1) {
                    $post = $db->where('post_id', Wo_Secure($_POST['post_id']))->getOne(T_POSTS);
                    if (!empty($post)) {
                        StopCloudRecording(array(
                            'resourceId' => $post->agora_resource_id,
                            'sid' => $post->agora_sid,
                            'cname' => $post->stream_name,
                            'post_id' => $post->post_id,
                            'token' => $post->agora_token,
                            'uid' => 12
                        ));
                    }
                }
                if ($wo['config']['agora_live_video'] == 1 && $wo['config']['amazone_s3_2'] != 1) {
                    try {
                        Wo_DeletePost(Wo_Secure($_POST['post_id']));
                    }
                    catch (Exception $e) {
                    }
                }
            }
        }
    }
    if ($s == 'create_thumb') {
        if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0 && !empty($_FILES['thumb'])) {
            $is_post = $db->where('post_id', Wo_Secure($_POST['post_id']))->where('user_id', $wo['user']['id'])->getValue(T_POSTS, 'COUNT(*)');
            if ($is_post > 0) {
                $fileInfo = array(
                    'file' => $_FILES["thumb"]["tmp_name"],
                    'name' => $_FILES['thumb']['name'],
                    'size' => $_FILES["thumb"]["size"],
                    'type' => $_FILES["thumb"]["type"],
                    'types' => 'jpeg,png,jpg,gif',
                    'crop' => array(
                        'width' => 525,
                        'height' => 295
                    )
                );
                $media    = Wo_ShareFile($fileInfo);
                if (!empty($media)) {
                    $thumb = $media['filename'];
                    if (!empty($thumb)) {
                        $db->where('post_id', Wo_Secure($_POST['post_id']))->where('user_id', $wo['user']['id'])->update(T_POSTS, array(
                            'postFileThumb' => $thumb
                        ));
                        $data['status'] = 200;
                        header("Content-type: application/json");
                        echo json_encode($data);
                        exit();
                    }
                }
            }
        }
    }
}
