<?php
if ($f == 'pages') {
    if ($s == 'create_page') {
        if (!empty($_POST['page_name']) && ($_POST['page_name'] == 'wowonder' || $_POST['page_name'] == 'sunshine' || $_POST['page_name'] == $wo['config']['theme'])) {
            $_POST['page_name'] = "";
        }
        if (empty($_POST['page_name']) || empty($_POST['page_title']) || empty(Wo_Secure($_POST['page_title'])) || Wo_CheckSession($hash_id) === false) {
            $errors[] = $error_icon . $wo['lang']['please_check_details'];
        } else {
            $is_exist = Wo_IsNameExist($_POST['page_name'], 0);
            if (in_array(true, $is_exist)) {
                $errors[] = $error_icon . $wo['lang']['page_name_exists'];
            }
            if (in_array($_POST['page_name'], $wo['site_pages'])) {
                $errors[] = $error_icon . $wo['lang']['page_name_invalid_characters'];
            }
            if (strlen($_POST['page_name']) < 5 OR strlen($_POST['page_name']) > 32) {
                $errors[] = $error_icon . $wo['lang']['page_name_characters_length'];
            }
            if (!preg_match('/^[\w]+$/', $_POST['page_name'])) {
                $errors[] = $error_icon . $wo['lang']['page_name_invalid_characters'];
            }
            if (empty($_POST['page_category'])) {
                $_POST['page_category'] = 1;
            }
        }
        if (empty($errors)) {
            $sub_category = '';
            if (!empty($_POST['page_sub_category']) && !empty($wo['page_sub_categories'][$_POST['page_category']])) {
                foreach ($wo['page_sub_categories'][$_POST['page_category']] as $key => $value) {
                    if ($value['id'] == $_POST['page_sub_category']) {
                        $sub_category = $value['id'];
                    }
                }
            }
            $re_page_data = array(
                'page_name' => Wo_Secure($_POST['page_name']),
                'user_id' => Wo_Secure($wo['user']['user_id']),
                'page_title' => Wo_Secure($_POST['page_title']),
                'page_description' => Wo_Secure($_POST['page_description']),
                'page_category' => Wo_Secure($_POST['page_category']),
                'sub_category' => $sub_category,
                'active' => '1',
                'time' => time()
            );
            $fields       = Wo_GetCustomFields('page');
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
                        $re_page_data['fid_' . $field['id']] = Wo_Secure($_POST['fid_' . $field['id']]);
                    }
                }
            }
            $register_page = Wo_RegisterPage($re_page_data);
            if ($register_page) {
                $data = array(
                    'status' => 200,
                    'location' => Wo_SeoLink('index.php?link1=timeline&u=' . Wo_Secure($_POST['page_name']))
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
        if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $PageData = Wo_PageData($_POST['page_id']);
            if (!empty($_POST['website'])) {
                if (!filter_var($_POST['website'], FILTER_VALIDATE_URL)) {
                    $errors[] = $error_icon . $wo['lang']['website_invalid_characters'];
                }
            }
            if ($PageData['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'], 'info')) {
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
    if ($s == 'update_sociallink_setting') {
        if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $PageData = Wo_PageData($_POST['page_id']);
            if ($PageData['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'], 'social')) {
                if (empty($errors)) {
                    $Update_data = array(
                        'facebook' => $_POST['facebook'],
                        'instgram' => $_POST['instgram'],
                        'twitter' => $_POST['twitter'],
                        'linkedin' => $_POST['linkedin'],
                        'vk' => $_POST['vk'],
                        'youtube' => $_POST['youtube']
                    );
                    if (Wo_UpdatePageData($_POST['page_id'], $Update_data)) {
                        $data = array(
                            'status' => 200,
                            'message' => $success_icon . $wo['lang']['setting_updated']
                        );
                    }
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update_images_setting') {
        if (isset($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $Userdata = Wo_PageData($_POST['page_id']);
            if (!empty($Userdata['page_id'])) {
                if ($Userdata['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'], 'avatar')) {
                    if (isset($_FILES['avatar']['name'])) {
                        if (Wo_UploadImage($_FILES["avatar"]["tmp_name"], $_FILES['avatar']['name'], 'avatar', $_FILES['avatar']['type'], $_POST['page_id'], 'page') === true) {
                            $page_data = Wo_PageData($_POST['page_id']);
                        }
                    }
                    if (isset($_FILES['cover']['name'])) {
                        if (Wo_UploadImage($_FILES["cover"]["tmp_name"], $_FILES['cover']['name'], 'cover', $_FILES['cover']['type'], $_POST['page_id'], 'page') === true) {
                            $page_data = Wo_PageData($_POST['page_id']);
                        }
                    }
                    if (empty($errors)) {
                        $Update_data = array(
                            'active' => '1'
                        );
                        if (Wo_UpdatePageData($_POST['page_id'], $Update_data)) {
                            $userdata2 = Wo_PageData($_POST['page_id']);
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
        if (!empty($_POST['page_name']) && ($_POST['page_name'] == 'wowonder' || $_POST['page_name'] == 'sunshine' || $_POST['page_name'] == $wo['config']['theme'])) {
            $_POST['page_name'] = "";
        }
        if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            $PageData = Wo_PageData($_POST['page_id']);
            if (empty($_POST['page_name']) OR empty($_POST['page_category']) OR empty($_POST['page_title']) OR empty(Wo_Secure($_POST['page_title']))) {
                $errors[] = $error_icon . $wo['lang']['please_check_details'];
            } else {
                if ($_POST['page_name'] != $PageData['page_name']) {
                    $is_exist = Wo_IsNameExist($_POST['page_name'], 0);
                    if (in_array(true, $is_exist)) {
                        $errors[] = $error_icon . $wo['lang']['page_name_exists'];
                    }
                }
                if (in_array($_POST['page_name'], $wo['site_pages'])) {
                    $errors[] = $error_icon . $wo['lang']['page_name_invalid_characters'];
                }
                if (strlen($_POST['page_name']) < 5 || strlen($_POST['page_name']) > 32) {
                    $errors[] = $error_icon . $wo['lang']['page_name_characters_length'];
                }
                if (!preg_match('/^[\w]+$/', $_POST['page_name'])) {
                    $errors[] = $error_icon . $wo['lang']['page_name_invalid_characters'];
                }
                if (empty($_POST['page_category'])) {
                    $_POST['page_category'] = 1;
                }
                $call_action_type = 0;
                if (!empty($_POST['call_action_type'])) {
                    if (array_key_exists($_POST['call_action_type'], $wo['call_action'])) {
                        $call_action_type = $_POST['call_action_type'];
                    }
                }
                if (!empty($_POST['call_action_type_url'])) {
                    if (!filter_var($_POST['call_action_type_url'], FILTER_VALIDATE_URL)) {
                        $errors[] = $error_icon . $wo['lang']['call_action_type_url_invalid'];
                    }
                }
                if ($PageData['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'], 'general')) {
                    if (empty($errors)) {
                        $sub_category = '';
                        if (!empty($_POST['page_sub_category']) && !empty($wo['page_sub_categories'][$_POST['page_category']])) {
                            foreach ($wo['page_sub_categories'][$_POST['page_category']] as $key => $value) {
                                if ($value['id'] == $_POST['page_sub_category']) {
                                    $sub_category = $value['id'];
                                }
                            }
                        }
                        $Update_data = array(
                            'page_name' => $_POST['page_name'],
                            'page_title' => $_POST['page_title'],
                            'page_category' => $_POST['page_category'],
                            'sub_category' => $sub_category,
                            'call_action_type' => $call_action_type,
                            'call_action_type_url' => $_POST['call_action_type_url']
                        );
                        $array       = array(
                            'verified' => 1,
                            'notVerified' => 0
                        );
                        if (!empty($_POST['verified'])) {
                            if (array_key_exists($_POST['verified'], $array)) {
                                $Update_data['verified'] = $array[$_POST['verified']];
                            }
                        }
                        $array                     = array(
                            0,
                            1
                        );
                        $Update_data['users_post'] = 0;
                        if (!empty($_POST['users_post'])) {
                            if (in_array($_POST['users_post'], $array)) {
                                $Update_data['users_post'] = Wo_Secure($_POST['users_post']);
                            }
                        }
                        $fields = Wo_GetCustomFields('page');
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
                        if (Wo_UpdatePageData($_POST['page_id'], $Update_data)) {
                            $data = array(
                                'status' => 200,
                                'message' => $success_icon . $wo['lang']['setting_updated'],
                                'link' => $wo['site_url'] . '/' . $_POST['page_name'],
                                'data_ajax' => '?link1=timeline&u=' . $_POST['page_name']
                            );
                        }
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
    if ($s == 'delete_page') {
        if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && Wo_CheckSession($hash_id) === true) {
            if (!Wo_HashPassword($_POST['password'], $wo['user']['password']) && !Wo_CheckPageAdminPassword($_POST['password'], $_POST['page_id'])) {
                $errors[] = $error_icon . $wo['lang']['current_password_mismatch'];
            }
            if (empty($errors)) {
                $page_data = Wo_PageData($_POST['page_id']);
                if ($page_data['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'], 'delete_page')) {
                    if (Wo_DeletePage($_POST['page_id']) === true) {
                        $data = array(
                            'status' => 200,
                            'message' => $success_icon . $wo['lang']['page_deleted'],
                            'location' => Wo_SeoLink('index.php?link1=pages')
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
    if ($s == 'add_admin') {
        $data = array(
            'status' => 304
        );
        if (isset($_GET['page_id']) && isset($_GET['user_id'])) {
            $page_data = Wo_PageData($_GET['page_id']);
            if ($page_data['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_GET['page_id'], 'admins')) {
                $page = Wo_Secure($_GET['page_id']);
                $user = Wo_Secure($_GET['user_id']);
                $code = Wo_AddPageAdmin($user, $page);
                if ($code === 1) {
                    $data['status'] = 200;
                    $data['code']   = 1;
                } else if ($code === 0) {
                    $data['status'] = 200;
                    $data['code']   = 0;
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_mbr' && isset($_GET['name']) && isset($_GET['page']) && is_numeric($_GET['page'])) {
        $data      = array(
            'status' => 304
        );
        $name      = Wo_Secure($_GET['name']);
        $page      = Wo_Secure($_GET['page']);
        $users     = Wo_GetUsersByName($name);
        $html      = '';
        $page_data = Wo_PageData($page);
        if (is_array($users) && count($users) > 0) {
            foreach ($users as $wo['member']) {
                $wo['member']['page_id']       = $page;
                $wo['member']['is_page_onwer'] = $page_data['is_page_onwer'];
                $wo['member']['page_name']     = $page_data['page_name'];
                $html .= Wo_LoadPage('page-setting/admin-list');
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_more_likes') {
        $html = '';
        if (isset($_GET['user_id']) && isset($_GET['after_last_id'])) {
            foreach (Wo_GetLikes($_GET['user_id'], 'profile', 10, $_GET['after_last_id']) as $wo['PageList']) {
                $html .= Wo_LoadPage('timeline/likes-list');
            }
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_next_page') {
        $html    = '';
        $page_id = (!empty($_GET['page_id'])) ? $_GET['page_id'] : 0;
        foreach (Wo_PageSug(1, $page_id) as $wo['PageList']) {
            $wo['PageList']['user_name'] = $wo['PageList']['name'];
            $html                        = Wo_LoadPage('sidebar/sidebar-home-page-list');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_likes') {
        $html = '';
        if (!empty($_GET['user_id'])) {
            foreach (Wo_GetLikes($_GET['user_id'], 'sidebar', 12) as $wo['PageList']) {
                $wo['PageList']['user_name'] = @mb_substr($wo['PageList']['name'], 0, 10, "utf-8");
                $html .= Wo_LoadPage('sidebar/sidebar-page-list');
            }
            $data = array(
                'status' => 200,
                'html' => $html
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'rate_page' && isset($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && isset($_POST['val'])) {
        $val  = Wo_Secure($_POST['val']);
        $id   = Wo_Secure($_POST['page_id']);
        $text = Wo_Secure($_POST['text']);
        $data = array(
            'status' => 304,
            'message' => $wo['lang']['page_rated']
        );
        if (Wo_RatePage($id, $val, $text)) {
            $data['status'] = 200;
            $data['val']    = $val;
            unset($data['message']);
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'load_reviews' && isset($_GET['page']) && isset($_GET['after_id'])) {
        $page_id = Wo_Secure($_GET['page']);
        $id      = Wo_Secure($_GET['after_id']);
        $data    = array(
            'status' => 404
        );
        $reviews = Wo_GetPageReviews($page_id, $id);
        $html    = '';
        if (count($reviews) > 0) {
            foreach ($reviews as $wo['review']) {
                $html .= Wo_LoadPage('page/review-list');
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'privileges') {
        if (!empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0 && !empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0) {
            $page_data = Wo_PageData($_POST['page_id']);
            if ($page_data['user_id'] == $wo['user']['id'] || Wo_IsCanPageUpdate($_POST['page_id'], 'admins')) {
                $update_array = array(
                    'general' => 0,
                    'info' => 0,
                    'social' => 0,
                    'avatar' => 0,
                    'design' => 0,
                    'admins' => 0,
                    'analytics' => 0,
                    'delete_page' => 0
                );
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
                if (Wo_UpdatePageAdminData($_POST['page_id'], $update_array, $_POST['user_id'])) {
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
