<?php
if ($wo['config']['website_mode'] != 'patreon') {
	exit();
}
$data = array('status' => 400);
if ($f == 'tier') {
    if ($s == 'add') {
        if (empty($_POST['title'])) {
            $data['message'] = $error_icon . $wo['lang']['title_empty'];
        }
        elseif (empty($_POST['price'])) {
            $data['message'] = $error_icon . $wo['lang']['price_empty'];
        }
        elseif (empty($_POST['benefits'])) {
            $data['message'] = $error_icon . $wo['lang']['benefits_empty'];
        }
        if (empty($data['message'])) {
            foreach ($_POST['benefits'] as $key => $value) {
                if (!in_array($value, array('chat','live_stream'))) {
                    $data['message'] = $error_icon . $wo['lang']['benefits_empty'];
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
                if ($value == 'chat') {
                    if (empty($_POST['chat']) || !in_array($_POST['chat'], array('chat_without_audio_video','chat_with_audio_without_video','chat_without_audio_with_video','chat_with_audio_video'))) {
                        $data['message'] = $error_icon . $wo['lang']['please_select_chat_type'];
                        header("Content-type: application/json");
                        echo json_encode($data);
                        exit();
                    }
                }
            }
            $image = '';
            if (!empty($_FILES['image'])) {
                $fileInfo = array(
                    'file' => $_FILES["image"]["tmp_name"],
                    'name' => $_FILES['image']['name'],
                    'size' => $_FILES["image"]["size"],
                    'type' => $_FILES["image"]["type"],
                    'types' => 'jpg,png,jpeg,gif'
                );
                $file     = Wo_ShareFile($fileInfo, 1);
                if (!empty($file) && !empty($file['filename'])) {
                    $image = $file['filename'];
                }
            }
            $description = '';
            if (!empty($_POST['description'])) {
                $description = Wo_Secure($_POST['description']);
            }
            $chat = '';
            if (!empty($_POST['chat']) && in_array($_POST['chat'], array('chat_without_audio_video','chat_with_audio_without_video','chat_without_audio_with_video','chat_with_audio_video'))) {
                $chat = Wo_Secure($_POST['chat']);
            }
            $live_stream = 0;
            if (in_array('live_stream', $_POST['benefits'])) {
                $live_stream = 1;
            }

            $insert_array = array('user_id' => $wo['user']['user_id'],
                                  'title' => Wo_Secure($_POST['title']),
                                  'price' => Wo_Secure($_POST['price']),
                                  'chat' => $chat,
                                  'image' => $image,
                                  'live_stream' => $live_stream,
                                  'time' => time(),
                                  'description' => $description);
            $db->insert(T_USER_TIERS,$insert_array);
            $data = array('status' => 200,
                          'message' => $wo['lang']['tier_added_successfully']);
        }
    }
    if ($s == 'edit') {
        if (empty($_POST['title'])) {
            $data['message'] = $error_icon . $wo['lang']['title_empty'];
        }
        elseif (empty($_POST['price'])) {
            $data['message'] = $error_icon . $wo['lang']['price_empty'];
        }
        elseif (empty($_POST['benefits'])) {
            $data['message'] = $error_icon . $wo['lang']['benefits_empty'];
        }
        if (empty($_POST['id']) || !is_numeric($_POST['id'])) {
            $data['message'] = $error_icon . $wo["lang"]["id_can_not_empty"];
        }
        if (empty($data['message'])) {
            foreach ($_POST['benefits'] as $key => $value) {
                if (!in_array($value, array('chat','live_stream'))) {
                    $data['message'] = $error_icon . $wo['lang']['benefits_empty'];
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
                if ($value == 'chat') {
                    if (empty($_POST['chat']) || !in_array($_POST['chat'], array('chat_without_audio_video','chat_with_audio_without_video','chat_without_audio_with_video','chat_with_audio_video'))) {
                        $data['message'] = $error_icon . $wo['lang']['please_select_chat_type'];
                        header("Content-type: application/json");
                        echo json_encode($data);
                        exit();
                    }
                }
            }
            $tier = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_TIERS);
            if (!empty($tier) && ($tier->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {

                $description = '';
                if (!empty($_POST['description'])) {
                    $description = Wo_Secure($_POST['description']);
                }
                $chat = '';
                if (!empty($_POST['chat']) && in_array($_POST['chat'], array('chat_without_audio_video','chat_with_audio_without_video','chat_without_audio_with_video','chat_with_audio_video'))) {
                    $chat = Wo_Secure($_POST['chat']);
                }
                $live_stream = 0;
                if (in_array('live_stream', $_POST['benefits'])) {
                    $live_stream = 1;
                }

                $update_array = array('title' => Wo_Secure($_POST['title']),
                                      'price' => Wo_Secure($_POST['price']),
                                      'chat' => $chat,
                                      'live_stream' => $live_stream,
                                      'description' => $description);
                if (!empty($_FILES['image'])) {
                    $fileInfo = array(
                        'file' => $_FILES["image"]["tmp_name"],
                        'name' => $_FILES['image']['name'],
                        'size' => $_FILES["image"]["size"],
                        'type' => $_FILES["image"]["type"],
                        'types' => 'jpg,png,jpeg,gif'
                    );
                    $file     = Wo_ShareFile($fileInfo, 1);
                    if (!empty($file) && !empty($file['filename'])) {
                        $update_array['image'] = $file['filename'];
                    }
                }
                $db->where('id',$tier->id)->update(T_USER_TIERS,$update_array);
                $data = array('status' => 200,
                              'message' => $wo['lang']['tier_updated_successfully']);
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["you_not_owner"];
            }
        }
    }
    if ($s == 'delete') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $tier = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_TIERS);
            if (!empty($tier) && ($tier->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                if (!empty($tier->image)) {
                    @unlink($tier->image);
                    Wo_DeleteFromToS3($tier->image);
                }
                $db->where('id',$tier->id)->delete(T_USER_TIERS);
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
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}