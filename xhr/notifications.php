<?php 
if ($f == 'notifications') {
    if ($s == 'get-users') {
        $data  = array(
            'status' => 404,
            'html' => ''
        );
        $html  = '';
        $users = Wo_GetUsersByName($_POST['name']);
        if ($users && count($users) > 0) {
            foreach ($users as $wo['notificated-user']) {
                $html .= Wo_LoadAdminPage('mass-notifications/list');
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'send') {
        $data  = array(
            'status' => 304,
            'message' => $error_icon . $wo['lang']['please_check_details']
        );
        $error = false;
        $users = array();
        if (!isset($_POST['url']) || !isset($_POST['description'])) {
            $error = true;
        } else {
            if (!filter_var($_POST['url'], FILTER_VALIDATE_URL)) {
                $error = true;
            }
            if (strlen($_POST['description']) < 5 || strlen($_POST['description']) > 300) {
                $error = true;
            }
        }
        if (!$error) {
            if (empty($_POST['notifc-users'])) {
                $users = Wo_GetUserIds();
            } elseif ($_POST['notifc-users'] && strlen($_POST['notifc-users']) > 0) {
                $users = explode(',', $_POST['notifc-users']);
            }
            $url               = Wo_Secure($_POST['url']);
            $message           = Wo_Secure($_POST['description']);
            $registration_data = array(
                'full_link' => $url,
                'text' => $message,
                'recipients' => $users
            );
            if (Wo_RegisterAdminNotification($registration_data)) {
                $data = array(
                    'status' => 200,
                    'message' => $success_icon . $wo['lang']['notification_sent']
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
