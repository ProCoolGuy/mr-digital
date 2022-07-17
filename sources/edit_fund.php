<?php
if ($wo['loggedin'] == false || $wo['config']['funding_system'] != 1) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
if (is_numeric($_GET['id']) && $_GET['id'] > 0) {
    $wo['fund'] = GetFundingById($_GET['id']);
} else {
    $wo['fund'] = GetFundingById($_GET['id'], 'hash');
}
if (empty($wo['fund']) || ($wo['user']['user_id'] != $wo['fund']['user_id'] && Wo_IsAdmin() == false)) {
    header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
    exit();
}
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'edit_fund';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('edit_fund/content');
