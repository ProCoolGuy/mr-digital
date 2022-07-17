<?php 
if ($f == 'show_common_user') {
    if ($s == 'show') {
        $html = '';
        if (!empty($_GET['user_id'])) {
            $popover_before = Wo_GetCommonUsers(array('limit' => 4,'before' => $_GET['user_id'],'order_by' => false));
            $popover_after = Wo_GetCommonUsers(array('limit' => 4,'after' => $_GET['user_id']));
            $popover = array();

            if (!empty($popover_before)) {
                for ($i = count($popover_before) - 1; $i >= 0 ; $i--) { 
                    $popover[] = $popover_before[$i]['user_data'];
                }
            }

            $popover[] = Wo_UserData($_GET['user_id']);
            $wo['slide_num'] = 0 ;
            if (!empty($popover) && count($popover) > 1) {
                $wo['slide_num'] = count($popover) - 1;
            }
            

            if (!empty($popover_after)) {
                foreach ($popover_after as $key => $value) {
                    if (!empty($value['user_data'])) {
                        $popover[] = $value['user_data'];
                    }
                }
            }

            $wo['popover_array'] = $popover;


            $html = Wo_LoadPage('lightbox/common_user');

        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
    }

    if ($s == 'pre') {
        $html = '';
        if (!empty($_GET['user_id'])) {
            $popover_after = Wo_GetCommonUsers(array('limit' => 2,'after' => $_GET['user_id']));
            $popover_before = Wo_GetCommonUsers(array('limit' => 6,'before' => $_GET['user_id'],'order_by' => false));
            $popover = array();

            if (!empty($popover_before)) {
                for ($i = count($popover_before) - 1; $i >= 0 ; $i--) { 
                    $popover[] = $popover_before[$i]['user_data'];
                }
            }


            $popover[] = Wo_UserData($_GET['user_id']);

            
            $wo['slide_num'] = 0 ;
            if (!empty($popover_before) && count($popover_before) > 1) {
                $wo['slide_num'] = count($popover_before) - 1;
            }
            if (!empty($popover_after)) {
                foreach ($popover_after as $key => $value) {
                    if (!empty($value['user_data'])) {
                        $popover[] = $value['user_data'];
                    }
                }
            }
            $wo['popover_array'] = $popover;

            $html = Wo_LoadPage('lightbox/common_user');


        }
        if (!empty($popover_before)) {
            $data = array(
                'status' => 200,
                'html' => $html
            );
        }
        else{
            $data = array(
                'status' => 200,
                'html' => ''
            );
        }
            
    }

    if ($s == 'next') {
        $html = '';
        if (!empty($_GET['user_id'])) {
            $popover_before = Wo_GetCommonUsers(array('limit' => 2,'before' => $_GET['user_id'],'order_by' => false));
            $popover_after = Wo_GetCommonUsers(array('limit' => 6,'after' => $_GET['user_id']));
            $popover = array();


            if (!empty($popover_before)) {
                for ($i = count($popover_before) - 1; $i >= 0 ; $i--) { 
                    $popover[] = $popover_before[$i]['user_data'];
                }
            }


            $popover[] = Wo_UserData($_GET['user_id']);

            $wo['slide_num'] = 0 ;
            if (!empty($popover) && count($popover) > 1) {
                $wo['slide_num'] = count($popover) + 1;
            }

            if (!empty($popover_after)) {
                foreach ($popover_after as $key => $value) {
                    if (!empty($value['user_data'])) {
                        $popover[] = $value['user_data'];
                    }
                }
                $wo['popover_array'] = $popover;
                $html = Wo_LoadPage('lightbox/common_user');
            }

        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
    }

    if ($s == 'load') {
        $html = '';
        $nearby_users = Wo_GetCommonUsers(array('limit' => 20,'after' => $_GET['offset']));
        if (count($nearby_users) > 0) {
            foreach ($nearby_users as $wo['UsersList']) {
                $html .= Wo_LoadPage('common_things/user-list');
            }
            $data = array(
                'status' => 200,
                'html' => $html
            );
        }
        else{
            $data = array(
                'status' => 400,
                'html' => $html
            );
        }
        
    }



    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
