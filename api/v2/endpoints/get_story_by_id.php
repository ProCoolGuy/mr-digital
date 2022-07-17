<?php
if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
	$id = Wo_Secure($_POST['id']);
	$story = $db->where('id',$id)->getOne(T_USER_STORY);

	$story_images              = Wo_GetStoryMedia($story->id, 'image');
	if (count($story_images) > 0) {
        $story->thumb  = array_shift($story_images);
        $story->images = $story_images;
    }
    $user_data = Wo_UserData($story->user_id);
    foreach ($non_allowed as $key => $value) {
       unset($user_data[$value]);
    }
    $story->user_data = $user_data;
    if (empty($story->thumbnail)) {
        $story->thumb['filename'] = $story->user_data['avatar_org'];
    } else {
        $story->thumb             = array();
        $story->thumb['filename'] = $story->thumbnail;
    }
    $story->thumb['filename'] = Wo_GetMedia($story->thumb['filename']);
    $story->videos            = Wo_GetStoryMedia($story->id, 'video');
    $story->is_owner          = ($story->user_id == $wo['user']['id'] || Wo_IsAdmin() || Wo_IsModerator()) ? true : false;

    $is_viewed = $db->where('story_id',$id)->where('user_id',$wo['user']['user_id'])->getValue(T_STORY_SEEN,'COUNT(*)');
    if ($is_viewed == 0) {
        $db->insert(T_STORY_SEEN,array('story_id' => $id,
                                          'user_id' => $wo['user']['user_id'],
                                          'time' => time()));
        if (!empty($user_data) && $user_data['user_id'] != $wo['user']['user_id']) {
            $notification_data_array = array(
                'recipient_id' => $user_data['user_id'],
                'type' => 'viewed_story',
                'story_id' => $id,
                'text' => '',
                'url' => 'index.php?link1=timeline&u=' . $wo['user']['username'] . '&story=true&story_id=' . $id
            );
            Wo_RegisterNotification($notification_data_array);
        }
    }
    $story->view_count = $db->where('story_id',$id)->where('user_id',$story->user_id,'!=')->getValue(T_STORY_SEEN,'COUNT(*)');
    $response_data = array(
	    'api_status' => 200,
	    'story' => $story
	);
}
else{
	$error_code    = 4;
    $error_message = 'id can not be empty';
}