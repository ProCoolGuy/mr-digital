<?php
if ($wo['loggedin'] == true) {
    header("Location: " . $wo['config']['site_url']);
    exit();
}
if ($wo['config']['user_registration'] == 0 && (!isset($_GET['invite']) || (!Wo_IsAdminInvitationExists($_GET['invite']) && !Wo_IsUserInvitationExists($_GET['invite'])))) {
    header("Location: " . $wo['config']['site_url']);
    exit();
} else {
    $page = 'register';
    if ($wo['config']['membership_system'] == 1) {
        $page = 'pro_register';
    }
    $wo['description'] = $wo['config']['siteDesc'];
    $wo['keywords']    = $wo['config']['siteKeywords'];
    $wo['page']        = 'welcome';
    $wo['title']       = $wo['config']['siteTitle'];
    $wo['content']     = Wo_LoadPage('welcome/' . $page);
}
