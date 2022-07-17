<?php
if ($wo['config']['website_mode'] != 'linkedin') {
	header("Location: " . $wo['config']['site_url']);
    exit();
}
$posts = Wo_GetOpenToWorkPosts(); 

$wo['open_posts'] = $posts;

$wo['description'] = '';
$wo['keywords']    = '';
$wo['page']        = 'open_to_work_posts';
$wo['title']       = $wo['lang']['open_to_work_posts'];
$wo['content']     = Wo_LoadPage('open_to_work_posts/content');