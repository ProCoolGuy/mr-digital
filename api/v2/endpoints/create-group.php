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

$required_fields = array(
    'group_name',
    'group_title',
    'category',
    'about',
);

foreach ($required_fields as $key => $value) {
    if (empty($_POST[$value]) && empty($error_code)) {
        $error_code    = 3;
        $error_message = $value . ' (POST) is missing';
    }
}

if (empty($error_code)) {
    $group_name     = Wo_Secure($_POST['group_name']);
    $group_title    = Wo_Secure($_POST['group_title']);
    $category       = Wo_Secure($_POST['category']);
    $about          = Wo_Secure($_POST['about']);

    $is_exist = Wo_IsNameExist($_POST['group_name'], 0);
    
    if (in_array(true, $is_exist) || in_array($_POST['group_name'], $wo['site_pages'])) {
        $error_code    = 4;
        $error_message = 'Group name is already exists.';
    } else if (strlen($_POST['group_name']) < 5 OR strlen($_POST['group_name']) > 32) {
        $error_code    = 5;
        $error_message = 'Group name must be between 5 / 32';
    } else if (!preg_match('/^[\w]+$/', $_POST['group_name'])) {
        $error_code    = 6;
        $error_message = 'Invalid group name characters';
    }
    $privacy = 1;
    if (!empty($_POST['privacy'])) {
        if ($_POST['privacy'] == 2) {
            $privacy = 2;
        }
    }
    
    if (empty($error_code)) {
        $sub_category = '';
        if (!empty($_POST['group_sub_category']) && !empty($wo['group_sub_categories'][$_POST['category']])) {
            foreach ($wo['group_sub_categories'][$_POST['category']] as $key => $value) {
                if ($value['id'] == $_POST['group_sub_category']) {
                    $sub_category = $value['id'];
                }
            }
        }
    	$group_data  = array(
            'group_name' => $group_name,
            'user_id' => $wo['user']['user_id'],
            'group_title' => $group_title,
            'about' => $about,
            'category' => $category,
            'privacy' => Wo_Secure($privacy),
            'active' => 1,
            'sub_category' => $sub_category
        );
        
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

        $register_group    = Wo_RegisterGroup($group_data);
        if ($register_group) {
            $response_data = array(
                'api_status' => 200,
                'group_data' => Wo_GroupData(Wo_GroupIdFromGroupname($_POST['group_name']))
            );
        }
    }
}