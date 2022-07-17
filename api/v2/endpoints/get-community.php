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

if (empty($_POST['user_id'])) {
    $error_code    = 4;
    $error_message = 'user_id (POST) is missing';
}
if (empty($_POST['fetch'])) {
    $error_code    = 3;
    $error_message = 'fetch (POST) is missing';
}
if (empty($error_code)) {
	$user_id  = Wo_Secure($_POST['user_id']);
    $recipient_data = Wo_UserData($user_id);
    if (empty($recipient_data)) {
        $error_code    = 6;
        $error_message = 'Recipient user not found';
    } else {
    	$response_data = array(
		    'api_status' => 200,
		);
    	$fetch = explode(',', $_POST['fetch']);
		$data = array();
		foreach ($fetch as $key => $value) {
			$data[$value] = $value;
		}
		if (!empty($data['my_groups'])) {
			$my_groups_offset = (!empty($_POST['my_groups_offset']) && is_numeric($_POST['my_groups_offset']) && $_POST['my_groups_offset'] > 0 ? Wo_Secure($_POST['my_groups_offset']) : 0);
	        $my_groups_limit = (!empty($_POST['my_groups_limit']) && is_numeric($_POST['my_groups_limit']) && $_POST['my_groups_limit'] > 0 && $_POST['my_groups_limit'] <= 50 ? Wo_Secure($_POST['my_groups_limit']) : 20);
			$groups = Wo_GetMyGroupsAPI($my_groups_limit,$my_groups_offset,'DESC');
			foreach ($groups as $key => $group) {
			    $groups[$key]['members'] = Wo_CountGroupMembers($group['id']);
			}
			$response_data = array(
			                        'api_status' => 200,
			                        'data' => $groups
			                    );
		}
		if (!empty($data['joined_groups'])) {
			if (!empty($_POST['user_id'])) {
				$user_id = Wo_Secure($_POST['user_id']);
				$user = Wo_UserData($user_id);
				if (!empty($user)) {
					$joined_groups_offset = (!empty($_POST['joined_groups_offset']) && is_numeric($_POST['joined_groups_offset']) && $_POST['joined_groups_offset'] > 0 ? Wo_Secure($_POST['joined_groups_offset']) : 0);
			        $joined_groups_limit = (!empty($_POST['joined_groups_limit']) && is_numeric($_POST['joined_groups_limit']) && $_POST['joined_groups_limit'] > 0 && $_POST['joined_groups_limit'] <= 50 ? Wo_Secure($_POST['joined_groups_limit']) : 20);

					$groups = Wo_GetUsersGroupsAPI($user_id, $joined_groups_limit,$joined_groups_offset);
					foreach ($groups as $key => $group) {
					    $groups[$key]['members'] = Wo_CountGroupMembers($group['id']);
					}
					$response_data = array(
			                        'api_status' => 200,
			                        'data' => $groups
			                    );
				}
				else{
					$error_code    = 5;
				    $error_message = 'user not found';
				}
			}
			else{
				$error_code    = 4;
			    $error_message = 'user_id (POST) is missing';
			}

		}
		if (!empty($data['groups'])) {
			$groups_offset = (!empty($_POST['groups_offset']) && is_numeric($_POST['groups_offset']) && $_POST['groups_offset'] > 0 ? Wo_Secure($_POST['groups_offset']) : 0);
	        $groups_limit = (!empty($_POST['groups_limit']) && is_numeric($_POST['groups_limit']) && $_POST['groups_limit'] > 0 && $_POST['groups_limit'] <= 50 ? Wo_Secure($_POST['groups_limit']) : 20);

			//$groups = Wo_GetUsersGroups($user_id,$groups_limit,array(),$groups_offset);
			$groups = Wo_GetUsersGroupsAPI($user_id,$groups_limit,$groups_offset);
	        foreach ($groups as $key => $group) {
	            $groups[$key]['members'] = Wo_CountGroupMembers($group['id']);
	        }
			$response_data['groups'] = $groups;
		}
		if (!empty($data['pages'])) {
			$pages_offset = (!empty($_POST['pages_offset']) && is_numeric($_POST['pages_offset']) && $_POST['pages_offset'] > 0 ? Wo_Secure($_POST['pages_offset']) : 0);
	        $pages_limit = (!empty($_POST['pages_limit']) && is_numeric($_POST['pages_limit']) && $_POST['pages_limit'] > 0 && $_POST['pages_limit'] <= 50 ? Wo_Secure($_POST['pages_limit']) : 20);

			$response_data['pages'] = Wo_GetMyPages($user_id,$pages_limit,$pages_offset);
		}
		if (!empty($data['liked_pages'])) {
			$liked_pages_offset = (!empty($_POST['liked_pages_offset']) && is_numeric($_POST['liked_pages_offset']) && $_POST['liked_pages_offset'] > 0 ? Wo_Secure($_POST['liked_pages_offset']) : 0);
	        $liked_pages_limit = (!empty($_POST['liked_pages_limit']) && is_numeric($_POST['liked_pages_limit']) && $_POST['liked_pages_limit'] > 0 && $_POST['liked_pages_limit'] <= 50 ? Wo_Secure($_POST['liked_pages_limit']) : 20);
			$response_data['liked_pages'] = Wo_GetLikes($user_id, 'profile', $liked_pages_limit, $liked_pages_offset, array('in' => 'profile_sidebar', 'likes_data' => $recipient_data['likes_data']));
		}
    }
}
