<?php 
$response_data = array(
    'api_status' => 400,
);

if (empty($_POST['id'])) {
    $error_code    = 3;
    $error_message = 'id (POST) is missing';
}
else{
    $post_id = Wo_GetPostIDFromOptionID($_POST['id']);
    if (Wo_IsPostVoted($post_id, $wo['user']['user_id'])) {
        $error_code    = 4;
        $error_message = 'you have already voted';
    } else {
        $vote = Wo_VoteUp($_POST['id'], $wo['user']['user_id']);
        if ($vote) {
            $response_data = array(
                'api_status' => 200,
                'votes' => Ju_GetPercentageOfOptionPost($post_id)
            );
        }
    }
}