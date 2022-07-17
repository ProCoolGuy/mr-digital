<?php 
if ($f == 'vote_up') {
    if (!empty($_GET['id']) && Wo_CheckMainSession($hash_id) === true) {
        $post_id = Wo_GetPostIDFromOptionID($_GET['id']);
        if (Wo_IsPostVoted($post_id, $wo['user']['user_id'])) {
            $data = array(
                'status' => 400,
                'text' => $wo['lang']['you_have_already_voted']
            );
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        } else {
            $vote = Wo_VoteUp($_GET['id'], $wo['user']['user_id']);
            if ($vote) {
                $data = array(
                    'status' => 200,
                    'votes' => Ju_GetPercentageOfOptionPost($post_id)
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
