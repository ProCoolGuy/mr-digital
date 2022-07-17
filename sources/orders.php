<?php
if ($wo['config']['store_system'] != 'on') {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if ($wo['loggedin'] == false) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
$wo['orders'] = $db->where('product_owner_id', $wo['user']['user_id'])->orderBy('id', 'DESC')->groupBy('hash_id')->get(T_USER_ORDERS, 10);
$wo['html']   = '<div class="orders_empty_state"><img class="orders_empty_state_img" src="' . $wo['config']['theme_url'] . '/img/no_transaction.svg"> ' . $wo['lang']['no_orders_found'] . '</div>';
if (!empty($wo['orders'])) {
    $wo['html'] = '';
    foreach ($wo['orders'] as $key => $wo['order']) {
        $wo['product'] = $db->where('id', $wo['order']->product_id)->getOne(T_PRODUCTS, array('name'));
        $wo['count']       = $db->where('hash_id', $wo['order']->hash_id)->getValue(T_USER_ORDERS, 'count(*)');
        $wo['items_count'] = $db->where('hash_id', $wo['order']->hash_id)->getValue(T_USER_ORDERS, 'sum(units)');
        $wo['price']       = $db->where('hash_id', $wo['order']->hash_id)->getValue(T_USER_ORDERS, 'sum(price)');
        $wo['price']       = number_format($wo['price'], 2);
        $wo['html'] .= Wo_LoadPage('orders/list');
    }
}
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'orders';
$wo['title']       = $wo['lang']['orders'];
$wo['content']     = Wo_LoadPage('orders/content');
