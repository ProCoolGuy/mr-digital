<?php 
if ($f == 'download_user_info') {
    $data['status'] = 200;
    if(!empty($wo['user']["info_file"])){
       // Get parameters
       $file = $wo['user']["info_file"];
       $filepath = $file; // upload/files/2019/20/adsoasdhalsdkjalsdjalksd.html

       // Process download
       if(file_exists($filepath)) {
           header('Content-Description: File Transfer');
           header('Content-Type: application/octet-stream');
           // rename the file to username
           header('Content-Disposition: attachment; filename="'.$wo['user']['username'].'.html"');
           header('Expires: 0');
           header('Cache-Control: must-revalidate');
           header('Pragma: public');
           header('Content-Length: ' . filesize($filepath));
           flush(); // Flush system output buffer
           readfile($filepath);
           // delete the file
           unlink($filepath);
           // remove user data
          Wo_UpdateUserData($wo['user']['user_id'], array(
                'info_file' => ''
            ));
           exit;
       }
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
