<?php
if ($f == 'view_story_by_id') {
    $data['status'] = 400;
    $types          = array(
        'next',
        'previous',
        'current'
    );
    if (!empty($_POST['story_id']) && is_numeric($_POST['story_id']) && $_POST['story_id'] > 0 && !empty($_POST['type']) && in_array($_POST['type'], $types)) {
        $data['story_id'] = 0;
        $main_story       = $db->where('id', Wo_Secure($_POST['story_id']))->getOne(T_USER_STORY);
        if (!empty($main_story)) {
            if ($_POST['type'] == 'previous') {
                $story = $db->where('id', Wo_Secure($_POST['story_id']), '>')->where('user_id', $main_story->user_id)->orderBy('id', "ASC")->getOne(T_USER_STORY);
                if (!empty($story) && !empty($story->id)) {
                    $data['story_id'] = $story->id;
                }
                if (empty($story) && !empty($_POST['story_type']) && $_POST['story_type'] == 'friends') {
                    $all_stories   = Wo_GetAllStatus();
                    $next_story_id = 0;
                    $n_ids         = array();
                    for ($i = 0; $i < count($all_stories); $i++) {
                        if ($i > 0 && $all_stories[$i]->user_id == $main_story->user_id) {
                            $next_story_id = $all_stories[$i - 1]->id;
                            break;
                        }
                    }
                    if ($next_story_id > 0) {
                        $story            = $db->where('id', $next_story_id)->getOne(T_USER_STORY);
                        $data['story_id'] = $story->id;
                    }
                }
            } else if ($_POST['type'] == 'next') {
                $story = $db->where('id', Wo_Secure($_POST['story_id']), '<')->where('user_id', $main_story->user_id)->orderBy('id', "Desc")->getOne(T_USER_STORY);
                if (!empty($story) && !empty($story->id)) {
                    $data['story_id'] = $story->id;
                }
                if (empty($story) && !empty($_POST['story_type']) && $_POST['story_type'] == 'friends') {
                    $all_stories   = Wo_GetAllStatus();
                    $next_story_id = 0;
                    $n_ids         = array();
                    for ($i = 0; $i < count($all_stories); $i++) {
                        if ($i < count($all_stories) && $all_stories[$i]->user_id == $main_story->user_id) {
                            if (!empty($all_stories[$i + 1])) {
                                $next_story_id = $all_stories[$i + 1]->id;
                            }
                            break;
                        }
                    }
                    if ($next_story_id > 0) {
                        $story            = $db->where('id', $next_story_id)->getOne(T_USER_STORY);
                        $data['story_id'] = $story->id;
                    }
                }
            } else {
                $story = $db->where('id', Wo_Secure($_POST['story_id']))->getOne(T_USER_STORY);
                if (!empty($story) && !empty($story->id)) {
                    $data['story_id'] = $story->id;
                }
            }
            if (!empty($story) && !empty($story->id)) {
                $story_id = $story->id;
            }
            $wo['story'] = ToArray($story);
            if (!empty($story)) {
                $story_media = Wo_GetStoryMedia($story_id, 'image');
                if (empty($story_media)) {
                    $story_media = Wo_GetStoryMedia($story_id, 'video');
                }
                $wo['story']['story_media'] = $story_media;
                $wo['story']['view_count']  = $db->where('story_id', $story_id)->where('user_id', $story->user_id, '!=')->getValue(T_STORY_SEEN, 'COUNT(*)');
                $story_views                = $db->where('story_id', $story_id)->where('user_id', $story->user_id, '!=')->get(T_STORY_SEEN, 10);
                if (!empty($story_views)) {
                    foreach ($story_views as $key => $value) {
                        $user_                        = Wo_UserData($value->user_id);
                        $user_['id']                  = $value->id;
                        $wo['story']['story_views'][] = $user_;
                    }
                }
                $wo['story']['is_owner']  = false;
                $wo['story']['user_data'] = $user_data = Wo_UserData($story->user_id);
                if ($user_data['user_id'] == $wo['user']['user_id']) {
                    $wo['story']['is_owner'] = true;
                }
                $is_viewed = $db->where('story_id', $story_id)->where('user_id', $wo['user']['user_id'])->getValue(T_STORY_SEEN, 'COUNT(*)');
                if ($is_viewed == 0) {
                    $db->insert(T_STORY_SEEN, array(
                        'story_id' => $story_id,
                        'user_id' => $wo['user']['user_id'],
                        'time' => time()
                    ));
                    if (!empty($user_data) && $user_data['user_id'] != $wo['user']['user_id']) {
                        $notification_data_array = array(
                            'recipient_id' => $user_data['user_id'],
                            'type' => 'viewed_story',
                            'story_id' => $story_id,
                            'text' => '',
                            'url' => 'index.php?link1=timeline&u=' . $wo['user']['username'] . '&story=true&story_id=' . $story_id
                        );
                        Wo_RegisterNotification($notification_data_array);
                    }
                }
                $data['story_id'] = $story_id;
                $wo['story_type'] = $_POST['story_type'];
                $data['html']     = Wo_LoadPage('lightbox/story');
                $data['status']   = 200;
            }
        }
    }
    Wo_CleanCache();
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
