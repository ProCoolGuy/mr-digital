<?php 
if ($f == "update-event") {
    if (true) {
        if (empty($_POST['event-name']) || empty($_POST['event-locat']) || empty($_POST['event-description'])) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        } else {
            if (strlen($_POST['event-name']) < 10) {
                $error = $error_icon . $wo['lang']['title_more_than10'];
            }
            if (strlen($_POST['event-description']) < 10) {
                $error = $error_icon . $wo['lang']['desc_more_than32'];
            }
            if (empty($_POST['event-start-date'])) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            if (empty($_POST['event-end-date'])) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            if (empty($_POST['event-start-time'])) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            if (empty($_POST['event-end-time'])) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            if (empty($error)) {
                $date_start = explode('-', $_POST['event-start-date']);
                $date_end = explode('-', $_POST['event-end-date']);
                if ($date_start[0] < $date_end[0]) {
                }
                else{
                    if ($date_start[0] > $date_end[0]) {
                        $error = $error_icon . $wo['lang']['please_check_details'];
                    }
                    else{
                        if ($date_start[1] < $date_end[1]) {
                        }
                        else{
                            if ($date_start[1] > $date_end[1]) {
                                $error = $error_icon . $wo['lang']['please_check_details'];
                            }
                            else{
                                if ($date_start[2] < $date_end[2]) {

                                }
                                else{
                                    if ($date_start[2] > $date_end[2]) {
                                        $error = $error_icon . $wo['lang']['please_check_details'];
                                    }
                                }
                            }
                        }
                    } 
                }
            }
        }
        if (empty($error) && isset($_GET['eid']) && is_numeric($_GET['eid'])) {
            $registration_data = array(
                'name' => $_POST['event-name'],
                'location' => $_POST['event-locat'],
                'description' => $_POST['event-description'],
                'start_date' => $_POST['event-start-date'],
                'start_time' => $_POST['event-start-time'],
                'end_date' => $_POST['event-end-date'],
                'end_time' => $_POST['event-end-time']
            );
            $result            = Wo_UpdateEvent($_GET['eid'], $registration_data);
            if ($result) {
                if (!empty($_FILES["event-cover"]["tmp_name"])) {
                    $temp_name = $_FILES["event-cover"]["tmp_name"];
                    $file_name = $_FILES["event-cover"]["name"];
                    $file_type = $_FILES['event-cover']['type'];
                    $file_size = $_FILES["event-cover"]["size"];
                    Wo_UploadImage($temp_name, $file_name, 'cover', $file_type, $_GET['eid'], 'event');
                }
                $data = array(
                    'message' => $success_icon . $wo['lang']['event_saved'],
                    'status' => 200,
                    'url' => Wo_SeoLink("index.php?link1=show-event&eid=" . $_GET['eid'])
                );
            }
        } else {
            $data = array(
                'status' => 500,
                'message' => $error
            );
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
