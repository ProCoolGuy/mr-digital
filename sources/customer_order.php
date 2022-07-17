<?php
if ($wo['config']['store_system'] != 'on') {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if ($wo['loggedin'] == false) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if (empty($_GET['id'])) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
$wo['hash_id'] = Wo_Secure($_GET['id']);
$wo['orders']  = $db->where('user_id', $wo['user']['user_id'])->where('hash_id', $wo['hash_id'])->get(T_USER_ORDERS);
$wo['html']    = '';
if (empty($wo['orders'])) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit;
}
$wo['total']             = 0;
$wo['total_commission']  = 0;
$wo['total_final_price'] = 0;
$wo['address_id']        = 0;
foreach ($wo['orders'] as $key => $wo['order']) {
    $wo['order']->product = Wo_GetProduct($wo['order']->product_id);
    $wo['total'] += $wo['order']->price;
    $wo['total_commission'] += $wo['order']->commission;
    $wo['total_final_price'] += $wo['order']->final_price;
    $wo['address_id']  = $wo['order']->address_id;
    $wo['can_review']  = 0;
    $wo['is_reviewed'] = 0;
    if ($wo['loggedin']) {
        $wo['can_review']  = $db->where('user_id', $wo['user']['user_id'])->where('id', $wo['order']->id)->where('status', 'delivered')->getValue(T_USER_ORDERS, 'COUNT(*)');
        $wo['is_reviewed'] = $db->where('user_id', $wo['user']['user_id'])->where('product_id', $wo['order']->product['id'])->getValue(T_PRODUCT_REVIEW, 'COUNT(*)');
    }
    $wo['html'] .= Wo_LoadPage('customer_order/list');
}
$wo['total']       = number_format($wo['total'], 2);
$wo['address']     = $db->where('id', $wo['address_id'])->getOne(T_USER_ADDRESS);
$wo['refund']      = $db->where('order_hash_id', $wo['hash_id'])->getOne(T_REFUND);
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'customer_order';
$wo['title']       = $wo['lang']['order_details'];
$wo['content']     = Wo_LoadPage('customer_order/content');
