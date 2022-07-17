<?php 
if ($f == 'get_payment_method') {
    if (!empty($_GET['type'])) {
        $html            = '';
        $pro_types_array = array(
            1,
            2,
            3,
            4
        );
        if (in_array($_GET['type'], $pro_types_array)) {
            switch ($_GET['type']) {
                case 1:
                    $type        = 'week';
                    $description = $wo['lang']['star'].' package';
                    if (strpos($wo['pro_packages']['star']['price'], ".") !== false) {
                        $price = str_replace('.', "", $wo['pro_packages']['star']['price']);
                    } else {
                        $price = $wo['pro_packages']['star']['price'] . '00';
                    }
                    break;
                case 2:
                    $type        = 'month';
                    $description = $wo['lang']['hot'].' package';
                    if (strpos($wo['pro_packages']['hot']['price'], ".") !== false) {
                        $price = str_replace('.', "", $wo['pro_packages']['hot']['price']);
                    } else {
                        $price = $wo['pro_packages']['hot']['price'] . '00';
                    }
                    break;
                case 3:
                    $type        = 'year';
                    $description = $wo['lang']['ultima'].' package';
                    if (strpos($wo['pro_packages']['ultima']['price'], ".") !== false) {
                        $price = str_replace('.', "", $wo['pro_packages']['ultima']['price']);
                    } else {
                        $price = $wo['pro_packages']['ultima']['price'] . '00';
                    }
                    break;
                case 4:
                    $type        = 'life-time';
                    $description = $wo['lang']['vip'].' package';
                    if (strpos($wo['pro_packages']['vip']['price'], ".") !== false) {
                        $price = str_replace('.', "", $wo['pro_packages']['vip']['price']);
                    } else {
                        $price = $wo['pro_packages']['vip']['price'] . '00';
                    }
                    break;
            }
            $wo['hide'] = false;
            if (strpos($_SERVER["HTTP_REFERER"], 'wallet') !== false) {
                $wo['hide'] = true;
            }
            $load = Wo_LoadPage('modals/pay-go-pro');
            $load = str_replace('{pro_type}', $type, $load);
            $load = str_replace('{pro_type_id}', $_GET['type'], $load);
            $load = str_replace('{pro_type_description}', $description, $load);
            $load = str_replace('{pro_type_price}', $price, $load);
            
            if (!empty($load)) {
                $data = array(
                    'status' => 200,
                    'html' => $load
                );
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
