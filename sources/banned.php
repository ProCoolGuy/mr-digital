<?php 
if (empty($wo['user']) || $wo['user']['banned'] != 1) {
	header("Location: " . $wo['config']['site_url']);
    exit();
}
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'banned';
$wo['title']       = $wo['lang']['banned'];
$wo['content']     = Wo_LoadPage('banned/content');