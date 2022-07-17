<?php
if ($f == 'status') {
    if ($s == 'new') {
        $data  = array(
            'message' => $error_icon . $wo['lang']['please_check_details'],
            'status' => 500
        );
        $error = false;
        if (!isset($_FILES['statusMedia'])) {
            $error = true;
        } else {
            if (gettype($_FILES['statusMedia']) != 'array' || count($_FILES['statusMedia']) < 1 || count($_FILES['statusMedia']) > 20) {
                $error = true;
            }
            if (isset($_POST['title']) && strlen($_POST['title']) > 100) {
                $error = true;
            }
            if (isset($_POST['description']) && strlen($_POST['description']) > 300) {
                $error = true;
            }
            if (!Wo_IsValidMimeType($_FILES['statusMedia']['type'])) {
                $error = true;
            }
        }
        if (!$error) {
            $amazone_s3                   = $wo['config']['amazone_s3'];
            $wasabi_storage                   = $wo['config']['wasabi_storage'];
            $ftp_upload                   = $wo['config']['ftp_upload'];
            $spaces                       = $wo['config']['spaces'];
            $cloud_upload                 = $wo['config']['cloud_upload'];
            $registration_data            = array();
            $registration_data['user_id'] = $wo['user']['id'];
            $registration_data['posted']  = time();
            $registration_data['expire']  = time() + (60 * 60 * 24);
            if (isset($_POST['title']) && strlen($_POST['title']) >= 2) {
                $registration_data['title'] = Wo_Secure($_POST['title']);
            }
            if (isset($_POST['description']) && strlen($_POST['description']) >= 10) {
                $registration_data['description'] = Wo_Secure($_POST['description']);
            }
            if (count($registration_data) > 0) {
                $last_id = Wo_InsertUserStory($registration_data);
                if ($last_id && is_numeric($last_id) && !empty($_FILES["statusMedia"])) {
                    $files   = Wo_MultipleArrayFiles($_FILES["statusMedia"]);
                    $sources = array();
                    $thumb   = '';
                    foreach ($files as $fileInfo) {
                        if (!in_array(strtolower(pathinfo($fileInfo['name'], PATHINFO_EXTENSION)), array(
                            "m4v",
                            "avi",
                            "mpg",
                            'mp4'
                        ))) {
                            $wo['config']['amazone_s3']   = 0;
                            $wo['config']['wasabi_storage']   = 0;
                            $wo['config']['ftp_upload']   = 0;
                            $wo['config']['spaces']       = 0;
                            $wo['config']['cloud_upload'] = 0;
                        }
                        if ($fileInfo['size'] > 0) {
                            $fileInfo['file'] = $fileInfo['tmp_name'];
                            if (empty($_FILES["cover"]) && $wo['config']['ffmpeg_system'] == 'on') {
                                $wo['config']['amazone_s3']   = 0;
                                $wo['config']['wasabi_storage']   = 0;
                                $wo['config']['ftp_upload']   = 0;
                                $wo['config']['spaces']       = 0;
                                $wo['config']['cloud_upload'] = 0;
                            }
                            $media = Wo_ShareFile($fileInfo);
                            if (!empty($media) && $media['filename'] && in_array(strtolower(pathinfo($media['filename'], PATHINFO_EXTENSION)), array(
                                "gif",
                                "jpg",
                                "png",
                                'jpeg'
                            ))) {
                                $image_file = Wo_GetMedia($media['filename']);
                                $blur       = 0;
                                $upload_p   = true;
                                if ($wo['config']['adult_images'] == 1 && detect_safe_search($image_file) == false && $wo['config']['adult_images_action'] == 1) {
                                    $blur = 1;
                                } elseif ($wo['config']['adult_images'] == 1 && detect_safe_search($image_file) == false && $wo['config']['adult_images_action'] == 0) {
                                    Wo_DeleteFromToS3($image_file);
                                    @unlink($media['filename']);
                                    $upload_p = false;
                                    Wo_DeleteStatus($last_id);
                                    $data = array(
                                        'status' => 400,
                                        'invalid_file' => 3
                                    );
                                    header("Content-type: application/json");
                                    echo json_encode($data);
                                    exit();
                                }
                            }
                            if (empty($_FILES["cover"]) && $wo['config']['ffmpeg_system'] == 'on') {
                                $ffmpeg_b         = $wo['config']['ffmpeg_binary_file'];
                                $total_seconds    = ffmpeg_duration($media['filename']);
                                $thumb_1_duration = (int) ($total_seconds > 10) ? 11 : 1;
                                $dir              = "upload/photos/" . date('Y') . '/' . date('m');
                                $image_thumb      = $dir . '/' . Wo_GenerateKey() . '_' . date('d') . '_' . md5(time()) . "_image.jpeg";
                                $output_thumb     = shell_exec("$ffmpeg_b -ss \"$thumb_1_duration\" -i " . $media['filename'] . " -vframes 1 -f mjpeg $image_thumb 2<&1");
                                if (file_exists($image_thumb) && !empty(getimagesize($image_thumb))) {
                                    $crop_image                   = Wo_Resize_Crop_Image(400, 400, $image_thumb, $image_thumb, 60);
                                    $wo['config']['amazone_s3']   = $amazone_s3;
                                    $wo['config']['wasabi_storage']   = $wasabi_storage;
                                    $wo['config']['ftp_upload']   = $ftp_upload;
                                    $wo['config']['spaces']       = $spaces;
                                    $wo['config']['cloud_upload'] = $cloud_upload;
                                    Wo_UploadToS3($image_thumb);
                                    $thumb = $image_thumb;
                                } else {
                                    @unlink($image_thumb);
                                }
                                $wo['config']['amazone_s3']   = $amazone_s3;
                                $wo['config']['wasabi_storage']   = $wasabi_storage;
                                $wo['config']['ftp_upload']   = $ftp_upload;
                                $wo['config']['spaces']       = $spaces;
                                $wo['config']['cloud_upload'] = $cloud_upload;
                                Wo_UploadToS3($media['filename']);
                            }
                            $file_type = explode('/', $fileInfo['type']);
                            if ($media['filename']) {
                                $sources[] = array(
                                    'story_id' => $last_id,
                                    'type' => $file_type[0],
                                    'filename' => $media['filename'],
                                    'expire' => time() + (60 * 60 * 24)
                                );
                            }
                            if (empty($thumb)) {
                                if (in_array(strtolower(pathinfo($media['filename'], PATHINFO_EXTENSION)), array(
                                    "gif",
                                    "jpg",
                                    "png",
                                    'jpeg'
                                ))) {
                                    $thumb             = $media['filename'];
                                    $explode2          = @end(explode('.', $thumb));
                                    $explode3          = @explode('.', $thumb);
                                    $last_file         = $explode3[0] . '_small.' . $explode2;
                                    $arrContextOptions = array(
                                        "ssl" => array(
                                            "verify_peer" => false,
                                            "verify_peer_name" => false
                                        )
                                    );
                                    $fileget           = file_get_contents(Wo_GetMedia($thumb), false, stream_context_create($arrContextOptions));
                                    if (!empty($fileget)) {
                                        $importImage = @file_put_contents($thumb, $fileget);
                                    }
                                    $crop_image                   = Wo_Resize_Crop_Image(400, 400, $thumb, $last_file, 60);
                                    $wo['config']['amazone_s3']   = $amazone_s3;
                                    $wo['config']['wasabi_storage']   = $wasabi_storage;
                                    $wo['config']['ftp_upload']   = $ftp_upload;
                                    $wo['config']['spaces']       = $spaces;
                                    $wo['config']['cloud_upload'] = $cloud_upload;
                                    $upload_s3                    = Wo_UploadToS3($last_file);
                                    $upload_s3                    = Wo_UploadToS3($media['filename']);
                                    $thumb                        = $last_file;
                                }
                            }
                        }
                    }
                    $img_types = array(
                        'image/png',
                        'image/jpeg',
                        'image/jpg',
                        'image/gif'
                    );
                    if (in_array(strtolower(pathinfo($media['filename'], PATHINFO_EXTENSION)), array(
                        "m4v",
                        "avi",
                        "mpg",
                        'mp4'
                    )) && !empty($_FILES["cover"]) && in_array($_FILES["cover"]["type"], $img_types)) {
                        $wo['config']['amazone_s3']   = 0;
                        $wo['config']['wasabi_storage']   = 0;
                        $wo['config']['ftp_upload']   = 0;
                        $wo['config']['spaces']       = 0;
                        $wo['config']['cloud_upload'] = 0;
                        $fileInfo                     = array(
                            'file' => $_FILES["cover"]["tmp_name"],
                            'name' => $_FILES['cover']['name'],
                            'size' => $_FILES["cover"]["size"],
                            'type' => $_FILES["cover"]["type"]
                        );
                        $media                        = Wo_ShareFile($fileInfo);
                        $file_type                    = explode('/', $fileInfo['type']);
                        if (empty($thumb)) {
                            if (in_array(strtolower(pathinfo($media['filename'], PATHINFO_EXTENSION)), array(
                                "gif",
                                "jpg",
                                "png",
                                'jpeg'
                            ))) {
                                $thumb             = $media['filename'];
                                $explode2          = @end(explode('.', $thumb));
                                $explode3          = @explode('.', $thumb);
                                $last_file         = $explode3[0] . '_small.' . $explode2;
                                $arrContextOptions = array(
                                    "ssl" => array(
                                        "verify_peer" => false,
                                        "verify_peer_name" => false
                                    )
                                );
                                $fileget           = file_get_contents(Wo_GetMedia($thumb), false, stream_context_create($arrContextOptions));
                                if (!empty($fileget)) {
                                    $importImage = @file_put_contents($thumb, $fileget);
                                }
                                $crop_image                   = Wo_Resize_Crop_Image(400, 400, $thumb, $last_file, 60);
                                $wo['config']['amazone_s3']   = $amazone_s3;
                                $wo['config']['wasabi_storage']   = $wasabi_storage;
                                $wo['config']['ftp_upload']   = $ftp_upload;
                                $wo['config']['spaces']       = $spaces;
                                $wo['config']['cloud_upload'] = $cloud_upload;
                                $upload_s3                    = Wo_UploadToS3($last_file);
                                $thumb                        = $last_file;
                            }
                        }
                    }
                    if (count($sources) > 0) {
                        foreach ($sources as $registration_data) {
                            Wo_InsertUserStoryMedia($registration_data);
                        }
                        if (!empty($thumb)) {
                            $thumb        = Wo_Secure($thumb, 0);
                            $mysqli_query = mysqli_query($sqlConnect, "UPDATE " . T_USER_STORY . " SET thumbnail = '$thumb' WHERE id = $last_id");
                        }
                        $data = array(
                            'message' => $success_icon . $wo['lang']['status_added'],
                            'status' => 200
                        );
                    }
                }
            }
        }
        if ($wo['loggedin'] == true) {
            Wo_CleanCache();
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'p' && isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0) {
        $data    = array(
            "status" => 404
        );
        $id      = Wo_Secure($_GET['id']);
        $html    = '';
        $stories = Wo_GetStroies(array(
            'user' => $id
        ));
        if (count($stories) > 0) {
            foreach ($stories as $wo['story']) {
                $html .= Wo_LoadPage('status/content');
            }
            $data = array(
                "status" => 200,
                "html" => $html
            );
        } else {
            $html = Wo_LoadPage('status/no-stories');
            $data = array(
                "status" => 404,
                "html" => $html
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'remove' && isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0) {
        $data = array(
            "status" => 304
        );
        if (Wo_DeleteStatus($_GET['id'])) {
            $data['status'] = 200;
            Wo_CleanCache();
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'lm' && isset($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] > 0) {
        $data    = array(
            'status' => 404
        );
        $html    = '';
        $stories = Wo_GetAllStories($_GET['offset']);
        if ($stories && count($stories) > 0) {
            foreach ($stories as $wo['status']) {
                $html .= Wo_LoadPage('admin/status/status-list');
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
    if ($s == 'remove_multi_status') {
        if (!empty($_POST['ids'])) {
            foreach ($_POST['ids'] as $key => $value) {
                if (is_numeric($value) && $value > 0) {
                    Wo_DeleteStatus(Wo_Secure($value));
                }
            }
            $data = array(
                'status' => 200
            );
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        }
    }
    if ($s == 'register_reaction') {
        $data            = array(
            'status' => 400
        );
        $reactions_types = array_keys($wo['reactions_types']);
        if (!empty($_GET['story_id']) && is_numeric($_GET['story_id']) && $_GET['story_id'] > 0 && !empty($_GET['reaction']) && in_array($_GET['reaction'], $reactions_types)) {
            $story_id = Wo_Secure($_GET['story_id']);
            $story    = $db->where('id', $story_id)->getOne(T_USER_STORY);
            if (!empty($story)) {
                $is_reacted = $db->where('user_id', $wo['user']['user_id'])->where('story_id', $story_id)->getValue(T_REACTIONS, 'COUNT(*)');
                if ($is_reacted > 0) {
                    $db->where('user_id', $wo['user']['user_id'])->where('story_id', $story_id)->delete(T_REACTIONS);
                }
                $db->insert(T_REACTIONS, array(
                    'user_id' => $wo['user']['id'],
                    'story_id' => $story_id,
                    'reaction' => Wo_Secure($_GET['reaction'])
                ));
                $text                    = 'story';
                $type2                   = Wo_Secure($_GET['reaction']);
                $notification_data_array = array(
                    'recipient_id' => $story->user_id,
                    'story_id' => $story->id,
                    'type' => 'reaction',
                    'text' => $text,
                    'type2' => $type2,
                    'url' => 'index.php?link1=timeline&u=' . $wo['user']['username'] . '&story=true&story_id=' . $story->id
                );
                Wo_RegisterNotification($notification_data_array);
                $data = array(
                    'status' => 200,
                    'reactions' => Wo_GetPostReactions($story_id, 'story'),
                    'like_lang' => $wo['lang']['liked']
                );
                if (Wo_CanSenEmails()) {
                    $data['can_send'] = 1;
                }
                $data['dislike'] = 0;
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
