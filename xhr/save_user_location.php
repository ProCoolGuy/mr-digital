<?php 
if ($f == 'save_user_location' && isset($_POST['lat']) && isset($_POST['lng'])) {
    $lat          = $_POST['lat'];
    $lng          = $_POST['lng'];
    $update_array = array(
        'lat' => (is_numeric($lat)) ? $lat : 0,
        'lng' => (is_numeric($lng)) ? $lng : 0,
        'last_location_update' => (strtotime("+1 week"))
    );
    $data         = array(
        'status' => 304
    );
    if (Wo_UpdateUserData($wo['user']['id'], $update_array)) {
        $data['status'] = 200;
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
