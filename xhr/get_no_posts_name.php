<?php 
if ($f == 'get_no_posts_name') {
    $data = array(
        'name' => $wo['lang']['no_more_posts']
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
