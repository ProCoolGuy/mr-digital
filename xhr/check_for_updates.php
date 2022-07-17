<?php 
if ($f == 'check_for_updates') {
    $false = false;
    if (!is_dir('themes/wowonder')) {
        $false = true;
    }
    if (!is_dir('themes/wonderful') && $false == true) {
        $false = true;
    } else {
        $false = false;
    }
    if ($false == true) {
        $data['status']     = 400;
        $data['ERROR_NAME'] = 'It looks like you have renamed your themes, please rename them back to "wowonder", "wonderful" to use the auto update system, otherwise please update your site manually.';
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if (Wo_CheckMainSession($hash_id) === true) {
        $arrContextOptions = array(
            "ssl" => array(
                "verify_peer" => false,
                "verify_peer_name" => false
            )
        );
        if (!empty($_GET['purchase_code'])) {
            $purchase_code = Wo_Secure($_GET['purchase_code']);
            $version       = Wo_Secure($wo['script_version']);
            $siteurl       = urlencode($_SERVER['SERVER_NAME']);
            $file          = file_get_contents("http://www.wowonder.com/check_for_updates.php?code={$purchase_code}&version=$version&url=$siteurl", false, stream_context_create($arrContextOptions));
            $check         = json_decode($file, true);
            if (!empty($check['status'])) {
                if ($check['status'] == 'SUCCESS') {
                    if (!empty($check['versions'])) {
                        $data['status']         = 200;
                        $data['script_version'] = $wo['script_version'];
                        $data['versions']       = $check['versions'];
                    } else {
                        $data['status'] = 300;
                    }
                } else {
                    $data['status']     = 400;
                    $data['ERROR_NAME'] = $check['ERROR_NAME'];
                }
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
