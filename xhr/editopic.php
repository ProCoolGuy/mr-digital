<?php 
if ($f == "editopic" && Wo_CheckMainSession($hash_id) === true) {
    if (empty($_POST['headline']) || empty($_POST['topicpost'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } elseif (!isset($_GET['tid']) || !is_numeric($_GET['tid'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } else {
        if (strlen($_POST['headline']) < 10) {
            $error = $error_icon . $wo['lang']['title_more_than10'];
        }
    }
    if (empty($error)) {
        $update_data = array(
            'headline' => Wo_Secure($_POST['headline']),
            'post' => Wo_BbcodeSecure($_POST['topicpost'])
        );
        if (Wo_UpdateTopic($_GET['tid'], $update_data)) {
            $data = array(
                'message' => $success_icon . $wo['lang']['forum_post_added'],
                'status' => 200,
                'url' => Wo_SeoLink('index.php?link1=showthread&tid=' . $_GET['tid'])
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
