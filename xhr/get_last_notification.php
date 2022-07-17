<?php
if ($f == 'get_last_notification') {
    if (Wo_CheckMainSession($hash_id) === true) {
        $data['html']  = '';
        $notifications = Wo_GetNotifications(array(
            'unread' => true,
            'limit' => 1,
            'delete_fromDB' => true
        ));
        foreach ($notifications as $wo['notification']) {
            $data['html']              = Wo_LoadPage('header/notifecation');
            $data['html']              = Wo_LoadPage('header/notification-popup');
            $data['icon']              = $wo['notification']['notifier']['avatar'];
            $data['title']             = $wo['notification']['notifier']['name'];
            $data['notification_text'] = $wo['notification']['type_text'];
            $data['url']               = $wo['notification']['url'];
            $data['id']                = $wo['notification']['id'];
            $data['pop']               = 200;
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
