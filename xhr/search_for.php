<?php 
if ($f == 'search_for') {
    $data_info = array();
    $data['status'] = 400;
    if ($s == 'group' && !empty($_GET['name'])) {
        $groups = Wo_SearchFor(Wo_Secure($_GET['name']), 'group');
        $data_info = $groups;
    }
    elseif ($s == 'page' && !empty($_GET['name'])) {
        $pages = Wo_SearchFor(Wo_Secure($_GET['name']), 'page');
        $data_info = $pages;
    }
    elseif ($s == 'user' && !empty($_GET['name'])) {
        $data_info = Wo_GetFollowingSug(5, $_GET['name']);
    }
    
    if (!empty($data_info)) {
        $data['status'] = 200;
        $data['info'] = $data_info;
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
