<?php
if ($f == 'invitation_links' && $wo['config']['invite_links_system'] == 1) {
    if ($s == 'create') {
        if (!empty($_POST['user_id']) && is_numeric($_POST['user_id']) && $_POST['user_id'] > 0 && (Wo_IsAdmin() || $wo['user']['id'] == $_POST['user_id']) && Wo_IfCanGenerateLink($_POST['user_id'])) {
            $user_id = Wo_Secure($_POST['user_id']);
            $code    = uniqid(rand(), true);
            $db->insert(T_INVITAION_LINKS, array(
                'user_id' => $user_id,
                'code' => $code,
                'time' => time()
            ));
            $data['status']  = 200;
            $data['message'] = $wo['lang']['code_successfully'];
        } else {
            $data['status']  = 400;
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
}
header("Content-type: application/json");
echo json_encode($data);
exit();
