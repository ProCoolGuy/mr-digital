<?php 
if ($f == "get_more_most_liked") {
    $html = '';
    if (isset($_GET['after_last_id']) && isset($_GET['lasttotal']) && isset($_GET['dt'])) {
        foreach (Wo_GetPosts(array(
            'filter_by' => 'most_liked',
            'publisher_id' => 0,
            'dt' => $_GET['dt'],
            'lasttotal' => $_GET['lasttotal'],
            'after_post_id' => $_GET['after_last_id'],
            'ids' => $_GET['ids']
        )) as $wo['story']) {
            if (is_array($wo['story'])) {
                $html .= sanitize_output(Wo_LoadPage('story/content'));
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
