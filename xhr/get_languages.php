<?php 
if ($f == 'get_languages') {
    $data['status'] = 400;
    $data['html'] = '';
    if (!empty($_POST['word'])) {
        $keys = array();
        $full = $db->get(T_USER_LANGUAGES,null,array('lang_key'));
        if (!empty($full)) {
            foreach ($full as $key => $value) {
                $keys[] = $value->lang_key;
            }
            $db->where('lang_key',$keys,'IN');
        }
        $word            = Wo_Secure($_POST['word']);
        $sql   = "(`lang_key` LIKE '%$word%' ";
        if (!empty($all_langs)) {
            foreach ($all_langs as $key => $value) {
                $sql   .= " OR `".$value."`  LIKE '%$word%' ";
            }
        }
        $sql   .= " )";
        $langs = $db->where($sql)->get(T_LANGS);
        if (!empty($langs)) {
            $data['status'] = 200;
            foreach ($langs as $key => $value) {
                $data['html'] .= '<p onclick="AddToLang(this,\''.$value->lang_key.'\')">'.$wo['lang'][$value->lang_key].'</p>';
            }
        }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
?>