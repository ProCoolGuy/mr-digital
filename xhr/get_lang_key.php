<?php 
if ($f == 'get_lang_key') {
    $html  = '';
    $langs = Wo_GetLangDetails($_GET['id']);
    if (count($langs) > 0) {
        foreach ($langs as $key => $wo['langs']) {
            foreach ($wo['langs'] as $wo['key_'] => $wo['lang_vlaue']) {
                $wo['is_editale'] = 0;
                if ($_GET['lang_name'] == $wo['key_']) {
                    $wo['is_editale'] = 1;
                }
                $html .= Wo_LoadAdminPage('edit-lang/form-list');
            }
        }
    } else {
        $html = "<h4>Keyword not found</h4>";
    }
    $data['have_image'] = 0;
    $gender = $db->where('gender_id',Wo_Secure($_GET['id']))->getOne(T_GENDER);
    if (!empty($gender) && !empty($gender->image)) {
        $data['have_image'] = 1;
    }
    $data['status'] = 200;
    $data['html']   = $html;
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
