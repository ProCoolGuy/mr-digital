<?php 
if ($f == 'download_info') {
    $data['status'] = 400;
    if (!empty($_POST['posts']) || !empty($_POST['pages']) || !empty($_POST['groups']) || !empty($_POST['followers']) || !empty($_POST['following']) || !empty($_POST['my_information']) || !empty($_POST['friends'])) {
        if (!empty($wo['user']['info_file'])) {
            unlink($wo['user']['info_file']);
        }
        $wo['user_info'] = array();
        $html = '';
        if (!empty($_POST['my_information'])) {
            $wo['user_info']['setting'] = Wo_UserData($wo['user']['user_id']);
            $wo['user_info']['setting']['session'] = Wo_GetAllSessionsFromUserID($wo['user']['user_id']);
            $wo['user_info']['setting']['block'] = Wo_GetBlockedMembers($wo['user']['user_id']);
            $wo['user_info']['setting']['trans'] = Wo_GetMytransactions();
            $wo['user_info']['setting']['refs'] = Wo_GetReferrers();
            // print_r($wo['user_info']['setting']['open_to_work_datajob_type']);
            // exit();
        }
        if (!empty($_POST['posts'])) {
            $wo['user_info']['posts'] = Wo_GetPosts(array('filter_by' => 'all','publisher_id' => $wo['user']['user_id'],'limit' => 100000)); 
        }
        if (!empty($_POST['pages']) && $wo['config']['pages'] == 1) {
            $wo['user_info']['pages'] = Wo_GetMyPages();
        }
        if (!empty($_POST['groups']) && $wo['config']['groups'] == 1) {
            $wo['user_info']['groups'] = Wo_GetMyGroups();
        }
        if ($wo['config']['connectivitySystem'] == 0) {
            if (!empty($_POST['followers'])) {
                $wo['user_info']['followers'] = Wo_GetFollowers($wo['user']['user_id'],'profile',1000000);
            }
            if (!empty($_POST['following'])) {
                $wo['user_info']['following'] = Wo_GetFollowing($wo['user']['user_id'], 'profile',1000000);
            }
        }
        else{
            if (!empty($_POST['friends'])) {
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
        $data['status'] = 200;
        $data['message'] = $wo['lang']['file_ready'];
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}

