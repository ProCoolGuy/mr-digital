<?php 
if ($f == "get_more_photos") {
    $html = '';
    if (isset($_GET['user_id']) && isset($_GET['after_last_id'])) {
        foreach (Wo_GetPosts(array(
            'filter_by' => 'photos',
            'publisher_id' => $_GET['user_id'],
            'limit' => 10,
            'after_post_id' => $_GET['after_last_id']
        )) as $wo['story']) {
            if (isset($wo['story']['postFile']) && !empty($wo['story']['postFile'])) {
                if (!empty($wo['story']) && $wo['story']['blur'] == 1) {
                    $html .= '<div class="text-center photo-data" data-photo-id="' . $wo['story']['post_id'] . '">
                            <a href="javascript:Wo_OpenLightBox(' . $wo['story']['post_id'] . ');">
                                <img src="'. Wo_GetMedia($wo['story']['postFile']) . '" style="filter: blur(5px)">
                            </a>
                        </div>';
                }
                else{
                    $html .= '<div class="text-center photo-data" data-photo-id="' . $wo['story']['post_id'] . '">
                            <a href="javascript:Wo_OpenLightBox(' . $wo['story']['post_id'] . ');">
                                <img src="'. Wo_GetMedia($wo['story']['postFile']) . '" >
                            </a>
                        </div>';
                }
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
