<?php
if (!empty($_POST['type']) && in_array($_POST['type'], array('post','page'))) {
	if ($_POST['type'] == 'post') {
		$posts = array();
		$stories = Wo_GetBoostedPosts($wo['user']['user_id']);
		if (!empty($stories)) {
			foreach ($stories as $key => $post) {
				$post['shared_info'] = null;

				if (!empty($post['postFile'])) {
					$post['postFile'] = Wo_GetMedia($post['postFile']);
				}
				if (!empty($post['postFileThumb'])) {
					$post['postFileThumb'] = Wo_GetMedia($post['postFileThumb']);
				}

				if (!empty($post['postPlaytube'])) {
					$post['postText'] = strip_tags($post['postText']);
				}



				if (!empty($post['publisher'])) {
					foreach ($non_allowed as $key4 => $value4) {
			          unset($post['publisher'][$value4]);
			        }
			    }
			    else{
			    	$post['publisher'] = null;
			    }

			    if (!empty($post['user_data'])) {
			    	foreach ($non_allowed as $key4 => $value4) {
			          unset($post['user_data'][$value4]);
			        }
			    }
			    else{
			    	$post['user_data'] = null;
			    }

			    if (!empty($post['parent_id'])) {
			    	$shared_info = Wo_PostData($post['parent_id']);
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
			    	$post['shared_info'] = $shared_info;
			    }

			    if (!empty($post['get_post_comments'])) {
			        foreach ($post['get_post_comments'] as $key3 => $comment) {

				        foreach ($non_allowed as $key5 => $value5) {
				          unset($post['get_post_comments'][$key3]['publisher'][$value5]);
				        }
				    }
				}
				$posts[] = $post;
			}
		}
		$response_data = array(
	                        'api_status' => 200,
	                        'data' => $posts
	                    );
	}
	if ($_POST['type'] == 'page') {
		$posts = array();
		$stories = Wo_GetBoostedPages($wo['user']['user_id']);
		$posts = $stories;
		$response_data = array(
	                        'api_status' => 200,
	                        'data' => $posts
	                    );
	}
}
else{
	$error_code    = 3;
    $error_message = "type can not be empty";
}
