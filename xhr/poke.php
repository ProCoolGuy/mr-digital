<?php 
if ($f == 'poke') {
    if (!empty($_GET['received_user_id']) && !empty($_GET['send_user_id']) && Wo_CheckMainSession($hash_id) === true) {
        $received_user_id = Wo_Secure($_GET['received_user_id']);
        $send_user_id     = Wo_Secure($_GET['send_user_id']);
        if (isset($_GET['poke_id']) && !empty($_GET['poke_id'])) {
            $poke_id  = Wo_Secure($_GET['poke_id']);
            $querydel = mysqli_query($sqlConnect, "DELETE FROM " . T_POKES . " WHERE `received_user_id` = {$send_user_id} AND `send_user_id` = {$received_user_id}");
        }
        $query = mysqli_query($sqlConnect, " INSERT INTO " . T_POKES . " (`received_user_id`,`send_user_id`) VALUES ({$received_user_id},{$send_user_id})");
        if ($query) {
            $text                    = "";
            $type2                   = "poke";
            $notification_data_array = array(
                'recipient_id' => $received_user_id,
                'post_id' => $send_user_id,
                'type' => 'poke',
                'text' => $text,
                'type2' => $type2,
                'url' => 'index.php?link1=poke'
            );
            Wo_RegisterNotification($notification_data_array);
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
