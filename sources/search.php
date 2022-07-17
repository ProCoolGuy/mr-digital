<?php
$wo['description'] = '';
$wo['keywords']    = '';
$wo['page']        = 'search';
$wo['title']       = $wo['lang']['search'] . ' | ' . $wo['config']['siteTitle'];
if ($wo['config']['website_mode'] == 'linkedin') {
    $wo['content'] = Wo_LoadPage('search/linkedin');
} else {
    $wo['content'] = Wo_LoadPage('search/content');
}
