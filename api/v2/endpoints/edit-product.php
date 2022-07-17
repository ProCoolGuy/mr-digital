<?php
// +------------------------------------------------------------------------+
// | @author Deen Doughouz (DoughouzForest)
// | @author_url 1: http://www.wowonder.com
// | @author_url 2: http://codecanyon.net/user/doughouzforest
// | @author_email: wowondersocial@gmail.com   
// +------------------------------------------------------------------------+
// | WoWonder - The Ultimate Social Networking Platform
// | Copyright (c) 2018 WoWonder. All rights reserved.
// +------------------------------------------------------------------------+
$response_data = array(
    'api_status' => 400
);

$required_fields = array(
    'product_id',
    'product_title',
    'product_category',
    'product_description',
    'product_price',
    'product_location'
);

foreach ($required_fields as $key => $value) {
    if (empty($_POST[$value]) && empty($error_code)) {
        $error_code    = 3;
        $error_message = $value . ' (POST) is missing';
    }
}
if (empty(Wo_GetPostIDFromProdcutID($_POST['product_id'])) && empty($error_message)) {
    $error_code    = 4;
    $error_message = 'Product not found';
}

if (empty($error_code)) {
    $product_title       = Wo_Secure($_POST['product_title']);
    $product_category    = Wo_Secure($_POST['product_category']);
    $product_description = Wo_Secure($_POST['product_description']);
    $product_location    = Wo_Secure($_POST['product_location']);
    $product_price       = Wo_Secure($_POST['product_price']);
    $lat       = (!empty($_POST['lat'])) ? Wo_Secure($_POST['lat']) : 0;
    $lng       = (!empty($_POST['lng'])) ? Wo_Secure($_POST['lng']) : 0;
    $product_type        = (!empty($_POST['product_type'])) ? 1 : 0;
    
    if ($product_price == '0.00') {
        $error_code    = 4;
        $error_message = 'Please choose a price for your product';
    } else if (!is_numeric($product_price)) {
        $error_code    = 5;
        $error_message = 'Please choose a correct value for your price';
    }
    
    if (isset($_FILES['images']['name'])) {
        $allowed = array(
            'gif',
            'png',
            'jpg',
            'jpeg'
        );
        for ($i = 0; $i < count($_FILES['images']['name']); $i++) {
            $new_string = pathinfo($_FILES['images']['name'][$i]);
            if (!in_array(strtolower($new_string['extension']), $allowed)) {
                $error_code    = 6;
                $error_message = 'Image format is not supported, (jpg, png, gif, jpeg) are supported';
            }
        }
    }
    
    if (empty($error_code)) {
        $currency = 0;
        if (isset($_POST['currency'])) {
            if (in_array($_POST['currency'], array_keys($wo['currencies']))) {
                $currency = Wo_Secure($_POST['currency']);
            }
        }

        $sub_category = '';
        if (!empty($_POST['product_sub_category']) && !empty($wo['products_sub_categories'][$_POST['product_category']])) {
            foreach ($wo['products_sub_categories'][$_POST['product_category']] as $key => $value) {
                if ($value['id'] == $_POST['product_sub_category']) {
                    $sub_category = $value['id'];
                }
            }
        }

        $product_data_array = array(
            'name' => $product_title,
            'category' => $product_category,
            'description' => $product_description,
            'price' => $product_price,
            'location' => $product_location,
            'type' => $product_type,
            'currency' => $currency,
            'sub_category' => $sub_category,
            'lat' => $lat,
            'lng' => $lng
        );

        $fields = Wo_GetCustomFields('product'); 
        if (!empty($fields)) {
            foreach ($fields as $key => $field) {
                if ($field['required'] == 'on' && empty($_POST['fid_'.$field['id']])) {
                    $response_data       = array(
                        'api_status'     => '404',
                        'errors'         => array(
                            'error_id'   => 7,
                            'error_text' => 'please check details required field'
                        )
                    );
                    echo json_encode($response_data, JSON_PRETTY_PRINT);
                    exit();
                }
                elseif (!empty($_POST['fid_'.$field['id']])) {
                    $product_data_array['fid_'.$field['id']] = Wo_Secure($_POST['fid_'.$field['id']]);
                }
            }
        }

        $product_data       = Wo_UpdateProductData($_POST['product_id'], $product_data_array);
        $product_id         = $_POST['product_id'];
        $id = Wo_GetPostIDFromProdcutID($product_id);
        // if (count($_FILES['postPhotos']) > 0 && !empty($id) && $id > 0) {
        //     $fileInfo = array(
        //         'file' => $_FILES["postPhotos"]["tmp_name"],
        //         'name' => $_FILES['postPhotos']['name'],
        //         'size' => $_FILES["postPhotos"]["size"],
        //         'type' => $_FILES["postPhotos"]["type"],
        //         'types' => 'jpg,png,jpeg,gif'
        //     );
        //     $file     = Wo_ShareFile($fileInfo, 1);
        //     if (!empty($file)) {
        //         $media_album = Wo_RegisterProductMedia($product_id, $file['filename']);
        //     }
        // }
        if (isset($_FILES['images']['name'])) {
                if (count($_FILES['images']['name']) > 0 && !empty($id) && $id > 0) {
                    for ($i = 0; $i < count($_FILES['images']['name']); $i++) {
                        $fileInfo = array(
                            'file' => $_FILES["images"]["tmp_name"][$i],
                            'name' => $_FILES['images']['name'][$i],
                            'size' => $_FILES["images"]["size"][$i],
                            'type' => $_FILES["images"]["type"][$i],
                            'types' => 'jpg,png,jpeg,gif'
                        );
                        $file     = Wo_ShareFile($fileInfo, 1);
                        if (!empty($file)) {
                            $media_album = Wo_RegisterProductMedia($product_id, $file['filename']);
                        }
                    }
                }
            }
            if (!empty($_POST['deleted_images_ids'])) {
                $images_array = explode(',', $_POST['deleted_images_ids']);
                if (!empty($images_array)) {
                    $product_data = Wo_GetProduct($product_id);
                    foreach ($images_array as $key => $value) {
                        $image = Wo_ProductImageData(array('id' => $value));
                        if (!empty($image)) {
                            $explode2    = @end(explode('.', $image['image']));
                            $explode3    = @explode('.', $image['image']);
                            $small_image = $explode3[0] . '_small.' . $explode2;

                            $product = Wo_GetProduct($image['product_id']);
                            if (!empty($product) && $wo['user']['id'] == $product['user_id']) {
                                $deleted = Wo_DeleteProductImage($value);
                                if ($deleted) {
                                    if (($wo['config']['amazone_s3'] == 1 || $wo['config']['wasabi_storage'] == 1 || $wo['config']['ftp_upload'] == 1 || $wo['config']['spaces'] == 1 || $wo['config']['cloud_upload'] == 1)) {
                                        Wo_DeleteFromToS3($image['image']);
                                        Wo_DeleteFromToS3($small_image);
                                    }
                                    @unlink($image['image']);
                                    @unlink($small_image);
                                }
                            }
                        }
                    }
                }
            }








        // if (isset($_FILES['postPhotos']['name'])) {
        //     if (count($_FILES['postPhotos']['name']) > 0 && !empty($id) && $id > 0) {
        //         for ($i = 0; $i < count($_FILES['postPhotos']['name']); $i++) {
        //             $fileInfo = array(
        //                 'file' => $_FILES["postPhotos"]["tmp_name"][$i],
        //                 'name' => $_FILES['postPhotos']['name'][$i],
        //                 'size' => $_FILES["postPhotos"]["size"][$i],
        //                 'type' => $_FILES["postPhotos"]["type"][$i],
        //                 'types' => 'jpg,png,jpeg,gif'
        //             );
        //             $file     = Wo_ShareFile($fileInfo, 1);
        //             if (!empty($file)) {
        //                 $media_album = Wo_RegisterProductMedia($product_id, $file['filename']);
        //             }
        //         }
        //     }
        // }
        $response_data = array(
            'api_status' => 200,
            'message' => "Product successfully edited."
        );
    }
}