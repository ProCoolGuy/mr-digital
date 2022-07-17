<?php 
if ($f == 'delete_user_account' && $wo['config']['deleteAccount'] == 1) {
    if (isset($_POST['password'])) {
        if (Wo_HashPassword($_POST['password'], $wo['user']['password']) == false) {
            $errors[] = $error_icon . $wo['lang']['current_password_mismatch'];
        }
        if (empty($errors)) {
            if (Wo_DeleteUser($wo['user']['user_id']) === true) {
                $data = array(
                    'status' => 200,
                    'message' => $success_icon . $wo['lang']['account_deleted'],
                    'location' => Wo_SeoLink('index.php?link1=logout')
                );
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
