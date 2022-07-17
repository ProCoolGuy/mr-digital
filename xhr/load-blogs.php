<?php 
if ($f == "load-blogs") {
    $html   = '';
    $id     = (isset($_GET['id'])) ? $_GET['id'] : false;
    $offset = (isset($_GET['offset'])) ? $_GET['offset'] : false;
    $blogs  = Wo_GetBlogs(array(
        "category" => $id,
        "offset" => $offset
    ));
    if (count($blogs) > 0) {
        foreach ($blogs as $key => $wo['blog']) {
            $html .= Wo_LoadPage('blog/includes/card-horiz-list');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
    } else {
        $data = array(
            'status' => 404
        );
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
