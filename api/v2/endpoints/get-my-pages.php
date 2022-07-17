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
    'api_status' => 400,
);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);

$required_fields =  array(
                        'my_pages',
                        'liked_pages',
                        'category'
                    );
if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {
	if ($_POST['type'] == 'my_pages') {
		$pages = Wo_GetMyPagesAPI($limit,$offset);
		foreach ($pages as $key => $page) {
		    $pages[$key]['likes'] = Wo_CountPageLikes($page['page_id']);
		}
		$response_data = array(
		                        'api_status' => 200,
		                        'data' => $pages
		                    );
	}
	elseif ($_POST['type'] == 'liked_pages') {
		if (!empty($_POST['user_id'])) {
			$user_id = Wo_Secure($_POST['user_id']);
			$user = Wo_UserData($user_id);
			if (!empty($user)) {
				$pages = Wo_GetLikes($user_id,'profile',$limit,$offset);
				foreach ($pages as $key => $page) {
				    $pages[$key]['likes'] = Wo_CountPageLikes($page['page_id']);
				}
				$response_data = array(
		                        'api_status' => 200,
		                        'data' => $pages
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
	elseif ($_POST['type'] == 'category') {
		if (!empty($_POST['category_id'])) {
			$pages = array();
			$category_id = Wo_Secure($_POST['category_id']);
			if ($offset > 0) {
	            $offset_to .= " AND `page_id` < {$offset} AND `page_id` <> {$offset} ";
	        }

	        $query = mysqli_query($sqlConnect, " SELECT `page_id` FROM " . T_PAGES . " WHERE `page_category` = {$category_id} AND `active` = '1' {$offset_to} ORDER BY `page_id` DESC LIMIT {$limit}");
	        while ($fetched_data = mysqli_fetch_assoc($query)) {
	        	$page_data = Wo_PageData($fetched_data['page_id']);
	        	$page_data['likes'] = Wo_CountPageLikes($fetched_data['page_id']);
	        	$page_data['is_liked'] = Wo_IsPageLiked($page_data['page_id'], $wo['user']['id']);
	            $pages[] = $page_data;
	        }
	        $response_data = array(
		                        'api_status' => 200,
		                        'data' => $pages
		                    );
		}
		else{
			$error_code    = 6;
		    $error_message = 'category_id (POST) is missing';
		}
	}
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}


