<?php 
if ($f == 'set_admin_alert_cookie') {
    setcookie('profileAlert', '1', time() + 86000);
}
