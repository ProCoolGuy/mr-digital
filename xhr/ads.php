<?php 
if ($f == 'ads') {
    if ($s == 'new' && $wo['loggedin'] === true) {
        $request   = array();
        $request[] = (empty($_POST['name']) || empty($_POST['website']));
        $request[] = (empty($_POST['headline']) || empty($_POST['description']));
        $request[] = (empty($_POST['audience-list']) || empty($_POST['gender']));
        $request[] = (empty($_POST['bidding']) || empty($_FILES['media']));
        $request[] = (empty($_POST['appears']));
        $request[] = ($wo['user']['wallet'] == 0 || $wo['user']['wallet'] == '0.00');
        if (in_array(true, $request)) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        } else {
            if (strlen($_POST['name']) < 3 || strlen($_POST['name']) > 100) {
                $error = $error_icon . $wo['lang']['invalid_company_name'];
            } else if (!filter_var($_POST['website'], FILTER_VALIDATE_URL) || strlen($_POST['website'])  > 3000) {
                $error = $error_icon . $wo['lang']['enter_valid_url'];
            } else if (strlen($_POST['headline']) < 5 || strlen($_POST['headline']) > 200) {
                $error = $error_icon . $wo['lang']['enter_valid_title'];
            }
            if (!in_array($_FILES["media"]["type"], $ad_media_types)) {
                $error = $error_icon . $wo['lang']['select_valid_img_vid'];
            } else if (gettype($_POST['audience-list']) != 'array' || count($_POST['audience-list']) < 1) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            } else if ($_POST['bidding'] != 'clicks' && $_POST['bidding'] != 'views') {
                $error = $error_icon . $wo['lang']['please_check_details'];
            } else if (!in_array($_POST['appears'], array(
                    'post',
                    'sidebar',
                    'video',
                    'jobs',
                    'forum',
                    'movies',
                    'offer',
                    'funding',
                    'entire',
                ))) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            } else if (in_array($_POST['appears'], array(
                    'post',
                    'sidebar',
                    'jobs',
                    'forum',
                    'movies',
                    'offer',
                    'funding',
                    'entire',
                ))) {
                $img_types = array(
                    'image/png',
                    'image/jpeg',
                    'image/gif'
                );
                if (!in_array($_FILES["media"]["type"], $img_types)) {
                    $error = $error_icon . $wo['lang']['select_valid_img'];
                }
            } else if (in_array($_POST['appears'], array(
                    'video'
                ))) {
                $img_types = array(
                    'video/mp4',
                    'video/mov',
                    'video/avi'
                );
                if (!in_array($_FILES["media"]["type"], $img_types)) {
                    $error = $error_icon . $wo['lang']['select_valid_vid'];
                }
            } else if ($_FILES["media"]["size"] > $wo['config']['maxUpload'] || true) {
                $maxUpload = Wo_SizeUnits($wo['config']['maxUpload']);
                $error     = $error_icon . str_replace('{file_size}', $maxUpload, $wo['lang']['file_too_big']);
            }
        }
        if (empty($error)) {
            $page_id = 0;
            if (!empty($_POST['page'])) {
                $page_id = Wo_PageIdFromPagename($_POST['page']);
                if (empty($page_id)) {
                    $page_id = 0;
                }
            }
            $start = '';
            if (!empty($_POST['start'])) {
                $start = Wo_Secure($_POST['start']);
            }
            $end = '';
            if (!empty($_POST['end'])) {
                $end = Wo_Secure($_POST['end']);
            }
            $budget = 0;
            if (!empty($_POST['budget']) && is_numeric($_POST['budget']) && $_POST['budget'] > 0) {
                $budget = Wo_Secure($_POST['budget']);
            }
            
            
            $registration_data             = array(
                'name' => Wo_Secure($_POST['name']),
                'url' => Wo_Secure($_POST['website']),
                'headline' => Wo_Secure($_POST['headline']),
                'description' => Wo_Secure($_POST['description']),
                'location' => Wo_Secure($_POST['location']),
                'audience' => Wo_Secure(implode(',', $_POST['audience-list'])),
                'gender' => Wo_Secure($_POST['gender']),
                'bidding' => Wo_Secure($_POST['bidding']),
                'posted' => time(),
                'appears' => Wo_Secure($_POST['appears']),
                'user_id' => Wo_Secure($wo['user']['user_id']),
                'page_id' => $page_id,
                'start'   => $start,
                'end'   => $end,
                'budget'   => $budget
            );
            $fileInfo                      = array(
                'file' => $_FILES["media"]["tmp_name"],
                'name' => $_FILES['media']['name'],
                'size' => $_FILES["media"]["size"],
                'type' => $_FILES["media"]["type"],
                'types' => 'jpg,png,bmp,gif,mp4,avi,mov',
                'compress' => false
            );
            $media                         = Wo_ShareFile($fileInfo);
            $registration_data['ad_media'] = $media['filename'];
            $last_id                       = $db->insert(T_USER_ADS, $registration_data);
            $data                          = array(
                'message' => $success_icon . $wo['lang']['ad_added'],
                'status' => 200,
                'url' => Wo_SeoLink('index.php?link1=advertise')
            );
        } else {
            $data = array(
                'message' => $error,
                'status' => 500
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update' && $wo['loggedin'] === true) {
        $request   = array();
        $request[] = (empty($_GET['ad-id']) || !is_numeric($_GET['ad-id']));
        $request[] = (empty($_POST['name']) || empty($_POST['website']));
        $request[] = (empty($_POST['headline']) || empty($_POST['description']));
        $request[] = ($_GET['ad-id'] < 1 || empty($_POST['gender']));
        $request[] = (empty($_POST['bidding']) || empty($_POST['location']));
        $request[] = (empty($_POST['audience-list']) || !is_array($_POST['audience-list']));
        if (in_array(true, $request)) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        } else {
            if (strlen($_POST['name']) < 3 || strlen($_POST['name']) > 100) {
                $error = $error_icon . $wo['lang']['invalid_company_name'];
            } else if (!filter_var($_POST['website'], FILTER_VALIDATE_URL) || $_POST['website'] > 3000) {
                $error = $error_icon . $wo['lang']['enter_valid_url'];
            } else if (strlen($_POST['headline']) < 5 || strlen($_POST['headline']) > 200) {
                $error = $error_icon . $wo['lang']['enter_valid_title'];
            }
            if (!in_array($_POST['bidding'], array(
                'clicks',
                'views'
            ))) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            $img_types = array(
                'image/png',
                'image/jpeg',
                'image/gif',
                'image/jpg'
            );
            $video_types = array(
                    'video/mp4',
                    'video/mov',
                    'video/avi'
                );
            if (!empty($_FILES["media"]) && (!in_array($_FILES["media"]["type"], $img_types) && !in_array($_FILES["media"]["type"], $video_types)) ) {
                $error = $error_icon . $wo['lang']['select_valid_img'];
            }
            if (!empty($_FILES["media"]) && $_FILES["media"]["size"] > $wo['config']['maxUpload']) {
                $maxUpload = Wo_SizeUnits($wo['config']['maxUpload']);
                $error     = $error_icon . str_replace('{file_size}', $maxUpload, $wo['lang']['file_too_big']);
            }
        }
        if (empty($error)) {
            $update_data = array(
                'name' => Wo_Secure($_POST['name']),
                'url' => Wo_Secure($_POST['website']),
                'headline' => Wo_Secure($_POST['headline']),
                'description' => Wo_Secure($_POST['description']),
                'location' => Wo_Secure($_POST['location']),
                'audience' => Wo_Secure(implode(',', $_POST['audience-list'])),
                'gender' => Wo_Secure($_POST['gender']),
                'bidding' => Wo_Secure($_POST['bidding']),
                'posted' => time()
            );
            $adid        = Wo_Secure($_GET['ad-id']);

            if (!empty($_FILES["media"])) {
                $fileInfo                      = array(
                    'file' => $_FILES["media"]["tmp_name"],
                    'name' => $_FILES['media']['name'],
                    'size' => $_FILES["media"]["size"],
                    'type' => $_FILES["media"]["type"],
                    'types' => 'jpg,png,bmp,gif,mp4,avi,mov',
                    'compress' => false
                );
                $media                         = Wo_ShareFile($fileInfo);
                if (!empty($media['filename'])) {
                    $update_data['ad_media'] = $media['filename'];
                    $user_ad = $db->where('id',$adid)->getOne(T_USER_ADS);
                    if (!empty($user_ad->ad_media)) {
                        @unlink($user_ad->ad_media);
                    }
                }
            }



            $table       = T_USER_ADS;
            
            $user_id     = $wo['user']['id'];
            $db->where("id", $adid)->where("user_id", $user_id)->update($table, $update_data);
            $data = array(
                'message' => $success_icon . $wo['lang']['ad_saved'],
                'status' => 200,
                'url' => Wo_SeoLink('index.php?link1=advertise')
            );
            if (isset($_GET['a']) && $_GET['a'] == 1) {
                $data['url'] = Wo_SeoLink('index.php?link1=admincp&page=user_ads');
            }
        } else {
            $data = array(
                'message' => $error,
                'status' => 500
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'rads-c' && !empty($_GET['ad_id']) && is_numeric($_GET['ad_id'])) {
        $data = array(
            "status" => 304
        );
        $ad   = Wo_Secure($_GET['ad_id']);
        if (Wo_RegisterAdConversionClick($ad)) {
            $data['status'] = 200;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'rads-v' && !empty($_GET['ad_id']) && is_numeric($_GET['ad_id'])) {
        $data        = array(
            "status" => 304
        );
        $ad          = Wo_Secure($_GET['ad_id']);
        $get_ad_data = Wo_GetUserAdData($ad);
        if ($get_ad_data['bidding'] == 'clicks') {
            Wo_RegisterAdConversionClick($ad);
        } else {
            Wo_RegisterAdClick($ad);
        }
        $data['status'] = 200;
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'ts' && $wo['loggedin'] === true) {
        $data    = array(
            'status' => 304
        );
        $request = (!empty($_GET['ad_id']) && is_numeric($_GET['ad_id']));
        $user_id = $wo['user']['id'];
        if ($request === true) {
            $ad_id   = Wo_Secure($_GET['ad_id']);
            $ad_data = $db->where('id', $ad_id)->where('user_id', $user_id)->getOne(T_USER_ADS);
            if (!empty($ad_data)) {
                $up_data = array(
                    'status' => (($ad_data->status == 1) ? 0 : 1)
                );
                $db->where('id', $ad_id)->where('user_id', $user_id)->update(T_USER_ADS, $up_data);
                $data['status'] = 200;
                $data['ad']     = ($ad_data->status == 1) ? $wo['lang']['not_active'] : $data['ad'] = $wo['lang']['active'];
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'lm' && isset($_GET['ad_id']) && is_numeric($_GET['ad_id'])) {
        $html    = '';
        $data    = array(
            'status' => 404,
            'html' => $wo['lang']['no_result']
        );
        $last_id = Wo_Secure($_GET['ad_id']);
        $ads     = Wo_GetMyAds(array(
            'offset' => $last_id
        ));
        if ($ads && count($ads) > 0) {
            foreach ($ads as $wo['ad']) {
                $html .= Wo_LoadPage('ads/includes/ads-list');
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
    if ($s == 'alm' && isset($_GET['ad_id']) && is_numeric($_GET['ad_id'])) {
        $html    = '';
        $data    = array(
            'status' => 404,
            'html' => $wo['lang']['no_result']
        );
        $last_id = Wo_Secure($_GET['ad_id']);
        $ads     = Wo_GetAds($last_id);
        if ($ads && count($ads) > 0) {
            foreach ($ads as $wo['user_ad']) {
                $html .= Wo_LoadPage('admin/user_ads/ads-list');
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
    if ($s == 'get_estimated_users' && $wo['loggedin'] === true) {
        $data = array(
            'status' => 304
        );
        if (isset($_GET['estimated_audience']) && isset($_GET['estimated_gender'])) {
            if ($_GET['estimated_gender'] == "All") {
            } 
            elseif (in_array($_GET['estimated_gender'], array_keys($wo['genders']))){
                $gender = Wo_Secure($_GET['estimated_gender']);
                $db->where('gender', $gender);
            }
            if (!empty($_GET['estimated_audience'])) {
                $db->where('country_id', explode(",", $_GET['estimated_audience']), 'IN');
            }
            $count          = $db->getValue(T_USERS, "count(*)");
            $data['status'] = 200;
            $data['count']  = $count;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
