<?php 
if ($f == 'load_profile_posts') {
    if (!empty($_GET['user_id'])) {
        $wo['page']         = 'timeline';
        $wo['user_profile'] = Wo_UserData($_GET['user_id']);
        $load               = Wo_LoadPage('timeline/load-posts');
        echo $load;
        exit();
    }
}

