<?php 
if ($f == "update_announcement_views") {
    if (isset($_GET['id'])) {
        $UpdateAnnouncementViews = Wo_UpdateAnnouncementViews($_GET['id']);
        if ($UpdateAnnouncementViews === true) {
            $data = array(
                'status' => 200
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
