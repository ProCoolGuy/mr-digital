<?php 
if ($f == "search-art") {
    $category = (isset($_GET['cat'])) ? $_GET['cat'] : false;
    $keyword  = (isset($_GET['keyword'])) ? Wo_Secure($_GET['keyword']) : false;
    $result   = Wo_SearchBlogs(array(
        "keyword" => $keyword,
        "category" => $category
    ));
    $status   = 404;
    $html     = "";
    if ($result && count($result) > 0) {
        foreach ($result as $wo['blog']) {
            $html .= Wo_LoadPage('blog/includes/card-horiz-list');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
    } else {
        $data = array(
            'status' => 200,
            "warning" => $wo['lang']['no_blogs_found']
        );
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
