<?php
if ($wo['config']['website_mode'] != 'linkedin') {
	exit();
}
$data = array();
if ($f == 'experience') {
    if ($s == 'add') {
        $experience_end = '';
        $image = '';
        $link = '';
        $headline = '';
    	if (empty($_POST['title'])) {
    		$data['message'] = $error_icon . $wo['lang']['title_empty'];
    	}
    	if (empty($_POST['company_name'])) {
    		$data['message'] = $error_icon . $wo['lang']['company_name_empty'];
    	}
    	if (empty($_POST['employment_type']) || !in_array($_POST['employment_type'], array_keys($wo['employment_type']))) {
    		$data['message'] = $error_icon . $wo['lang']['employment_type_empty'];
    	}
    	if (empty($_POST['location'])) {
    		$data['message'] = $error_icon . $wo['lang']['location_empty'];
    	}
    	if (empty($_POST['experience_start'])) {
    		$data['message'] = $error_icon . $wo['lang']['start_date_empty'];
    	}
    	if (empty($_POST['industry'])) {
    		$data['message'] = $error_icon . $wo['lang']['industry_empty'];
    	}
    	if (empty($_POST['description'])) {
    		$data['message'] = $error_icon . $wo['lang']['description_empty'];
    	}
        if (!empty($_POST['link']) && !preg_match('/^(http|https):\\/\\/[a-z0-9_]+([\\-\\.]{1}[a-z_0-9]+)*\\.[_a-z]{1,100}' . '((:[0-9]{1,5})?\\/.*)?$/i', $_POST['link'])) {
            $data['message'] = $error_icon . $wo['lang']['valid_link'];
        }
        if (!empty($_POST['experience_start']) && !empty($_POST['experience_end'])) {
            $date_start = explode('-', $_POST['experience_start']);
            $date_end = explode('-', $_POST['experience_end']);
            if ($date_start[0] < $date_end[0]) {
            }
            else{
                if ($date_start[0] > $date_end[0]) {
                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                }
                else{
                    if ($date_start[1] < $date_end[1]) {
                    }
                    else{
                        if ($date_start[1] > $date_end[1]) {
                            $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                        }
                        else{
                            if ($date_start[2] < $date_end[2]) {

                            }
                            else{
                                if ($date_start[2] > $date_end[2]) {
                                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                                }
                            }
                        }
                    }
                } 
            }
        }
    	if (empty($data['message'])) {
            if (!empty($_POST['experience_end'])) {
                $experience_end = Wo_Secure($_POST['experience_end']);
            }
            if (!empty($_POST['headline'])) {
                $headline = Wo_Secure($_POST['headline']);
            }
            if (!empty($_POST['link'])) {
                $link = Wo_Secure($_POST['link']);
            }
            if (!empty($_FILES["image"])) {
                $fileInfo = array(
                    'file' => $_FILES["image"]["tmp_name"],
                    'name' => $_FILES['image']['name'],
                    'size' => $_FILES["image"]["size"],
                    'type' => $_FILES["image"]["type"],
                    'types' => 'jpg,png,jpeg,gif'
                );
                $file     = Wo_ShareFile($fileInfo, 1);
                if (!empty($file) && !empty($file['filename'])) {
                    $image = $file['filename'];
                }
            }
    		$insert_data = array('title' => Wo_Secure($_POST['title']),
                                 'company_name' => Wo_Secure($_POST['company_name']),
                                 'location' => Wo_Secure($_POST['location']),
                                 'experience_start' => Wo_Secure($_POST['experience_start']),
                                 'experience_end' => $experience_end,
                                 'industry' => Wo_Secure($_POST['industry']),
                                 'description' => Wo_Secure($_POST['description'],0,true,1),
                                 'image' => $image,
                                 'link' => $link,
                                 'headline' => $headline,
                                 'time' => time(),
                                 'user_id' => $wo['user']['id'],
                                 'employment_type' => Wo_Secure($_POST['employment_type']));
            $id = $db->insert(T_USER_EXPERIENCE,$insert_data);
            if (!empty($id)) {
                $data = array('status' => 200,
                              'message' => $wo['lang']['experience_successfully_created']);
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
            } 
    	}
    }
    if ($s == 'delete') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $experience = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_EXPERIENCE);
            if (!empty($experience) && ($experience->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                if (!empty($experience->image)) {
                    @unlink($experience->image);
                    Wo_DeleteFromToS3($experience->image);
                }
                $db->where('id',$experience->id)->delete(T_USER_EXPERIENCE);
                $data['status'] = 200;
            }
            else{
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        }
        else{
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'edit') {
        $experience_end = '';
        $image = '';
        $link = '';
        $headline = '';
        if (empty($_POST['title'])) {
            $data['message'] = $error_icon . $wo['lang']['title_empty'];
        }
        if (empty($_POST['company_name'])) {
            $data['message'] = $error_icon . $wo['lang']['company_name_empty'];
        }
        if (empty($_POST['employment_type']) || !in_array($_POST['employment_type'], array_keys($wo['employment_type']))) {
            $data['message'] = $error_icon . $wo['lang']['employment_type_empty'];
        }
        if (empty($_POST['location'])) {
            $data['message'] = $error_icon . $wo['lang']['location_empty'];
        }
        if (empty($_POST['experience_start'])) {
            $data['message'] = $error_icon . $wo['lang']['start_date_empty'];
        }
        if (empty($_POST['industry'])) {
            $data['message'] = $error_icon . $wo['lang']['industry_empty'];
        }
        if (empty($_POST['description'])) {
            $data['message'] = $error_icon . $wo['lang']['description_empty'];
        }
        if (!empty($_POST['link']) && !preg_match('/^(http|https):\\/\\/[a-z0-9_]+([\\-\\.]{1}[a-z_0-9]+)*\\.[_a-z]{1,100}' . '((:[0-9]{1,5})?\\/.*)?$/i', $_POST['link'])) {
            $data['message'] = $error_icon . $wo['lang']['valid_link'];
        }
        if (!empty($_POST['experience_start']) && !empty($_POST['experience_end'])) {
            $date_start = explode('-', $_POST['experience_start']);
            $date_end = explode('-', $_POST['experience_end']);
            if ($date_start[0] < $date_end[0]) {
            }
            else{
                if ($date_start[0] > $date_end[0]) {
                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                }
                else{
                    if ($date_start[1] < $date_end[1]) {
                    }
                    else{
                        if ($date_start[1] > $date_end[1]) {
                            $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                        }
                        else{
                            if ($date_start[2] < $date_end[2]) {

                            }
                            else{
                                if ($date_start[2] > $date_end[2]) {
                                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                                }
                            }
                        }
                    }
                } 
            }
        }
        if (empty($_POST['id']) || !is_numeric($_POST['id'])) {
            $data['message'] = $error_icon . $wo["lang"]["id_can_not_empty"];
        }
        if (empty($data['message'])) {
            $experience = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_EXPERIENCE);
            if (!empty($experience) && ($experience->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                if (!empty($_POST['experience_end'])) {
                    $experience_end = Wo_Secure($_POST['experience_end']);
                }
                if (!empty($_POST['headline'])) {
                    $headline = Wo_Secure($_POST['headline']);
                }
                if (!empty($_POST['link'])) {
                    $link = Wo_Secure($_POST['link']);
                }
                if (!empty($_FILES["image"])) {
                    $fileInfo = array(
                        'file' => $_FILES["image"]["tmp_name"],
                        'name' => $_FILES['image']['name'],
                        'size' => $_FILES["image"]["size"],
                        'type' => $_FILES["image"]["type"],
                        'types' => 'jpg,png,jpeg,gif'
                    );
                    $file     = Wo_ShareFile($fileInfo, 1);
                    if (!empty($file) && !empty($file['filename'])) {
                        $image = $file['filename'];
                        if (!empty($experience->image)) {
                            @unlink($experience->image);
                            Wo_DeleteFromToS3($experience->image);
                        }
                    }
                }
                $update_data = array('title' => Wo_Secure($_POST['title']),
                                     'company_name' => Wo_Secure($_POST['company_name']),
                                     'location' => Wo_Secure($_POST['location']),
                                     'experience_start' => Wo_Secure($_POST['experience_start']),
                                     'experience_end' => $experience_end,
                                     'industry' => Wo_Secure($_POST['industry']),
                                     'description' => Wo_Secure($_POST['description'],0,true,1),
                                     'link' => $link,
                                     'headline' => $headline,
                                     'employment_type' => Wo_Secure($_POST['employment_type']));
                if (!empty($image)) {
                    $update_data['image'] = $image;
                }
                $id = $db->where('id',$experience->id)->update(T_USER_EXPERIENCE,$update_data);
                if (!empty($id)) {
                    $data = array('status' => 200,
                                  'message' => $wo['lang']['experience_successfully_updated']);
                }
                else{
                    $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
                } 
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["you_not_owner"];
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
if ($f == 'certification') {
    if ($s == 'add') {
        $certification_end = '';
        $credential_id = '';
        $credential_url = '';
        if (empty($_POST['name'])) {
            $data['message'] = $error_icon . $wo['lang']['name_empty'];
        }
        if (empty($_POST['issuing_organization'])) {
            $data['message'] = $error_icon . $wo['lang']['issuing_organization_empty'];
        }
        if (empty($_POST['certification_start'])) {
            $data['message'] = $error_icon . $wo['lang']['issue_date_empty'];
        }
        if (!empty($_POST['credential_url']) && !preg_match('/^(http|https):\\/\\/[a-z0-9_]+([\\-\\.]{1}[a-z_0-9]+)*\\.[_a-z]{1,100}' . '((:[0-9]{1,5})?\\/.*)?$/i', $_POST['credential_url'])) {
            $data['message'] = $error_icon . $wo['lang']['valid_link'];
        }
        if (!empty($_POST['certification_start']) && !empty($_POST['certification_end'])) {
            $date_start = explode('-', $_POST['certification_start']);
            $date_end = explode('-', $_POST['certification_end']);
            if ($date_start[0] < $date_end[0]) {
            }
            else{
                if ($date_start[0] > $date_end[0]) {
                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                }
                else{
                    if ($date_start[1] < $date_end[1]) {
                    }
                    else{
                        if ($date_start[1] > $date_end[1]) {
                            $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                        }
                        else{
                            if ($date_start[2] < $date_end[2]) {

                            }
                            else{
                                if ($date_start[2] > $date_end[2]) {
                                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                                }
                            }
                        }
                    }
                } 
            }
        }
        if (empty($data['message'])) {
            $pdf = '';
            $filename = '';
            if (!empty($_POST['certification_end'])) {
                $certification_end = Wo_Secure($_POST['certification_end']);
            }
            if (!empty($_POST['credential_id'])) {
                $credential_id = Wo_Secure($_POST['credential_id']);
            }
            if (!empty($_POST['credential_url'])) {
                $credential_url = Wo_Secure($_POST['credential_url']);
            }
            if (!empty($_FILES["pdf"])) {
                $fileInfo = array(
                    'file' => $_FILES["pdf"]["tmp_name"],
                    'name' => $_FILES['pdf']['name'],
                    'size' => $_FILES["pdf"]["size"],
                    'type' => $_FILES["pdf"]["type"],
                    'types' => 'pdf'
                );
                $amazone_s3 = $wo['config']['amazone_s3'];
                $wasabi_storage = $wo['config']['wasabi_storage'];
                $ftp_upload = $wo['config']['ftp_upload'];
                $spaces = $wo['config']['spaces'];
                $cloud_upload = $wo['config']['cloud_upload'];
                $wo['config']['amazone_s3'] = 0;
                $wo['config']['wasabi_storage'] = 0;
                $wo['config']['ftp_upload'] = 0;
                $wo['config']['spaces'] = 0;
                $wo['config']['cloud_upload'] = 0;

                $file     = Wo_ShareFile($fileInfo, 1);

                $wo['config']['amazone_s3'] = $amazone_s3;
                $wo['config']['wasabi_storage'] = $wasabi_storage;
                $wo['config']['ftp_upload'] = $ftp_upload;
                $wo['config']['spaces'] = $spaces;
                $wo['config']['cloud_upload'] = $cloud_upload;
                if (!empty($file) && !empty($file['filename'])) {
                    $pdf = $file['filename'];
                    $filename = $file['name'];
                }
            }
            $insert_data = array('name' => Wo_Secure($_POST['name']),
                                 'issuing_organization' => Wo_Secure($_POST['issuing_organization']),
                                 'credential_id' => $credential_id,
                                 'credential_url' => $credential_url,
                                 'certification_start' => Wo_Secure($_POST['certification_start']),
                                 'certification_end' => $certification_end,
                                 'pdf' => $pdf,
                                 'filename' => $filename,
                                 'time' => time(),
                                 'user_id' => $wo['user']['id']);
            $id = $db->insert(T_USER_CERTIFICATION,$insert_data);
            if (!empty($id)) {
                $data = array('status' => 200,
                              'message' => $wo['lang']['certification_successfully_created']);
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
            } 
        }
    }
    if ($s == 'delete') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $certification = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_CERTIFICATION);
            if (!empty($certification) && ($certification->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                if (!empty($certification->pdf)) {
                    @unlink($certification->pdf);
                }
                $db->where('id',$certification->id)->delete(T_USER_CERTIFICATION);
                $data['status'] = 200;
            }
            else{
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        }
        else{
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'edit') {
        $certification_end = '';
        $credential_id = '';
        $credential_url = '';
        if (empty($_POST['name'])) {
            $data['message'] = $error_icon . $wo['lang']['name_empty'];
        }
        if (empty($_POST['issuing_organization'])) {
            $data['message'] = $error_icon . $wo['lang']['issuing_organization_empty'];
        }
        if (empty($_POST['certification_start'])) {
            $data['message'] = $error_icon . $wo['lang']['issue_date_empty'];
        }
        if (!empty($_POST['credential_url']) && !preg_match('/^(http|https):\\/\\/[a-z0-9_]+([\\-\\.]{1}[a-z_0-9]+)*\\.[_a-z]{1,100}' . '((:[0-9]{1,5})?\\/.*)?$/i', $_POST['credential_url'])) {
            $data['message'] = $error_icon . $wo['lang']['valid_link'];
        }
        if (!empty($_POST['certification_start']) && !empty($_POST['certification_end'])) {
            $date_start = explode('-', $_POST['certification_start']);
            $date_end = explode('-', $_POST['certification_end']);
            if ($date_start[0] < $date_end[0]) {
            }
            else{
                if ($date_start[0] > $date_end[0]) {
                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                }
                else{
                    if ($date_start[1] < $date_end[1]) {
                    }
                    else{
                        if ($date_start[1] > $date_end[1]) {
                            $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                        }
                        else{
                            if ($date_start[2] < $date_end[2]) {

                            }
                            else{
                                if ($date_start[2] > $date_end[2]) {
                                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                                }
                            }
                        }
                    }
                } 
            }
        }
        if (empty($_POST['id']) || !is_numeric($_POST['id'])) {
            $data['message'] = $error_icon . $wo["lang"]["id_can_not_empty"];
        }
        if (empty($data['message'])) {
            $certification = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_CERTIFICATION);
            if (!empty($certification) && ($certification->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                if (!empty($_POST['certification_end'])) {
                    $certification_end = Wo_Secure($_POST['certification_end']);
                }
                if (!empty($_POST['credential_id'])) {
                    $credential_id = Wo_Secure($_POST['credential_id']);
                }
                if (!empty($_POST['credential_url'])) {
                    $credential_url = Wo_Secure($_POST['credential_url']);
                }
                $update_data = array('name' => Wo_Secure($_POST['name']),
                                     'issuing_organization' => Wo_Secure($_POST['issuing_organization']),
                                     'credential_id' => $credential_id,
                                     'credential_url' => $credential_url,
                                     'certification_start' => Wo_Secure($_POST['certification_start']),
                                     'certification_end' => $certification_end);
                if (!empty($_FILES["pdf"])) {
                    $fileInfo = array(
                        'file' => $_FILES["pdf"]["tmp_name"],
                        'name' => $_FILES['pdf']['name'],
                        'size' => $_FILES["pdf"]["size"],
                        'type' => $_FILES["pdf"]["type"],
                        'types' => 'pdf'
                    );
                    $amazone_s3 = $wo['config']['amazone_s3'];
                    $wasabi_storage = $wo['config']['wasabi_storage'];
                    $ftp_upload = $wo['config']['ftp_upload'];
                    $spaces = $wo['config']['spaces'];
                    $cloud_upload = $wo['config']['cloud_upload'];
                    $wo['config']['amazone_s3'] = 0;
                    $wo['config']['wasabi_storage'] = 0;
                    $wo['config']['ftp_upload'] = 0;
                    $wo['config']['spaces'] = 0;
                    $wo['config']['cloud_upload'] = 0;

                    $file     = Wo_ShareFile($fileInfo, 1);
                    
                    $wo['config']['amazone_s3'] = $amazone_s3;
                    $wo['config']['wasabi_storage'] = $wasabi_storage;
                    $wo['config']['ftp_upload'] = $ftp_upload;
                    $wo['config']['spaces'] = $spaces;
                    $wo['config']['cloud_upload'] = $cloud_upload;
                    if (!empty($file) && !empty($file['filename'])) {
                        $update_data['pdf'] = $file['filename'];
                        $update_data['filename'] = $file['name'];
                    }
                }
                $id = $db->where('id',$certification->id)->update(T_USER_CERTIFICATION,$update_data);
                if (!empty($id)) {
                    $data = array('status' => 200,
                                  'message' => $wo['lang']['certification_successfully_updated']);
                }
                else{
                    $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
                } 
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["you_not_owner"];
            }
        }
    }
    if ($s == 'download_user_certification') {
        $data['status'] = 200;
        if(!empty($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0){
            $id = Wo_Secure($_GET['id']);
            $certification = $db->where('id',$id)->getOne(T_USER_CERTIFICATION);
            if (!empty($certification) && !empty($certification->pdf)) {
                $filepath = $certification->pdf;
                if(file_exists($filepath)) {
                   header('Content-Description: File Transfer');
                   header('Content-Type: application/octet-stream');
                   // rename the file to username
                   header('Content-Disposition: attachment; filename="'.(!empty($certification->filename) ? $certification->filename : $certification->name).'.pdf"');
                   header('Expires: 0');
                   header('Cache-Control: must-revalidate');
                   header('Pragma: public');
                   header('Content-Length: ' . filesize($filepath));
                   flush(); // Flush system output buffer
                   readfile($filepath);
                   exit;
               }
            }
        }
    }

    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
if ($f == 'project') {
    if ($s == 'add') {
        $project_end = '';
        $credential_id = '';
        $project_url = '';
        $description = '';
        if (empty($_POST['name'])) {
            $data['message'] = $error_icon . $wo['lang']['name_empty'];
        }
        if (empty($_POST['project_start'])) {
            $data['message'] = $error_icon . $wo['lang']['start_date_empty'];
        }
        if (!empty($_POST['project_url']) && !preg_match('/^(http|https):\\/\\/[a-z0-9_]+([\\-\\.]{1}[a-z_0-9]+)*\\.[_a-z]{1,100}' . '((:[0-9]{1,5})?\\/.*)?$/i', $_POST['project_url'])) {
            $data['message'] = $error_icon . $wo['lang']['valid_link'];
        }
        if (!empty($_POST['project_start']) && !empty($_POST['project_end'])) {
            $date_start = explode('-', $_POST['project_start']);
            $date_end = explode('-', $_POST['project_end']);
            if ($date_start[0] < $date_end[0]) {
            }
            else{
                if ($date_start[0] > $date_end[0]) {
                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                }
                else{
                    if ($date_start[1] < $date_end[1]) {
                    }
                    else{
                        if ($date_start[1] > $date_end[1]) {
                            $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                        }
                        else{
                            if ($date_start[2] < $date_end[2]) {

                            }
                            else{
                                if ($date_start[2] > $date_end[2]) {
                                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                                }
                            }
                        }
                    }
                } 
            }
        }
        if (empty($data['message'])) {
            if (!empty($_POST['project_end'])) {
                $project_end = Wo_Secure($_POST['project_end']);
            }
            if (!empty($_POST['associated_with'])) {
                $associated_with = Wo_Secure($_POST['associated_with']);
            }
            if (!empty($_POST['description'])) {
                $description = Wo_Secure($_POST['description'],0,true,1);
            }
            if (!empty($_POST['project_url'])) {
                $project_url = Wo_Secure($_POST['project_url']);
            }
            $insert_data = array('name' => Wo_Secure($_POST['name']),
                                 'description' => $description,
                                 'associated_with' => $associated_with,
                                 'project_url' => $project_url,
                                 'project_start' => Wo_Secure($_POST['project_start']),
                                 'project_end' => $project_end,
                                 'time' => time(),
                                 'user_id' => $wo['user']['id']);
            $id = $db->insert(T_USER_PROJECTS,$insert_data);
            if (!empty($id)) {
                $data = array('status' => 200,
                              'message' => $wo['lang']['project_successfully_added']);
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
            } 
        }
    }
    if ($s == 'delete') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $project = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_PROJECTS);
            if (!empty($project) && ($project->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                $db->where('id',$project->id)->delete(T_USER_PROJECTS);
                $data['status'] = 200;
            }
            else{
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        }
        else{
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'edit') {
        $project_end = '';
        $credential_id = '';
        $project_url = '';
        $description = '';
        if (empty($_POST['name'])) {
            $data['message'] = $error_icon . $wo['lang']['name_empty'];
        }
        if (empty($_POST['project_start'])) {
            $data['message'] = $error_icon . $wo['lang']['start_date_empty'];
        }
        if (!empty($_POST['project_url']) && !preg_match('/^(http|https):\\/\\/[a-z0-9_]+([\\-\\.]{1}[a-z_0-9]+)*\\.[_a-z]{1,100}' . '((:[0-9]{1,5})?\\/.*)?$/i', $_POST['project_url'])) {
            $data['message'] = $error_icon . $wo['lang']['valid_link'];
        }
        if (!empty($_POST['project_start']) && !empty($_POST['project_end'])) {
            $date_start = explode('-', $_POST['project_start']);
            $date_end = explode('-', $_POST['project_end']);
            if ($date_start[0] < $date_end[0]) {
            }
            else{
                if ($date_start[0] > $date_end[0]) {
                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                }
                else{
                    if ($date_start[1] < $date_end[1]) {
                    }
                    else{
                        if ($date_start[1] > $date_end[1]) {
                            $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                        }
                        else{
                            if ($date_start[2] < $date_end[2]) {

                            }
                            else{
                                if ($date_start[2] > $date_end[2]) {
                                    $error = $error_icon . $wo['lang']['please_choose_correct_experience_date'];
                                }
                            }
                        }
                    }
                } 
            }
        }
        if (empty($_POST['id']) || !is_numeric($_POST['id'])) {
            $data['message'] = $error_icon . $wo["lang"]["id_can_not_empty"];
        }
        if (empty($data['message'])) {
            $project = $db->where('id',Wo_Secure($_POST['id']))->getOne(T_USER_PROJECTS);
            if (!empty($project) && ($project->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                if (!empty($_POST['project_end'])) {
                    $project_end = Wo_Secure($_POST['project_end']);
                }
                if (!empty($_POST['associated_with'])) {
                    $associated_with = Wo_Secure($_POST['associated_with']);
                }
                if (!empty($_POST['description'])) {
                    $description = Wo_Secure($_POST['description'],0,true,1);
                }
                if (!empty($_POST['project_url'])) {
                    $project_url = Wo_Secure($_POST['project_url']);
                }
                $update_data = array('name' => Wo_Secure($_POST['name']),
                                     'description' => $description,
                                     'associated_with' => $associated_with,
                                     'project_url' => $project_url,
                                     'project_start' => Wo_Secure($_POST['project_start']),
                                     'project_end' => $project_end);
                $id = $db->where('id',$project->id)->update(T_USER_PROJECTS,$update_data);
                if (!empty($id)) {
                    $data = array('status' => 200,
                                  'message' => $wo['lang']['project_successfully_updated']);
                }
                else{
                    $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
                } 
            }
            else{
                $data['message'] = $error_icon . $wo["lang"]["you_not_owner"];
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
if ($f == 'open_to') {
    if ($s == 'find_job') {
        if (empty($_POST['job_title'])) {
            $data['message'] = $error_icon . $wo['lang']['Job_title_empty'];
        }
        else if (empty($_POST['job_location'])) {
            $data['message'] = $error_icon . $wo['lang']['job_location_empty'];
        }
        else if (empty($_POST['workplaces'])) {
            $data['message'] = $error_icon . $wo['lang']['workplaces_empty'];
        }
        else if (empty($_POST['job_type'])) {
            $data['message'] = $error_icon . $wo['lang']['job_type_empty'];
        }
        if (empty($data['message'])) {
            foreach ($_POST['job_type'] as $key => $value) {
                if (!in_array($value, array('full_time','contract','part_time','internship','temporary'))) {
                    $data['message'] = $error_icon . $wo['lang']['job_type_empty'];
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
            }
            foreach ($_POST['workplaces'] as $key => $value) {
                if (!in_array($value, array('on_site','hybrid','remote'))) {
                    $data['message'] = $error_icon . $wo['lang']['workplaces_empty'];
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
            }
            $insert_data = array('user_id' => $wo['user']['id'],
                                 'job_title' => Wo_Secure($_POST['job_title']),
                                 'job_location' => Wo_Secure($_POST['job_location']),
                                 'workplaces' => Wo_Secure(implode(",",$_POST['workplaces'])),
                                 'job_type' => Wo_Secure(implode(",",$_POST['job_type'])),
                                 'type' => 'find_job',
                                 'time' => time());
            $id = $db->insert(T_USER_OPEN_TO,$insert_data);
            if (!empty($id)) {
          $data = array('status' => 200,
                        'message' => $wo['lang']['job_preferences_saved_successfully']);
      }
      else{
          $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
      }
        }
    }
    if ($s == 'delete_job') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $db->where('user_id',Wo_Secure($_POST['id']))->where('type','find_job')->delete(T_USER_OPEN_TO);
            $data = array('status' => 200);
        }
        else{
            $data['message'] = $wo["lang"]['you_not_owner'];
        }
    }

    if ($s == 'edit_job') {
        if (empty($_POST['job_title'])) {
            $data['message'] = $error_icon . $wo['lang']['Job_title_empty'];
        }
        else if (empty($_POST['job_location'])) {
            $data['message'] = $error_icon . $wo['lang']['job_location_empty'];
        }
        else if (empty($_POST['workplaces'])) {
            $data['message'] = $error_icon . $wo['lang']['workplaces_empty'];
        }
        else if (empty($_POST['job_type'])) {
            $data['message'] = $error_icon . $wo['lang']['job_type_empty'];
        }
        if (empty($data['message'])) {
            foreach ($_POST['job_type'] as $key => $value) {
                if (!in_array($value, array('full_time','contract','part_time','internship','temporary'))) {
                    $data['message'] = $error_icon . $wo['lang']['job_type_empty'];
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
            }
            foreach ($_POST['workplaces'] as $key => $value) {
                if (!in_array($value, array('on_site','hybrid','remote'))) {
                    $data['message'] = $error_icon . $wo['lang']['workplaces_empty'];
                    header("Content-type: application/json");
                    echo json_encode($data);
                    exit();
                }
            }
            $job = $db->where('id',Wo_Secure($_POST['id']))->where('type','find_job')->getOne(T_USER_OPEN_TO);
      if (!empty($job) && ($job->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
                $insert_data = array('job_title' => Wo_Secure($_POST['job_title']),
                                   'job_location' => Wo_Secure($_POST['job_location']),
                                   'workplaces' => Wo_Secure(implode(",",$_POST['workplaces'])),
                                   'job_type' => Wo_Secure(implode(",",$_POST['job_type'])));
                $id = $db->where('id',$job->id)->update(T_USER_OPEN_TO,$insert_data);
                if (!empty($id)) {
              $data = array('status' => 200,
                            'message' => $wo['lang']['job_preferences_edited_successfully']);
          }
          else{
              $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
          }
        }
        else{
            $data['message'] = $error_icon . $wo["lang"]["you_not_owner"];
        }
        }





    }
    if ($s == 'providing_services') {
        if (empty($_POST['services'])) {
            $data['message'] = $error_icon . $wo['lang']['services_empty'];
        }
        if (empty($_POST['job_location'])) {
            $data['message'] = $error_icon . $wo['lang']['location_empty'];
        }
        if (empty($_POST['description'])) {
            $data['message'] = $error_icon . $wo['lang']['description_empty'];
        }
        if (empty($data['message'])) {
            $_POST['services'] = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_POST['services']);
      $_POST['services'] = strip_tags($_POST['services']);
            $insert_data = array('user_id' => $wo['user']['id'],
                               'services' => Wo_Secure($_POST['services']),
                               'job_location' => Wo_Secure($_POST['job_location']),
                               'description' => Wo_Secure($_POST['description'],0,true,1),
                               'time' => time(),
                               'type' => 'service');
            $id = $db->insert(T_USER_OPEN_TO,$insert_data);
            if (!empty($id)) {
          $data = array('status' => 200,
                        'message' => $wo['lang']['services_saved_successfully']);
      }
      else{
          $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
      }
        }
    }
    if ($s == 'delete_service') {
        if (!empty($_POST['id']) && is_numeric($_POST['id']) && $_POST['id'] > 0) {
            $db->where('user_id',Wo_Secure($_POST['id']))->where('type','service')->delete(T_USER_OPEN_TO);
            $data = array('status' => 200);
        }
        else{
            $data['message'] = $wo["lang"]['you_not_owner'];
        }
    }
    if ($s == 'edit_providing_services') {
        if (empty($_POST['services'])) {
            $data['message'] = $error_icon . $wo['lang']['services_empty'];
        }
        if (empty($_POST['job_location'])) {
            $data['message'] = $error_icon . $wo['lang']['location_empty'];
        }
        if (empty($_POST['description'])) {
            $data['message'] = $error_icon . $wo['lang']['description_empty'];
        }
        if (empty($_POST['id']) || !is_numeric($_POST['id'])) {
            $data['message'] = $error_icon . $wo['lang']['invalid_id'];
        }
        if (empty($data['message'])) {
            $service = $db->where('id',Wo_Secure($_POST['id']))->where('type','service')->getOne(T_USER_OPEN_TO);
      if (!empty($service) && ($service->user_id == $wo['user']['user_id'] || Wo_IsAdmin())) {
        $_POST['services'] = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_POST['services']);
          $_POST['services'] = strip_tags($_POST['services']);
                $insert_data = array('services' => Wo_Secure($_POST['services']),
                                   'job_location' => Wo_Secure($_POST['job_location']),
                                   'description' => Wo_Secure($_POST['description'],0,true,1));
                $id = $db->where('id',$service->id)->update(T_USER_OPEN_TO,$insert_data);
                if (!empty($id)) {
              $data = array('status' => 200,
                            'message' => $wo['lang']['services_edited_successfully']);
          }
          else{
              $data['message'] = $error_icon . $wo["lang"]["something_wrong"];
          }
      }
      else{
        $data['message'] = $error_icon . $wo["lang"]["you_not_owner"];
      }
        }
    }
    header("Content-type: application/json");
  echo json_encode($data);
  exit();
}
if ($f == 'search_linkedin') {
    $html  = '';
    $array = array(
        'limit' => 10,
        'type' => 'all'
    );
    if (!empty($_POST['keyword'])) {
        $array['keyword'] = $_POST['keyword'];
    }
    if (!empty($_POST['certifications'])) {
        $array['certifications'] = $_POST['certifications'];
    }
    if (!empty($_POST['search_type']) && in_array($_POST['search_type'], array('all','users','pages','groups','service'))) {
        $array['search_type'] = $_POST['search_type'];
    }
    if (!empty($_POST['offset']) && is_numeric($_POST['offset'])) {
        $array['offset'] = $_POST['offset'];
    }
    if (!empty($_POST['experience']) && is_numeric($_POST['experience'])) {
        $array['experience'] = $_POST['experience'];
    }
    if (!empty($_POST['job_type'])) {
        $array['job_type'] = $_POST['job_type'];
    }
    if (!empty($_POST['workplaces'])) {
        $array['workplaces'] = $_POST['workplaces'];
    }
    $info = LinkedinSearch($array);
    array_multisort( array_column($info, "sort_time"), SORT_DESC, $info );
    if (count($info) > 20) {
        $info = array_slice($info, 0, 20, true);
    }
    foreach ($info as $key => $wo['result']) {
        if ($wo['result']['sort_type'] == 'user') {
            $html .= Wo_LoadPage('search/linkedin_user_list');
        }
        if ($wo['result']['sort_type'] == 'page') {
            $html .= Wo_LoadPage('search/linkedin_page_list');
        }
        if ($wo['result']['sort_type'] == 'group') {
            $html .= Wo_LoadPage('search/linkedin_group_list');
        }
        if ($wo['result']['sort_type'] == 'service') {
            $html .= Wo_LoadPage('search/linkedin_service_list');
        }
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
if ($f == "get_more_open_posts") {
    $html = '';
    if (isset($_GET['after_last_id']) && is_numeric($_GET['after_last_id'])) {
        $posts = Wo_GetOpenToWorkPosts(10,$_GET['after_last_id']);
        if (!empty($posts)) {
            foreach ($posts as $wo['story']) {
                if( is_array($wo['story']) && isset( $wo['story']['id']) ){
                    $html .= Wo_LoadPage('story/content');
                }
            }
        }
    }
    $data = array(
        'status' => 200,
        'html' => $html
    );
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}