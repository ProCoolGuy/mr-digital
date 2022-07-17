<?php 
if ($f == 'load_more_products') {
    $html  = '';
    $array = array(
        'limit' => 10
    );
    if (!empty($_POST['c_id'])) {
        $array['c_id'] = Wo_Secure($_POST['c_id']);
    }
    if (!empty($_POST['sub_id'])) {
        $array['sub_id'] = Wo_Secure($_POST['sub_id']);
    }
    if (!empty($_POST['last_id'])) {
        $array['after_id'] = $_POST['last_id'];
    }
    if (!empty($_POST['length'])) {
        $array['length'] = $_POST['length'];
    }
    if (!empty($_POST['price_sort'])) {
        $array['order_by'] = $_POST['price_sort'];
    }
    if (!empty($_POST['price'])) {
        $array['price'] = $_POST['price'];
    }
    if (!empty($_POST['text'])) {
        $array['keyword'] = $_POST['text'];
    }
    $result = Wo_GetProducts($array);
    foreach ($result as $key => $wo['product']) {
        $html .= Wo_LoadPage('products/products-list');
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
