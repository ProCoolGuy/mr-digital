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

$required_fields =  array(
                        'paypal',
                        'bank'
                    );
if (!empty($_POST['type']) && in_array($_POST['type'], $required_fields)) {
    if ($_POST['type'] == 'paypal') {
        if (empty($_POST['paypal_email'])) {
            $error_code    = 5;
            $error_message = 'paypal_email can not be empty';
        }
        elseif (!filter_var($_POST['paypal_email'], FILTER_VALIDATE_EMAIL)) {
            $error_code    = 6;
            $error_message = 'invalid email';
        }
        elseif (empty($_POST['amount']) || !is_numeric($_POST['amount'])) {
            $error_code    = 7;
            $error_message = 'amount can not be empty';
        }
        elseif (Wo_IsUserPaymentRequested($wo['user']['user_id']) === true) {
            $error_code    = 8;
            $error_message = 'you have pending request';
        } 
        elseif (($wo['user']['balance'] < $_POST['amount'])) {
            $error_code    = 9;
            $error_message = $wo['lang']['invalid_amount_value_your'] . ''.Wo_GetCurrency($wo['config']['ads_currency']) . $wo['user']['balance'];
        } 
        elseif ($wo['config']['m_withdrawal'] > $_POST['amount']) {
            $error_code    = 10;
            $error_message = $wo['lang']['invalid_amount_value_withdrawal'] . ' '.Wo_GetCurrency($wo['config']['ads_currency']) . $wo['config']['m_withdrawal'];
        }
        else{
            $userU  = Wo_UpdateUserData($wo['user']['user_id'], array(
                        'paypal_email' => $_POST['paypal_email']
                    ));
            $insert_payment = Wo_RequestNewPayment($wo['user']['user_id'], $_POST['amount'],$insert_array);
            if ($insert_payment) {
                $update_balance = Wo_UpdateBalance($wo['user']['user_id'], $_POST['amount'], '-');
                $response_data['message'] = $wo['lang']['you_request_sent'];
                $response_data['api_status'] = 200;
            }
            else{
                $error_code    = 11;
                $error_message = 'something went wrong';
            }
        }
    }
    if ($_POST['type'] == 'bank') {
        if (empty($_POST['iban']) || empty($_POST['country']) || empty($_POST['full_name']) || empty($_POST['swift_code']) || empty($_POST['address'])) {
            $error_code    = 5;
            $error_message = 'please check details';
        }
        elseif (empty($_POST['amount']) || !is_numeric($_POST['amount'])) {
            $error_code    = 7;
            $error_message = 'amount can not be empty';
        }
        elseif (Wo_IsUserPaymentRequested($wo['user']['user_id']) === true) {
            $error_code    = 8;
            $error_message = 'you have pending request';
        } 
        elseif (($wo['user']['balance'] < $_POST['amount'])) {
            $error_code    = 9;
            $error_message = $wo['lang']['invalid_amount_value_your'] . ''.Wo_GetCurrency($wo['config']['ads_currency']) . $wo['user']['balance'];
        } 
        elseif ($wo['config']['m_withdrawal'] > $_POST['amount']) {
            $error_code    = 10;
            $error_message = $wo['lang']['invalid_amount_value_withdrawal'] . ' '.Wo_GetCurrency($wo['config']['ads_currency']) . $wo['config']['m_withdrawal'];
        }
        else{
            $insert_array = array();
            if ($wo['config']['bank_withdrawal_system'] == 1 && !empty($_POST['iban']) && !empty($_POST['country']) && !empty($_POST['full_name']) && !empty($_POST['swift_code']) && !empty($_POST['address'])) {
                $insert_array['iban'] = Wo_Secure($_POST['iban']);
                $insert_array['country'] = Wo_Secure($_POST['country']);
                $insert_array['full_name'] = Wo_Secure($_POST['full_name']);
                $insert_array['swift_code'] = Wo_Secure($_POST['swift_code']);
                $insert_array['address'] = Wo_Secure($_POST['address']);
                $userU          = Wo_UpdateUserData($wo['user']['user_id'], array(
                                        'paypal_email' => ''
                                    ));
            }
            $insert_payment = Wo_RequestNewPayment($wo['user']['user_id'], $_POST['amount'],$insert_array);
            if ($insert_payment) {
                $update_balance = Wo_UpdateBalance($wo['user']['user_id'], $_POST['amount'], '-');
                $response_data['message'] = $wo['lang']['you_request_sent'];
                $response_data['api_status'] = 200;
            }
        }
    }
}
else{
    $error_code    = 4;
    $error_message = 'type can not be empty';
}