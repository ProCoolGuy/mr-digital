<?php
if ($wo['loggedin'] == false || $wo['config']['memories_system'] == 0) {
	header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}

$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'memories';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('memories/content');