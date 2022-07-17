<?php 
if ($f == "new-film") {
    if (Wo_IsAdmin() == true) {
        if (empty($_POST['name']) || empty($_POST['description']) || !isset($_FILES["cover"]["tmp_name"])) {
            $error = $error_icon . $wo['lang']['please_check_details'];
            if (empty($_FILES["cover"]["tmp_name"]) || (!isset($_FILES["source"]["tmp_name"]) && empty($_POST['iframe']) && empty($_POST['other']))) {
                if (!empty($_FILES["cover"]["error"]) || !empty($_FILES["source"]["error"])) {
                    $error = $error_icon . 'The file is too big, please increase your server upload limit in php.ini';
                } else {
                    $error = $error_icon . $wo['lang']['please_check_details'];
                }
            }
        } else {
            if (strlen($_POST['name']) < 3) {
                $error = $error_icon . " Please enter a valid name";
            }
            if (empty($_POST['genre'])) {
                $error = $error_icon . " Please choose a genre";
            }
            if (empty($_POST['stars'])) {
                $error = $error_icon . "Please enter the names of the stars";
            }
            if (empty($_POST['producer'])) {
                $error = $error_icon . "Please enter the producer's name";
            }
            if (empty($_POST['country'])) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            if (empty($_POST['quanlity'])) {
                $error = $error_icon . $wo['lang']['please_check_details'];
            }
            if (empty($_POST['release']) || !is_numeric($_POST['release'])) {
                $error = $error_icon . "Please select movie release";
            }
            if (empty($_POST['duration']) || !is_numeric($_POST['duration'])) {
                $error = $error_icon . "Please select the duration of the movie";
            }
            if (strlen($_POST['description']) < 32) {
                $error = $error_icon . $wo['lang']['desc_more_than32'];
            }
            if (!isset($_FILES["source"]) && empty($_POST['iframe']) && empty($_POST['other'])) {
                $error = $error_icon . " Please select movie";
            }
            if (!file_exists($_FILES["cover"]["tmp_name"])) {
                $error = $error_icon . " Select the cover to the movie";
            }
            if (empty($_POST['rating']) || !is_numeric($_POST['rating']) || $_POST['rating'] < 1 || $_POST['rating'] > 10) {
                $error = $error_icon . "Rating must be between 1 -> 10";
            }
        }
        if (!empty($_FILES["cover"]["tmp_name"])) {
            if (file_exists($_FILES["cover"]["tmp_name"])) {
                $cover = getimagesize($_FILES["cover"]["tmp_name"]);
                if ($cover[0] > 400 || $cover[1] > 570) {
                    $error = $error_icon . " Cover size should not be more than 400x570 ";
                }
            }
        }
        if (empty($error)) {
            $registration_data = array(
                'name' => Wo_Secure($_POST['name']),
                'genre' => Wo_Secure($_POST['genre']),
                'stars' => Wo_Secure($_POST['stars']),
                'producer' => Wo_Secure($_POST['producer']),
                'country' => Wo_Secure($_POST['country']),
                'release' => Wo_Secure($_POST['release']),
                'quality' => Wo_Secure($_POST['quanlity']),
                'duration' => Wo_Secure($_POST['duration']),
                'description' => Wo_Secure($_POST['description']),
                'iframe' => (!empty($_POST['iframe']) && Wo_IsUrl($_POST['iframe'])) ? $_POST['iframe'] : '',
                'video' => (!empty($_POST['other']) && Wo_IsUrl($_POST['other'])) ? $_POST['other'] : '',
                'rating' => Wo_Secure($_POST['rating'])
            );
            $film_id           = Wo_InsertFilm($registration_data);
            if ($film_id && is_numeric($film_id)) {
                $update_film = array();
                if (!empty($_FILES["source"]["tmp_name"]) && empty($_POST['youtube']) && empty($_POST['other'])) {
                    $fileInfo              = array(
                        'file' => $_FILES["source"]["tmp_name"],
                        'name' => $_FILES['source']['name'],
                        'size' => $_FILES["source"]["size"],
                        'type' => $_FILES["source"]["type"],
                        'types' => 'mp4,mov,webm,flv'
                    );
                    $media                 = Wo_ShareFile($fileInfo);
                    $update_film['source'] = $media['filename'];
                }
                if (!empty($_FILES["cover"]["tmp_name"])) {
                    $fileInfo             = array(
                        'file' => $_FILES["cover"]["tmp_name"],
                        'name' => $_FILES['cover']['name'],
                        'size' => $_FILES["cover"]["size"],
                        'type' => $_FILES["cover"]["type"],
                        'types' => 'jpeg,jpg,png,bmp,gif',
                        'compress' => false
                    );
                    $media                = Wo_ShareFile($fileInfo);
                    $update_film['cover'] = $media['filename'];
                }
                if (count($update_film) > 0) {
                    Wo_UpdateFilm($film_id, $update_film);
                    $data = array(
                        'status' => 200,
                        'message' => $success_icon . ' New movie was successfully added'
                    );
                }
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
