<?php 
if ($f == 'check_pagename') {
    if (isset($_GET['pagename']) && !empty($_GET['page_id'])) {
        $pagename  = Wo_Secure($_GET['pagename']);
        $page_data = Wo_PageData($_GET['page_id']);
        if ($pagename == $page_data['page_name']) {
            $data['status']  = 200;
            $data['message'] = $wo['lang']['available'];
        } else if (strlen($pagename) < 5) {
            $data['status']  = 400;
            $data['message'] = $wo['lang']['too_short'];
        } else if (strlen($pagename) > 32) {
            $data['status']  = 500;
            $data['message'] = $wo['lang']['too_long'];
        } else if (!preg_match('/^[\w]+$/', $_GET['pagename'])) {
            $data['status']  = 600;
            $data['message'] = $wo['lang']['username_invalid_characters_2'];
        } else {
            $is_exist = Wo_IsNameExist($_GET['pagename'], 0);
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
