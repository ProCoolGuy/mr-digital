<?php
if ($wo['loggedin'] == false || $wo['config']['job_system'] != 1) {
  header("Location: " . Wo_SeoLink('index.php?link1=welcome'));
  exit();
}
$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'jobs';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('jobs/content');
