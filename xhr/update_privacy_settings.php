<?php 
if ($f == "update_privacy_settings") {
    if (isset($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && Wo_CheckSession($hash_id) === true) {
        $message_privacy         = 0;
        $follow_privacy          = 0;
        $post_privacy            = 'ifollow';
        $showlastseen            = 0;
        $confirm_followers       = 0;
        $show_activities_privacy = 0;
        $status                  = 0;
        $visit_privacy           = 0;
        $birth_privacy           = 0;
        $friend_privacy          = 0;
        $share_my_location       = 0;
        $share_my_data       = 0;
        $array                   = array(
            '0',
            '1'
        );
        $array_2                 = array(
            '0',
            '1',
            '2'
        );
        $array_two               = array(
            'everyone',
            'ifollow',
            'nobody'
        );
        $array_three             = array(
            '0',
            '1',
            '2',
            '3'
        );
        if (!empty($_POST['share_my_data'])) {
            if (in_array($_POST['share_my_data'], $array)) {
                $share_my_data = $_POST['share_my_data'];
            }
        }
        if (!empty($_POST['share_my_location'])) {
            if (in_array($_POST['share_my_location'], $array)) {
                $share_my_location = $_POST['share_my_location'];
            }
        }
        if (!empty($_POST['post_privacy'])) {
            if (in_array($_POST['post_privacy'], $array_two)) {
                $post_privacy = $_POST['post_privacy'];
            }
        }
        if (!empty($_POST['confirm_followers'])) {
            if (in_array($_POST['confirm_followers'], $array)) {
                $confirm_followers = $_POST['confirm_followers'];
            }
        }
        if (!empty($_POST['follow_privacy'])) {
            if (in_array($_POST['follow_privacy'], $array)) {
                $follow_privacy = $_POST['follow_privacy'];
            }
        }
        if (!empty($_POST['show_activities_privacy'])) {
            if (in_array($_POST['show_activities_privacy'], $array)) {
                $show_activities_privacy = $_POST['show_activities_privacy'];
            }
        }
        if (!empty($_POST['showlastseen'])) {
            if (in_array($_POST['showlastseen'], $array)) {
                $showlastseen = $_POST['showlastseen'];
            }
        }
        if (!empty($_POST['message_privacy'])) {
            if (in_array($_POST['message_privacy'], $array_2)) {
                $message_privacy = $_POST['message_privacy'];
            }
        }
        if (!empty($_POST['status'])) {
            if (in_array($_POST['status'], $array)) {
                $status = $_POST['status'];
            }
        }
        if (!empty($_POST['visit_privacy'])) {
            if (in_array($_POST['visit_privacy'], $array)) {
                $visit_privacy = $_POST['visit_privacy'];
            }
        }
        if (!empty($_POST['birth_privacy'])) {
            if (in_array($_POST['birth_privacy'], $array_2)) {
                $birth_privacy = $_POST['birth_privacy'];
            }
        }
        if (!empty($_POST['friend_privacy'])) {
            if (in_array($_POST['friend_privacy'], $array_three)) {
                $friend_privacy = $_POST['friend_privacy'];
            }
        }
        $userdata = Wo_UserData($_POST['user_id']);
        if ($wo['config']['pro'] == 1 && empty($_POST['showlastseen']) && empty($_POST['profileVisit'])) {
            if ($userdata['is_pro'] == 0) {
                $visit_privacy = 1;
                $showlastseen  = 1;
            }
        }
        $Update_data = array(
            'message_privacy' => $message_privacy,
            'follow_privacy' => $follow_privacy,
            'friend_privacy' => $friend_privacy,
            'post_privacy' => $post_privacy,
            'showlastseen' => $showlastseen,
            'confirm_followers' => $confirm_followers,
            'show_activities_privacy' => $show_activities_privacy,
            'visit_privacy' => $visit_privacy,
            'birth_privacy' => $birth_privacy,
            'status' => $status,
            'share_my_location' => $share_my_location,
            'share_my_data' => $share_my_data
        );
        if (Wo_UpdateUserData($_POST['user_id'], $Update_data)) {
            $data = array(
                'status' => 200,
                'message' => $success_icon . $wo['lang']['setting_updated']
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
