<?php 
$response_data = array(
    'api_status' => 400,
);

if (empty($_POST['page_id'])) {
    $error_code    = 3;
    $error_message = 'page_id (POST) is missing';
}
else{
    $page_id = Wo_Secure($_POST['page_id']);

    $wo['page_profile'] = Wo_PageData($page_id);

    if ($wo['page_profile']['is_page_onwer'] == true) {
        if ($wo['page_profile']['boosted'] == 0) {
            if ($wo['user']['is_pro'] == 1) {
                $user_id = $wo['user']['user_id'];
                $query = mysqli_query($sqlConnect, "SELECT COUNT(`page_id`) as count FROM " . T_PAGES . " WHERE `user_id` = {$user_id} AND `boosted` = '1'");
                $query_select_fetch = mysqli_fetch_assoc($query);
                $continue = 0;
                if ($wo['user']['pro_type'] == 1) {
                     if ($query_select_fetch['count'] > ($wo['pro_packages'][$wo['pro_packages_types'][$wo['user']['pro_type']]]['pages_promotion'] - 1)) {
                           $continue = 1;
                     }
                } else if ($wo['user']['pro_type'] == 2) {
                     if ($query_select_fetch['count'] > ($wo['pro_packages'][$wo['pro_packages_types'][$wo['user']['pro_type']]]['pages_promotion'] - 1)) {
                           $continue = 1;
                     }
                } else if ($wo['user']['pro_type'] == 3) {
                     if ($query_select_fetch['count'] > ($wo['pro_packages'][$wo['pro_packages_types'][$wo['user']['pro_type']]]['pages_promotion'] - 1)) {
                           $continue = 1;
                     }
                } else if ($wo['user']['pro_type'] == 4) {
                     if ($query_select_fetch['count'] > ($wo['pro_packages'][$wo['pro_packages_types'][$wo['user']['pro_type']]]['pages_promotion'] - 1)) {
                           $continue = 1;
                     }
                }
                if ($continue == 1) {
                    $query_textt = "UPDATE " . T_PAGES . " SET `boosted` = '0' WHERE `page_id` IN (SELECT * FROM (SELECT `page_id` FROM " . T_PAGES . " WHERE `boosted` = '1' AND (`user_id` = {$user_id} OR `page_id` IN (SELECT `page_id` FROM " . T_PAGES . " WHERE `user_id` = {$user_id})) ORDER BY `page_id` DESC LIMIT 1) as t)";
                    $query_two = mysqli_query($sqlConnect, $query_textt);
                }
                $array  = array(
                    'boosted' => 1
                );
                $update = Wo_UpdatePageData($page_id, $array);
                $response_data = array(
                    'api_status' => 200,
                    'message' => 'boosted'
                );
            }
        }
        else{
            if ($wo['user']['is_pro'] == 1) {
                if ($wo['user']['pro_type'] > 1) {
                    $array  = array(
                        'boosted' => 0
                    );
                    $update = Wo_UpdatePageData($page_id, $array);
                    $response_data = array(
                        'api_status' => 200,
                        'message' => 'unboosted'
                    );
                }
            }
        }
    }
    else{
        $error_code    = 4;
        $error_message = 'you are not the page owner';
    }
}