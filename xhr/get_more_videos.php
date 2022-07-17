<?php 
if ($f == "get_more_videos") {
    $html = '';
    if (isset($_GET['user_id']) && isset($_GET['after_last_id'])) {
        foreach (Wo_GetPosts(array(
            'filter_by' => 'video',
            'publisher_id' => $_GET['user_id'],
            'limit' => 10,
            'after_post_id' => $_GET['after_last_id']
        )) as $wo['story']) {
            if (isset($wo['story']['postFile']) && !empty($wo['story']['postFile'])) {
                $html .= '<div class="text-center video-data" data-video-id="' . $wo['story']['post_id'] . '">
                            <a href="' . $wo['story']['url'] . '" target="_blank">
                                <video><source src="' .  Wo_GetMedia($wo['story']['postFile']) . '" type="video/mp4"></video>
                            </a>
                        </div>';
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
