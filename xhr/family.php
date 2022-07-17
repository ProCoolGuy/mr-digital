<?php 
if ($f == 'family') {
    if ($s == 'add_member' && isset($_GET['member_id']) && isset($_GET['type'])) {
        $error = false;
        $data  = array(
            'status' => 304,
            'message' => $error_icon . $wo['lang']['please_check_details']
        );
        $html  = '';
        if (!is_numeric($_GET['member_id']) || $_GET['member_id'] < 1) {
            $error = true;
        }
        if (!is_numeric($_GET['type']) || $_GET['type'] < 1 || $_GET['type'] > 43) {
            $error = true;
        }
        if ($_GET['member_id'] == $wo['user']['id']) {
            $error = true;
        }
        if (!$error) {
            $relationship_type       = array(
                5,
                6,
                11,
                12,
                13,
                17,
                18,
                23,
                24,
                29,
                34,
                37,
                40
            );
            $registration_data_array = array(
                0 => array(
                    'member_id' => Wo_Secure($_GET['member_id']),
                    'member' => Wo_Secure($_GET['type']),
                    'active' => 0,
                    'user_id' => Wo_Secure($wo['user']['id']),
                    'requesting' => Wo_Secure($wo['user']['id'])
                )
            );
            if (in_array($_GET['type'], $relationship_type)) {
                $registration_data_array[] = array(
                    'member_id' => Wo_Secure($wo['user']['id']),
                    'member' => Wo_Secure($_GET['type']),
                    'active' => 0,
                    'user_id' => Wo_Secure($_GET['member_id']),
                    'requesting' => Wo_Secure($wo['user']['id'])
                );
            }
            foreach ($registration_data_array as $registration_data) {
                Wo_RegisterFamilyMember($registration_data);
            }
            $member_data = Wo_UserData($_GET['member_id']);
            if (!empty($member_data)) {
                $notification_data_array = array(
                    'recipient_id' => $_GET['member_id'],
                    'type' => 'added_u_as',
                    'user_id' => $wo['user']['id'],
                    'text' => $wo['lang']['sent_u_request'] . $wo['lang'][$wo['family'][Wo_Secure($_GET['type'])]],
                    'url' => 'index.php?link1=timeline&u=' . $member_data['username'] . '&type=requests'
                );
                $data['status']          = 200;
                $data['notification']    = boolval(Wo_RegisterNotification($notification_data_array));
                $data['message']         = $success_icon . $wo['lang']['request_sent'];
            }
        }
    }
    if ($s == 'delete_member' && isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0) {
        $member_id = Wo_Secure($_GET['id']);
        $data      = array(
            'status' => 304
        );
        if (Wo_DeleteFamilyMember($member_id)) {
            $data['status'] = 200;
        }
    }
    if ($s == 'accept_member' && isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0 && isset($_GET['type'])) {
        $member_id   = Wo_Secure($_GET['id']);
        $data        = array(
            'status' => 304
        );
        $member_data = Wo_UserData($member_id);
        if (Wo_AcceptFamilyMember($member_id) && !empty($member_data)) {
            $notification_data_array = array(
                'recipient_id' => $member_id,
                'type' => 'accept_u_as',
                'user_id' => $wo['user']['id'],
                'text' => $wo['lang']['request_accepted'] . $wo['lang'][$wo['family'][Wo_Secure($_GET['type'])]],
                'url' => 'index.php?link1=timeline&u=' . $member_data['username'] . '&type=family_list'
            );
            Wo_RegisterNotification($notification_data_array);
            $data['status'] = 200;
        }
    }
    if ($s == 'accept_relation' && isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0 && isset($_GET['type']) && isset($_GET['member'])) {
        $member_id   = Wo_Secure($_GET['member']);
        $id          = Wo_Secure($_GET['id']);
        $data        = array(
            'status' => 304
        );
        $member_data = Wo_UserData($member_id);
        if (Wo_AcceptRelationRequest($id, $member_id, Wo_Secure($_GET['type'])) && !empty($member_data)) {
            $notification_data_array = array(
                'recipient_id' => $member_id,
                'type' => 'accept_u_as',
                'user_id' => $wo['user']['id'],
                'text' => $wo['lang']['relhip_request_accepted'] . $wo['relationship'][Wo_Secure($_GET['type'])],
                'url' => 'index.php?link1=timeline&u=' . $member_data['username']
            );
            Wo_RegisterNotification($notification_data_array);
            $data['status'] = 200;
        }
    }
    if ($s == 'delete_relation' && isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0 && isset($_GET['user']) && isset($_GET['type'])) {
        if (is_numeric($_GET['user']) && $_GET['user'] > 0 && is_numeric($_GET['type']) && $_GET['type'] >= 1 && $_GET['type'] <= 4) {
            $id      = Wo_Secure($_GET['id']);
            $user_id = Wo_Secure($_GET['user']);
            $type    = Wo_Secure($_GET['type']);
            $data    = array(
                'status' => 304
            );
            if (Wo_DeleteRelationRequest($id)) {
                $data['status']          = 200;
                $notification_data_array = array(
                    'recipient_id' => $user_id,
                    'type' => 'rejected_u_as',
                    'user_id' => $wo['user']['id'],
                    'text' => $wo['lang']['relation_rejected'] . $wo['relationship'][$type],
                    'url' => 'index.php?link1=timeline&u=' . $wo['user']['username']
                );
                Wo_RegisterNotification($notification_data_array);
            }
        }
    }
    if ($s == 'search' && isset($_GET['name'])) {
        $name  = Wo_Secure($_GET['name']);
        $users = Wo_GetUsersByName($name);
        $data  = array(
            'status' => 404,
            'users' => array()
        );
        if ($users && count($users) > 0) {
            foreach ($users as $user) {
                $data['users'][] = array(
                    'user_id' => $user['user_id'],
                    'avatar' => $user['avatar'],
                    'name' => $user['name'],
                    'lastseen' => Wo_UserStatus($user['user_id'], $user['lastseen'])
                );
            }
            $data['status'] = 200;
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
