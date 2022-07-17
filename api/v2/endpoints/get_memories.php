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


if (!empty($_POST['type']) && in_array($_POST['type'], array('all','posts','friends'))) {
	$data = array('posts' => array(),'friends' => array());
	if ($_POST['type'] == 'all') {
		$data['friends'] = Wo_GetMemoriesFreinds($wo['user']['user_id']);
		$data['posts'] = Wo_GetMemoriesPosts($wo['user']['user_id']);
	}
	elseif ($_POST['type'] == 'friends') {
		$data['friends'] = Wo_GetMemoriesFreinds($wo['user']['user_id']);
	}
	elseif ($_POST['type'] == 'posts') {
		$data['posts'] = Wo_GetMemoriesPosts($wo['user']['user_id']);
	}

    if (!empty($data['friends'])) {
    	foreach ($data['friends'] as $key => $value) {
	        foreach ($non_allowed as $key4 => $value4) {
	          unset($data['friends'][$key][$value4]);
	        }
	    }
    }
    if (!empty($data['posts'])) {
    	foreach ($data['posts'] as $key => $value) {
	        foreach ($non_allowed as $key4 => $value4) {
	          unset($data['posts'][$key]['publisher'][$value4]);
	        }
	    }
    }
	

	$response_data = array(
                        'api_status' => 200,
                        'data' => $data
                    );

}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}