<?php
if ($wo['loggedin'] == false || $wo['config']['poke_system'] == 0) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
global $sqlConnect;
$data      = array();
$user_id   = Wo_Secure($wo['user']['user_id']);
$query     = " SELECT * FROM " . T_POKES . " WHERE `received_user_id` = {$user_id} ORDER BY `id` DESC LIMIT 10";
$sql_query = mysqli_query($sqlConnect, $query);
while ($fetched_data = mysqli_fetch_assoc($sql_query)) {
    $user            = Wo_UserData($fetched_data['send_user_id']);
    $user['poke_id'] = $fetched_data['id'];
    $data[]          = $user;
}
$wo['poke']        = $data;
$wo['description'] = '';
$wo['keywords']    = '';
$wo['page']        = 'poke';
$wo['title']       = $wo['lang']['pokes'];
$wo['content']     = Wo_LoadPage('poke/content');
