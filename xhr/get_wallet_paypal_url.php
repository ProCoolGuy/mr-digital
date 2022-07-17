<?php 
if ($f == 'get_wallet_paypal_url') {
    $data = array(
        'status' => 400,
        'url' => ''
    );
    if (isset($_POST['amount'])) {
        $url = Wo_PayPal_Payment($_POST['amount'], $_POST['desc']);
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
