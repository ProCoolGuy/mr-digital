<?php 
if ($f == 'search-blog-read') {
    $html = '';
    if (empty($_POST['keyword'])) {
        $data['status'] = 200;
        $data['html']   = $html;
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if (isset($_POST['keyword'])) {
        $pages = Wo_GetBlogs(array(
            "limit" => 20,
            'keyword' => $_POST['keyword']
        ));
        if (count($pages) > 0) {
            foreach ($pages as $key => $wo['blog-style']) {
                $wo['blog-style']['first'] = ($key == 0) ? true : false;
                $html .= Wo_LoadPage('blog/blog-popular');
            }
            if (!empty($html)) {
                $data['status'] = 200;
                $data['html']   = $html;
            }
        } else {
            $data = array(
                'status' => 400,
                'message' => $wo['lang']['no_blogs_found']
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
// 