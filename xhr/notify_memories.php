<?php
if ($f == "notify_memories") {
    $wo['user']['notification_settings'] = (Array) json_decode(html_entity_decode($wo['user']['notification_settings']));
    if ($wo['loggedin'] == true && $wo['config']['memories_system'] != 0 && $wo['user']['notification_settings']['e_memory'] == 1 && empty($_COOKIE['memory'])) {
        Wo_AddNotifyMemories();
        setcookie("memory", '1', time() + (1 * 60 * 60));
    }
    $data['status'] = 200;
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
