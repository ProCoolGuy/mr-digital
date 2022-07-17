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
$response_data = array(
    'api_status' => 400
);

if (empty($_FILES["file"]["tmp_name"])) {
    $error_code    = 3;
    $error_message = 'file (STREAM FILE) is missing';
}
if (isset($_POST['story_title']) && strlen($_POST['story_title']) > 100) {
    $error_code    = 4;
    $error_message = 'Title is so long';
}
if (isset($_POST['story_description']) && strlen($_POST['story_description']) > 300) {
    $error_code    = 5;
    $error_message = 'Description is so long';
}
if (empty($_POST['file_type'])) {
    $error_code    = 6;
    $error_message = 'file_type (POST) is missing';
} else if (!in_array($_POST['file_type'], array(
        'video',
        'image'
    ))) {
    $error_code    = 7;
    $error_message = 'Incorrect value for (file_type), allowed: video|image';
}

if (empty($error_code)) {
    $amazone_s3                   = $wo['config']['amazone_s3'];
    $wasabi_storage                   = $wo['config']['wasabi_storage'];
    $ftp_upload                   = $wo['config']['ftp_upload'];
    $spaces                       = $wo['config']['spaces'];
    $cloud_upload                 = $wo['config']['cloud_upload'];
    $story_title       = (!empty($_POST['story_title'])) ? Wo_Secure($_POST['story_title']) : '';
    $story_description = (!empty($_POST['story_description'])) ? Wo_Secure($_POST['story_description']) : '';
    $file_type         = Wo_Secure($_POST['file_type']);
    $story_data        = array(
        'user_id' => $wo['user']['id'],
        'posted' => time(),
        'expire' => time()+(60*60*24),
        'title' => $story_title,
        'description' => $story_description
    );
    $last_id           = Wo_InsertUserStory($story_data);
    if ($last_id && is_numeric($last_id) && !empty($_FILES["file"]["tmp_name"])) {
        $true     = false;
        $sources  = array();
        $fileInfo = array(
            'file' => $_FILES["file"]["tmp_name"],
            'name' => $_FILES['file']['name'],
            'size' => $_FILES["file"]["size"],
            'type' => $_FILES["file"]["type"],
            'types' => 'jpg,png,mp4,gif,jpeg,mov,webm'
        );
        $media    = Wo_ShareFile($fileInfo);
        if (!empty($media)) {
            $filename = $media['filename'];
        }
        if ($filename) {
            $sources[] = array(
                'story_id' => $last_id,
                'type' => Wo_Secure($file_type),
                'filename' => $filename,
                'expire' => time()+(60*60*24)
            );
            $img_types     = array(
                'image/png',
                'image/jpeg',
                'image/jpg',
                'image/gif'
            );
            $thumb     = '';
            if (empty($thumb)) {
                if (in_array(strtolower(pathinfo($media['filename'], PATHINFO_EXTENSION)), array(
                                    "m4v",
                                    "avi",
                                    "mpg",
                                    'mp4'
                                )) && !empty($_FILES["cover"]) && in_array($_FILES["cover"]["type"], $img_types)) {
                    $fileInfo = array(
                        'file' => $_FILES["cover"]["tmp_name"],
                        'name' => $_FILES['cover']['name'],
                        'size' => $_FILES["cover"]["size"],
                        'type' => $_FILES["cover"]["type"]
                    );
                    $media            = Wo_ShareFile($fileInfo);
                    $file_type        = explode('/', $fileInfo['type']);
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
                            $crop_image = Wo_Resize_Crop_Image(400, 400, $thumb, $last_file, 60);
                            $upload_s3  = Wo_UploadToS3($last_file);
                            $thumb      = $last_file;
                        }
                    }
                }
            }
        }
        if (count($sources) > 0) {
            foreach ($sources as $registration_data) {
                Wo_InsertUserStoryMedia($registration_data);
            }
            if (empty($thumb) && $wo['config']['ffmpeg_system'] == 'on' && $file_type == 'video') {
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
            if (!empty($thumb)) {
                $thumb        = Wo_Secure($thumb);
                $mysqli_query = mysqli_query($sqlConnect, "UPDATE " . T_USER_STORY . " SET thumbnail = '$thumb' WHERE id = $last_id");
            }
            $response_data = array(
                'api_status' => 200,
                'story_id' => $last_id
            );
        }
    }
}