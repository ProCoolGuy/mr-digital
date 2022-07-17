<?php 
if ($f == 'get_more_hashtag_posts') {
    $html = '';
    if (isset($_POST['after_post_id']) && is_numeric($_POST['after_post_id']) && $_POST['after_post_id'] > 0) {
        $is_api = false;
        if (!empty($_POST['is_api'])) {
            $is_api = true;
        }
        $after_post_id = Wo_Secure($_POST['after_post_id']);
        foreach (Wo_GetHashtagPosts($_POST['hashtagName'], $after_post_id, 8) as $wo['story']) {
            if ($is_api == true) {
                $html .= Wo_LoadPage('story/api-posts');
            } else {
                $html .= Wo_LoadPage('story/content');
            }
        }
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
