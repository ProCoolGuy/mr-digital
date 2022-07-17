<?php 
if ($f == 'apps') {
    if ($s == 'create_app') {
        if (empty($_POST['app_name']) || empty($_POST['app_website_url']) || empty($_POST['app_description'])) {
            $errors[] = $error_icon . $wo['lang']['please_check_details'];
        }
        if (!filter_var($_POST['app_website_url'], FILTER_VALIDATE_URL)) {
            $errors[] = $error_icon . $wo['lang']['website_invalid_characters'];
        }
        if (empty($errors)) {
            $app_callback_url = '';
            if (!empty($_POST['app_callback_url'])) {
                if (!filter_var($_POST['app_callback_url'], FILTER_VALIDATE_URL)) {
                    $errors[] = $error_icon . $wo['lang']['website_invalid_characters'];
                } else {
                    $app_callback_url = $_POST['app_callback_url'];
                }
            }
            $re_app_data = array(
                'app_user_id' => Wo_Secure($wo['user']['user_id']),
                'app_name' => Wo_Secure($_POST['app_name']),
                'app_website_url' => Wo_Secure($_POST['app_website_url']),
                'app_description' => Wo_Secure($_POST['app_description']),
                'app_callback_url' => Wo_Secure($app_callback_url)
            );
            $app_id      = Wo_RegisterApp($re_app_data);
            if ($app_id != '') {
                if (!empty($_FILES["app_avatar"]["name"])) {
                    Wo_UploadImage($_FILES["app_avatar"]["tmp_name"], $_FILES['app_avatar']['name'], 'avatar', $_FILES['app_avatar']['type'], $app_id, 'app');
                }
                $data = array(
                    'status' => 200,
                    'location' => Wo_SeoLink('index.php?link1=app&app_id=' . $app_id)
                );
            }
        }
        header("Content-type: application/json");
        if (isset($errors)) {
            echo json_encode(array(
                'errors' => $errors
            ));
        } else {
            echo json_encode($data);
        }
        exit();
    }
    if ($s == 'update_app') {
        if (empty($_POST['app_name']) || empty($_POST['app_website_url']) || empty($_POST['app_description'])) {
            $errors[] = $error_icon . $wo['lang']['please_check_details'];
        }
        if (!filter_var($_POST['app_website_url'], FILTER_VALIDATE_URL)) {
            $errors[] = $error_icon . $wo['lang']['website_invalid_characters'];
        }
        if (!filter_var($_POST['app_callback_url'], FILTER_VALIDATE_URL)) {
            $errors[] = $error_icon . $wo['lang']['website_invalid_characters'];
        }
        if (empty($errors)) {
            $app_id      = $_POST['app_id'];
            $re_app_data = array(
                'app_user_id' => Wo_Secure($wo['user']['user_id']),
                'app_name' => Wo_Secure($_POST['app_name']),
                'app_website_url' => Wo_Secure($_POST['app_website_url']),
                'app_callback_url' => Wo_Secure($_POST['app_callback_url']),
                'app_description' => Wo_Secure($_POST['app_description'])
            );
            if (Wo_UpdateAppData($app_id, $re_app_data) === true) {
                if (!empty($_FILES["app_avatar"]["name"])) {
                    Wo_UploadImage($_FILES["app_avatar"]["tmp_name"], $_FILES['app_avatar']['name'], 'avatar', $_FILES['app_avatar']['type'], $app_id, 'app');
                }
                $img  = Wo_GetApp($app_id);
                $data = array(
                    'status' => 200,
                    'message' => $wo['lang']['setting_updated'],
                    'name' => $_POST['app_name'],
                    'image' => $img['app_avatar']
                );
            }
        }
        header("Content-type: application/json");
        if (isset($errors)) {
            echo json_encode(array(
                'errors' => $errors
            ));
        } else {
            echo json_encode($data);
        }
        exit();
    }
    if ($s == 'acceptPermissions') {
        $acceptPermissions = Wo_AcceptPermissions($_POST['id']);
        if ($acceptPermissions === true) {
            $import = Wo_GenrateCode($wo['user']['user_id'], $_POST['id']);
            $app    = urldecode($_POST['url']) . '?code=' . $import;
            $data   = array(
                'status' => 200,
                'location' => $app
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
