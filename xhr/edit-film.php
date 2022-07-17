<?php 
if ($f == "edit-film") {
    if (Wo_IsAdmin() || Wo_IsModerator()) {
        if (empty($_POST['name']) || empty($_POST['description']) || empty($_POST['id']) || !is_numeric($_POST['id'])) {
            $error = $error_icon . $wo['lang']['please_check_details'];
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
                'name' => $_POST['name'],
                'genre' => $_POST['genre'],
                'stars' => $_POST['stars'],
                'producer' => $_POST['producer'],
                'country' => $_POST['country'],
                'release' => $_POST['release'],
                'quality' => $_POST['quanlity'],
                'duration' => $_POST['duration'],
                'description' => $_POST['description'],
                'rating' => Wo_Secure($_POST['rating'])
            );
            $film_id           = Wo_Secure($_POST['id']);
            $film              = Wo_UpdateFilm($film_id, $registration_data);
            if ($film) {
                $update_film = array();
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
                }
                $data = array(
                    'status' => 200,
                    'message' => $success_icon . ' The movie was successfully updated'
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
