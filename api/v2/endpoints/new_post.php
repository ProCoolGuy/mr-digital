<?php
if (!empty($_POST['postText'])) {


    if (preg_match('%(?:youtube(?:-nocookie)?\.com/(?:[^/]+/.+/|(?:v|e(?:mbed)?)/|.*[?&]v=)|youtu\.be/)([^"&?/ ]{11})%i', $_POST["postText"], $match)) {
        $youtube_video = Wo_Secure($match[1]);
        $api_request   = file_get_contents('https://www.googleapis.com/youtube/v3/videos?id=' . $youtube_video . '&key=AIzaSyDoOC41IwRzX5XvP7bNiCJXJfcK14HalM0&part=snippet,contentDetails,statistics,status');
        $thumbnail     = '';
        if (!empty($api_request)) {
            $json_decode = json_decode($api_request);
            if (!empty($json_decode->items[0]->snippet)) {
                if (!empty($json_decode->items[0]->snippet->thumbnails->maxres->url)) {
                    $thumbnail = $json_decode->items[0]->snippet->thumbnails->maxres->url;
                }
                if (!empty($json_decode->items[0]->snippet->thumbnails->medium->url)) {
                    $thumbnail = $json_decode->items[0]->snippet->thumbnails->medium->url;
                }
                $info        = $json_decode->items[0]->snippet;
                $title       = $info->title;
                $description = $info->description;
                if (!empty($json_decode->items[0]->snippet->tags)) {
                    if (is_array($json_decode->items[0]->snippet->tags)) {
                        foreach ($json_decode->items[0]->snippet->tags as $key => $tag) {
                            $tags_array[] = $tag;
                        }
                        $tags = implode(',', $tags_array);
                    }
                }
            }
            // $output = array(
            //     'title' => $title,
            //     'images' => array(
            //         $thumbnail
            //     ),
            //     'content' => $description,
            //     'url' => $_POST["postText"]
            // );

            $_POST['url_title'] = $title;
            $_POST['url_content'] = $description;
            $_POST['url_image'] = $thumbnail;
            $_POST['url_link'] = $_POST["postText"];
        }
    } else if (isset($_POST["postText"])) {
        $link_regex = '/(http\:\/\/|https\:\/\/|www\.)([^\ ]+)/i';
        $i          = 0;
        preg_match_all($link_regex, $_POST['postText'], $matches);
        if (!empty($matches) && !empty($matches[0]) && !empty($matches[0][0])) {
            //include_once("assets/libraries/simple_html_dom.inc.php");
            $page_title = '';
            $image_urls = array();
            $page_body  = '';
            $get_url    = strip_tags($matches[0][0]);
            $save = IsSaveUrl($get_url);
            if ($save['status'] == 200) {
                if ($save['type'] == 'image') {
                    $get_image = getimagesize($get_url);
                    $image_urls[] = $get_url;
                    $page_title   = 'Image';
                }
                else {
                    include_once("assets/libraries/simple_html_dom.inc.php");
                    $get_content = file_get_html($get_url);
                    foreach ($get_content->find('title') as $element) {
                        @$page_title = $element->plaintext;
                    }
                    if (empty($page_title)) {
                        $page_title = '';
                    }
                    @$page_body = $get_content->find("meta[name='description']", 0)->content;
                    $page_body = mb_substr($page_body, 0, 250, "utf-8");
                    if ($page_body === false) {
                        $page_body = '';
                    }
                    if (empty($page_body)) {
                        @$page_body = $get_content->find("meta[property='og:description']", 0)->content;
                        $page_body = mb_substr($page_body, 0, 250, "utf-8");
                        if ($page_body === false) {
                            $page_body = '';
                        }
                    }
                    $image_urls = array();
                    @$page_image = $get_content->find("meta[property='og:image']", 0)->content;
                    if (!empty($page_image)) {
                        if (preg_match('/[\w\-]+\.(jpg|png|gif|jpeg)/', $page_image)) {
                            $image_urls[] = $page_image;
                        }
                    } else {
                        foreach ($get_content->find('img') as $element) {
                            if (!preg_match('/blank.(.*)/i', $element->src)) {
                                if (preg_match('/[\w\-]+\.(jpg|png|gif|jpeg)/', $element->src)) {
                                    $image_urls[] = $element->src;
                                }
                            }
                        }
                    }
                }
                $_POST['url_title'] = $page_title;
                $_POST['url_content'] = $page_body;
                $_POST['url_image'] = $image_urls[0];
                $_POST['url_link'] = $_POST["postText"];
            }
        }
    }

}




$media         = '';
$mediaFilename = '';
$mediaName     = '';
$html          = '';
$recipient_id  = 0;
$page_id       = 0;
$event_id       = 0;
$group_id      = 0;
$image_array   = array();
if (isset($_POST['recipient_id']) && !empty($_POST['recipient_id'])) {
    $recipient_id = Wo_Secure($_POST['recipient_id']);
} else if (isset($_POST['page_id']) && !empty($_POST['page_id'])) {
    $page_id = Wo_Secure($_POST['page_id']);
} else if (isset($_POST['event_id']) && !empty($_POST['event_id'])) {
    $event_id = Wo_Secure($_POST['event_id']);
} else if (isset($_POST['group_id']) && !empty($_POST['group_id'])) {
    $group_id = Wo_Secure($_POST['group_id']);
    $group    = Wo_GroupData($group_id);
    if (!empty($group['id'])) {
        if ($group['privacy'] == 1) {
            $_POST['postPrivacy'] = 0;
        } else if ($group['privacy'] == 2) {
            $_POST['postPrivacy'] = 2;
        }
    }
}
if (isset($_FILES['postFile']['name'])) {
    $fileInfo = array(
        'file' => $_FILES["postFile"]["tmp_name"],
        'name' => $_FILES['postFile']['name'],
        'size' => $_FILES["postFile"]["size"],
        'type' => $_FILES["postFile"]["type"]
    );
    $media    = Wo_ShareFile($fileInfo);
    if (!empty($media)) {
        $mediaFilename = $media['filename'];
        $mediaName     = $media['name'];
    }
    if (empty($mediaFilename)) {
    	$error_code    = 7;
		$error_message = 'invalid file';
    }
}
$not_video = true;
$ffmpeg_convert_video = '';
if (isset($_FILES['postVideo']['name']) && empty($mediaFilename)) {
    $mimeType = mime_content_type($_FILES['postVideo']['tmp_name']);
    $fileType = explode('/', $mimeType)[0]; // video|image
    if ($fileType === 'video' && Wo_IsFfmpegFileAllowed($_FILES['postVideo']['name']) && !Wo_IsVideoNotAllowedMime($_FILES["postVideo"]["type"])) {
        $not_video = false;
    }
    if ($wo['config']['ffmpeg_system'] == 'on' && $not_video) {
        $error_code    = 8;
        $error_message = 'invalid file';
        $response_data = array(
            'api_status' => '404',
            'errors' => array(
                'error_id' => $error_code,
                'error_text' => $error_message
            )
        );
        echo json_encode($response_data, JSON_PRETTY_PRINT);
        exit();
    }
    $fileInfo = array(
        'file' => $_FILES["postVideo"]["tmp_name"],
        'name' => $_FILES['postVideo']['name'],
        'size' => $_FILES["postVideo"]["size"],
        'type' => $_FILES["postVideo"]["type"]
    );
    if ($wo['config']['ffmpeg_system'] != 'on') {
        $fileInfo['types'] = 'mp4,m4v,webm,flv,mov,mpeg,mkv';
    }
    if ($wo['config']['ffmpeg_system'] == 'on') {
        if ($not_video == false) {
            $fileInfo['is_video'] = 1;
        }
        $amazone_s3                   = $wo['config']['amazone_s3'];
        $wasabi_storage               = $wo['config']['wasabi_storage'];
        $ftp_upload                   = $wo['config']['ftp_upload'];
        $spaces                       = $wo['config']['spaces'];
        $cloud_upload                 = $wo['config']['cloud_upload'];
        $wo['config']['amazone_s3']   = 0;
        $wo['config']['wasabi_storage']   = 0;
        $wo['config']['ftp_upload']   = 0;
        $wo['config']['spaces']       = 0;
        $wo['config']['cloud_upload'] = 0;
    }
    $media    = Wo_ShareFile($fileInfo);
    if ($wo['config']['ffmpeg_system'] == 'on') {
        $wo['config']['amazone_s3']   = $amazone_s3;
        $wo['config']['wasabi_storage']   = $wasabi_storage;
        $wo['config']['ftp_upload']   = $ftp_upload;
        $wo['config']['spaces']       = $spaces;
        $wo['config']['cloud_upload'] = $cloud_upload;
    }
    if (!empty($media)) {
        $mediaFilename = $media['filename'];
        $mediaName     = $media['name'];
        if (!empty($mediaFilename) && $wo['config']['ffmpeg_system'] == 'on') {
            $ffmpeg_convert_video = $mediaFilename;
        }
    }
    if (empty($mediaFilename)) {
    	$error_code    = 8;
		$error_message = 'invalid file';
    }
}
if (isset($_FILES['postMusic']['name']) && empty($mediaFilename)) {
    $fileInfo = array(
        'file' => $_FILES["postMusic"]["tmp_name"],
        'name' => $_FILES['postMusic']['name'],
        'size' => $_FILES["postMusic"]["size"],
        'type' => $_FILES["postMusic"]["type"],
        'types' => 'mp3,wav'
    );
    $media    = Wo_ShareFile($fileInfo);
    if (!empty($media)) {
        $mediaFilename = $media['filename'];
        $mediaName     = $media['name'];
    }
    if (empty($mediaFilename)) {
    	$error_code    = 9;
		$error_message = 'invalid file';
    }
}
$multi = 0;
if (isset($_FILES['postPhotos']['name']) && empty($mediaFilename) && empty($_POST['album_name'])) {
    
    if (count($_FILES['postPhotos']['name']) == 1) {
        if ($_FILES['postPhotos']['size'][0] > $wo['config']['maxUpload']) {
            $invalid_file = 1;
        } else if (Wo_IsFileAllowed($_FILES['postPhotos']['name'][0]) == false) {
            $invalid_file = 2;
        } else {
            $fileInfo = array(
                'file' => $_FILES["postPhotos"]["tmp_name"][0],
                'name' => $_FILES['postPhotos']['name'][0],
                'size' => $_FILES["postPhotos"]["size"][0],
                'type' => $_FILES["postPhotos"]["type"][0]
            );
            $media    = Wo_ShareFile($fileInfo);
            if (!empty($media)) {
                $mediaFilename = $media['filename'];
                $mediaName     = $media['name'];
            }
            if (empty($mediaFilename)) {
            	$error_code    = 10;
				$error_message = 'invalid file';
            }
        }
    } else {
        $multi = 1;
    }
}
if (empty($_POST['postPrivacy'])) {
    $_POST['postPrivacy'] = 0;
}
$post_privacy  = 0;
$privacy_array = array(
    '0',
    '1',
    '2',
    '3',
    '4'
);
if (isset($_POST['postPrivacy'])) {
    if (in_array($_POST['postPrivacy'], $privacy_array)) {
        $post_privacy = $_POST['postPrivacy'];
    }
}
$import_url_image = '';
$url_link         = '';
$url_content      = '';
$url_title        = '';
if (!empty($_POST['url_link']) && !empty($_POST['url_title'])) {
    $url_link  = $_POST['url_link'];
    $url_title = $_POST['url_title'];
    if (!empty($_POST['url_content'])) {
        $url_content = $_POST['url_content'];
    }
    if (!empty($_POST['url_image'])) {
        $import_url_image = @Wo_ImportImageFromUrl($_POST['url_image']);
    }
}
$post_text = '';
$post_map  = '';
if (!empty($_POST['postText']) && !ctype_space($_POST['postText'])) {
    $post_text = $_POST['postText'];
}
if (!empty($_POST['postMap'])) {
    $post_map = $_POST['postMap'];
}
$album_name = '';
if (!empty($_POST['album_name'])) {
    $album_name = $_POST['album_name'];
}
if (!isset($_FILES['postPhotos']['name'])) {
    $album_name = '';
}
$traveling = '';
$watching  = '';
$playing   = '';
$listening = '';
$feeling   = '';
if (!empty($_POST['feeling_type'])) {
    $array_types = array(
        'feelings',
        'traveling',
        'watching',
        'playing',
        'listening'
    );
    if (in_array($_POST['feeling_type'], $array_types)) {
        if ($_POST['feeling_type'] == 'feelings') {
            if (!empty($_POST['feeling'])) {
                if (array_key_exists($_POST['feeling'], $wo['feelingIcons'])) {
                    $feeling = $_POST['feeling'];
                }
            }
        } else if ($_POST['feeling_type'] == 'traveling') {
            if (!empty($_POST['feeling'])) {
                $traveling = $_POST['feeling'];
            }
        } else if ($_POST['feeling_type'] == 'watching') {
            if (!empty($_POST['feeling'])) {
                $watching = $_POST['feeling'];
            }
        } else if ($_POST['feeling_type'] == 'playing') {
            if (!empty($_POST['feeling'])) {
                $playing = $_POST['feeling'];
            }
        } else if ($_POST['feeling_type'] == 'listening') {
            if (!empty($_POST['feeling'])) {
                $listening = $_POST['feeling'];
            }
        }
    }
}
if (isset($_FILES['postPhotos']['name'])) {
    $allowed = array(
        'gif',
        'png',
        'jpg',
        'jpeg'
    );
    for ($i = 0; $i < count($_FILES['postPhotos']['name']); $i++) {
        if (count($_FILES['postPhotos']['name']) > 1) {
            $new_string = pathinfo($_FILES['postPhotos']['name'][$i]);
        } else {
            $new_string = pathinfo($_FILES['postPhotos']['name'][0]);
        }
        if (!in_array(strtolower($new_string['extension']), $allowed)) {
        	$error_code    = 11;
			$error_message = 'please check details';
        }
    }
}
if (!empty($_POST['answer']) && array_filter($_POST['answer'])) {
    if (!empty($_POST['postText'])) {
        foreach ($_POST['answer'] as $key => $value) {
            if (empty($value) || ctype_space($value)) {
            	$error_code    = 12;
				$error_message = 'Answer #' . ($key + 1) . ' is empty.';
            }
        }
    } else {
    	$error_code    = 13;
		$error_message = 'Please write the question.';
    }
}
if (empty($error_message)) {
    $is_option = false;
    if (!empty($_POST['answer']) && array_filter($_POST['answer'])) {
        $is_option = true;
    }
    $post_data = array(
        'user_id' => $wo['user']['user_id'],
        'page_id' => Wo_Secure($page_id),
        'event_id' => Wo_Secure($event_id),
        'group_id' => Wo_Secure($group_id),
        'postText' => Wo_Secure($post_text),
        'recipient_id' => Wo_Secure($recipient_id),
        'postFile' => Wo_Secure($mediaFilename, 0),
        'postFileName' => Wo_Secure($mediaName),
        'postMap' => Wo_Secure($post_map),
        'postPrivacy' => Wo_Secure($post_privacy),
        'postLinkTitle' => Wo_Secure($url_title),
        'postLinkContent' => Wo_Secure($url_content),
        'postLink' => Wo_Secure($url_link),
        'postLinkImage' => Wo_Secure($import_url_image, 0),
        'album_name' => Wo_Secure($album_name),
        'multi_image' => Wo_Secure($multi),
        'postFeeling' => Wo_Secure($feeling),
        'postListening' => Wo_Secure($listening),
        'postPlaying' => Wo_Secure($playing),
        'postWatching' => Wo_Secure($watching),
        'postTraveling' => Wo_Secure($traveling),
        'time' => time()
    );
    if (isset($_POST['postSticker']) && Wo_IsUrl($_POST['postSticker']) && empty($_FILES) && empty($_POST['postRecord'])) {
        $_POST['postSticker'] = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_POST['postSticker']);
        $_POST['postSticker'] = preg_replace('/\((.*?)\)/m', '', $_POST['postSticker']);
        $_POST['postSticker'] = strip_tags($_POST['postSticker']);
        $post_data['postSticker'] = $_POST['postSticker'];
    } else if (empty($_FILES['postPhotos']) && preg_match_all('/https?:\/\/(?:[^\s]+)\.(?:png|jpg|gif|jpeg)/', $post_data['postText'], $matches)) {
        if (!empty($matches[0][0]) && Wo_IsUrl($matches[0][0])) {
            $post_data['postPhoto'] = @Wo_ImportImageFromUrl($matches[0][0]);
        }
    }
    if (!empty($is_option)) {
        $post_data['poll_id'] = 1;
    }
    if (!empty($_POST['post_color']) && !empty($post_text) && empty($_POST['postRecord']) && empty($mediaFilename) && empty($mediaName) && empty($post_map) && empty($url_title) && empty($url_content) && empty($url_link) && empty($import_url_image) && empty($album_name) && empty($multi) && empty($video_thumb) && empty($post_data['postPhoto'])) {
        $post_data['color_id'] = Wo_Secure($_POST['post_color']);
    }
    if (!empty($ffmpeg_convert_video)) {
        $ffmpeg_b             = $wo['config']['ffmpeg_binary_file'];
        $video_file_full_path = dirname(__DIR__) . '/' . $ffmpeg_convert_video;
        $video_info           = shell_exec("$ffmpeg_b -i " . $video_file_full_path . " 2>&1");
        $re                   = '/[0-9]{3}+x[0-9]{3}/m';
        preg_match_all($re, $video_info, $min_str);
        $resolution = 0;
        if (!empty($min_str) && !empty($min_str[0]) && !empty($min_str[0][0])) {
            $substr = substr($video_info, strpos($video_info, $min_str[0][0]) - 3, 15);
            $re     = '/[0-9]+x[0-9]+/m';
            preg_match_all($re, $substr, $resolutions);
            if (!empty($resolutions) && !empty($resolutions[0]) && !empty($resolutions[0][0])) {
                $resolution = substr($resolutions[0][0], 0, strpos($resolutions[0][0], 'x'));
            }
        }
        $ret = array(
            'status' => 300
        );
        if ($resolution >= 640 || $resolution == 0) {
            $ret = array(
                'status' => 200,
                'message' => 'Your video is in process'
            );
        }
        ob_end_clean();
        header("Content-Encoding: none");
        header("Connection: close");
        ignore_user_abort();
        ob_start();
        header('Content-Type: application/json');
        echo json_encode($ret);
        $size = ob_get_length();
        header("Content-Length: $size");
        ob_end_flush();
        flush();
        session_write_close();
        if (is_callable('fastcgi_finish_request')) {
            fastcgi_finish_request();
        }
        $id = FFMPEGUpload(array(
            'filename' => $ffmpeg_convert_video,
            'id' => $id,
            'video_thumb' => $video_thumb,
            'post_data' => $post_data
        ));
    } else {
        $id = Wo_RegisterPost($post_data);
    }
    
    if ($id) {
        if ($is_option == true) {
            foreach ($_POST['answer'] as $key => $value) {
                $add_opition = Wo_AddOption($id, $value);
            }
        }
        if (isset($_FILES['postPhotos']['name'])) {
            if (count($_FILES['postPhotos']['name']) > 0) {
                for ($i = 0; $i < count($_FILES['postPhotos']['name']); $i++) {
                    $fileInfo = array(
                        'file' => $_FILES["postPhotos"]["tmp_name"][$i],
                        'name' => $_FILES['postPhotos']['name'][$i],
                        'size' => $_FILES["postPhotos"]["size"][$i],
                        'type' => $_FILES["postPhotos"]["type"][$i],
                        'types' => 'jpg,png,jpeg,gif'
                    );
                    $file     = Wo_ShareFile($fileInfo, 1);
                    if (!empty($file)) {
                        $media_album = Wo_RegisterAlbumMedia($id, $file['filename']);
                    }
                }
            }
        }
        $wo['story'] = Wo_PostData($id);
        $html .= Wo_LoadPage('story/content');
        $wo['story']['shared_info'] = null;

        if (!empty($wo['story']['postFile'])) {
            $wo['story']['postFile'] = Wo_GetMedia($wo['story']['postFile']);
        }
        if (!empty($wo['story']['postFileThumb'])) {
            $wo['story']['postFileThumb'] = Wo_GetMedia($wo['story']['postFileThumb']);
        }
        if (!empty($wo['story']['postPlaytube'])) {
            $wo['story']['postText'] = strip_tags($wo['story']['postText']);
        }



        if (!empty($wo['story']['publisher'])) {
            foreach ($non_allowed as $key4 => $value4) {
              unset($wo['story']['publisher'][$value4]);
            }
        }
        else{
            $wo['story']['publisher'] = null;
        }

        if (!empty($wo['story']['user_data'])) {
            foreach ($non_allowed as $key4 => $value4) {
              unset($wo['story']['user_data'][$value4]);
            }
        }
        else{
            $wo['story']['user_data'] = null;
        }

        if (!empty($wo['story']['parent_id'])) {
            $shared_info = Wo_PostData($wo['story']['parent_id']);
            if (!empty($shared_info)) {
                if (!empty($shared_info['publisher'])) {
                    foreach ($non_allowed as $key4 => $value4) {
                      unset($shared_info['publisher'][$value4]);
                    }
                }
                else{
                    $shared_info['publisher'] = null;
                }

                if (!empty($shared_info['user_data'])) {
                    foreach ($non_allowed as $key4 => $value4) {
                      unset($shared_info['user_data'][$value4]);
                    }
                }
                else{
                    $shared_info['user_data'] = null;
                }

                if (!empty($shared_info['get_post_comments'])) {
                    foreach ($shared_info['get_post_comments'] as $key3 => $comment) {

                        foreach ($non_allowed as $key5 => $value5) {
                          unset($shared_info['get_post_comments'][$key3]['publisher'][$value5]);
                        }
                    }
                }
            }
            $wo['story']['shared_info'] = $shared_info;
        }

        if (!empty($value['get_post_comments'])) {
            foreach ($value['get_post_comments'] as $key3 => $comment) {

                foreach ($non_allowed as $key5 => $value5) {
                  unset($wo['story']['get_post_comments'][$key3]['publisher'][$value5]);
                }
            }
        }
        $response_data = array('api_status' => 200,
        	                   'post_html' => $html,
        	                   'post_data' => $wo['story']);
    }
    else{
    	$error_code    = 14;
		$error_message = 'something went wrong';
    }
}