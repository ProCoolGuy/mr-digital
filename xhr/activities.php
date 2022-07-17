<?php 
if ($f == 'activities') {
    if ($s == 'get_new_activities') {
        if (!empty($_POST['before_activity_id']) && is_numeric($_POST['before_activity_id']) && $_POST['before_activity_id'] > 0) {
            $html     = '';
            $activity = Wo_GetActivities(array(
                'before_activity_id' => Wo_Secure($_POST['before_activity_id'])
            ));
            foreach ($activity as $wo['activity']) {
                $wo['activity']['unread'] = 'unread';
                $html .= Wo_LoadPage('sidebar/activities-list');
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
    if ($s == 'get_more_activities') {
        if (!empty($_POST['after_activity_id']) && is_numeric($_POST['after_activity_id']) && $_POST['after_activity_id'] > 0) {
            $html = '';
            $me = false;
            if (!empty($_POST['user_id'])) {
                $me = true;
            }
            foreach (Wo_GetActivities(array(
                'after_activity_id' => Wo_Secure($_POST['after_activity_id']),
                'me' => $me
            )) as $wo['activity']) {
                $html .= Wo_LoadPage('sidebar/activities-list');
            }
            $data = array(
                'status' => 200,
                'html' => $html
            );
            if (empty($html)) {
                $data['message'] = $wo['lang']['no_more_actitivties'];
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
