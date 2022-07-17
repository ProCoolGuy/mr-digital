<?php
$discount_type = array(
    'discount_percent',
    'discount_amount',
    'buy_get_discount',
    'spend_get_off',
    'free_shipping'
);
$salary_date   = array(
    'per_hour',
    'per_day',
    'per_week',
    'per_month',
    'per_year'
);
$question_type = array(
    'free_text_question',
    'yes_no_question',
    'multiple_choice_question'
);
if ($f == 'offer' && $wo['config']['offer_system'] == 1) {
    $data['status'] = 400;
    if ($s == 'create_offer') {
        if (!empty($_POST['discount_type']) && in_array($_POST['discount_type'], $discount_type) && in_array($_POST['currency'], array_keys($wo['currencies'])) && !empty($_FILES["thumbnail"]) && !empty($_POST['page_id']) && is_numeric($_POST['page_id']) && $_POST['page_id'] > 0) {
            $page_data = $db->where('page_id', Wo_Secure($_POST['page_id']))->getOne(T_PAGES);
            if (!empty($page_data) && Wo_IsPageOnwer($page_data->page_id)) {
                $discount_type    = 'free_shipping';
                $discount_percent = 0;
                $discount_amount  = 0;
                $buy              = 0;
                $get              = 0;
                $spend            = 0;
                $amount_off       = 0;
                if ($_POST['discount_type'] == 'discount_percent') {
                    if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99) {
                        $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                    } else {
                        $discount_type    = 'discount_percent';
                        $discount_percent = Wo_Secure($_POST['discount_percent']);
                        $discount_amount  = 0;
                        $buy              = 0;
                        $get              = 0;
                        $spend            = 0;
                        $amount_off       = 0;
                    }
                } elseif ($_POST['discount_type'] == 'discount_amount') {
                    if (empty($_POST['discount_amount']) || !is_numeric($_POST['discount_amount']) || $_POST['discount_amount'] < 1) {
                        $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                    } else {
                        $discount_type    = 'discount_amount';
                        $discount_amount  = Wo_Secure($_POST['discount_amount']);
                        $discount_percent = 0;
                        $buy              = 0;
                        $get              = 0;
                        $spend            = 0;
                        $amount_off       = 0;
                    }
                } elseif ($_POST['discount_type'] == 'buy_get_discount') {
                    if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99 || empty($_POST['buy']) || !is_numeric($_POST['buy']) || $_POST['buy'] < 1 || empty($_POST['get']) || !is_numeric($_POST['get']) || $_POST['get'] < 1) {
                        $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                    } else {
                        $discount_type    = 'buy_get_discount';
                        $buy              = Wo_Secure($_POST['buy']);
                        $get              = Wo_Secure($_POST['get']);
                        $discount_amount  = 0;
                        $discount_percent = Wo_Secure($_POST['discount_percent']);
                        $spend            = 0;
                        $amount_off       = 0;
                    }
                } elseif ($_POST['discount_type'] == 'spend_get_off') {
                    if (empty($_POST['spend']) || !is_numeric($_POST['spend']) || $_POST['spend'] < 1 || empty($_POST['amount_off']) || !is_numeric($_POST['amount_off']) || $_POST['amount_off'] < 1) {
                        $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                    } else {
                        $discount_type    = 'spend_get_off';
                        $buy              = 0;
                        $get              = 0;
                        $discount_amount  = 0;
                        $discount_percent = 0;
                        $spend            = Wo_Secure($_POST['spend']);
                        $amount_off       = Wo_Secure($_POST['amount_off']);
                    }
                }
                if (empty($_POST['description']) || strlen($_POST['description']) < 32) {
                    $data['error'] = $error_icon . $wo['lang']['desc_more_than32'];
                }
                if (empty($_POST['expire_date']) || empty($_POST['expire_time'])) {
                    $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                }
                if (!empty($_POST['discounted_items']) && strlen($_POST['discounted_items']) > 100) {
                    $data['error'] = $error_icon . $wo['lang']['discounted_items_less'];
                }
                $fileInfo = array(
                    'file' => $_FILES["thumbnail"]["tmp_name"],
                    'name' => $_FILES['thumbnail']['name'],
                    'size' => $_FILES["thumbnail"]["size"],
                    'type' => $_FILES["thumbnail"]["type"],
                    'types' => 'jpeg,jpg,png,bmp'
                );
                $media    = Wo_ShareFile($fileInfo);
                if (empty($media) || empty($media['filename'])) {
                    $data['error'] = $error_icon . $wo['lang']['file_not_supported'];
                }
                if (empty($data['error'])) {
                    $offer_id    = $db->insert(T_OFFER, array(
                        'discount_type' => $discount_type,
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
                        'currency' => Wo_Secure($_POST['currency']),
                        'time' => time()
                    ));
                    $description = mb_substr(Wo_Secure($_POST['description']), 0, 175, "UTF-8") . "...";
                    $post_id     = $db->insert(T_POSTS, array(
                        'page_id' => $page_data->page_id,
                        'postText' => $description,
                        'offer_id' => $offer_id,
                        'postType' => 'offer',
                        'postPrivacy' => 0,
                        'time' => time()
                    ));
                    $db->where('id', $post_id)->update(T_POSTS, array(
                        'post_id' => $post_id
                    ));
                    $data['status'] = 200;
                }
            } else {
                $data['error'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'delete_offer' && !empty($_GET['offer_id']) && is_numeric($_GET['offer_id']) && $_GET['offer_id'] > 0) {
        $offer_id = Wo_Secure($_GET['offer_id']);
        $offer    = $db->where('id', $offer_id)->getOne(T_OFFER);
        if (!empty($offer) && ($offer->user_id == $wo['user']['id'] || Wo_IsModerator() || Wo_IsAdmin())) {
            @unlink($offer->image);
            Wo_DeleteFromToS3($offer->image);
            $db->where('id', $offer_id)->delete(T_OFFER);
            $post = $db->where('offer_id', $offer_id)->getOne(T_POSTS);
            if (!empty($post)) {
                Wo_DeletePost($post->id);
            }
        }
        $data['status'] = 200;
    }
    if ($s == 'load_more' && !empty($_POST['last_id']) && is_numeric($_POST['last_id']) && $_POST['last_id'] > 0) {
        $last_id = Wo_Secure($_POST['last_id']);
        $offer   = $db->where('id', $last_id)->getOne(T_OFFER);
        $html    = '';
        if (!empty($offer)) {
            $offers = Wo_GetAllOffers(array(
                'after_id' => $last_id,
                'limit' => 15
            ));
            foreach ($offers as $key => $wo['offer']) {
                $html .= Wo_LoadPage('offers/offers');
            }
        }
        $data['status'] = 200;
        $data['html']   = $html;
    }
    if ($s == 'get_offer' && !empty($_POST['offer_id']) && is_numeric($_POST['offer_id']) && $_POST['offer_id'] > 0) {
        $wo['offer']    = Wo_GetOfferById($_POST['offer_id']);
        $html           = '';
        $data['status'] = 400;
        if (!empty($wo['offer'])) {
            $wo['offer']['description'] = Wo_EditMarkup($wo['offer']['description'], true, true, true);
            $wo['offer']['description'] = str_replace('<br>', "\n", $wo['offer']['description']);
            $html                       = Wo_LoadPage('modals/edit_offer');
            $data['status']             = 200;
            $data['html']               = $html;
        }
    }
    if ($s == 'edit_offer' && !empty($_POST['offer_id']) && is_numeric($_POST['offer_id']) && $_POST['offer_id'] > 0) {
        $offer_id = Wo_Secure($_POST['offer_id']);
        $offer    = $db->where('id', $offer_id)->getOne(T_OFFER);
        if (!empty($offer) && (Wo_IsPageOnwer($offer->page_id) || $offer->user_id == $wo['user']['id'] || Wo_IsModerator() || Wo_IsAdmin())) {
            if (!empty($_POST['discount_type']) && in_array($_POST['discount_type'], $discount_type) && !empty($_POST['page_id'])) {
                $page_data = $db->where('page_id', Wo_Secure($_POST['page_id']))->getOne(T_PAGES);
                if (!empty($page_data) && Wo_IsPageOnwer($page_data->page_id)) {
                    $discount_type    = 'free_shipping';
                    $discount_percent = 0;
                    $discount_amount  = 0;
                    $buy              = 0;
                    $get              = 0;
                    $spend            = 0;
                    $amount_off       = 0;
                    if ($_POST['discount_type'] == 'discount_percent') {
                        if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99) {
                            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                        } else {
                            $discount_type    = 'discount_percent';
                            $discount_percent = Wo_Secure($_POST['discount_percent']);
                            $discount_amount  = 0;
                            $buy              = 0;
                            $get              = 0;
                            $spend            = 0;
                            $amount_off       = 0;
                        }
                    } elseif ($_POST['discount_type'] == 'discount_amount') {
                        if (empty($_POST['discount_amount']) || !is_numeric($_POST['discount_amount']) || $_POST['discount_amount'] < 1) {
                            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                        } else {
                            $discount_type    = 'discount_amount';
                            $discount_amount  = Wo_Secure($_POST['discount_amount']);
                            $discount_percent = 0;
                            $buy              = 0;
                            $get              = 0;
                            $spend            = 0;
                            $amount_off       = 0;
                        }
                    } elseif ($_POST['discount_type'] == 'buy_get_discount') {
                        if (empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] < 1 || $_POST['discount_percent'] > 99 || empty($_POST['buy']) || !is_numeric($_POST['buy']) || $_POST['buy'] < 1 || empty($_POST['get']) || !is_numeric($_POST['get']) || $_POST['get'] < 1) {
                            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                        } else {
                            $discount_type    = 'buy_get_discount';
                            $buy              = Wo_Secure($_POST['buy']);
                            $get              = Wo_Secure($_POST['get']);
                            $discount_amount  = 0;
                            $discount_percent = Wo_Secure($_POST['discount_percent']);
                            $spend            = 0;
                            $amount_off       = 0;
                        }
                    } elseif ($_POST['discount_type'] == 'spend_get_off') {
                        if (empty($_POST['spend']) || !is_numeric($_POST['spend']) || $_POST['spend'] < 1 || empty($_POST['amount_off']) || !is_numeric($_POST['amount_off']) || $_POST['amount_off'] < 1) {
                            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                        } else {
                            $discount_type    = 'spend_get_off';
                            $buy              = 0;
                            $get              = 0;
                            $discount_amount  = 0;
                            $discount_percent = 0;
                            $spend            = Wo_Secure($_POST['spend']);
                            $amount_off       = Wo_Secure($_POST['amount_off']);
                        }
                    }
                    if (empty($_POST['description']) || strlen($_POST['description']) < 32) {
                        $data['error'] = $error_icon . $wo['lang']['desc_more_than32'];
                    }
                    if (!empty($_POST['discounted_items']) && strlen($_POST['discounted_items']) > 100) {
                        $data['error'] = $error_icon . $wo['lang']['discounted_items_less'];
                    }
                    if (empty($data['error'])) {
                        $description    = mb_substr(Wo_Secure($_POST['description']), 0, 175, "UTF-8") . "...";
                        $offer_id       = $db->where('id', $offer_id)->update(T_OFFER, array(
                            'discount_type' => $discount_type,
                            'buy' => $buy,
                            'get_price' => $get,
                            'discount_amount' => $discount_amount,
                            'discount_percent' => $discount_percent,
                            'spend' => $spend,
                            'amount_off' => $amount_off,
                            'description' => Wo_Secure($_POST['description']),
                            'discounted_items' => Wo_Secure($_POST['discounted_items'])
                        ));
                        $post_id        = $db->where('offer_id', $offer_id)->update(T_POSTS, array(
                            'postText' => $description
                        ));
                        $data['status'] = 200;
                    }
                } else {
                    $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                }
            } else {
                $data['error'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
}
header("Content-type: application/json");
echo json_encode($data);
exit();
