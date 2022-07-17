<?php 
if ($f == 'load_poke') {
    $data['status'] = 400;
    $data['html'] = '';
    if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
        $user_id       = Wo_Secure($wo['user']['user_id']);
        $id            = Wo_Secure($_POST['id']);
        $html = '';
        $query         = " SELECT * FROM " . T_POKES . " WHERE `received_user_id` = {$user_id} AND `id` < {$id} ORDER BY `id` DESC LIMIT 10";
        $sql_query = mysqli_query($sqlConnect, $query);
        while ($fetched_data = mysqli_fetch_assoc($sql_query)) {
            $wo['poke']   = Wo_UserData($fetched_data['send_user_id']);
            $wo['poke']['poke_id']   = $fetched_data['id'];
            $html .= "<div class='wo_pokes_cont'>" . Wo_LoadPage('poke/poke-list') . "</div>";
        }
        $data['status'] = 200;
        $data['html'] = $html;
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}

mysqli_close($sqlConnect);
unset($wo);
?>