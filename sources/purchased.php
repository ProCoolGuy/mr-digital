<?php
if ($wo['config']['store_system'] != 'on') {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if ($wo['loggedin'] == false) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
$wo['purchased'] = $db->where('user_id', $wo['user']['user_id'])->orderBy('id', 'DESC')->get(T_PURCHAES, 20);
$wo['html']      = '<div class="purchased_empty_state"> ' . $wo['lang']['no_purchased_found'] . '</div>';
if (!empty($wo['purchased'])) {
    $wo['html'] = '';
    foreach ($wo['purchased'] as $key => $wo['purchase']) {
        $wo['purchase']->data = json_decode($wo['purchase']->data, true);
        $wo['purchase']->type = $wo['lang']['order'];
        $wo['purchase']->date = Wo_Time_Elapsed_String($wo['purchase']->time);
        $wo['purchase']->url  = Wo_SeoLink('index.php?link1=customer_order&id=' . $wo['purchase']->order_hash_id);
        $wo['html'] .= Wo_LoadPage('purchased/list');
    }
}
$wo['have_products'] = $db->where('product_owner_id',$wo['user']['user_id'])->getValue(T_USER_ORDERS,'COUNT(*)');
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'purchased';
$wo['title']       = $wo['lang']['purchased'];
$wo['content']     = Wo_LoadPage('purchased/content');
