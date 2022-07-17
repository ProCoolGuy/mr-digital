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
                        'delete',
                        'edit',
                        'get'
                    );

$discount_type = array('discount_percent','discount_amount','buy_get_discount','spend_get_off','free_shipping');
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'create') {

    	if (!empty($_POST['discount_type']) && in_array($_POST['discount_type'], $discount_type) && in_array($_POST['currency'], array_keys($wo['currencies'])) && !empty($_FILES["thumbnail"]) && !empty($_POST['page_id'])) {

    		$page_data = $db->where('page_id',Wo_Secure($_POST['page_id']))->getOne(T_PAGES);

    		if (!empty($page_data) && $page_data->user_id == $wo['user']['id']) {

	    		$discount_type = 'free_shipping';
	    		$discount_percent = 0;
				$discount_amount = 0;
				$buy = 0;
				$get = 0;
				$spend = 0;
				$amount_off = 0;
	    		if ($_POST['discount_type'] == 'discount_percent') {
	    			if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99) {
	    				$error_code    = 7;
			            $error_message = 'discount_percent must be between 1 and 99';
	    			}
	    			else{
	    				$discount_type = 'discount_percent';
	    				$discount_percent = Wo_Secure($_POST['discount_percent']);
	    				$discount_amount = 0;
	    				$buy = 0;
	    				$get = 0;
	    				$spend = 0;
	    				$amount_off = 0;
	    			}
	    		}
	    		elseif ($_POST['discount_type'] == 'discount_amount') {
	    			if (empty($_POST['discount_amount']) || !is_numeric($_POST['discount_amount']) || $_POST['discount_amount'] < 1) {
	    				$error_code    = 8;
			            $error_message = 'discount_amount can not be empty';
	    			}
	    			else{
	    				$discount_type = 'discount_amount';
	    				$discount_amount = Wo_Secure($_POST['discount_amount']);
	    				$discount_percent = 0;
	    				$buy = 0;
	    				$get = 0;
	    				$spend = 0;
	    				$amount_off = 0;
	    			}
	    		}
	    		elseif ($_POST['discount_type'] == 'buy_get_discount') {
	    			if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99 || empty($_POST['buy']) || !is_numeric($_POST['buy']) || $_POST['buy'] < 1 || empty($_POST['get']) || !is_numeric($_POST['get']) || $_POST['get'] < 1) {
	    				$error_code    = 9;
			            $error_message = 'discount_percent must be between 1 and 99 and buy and get can not be empty';
	    			}
	    			else{
	    				$discount_type = 'buy_get_discount';
	    				$buy = Wo_Secure($_POST['buy']);
	    				$get = Wo_Secure($_POST['get']);
	    				$discount_amount = 0;
	    				$discount_percent = Wo_Secure($_POST['discount_percent']);
	    				$spend = 0;
	    				$amount_off = 0;
	    			}
	    		}
	    		elseif ($_POST['discount_type'] == 'spend_get_off') {
	    			if (empty($_POST['spend']) || !is_numeric($_POST['spend']) || $_POST['spend'] < 1 || empty($_POST['amount_off']) || !is_numeric($_POST['amount_off']) || $_POST['amount_off'] < 1) {
	    				$error_code    = 10;
			            $error_message = 'spend and amount_off can not be empty';
	    			}
	    			else{
	    				$discount_type = 'spend_get_off';
	    				$buy = 0;
	    				$get = 0;
	    				$discount_amount = 0;
	    				$discount_percent = 0;
	    				$spend = Wo_Secure($_POST['spend']);
	    				$amount_off = Wo_Secure($_POST['amount_off']);
	    			}
	    		}

	    		if (empty($_POST['description']) || strlen($_POST['description']) < 32) {
	    			$error_code    = 11;
			        $error_message = 'description must be more than 32';
	    		}
	    		if (empty($_POST['expire_date']) || empty($_POST['expire_time'])) {
	    			$error_code    = 12;
			        $error_message = 'expire_date and expire_time can not be empty';
	    		}
	    		if (!empty($_POST['discounted_items']) && strlen($_POST['discounted_items']) > 100) {
	    			$error_code    = 13;
			        $error_message = 'discounted_items must be less than 100';
	    		}

	    		$fileInfo      = array(
                    'file' => $_FILES["thumbnail"]["tmp_name"],
                    'name' => $_FILES['thumbnail']['name'],
                    'size' => $_FILES["thumbnail"]["size"],
                    'type' => $_FILES["thumbnail"]["type"],
                    'types' => 'jpeg,jpg,png,bmp'
                );
                $media         = Wo_ShareFile($fileInfo);
                if (empty($media) || empty($media['filename'])) {
                	$error_code    = 14;
			        $error_message = 'file not supported';
                }

	    		if (empty($error_message)) {
	    			
	    			$offer_id = $db->insert(T_OFFER,array('discount_type' => $discount_type,
	    		                                          'buy' => $buy,
	    		                                          'get_price' => $get,
	    		                                          'discount_amount' => $discount_amount,
	    		                                          'discount_percent' => $discount_percent,
	    		                                          'spend' => $spend,
	    		                                          'amount_off' => $amount_off,
	    		                                          'description' => Wo_Secure($_POST['description']),
	    		                                          'expire_date' => Wo_Secure($_POST['expire_date']),
	    		                                          'expire_time' => Wo_Secure($_POST['expire_time']),
	    		                                          'discounted_items' => Wo_Secure($_POST['discounted_items']),
	    		                                          'page_id' => $page_data->page_id,
	    		                                          'user_id' => $wo['user']['id'],
	    		                                          'image' => $media['filename'],
	    		                                          'time' => time()));
                    $description = mb_substr(Wo_Secure($_POST['description']),0,175,"UTF-8") . "...";
	    			$post_id = $db->insert(T_POSTS,array('page_id' => $page_data->page_id,
				    	                                 'postText' => $description,
				    	                                 'offer_id' => $offer_id,
                                                         'postType' => 'offer',
                                                         'postPrivacy' => 0,
                                                         'time' => time()));
		    		$db->where('id',$post_id)->update(T_POSTS,array('post_id' => $post_id));
	    			$post = Wo_PostData($post_id);
	    			$response_data = array(
                                'api_status' => 200,
                                'data' => $post
                            );
	    		}
	    	}
	    	else{
	    		$error_code    = 6;
	            $error_message = 'page not found or you are not the page owner';
	    	}
    	}
    	else{
    		$error_code    = 5;
            $error_message = 'please check your details';
    	}
    }
    elseif ($_POST['type'] == 'delete') {
    	if (!empty($_POST['offer_id']) && is_numeric($_POST['offer_id']) && $_POST['offer_id'] > 0) {
    		$offer_id = Wo_Secure($_POST['offer_id']);
	        $offer = $db->where('id',$offer_id)->getOne(T_OFFER);
	        if (!empty($offer) && ($offer->user_id == $wo['user']['id'] || Wo_IsModerator() || Wo_IsAdmin())) {
	            @unlink($offer->image);
	            Wo_DeleteFromToS3($offer->image);
	            $db->where('id',$offer_id)->delete(T_OFFER);
	            $post = $db->where('offer_id',$offer_id)->getOne(T_POSTS);
	            if (!empty($post)) {
	                Wo_DeletePost($post->id);
	                $response_data = array(
                                'api_status' => 200,
                                'message' => 'offer successfully deleted '
                            );
	            }
	        }
	        else{
	        	$error_code    = 6;
	            $error_message = 'offer not found or you are not the owner';
	        }
    	}
    	else{
    		$error_code    = 5;
            $error_message = 'offer_id can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'edit') {
    	if (!empty($_POST['offer_id']) && is_numeric($_POST['offer_id']) && $_POST['offer_id'] > 0) {
    		$offer_id = Wo_Secure($_POST['offer_id']);
	        $offer = $db->where('id',$offer_id)->getOne(T_OFFER);
	        if (!empty($offer) && ($offer->user_id == $wo['user']['id'] || Wo_IsModerator() || Wo_IsAdmin())) {

	        	if (!empty($_POST['discount_type']) && in_array($_POST['discount_type'], $discount_type)) {

		    		$page_data = $db->where('page_id',$offer->page_id)->getOne(T_PAGES);

		    		if (!empty($page_data) && $page_data->user_id == $wo['user']['id']) {

			    		$discount_type = 'free_shipping';
			    		$discount_percent = 0;
						$discount_amount = 0;
						$buy = 0;
						$get = 0;
						$spend = 0;
						$amount_off = 0;
			    		if ($_POST['discount_type'] == 'discount_percent') {
			    			if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99) {
			    				$error_code    = 9;
					            $error_message = 'discount_percent must be between 1 and 99';
			    			}
			    			else{
			    				$discount_type = 'discount_percent';
			    				$discount_percent = Wo_Secure($_POST['discount_percent']);
			    				$discount_amount = 0;
			    				$buy = 0;
			    				$get = 0;
			    				$spend = 0;
			    				$amount_off = 0;
			    			}
			    		}
			    		elseif ($_POST['discount_type'] == 'discount_amount') {
			    			if (empty($_POST['discount_amount']) || !is_numeric($_POST['discount_amount']) || $_POST['discount_amount'] < 1) {
			    				$error_code    = 10;
					            $error_message = 'discount_amount can not be empty';
			    			}
			    			else{
			    				$discount_type = 'discount_amount';
			    				$discount_amount = Wo_Secure($_POST['discount_amount']);
			    				$discount_percent = 0;
			    				$buy = 0;
			    				$get = 0;
			    				$spend = 0;
			    				$amount_off = 0;
			    			}
			    		}
			    		elseif ($_POST['discount_type'] == 'buy_get_discount') {
			    			if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99 || empty($_POST['buy']) || !is_numeric($_POST['buy']) || $_POST['buy'] < 1 || empty($_POST['get']) || !is_numeric($_POST['get']) || $_POST['get'] < 1) {
			    				$error_code    = 11;
					            $error_message = 'discount_percent must be between 1 and 99 and buy and get can not be empty';
			    			}
			    			else{
			    				$discount_type = 'buy_get_discount';
			    				$buy = Wo_Secure($_POST['buy']);
			    				$get = Wo_Secure($_POST['get']);
			    				$discount_amount = 0;
			    				$discount_percent = Wo_Secure($_POST['discount_percent']);
			    				$spend = 0;
			    				$amount_off = 0;
			    			}
			    		}
			    		elseif ($_POST['discount_type'] == 'spend_get_off') {
			    			if (empty($_POST['spend']) || !is_numeric($_POST['spend']) || $_POST['spend'] < 1 || empty($_POST['amount_off']) || !is_numeric($_POST['amount_off']) || $_POST['amount_off'] < 1) {
			    				$error_code    = 12;
					            $error_message = 'spend and amount_off can not be empty';
			    			}
			    			else{
			    				$discount_type = 'spend_get_off';
			    				$buy = 0;
			    				$get = 0;
			    				$discount_amount = 0;
			    				$discount_percent = 0;
			    				$spend = Wo_Secure($_POST['spend']);
			    				$amount_off = Wo_Secure($_POST['amount_off']);
			    			}
			    		}

			    		if (empty($_POST['description']) || strlen($_POST['description']) < 32) {
			    			$error_code    = 13;
					        $error_message = 'description must be more than 32';
			    		}
			    		if (!empty($_POST['discounted_items']) && strlen($_POST['discounted_items']) > 100) {
			    			$error_code    = 14;
					        $error_message = 'discounted_items must be less than 100';
			    		}

			    		if (empty($data['error'])) {
			    			$description = mb_substr(Wo_Secure($_POST['description']),0,175,"UTF-8") . "...";
			    			$offer_id = $db->where('id',$offer_id)->update(T_OFFER,array('discount_type' => $discount_type,
									    		                                          'buy' => $buy,
									    		                                          'get_price' => $get,
									    		                                          'discount_amount' => $discount_amount,
									    		                                          'discount_percent' => $discount_percent,
									    		                                          'spend' => $spend,
									    		                                          'amount_off' => $amount_off,
									    		                                          'description' => Wo_Secure($_POST['description']),
									    		                                          'discounted_items' => Wo_Secure($_POST['discounted_items'])));

			    			$post_id = $db->where('offer_id',$offer_id)->update(T_POSTS,array('postText' => $description));
			    			$response_data = array(
						                        'api_status' => 200,
						                        'message_data' => 'offer successfully edited'
						                    );
			    		}
			    	}
			    	else{
			    		$error_code    = 8;
			            $error_message = 'you are not the page owner';
			    	}
		    	}
		    	else{
		    		$error_code    = 7;
		            $error_message = 'discount_type can not be empty';
		    	}
	        }
	        else{
	        	$error_code    = 6;
	            $error_message = 'offer not found or you are not the owner';
	        }
    	}
    	else{
    		$error_code    = 5;
            $error_message = 'offer_id can not be empty';
    	}
    }
    elseif ($_POST['type'] == 'get') {
    	$data['limit'] = $limit;
    	$data['after_id'] = $offset;
		$offers = Wo_GetAllOffers($data);
		$response_data = array(
                            'api_status' => 200,
                            'data' => $offers
                        );
    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}