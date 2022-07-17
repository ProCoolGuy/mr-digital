<?php 
if ($f == 'load-more-users') {
    $offset = (isset($_GET['offset']) && is_numeric($_GET['offset'])) ? $_GET['offset'] : false;
    $query  = (isset($_GET['query'])) ? $_GET['query'] : '';
    $html   = "";
    $data   = array(
        "status" => 404,
        "html" => $html
    );

    if ($offset) {
        $groups = Wo_GetSearchFilter(
            $_POST
        , 10, $offset);
        if (count($groups) > 0) {
            foreach ($groups as $wo['result']) {
                if ($wo['config']['theme'] == 'sunshine') {
                    $html .= Wo_LoadPage('search/user-result');
                }
                else{
                    $html .= Wo_LoadPage('search/user-result');
                }
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
