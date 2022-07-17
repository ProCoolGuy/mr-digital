<?php 
if ($f == 'mention') {
    $html_data  = array();
    $data_finel = array();
    $following  = Wo_GetFollowingSug(5, $_GET['term']);
    header("Content-type: application/json");
    echo json_encode(array(
        $following
    ));
    exit();
}
