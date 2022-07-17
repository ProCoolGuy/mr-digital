<?php 
if ($f == 'delete_s') {
    if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
        $id = Wo_Secure($_POST['id']);
    }
    $check_session = $db->where('id', $id)->getOne(T_APP_SESSIONS);
    if (!empty($check_session)) {
        if (($check_session->user_id == $wo['user']['user_id']) || Wo_IsAdmin()) {
            $delete_session = $db->where('id', $id)->delete(T_APP_SESSIONS);
            if ($delete_session) {
                $data['status'] = 200;
            }
        }
    }
}
