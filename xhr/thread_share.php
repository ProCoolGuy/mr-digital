<?php
if ($f == "thread_share") {
    if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
        $thread = Wo_GetForumThreads(array(
            "id" => $_POST['id'],
            "preview" => true
        ));
        if (!empty($thread) && !empty($thread[0])) {
            $register = Wo_RegisterPost(array(
                'user_id' => Wo_Secure($wo['user']['user_id']),
                'thread_id' => $thread[0]['id'],
                'postText' => $thread[0]['headline'],
                'time' => time(),
                'postPrivacy' => '0'
            ));
            if ($register) {
                $data = array(
                    'status' => 200
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
