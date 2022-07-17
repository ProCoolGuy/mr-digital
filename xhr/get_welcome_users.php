<?php 
if ($f == 'get_welcome_users') {
    $html = '';
    foreach (Wo_WelcomeUsers() as $wo['user']) {
        $html .= Wo_LoadPage('welcome/user-list');
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
