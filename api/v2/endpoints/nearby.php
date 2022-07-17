<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'businesses',
                        'shops'
                    );
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'businesses') {
    	$data['limit'] = $limit;
    	$data['offset'] = $offset;
    	$data['name']   = (isset($_POST['name'])) ? $_POST['name'] : false;
    	$data['distance'] = (isset($_POST['distance'])) ? $_POST['distance'] : false;
		$jobs = Wo_GetNearbyBusiness($data);
		$response_data = array(
                            'api_status' => 200,
                            'data' => $jobs
                        );

    }
    elseif ($_POST['type'] == 'shops') {
    	$data['limit'] = $limit;
    	$data['offset'] = $offset;
    	$data['name']   = (isset($_POST['name'])) ? $_POST['name'] : false;
    	$data['distance'] = (isset($_POST['distance'])) ? $_POST['distance'] : false;
		$shops = Wo_GetNearbyShops($data);
		$response_data = array(
                            'api_status' => 200,
                            'data' => $shops
                        );

    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}