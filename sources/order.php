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
$wo['orders']  = $db->where('hash_id', $wo['hash_id'])->get(T_USER_ORDERS);
$wo['html']    = '';
if (empty($wo['orders']) || empty($wo['orders'][0]) || ($wo['orders'][0]->product_owner_id != $wo['user']['user_id'] && !Wo_IsAdmin() && !Wo_IsModerator())) {
    header("Location: $site_url/404");
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
    $wo['address_id'] = $wo['order']->address_id;
    $wo['html'] .= Wo_LoadPage('order/list');
}
$wo['total']             = number_format($wo['total'], 2);
$wo['total_commission']  = number_format($wo['total_commission'], 2);
$wo['total_final_price'] = number_format($wo['total_final_price'], 2);
$wo['address']           = $db->where('id', $wo['address_id'])->getOne(T_USER_ADDRESS);
$wo['description']       = $wo['config']['siteDesc'];
$wo['keywords']          = $wo['config']['siteKeywords'];
$wo['page']              = 'order';
$wo['title']             = $wo['lang']['order_details'];
$wo['content']           = Wo_LoadPage('order/content');
