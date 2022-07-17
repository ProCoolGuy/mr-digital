<?php 
if ($f == 'answer_call') {
    if (!empty($_GET['id']) && !empty($_GET['type'])) {
        $id = Wo_Secure($_GET['id']);
        if ($_GET['type'] == 'audio') {
            $query = mysqli_query($sqlConnect, "UPDATE " . T_AUDIO_CALLES . " SET `active` = 1 WHERE `id` = '$id'");
        } else {
            $query = mysqli_query($sqlConnect, "UPDATE " . T_VIDEOS_CALLES . " SET `active` = 1 WHERE `id` = '$id'");
        }
        if ($wo['config']['agora_chat_video'] == 1) {
            $query = mysqli_query($sqlConnect, "UPDATE " . T_AGORA . " SET `active` = 1 WHERE `id` = '$id'");
        }
        if ($query) {
            $data = array(
                'status' => 200
            );
            if ($_GET['type'] == 'audio') {
                if ($wo['config']['agora_chat_video'] == 1) {
                    $query = mysqli_query($sqlConnect, "SELECT * FROM " . T_AGORA . " WHERE `id` = '{$id}'");
                }
                else{
                    $query = mysqli_query($sqlConnect, "SELECT * FROM " . T_AUDIO_CALLES . " WHERE `id` = '{$id}'");
                }
                
                $sql   = mysqli_fetch_assoc($query);
                if (!empty($sql) && is_array($sql)) {
                    $wo['incall']                 = $sql;
                    $wo['incall']['in_call_user'] = Wo_UserData($sql['from_id']);
                    if ($wo['incall']['to_id'] == $wo['user']['user_id']) {
                        $wo['incall']['user']         = 1;
                        $wo['incall']['access_token'] = $wo['incall']['access_token'];
                    } else if ($wo['incall']['from_id'] == $wo['user']['user_id']) {
                        $wo['incall']['user']         = 2;
                        $wo['incall']['access_token'] = $wo['incall']['access_token_2'];
                    }
                    $user_1               = Wo_UserData($wo['incall']['from_id']);
                    $user_2               = Wo_UserData($wo['incall']['to_id']);
                    $wo['incall']['room'] = $wo['incall']['room_name'];
                    $data['calls_html']   = Wo_LoadPage('modals/talking');
                }
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
