<?php
if ($wo['loggedin'] == false || $wo['config']['refund_system'] != 'on') {
  header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
  exit();
}
$wo['is_requested'] = false;
$requested = $db->where('user_id',$wo['user']['id'])->getValue(T_REFUND,"COUNT(*)");
if ($requested > 0) {
	$wo['is_requested'] = true;
}

$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'refund';
$wo['title']       = $wo['lang']['refund'] . ' | ' . $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('refund/content');