<?php 
if ($f == 'check_username') {
    if (isset($_GET['username'])) {
        $usename = Wo_Secure($_GET['username']);
        if ($usename == $wo['user']['username']) {
            $data['status']  = 200;
            $data['message'] = $wo['lang']['available'];
        } else if (strlen($usename) < 5) {
            $data['status']  = 400;
            $data['message'] = $wo['lang']['too_short'];
        } else if (strlen($usename) > 32) {
            $data['status']  = 500;
            $data['message'] = $wo['lang']['too_long'];
        } else if (!preg_match('/^[\w]+$/', $_GET['username'])) {
            $data['status']  = 600;
            $data['message'] = $wo['lang']['username_invalid_characters_2'];
        } else {
            $is_exist = Wo_IsNameExist($_GET['username'], 0);
            if (in_array(true, $is_exist)) {
                $data['status']  = 300;
                $data['message'] = $wo['lang']['in_use'];
            } else {
                $data['status']  = 200;
                $data['message'] = $wo['lang']['available'];
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
