<?php 
if ($f == 'update_event_cover_picture') {
    if (isset($_FILES['cover']['name']) && !empty($_POST['event_id']) && is_numeric($_POST['event_id']) && $_POST['event_id'] > 0 && Is_EventOwner($_POST['event_id'])) {
        if (Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $_POST['event_id'], 'event')) {
            $img  = Wo_EventData($_POST['event_id']);
            $data = array(
                'status' => 200,
                'img' => $img['cover']
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
