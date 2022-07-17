<?php 
if ($f == 'nearby_users' && $wo['config']['find_friends'] == 1) {
    if ($s == 'load') {
        $name     = (isset($_GET['name'])) ? $_GET['name'] : false;
        $gender   = (isset($_GET['gender'])) ? $_GET['gender'] : false;
        $offset   = (isset($_GET['offset'])) ? $_GET['offset'] : false;
        $distance = (isset($_GET['distance'])) ? $_GET['distance'] : false;
        $relship  = (isset($_GET['relship'])) ? $_GET['relship'] : false;
        $status   = (isset($_GET['status'])) ? $_GET['status'] : false;
        $data     = array(
            'status' => 404
        );
        $html     = '';
        $filter   = array(
            'name' => $name,
            'gender' => $gender,
            'distance' => $distance,
            'offset' => $offset,
            'relship' => $relship,
            'status' => $status
        );
        $users    = Wo_GetNearbyUsers($filter);
        $users_info = array();
        if ($users && count($users) > 0) {
            foreach ($users as $wo['UsersList']) {
                $user_info['name'] = $wo['UsersList']['user_data']['name'];
                $user_info['lng'] = $wo['UsersList']['user_data']['lng'];
                $user_info['lat'] = $wo['UsersList']['user_data']['lat'];
                $users_info[] = $user_info;

                $html .= Wo_LoadPage('friends_nearby/includes/user-list');
            }
            $data['status'] = 200;
            $data['html']   = $html;
            $data['users_info']   = $users_info;
            $data['count']  = Wo_GetNearbyUsersCount($filter);
            //$data['count']  = count($users);
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
