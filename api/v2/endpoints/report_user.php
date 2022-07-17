<?php
$response_data = array(
    'api_status' => 400
);
if (isset($_POST['user']) && is_numeric($_POST['user']) && isset($_POST['text'])) {
    $user = Wo_Secure($_POST['user']);
    $text = Wo_Secure($_POST['text']);
    $code = Wo_ReportUser($user, $text);
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
    $error_message = 'user , text can not be empty';
}