<?php
$job_type      = array(
    'full_time',
    'part_time',
    'internship',
    'volunteer',
    'contract'
);
$salary_date   = array(
    'per_hour',
    'per_day',
    'per_week',
    'per_month',
    'per_year'
);
$question_type = array(
    'free_text_question',
    'yes_no_question',
    'multiple_choice_question'
);
if ($f == 'job' && $wo['config']['job_system'] == 1) {
    $data['status'] = 400;
    if ($s == 'create_job') {
        if (!empty($_POST['job_title']) && !empty($_POST['description']) && !empty($_POST['location']) && !empty($_POST['job_type']) && in_array($_POST['job_type'], $job_type) && !empty($_POST['category']) && in_array($_POST['category'], array_keys($wo['job_categories']))) {
            if (!empty($_POST['page_id'])) {
                $page_data = $db->where('page_id', Wo_Secure($_POST['page_id']))->getOne(T_PAGES);
                if (empty($page_data) || !Wo_IsPageOnwer($page_data->page_id)) {
                    $data['error'] = $error_icon . $wo['lang']['please_check_details'];
                }
            }
            if (empty($data['error'])) {
                $insert_array = array();
                if (!empty($_POST['job_title'])) {
                    $insert_array['title'] = Wo_Secure($_POST['job_title']);
                }
                if (!empty($_POST['location'])) {
                    $insert_array['location'] = Wo_Secure($_POST['location']);
                }
                if (!empty($_POST['lat'])) {
                    $insert_array['lat'] = Wo_Secure($_POST['lat']);
                }
                if (!empty($_POST['lng'])) {
                    $insert_array['lng'] = Wo_Secure($_POST['lng']);
                }
                if (!empty($_POST['minimum']) && is_numeric($_POST['minimum']) && $_POST['minimum'] > 0) {
                    $insert_array['minimum'] = Wo_Secure($_POST['minimum']);
                }
                if (!empty($_POST['maximum']) && is_numeric($_POST['maximum']) && $_POST['maximum'] > 0) {
                    $insert_array['maximum'] = Wo_Secure($_POST['maximum']);
                }
                if (!empty($_POST['salary_date']) && in_array($_POST['salary_date'], $salary_date)) {
                    $insert_array['salary_date'] = Wo_Secure($_POST['salary_date']);
                }
                if (!empty($_POST['job_type'])) {
                    $insert_array['job_type'] = Wo_Secure($_POST['job_type']);
                }
                if (!empty($_POST['category'])) {
                    $insert_array['category'] = Wo_Secure($_POST['category']);
                }
                if (isset($_POST['currency'])) {
                    if (in_array($_POST['currency'], array_keys($wo['currencies']))) {
                        $insert_array['currency'] = Wo_Secure($_POST['currency']);
                    }
                }
                if (!empty($_POST['question_one'])) {
                    if (!empty($_POST['question_one_type']) && in_array($_POST['question_one_type'], $question_type)) {
                        if ($_POST['question_one_type'] != 'multiple_choice_question') {
                            $insert_array['question_one']      = Wo_Secure($_POST['question_one']);
                            $insert_array['question_one_type'] = Wo_Secure($_POST['question_one_type']);
                        } elseif ($_POST['question_one_type'] == 'multiple_choice_question' && !empty($_POST['question_one_answers'])) {
                            $insert_array['question_one']         = Wo_Secure($_POST['question_one']);
                            $insert_array['question_one_type']    = Wo_Secure($_POST['question_one_type']);
                            $answers                              = explode(',', $_POST['question_one_answers']);
                            $answers                              = (object) $answers;
                            $insert_array['question_one_answers'] = json_encode($answers);
                        }
                    }
                }
                if (!empty($_POST['question_two'])) {
                    if (!empty($_POST['question_two_type']) && in_array($_POST['question_two_type'], $question_type)) {
                        if ($_POST['question_two_type'] != 'multiple_choice_question') {
                            $insert_array['question_two']      = Wo_Secure($_POST['question_two']);
                            $insert_array['question_two_type'] = Wo_Secure($_POST['question_two_type']);
                        } elseif ($_POST['question_two_type'] == 'multiple_choice_question' && !empty($_POST['question_two_answers'])) {
                            $insert_array['question_two']         = Wo_Secure($_POST['question_two']);
                            $insert_array['question_two_type']    = Wo_Secure($_POST['question_two_type']);
                            $answers                              = explode(',', $_POST['question_two_answers']);
                            $answers                              = (object) $answers;
                            $insert_array['question_two_answers'] = json_encode($answers);
                        }
                    }
                }
                if (!empty($_POST['question_three'])) {
                    if (!empty($_POST['question_three_type']) && in_array($_POST['question_three_type'], $question_type)) {
                        if ($_POST['question_three_type'] != 'multiple_choice_question') {
                            $insert_array['question_three']      = Wo_Secure($_POST['question_three']);
                            $insert_array['question_three_type'] = Wo_Secure($_POST['question_three_type']);
                        } elseif ($_POST['question_three_type'] == 'multiple_choice_question' && !empty($_POST['question_three_answers'])) {
                            $insert_array['question_three']         = Wo_Secure($_POST['question_three']);
                            $insert_array['question_three_type']    = Wo_Secure($_POST['question_three_type']);
                            $answers                                = explode(',', $_POST['question_three_answers']);
                            $answers                                = (object) $answers;
                            $insert_array['question_three_answers'] = json_encode($answers);
                        }
                    }
                }
                if (!empty($_POST['description'])) {
                    $insert_array['description'] = Wo_Secure($_POST['description']);
                }
                $insert_array['image'] = '';
                if ($_POST['image_type'] == 'cover') {
                    $insert_array['image'] = $wo['user']['cover_org'];
                    if (!empty($page_data)) {
                        $insert_array['image'] = $page_data->cover;
                    }
                    $insert_array['image_type'] = 'cover';
                } elseif ($_POST['image_type'] == 'upload' && !empty($_FILES['thumbnail'])) {
                    $fileInfo                   = array(
                        'file' => $_FILES["thumbnail"]["tmp_name"],
                        'name' => $_FILES['thumbnail']['name'],
                        'size' => $_FILES["thumbnail"]["size"],
                        'type' => $_FILES["thumbnail"]["type"],
                        'types' => 'jpeg,jpg,png,bmp'
                    );
                    $media                      = Wo_ShareFile($fileInfo);
                    $insert_array['image']      = $media['filename'];
                    $insert_array['image_type'] = 'upload';
                }
                if (!empty($insert_array['image'])) {
                    $insert_array['user_id'] = $wo['user']['id'];
                    if (!empty($page_data)) {
                        $insert_array['page_id'] = $page_data->page_id;
                        $insert_array['user_id'] = $page_data->user_id;
                    }
                    $insert_array['time'] = time();
                    $job_id               = $db->insert(T_JOB, $insert_array);
                    $post_id              = $db->insert(T_POSTS, array(
                        'page_id' => !empty($page_data) ? $page_data->page_id : 0,
                        'user_id' => !empty($page_data) ? 0 : $wo['user']['id'],
                        'postText' => '"' . $insert_array['title'] . '"',
                        'job_id' => $job_id,
                        'postType' => 'job',
                        'postPrivacy' => '0',
                        'time' => time()
                    ));
                    $db->where('id', $post_id)->update(T_POSTS, array(
                        'post_id' => $post_id
                    ));
                    $data['status'] = 200;
                } else {
                    $data['error'] = $error_icon . $wo['lang']['file_not_supported'];
                }
            } else {
                $data['error'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'get_apply_modal') {
        if (!empty($_POST['job_id']) && is_numeric($_POST['job_id']) && $_POST['job_id'] > 0) {
            $wo['job']      = Wo_GetJobById($_POST['job_id']);
            $data['html']   = Wo_LoadPage("modals/apply_job");
            $data['status'] = 200;
        }
    }
    if ($s == 'apply_job' && !empty($_POST['job_id']) && is_numeric($_POST['job_id']) && $_POST['job_id'] > 0) {
        $job = Wo_GetJobById($_POST['job_id']);
        if (!empty($job) && !empty($_POST['user_name']) && !empty($_POST['phone_number']) && !empty($_POST['location']) && !empty($_POST['email']) && $job['apply'] == false) {
            $insert      = true;
            $insert_data = array();
            if (!empty($job['question_one'])) {
                if ($job['question_one_type'] == 'yes_no_question' && !empty($_POST['question_one_answer']) && in_array($_POST['question_one_answer'], array(
                    'yes',
                    'no'
                ))) {
                    $insert_data['question_one_answer'] = Wo_Secure($_POST['question_one_answer']);
                } elseif ($job['question_one_type'] == 'multiple_choice_question' && in_array($_POST['question_one_answer'], array_keys($job['question_one_answers']))) {
                    $insert_data['question_one_answer'] = Wo_Secure($_POST['question_one_answer']);
                } elseif ($job['question_one_type'] == 'free_text_question' && !empty($_POST['question_one_answer'])) {
                    $insert_data['question_one_answer'] = Wo_Secure($_POST['question_one_answer']);
                } else {
                    $insert = false;
                }
            }
            if (!empty($job['question_two'])) {
                if ($job['question_two_type'] == 'yes_no_question' && in_array($_POST['question_two_answer'], array(
                    'yes',
                    'no'
                ))) {
                    $insert_data['question_two_answer'] = Wo_Secure($_POST['question_two_answer']);
                } elseif ($job['question_two_type'] == 'multiple_choice_question' && in_array($_POST['question_two_answer'], array_keys($job['question_two_answers']))) {
                    $insert_data['question_two_answer'] = Wo_Secure($_POST['question_two_answer']);
                } elseif ($job['question_two_type'] == 'free_text_question') {
                    $insert_data['question_two_answer'] = Wo_Secure($_POST['question_two_answer']);
                } else {
                    $insert = false;
                }
            }
            if (!empty($job['question_three'])) {
                if ($job['question_three_type'] == 'yes_no_question' && in_array($_POST['question_three_answer'], array(
                    'yes',
                    'no'
                ))) {
                    $insert_data['question_three_answer'] = Wo_Secure($_POST['question_three_answer']);
                } elseif ($job['question_three_type'] == 'multiple_choice_question' && in_array($_POST['question_three_answer'], array_keys($job['question_three_answers']))) {
                    $insert_data['question_three_answer'] = Wo_Secure($_POST['question_three_answer']);
                } elseif ($job['question_three_type'] == 'free_text_question') {
                    $insert_data['question_three_answer'] = Wo_Secure($_POST['question_three_answer']);
                } else {
                    $insert = false;
                }
            }
            if ($insert == true) {
                $insert_data['user_name']    = Wo_Secure($_POST['user_name']);
                $insert_data['phone_number'] = Wo_Secure($_POST['phone_number']);
                $insert_data['location']     = Wo_Secure($_POST['location']);
                $insert_data['email']        = Wo_Secure($_POST['email']);
                $insert_data['job_id']       = Wo_Secure($_POST['job_id']);
                $insert_data['user_id']      = $wo['user']['id'];
                $insert_data['page_id']      = $job['page_id'];
                $insert_data['time']         = time();
                if (!empty($_POST['position'])) {
                    $insert_data['position'] = Wo_Secure($_POST['position']);
                }
                if (!empty($_POST['where_did_you_work'])) {
                    $insert_data['where_did_you_work'] = Wo_Secure($_POST['where_did_you_work']);
                }
                if (!empty($_POST['experience_description'])) {
                    $insert_data['experience_description'] = Wo_Secure($_POST['experience_description']);
                }
                if (!empty($_POST['position']) && !empty($_POST['where_did_you_work']) && !empty($_POST['experience_start_date'])) {
                    $insert_data['experience_start_date'] = Wo_Secure($_POST['experience_start_date']);
                } else {
                    $insert_data['experience_start_date'] = '';
                }
                if (!empty($_POST['i_currently_work']) && $_POST['i_currently_work'] == 'on') {
                    $insert_data['experience_end_date'] = '';
                } else {
                    if (!empty($_POST['position']) && !empty($_POST['where_did_you_work']) && !empty($_POST['experience_end_date'])) {
                        $insert_data['experience_end_date'] = Wo_Secure($_POST['experience_end_date']);
                    } else {
                        $insert_data['experience_end_date'] = '';
                    }
                }
                $db->insert(T_JOB_APPLY, $insert_data);
                if (!empty($job['page'])) {
                    $notification_data_array = array(
                        'recipient_id' => $job['page']['user_id'],
                        'type' => 'apply_job',
                        'url' => 'index.php?link1=timeline&u=' . $job['page']['page_name'] . '&type=job_apply&id=' . $insert_data['job_id']
                    );
                    $data['user_id']         = $job['page']['user_id'];
                } else {
                    $notification_data_array = array(
                        'recipient_id' => $job['user']['user_id'],
                        'type' => 'apply_job',
                        'url' => 'index.php?link1=timeline&u=' . $job['user']['username'] . '&type=job_apply&id=' . $insert_data['job_id']
                    );
                    $data['user_id']         = $job['user']['user_id'];
                }
                Wo_RegisterNotification($notification_data_array);
                $data['status'] = 200;
            } else {
                if ($job['apply'] == true) {
                    $data['error'] = $error_icon . $wo['lang']['you_apply_this_job'];
                } else {
                    $data['error'] = $error_icon . $wo['lang']['please_answer_questions'];
                }
            }
        } else {
            $data['error'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'search_jobs') {
        $html  = '';
        $array = array(
            'limit' => 15
        );
        if (!empty($_POST['c_id'])) {
            $array['c_id'] = Wo_Secure($_POST['c_id']);
        }
        if (!empty($_POST['value'])) {
            $array['keyword'] = $_POST['value'];
        }
        if (!empty($_POST['length'])) {
            $array['length'] = $_POST['length'];
        }
        if (!empty($_POST['type'])) {
            $array['type'] = $_POST['type'];
        }
        if (!empty($_POST['last_id'])) {
            $array['after_id'] = $_POST['last_id'];
        }
        $result = Wo_GetAllJobs($array);
        foreach ($result as $key => $wo['job']) {
            $html .= Wo_LoadPage('jobs/jobs_list');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'edit_job' && !empty($_POST['job_id']) && is_numeric($_POST['job_id']) && $_POST['job_id'] > 0) {
        $job = Wo_GetJobById($_POST['job_id']);
        if (!empty($job) && (((!empty($job['page']) && $job['page']['is_page_onwer']) || empty($job['page'])) || $job['user_id'] == $wo['user']['id'] || Wo_IsAdmin() || Wo_IsModerator())) {
            $insert_array = array();
            if (!empty($_POST['job_title'])) {
                $insert_array['title'] = Wo_Secure($_POST['job_title']);
            }
            if (!empty($_POST['location'])) {
                $insert_array['location'] = Wo_Secure($_POST['location']);
            }
            if (!empty($_POST['minimum']) && is_numeric($_POST['minimum']) && $_POST['minimum'] > 0) {
                $insert_array['minimum'] = Wo_Secure($_POST['minimum']);
            }
            if (!empty($_POST['maximum']) && is_numeric($_POST['maximum']) && $_POST['maximum'] > 0) {
                $insert_array['maximum'] = Wo_Secure($_POST['maximum']);
            }
            if (!empty($_POST['salary_date']) && in_array($_POST['salary_date'], $salary_date)) {
                $insert_array['salary_date'] = Wo_Secure($_POST['salary_date']);
            }
            if (!empty($_POST['job_type'])) {
                $insert_array['job_type'] = Wo_Secure($_POST['job_type']);
            }
            if (!empty($_POST['category'])) {
                $insert_array['category'] = Wo_Secure($_POST['category']);
            }
            if (!empty($_POST['description'])) {
                $insert_array['description'] = Wo_Secure($_POST['description']);
            }
            $db->where('id', $job['id'])->update(T_JOB, $insert_array);
            $data['status'] = 200;
        }
    }
    if ($s == 'load' && !empty($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] > 0 && !empty($_GET['job_id']) && is_numeric($_GET['job_id']) && $_GET['job_id'] > 0) {
        $offset    = Wo_Secure($_GET['offset']);
        $job_id    = Wo_Secure($_GET['job_id']);
        $html      = '';
        $job_apply = Wo_GetApplyJob(array(
            'job_id' => $job_id,
            'offset' => $offset
        ));
        if (!empty($job_apply)) {
            foreach ($job_apply as $key => $wo['job_apply']) {
                $html .= Wo_LoadPage('page/job_apply');
            }
            $data = array(
                'status' => 200,
                'html' => $html
            );
        } else {
            $data = array(
                'status' => 400,
                'html' => $html
            );
        }
    }
    if ($s == 'delete_job' && !empty($_GET['job_id']) && is_numeric($_GET['job_id']) && $_GET['job_id'] > 0) {
        $job_id = Wo_Secure($_GET['job_id']);
        $job    = $db->where('id', $job_id)->getOne(T_JOB);
        if (!empty($job) && ($job->user_id == $wo['user']['id'] || Wo_IsModerator() || Wo_IsAdmin())) {
            if ($job->image_type != 'cover') {
                @unlink($job->image);
                Wo_DeleteFromToS3($job->image);
            }
            $db->where('id', $job_id)->delete(T_JOB);
            $db->where('job_id', $job_id)->delete(T_JOB_APPLY);
            $post = $db->where('job_id', $job_id)->getOne(T_POSTS);
            if (!empty($post)) {
                Wo_DeletePost($post->id);
            }
        }
        $data['status'] = 200;
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
header("Content-type: application/json");
echo json_encode($data);
exit();
