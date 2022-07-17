<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data   = array(
    'api_status' => 400
);

if (empty($_POST['group_id'])) {
    $error_code    = 1;
    $error_message = 'group_id (POST) is missing';
}

if (empty($error_code)) {
	$group = Wo_GroupData($_POST['group_id']);
	if (empty($group)) {
		$error_code    = 2;
    	$error_message = 'Group not found';
	} else {
		$group_data = array();
		if (!empty($_POST)) {
			$group_data = $_POST;
		}
		$escape = array('server_key');
		if (isset($group_data['server_key'])) {
			unset($group_data['server_key']);
		}
		if (!empty($group_data['group_name'])) {
			$is_exist = Wo_IsNameExist($group_data['group_name'], 0);
		    if (in_array(true, $is_exist) && $group_data['group_name'] != $group['group_name']) {
		        $error_code    = 3;
		        $error_message = 'Group name is already exists';
		    }
		    if (in_array($group_data['group_name'], $wo['site_pages']) || !preg_match('/^[\w]+$/', $group_data['group_name'])) {
		        $error_code    = 4;
		        $error_message = 'Invalid group name characters';
		    }
		    if (strlen($group_data['group_name']) < 5 || strlen($group_data['group_name']) > 32) {
		        $error_code    = 5;
		        $error_message = 'Group name must be between 5/32';
		    }
		}
		if (!empty($_FILES["avatar"]["tmp_name"])) {
			$upload_image = Wo_UploadImage($_FILES["avatar"]["tmp_name"], $_FILES['avatar']['name'], 'avatar', $_FILES['avatar']['type'], $_POST['group_id'], 'group');
			if ($upload_image) {
		        $response_data['api_status'] = 200;
		    }
		}
		if (!empty($_FILES["cover"]["tmp_name"])) {
			$upload_image = Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $_POST['group_id'], 'group');
			if ($upload_image) {
		        $response_data['api_status'] = 200;
		    }
		}
		if (empty($error_code)) {
			foreach ($group_data as $key => $value) {
				if (!isset($group[$key])) {
					$error_code = 1;
					$error_message = "Key #$key not found, check Wo_Groups table to get the correct information";
					unset($group_data[$key]);
				}
			}
		}
		if (empty($error_code)) {
			if ($group_data['group_id']) {
				unset($group_data['group_id']);
			}
			$privacy      = 1;
            $join_privacy = 1;
            $array        = array(
                1,
                2
            );
            if (!empty($_POST['privacy'])) {
                if (in_array($_POST['privacy'], $array)) {
                    $group_data['privacy'] = $_POST['privacy'];
                }
            }
            if (!empty($_POST['join_privacy'])) {
                if (in_array($_POST['join_privacy'], $array)) {
                    $group_data['join_privacy'] = $_POST['join_privacy'];
                }
            }

            $group_data['sub_category'] = '';
	        if (!empty($_POST['group_sub_category']) && !empty($wo['group_sub_categories'][$_POST['category']])) {
	            foreach ($wo['group_sub_categories'][$_POST['category']] as $key => $value) {
	                if ($value['id'] == $_POST['group_sub_category']) {
	                    $group_data['sub_category'] = $value['id'];
	                }
	            }
	        }
	        unset($group_data['group_sub_category']);

	        $fields = Wo_GetCustomFields('group'); 
	        if (!empty($fields)) {
	            foreach ($fields as $key => $field) {
	                if ($field['required'] == 'on' && empty($_POST['fid_'.$field['id']])) {
	                    $response_data       = array(
	                        'api_status'     => '404',
	                        'errors'         => array(
	                            'error_id'   => 7,
	                            'error_text' => 'please check details required field'
	                        )
	                    );
	                    echo json_encode($response_data, JSON_PRETTY_PRINT);
	                    exit();
	                }
	                elseif (!empty($_POST['fid_'.$field['id']])) {
	                    $group_data['fid_'.$field['id']] = Wo_Secure($_POST['fid_'.$field['id']]);
	                }
	            }
	        }


			$update = Wo_UpdateGroupData($group['id'], $group_data);
			if ($update) {
				$response_data['api_status'] = 200;
				$response_data['message'] = 'Your group was updated';
			}
		}
	}
}