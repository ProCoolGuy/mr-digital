<?php 
if ($f == "refund_pro") {
    if (Wo_CheckSession($hash_id) === true) {
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
                    $data = array(
                        'message' => $success_icon . $wo['lang']['bank_transfer_request'],
                        'status' => 200,
                        'url' => Wo_SeoLink('index.php?link1=home')
                    );
                }
                else{
                    $error = $error_icon . $wo['lang']['select_your_membership'];
                }
            }
            else{
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
        }
        else{
            $error = $error_icon . $wo['lang']['you_not_membership'];
        }
        if (!empty($error)) {
            $data = array(
                'status' => 500,
                'message' => $error
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
