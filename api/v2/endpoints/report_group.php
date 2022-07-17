<?php
$response_data = array(
    'api_status' => 400
);
if (isset($_POST['group_id']) && is_numeric($_POST['group_id']) && isset($_POST['group_id'])) {
    $group_id = Wo_Secure($_POST['group_id']);
    $text = Wo_Secure($_POST['text']);
    $code = Wo_ReportGroup($group_id, $text);
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
    $error_message = 'group_id , text can not be empty';
}