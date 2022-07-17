<?php 
if ($f == "update_notifications_settings") {
    if (isset($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && Wo_CheckSession($hash_id) === true) {
        $e_liked             = 0;
        $e_shared            = 0;
        $e_wondered          = 0;
        $e_commented         = 0;
        $e_followed          = 0;
        $e_liked_page        = 0;
        $e_visited           = 0;
        $e_mentioned         = 0;
        $e_joined_group      = 0;
        $e_accepted          = 0;
        $e_profile_wall_post = 0;
        $e_memory = 0;
        $array               = array(
            '0',
            '1'
        );
        if (!empty($_POST['e_liked'])) {
            if (in_array($_POST['e_liked'], $array)) {
                $e_liked = 1;
            }
        }
        if (!empty($_POST['e_shared'])) {
            if (in_array($_POST['e_shared'], $array)) {
                $e_shared = 1;
            }
        }
        if (!empty($_POST['e_wondered'])) {
            if (in_array($_POST['e_wondered'], $array)) {
                $e_wondered = 1;
            }
        }
        if (!empty($_POST['e_commented'])) {
            if (in_array($_POST['e_commented'], $array)) {
                $e_commented = 1;
            }
        }
        if (!empty($_POST['e_followed'])) {
            if (in_array($_POST['e_followed'], $array)) {
                $e_followed = 1;
            }
        }
        if (!empty($_POST['e_liked_page'])) {
            if (in_array($_POST['e_liked_page'], $array)) {
                $e_liked_page = 1;
            }
        }
        if (!empty($_POST['e_visited'])) {
            if (in_array($_POST['e_visited'], $array)) {
                $e_visited = 1;
            }
        }
        if (!empty($_POST['e_mentioned'])) {
            if (in_array($_POST['e_mentioned'], $array)) {
                $e_mentioned = 1;
            }
        }
        if (!empty($_POST['e_joined_group'])) {
            if (in_array($_POST['e_joined_group'], $array)) {
                $e_joined_group = 1;
            }
        }
        if (!empty($_POST['e_accepted'])) {
            if (in_array($_POST['e_accepted'], $array)) {
                $e_accepted = 1;
            }
        }
        if (!empty($_POST['e_profile_wall_post'])) {
            if (in_array($_POST['e_profile_wall_post'], $array)) {
                $e_profile_wall_post = 1;
            }
        }
        if (!empty($_POST['e_memory'])) {
            if (in_array($_POST['e_memory'], $array)) {
                $e_memory = 1;
            }
        }
        $Update_data = array(
            'e_liked' => $e_liked,
            'e_shared' => $e_shared,
            'e_wondered' => $e_wondered,
            'e_commented' => $e_commented,
            'e_followed' => $e_followed,
            'e_accepted' => $e_accepted,
            'e_mentioned' => $e_mentioned,
            'e_joined_group' => $e_joined_group,
            'e_liked_page' => $e_liked_page,
            'e_visited' => $e_visited,
            'e_profile_wall_post' => $e_profile_wall_post,
            'e_memory' => $e_memory
        );
        $Update_data = json_encode($Update_data);
        if (Wo_UpdateUserData($_POST['user_id'], array(
            'notification_settings' => $Update_data
        ))) {
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
