<?php 
if ($f == 'upload-blog-image') {
    reset($_FILES);
    $temp = current($_FILES);
    if (is_uploaded_file($temp['tmp_name'])) {
        $fileInfo = array(
            'file' => $temp["tmp_name"],
            'name' => $temp['name'],
            'size' => $temp["size"],
            'type' => $temp["type"]
        );
        $media    = Wo_ShareFile($fileInfo);
        if (!empty($media)) {
            $mediaFilename = $media['filename'];
            $mediaName     = $media['name'];
        }
        if (!empty($mediaFilename)) {
            $filetowrite = Wo_GetMedia($mediaFilename);
            echo json_encode(array(
                'location' => $filetowrite
            ));
            exit();
        } else {
            header("HTTP/1.0 500 Server Error");
        }
    } else {
        header("HTTP/1.0 500 Server Error");
    }
}
