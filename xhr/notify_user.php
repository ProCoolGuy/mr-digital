<?php 
if ($f == 'notify_user' && $wo['config']['notify_new_post'] == 1) {
    if (isset($_GET['following_id']) && is_numeric($_GET['following_id']) && $_GET['following_id'] > 0) {
        $user_id = Wo_Secure($_GET['following_id']);
        if (Wo_IsFollowingNotify($user_id, $wo['user']['user_id'])) {
            $db->where('following_id',$user_id)->where('follower_id',$wo['user']['user_id'])->update(T_FOLLOWERS,array('notify' => 0));
        }
        else{
            $db->where('following_id',$user_id)->where('follower_id',$wo['user']['user_id'])->update(T_FOLLOWERS,array('notify' => 1));
        }
    }
    $data['status'] = 200;
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}