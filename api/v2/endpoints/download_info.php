<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data = array(
    'api_status' => 400
);
$types = array('posts','pages','groups','followers','following','my_information','friends');
if (empty($_POST['data'])) {
    $error_code    = 3;
    $error_message = 'data (POST) is missing';
}
else{
	$fetch = explode(',', $_POST['data']);
	$data  = array();
    foreach ($fetch as $key => $value) {
        $data[$value] = $value;
    }
}

if (!empty($data)) {
    if (!empty($wo['user']['info_file'])) {
        unlink($wo['user']['info_file']);
    }
    $wo['user_info'] = array();
    $html = '';
    if (!empty($data['my_information'])) {
        $wo['user_info']['setting'] = Wo_UserData($wo['user']['user_id']);
        $wo['user_info']['setting']['session'] = Wo_GetAllSessionsFromUserID($wo['user']['user_id']);
        $wo['user_info']['setting']['block'] = Wo_GetBlockedMembers($wo['user']['user_id']);
        $wo['user_info']['setting']['trans'] = Wo_GetMytransactions();
        $wo['user_info']['setting']['refs'] = Wo_GetReferrers();
    }
    if (!empty($data['posts'])) {
        $wo['user_info']['posts'] = Wo_GetPosts(array('filter_by' => 'all','publisher_id' => $wo['user']['user_id'],'limit' => 100000)); 
    }
    if (!empty($data['pages']) && $wo['config']['pages'] == 1) {
        $wo['user_info']['pages'] = Wo_GetMyPages();
    }
    if (!empty($data['groups']) && $wo['config']['groups'] == 1) {
        $wo['user_info']['groups'] = Wo_GetMyGroups();
    }
    if ($wo['config']['connectivitySystem'] == 0) {
        if (!empty($data['followers'])) {
            $wo['user_info']['followers'] = Wo_GetFollowers($wo['user']['user_id'],'profile',1000000);
        }
        if (!empty($data['following'])) {
            $wo['user_info']['following'] = Wo_GetFollowing($wo['user']['user_id'], 'profile',1000000);
        }
    }
    else{
        if (!empty($data['friends'])) {
            $wo['user_info']['friends'] = Wo_GetMutualFriends($wo['user']['user_id'],'profile', 1000000);
        }
    }
        
    $html = Wo_LoadPage('user_info/content');

    if (!file_exists('upload/files/' . date('Y'))) {
        @mkdir('upload/files/' . date('Y'), 0777, true);
    }
    if (!file_exists('upload/files/' . date('Y') . '/' . date('m'))) {
        @mkdir('upload/files/' . date('Y') . '/' . date('m'), 0777, true);
    }
    $folder   = 'files';
    $fileType = 'file';
    $dir         = "upload/files/" . date('Y') . '/' . date('m');
    $hash    = $dir . '/' . Wo_GenerateKey() . '_' . date('d') . '_' . md5(time()) . "_file.html";
    $file = fopen($hash, 'w');
    fwrite($file, $html);
    fclose($file);
    Wo_UpdateUserData($wo['user']['user_id'], array(
        'info_file' => $hash
    ));
    $response_data['message'] = $wo['lang']['file_ready'];
    $response_data['link'] = $wo['config']['site_url'] . '/' . $hash;
    $response_data['api_status'] = 200;
}
else{
	$error_code    = 6;
    $error_message = 'please check details';
}