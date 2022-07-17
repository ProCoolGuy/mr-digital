<?php 
if ($f == 'get_paypal_url') {
    $data = array(
        'status' => 400,
        'url' => ''
    );
    if (isset($_POST['type'])) {
        $type2 = '';
        if (!empty($_POST['type2'])) {
            $type2 = $_POST['type2'];
        }
        $url = Wo_PayPal($_POST['type'], $type2);
        if (!empty($url['type'])) {
            if ($url['type'] == 'SUCCESS' && !empty($url['type'])) {
                $data = array(
                    'status' => 200,
                    'url' => $url['url']
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
