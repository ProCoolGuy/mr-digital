<?php 
if ($f == "editreply" && Wo_CheckMainSession($hash_id) === true) {
    if (empty($_POST['subject']) || empty($_POST['content'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } elseif (!isset($_GET['rid']) || !is_numeric($_GET['rid'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } elseif (!isset($_GET['tid']) || !is_numeric($_GET['tid'])) {
        $error = $error_icon . $wo['lang']['please_check_details'];
    } else {
        if (strlen($_POST['subject']) < 10) {
            $error = $error_icon . $wo['lang']['title_more_than10'];
        }
    }
    if (empty($error)) {
        $update_data = array(
            'post_subject' => Wo_Secure($_POST['subject']),
            'post_text' => Wo_BbcodeSecure($_POST['content'])
        );
        if (Wo_ThreadUpdate(Wo_Secure($_GET['rid']), $update_data)) {
            $data = array(
                'message' => $success_icon . $wo['lang']['reply_saved'],
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
