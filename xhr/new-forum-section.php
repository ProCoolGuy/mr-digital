<?php 
if ($f == "new-forum-section" && Wo_IsAdmin() == true) {
    if (empty($_POST['name']) || empty($_POST['description'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } else {
        if (strlen($_POST['name']) < 5) {
            $error = $error_icon . $wo['lang']['title_more_than10'];
        }
        if (strlen($_POST['name']) > 145) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        }
        if (strlen($_POST['description']) < 5) {
            $error = $error_icon . $wo['lang']['desc_more_than32'];
        }
    }
    if (empty($error)) {
        $registration_data = array(
            'section_name' => Wo_Secure($_POST['name']),
            'description' => Wo_Secure($_POST['description'])
        );
        if (Wo_AddForumSection($registration_data)) {
            $data = array(
                'message' => $success_icon . $wo['lang']['forum_post_added'],
                'status' => 200
            );
        } else {
            $data = array(
                'status' => 500,
                'message' => $wo['lang']['please_check_details']
            );
        }
    } else {
        $data = array(
            'status' => 500,
            'message' => $error
        );
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
