<?php 
if ($f == 'delete_all_sessions') {
    $delete_session = $db->where('user_id', $wo['user']['user_id'])->delete(T_APP_SESSIONS);
    if ($delete_session) {
        $data['status'] = 200;
    }
}
