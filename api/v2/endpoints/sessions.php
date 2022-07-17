<?php

$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'get',
                        'delete'
                    );

$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'get') {
        $sessions = Wo_GetAllSessionsFromUserID($wo['user']['user_id']);
        $response_data = array(
                            'api_status' => 200,
                            'data' => $sessions
                        );
    }
    if ($_POST['type'] == 'delete') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $delete_session = $db->where('id', Wo_Secure($_POST['id']))->delete(T_APP_SESSIONS);
            if ($delete_session) {
                $response_data = array(
                                    'api_status' => 200,
                                    'message' => 'session deleted'
                                );
            }
        }
        else{
            $error_code    = 5;
            $error_message = 'id can not be empty';
        }
    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}