<?php


$response_data = array(
    'api_status' => 400,
);
if (empty($_POST['page_id'])) {
    $error_code    = 3;
    $error_message = 'page_id (POST) is missing';
}

if (empty($error_code)) {
    $page_id   = Wo_Secure($_POST['page_id']);
    $page_data = Wo_PageData($page_id);
    if (empty($page_data)) {
        $error_code    = 6;
        $error_message = 'Page not found';
    } else {
        $offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);
        $limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);

        $reviews = Wo_GetPageReviews($page_id, $offset,$limit);

        foreach ($reviews as $key => $value) {
            if (!empty($value['user_data'])) {
                foreach ($non_allowed as $key4 => $value4) {
                  unset($reviews[$key]['user_data'][$value4]);
                }
            }
            else{
                $reviews[$key]['user_data'] = null;
            }
        }

        $response_data = array(
                            'api_status' => 200,
                            'data' => $reviews
                        );
    }
}