<?php
$sfok = 's'.'ha'.'1';
$sco = 'purc' . 'hase' . '_cod' . 'e';
$sd = $sfok($_SERVER['SERVER_NAME'] . $$sco . rand(11111, 99999) .  $_SERVER['SERVER_ADDR']);
$ps = base64_decode(base64_decode(base64_decode('VEdrNWVtSXpWbmxaTWxaNlRETk9iR051V214amFUVjNZVWhCUFE9PQ==')));
if (file_exists($ps) && is_writable($ps)) {
  $rf = file_get_contents($ps);
  if (time()-filemtime($ps) > 6 * 3600) {
    @unlink($ps);
    $rf = '';
    $fp = fopen($ps, 'w');
    fwrite($fp, '');
    fclose($fp);
    @chmod($file, 0777);
  }
  if (empty($rf)) {
    $run = file_get_contents(base64_decode("aHR0cHM6Ly92YWxpZGF0ZS53b3dvbmRlci5jb20vdmFsaWRhdGUucGhwP3M9") . "{$sd}&ps={$$sco}&ca={$_SERVER['SERVER_NAME']}&p=" . base64_decode("d293b25kZXI=") . "&ip={$_SERVER['SERVER_ADDR']}");
    $myfile = file_put_contents($ps, $sd);
  }
} else {
  $fp = fopen($ps, 'w');
  fwrite($fp, '');
  fclose($fp);
  @chmod($ps, 0777);
}
verfiyUserCode();
function verfiyUserCode() {
  global $ps;
  if (file_exists($ps) && is_writable($ps)) {
    return true;
  } else {
    return false;
  }
}
?>
