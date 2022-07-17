<?php
if ($f == 'story_view') {
    if (!empty($_POST['id'])) {
        if (is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $story_id        = Wo_Secure($_POST['id']);
            $get_story_owner = $db->where('id', $story_id)->getValue(T_USER_STORY, 'user_id');
            $story           = $db->where('id', $story_id)->getOne(T_USER_STORY);
            $wo['story']     = ToArray($story);
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
                $wo['story']['user_data'] = $user_data = Wo_UserData($get_story_owner);
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
                $data['html']     = Wo_LoadPage('lightbox/story');
                $data['status']   = 200;
            }
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        }
    }
}
