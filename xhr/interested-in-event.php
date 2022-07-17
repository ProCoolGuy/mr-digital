<?php 
if ($f == "interested-in-event") {
    $data = array(
        'status' => 500
    );
    if (isset($_GET['eid']) && is_numeric($_GET['eid'])) {
        if (Wo_AddEventInterestedUsers($_GET['eid'])) {
            $data['status'] = 200;
            $data['html']   = $wo['lang']['you_are_interested'];
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
