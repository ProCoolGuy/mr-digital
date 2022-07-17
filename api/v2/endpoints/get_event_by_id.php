<?php
if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
	$id = Wo_Secure($_POST['id']);
	$event              = Wo_EventData($id);
	$event_data = array();
	if (!empty($event)) {
		foreach ($non_allowed as $key4 => $value4) {
	      unset($event['user_data'][$value4]);
	    }
	    $event_data = $event;
	}
		
	$response_data = array(
                'status' => 200,
                'event_data' => $event_data
            );
}
else{
	$error_code    = 4;
    $error_message = 'id can not be empty';
}