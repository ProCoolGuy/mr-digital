<?php
if ($wo['config']['store_system'] != 'on') {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if ($wo['loggedin'] == false) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
$wo['items'] = $db->where('user_id', $wo['user']['id'])->get(T_USERCARD);
$wo['html']  = '';
$wo['total'] = 0;
if (!empty($wo['items'])) {
    foreach ($wo['items'] as $key => $wo['item']) {
        $wo['product'] = Wo_GetProduct($wo['item']->product_id);
        if (!empty($wo['currencies']) && !empty($wo['currencies'][$wo['product']['currency']]) && $wo['currencies'][$wo['product']['currency']]['text'] != $wo['config']['currency'] && !empty($wo['config']['exchange']) && !empty($wo['config']['exchange'][$wo['currencies'][$wo['product']['currency']]['text']])) {
            $wo['total'] += (($wo['product']['price'] / $wo['config']['exchange'][$wo['currencies'][$wo['product']['currency']]['text']]) * $wo['item']->units);
        } else {
            $wo['total'] += ($wo['product']['price'] * $wo['item']->units);
        }
        $wo['html'] .= Wo_LoadPage('checkout/item');
    }
}
$wo['addresses']   = $db->where('user_id', $wo['user']['user_id'])->get(T_USER_ADDRESS);
$wo['topup']       = ($wo['user']['wallet'] < $wo['total'] ? 'show' : 'hide');
$wo['total']       = number_format($wo['total'], '2');
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'checkout';
$wo['title']       = $wo['lang']['checkout'];
$wo['content']     = Wo_LoadPage('checkout/content');
