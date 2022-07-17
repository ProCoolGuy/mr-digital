<?php
if ($f == 'groups') {
    if ($s == 'create_group') {
        if (empty($_POST['group_name']) || empty($_POST['group_title']) || empty(Wo_Secure($_POST['group_title'])) || Wo_CheckSession($hash_id) === false) {
            $errors[] = $error_icon . $wo['lang']['please_check_details'];
        } else {
            $is_exist = Wo_IsNameExist($_POST['group_name'], 0);
            if (in_array(true, $is_exist)) {
                $errors[] = $error_icon . $wo['lang']['group_name_exists'];
            }
            if (in_array($_POST['group_name'], $wo['site_pages'])) {
                $errors[] = $error_icon . $wo['lang']['group_name_invalid_characters'];
            }
            if (strlen($_POST['group_name']) < 5 OR strlen($_POST['group_name']) > 32) {
                $errors[] = $error_icon . $wo['lang']['group_name_characters_length'];
            }
            if (!preg_match('/^[\w]+$/', $_POST['group_name'])) {
                $errors[] = $error_icon . $wo['lang']['group_name_invalid_characters'];
            }
            if (empty($_POST['category'])) {
                $_POST['category'] = 1;
            }
        }
        $privacy = 1;
        if (!empty($_POST['privacy'])) {
            if ($_POST['privacy'] == 2) {
                $privacy = 2;
            }
        }
        if (empty($errors)) {
            $sub_category = '';
            if (!empty($_POST['group_sub_category']) && !empty($wo['group_sub_categories'][$_POST['category']])) {
                foreach ($wo['group_sub_categories'][$_POST['category']] as $key => $value) {
                    if ($value['id'] == $_POST['group_sub_category']) {
                        $sub_category = $value['id'];
                    }
                }
            }
            $re_group_data = array(
                'group_name' => Wo_Secure($_POST['group_name']),
                'user_id' => Wo_Secure($wo['user']['user_id']),
                'group_title' => Wo_Secure($_POST['group_title']),
                'about' => Wo_Secure($_POST['about']),
                'category' => Wo_Secure($_POST['category']),
                'sub_category' => $sub_category,
                'privacy' => Wo_Secure($privacy),
                'active' => '1',
                'time' => time()
            );
            if ($privacy == 2) {
                $re_group_data['join_privacy'] = 2;
            }
            $fields = Wo_GetCustomFields('group');
            if (!empty($fields)) {
                foreach ($fields as $key => $field) {
                    if ($field['required'] == 'on' && empty($_POST['fid_' . $field['id']])) {
                        $errors[] = $error_icon . $wo['lang']['please_check_details'];
                        header("Content-type: application/json");
                        echo json_encode(array(
                            'errors' => $errors
                        ));
                        exit();
                    } elseif (!empty($_POST['fid_' . $field['id']])) {
                        $re_group_data['fid_' . $field['id']] = Wo_Secure($_POST['fid_' . $field['id']]);
                    }
                }
            }
            $register_group = Wo_RegisterGroup($re_group_data);
            if ($register_group) {
                if ($privacy == 2) {
                    $group_id = Wo_GroupIdFromGroupname(Wo_Secure($_POST['group_name']));
                    $user_id  = $wo['user']['id'];
                    $active   = 1;
                    $query    = mysqli_query($sqlConnect, " INSERT INTO " . T_GROUP_MEMBERS . " (`user_id`,`group_id`,`active`,`time`) VALUES ({$user_id},{$group_id},'{$active}'," . time() . ")");
                }
                $data = array(
                    'status' => 200,
                    'location' => Wo_SeoLink('index.php?link1=timeline&u=' . Wo_Secure($_POST['group_name']))
                );
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
    if ($s == 'update_information_setting') {
        if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0) {
            $PageData = Wo_PageData($_POST['page_id']);
            if (!empty($_POST['website'])) {
                if (!filter_var($_POST['website'], FILTER_VALIDATE_URL)) {
                    $errors[] = $error_icon . $wo['lang']['website_invalid_characters'];
                }
            }
            if (empty($errors)) {
                $Update_data = array(
                    'website' => $_POST['website'],
                    'page_description' => $_POST['page_description'],
                    'company' => $_POST['company'],
                    'address' => $_POST['address'],
                    'phone' => $_POST['phone']
                );
                if (Wo_UpdatePageData($_POST['page_id'], $Update_data)) {
                    $data = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['setting_updated']
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
    if ($s == 'update_privacy_setting') {
        if (!empty($_POST['group_id']) && is_numeric($_POST['group_id']) && $_POST['group_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $group_data   = Wo_GroupData($_POST['group_id']);
            $privacy      = 1;
            $join_privacy = 1;
            $array        = array(
                1,
                2
            );
            if (!empty($_POST['privacy'])) {
                if (in_array($_POST['privacy'], $array)) {
                    $privacy = $_POST['privacy'];
                }
            }
            if (!empty($_POST['join_privacy'])) {
                if (in_array($_POST['join_privacy'], $array)) {
                    $join_privacy = $_POST['join_privacy'];
                }
            }
            if ($group_data['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_POST['group_id'], 'privacy')) {
                if (empty($errors)) {
                    $Update_data = array(
                        'privacy' => $privacy,
                        'join_privacy' => $join_privacy
                    );
                    if (Wo_UpdateGroupData($_POST['group_id'], $Update_data)) {
                        $data = array(
                            'status' => 200,
                            'message' => $success_icon . $wo['lang']['setting_updated']
                        );
                    }
                }
            } else {
                $errors[] = $error_icon . $wo['lang']['please_check_details'];
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update_images_setting') {
        if (isset($_POST['group_id']) && is_numeric($_POST['group_id']) && $_POST['group_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $Userdata = Wo_GroupData($_POST['group_id']);
            if (!empty($Userdata['id'])) {
                if (!empty($_FILES['avatar']['name'])) {
                    if (Wo_UploadImage($_FILES["avatar"]["tmp_name"], $_FILES['avatar']['name'], 'avatar', $_FILES['avatar']['type'], $_POST['group_id'], 'group') === true) {
                        $page_data = Wo_GroupData($_POST['group_id']);
                    }
                }
                if (!empty($_FILES['cover']['name'])) {
                    if (Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $_POST['group_id'], 'group') === true) {
                        $page_data = Wo_GroupData($_POST['group_id']);
                    }
                }
                if ($Userdata['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_POST['group_id'], 'avatar')) {
                    if (empty($errors)) {
                        $Update_data = array(
                            'active' => '1'
                        );
                        if (Wo_UpdateGroupData($_POST['group_id'], $Update_data)) {
                            $userdata2 = Wo_GroupData($_POST['group_id']);
                            $data      = array(
                                'status' => 200,
                                'message' => $success_icon . $wo['lang']['setting_updated'],
                                'cover' => $userdata2['cover'],
                                'avatar' => $userdata2['avatar']
                            );
                        }
                    }
                } else {
                    $errors[] = $error_icon . $wo['lang']['please_check_details'];
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
    }
    if ($s == 'update_general_settings') {
        if (!empty($_POST['group_id']) && is_numeric($_POST['group_id']) && $_POST['group_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $group_data = Wo_GroupData($_POST['group_id']);
            if (empty($_POST['group_name']) OR empty($_POST['group_category']) OR empty($_POST['group_title']) OR empty(Wo_Secure($_POST['group_title']))) {
                $errors[] = $error_icon . $wo['lang']['please_check_details'];
            } else {
                if ($_POST['group_name'] != $group_data['group_name']) {
                    $is_exist = Wo_IsNameExist($_POST['group_name'], 0);
                    if (in_array(true, $is_exist)) {
                        $errors[] = $error_icon . $wo['lang']['group_name_exists'];
                    }
                }
                if (in_array($_POST['group_name'], $wo['site_pages'])) {
                    $errors[] = $error_icon . $wo['lang']['group_name_invalid_characters'];
                }
                if (strlen($_POST['group_name']) < 5 || strlen($_POST['group_name']) > 32) {
                    $errors[] = $error_icon . $wo['lang']['group_name_characters_length'];
                }
                if (!preg_match('/^[\w]+$/', $_POST['group_name'])) {
                    $errors[] = $error_icon . $wo['lang']['group_name_invalid_characters'];
                }
                if (empty($_POST['group_category'])) {
                    $_POST['group_category'] = 1;
                }
                if ($group_data['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_POST['group_id'], 'general')) {
                    if (empty($errors)) {
                        $sub_category = '';
                        if (!empty($_POST['group_sub_category']) && !empty($wo['group_sub_categories'][$_POST['group_category']])) {
                            foreach ($wo['group_sub_categories'][$_POST['group_category']] as $key => $value) {
                                if ($value['id'] == $_POST['group_sub_category']) {
                                    $sub_category = $value['id'];
                                }
                            }
                        }
                        $Update_data = array(
                            'group_name' => $_POST['group_name'],
                            'group_title' => $_POST['group_title'],
                            'category' => $_POST['group_category'],
                            'sub_category' => $sub_category,
                            'about' => $_POST['about']
                        );
                        $fields      = Wo_GetCustomFields('group');
                        if (!empty($fields)) {
                            foreach ($fields as $key => $field) {
                                if ($field['required'] == 'on' && empty($_POST['fid_' . $field['id']])) {
                                    $errors[] = $error_icon . $wo['lang']['please_check_details'];
                                    header("Content-type: application/json");
                                    echo json_encode(array(
                                        'errors' => $errors
                                    ));
                                    exit();
                                } elseif (!empty($_POST['fid_' . $field['id']])) {
                                    $Update_data['fid_' . $field['id']] = Wo_Secure($_POST['fid_' . $field['id']]);
                                }
                            }
                        }
                        if (Wo_UpdateGroupData($_POST['group_id'], $Update_data)) {
                            $data = array(
                                'status' => 200,
                                'message' => $success_icon . $wo['lang']['setting_updated']
                            );
                        }
                    }
                } else {
                    $errors[] = $error_icon . $wo['lang']['please_check_details'];
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
    if ($s == 'delete_group') {
        if (!empty($_POST['group_id']) && is_numeric($_POST['group_id']) && $_POST['group_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            if (!Wo_HashPassword($_POST['password'], $wo['user']['password']) && !Wo_CheckGroupAdminPassword($_POST['password'], $_POST['group_id'])) {
                $errors[] = $error_icon . $wo['lang']['current_password_mismatch'];
            }
            $group_data = Wo_GroupData($_POST['group_id']);
            if ($group_data['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_POST['group_id'], 'delete_group')) {
                if (empty($errors)) {
                    if (Wo_DeleteGroup($_POST['group_id']) === true) {
                        $data = array(
                            'status' => 200,
                            'message' => $success_icon . $wo['lang']['group_deleted'],
                            'location' => Wo_SeoLink('index.php?link1=groups')
                        );
                    }
                }
            } else {
                $errors[] = $error_icon . $wo['lang']['please_check_details'];
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
    if ($s == 'accept_request') {
        if (isset($_GET['user_id']) && is_numeric($_GET['user_id']) && $_GET['user_id'] > 0 && !empty($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
            if (Wo_AcceptJoinRequest($_GET['user_id'], $_GET['group_id']) === true) {
                $data = array(
                    'status' => 200
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'delete_request') {
        if (isset($_GET['user_id']) && is_numeric($_GET['user_id']) && $_GET['user_id'] > 0 && !empty($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
            if (Wo_DeleteJoinRequest($_GET['user_id'], $_GET['group_id']) === true) {
                $data = array(
                    'status' => 200
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'delete_joined_user') {
        if (isset($_GET['user_id']) && is_numeric($_GET['user_id']) && $_GET['user_id'] > 0 && !empty($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
            $group_data = Wo_GroupData($_GET['group_id']);
            if ($group_data['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_GET['group_id'], 'members')) {
                if (Wo_LeaveGroup($_GET['group_id'], $_GET['user_id']) === true) {
                    $data = array(
                        'status' => 200
                    );
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'add_admin') {
        if (isset($_GET['user_id']) && is_numeric($_GET['user_id']) && $_GET['user_id'] > 0 && !empty($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
            $group_data = Wo_GroupData($_GET['group_id']);
            if ($group_data['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_GET['group_id'], 'members')) {
                $member = Wo_Secure($_GET['user_id']);
                $group  = Wo_Secure($_GET['group_id']);
                $data   = array(
                    'status' => 304
                );
                $code   = Wo_AddGroupAdmin($member, $group);
                if ($code === 1) {
                    $data['status'] = 200;
                    $data['code']   = 1;
                } elseif ($code === 0) {
                    $data['status'] = 200;
                    $data['code']   = 0;
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'privileges') {
        if (!empty($_POST['group_id']) && is_numeric($_POST['group_id']) && $_POST['group_id'] > 0 && !empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0) {
            $group_data = Wo_GroupData($_POST['group_id']);
            if ($group_data['user_id'] == $wo['user']['id'] || Wo_IsCanGroupUpdate($_POST['group_id'], 'members')) {
                $update_array = array(
                    'general' => 0,
                    'privacy' => 0,
                    'avatar' => 0,
                    'members' => 0,
                    'analytics' => 0,
                    'delete_group' => 0
                );
                if (!empty($_POST['general']) && $_POST['general'] == 1) {
                    $update_array['general'] = 1;
                }
                if (!empty($_POST['privacy']) && $_POST['privacy'] == 1) {
                    $update_array['privacy'] = 1;
                }
                if (!empty($_POST['avatar']) && $_POST['avatar'] == 1) {
                    $update_array['avatar'] = 1;
                }
                if (!empty($_POST['members']) && $_POST['members'] == 1) {
                    $update_array['members'] = 1;
                }
                if (!empty($_POST['analytics']) && $_POST['analytics'] == 1) {
                    $update_array['analytics'] = 1;
                }
                if (!empty($_POST['delete_group']) && $_POST['delete_group'] == 1) {
                    $update_array['delete_group'] = 1;
                }
                if (Wo_UpdateGroupAdminData($_POST['group_id'], $update_array, $_POST['user_id'])) {
                    $data = array(
                        'status' => 200,
                        'message' => $success_icon . $wo['lang']['setting_updated']
                    );
                }
            } else {
                $errors[] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $errors[] = $error_icon . $wo['lang']['please_check_details'];
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
