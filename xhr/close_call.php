<?php 
if ($f == 'close_call') {
    if (!empty($_GET['id'])) {
        $id    = Wo_Secure($_GET['id']);
        $query = mysqli_query($sqlConnect, "UPDATE " . T_AUDIO_CALLES . " SET `declined` = '1' WHERE `id` = '$id'");
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
