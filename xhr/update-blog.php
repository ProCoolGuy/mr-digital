<?php 
if ($f == "update-blog") {
    if (Wo_CheckSession($hash_id) === true) {
        if (empty($_POST['blog_title']) || empty($_POST['blog_content']) || empty($_POST['blog_description'])) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        } else {
            if (strlen($_POST['blog_title']) < 10) {
                $error = $error_icon . $wo['lang']['title_more_than10'];
            }
            if (strlen($_POST['blog_description']) < 32) {
                $error = $error_icon . $wo['lang']['desc_more_than32'];
            }
            if (empty($_POST['blog_tags'])) {
                $error = $error_icon . $wo['lang']['please_fill_tags'];
            }
            if (!in_array($_POST['blog_category'], array_keys($wo['blog_categories']))) {
                $error = $error_icon . $wo['lang']['error_found'];
            }
        }
        if (empty($error)) {
            $_POST['blog_tags'] = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_POST['blog_tags']);
            $_POST['blog_tags'] = strip_tags($_POST['blog_tags']);
            $_POST['blog_content'] = preg_replace($wo['regx_attr'], '', $_POST['blog_content']);
            $registration_data = array(
                'user' => $wo['user']['id'],
                'title' => $_POST['blog_title'],
                'content' => $_POST['blog_content'],
                'description' => $_POST['blog_description'],
                'category' => $_POST['blog_category'],
                'tags' => $_POST['blog_tags']
            );
            if (Wo_UpdateBlog($_GET['blog_id'], $registration_data)) {
                if (isset($_FILES["thumbnail"])) {
                    $fileInfo           = array(
                        'file' => $_FILES["thumbnail"]["tmp_name"],
                        'name' => $_FILES['thumbnail']['name'],
                        'size' => $_FILES["thumbnail"]["size"],
                        'type' => $_FILES["thumbnail"]["type"],
                        'types' => 'jpeg,jpg,png,bmp,gif',
                        'crop' => array(
                            'width' => 1200,
                            'height' => 600
                        )
                    );
                    $media              = Wo_ShareFile($fileInfo);
                    $mediaFilename      = $media['filename'];
                    $image              = array();
                    $image['user']      = $wo['user']['user_id'];
                    $image['thumbnail'] = $mediaFilename;
                    Wo_UpdateBlog($_GET['blog_id'], $image);
                }
                $data = array(
                    'message' => $success_icon . $wo['lang']['article_updated'],
                    'status' => 200,
                    'url' => Wo_SeoLink('index.php?link1=read-blog&id=' . $_GET['blog_id'])
                );
            }
        } else {
            $data = array(
                'status' => 500,
                'message' => $error
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
