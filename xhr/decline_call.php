<?php 
if ($f == 'decline_call') {
    if (!empty($_GET['id']) && !empty($_GET['type'])) {
        $id = Wo_Secure($_GET['id']);
        if ($_GET['type'] == 'video') {
            $query = mysqli_query($sqlConnect, "UPDATE " . T_VIDEOS_CALLES . " SET `declined` = '1' WHERE `id` = '$id'");
        } else {
            $query = mysqli_query($sqlConnect, "UPDATE " . T_AUDIO_CALLES . " SET `declined` = '1' WHERE `id` = '$id'");
        }
        if ($wo['config']['agora_chat_video'] == 1) {
            $query = mysqli_query($sqlConnect, "UPDATE " . T_AGORA . " SET `declined` = '1' WHERE `id` = '$id'");
        }
        if ($query) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
