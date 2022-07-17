<?php 
if ($f == 'open_album_lightbox') {
    $html = '';
    if (!empty($_GET['image_id'])) {
        $data_image = array(
            'id' => (int) $_GET['image_id']
        );
        if ($_GET['type'] == 'album') {
            $wo['image'] = Wo_AlbumImageData($data_image);
            if (!empty($wo['image'])) {
                $html = Wo_LoadPage('lightbox/album-content');
            }
        } else {
            $wo['image'] = Wo_ProductImageData($data_image);
            if (!empty($wo['image'])) {
                $html = Wo_LoadPage('lightbox/product-content');
            }
        }
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
