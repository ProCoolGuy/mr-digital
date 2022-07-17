<?php 
if ($f == 'send_gift') {
    if (!empty($_GET['from']) && !empty($_GET['to']) && !empty($_GET['gift_id']) && Wo_CheckMainSession($hash_id) === true) {
        $from     = Wo_Secure($_GET['from']);
        $to       = Wo_Secure($_GET['to']);
        $gift_id  = Wo_Secure($_GET['gift_id']);
        $gift_img = Wo_Secure($_GET['gift_img']);
        $query    = mysqli_query($sqlConnect, " INSERT INTO " . T_USERGIFTS . " (`from`,`to`,`gift_id`,`time`) VALUES ('{$from}','{$to}','{$gift_id}','" . time() . "')");
        $user     = Wo_UserData($from);
        if ($query) {
            $text                    = "";
            $type2                   = "gift_" . $gift_id;
            $notification_data_array = array(
                'recipient_id' => $to,
                'post_id' => $from,
                'type' => 'gift',
                'text' => $text,
                'type2' => $type2,
                'url' => 'index.php?link1=timeline&mode=opengift&gift_img=' . urlencode($gift_img) . '&u=' . $user['username']
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
