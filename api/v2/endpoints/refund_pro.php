<?php
if ($wo['user']['is_pro'] != 0) {
    $requested = $db->where('user_id',$wo['user']['id'])->getValue(T_REFUND,"COUNT(*)");
    if (!empty($_POST['pro_type']) && !empty($_POST['description']) && $requested == 0) {
        $types = array('star' => 1,'hot' => 2,'ultima' => 3,'vip' => 4);
        if (in_array($_POST['pro_type'], array_keys($types)) && $types[$_POST['pro_type']] == $wo['user']['pro_type']) {
            $registration_data = array(
                'user_id' => $wo['user']['id'],
                'pro_type' => Wo_Secure($_POST['pro_type']),
                'description' => Wo_Secure($_POST['description']),
                'time' => time(),
                'status' => 0
            );
            $db->insert(T_REFUND,$registration_data);
            $notification_data_array = array(
                'recipient_id' => 0,
                'type' => 'refund',
                'time' => time(),
                'admin' => 1
            );
            $db->insert(T_NOTIFICATION,$notification_data_array);
            $response_data = array(
                        'api_status' => 200,
                        'message' => "Your request has been successfully sent, we will notify you once it&#039;s approved"
                    );
        }
        else{
        	$error_code    = 6;
		    $error_message = 'please select yourmembership';
        }
    }
    else{
        $error_code    = 5;
	    $error_message = 'please check your details';
    }
}
else{
    $error_code    = 4;
    $error_message = 'you are not a membership';
}