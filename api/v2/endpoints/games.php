<?php

$response_data = array(
    'api_status' => 400
);

$required_fields =  array(
                        'get',
                        'get_my',
                        'add_to_my',
                        'search',
                        'popular'
                    );

$limit = (!empty($_POST['limit']) && is_numeric($_POST['limit']) && $_POST['limit'] > 0 && $_POST['limit'] <= 50 ? Wo_Secure($_POST['limit']) : 20);
$offset = (!empty($_POST['offset']) && is_numeric($_POST['offset']) && $_POST['offset'] > 0 ? Wo_Secure($_POST['offset']) : 0);

if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {

    if ($_POST['type'] == 'get') {

        $games = Wo_GetAllGames($limit,$offset);
        $response_data = array(
                                'api_status' => 200,
                                'data' => $games
                            );
    }
    if ($_POST['type'] == 'get_my') {

        $games = Wo_GetMyGames($limit,$offset);
        $response_data = array(
                                'api_status' => 200,
                                'data' => $games
                            );
    }
    if ($_POST['type'] == 'add_to_my') {
        if (!empty($_POST['game_id']) && is_numeric($_POST['game_id']) && $_POST['game_id'] > 0) {
            $game_id  = Wo_Secure($_POST['game_id']);
            Wo_AddPlayGame($game_id);
            $response_data = array(
                                'api_status' => 200,
                            );
        }
        else{
            $error_code    = 5;
            $error_message = 'game_id can not be empty';
        }
    }
    if ($_POST['type'] == 'search') {
        if (!empty($_POST['query'])) {
            $query  = Wo_Secure($_POST['query']);
            $search_query = Wo_GetSearchAdv($query, 'games',$offset,$limit);
            $response_data = array(
                                'api_status' => 200,
                                'data'       => $search_query
                            );
        }
        else{
            $error_code    = 5;
            $error_message = 'query can not be empty';
        }
    }
    if ($_POST['type'] == 'popular') {
        $games = Wo_GetPopularGames($limit,$offset);
        $response_data = array(
                    'api_status' => 200,
                    'data' => $games
                );
    }

}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}