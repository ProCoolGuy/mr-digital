<?php 
if ($f == "load-recent-blogs") {
    $html   = '';
    $id     = (isset($_GET['id'])) ? $_GET['id'] : false;
    $offset = (isset($_GET['offset'])) ? $_GET['offset'] : false;
    $total  = (isset($_GET['total'])) ? $_GET['total'] : 10;
    $blogs  = Wo_GetBlogs(array(
        "category" => $id,
        "offset" => $offset,
        "limit" => $total
    ));
    if (count($blogs) > 0) {
        foreach ($blogs as $key => $wo['article']) {
            $html .= Wo_LoadPage('blog/includes/card-list');
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
if ($wo['loggedin'] == false && ($s != 'load_more_posts' && $f != 'load-more-events')) {
    if ($s != 'load-comments' && $f != 'load-more-events' && $f != 'search-blog' && $f != 'search-blog-read') {
        exit("Please login or signup to continue.");
    }
}
