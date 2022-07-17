<?php
$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'create',
                        'delete',
                        'edit',
                        'get_by_id',
                        'get',
                        'send'
                    );

$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {
    if ($_POST['type'] == 'create') {
    	if (!empty($_POST['name']) && !empty($_POST['users'])) {
    		$users = explode(",", $_POST['users']);
    		$ids = array();
    		if (!empty($users) && is_array($users)) {
    			foreach ($users as $key => $value) {
    				if (!empty($value) && is_numeric($value) && $value > 0 && $wo['user']['id'] != $value) {
    					$ids[] = Wo_Secure($value);
    				}
    			}
    			if (!empty($ids)) {
    				$insert_array = array('user_id' => $wo['user']['id'],
    			                          'name' => Wo_Secure($_POST['name']),
    			                          'time' => time());
    				if (!empty($_FILES['image'])) {
    					$fileInfo      = array(
					        'file' => $_FILES["image"]["tmp_name"],
					        'name' => $_FILES['image']['name'],
					        'size' => $_FILES["image"]["size"],
					        'type' => $_FILES["image"]["type"],
					        'types' => 'jpeg,jpg,png,bmp,gif'
					    );
					    $media         = Wo_ShareFile($fileInfo);
					    $mediaFilename = $media['filename'];
					    if (!empty($media) && !empty($media['filename'])) {
					    	$insert_array['image'] = $media['filename'];
					    }
    				}
    				$id = $db->insert(T_CAST,$insert_array);
    				if (!empty($id)) {
    					foreach ($ids as $key => $value) {
    						$db->insert(T_CAST_USERS,array('user_id' => $value,
    					                                   'broadcast_id' => $id,
    					                                   'time' => time()));
    					}
    					$broadcast = GetBroadcastChatById($id);
    					if (!empty($broadcast->users)) {
    						foreach ($broadcast->users as $key => $value) {
    							foreach ($non_allowed as $key2 => $value2) {
			                       unset($broadcast->users[$key][$value2]);
			                    }
    						}
    					}
    					$response_data = array('api_status' => 200,
			            	                   'data' => $broadcast);
    				}
    				else{
    					$error_code    = 7;
					    $error_message = 'something went wrong';
    				}
    			}
    			else{
    				$error_code    = 6;
				    $error_message = 'users can not be empty';
    			}
    		}
    		else{
    			$error_code    = 5;
			    $error_message = 'users can not be empty';
    		}
    	}
    	else{
    		$error_code    = 5;
			$error_message = 'name , users can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'get_by_id') {
    	if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
    		$id = Wo_Secure($_POST['id']);
    		$broadcast = GetBroadcastChatById($id);
			if (!empty($broadcast->users)) {
				foreach ($broadcast->users as $key => $value) {
					foreach ($non_allowed as $key2 => $value2) {
                       unset($broadcast->users[$key][$value2]);
                    }
				}
			}
    		$response_data = array('api_status' => 200,
			            	       'data' => $broadcast);
    	}
    	else{
    		$error_code    = 4;
		    $error_message = 'id can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'get') {
    	$broadcast = GetBroadcastChatByUserId($wo['user']['id'],$limit,$offset);
    	foreach ($broadcast as $key => $value) {
    		foreach ($broadcast[$key]->users as $key2 => $value2) {
    			foreach ($non_allowed as $key3 => $value3) {
                   unset($broadcast[$key]->users[$key2][$value3]);
                }
    		}
    	}
    	$response_data = array('api_status' => 200,
			            	   'data' => $broadcast);
    }
    elseif ($_POST['type'] == 'delete') {
    	if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
    		$broadcast = $db->where('id',Wo_Secure($_POST['id']))->where('user_id',$wo['user']['id'])->getOne(T_CAST);
    		if (!empty($broadcast)) {
    			$db->where('id',Wo_Secure($_POST['id']))->where('user_id',$wo['user']['id'])->delete(T_CAST);
    			$db->where('broadcast_id',Wo_Secure($_POST['id']))->delete(T_CAST_USERS);
    			$response_data = array('api_status' => 200,
					            	   'message' => 'broadcast removed');
    		}
    		else{
    			$error_code    = 5;
			    $error_message = 'You are not the owner or broadcast not found';
    		}
    	}
    	else{
    		$error_code    = 4;
		    $error_message = 'id can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'edit') {
    	if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
    		$id = Wo_Secure($_POST['id']);
    		$cast = $db->where('id',$id)->where('user_id',$wo['user']['id'])->getOne(T_CAST);
    		if (!empty($cast)) {
    			$update_array = array();
    			if (!empty($_POST['name'])) {
    				$update_array['name'] = Wo_Secure($_POST['name']);
    			}
    			if (!empty($_FILES['image'])) {
					$fileInfo      = array(
				        'file' => $_FILES["image"]["tmp_name"],
				        'name' => $_FILES['image']['name'],
				        'size' => $_FILES["image"]["size"],
				        'type' => $_FILES["image"]["type"],
				        'types' => 'jpeg,jpg,png,bmp,gif'
				    );
				    $media         = Wo_ShareFile($fileInfo);
				    $mediaFilename = $media['filename'];
				    if (!empty($media) && !empty($media['filename'])) {
				    	$update_array['image'] = $media['filename'];
				    }
				}
				$db->where('id',$cast->id)->update(T_CAST,$update_array);
				if (!empty($_POST['added_users'])) {
					$added_users = explode(",", $_POST['added_users']);
					if (!empty($added_users) && is_array($added_users)) {
		    			foreach ($added_users as $key => $value) {
		    				if (!empty($value) && is_numeric($value) && $value > 0 && $wo['user']['id'] != $value) {
		    					$is_exist = $db->where('user_id',Wo_Secure($value))->where('broadcast_id',$cast->id)->getValue(T_CAST_USERS,"COUNT(*)");
		    					if ($is_exist < 1) {
		    						$db->insert(T_CAST_USERS,array('user_id' => Wo_Secure($value),
		    					                                   'broadcast_id' => $cast->id,
		    					                                   'time' => time()));
		    					}
		    				}
		    			}
		    		}
				}
				if (!empty($_POST['remove_users'])) {
					$remove_users = explode(",", $_POST['remove_users']);
					if (!empty($remove_users) && is_array($remove_users)) {
		    			foreach ($remove_users as $key => $value) {
		    				if (!empty($value) && is_numeric($value) && $value > 0 && $wo['user']['id'] != $value) {
		    					$db->where('broadcast_id',$cast->id)->where('user_id',Wo_Secure($value))->delete(T_CAST_USERS);
		    				}
		    			}
		    		}
				}
				$broadcast = GetBroadcastChatById($cast->id);
				if (!empty($broadcast->users)) {
					foreach ($broadcast->users as $key => $value) {
						foreach ($non_allowed as $key2 => $value2) {
	                       unset($broadcast->users[$key][$value2]);
	                    }
					}
				}
				$response_data = array('api_status' => 200,
					            	   'message' => 'broadcast edited',
					            	   'data' => $broadcast);
    		}
    		else{
    			$error_code    = 6;
			    $error_message = 'Broadcast not found or you are not the owner';
    		}
    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'id can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'send') {
    	if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
    		$id = Wo_Secure($_POST['id']);
    		$cast = GetBroadcastChatById($id);
    		if (!empty($cast)) {
    			$response_data = array(
				    'api_status' => 400
				);

				$required_fields = array(
				    'message_hash_id'
				);

				if (empty($_POST['product_id'])) {
				    if (empty($_POST['text']) && $_POST['text'] != 0 && empty($_POST['lat']) && empty($_POST['lng'])) {
				    	if (empty($_FILES['file']['name']) && empty($_POST['image_url']) && empty($_POST['gif'])) {
				    	    $error_code    = 3;
				    	    $error_message = 'file (STREAM FILE) AND text (POST) AND image_url AND gif (POST) are missing, at least one is required';
				    	}
				    }
				}

				foreach ($required_fields as $key => $value) {
				    if (empty($_POST[$value]) && empty($error_code)) {
				        $error_code    = 4;
				        $error_message = $value . ' (POST) is missing';
				    }
				}


				if (empty($error_code)) {
					$recipient_id = 0;
					if (empty($_POST['product_id'])) {

			    	    $mediaFilename = '';
			            $mediaName     = '';
			            if (isset($_FILES['file']['name'])) {
			                $fileInfo      = array(
			                    'file' => $_FILES["file"]["tmp_name"],
			                    'name' => $_FILES['file']['name'],
			                    'size' => $_FILES["file"]["size"],
			                    'type' => $_FILES["file"]["type"]
			                );
			                $media         = Wo_ShareFile($fileInfo);
			                $mediaFilename = $media['filename'];
			                $mediaName     = $_FILES['file']['name'];
			            }
			            if (!empty($_POST['image_url'])) {
			            	$fileend = '_url_image';
			            	if (!empty($_POST['sticker_id'])) {
			            		$fileend =  '_sticker_' . Wo_Secure($_POST['sticker_id']);
			            	}
			                $mediaFilename = Wo_ImportImageFromUrl($_POST['image_url'], $fileend);
			            }
			            $gif = '';
			            if (!empty($_POST['gif'])) {
			                if (strpos($_POST['gif'], '.gif') !== false) {
			                    $gif = Wo_Secure($_POST['gif']);
			                }
			            }
			            $lng = 0;
			            $lat = 0;
			            if (!empty($_POST['lng']) && !empty($_POST['lat'])) {
			                $lng = Wo_Secure($_POST['lng']);
			                $lat = Wo_Secure($_POST['lat']);
			            }
			        	$message_data = array(
			                'from_id' => Wo_Secure($wo['user']['user_id']),
			                'media' => Wo_Secure($mediaFilename),
			                'mediaFileName' => Wo_Secure($mediaName),
			                'time' => time(),
			                'type_two' => (!empty($_POST['contact'])) ? 'contact' : '',
			                'text' => '',
			                'stickers' => $gif,
			                'lng' => $lng,
			                'lat' => $lat,
			            );
			    		if (!empty($_POST['text']) || (isset($_POST['text']) && $_POST['text'] === '0') ) {
			    		 	$message_data['text'] = Wo_Secure($_POST['text']);
			    		}
			            else{
			                if (empty($lng) && empty($lat) && empty($_FILES['file']['name']) && empty($_POST['image_url']) && empty($_POST['gif'])) {
			                    $error_code    = 5;
			                    $error_message = 'Please check your details.';
			                }
			            }
			            if (empty($error_message)) {
			            	foreach ($cast->users as $key => $value) {
			            		$recipient_id = $value['user_id'];
			            		$message_data['to_id'] = $value['user_id'];
			            		$message_data['broadcast_id'] = $cast->id;
			            		$last_id      = Wo_RegisterMessage($message_data);
			            	}
			                
			            }
			        }
			        else{
			        	foreach ($cast->users as $key => $value) {
			        		$recipient_id = $value['user_id'];
		            		$last_id = Wo_RegisterMessage(array(
			                            'from_id' => Wo_Secure($wo['user']['user_id']),
			                            'to_id' => $value['user_id'],
			                            'time' => time(),
			                            'stickers' => '',
			                            'product_id' => Wo_Secure($_POST['product_id']),
			                            'broadcast_id' => $cast->id
			                        ));
		            	}
			            
			        }
			        if (!empty($last_id)) {
			            if (!empty($_POST['reply_id']) && is_numeric($_POST['reply_id']) && $_POST['reply_id'] > 0) {
			                $reply_id = Wo_Secure($_POST['reply_id']);
			                $db->where('id',$last_id)->update(T_MESSAGES,array('reply_id' => $reply_id));
			            }
			            if (!empty($_POST['story_id']) && is_numeric($_POST['story_id']) && $_POST['story_id'] > 0) {
			                $story_id = Wo_Secure($_POST['story_id']);
			                $db->where('id',$last_id)->update(T_MESSAGES,array('story_id' => $story_id));
			            }
			        	$message_info = array(
			                'user_id' => $recipient_id,
			                'message_id' => $last_id
			            );
			            $message_info = Wo_GetMessages($message_info);
			            foreach ($non_allowed as $key => $value) {
				           unset($message_info[0]['messageUser'][$value]);
				        }
				        if (empty($wo['user']['timezone'])) {
			                $wo['user']['timezone'] = 'UTC';
			            }
				        $timezone = new DateTimeZone($wo['user']['timezone']);
				        $messages = array();
				        foreach ($message_info as $key => $message) {
			                $message['text'] = Wo_Markup($message['or_text']);
				        	$message['time_text'] = Wo_Time_Elapsed_String($message['time']);
			                $message_po           = 'left';
			                if ($message['from_id'] == $wo['user']['user_id']) {
			                    $message_po = 'right';
			                }
			                $message['position'] = $message_po;
			                $message['type']     = Wo_GetFilePosition($message['media']);
			                if (!empty($message['stickers']) && strpos($message['stickers'], '.gif') !== false) {
			                    $message['type'] = 'gif';
			                }
			                if ($message['type_two'] == 'contact') {
			                    $message['type']   = 'contact';
			                }
			                if (!empty($message['lng']) && !empty($message['lat'])) {
			                    $message['type']   = 'map';
			                }
			                $message['type']     = $message_po . '_' . $message['type'];
			                $message['file_size'] = 0;
			                if (!empty($message['media'])) {
			                    $message['file_size'] = '0MB';
			                    if (file_exists($message['file_size'])) {
			                        $message['file_size'] = Wo_SizeFormat(filesize($message['media']));
			                    }
			                    $message['media']     = Wo_GetMedia($message['media']);
			                }
			                if (!empty($message['time'])) {
			                    $time_today = time() - 86400;
			                    if ($message['time'] < $time_today) {
			                        $message['time_text'] = date('m.d.y', $message['time']);
			                    } else {
			                        $time = new DateTime('now', $timezone);
			                        $time->setTimestamp($message['time']);
			                        $message['time_text'] = $time->format('H:i');
			                    }
			                }
			                $message['message_hash_id'] = $_POST['message_hash_id'];
			                if (!empty($message['reply'])) {
			                    foreach ($non_allowed as $key => $value) {
			                       unset($message['reply']['messageUser'][$value]);
			                    }

			                    $message['reply']['text'] = Wo_Markup($message['reply']['or_text']);
			                    $message['reply']['time_text'] = Wo_Time_Elapsed_String($message['reply']['time']);
			                    $message_po           = 'left';
			                    if ($message['reply']['from_id'] == $wo['user']['user_id']) {
			                        $message_po = 'right';
			                    }
			                    $message['reply']['position'] = $message_po;
			                    $message['reply']['type']     = Wo_GetFilePosition($message['reply']['media']);
			                    if (!empty($message['reply']['stickers']) && strpos($message['reply']['stickers'], '.gif') !== false) {
			                        $message['reply']['type'] = 'gif';
			                    }
			                    if ($message['reply']['type_two'] == 'contact') {
			                        $message['reply']['type']   = 'contact';
			                    }
			                    if (!empty($message['reply']['lng']) && !empty($message['reply']['lat'])) {
			                        $message['reply']['type']   = 'map';
			                    }
			                    $message['reply']['type']     = $message_po . '_' . $message['reply']['type'];
			                    $message['reply']['file_size'] = 0;
			                    if (!empty($message['reply']['media'])) {
			                        $message['reply']['file_size'] = '0MB';
			                        if (file_exists($message['reply']['file_size'])) {
			                            $message['reply']['file_size'] = Wo_SizeFormat(filesize($message['reply']['media']));
			                        }
			                        $message['reply']['media']     = Wo_GetMedia($message['reply']['media']);
			                    }
			                    if (!empty($message['reply']['time'])) {
			                        $time_today = time() - 86400;
			                        if ($message['reply']['time'] < $time_today) {
			                            $message['reply']['time_text'] = date('m.d.y', $message['reply']['time']);
			                        } else {
			                            $time = new DateTime('now', $timezone);
			                            $time->setTimestamp($message['reply']['time']);
			                            $message['reply']['time_text'] = $time->format('H:i');
			                        }
			                    }
			                }
			                if (!empty($message['story'])) {
			                    foreach ($non_allowed as $key => $value) {
			                       unset($message['story']['user_data'][$value]);
			                    }
			                    if (!empty($message['story']['thumb']['filename'])) {
			                        $message['story']['thumbnail'] = $message['story']['thumb']['filename'];
			                        unset($message['story']['thumb']);
			                    } else {
			                        $message['story']['thumbnail'] = $message['story']['user_data']['avatar'];
			                    }
			                    $message['story']['time_text'] = Wo_Time_Elapsed_String($message['story']['posted']);
			                    $message['story']['view_count'] = $db->where('story_id',$message['story']['id'])->where('user_id',$message['story']['user_id'],'!=')->getValue(T_STORY_SEEN,'COUNT(*)');
			                }
			                array_push($messages, $message);
				        }
				        if (!empty($messages)) {
				        	$response_data = array(
				                'api_status' => 200,
				                'message_data' => $messages
				            );
				        }
			        }
			        else{
			            $error_code    = 6;
			            $error_message = 'something went wrong.';
			        }
			    }

    		}
    		else{
    			$error_code    = 4;
				$error_message = 'broadcast not found';
    		}














    	}
    	else{
    		$error_code    = 5;
		    $error_message = 'id can not be empty';
    	}
    }
}
else{
	$error_code    = 4;
    $error_message = 'type can not be empty';
}