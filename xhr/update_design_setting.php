<?php 
if ($f == "update_design_setting") {
    if (isset($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && Wo_CheckSession($hash_id) === true) {
        $Userdata = Wo_UserData($_POST['user_id']);
        if (!empty($Userdata['user_id'])) {
            $background_image_status = 0;
            if (isset($_FILES['background_image']['name'])) {
                if (Wo_UploadImage($_FILES["background_image"]["tmp_name"], $_FILES['background_image']['name'], 'background_image', $_FILES['background_image']['type'], $_POST['user_id']) === true) {
                    $background_image_status = 1;
                    if (!empty($mediaFilename)) {
                        Wo_DeleteFromToS3($Userdata['background_image']);
                    }
                }
            }
            if (!empty($_POST['background_image_status'])) {
                if ($_POST['background_image_status'] == 'defualt') {
                    $background_image_status = 0;
                } else if ($_POST['background_image_status'] == 'my_background') {
                    $background_image_status = 1;
                } else {
                    $background_image_status = 0;
                }
            }
            $mediaFilename = $Userdata['css_file'];
            if (isset($_FILES['css_file']['name']) && $wo['config']['css_upload'] == 1) {
                $fileInfo      = array(
                    'file' => $_FILES["css_file"]["tmp_name"],
                    'name' => $_FILES['css_file']['name'],
                    'size' => $_FILES["css_file"]["size"],
                    'type' => $_FILES["css_file"]["type"],
                    'types' => 'css,CSS'
                );
                $media         = Wo_ShareFile($fileInfo);
                $mediaFilename = $media['filename'];
            }
            if (empty($errors)) {
                $Update_data = array(
                    'background_image_status' => $background_image_status,
                    'css_file' => $mediaFilename
                );
                $css_status  = 1;
                if (!empty($_POST['css_status'])) {
                    if ($_POST['css_status'] == 1) {
                        $Update_data['css_file'] = '';
                    } else if ($_POST['css_status'] == 2) {
                        $Update_data['css_file'] = $mediaFilename;
                    }
                }
                if (Wo_UpdateUserData($_POST['user_id'], $Update_data)) {
                    $userdata2 = Wo_UserData($_POST['user_id']);
                    $data      = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['setting_updated']
                    );
                }
            }
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
