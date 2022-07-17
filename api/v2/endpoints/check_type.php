<?php
if (!empty($_POST['u'])) {
	$u = Wo_IsNameExist($_POST['u'], 1);
	if (!empty($u) && !empty($u['id'])) {
		$response_data = array(
	                    'api_status' => 200,
	                    'type' => $u['type'],
	                    'id' => $u['id'],
	                );
	}
	else{
		$error_code    = 5;
		$error_message = 'Unknown Type';
	}
}