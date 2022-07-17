<?php 
if ($f == 'get_next_album_image') {
    $html = '';
    if (!empty($_GET['after_image_id'])) {
        $data_image  = array(
            'post_id' => (int) $_GET['post_id'],
            'after_image_id' => (int) $_GET['after_image_id']
        );
        $wo['image'] = Wo_AlbumImageData($data_image);
        if (!empty($wo['image'])) {
            $html = Wo_LoadPage('lightbox/album-content');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
