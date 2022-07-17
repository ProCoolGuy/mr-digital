<?php
if ($wo['loggedin'] == false || $wo['config']['nearby_business_system'] == 0 || $wo['config']['job_system'] == 0) {
		header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}

$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'nearby_business';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('nearby_business/content');
