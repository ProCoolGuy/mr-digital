<?php
$wo['AgorachannelName'] = "stream_".$wo['user']['id'].'_'.rand(1111111,9999999);
$wo['AgoraToken'] = null;
if (!empty($wo['config']['agora_app_certificate'])) {
	include(dirname(__DIR__)."/src/RtcTokenBuilder.php");

	$appID = $wo['config']['agora_app_id'];
	$appCertificate = $wo['config']['agora_app_certificate'];
	$uid = 0;
	$uidStr = "0";
	$role = RtcTokenBuilder::RoleAttendee;
	$expireTimeInSeconds = 36000000;
	$currentTimestamp = (new DateTime("now", new DateTimeZone('UTC')))->getTimestamp();
	$privilegeExpiredTs = $currentTimestamp + $expireTimeInSeconds;
	$wo['AgoraToken'] = RtcTokenBuilder::buildTokenWithUid($appID, $appCertificate, $wo['AgorachannelName'], $uid, $role, $privilegeExpiredTs);
	// echo "<h1>".$wo['AgoraToken']."</h1>";
	// echo "<h1>".$wo['AgorachannelName']."</h1>";
}

?>
