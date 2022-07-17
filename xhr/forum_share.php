<?php 
if ($f == "forum_share") {
	if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
		$forum = Wo_GetForumInfo($_POST['id']);
		if (!empty($forum)) {
			$register = Wo_RegisterPost(array(
                'user_id' => Wo_Secure($wo['user']['user_id']),
                'forum_id' => $forum['forum']['id'],
                'postText' => $forum['forum']['name'],
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
