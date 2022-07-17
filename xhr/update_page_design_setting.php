<?php 
if ($f == 'update_page_design_setting') {
    if (isset($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && Wo_CheckSession($hash_id) === true) {
        $Userdata = Wo_PageData($_POST['page_id']);
        if (!empty($Userdata['id'])) {
            $background_image_status = 0;
            if (isset($_FILES['background_image']['name'])) {
                if (Wo_UploadImage($_FILES["background_image"]["tmp_name"], $_FILES['background_image']['name'], 'page_background_image', $_FILES['background_image']['type'], $_POST['page_id'], 'page') === true) {
                    $background_image_status = 1;
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
            if (empty($errors)) {
                $Update_data = array(
                    'background_image_status' => $background_image_status
                );
                if (Wo_UpdatePageData($_POST['page_id'], $Update_data)) {
                    $userdata2 = Wo_PageData($_POST['page_id']);
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
