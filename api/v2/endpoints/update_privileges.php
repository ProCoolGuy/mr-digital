<?php
if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && !empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0) {
    $page_data = Wo_PageData($_POST['page_id']);
    if ($page_data['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'],'admins')) {
        $update_array = array('general' => 0 , 'info' => 0 , 'social' => 0 , 'avatar' => 0 , 'design' => 0 , 'admins' => 0 , 'analytics' => 0 , 'delete_page' => 0);
        if (!empty($_POST['general']) && $_POST['general'] == 1) {
            $update_array['general'] = 1;
        }
        if (!empty($_POST['info']) && $_POST['info'] == 1) {
            $update_array['info'] = 1;
        }
        if (!empty($_POST['social']) && $_POST['social'] == 1) {
            $update_array['social'] = 1;
        }
        if (!empty($_POST['avatar']) && $_POST['avatar'] == 1) {
            $update_array['avatar'] = 1;
        }
        if (!empty($_POST['design']) && $_POST['design'] == 1) {
            $update_array['design'] = 1;
        }
        if (!empty($_POST['admins']) && $_POST['admins'] == 1) {
            $update_array['admins'] = 1;
        }
        if (!empty($_POST['analytics']) && $_POST['analytics'] == 1) {
            $update_array['analytics'] = 1;
        }
        if (!empty($_POST['delete_page']) && $_POST['delete_page'] == 1) {
            $update_array['delete_page'] = 1;
        }

        if (Wo_UpdatePageAdminData($_POST['page_id'], $update_array,$_POST['user_id'])) {
            $response_data['api_status'] = 200;
			$response_data['message'] = 'Privileges updated';
        }
        else{
        	$error_code = 3;
			$error_message = "something went wrong";
        }
    }
    else{
        $error_code = 2;
		$error_message = "you can not update the info";
    }
}
else{
    $error_code = 1;
	$error_message = "page_id user_id can not be empty";
}