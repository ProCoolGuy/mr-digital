<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'edit',
                        'delete',
                        'interested',
                        'going'
                    );

$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {
    $required_event_fields = array(
        'event_name',
        'event_location',
        'event_description',
        'event_start_date',
        'event_end_date',
        'event_start_time',
        'event_end_time',
        'event_id'
    );
    if ($_POST['type'] == 'edit') {
        foreach ($required_event_fields as $key => $value) {
            if (empty($_POST[$value]) && empty($error_code)) {
                $error_code    = 3;
                $error_message = $value . ' (POST) is missing';
            }
        }
        if (empty($error_code)) {
            $event_id          = Wo_Secure($_POST['event_id']);
            $event_name        = Wo_Secure($_POST['event_name']);
            $event_location    = Wo_Secure($_POST['event_location']);
            $event_description = Wo_Secure($_POST['event_description']);
            $event_start_date  = Wo_Secure($_POST['event_start_date']);
            $event_end_date    = Wo_Secure($_POST['event_end_date']);
            $event_start_time  = Wo_Secure($_POST['event_start_time']);
            $event_end_time    = Wo_Secure($_POST['event_end_time']);
            if (Is_EventOwner($event_id, $user = false, $admin = false)) {
                $registration_data = array(
                    'name' => $event_name,
                    'location' => $event_location,
                    'description' => $event_description,
                    'start_date' => $event_start_date,
                    'start_time' => $event_start_time,
                    'end_date' => $event_end_date,
                    'end_time' => $event_end_time
                );
                $result            = Wo_UpdateEvent($event_id, $registration_data);
                if ($result) {
                    if (!empty($_FILES["event-cover"]["tmp_name"])) {
                        $temp_name = $_FILES["event-cover"]["tmp_name"];
                        $file_name = $_FILES["event-cover"]["name"];
                        $file_type = $_FILES['event-cover']['type'];
                        $file_size = $_FILES["event-cover"]["size"];
                        Wo_UploadImage($temp_name, $file_name, 'cover', $file_type, $event_id, 'event');
                    }
                    $response_data = array(
                                    'api_status' => 200,
                                    'message_data' => 'Event successfully edited'
                                );
                }
            }
            else{
                $error_code    = 5;
                $error_message = 'You are not the event owner';
            }
        }
    }
    if ($_POST['type'] == 'delete') {

        if (empty($_POST['event_id'])) {
            $error_code    = 3;
            $error_message = 'event_id (POST) is missing';
        } 
        if (empty($error_code)) {
            $event_id          = Wo_Secure($_POST['event_id']);
            if (Is_EventOwner($event_id, $user = false, $admin = false)) {
                if (Wo_DeleteEvent($event_id)) {
                    $response_data = array(
                                    'api_status' => 200,
                                    'message_data' => 'Event successfully deleted'
                                );
                }
            }
            else{
                $error_code    = 5;
                $error_message = 'You are not the event owner';
            }
        }
    }
    if ($_POST['type'] == 'interested') {
        if (!empty($_POST['event_id']) && is_numeric($_POST['event_id']) && $_POST['event_id'] > 0) {
            $event_id = Wo_Secure($_POST['event_id']);
            $interested = Wo_GetInterestedEventsUsers($event_id,$offset,$limit);
            if (!empty($interested)) {
                foreach ($interested as $key => $value) {
                    foreach ($non_allowed as $key4 => $value4) {
                      unset($interested[$key][$value4]);
                    }
                }
                
            }
            $response_data = array(
                                'api_status' => 200,
                                'data' => $interested
                            );
        }
        else{
            $error_code    = 5;
            $error_message = 'event_id can not be empty';
        }
    }
    if ($_POST['type'] == 'going') {
        if (!empty($_POST['event_id']) && is_numeric($_POST['event_id']) && $_POST['event_id'] > 0) {
            $event_id = Wo_Secure($_POST['event_id']);
            $going = Wo_GetGoingEventsUsers($event_id,$offset,$limit);
            if (!empty($going)) {
                foreach ($going as $key => $value) {
                    foreach ($non_allowed as $key4 => $value4) {
                      unset($going[$key][$value4]);
                    }
                }
                
            }
            $response_data = array(
                                'api_status' => 200,
                                'data' => $going
                            );
        }
        else{
            $error_code    = 5;
            $error_message = 'event_id can not be empty';
        }
    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}









