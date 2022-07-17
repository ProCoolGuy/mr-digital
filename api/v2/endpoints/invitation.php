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
                        'create',
                        'get'
                    );
if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {
    if ($_POST['type'] == 'create') {
    	if (Wo_IfCanGenerateLink($wo['user']['id'])) {
    		$code  = uniqid(rand(), true);
			$id = $db->insert(T_INVITAION_LINKS,array('user_id' => $wo['user']['id'],
				                                'code' => $code,
				                                'time' => time()));
			if ($id) {
				$response_data['link'] = $wo['config']['site_url'] . '/register?invite='. $code;
                $response_data['api_status'] = 200;
			}
			else{
				$error_code    = 6;
			    $error_message = 'something went wrong';
			}
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'you can not generate link';
    	}
    }
    if ($_POST['type'] == 'get') {
    	$data = array();
    	$invite = Wo_GetMyInvitaionCodes($wo['user']['id']);
    	if (!empty($invite)) {
    		$data = $invite;
    		foreach ($data as $key => $value) {
    			$data[$key]['link'] = $wo['config']['site_url'] . '/register?invite='. $value['code'];
    			$data[$key]['user_data'] = array();
    			if (!empty($value['invited_id'])) {
    				$data[$key]['user_data'] = Wo_UserData($value['invited_id']);
    				foreach ($non_allowed as $key1 => $value2) {
				       unset($data[$key]['user_data'][$value2]);
				    }
    			}
    		}
    	}
    	$response_data['available_links'] = Wo_GetAvailableLinks($wo['user']['id']);
		if ($wo['config']['user_links_limit'] > 0) {
			$response_data['generated_links'] = $wo['config']['user_links_limit'] - $wo['available_links'];
		}
		else{
			$response_data['generated_links'] = Wo_GetGeneratedLinks($wo['user']['id']);
		}
		$response_data['used_links'] = Wo_GetUsedLinks($wo['user']['id']);
    	$response_data['data'] = $data;
        $response_data['api_status'] = 200;

    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}