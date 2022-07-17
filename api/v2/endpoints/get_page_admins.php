<?php
if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0) {
	$data =array();
	$requests = Wo_GetPageAdmins($_POST['page_id']);
	foreach ($requests as $key => $value) {
		foreach ($non_allowed as $key => $value2) {
            unset($value[$value2]);
        }
		$value['admin_info'] = Wo_GetPageAdminInfo($value['user_id'],$_POST['page_id']);
		$data[] = $value;
	}
	$response_data = array(
                        'api_status' => 200,
                        'data' => $data
                    );
}
else{
	$error_code    = 5;
    $error_message = 'page_id can not be empty';
}