<?php

if (empty($_POST['type'])) {
	$error_code    = 4;
    $error_message = 'type can not be empty';
}
else{
	if ($_POST['type'] == 'create') {

		if (empty($_POST['stream_name'])) {
			$error_code    = 5;
		    $error_message = 'stream_name can not be empty';
    	}
    	else{
            $postPrivacy = 0;
            $privacy_array = array(
                '0',
                '1',
                '2',
                '3',
                '4'
            );
            if (!empty($_COOKIE['post_privacy']) && in_array($_COOKIE['post_privacy'], $privacy_array)) {
                $postPrivacy = Wo_Secure($_COOKIE['post_privacy']);
            }
            if (!empty($_POST['post_privacy']) && in_array($_POST['post_privacy'], $privacy_array)) {
                $postPrivacy = Wo_Secure($_POST['post_privacy']);
            }
            $token = null;
            if (!empty($_POST['token']) && !is_null($_POST['token'])) {
                $token = Wo_Secure($_POST['token']);
            }
    		$post_id = $db->insert(T_POSTS,array('user_id' => $wo['user']['id'],
		    	                                 'postText' => '',
                                                 'postType' => 'live',
                                                 'postPrivacy' => $postPrivacy,
                                                 'agora_token' => $token,
                                                 'stream_name' => Wo_Secure($_POST['stream_name']),
                                                 'time' => time()));
    		$db->where('id',$post_id)->update(T_POSTS,array('post_id' => $post_id));
            // Wo_RunInBackground(array('status' => 200,
            //                          'post_id' => $post_id));

            if ($wo['config']['agora_live_video'] == 1 && !empty($wo['config']['agora_app_id']) && !empty($wo['config']['agora_customer_id']) && !empty($wo['config']['agora_customer_certificate']) && $wo['config']['live_video_save'] == 1) {

                if ($wo['config']['amazone_s3_2'] == 1 && !empty($wo['config']['bucket_name_2']) && !empty($wo['config']['amazone_s3_key_2']) && !empty($wo['config']['amazone_s3_s_key_2']) && !empty($wo['config']['region_2'])) {

                    $region_array = array('us-east-1' => 0,'us-east-2' => 1,'us-west-1' => 2,'us-west-2' => 3,'eu-west-1' => 4,'eu-west-2' => 5,'eu-west-3' => 6,'eu-central-1' => 7,'ap-southeast-1' => 8,'ap-southeast-2' => 9,'ap-northeast-1' => 10,'ap-northeast-2' => 11,'sa-east-1' => 12,'ca-central-1' => 13,'ap-south-1' => 14,'cn-north-1' => 15,'us-gov-west-1' => 17);

                    if (in_array(strtolower($wo['config']['region_2']),array_keys($region_array) )) {

                       // StartCloudRecording(1,$region_array[strtolower($wo['config']['region_2'])],$wo['config']['bucket_name_2'],$wo['config']['amazone_s3_key_2'],$wo['config']['amazone_s3_s_key_2'],$_POST['stream_name'],explode('_', $_POST['stream_name'])[2],$post_id);
                    }
                    
                }
            }
            Wo_notifyUsersLive($post_id);
            $post_data = Wo_PostData($post_id);
            unset($post_data['get_post_comments']);

            foreach ($non_allowed as $key => $value) {
	           unset($post_data['publisher'][$value]);
	        }

	        if (!empty($post_data['blog'])) {
	        	foreach ($non_allowed as $key => $value) {
		           unset($post_data['blog']['author'][$value]);
		        }
	        }
	        if (!empty($post_data['event'])) {
	        	foreach ($non_allowed as $key => $value) {
		           unset($post_data['event']['user_data'][$value]);
		        }
	        }
            $post_data['shared_from'] = (empty($post_data['shared_from'])) ? null : $post_data['shared_from'];

            $response_data = array(
                                'api_status' => 200,
                                'post_data' => $post_data
                            );
    	}
	}

	if ($_POST['type'] == 'check_comments') {
		if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0) {
    		$post_id = Wo_Secure($_POST['post_id']);
    		$post_data = $db->where('id',$post_id)->getOne(T_POSTS);
    		if (!empty($post_data)) {
                if ($post_data->live_ended == 0) {
                	$response_data = array('api_status' => 200);

                    // //if ($_POST['page'] == 'story') {
                    //     $user_comment = $db->where('post_id',$post_id)->where('user_id',$wo['user']['id'])->getOne(T_COMMENTS);
                    //     if (!empty($user_comment)) {
                    //         $db->where('id',$user_comment->id,'>');
                    //     }
                    // //}
                    // if (!empty($_POST['ids'])) {
                    //     $ids = array();
                    //     foreach ($_POST['ids'] as $key => $one_id) {
                    //         $ids[] = Wo_Secure($one_id);
                    //     }
                    //     $db->where('id',$ids,'NOT IN')->where('id',end($ids),'>');
                    // }
                    //if ($_POST['page'] == 'story') {
                        //$db->where('user_id',$wo['user']['id'],'!=');
                    //}
                    $offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
                    $limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
                    if (!empty($offset)) {
                        $db->where('id',$offset,'>');
                    }
    				$comments = $db->where('post_id',$post_id)->where('text','','!=')->get(T_COMMENTS,$limit);
    				$comments_data = array();
    				foreach ($comments as $key => $value) {
    					if (!empty($value->text)) {
    						$comment = Wo_GetPostComment($value->id);
    						foreach ($non_allowed as $key => $value) {
				              unset($comment['publisher'][$value]);
				            }
				            $comments_data[] = $comment;
    					}
    				}


                    
                    $word = $wo['lang']['offline'];
                    $joined_data = array();
                    $left_data = array();
                    if (!empty($post_data->live_time) && $post_data->live_time >= (time() - 10)) {
                        //$db->where('post_id',$post_id)->where('time',time()-6,'<')->update(T_LIVE_SUB,array('is_watching' => 0));
                        $word = $wo['lang']['live'];
                        $count = $db->where('post_id',$post_id)->where('time',time()-6,'>=')->getValue(T_LIVE_SUB,'COUNT(*)');

                        if ($wo['user']['id'] == $post_data->user_id) {
                            $joined_users = $db->where('post_id',$post_id)->where('time',time()-6,'>=')->where('is_watching',0)->get(T_LIVE_SUB);
                            $joined_ids = array();
                            if (!empty($joined_users)) {
                                foreach ($joined_users as $key => $value) {
                                    $joined_ids[] = $value->user_id;
                                    $joined_data[] = Wo_UserData($value->user_id);
                                    
                                }
                                if (!empty($joined_ids)) {
                                    $db->where('post_id',$post_id)->where('user_id',$joined_ids,'IN')->update(T_LIVE_SUB,array('is_watching' => 1));
                                }
                            }

                            $left_users = $db->where('post_id',$post_id)->where('time',time()-6,'<')->where('is_watching',1)->get(T_LIVE_SUB);
                            $left_ids = array();
                            if (!empty($left_users)) {
                                foreach ($left_users as $key => $value) {
                                    $left_ids[] = $value->user_id;
                                    $left_data[] = Wo_UserData($value->user_id);
                                }
                                if (!empty($left_ids)) {
                                    $db->where('post_id',$post_id)->where('user_id',$left_ids,'IN')->delete(T_LIVE_SUB);
                                }
                            }
                        }
                    }
                    $still_live = 'offline';
                    if (!empty($post_data) && $post_data->live_time >= (time() - 10)){
                        $still_live = 'live';
                    }
                    $response_data = array(
                        'api_status' => 200,
                        'comments' => $comments_data,
                        'joined' => $joined_data,
                        'left' => $left_data,
                        'count' => $count,
                        'word' => $word,
                        'still_live' => $still_live
                    );
                    
                    // Wo_RunInBackground(array(
                    //     'status' => 200,
                    //     'html' => $html,
                    //     'count' => $count,
                    //     'word' => $word,
                    //     'still_live' => $still_live
                    // ));
                    
                    if ($wo['user']['id'] == $post_data->user_id) {
                        if ($_POST['page'] == 'live') {
                            $time = time();
                            $update_array = array('live_time' => $time);
                            if (!empty($_POST['resourceId']) && !empty($_POST['sid'])) {
                                $update_array['agora_resource_id'] = Wo_Secure($_POST['resourceId']);
                                $update_array['agora_sid'] = Wo_Secure($_POST['sid']);
                            }
                            if (!empty($_POST['fileList'])) {
                                $update_array['postFile'] = Wo_Secure($_POST['fileList']);
                            }
                            $db->where('id',$post_id)->update(T_POSTS,$update_array);
                            $db->where('parent_id',$post_id)->update(T_POSTS,array('live_time' => $time));
                        }
                        // if ($_POST['page'] == 'live') {
                        //     $time = time();
                        //     $db->where('id',$post_id)->update(T_POSTS,array('live_time' => $time));
                        //     $db->where('parent_id',$post_id)->update(T_POSTS,array('live_time' => $time));
                        // }
                    }
                    else{
                        if (!empty($post_data->live_time) && $post_data->live_time >= (time() - 10) && $_POST['page'] == 'story') {
                            $is_watching = $db->where('user_id',$wo['user']['id'])->where('post_id',$post_id)->getValue(T_LIVE_SUB,'COUNT(*)');
                            if ($is_watching > 0) {
                                $db->where('user_id',$wo['user']['id'])->where('post_id',$post_id)->update(T_LIVE_SUB,array('time' => time()));
                            }
                            else{
                                $db->insert(T_LIVE_SUB,array('user_id' => $wo['user']['id'],
                                                             'post_id' => $post_id,
                                                             'time' => time(),
                                                             'is_watching' => 0));
                            }
                        }
                    }
                }
                else{
                    $error_code    = 7;
				    $error_message = 'live ended';
                }
                
    		}
    		else{
                $error_code    = 6;
			    $error_message = 'post not found';
    		}
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'post_id can not be empty';
    	}
	}

    if ($_POST['type'] == 'delete') {
        if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0) {
            $db->where('post_id',Wo_Secure($_POST['post_id']))->where('user_id',$wo['user']['id'])->update(T_POSTS,array('live_ended' => 1));
            if ($wo['config']['live_video_save'] == 0) {
                // $db->where('post_id',Wo_Secure($_POST['post_id']))->where('user_id',$wo['user']['id'])->delete(T_POSTS);
                // $db->where('parent_id',Wo_Secure($_POST['post_id']))->delete(T_POSTS);

                Wo_DeletePost(Wo_Secure($_POST['post_id']));
                $response_data = array(
                                    'api_status' => 200,
                                    'message' => 'deleted successfully'
                                );
            }
            else{
                if ($wo['config']['agora_live_video'] == 1 && !empty($wo['config']['agora_app_id']) && !empty($wo['config']['agora_customer_id']) && !empty($wo['config']['agora_customer_certificate']) && $wo['config']['live_video_save'] == 1) {
                    $post = $db->where('post_id',Wo_Secure($_POST['post_id']))->getOne(T_POSTS);
                    if (!empty($post)) {
                        StopCloudRecording(array('resourceId' => $post->agora_resource_id,
                                                 'sid' => $post->agora_sid,
                                                 'cname' => $post->stream_name,
                                                 'post_id' => $post->post_id,
                                                 'uid' => explode('_', $post->stream_name)[2]));
                    }
                }
                if ($wo['config']['agora_live_video'] == 1 && $wo['config']['amazone_s3_2'] != 1) {
                    try {
                        Wo_DeletePost(Wo_Secure($_POST['post_id']));
                        $response_data = array(
                                            'api_status' => 200,
                                            'message' => 'deleted successfully'
                                        );
                    } catch (Exception $e) {
                        $error_code    = 6;
                        $error_message = 'something went wrong';
                        
                    }
                }
            }
        }
        else{
            $error_code    = 5;
            $error_message = 'post_id can not be empty';
        }
    }

    if ($_POST['type'] == 'create_thumb') {
        if (!empty($_POST['post_id']) && is_numeric($_POST['post_id']) && $_POST['post_id'] > 0 && !empty($_FILES['thumb'])) {
            $is_post = $db->where('post_id',Wo_Secure($_POST['post_id']))->where('user_id',$wo['user']['id'])->getValue(T_POSTS,'COUNT(*)');
            if ($is_post > 0) {
                $fileInfo = array(
                    'file' => $_FILES["thumb"]["tmp_name"],
                    'name' => $_FILES['thumb']['name'],
                    'size' => $_FILES["thumb"]["size"],
                    'type' => $_FILES["thumb"]["type"],
                    'types' => 'jpeg,png,jpg,gif',
                    'crop' => array(
                        'width' => 525,
                        'height' => 295
                    )
                );
                $media    = Wo_ShareFile($fileInfo);
                if (!empty($media)) {
                    $thumb = $media['filename'];
                    if (!empty($thumb)) {
                        $db->where('post_id',Wo_Secure($_POST['post_id']))->where('user_id',$wo['user']['id'])->update(T_POSTS,array('postFileThumb' => $thumb));
                        $response_data = array(
                                            'api_status' => 200,
                                            'message' => 'created successfully'
                                        );
                    }
                    else{
                        $error_code    = 8;
                        $error_message = 'invalid file';
                    }
                }
                else{
                    $error_code    = 7;
                    $error_message = 'invalid file';
                }
            }
            else{
                $error_code    = 6;
                $error_message = 'post not found';
            }
        }
        else{
            $error_code    = 5;
            $error_message = 'post_id , thumb can not be empty';
        }
    }




}