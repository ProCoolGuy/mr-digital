<?php 
if ($f == 'story_views_') {
    $data['status'] = 400;
    if (!empty($_POST['story_id']) && is_numeric($_POST['story_id']) && $_POST['story_id'] > 0 && !empty($_POST['last_view']) && is_numeric($_POST['last_view']) && $_POST['last_view'] > 0) {
        $users = $db->where('id',Wo_Secure($_POST['last_view']),'>')->where('story_id',Wo_Secure($_POST['story_id']))->get(T_STORY_SEEN,10);
        $html = '';
        if (!empty($users)) {
            foreach ($users as $key => $value) {
                $user_ = Wo_UserData($value->user_id);
                $user_['id'] = $value->id;
                $wo['story'] = $user_;
                $html .= Wo_LoadPage('lightbox/friends_list');
            }
            $data['status'] = 200;
            $data['html'] = $html;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
