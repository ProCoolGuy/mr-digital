<?php
if ($wo['loggedin'] == false || $wo['config']['nearby_shop_system'] == 0 || $wo['config']['classified'] == 0) {
		header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}

$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'nearby_shops';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('nearby_shops/content');
