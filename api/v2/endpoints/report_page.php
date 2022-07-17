<?php
$response_data = array(
    'api_status' => 400
);
if (isset($_POST['page_id']) && is_numeric($_POST['page_id']) && isset($_POST['page_id'])) {
    $page_id = Wo_Secure($_POST['page_id']);
    $text = Wo_Secure($_POST['text']);
    $code = Wo_ReportPage($page_id, $text);
    if ($code == 0) {
        $response_data['api_status'] = 200;
        $response_data['code']   = 0;
    } else if ($code == 1) {
        $response_data['api_status'] = 200;
        $response_data['code']   = 1;
    }
}
else{
	$error_code    = 3;
    $error_message = 'page_id , text can not be empty';
}