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

if (empty($_POST['page_id'])) {
    $error_code    = 1;
    $error_message = 'page_id (POST) is missing';
}

if (empty($error_code)) {
	$page = Wo_PageData($_POST['page_id']);
	if (empty($page)) {
		$error_code    = 2;
    	$error_message = 'Page not found';
	} else {
		$page_data = array();
		if (!empty($_POST)) {
			$page_data = $_POST;
		}
		$escape = array('server_key');
		if (isset($page_data['server_key'])) {
			unset($page_data['server_key']);
		}
		if (!empty($page_data['page_name'])) {
			$is_exist = Wo_IsNameExist($page_data['page_name'], 0);
		    if (in_array(true, $is_exist) && $page_data['page_name'] != $page['page_name']) {
		        $error_code    = 3;
		        $error_message = 'Page name is already exists';
		    }
		    if (in_array($page_data['page_name'], $wo['site_pages']) || !preg_match('/^[\w]+$/', $page_data['page_name'])) {
		        $error_code    = 4;
		        $error_message = 'Invalid Page name characters';
		    }
		    if (strlen($page_data['page_name']) < 5 || strlen($page_data['page_name']) > 32) {
		        $error_code    = 5;
		        $error_message = 'Page name must be between 5/32';
		    }
		}
		if (!empty($_FILES["avatar"]["tmp_name"])) {
			$upload_image = Wo_UploadImage($_FILES["avatar"]["tmp_name"], $_FILES['avatar']['name'], 'avatar', $_FILES['avatar']['type'], $page['page_id'], 'page');
			if ($upload_image) {
		        $response_data['api_status'] = 200;
		    }
		}
		if (!empty($_FILES["cover"]["tmp_name"])) {
			$upload_image = Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $page['page_id'], 'page');
			if ($upload_image) {
		        $response_data['api_status'] = 200;
		    }
		}
		if (!empty($_FILES["background_image"]["tmp_name"])) {
			$upload_image = Wo_UploadImage($_FILES["background_image"]["tmp_name"], $_FILES['background_image']['name'], 'page_background_image', $_FILES['background_image']['type'], $page['page_id'], 'page');
			if ($upload_image) {
		        $response_data['api_status'] = 200;
		    }
		}
		if (empty($error_code)) {
			foreach ($page_data as $key => $value) {
				if (!isset($page[$key])) {
					$error_code = 1;
					$error_message = "Key #$key not found, check Wo_Pages table to get the correct information";
					unset($page_data[$key]);
				}
			}
		}
		$call_action_type = 0;
        if (!empty($_POST['call_action_type'])) {
            if (array_key_exists($_POST['call_action_type'], $wo['call_action'])) {
                $page_data['call_action_type'] = $_POST['call_action_type'];
            }
        }
        if (!empty($_POST['call_action_type_url'])) {
            if (!filter_var($_POST['call_action_type_url'], FILTER_VALIDATE_URL)) {
            	$error_code = 2;
				$error_message = "call action type url invalid";
            }
            else{
            	$page_data['call_action_type_url'] = $_POST['call_action_type_url'];
            }
        }
        if (!empty($_POST['website'])) {
            if (!filter_var($_POST['website'], FILTER_VALIDATE_URL)) {
                $error_code = 3;
				$error_message = "website invalid characters";
            }
        }
		if (empty($error_code)) {
			if ($page_data['page_id']) {
				unset($page_data['page_id']);
			}

			$array        = array(
                0,
                2
            );
            if (in_array($_POST['verified'], $array)) {
                $page_data['verified'] = $_POST['verified'];
            }

            if (!empty($_POST['website'])) {
            	$page_data['website'] = Wo_Secure($_POST['website']);
            }
            if (!empty($_POST['page_description'])) {
            	$page_data['page_description'] = Wo_Secure($_POST['page_description']);
            }
            if (!empty($_POST['company'])) {
            	$page_data['company'] = Wo_Secure($_POST['company']);
            }
            if (!empty($_POST['address'])) {
            	$page_data['address'] = Wo_Secure($_POST['address']);
            }
            if (!empty($_POST['phone'])) {
            	$page_data['phone'] = Wo_Secure($_POST['phone']);
            }
            if (!empty($_POST['facebook'])) {
            	$page_data['facebook'] = Wo_Secure($_POST['facebook']);
            }
            if (!empty($_POST['instgram'])) {
            	$page_data['instgram'] = Wo_Secure($_POST['instgram']);
            }
            if (!empty($_POST['twitter'])) {
            	$page_data['twitter'] = Wo_Secure($_POST['twitter']);
            }
            if (!empty($_POST['linkedin'])) {
            	$page_data['linkedin'] = Wo_Secure($_POST['linkedin']);
            }
            if (!empty($_POST['vk'])) {
            	$page_data['vk'] = Wo_Secure($_POST['vk']);
            }
            if (!empty($_POST['youtube'])) {
            	$page_data['youtube'] = Wo_Secure($_POST['youtube']);
            }

            if (!empty($_POST['background_image_status'])) {
                if ($_POST['background_image_status'] == 'defualt') {
                    $page_data['background_image_status'] = 0;
                } else if ($_POST['background_image_status'] == 'my_background') {
                    $page_data['background_image_status'] = 1;
                } else {
                    $page_data['background_image_status'] = 0;
                }
            }
            $array       = array(0,1);
            $page_data['users_post'] = 0;
            if (!empty($_POST['users_post'])) {
                if (in_array($_POST['users_post'], $array)) {
                    $page_data['users_post'] = Wo_Secure($_POST['users_post']);
                }
            }

            $page_data['sub_category'] = '';
            if (!empty($_POST['page_sub_category']) && !empty($wo['page_sub_categories'][$_POST['page_category']])) {
                foreach ($wo['page_sub_categories'][$_POST['page_category']] as $key => $value) {
                    if ($value['id'] == $_POST['page_sub_category']) {
                        $page_data['sub_category'] = $value['id'];
                    }
                }
            }
            unset($page_data['page_sub_category']);
            
            $fields = Wo_GetCustomFields('page'); 
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
                        $page_data['fid_'.$field['id']] = Wo_Secure($_POST['fid_'.$field['id']]);
                    }
                }
            }


			$update = Wo_UpdatePageData($page['page_id'], $page_data);
			if ($update) {
				$response_data['api_status'] = 200;
				$response_data['message'] = 'Your page was updated';
			}
		}
	}
}