<?php
if ($wo['loggedin'] == false || $wo['config']['funding_system'] != 1) {
  header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
  exit();
}

if (is_numeric($_GET['id']) && $_GET['id'] > 0) {
	$wo['fund'] = GetFundingById($_GET['id']);
}
else{
	$wo['fund'] = GetFundingById($_GET['id'],'hash');
}
if (empty($wo['fund'])) {
	header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
  exit();
}

$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'show_fund';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('show_fund/content');