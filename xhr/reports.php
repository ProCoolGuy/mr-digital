<?php 
if ($f == 'reports') {
    if ($s == 'report_user' && isset($_POST['user']) && is_numeric($_POST['user']) && isset($_POST['text'])) {
        $user = Wo_Secure($_POST['user']);
        $text = Wo_Secure($_POST['text']);
        $code = Wo_ReportUser($user, $text);
        $data = array(
            'status' => 304
        );
        if ($code == 0) {
            $data['status'] = 200;
            $data['code']   = 0;
        } else if ($code == 1) {
            $data['status'] = 200;
            $data['code']   = 1;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'report_page' && isset($_POST['page']) && is_numeric($_POST['page']) && isset($_POST['text'])) {
        $page = Wo_Secure($_POST['page']);
        $text = Wo_Secure($_POST['text']);
        $code = Wo_ReportPage($page, $text);
        $data = array(
            'status' => 304
        );
        if ($code == 0) {
            $data['status'] = 200;
            $data['code']   = 0;
        } else if ($code == 1) {
            $data['status'] = 200;
            $data['code']   = 1;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'report_group' && isset($_POST['group']) && is_numeric($_POST['group']) && isset($_POST['text'])) {
        $group = Wo_Secure($_POST['group']);
        $text  = Wo_Secure($_POST['text']);
        $code  = Wo_ReportGroup($group, $text);
        $data  = array(
            'status' => 304
        );
        if ($code == 0) {
            $data['status'] = 200;
            $data['code']   = 0;
        } else if ($code == 1) {
            $data['status'] = 200;
            $data['code']   = 1;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
