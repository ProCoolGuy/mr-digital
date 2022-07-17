<?php
$wondertage_settings = array();
if (mysqli_query($wo['sqlConnect'], "DESCRIBE `wondertage_settings`")) {
    $settings = $db->get('wondertage_settings');
    foreach ($settings as $key => $value) {
        $wondertage_settings[$value->name] = $value->value;
    }
}
$data = array(
    'status' => 400,
    'error' => $wo['lang']['please_check_details']
);
if (Wo_IsAdmin() || Wo_IsModerator()) {
    if ($s == 'install') {
        if (!mysqli_query($wo['sqlConnect'], "DESCRIBE `wondertage_settings`")) {
            $filename = 'wondertag.sql';
            $templine = '';
            $lines    = file($filename);
            foreach ($lines as $line) {
                if (substr($line, 0, 2) == '--' || $line == '')
                    continue;
                $templine .= $line;
                $query = false;
                if (substr(trim($line), -1, 1) == ';') {
                    $query    = mysqli_query($wo['sqlConnect'], $templine);
                    $templine = '';
                }
            }
            $data = array(
                'status' => 200,
                'message' => "Settings installed"
            );
        } else {
            $data = array(
                'status' => 400,
                'error' => $wo['lang']['please_check_details']
            );
        }
    }
    if ($s == 'update') {
        foreach ($_POST as $key => $value) {
            if (in_array($key, array_keys($wondertage_settings))) {
                if (empty($value)) {
                    $value = 0;
                }
                $update_name = Wo_Secure($key);
                $value       = mysqli_real_escape_string($sqlConnect, $value);
                $query_one   = " UPDATE `wondertage_settings` SET `value` = '{$value}' WHERE `name` = '{$update_name}'";
                $query       = mysqli_query($sqlConnect, $query_one);
            }
        }
        $data = array(
            'status' => 200,
            'message' => "Settings updated"
        );
    }
}
header("Content-type: application/json");
echo json_encode($data);
exit();
