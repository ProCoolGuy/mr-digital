<?php 
if ($f == 'open_multilightbox') {
    $html = '';
    if (!empty($_POST['url'])) {
        $wo['lighbox']['url'] = $_POST['url'];
        $html                 = Wo_LoadPage('lightbox/content-multi');
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
