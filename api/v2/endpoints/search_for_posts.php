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

$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);

if (!empty($_POST['type']) && in_array($_POST['type'], array('page','user','group')) && !empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0 && !empty($_POST['search_query'])) {

	$posts = Wo_SearchForPosts($_POST['id'], $_POST['search_query'], $limit, $_POST['type']);
	foreach ($posts as $key => $value) {
		$posts[$key]['shared_info'] = null;

		if (!empty($posts[$key]['postFile'])) {
			$posts[$key]['postFile'] = Wo_GetMedia($posts[$key]['postFile']);
		}
		if (!empty($posts[$key]['postFileThumb'])) {
			$posts[$key]['postFileThumb'] = Wo_GetMedia($posts[$key]['postFileThumb']);
		}

		if (!empty($posts[$key]['postPlaytube'])) {
			$posts[$key]['postText'] = strip_tags($posts[$key]['postText']);
		}



		if (!empty($posts[$key]['publisher'])) {
			foreach ($non_allowed as $key4 => $value4) {
	          unset($posts[$key]['publisher'][$value4]);
	        }
	    }
	    else{
	    	$posts[$key]['publisher'] = null;
	    }

	    if (!empty($posts[$key]['user_data'])) {
	    	foreach ($non_allowed as $key4 => $value4) {
	          unset($posts[$key]['user_data'][$value4]);
	        }
	    }
	    else{
	    	$posts[$key]['user_data'] = null;
	    }

	    if (!empty($posts[$key]['parent_id'])) {
	    	$shared_info = Wo_PostData($posts[$key]['parent_id']);
	    	if (!empty($shared_info)) {
	    		if (!empty($shared_info['publisher'])) {
					foreach ($non_allowed as $key4 => $value4) {
			          unset($shared_info['publisher'][$value4]);
			        }
			    }
			    else{
			    	$shared_info['publisher'] = null;
			    }

			    if (!empty($shared_info['user_data'])) {
			    	foreach ($non_allowed as $key4 => $value4) {
			          unset($shared_info['user_data'][$value4]);
			        }
			    }
			    else{
			    	$shared_info['user_data'] = null;
			    }

			    if (!empty($shared_info['get_post_comments'])) {
			        foreach ($shared_info['get_post_comments'] as $key3 => $comment) {

				        foreach ($non_allowed as $key5 => $value5) {
				          unset($shared_info['get_post_comments'][$key3]['publisher'][$value5]);
				        }
				    }
				}
	    	}
	    	$posts[$key]['shared_info'] = $shared_info;
	    }

	    if (!empty($value['get_post_comments'])) {
	        foreach ($value['get_post_comments'] as $key3 => $comment) {

		        foreach ($non_allowed as $key5 => $value5) {
		          unset($posts[$key]['get_post_comments'][$key3]['publisher'][$value5]);
		        }
		    }
		}
	}

	$response_data['data'] = $posts;
    $response_data['api_status'] = 200;
}
else{
	$error_code    = 5;
    $error_message = 'please check your details';
}