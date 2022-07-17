<?php 
if ($wo['config']['blogs'] == 0) {
	header("Location: " . $wo['config']['site_url']);
    exit();
}
if (empty($_GET['id']) || !is_numeric($_GET['id']) || $_GET['id'] < 1) {
	header("Location: " . $wo['config']['site_url']);
    exit();
}
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'blog';
$wo['title']       = $wo['lang']['blog'];
$wo['content']     = Wo_LoadPage('blog/blog-category');