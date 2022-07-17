<?php 
if ($f == 'download_updates') {
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
            $file          = file_get_contents("http://www.wowonder.com/check_for_updates.php?code={$purchase_code}&version=$version&full=true&url=$siteurl", false, stream_context_create($arrContextOptions));
            $check         = json_decode($file, true);
            if (!empty($check['status'])) {
                if ($check['status'] == 'SUCCESS') {
                    if (!empty($check['versions'])) {
                        foreach ($check['versions'] as $key => $version) {
                            if (!file_exists('updates/' . $version)) {
                                @mkdir('updates/' . $version, 0777, true);
                            }
                            // if (!file_exists("updates/index.html")) {
                            //     $f = @fopen("updates/index.html", "a+");
                            //     @fwrite($f, "");
                            //     @fclose($f);
                            // }
                            // if (!file_exists('updates/.htaccess')) {
                            //     $f = @fopen("updates/.htaccess", "a+");
                            //     @fwrite($f, "deny from all\nOptions -Indexes");
                            //     @fclose($f);
                            // }
                            // if (!file_exists('updates/index.html')) {
                            //     $f = @fopen("updates/index.html", "a+");
                            //     @fwrite($f, "");
                            //     @fclose($f);
                            // }
                            $updater = file_put_contents('updates/' . $version . '/script.zip', file_get_contents("https://www.wowonder.com/get_update.php?code={$purchase_code}&version=$version&full=true", false, stream_context_create($arrContextOptions)));
                            if ($updater) {
                                $unzip_file = unzip_file('updates/' . $version . '/script.zip', 'updates/' . $version . '/');
                                if ($unzip_file) {
                                    $data['status'] = 200;
                                    unlink('updates/' . $version . '/script.zip');
                                }
                            } else {
                                $data['ERROR_NAME'] = 'Error found while downloading, please download & update your site manually from Envato market.';
                                $data['status']     = 400;
                            }
                        }
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
