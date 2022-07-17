<?php 
$response_data = array(
    'api_status' => 400,
);

if (empty($_POST['page_id'])) {
    $error_code    = 3;
    $error_message = 'page_id (POST) is missing';
}
elseif (empty($_POST['val'])) {
    $error_code    = 4;
    $error_message = 'val (POST) is missing';
}
elseif (empty($_POST['text'])) {
    $error_code    = 5;
    $error_message = 'text (POST) is missing';
}
else{
    $val  = Wo_Secure($_POST['val']);
    $id   = Wo_Secure($_POST['page_id']);
    $text = Wo_Secure($_POST['text']);
    if (Wo_RatePage($id, $val, $text)) {
        $response_data = array(
                'api_status' => 200,
                'val' => $val
            );
    }
}