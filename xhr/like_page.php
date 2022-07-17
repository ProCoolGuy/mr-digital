<?php 
if ($f == 'like_page') {
    if (!empty($_GET['page_id']) && Wo_CheckMainSession($hash_id) === true) {
        if (Wo_IsPageLiked($_GET['page_id'], $wo['user']['user_id']) === true) {
            if (Wo_DeletePageLike($_GET['page_id'], $wo['user']['user_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => Wo_GetLikeButton($_GET['page_id'])
                );
            }
        } else {
            if (Wo_RegisterPageLike($_GET['page_id'], $wo['user']['user_id'])) {
                $data = array(
                    'status' => 200,
                    'html' => Wo_GetLikeButton($_GET['page_id'])
                );
                if (Wo_CanSenEmails()) {
                    $data['can_send'] = 1;
                }
            }
        }
    }
    if ($wo['loggedin'] == true) {
        Wo_CleanCache();
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
