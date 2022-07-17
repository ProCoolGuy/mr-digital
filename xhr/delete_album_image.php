<?php 
if ($f == 'delete_album_image') {
    if (!empty($_GET['post_id']) && !empty($_GET['id'])) {
        if (Wo_DeleteImageFromAlbum($_GET['post_id'], $_GET['id']) === true) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
