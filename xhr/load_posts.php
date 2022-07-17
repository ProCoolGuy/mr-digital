<?php 
if ($f == 'load_posts') {
    $wo['page'] = 'home';
    $load = sanitize_output(Wo_LoadPage('home/load-posts'));
    echo $load;
    exit();
}
