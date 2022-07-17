<?php
$live = array();
$time = (time() - 10);
$live_posts = $db->rawQuery("SELECT P.id FROM ".T_POSTS." P WHERE P.user_id = (SELECT following_id FROM ".T_FOLLOWERS." WHERE P.user_id = following_id AND follower_id = ".$wo['user']['id'].") AND P.postType = 'live' AND P.live_time >= '".$time."' ORDER BY P.id DESC");
if (!empty($live_posts)) {
	foreach ($live_posts as $key => $value) {
		$post_data = Wo_PostData($value->id);

		$post_data['shared_info'] = null;

		if (!empty($post_data['postFile'])) {
			$post_data['postFile'] = Wo_GetMedia($post_data['postFile']);
		}
		if (!empty($post_data['postFileThumb'])) {
			$post_data['postFileThumb'] = Wo_GetMedia($post_data['postFileThumb']);
		}

		if (!empty($post_data['postPlaytube'])) {
			$post_data['postText'] = strip_tags($post_data['postText']);
		}



		if (!empty($post_data['publisher'])) {
			foreach ($non_allowed as $key4 => $value4) {
	          unset($post_data['publisher'][$value4]);
	        }
	    }
	    else{
	    	$post_data['publisher'] = null;
	    }

	    if (!empty($post_data['user_data'])) {
	    	foreach ($non_allowed as $key4 => $value4) {
	          unset($post_data['user_data'][$value4]);
	        }
	    }
	    else{
	    	$post_data['user_data'] = null;
	    }

	    if (!empty($post_data['parent_id'])) {
	    	$shared_info = Wo_PostData($post_data['parent_id']);
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
	    	$post_data['shared_info'] = $shared_info;
	    }

	    if (!empty($post_data['get_post_comments'])) {
	        foreach ($post_data['get_post_comments'] as $key3 => $comment) {

		        foreach ($non_allowed as $key5 => $value5) {
		          unset($post_data['get_post_comments'][$key3]['publisher'][$value5]);
		        }
		    }
		}
		$live[] = $post_data;
	}
}

$response_data = array(
                    'api_status' => 200,
                    'data' => $live
                );