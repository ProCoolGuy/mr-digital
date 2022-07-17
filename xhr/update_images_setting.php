<?php 
if ($f == "update_images_setting") {
    if (isset($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && Wo_CheckSession($hash_id) === true) {
        $Userdata = Wo_UserData($_POST['user_id']);
        if (!empty($Userdata['user_id'])) {
            if (isset($_FILES['avatar']['name'])) {
                if (Wo_UploadImage($_FILES["avatar"]["tmp_name"], $_FILES['avatar']['name'], 'avatar', $_FILES['avatar']['type'], $_POST['user_id']) === true) {
                    $Userdata = Wo_UserData($_POST['user_id']);
                }
            }
            if (isset($_FILES['cover']['name'])) {
                if (Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $_POST['user_id']) === true) {
                    $Userdata = Wo_UserData($_POST['user_id']);
                }
            }
            if (empty($errors)) {
                $Update_data = array(
                    'lastseen' => time()
                );
                if (Wo_UpdateUserData($_POST['user_id'], $Update_data)) {
                    $userdata2 = Wo_UserData($_POST['user_id']);
                    $data      = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['setting_updated'],
                        'cover' => $userdata2['cover'],
                        'avatar' => $userdata2['avatar']
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
