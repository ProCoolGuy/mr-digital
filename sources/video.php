<?php
if ($wo['loggedin'] == false) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if (empty($_GET['call_id'])) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if ($wo['config']['video_chat'] == 0) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
$id = Wo_Secure($_GET['call_id']);
if ($wo['config']['agora_chat_video'] == 1) {
    $wo['video_call'] = array();
    $call             = $db->where('room_name', $id)->where('(to_id = ' . $wo['user']['id'] . ' OR from_id = ' . $wo['user']['id'] . ')')->getOne(T_AGORA);
    if (!empty($call)) {
        $wo['video_call']['room']         = $call->room_name;
        $wo['video_call']['access_token'] = $call->access_token;
    } else {
        header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
        exit();
    }
} else {
    $data2 = Wo_GetAllDataFromCallID($id);
    if (!$data2) {
        header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
        exit();
    }
    $wo['video_call'] = $data2;
    if ($wo['video_call']['to_id'] == $wo['user']['user_id']) {
        $wo['video_call']['user']         = 1;
        $wo['video_call']['access_token'] = $wo['video_call']['access_token'];
        $wo['video_call']['call_id']      = $wo['video_call']['id'];
    } else if ($wo['video_call']['from_id'] == $wo['user']['user_id']) {
        $wo['video_call']['user']         = 2;
        $wo['video_call']['access_token'] = $wo['video_call']['access_token_2'];
        $wo['video_call']['call_id']      = $wo['video_call']['id'];
    } else {
        header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
        exit();
    }
    $user_1                   = Wo_UserData($wo['video_call']['from_id']);
    $user_2                   = Wo_UserData($wo['video_call']['to_id']);
    $wo['video_call']['room'] = $wo['video_call']['room_name'];
    if ($wo['video_call']['from_id'] == $wo['user']['user_id']) {
        $user_id = Wo_Secure($wo['user']['user_id']);
    }
}
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'video';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('video/content');
?>
