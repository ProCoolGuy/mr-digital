<?php 
if ($f == 'get_skills') {
    $data['status'] = 400;
    $data['html'] = '';
    if (!empty($_POST['word'])) {
        $word            = Wo_Secure($_POST['word']);
        $sql   = "(`name` LIKE '%$word%')";
        $skills = $db->where($sql)->get(T_USER_SKILLS);
        if (!empty($skills)) {
            $data['status'] = 200;
            foreach ($skills as $key => $value) {
                $data['html'] .= '<p onclick="AddToSkill(this)">'.$value->name.'</p>';
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
?>