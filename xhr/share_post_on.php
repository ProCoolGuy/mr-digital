<?php 
if ($f == 'share_post_on') {
    $data_info = array();
    $data['status'] = 400;
    $result = false;
    $user_id = 0;
    if ($s == 'group' && !empty($_GET['type_id']) && is_numeric($_GET['type_id']) && $_GET['type_id'] > 0 && !empty($_GET['post_id']) && is_numeric($_GET['post_id']) && $_GET['post_id'] > 0) {
        $group = Wo_GroupData(Wo_Secure($_GET['type_id']));
        $post = Wo_PostData(Wo_Secure($_GET['post_id']));
        $user_id = $post['user_id'];
        if (!empty($post) && !empty($group) && $group['user_id'] == $wo['user']['id']) {
            $result = Wo_SharePostOn($post['id'],$group['id'],'group');
        }
    }
    elseif ($s == 'page' && !empty($_GET['type_id']) && is_numeric($_GET['type_id']) && $_GET['type_id'] > 0 && !empty($_GET['post_id']) && is_numeric($_GET['post_id']) && $_GET['post_id'] > 0) {
        $page = Wo_PageData(Wo_Secure($_GET['type_id']));
        $post = Wo_PostData(Wo_Secure($_GET['post_id']));
        $user_id = $post['user_id'];
        if (empty($post['user_id'])) {
            $user_id = $page['user_id'];
        }
        if (!empty($post) && !empty($page) && $page['user_id'] == $wo['user']['id']) {
            $result = Wo_SharePostOn($post['id'],$page['id'],'page');
        }
    }
    elseif ($s == 'user' && !empty($_GET['type_id']) && is_numeric($_GET['type_id']) && $_GET['type_id'] > 0 && !empty($_GET['post_id']) && is_numeric($_GET['post_id']) && $_GET['post_id'] > 0) {
        $user = Wo_UserData(Wo_Secure($_GET['type_id']));
        $post = Wo_PostData(Wo_Secure($_GET['post_id']));
        $user_id = $post['user_id'];
        if (!empty($post['page_id'])) {
            $page = Wo_PageData($post['page_id']);
            $user_id = $page['user_id'];
        }
        if (!empty($post) && !empty($user)) {
            $result = Wo_SharePostOn($post['id'],$user['id'],'user');
        }
    }
    elseif ($s == 'timeline' && !empty($_GET['post_id']) && is_numeric($_GET['post_id']) && $_GET['post_id'] > 0) {
        $post = Wo_PostData(Wo_Secure($_GET['post_id']));
        $user_id = $post['user_id'];
        if (empty($post['user_id']) && !empty($post['page_id'])) {
            $page = Wo_PageData($post['page_id']);
            $user_id = $page['user_id'];
        }
        if (!empty($post)) {
            $result = Wo_SharePostOn($post['id'],$wo['user']['id'],'user');
        }
    }
    if ($result) {
        if (!empty($_GET['text'])) {
            $updatePost = Wo_UpdatePost(array(
                'post_id' => $result,
                'text' => $_GET['text']
            ));
        }
        $notification_data_array = array(
            'recipient_id' => $user_id,
            'post_id' => $post['id'],
            'type' => 'shared_your_post',
            'url' => 'index.php?link1=post&id=' . $result
        );
        Wo_RegisterNotification($notification_data_array);
        if ($s == 'user') {
            $notification_data_array = array(
                'recipient_id' => $user['id'],
                'post_id' => $post['id'],
                'type' => 'shared_a_post_in_timeline',
                'url' => 'index.php?link1=post&id=' . $result
            );
            Wo_RegisterNotification($notification_data_array);
        }
        $data['status'] = 200;
    }
    else{
        $data['status'] = 400;
        $data['message'] = $wo['lang']['cant_share_own'];
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}

