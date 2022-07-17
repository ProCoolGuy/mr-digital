<?php
if ($f == "address") {
	if ($s == 'add') {
		if (!empty($_POST['name']) && !empty($_POST['phone']) && !empty($_POST['country']) && !empty($_POST['city']) && !empty($_POST['zip']) && !empty($_POST['address'])) {
			$id = $db->insert(T_USER_ADDRESS,array('name' => Wo_Secure($_POST['name']),
		                                'phone' => Wo_Secure($_POST['phone']),
		                                'city' => Wo_Secure($_POST['city']),
		                                'zip' => Wo_Secure($_POST['zip']),
		                                'address' => Wo_Secure($_POST['address']),
		                                'user_id' => $wo['user']['user_id'],
		                                'time' => time(),
		                                'country' => Wo_Secure($_POST['country'])));
			if (!empty($id)) {
				$data['status'] = 200;
				$data['url'] = $wo['config']['site_url'].'/setting/'.$wo['user']['username'].'/addresses';
				$data['message'] = $wo['lang']['address_added'];
			}
			else{
				$data['message'] = $error_icon . $wo['lang']['something_wrong'];
			}
		}
		else{
			$data['message'] = $error_icon . $wo['lang']['please_check_details'];
		}
	}
	if ($s == 'delete') {
		if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
			$address = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_ADDRESS);
			if (!empty($address) && ($address->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
				$db->where('id',$address->id)->delete(T_USER_ADDRESS);
				$data['status'] = 200;
			}
			else{
				$data['message'] = $error_icon . $wo['lang']['please_check_details'];
			}
		}
		else{
			$data['message'] = $error_icon . $wo['lang']['please_check_details'];
		}
	}
	if ($s == 'edit') {
		if (!empty($_POST['name']) && !empty($_POST['phone']) && !empty($_POST['country']) && !empty($_POST['city']) && !empty($_POST['zip']) && !empty($_POST['address']) && !empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
			$address = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_ADDRESS);
			if (!empty($address) && ($address->user_id == $wo['user']['user_id'] || IsAdmin())) {
				$db->where('id',$address->id)->update(T_USER_ADDRESS,array('name' => Wo_Secure($_POST['name']),
									                                'phone' => Wo_Secure($_POST['phone']),
									                                'city' => Wo_Secure($_POST['city']),
									                                'zip' => Wo_Secure($_POST['zip']),
									                                'address' => Wo_Secure($_POST['address']),
									                                'country' => Wo_Secure($_POST['country'])));
				$data['status'] = 200;
				$data['url'] = $wo['config']['site_url'].'/setting/'.$wo['user']['username'].'/addresses';
				$data['message'] = $wo['lang']['address_edited'];
			}
			else{
				$data['message'] = $error_icon . $wo['lang']['please_check_details'];
			}
		}
		else{
			$data['message'] = $error_icon . $wo['lang']['please_check_details'];
		}
	}
	header("Content-type: application/json");
    echo json_encode($data);
    exit();
}