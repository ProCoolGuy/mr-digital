<?php
// Paypal methods
use PayPal\Api\Payer;
use PayPal\Api\Item;
use PayPal\Api\ItemList;
use PayPal\Api\Details;
use PayPal\Api\Amount;
use PayPal\Api\Transaction;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;
if ($f == 'funding' && $wo['config']['funding_system'] == 1) {
    $data['status'] = 400;
    if ($s == 'insert_funding') {
        if ($wo['config']['who_upload'] == 'pro' && $wo['user']['is_pro'] == 0 && !Wo_IsAdmin() && !empty($_FILES['image'])) {
            $data['message'] = $error_icon . $wo['lang']['free_plan_upload_pro'];
        } else {
            if (!empty($_POST['title']) && !empty($_POST['description']) && !empty($_FILES['image']) && !empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0) {
                $insert_array = array();
                $fileInfo     = array(
                    'file' => $_FILES["image"]["tmp_name"],
                    'name' => $_FILES['image']['name'],
                    'size' => $_FILES["image"]["size"],
                    'type' => $_FILES["image"]["type"],
                    'types' => 'jpeg,jpg,png,bmp'
                );
                $media        = Wo_ShareFile($fileInfo);
                if (!empty($media) && !empty($media['filename'])) {
                    $insert_array    = array(
                        'title' => Wo_Secure($_POST['title']),
                        'description' => Wo_Secure($_POST['description']),
                        'amount' => Wo_Secure($_POST['amount']),
                        'time' => time(),
                        'user_id' => $wo['user']['id'],
                        'image' => $media['filename'],
                        'hashed_id' => Wo_GenerateKey(15, 15)
                    );
                    $fund_id         = $db->insert(T_FUNDING, $insert_array);
                    $post_data       = array(
                        'user_id' => Wo_Secure($wo['user']['user_id']),
                        'fund_id' => $fund_id,
                        'time' => time(),
                        'multi_image_post' => 0,
                        'postPrivacy' => 0
                    );
                    $id              = Wo_RegisterPost($post_data);
                    $data['status']  = 200;
                    $data['message'] = $wo['lang']['funding_created'];
                    $data['url']     = Wo_SeoLink('index.php?link1=my_funding');
                } else {
                    $data['message'] = $error_icon . $wo['lang']['file_not_supported'];
                }
            } else {
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        }
    }
    if ($s == 'delete_fund') {
        if (!empty($_GET['id'])) {
            $id   = Wo_Secure($_GET['id']);
            $fund = $db->where('id', $id)->getOne(T_FUNDING);
            if (!empty($fund) || ($wo['user']['user_id'] != $fund->user_id && Wo_IsAdmin() == false)) {
                @Wo_DeleteFromToS3($fund->image);
                if (file_exists($fund->image)) {
                    try {
                        unlink($fund->image);
                    }
                    catch (Exception $e) {
                    }
                }
                $db->where('id', $id)->delete(T_FUNDING);
                $raise = $db->where('funding_id', $id)->get(T_FUNDING_RAISE);
                $db->where('funding_id', $id)->delete(T_FUNDING_RAISE);
                $posts = $db->where('fund_id', $id)->get(T_POSTS);
                if (!empty($posts)) {
                    foreach ($posts as $key => $value) {
                        $db->where('parent_id', $value->id)->delete(T_POSTS);
                    }
                }
                $db->where('fund_id', $id)->delete(T_POSTS);
                foreach ($raise as $key => $value) {
                    $raise_posts = $db->where('fund_raise_id', $value->id)->get(T_POSTS);
                    if (!empty($raise_posts)) {
                        foreach ($posts as $key => $value1) {
                            $db->where('parent_id', $value1->id)->delete(T_POSTS);
                        }
                    }
                    $db->where('fund_raise_id', $value->id)->delete(T_POSTS);
                }
                $data['status'] = 200;
            } else {
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'edit_funding') {
        $data['status'] = 400;
        if (!empty($_POST['title']) && !empty($_POST['description']) && !empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0 && !empty($_POST['id'])) {
            $id   = Wo_Secure($_POST['id']);
            $fund = $db->where('id', $id)->getOne(T_FUNDING);
            if (!empty($fund) || ($wo['user']['user_id'] != $fund->user_id && Wo_IsAdmin() == false)) {
                $insert_array = array(
                    'title' => Wo_Secure($_POST['title']),
                    'description' => Wo_Secure($_POST['description']),
                    'amount' => Wo_Secure($_POST['amount'])
                );
                if (!empty($_FILES["image"])) {
                    $fileInfo = array(
                        'file' => $_FILES["image"]["tmp_name"],
                        'name' => $_FILES['image']['name'],
                        'size' => $_FILES["image"]["size"],
                        'type' => $_FILES["image"]["type"],
                        'types' => 'jpeg,jpg,png,bmp'
                    );
                    $media    = Wo_ShareFile($fileInfo);
                    if (!empty($media) && !empty($media['filename'])) {
                        $insert_array['image'] = $media['filename'];
                    }
                    @Wo_DeleteFromToS3($fund->image);
                    if (file_exists($fund->image)) {
                        try {
                            unlink($fund->image);
                        }
                        catch (Exception $e) {
                        }
                    }
                }
                $db->where('id', $id)->update(T_FUNDING, $insert_array);
                $data['status']  = 200;
                $data['message'] = $wo['lang']['funding_edited'];
                $data['url']     = $wo['config']['site_url'] . '/show_fund/' . $fund->hashed_id;
            } else {
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'load_user_fund') {
        if (!empty($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] > 0) {
            $id      = Wo_Secure($_GET['offset']);
            $user_id = $wo['user']['id'];
            if (!empty($_GET['user_id']) && is_numeric($_GET['user_id']) && $_GET['user_id'] > 0) {
                $user_id = Wo_Secure($_GET['user_id']);
            }
            $funding = GetFundingByUserId($user_id, 9, $id);
            $html    = '';
            if (!empty($funding)) {
                foreach ($funding as $key => $wo['fund']) {
                    $html .= Wo_LoadPage('my_funding/list');
                }
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
    }
    if ($s == 'load_fund') {
        if (!empty($_GET['offset']) && is_numeric($_GET['offset']) && $_GET['offset'] > 0) {
            $id      = Wo_Secure($_GET['offset']);
            $funding = GetFunding(10, $id);
            $html    = '';
            if (!empty($funding)) {
                foreach ($funding as $key => $wo['fund']) {
                    $html .= Wo_LoadPage('funding/list');
                }
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
    }
    if ($s == 'get_payment_donate_method') {
        if (!empty($_GET['amount']) && is_numeric($_GET['amount']) && $_GET['amount'] > 0 && !empty($_GET['fund_id']) && is_numeric($_GET['fund_id']) && $_GET['fund_id'] > 0) {
            $amount = Wo_Secure($_GET['amount']);
            $id     = Wo_Secure($_GET['fund_id']);
            $fund   = GetFundingById($id);
            $left   = $fund['amount'] - $fund['raised'];
            if (!empty($fund)) {
                if ($amount <= $left) {
                    $html                     = '';
                    $wo['donate_fund_id']     = $id;
                    $wo['donate_fund_amount'] = $amount;
                    $html                     = Wo_LoadPage('modals/donate_payment_methods');
                    $data['status']           = 200;
                    $data['html']             = $html;
                } else {
                    $data['message'] = $error_icon . str_replace('{{money}}', $wo['config']['currency_symbol_array'][$wo['config']['currency']] . $left, $wo['lang']['you_cant_pay']);
                }
            } else {
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'get_paypal_url' && $wo['config']['paypal'] != 'no') {
        if (!empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0 && !empty($_POST['fund_id']) && is_numeric($_POST['fund_id']) && $_POST['fund_id'] > 0) {
            $price = Wo_Secure($_POST['amount']);
            $id    = Wo_Secure($_POST['fund_id']);
            $fund  = $db->where('id', $id)->getOne(T_FUNDING);
            if (!empty($fund)) {
                include_once('assets/includes/paypal_config.php');
                $product = "Doante to " . mb_substr($fund->title, 0, 100, "UTF-8");
                $payer   = new Payer();
                $payer->setPaymentMethod('paypal');
                $item = new Item();
                $item->setName($product)->setQuantity(1)->setPrice($price)->setCurrency($wo['config']['paypal_currency']);
                $itemList = new ItemList();
                $itemList->setItems(array(
                    $item
                ));
                $details = new Details();
                $details->setSubtotal($price);
                $amount = new Amount();
                $amount->setCurrency($wo['config']['paypal_currency'])->setTotal($price)->setDetails($details);
                $transaction = new Transaction();
                $transaction->setAmount($amount)->setItemList($itemList)->setDescription($product)->setInvoiceNumber(uniqid());
                $redirectUrls = new RedirectUrls();
                $redirectUrls->setReturnUrl($wo['config']['site_url'] . "/requests.php?f=funding&s=paypal_paid&fund_id=" . $id . "&amount=" . $price)->setCancelUrl($wo['config']['site_url']);
                $payment = new Payment();
                $payment->setIntent('sale')->setPayer($payer)->setRedirectUrls($redirectUrls)->setTransactions(array(
                    $transaction
                ));
                try {
                    $payment->create($paypal);
                }
                catch (Exception $e) {
                    $data = array(
                        'type' => 'ERROR',
                        'details' => json_decode($e->getData())
                    );
                    if (empty($data['details'])) {
                        $data['details'] = json_decode($e->getCode());
                    }
                    return $data;
                }
                $data = array(
                    'status' => 200,
                    'url' => $payment->getApprovalLink()
                );
            } else {
                $data['message'] = $error_icon . $wo['lang']['please_check_details'];
            }
        } else {
            $data['message'] = $error_icon . $wo['lang']['please_check_details'];
        }
    }
    if ($s == 'paypal_paid' && $wo['config']['paypal'] != 'no' && !empty($_GET['fund_id']) && !empty($_GET['amount'])) {
        if (!isset($_GET['paymentId'], $_GET['PayerID'])) {
            header("Location: " . Wo_SeoLink('index.php?link1=oops'));
            exit();
        }
        $fund_id = Wo_Secure($_GET['fund_id']);
        $amount  = Wo_Secure($_GET['amount']);
        $fund    = $db->where('id', $fund_id)->getOne(T_FUNDING);
        if (!empty($fund) && !empty($fund_id) && !empty($amount)) {
            $paymentId = $_GET['paymentId'];
            $PayerID   = $_GET['PayerID'];
            include_once 'assets/includes/paypal_config.php';
            $payment = new Payment();
            $payment = Payment::get($paymentId, $paypal);
            $execute = new PaymentExecution();
            $execute->setPayerId($PayerID);
            try {
                $notes              = "Doanted to " . mb_substr($fund->title, 0, 100, "UTF-8");
                $result             = $payment->execute($execute, $paypal);
                $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'DONATE', {$amount}, '{$notes}')");
                $admin_com          = 0;
                if (!empty($wo['config']['donate_percentage']) && is_numeric($wo['config']['donate_percentage']) && $wo['config']['donate_percentage'] > 0) {
                    $admin_com = ($wo['config']['donate_percentage'] * $amount) / 100;
                    $amount    = $amount - $admin_com;
                }
                $user_data = Wo_UserData($fund->user_id);
                $db->where('user_id', $fund->user_id)->update(T_USERS, array(
                    'balance' => $user_data['balance'] + $amount
                ));
                $fund_raise_id           = $db->insert(T_FUNDING_RAISE, array(
                    'user_id' => $wo['user']['user_id'],
                    'funding_id' => $fund_id,
                    'amount' => $amount,
                    'time' => time()
                ));
                $post_data               = array(
                    'user_id' => Wo_Secure($wo['user']['user_id']),
                    'fund_raise_id' => $fund_raise_id,
                    'time' => time(),
                    'multi_image_post' => 0
                );
                $id                      = Wo_RegisterPost($post_data);
                $notification_data_array = array(
                    'recipient_id' => $fund->user_id,
                    'type' => 'fund_donate',
                    'url' => 'index.php?link1=show_fund&id=' . $fund->hashed_id
                );
                Wo_RegisterNotification($notification_data_array);
                header("Location: " . $config['site_url'] . "/show_fund/" . $fund->hashed_id);
                exit();
            }
            catch (Exception $e) {
                header("Location: " . Wo_SeoLink('index.php?link1=oops'));
                exit();
            }
        } else {
            header("Location: " . Wo_SeoLink('index.php?link1=oops'));
            exit();
        }
    }
    if ($s == 'stripe' && $wo['config']['credit_card'] != 'no' && !empty($_POST['fund_id']) && is_numeric($_POST['fund_id']) && $_POST['fund_id'] > 0 && !empty($_POST['amount']) && is_numeric($_POST['amount']) && $_POST['amount'] > 0) {
        include_once('assets/includes/stripe_config.php');
        $fund_id = Wo_Secure($_POST['fund_id']);
        $amount  = Wo_Secure($_POST['amount']);
        $fund    = $db->where('id', $fund_id)->getOne(T_FUNDING);
        if (empty($_POST['stripeToken']) || empty($fund)) {
            header("Location: " . Wo_SeoLink('index.php?link1=oops'));
            exit();
        }
        $token = $_POST['stripeToken'];
        try {
            $customer     = \Stripe\Customer::create(array(
                'source' => $token
            ));
            $final_amount = $amount * 100;
            $charge       = \Stripe\Charge::create(array(
                'customer' => $customer->id,
                'amount' => $final_amount,
                'currency' => $wo['config']['stripe_currency']
            ));
            if ($charge) {
                $notes              = "Doanted to " . mb_substr($fund->title, 0, 100, "UTF-8");
                $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'DONATE', {$amount}, '{$notes}')");
                $admin_com          = 0;
                if (!empty($wo['config']['donate_percentage']) && is_numeric($wo['config']['donate_percentage']) && $wo['config']['donate_percentage'] > 0) {
                    $admin_com = ($wo['config']['donate_percentage'] * $amount) / 100;
                    $amount    = $amount - $admin_com;
                }
                $user_data = Wo_UserData($fund->user_id);
                $db->where('user_id', $fund->user_id)->update(T_USERS, array(
                    'balance' => $user_data['balance'] + $amount
                ));
                $fund_raise_id           = $db->insert(T_FUNDING_RAISE, array(
                    'user_id' => $wo['user']['user_id'],
                    'funding_id' => $fund_id,
                    'amount' => $amount,
                    'time' => time()
                ));
                $post_data               = array(
                    'user_id' => Wo_Secure($wo['user']['user_id']),
                    'fund_raise_id' => $fund_raise_id,
                    'time' => time(),
                    'multi_image_post' => 0
                );
                $id                      = Wo_RegisterPost($post_data);
                $notification_data_array = array(
                    'recipient_id' => $fund->user_id,
                    'type' => 'fund_donate',
                    'url' => 'index.php?link1=show_fund&id=' . $fund->hashed_id
                );
                Wo_RegisterNotification($notification_data_array);
                $data = array(
                    'status' => 200,
                    'location' => $config['site_url'] . "/show_fund/" . $fund->hashed_id
                );
            }
        }
        catch (Exception $e) {
            $data = array(
                'status' => 400,
                'error' => $e->getMessage()
            );
            header("Content-type: application/json");
            echo json_encode($data);
            exit();
        }
    }
    if ($s == 'bank') {
        $request   = array();
        $request[] = (empty($_FILES["thumbnail"]));
        if (in_array(true, $request) || empty($_POST['price']) || !is_numeric($_POST['price']) || $_POST['price'] < 1 || empty($_POST['fund_id']) || !is_numeric($_POST['fund_id']) || $_POST['fund_id'] < 1) {
            $error = $error_icon . $wo['lang']['please_check_details'];
        }
        $fund_id = Wo_Secure($_POST['fund_id']);
        $amount  = Wo_Secure($_POST['price']);
        $fund    = $db->where('id', $fund_id)->getOne(T_FUNDING);
        if (empty($error) && !empty($fund)) {
            $description = "Doante to " . mb_substr($fund->title, 0, 100, "UTF-8");
            ;
            $fileInfo      = array(
                'file' => $_FILES["thumbnail"]["tmp_name"],
                'name' => $_FILES['thumbnail']['name'],
                'size' => $_FILES["thumbnail"]["size"],
                'type' => $_FILES["thumbnail"]["type"],
                'types' => 'jpeg,jpg,png,bmp,gif'
            );
            $media         = Wo_ShareFile($fileInfo);
            $mediaFilename = $media['filename'];
            if (!empty($mediaFilename)) {
                $insert_id = Wo_InsertBankTrnsfer(array(
                    'user_id' => $wo['user']['id'],
                    'description' => $description,
                    'price' => $amount,
                    'receipt_file' => $mediaFilename,
                    'mode' => 'donate',
                    'fund_id' => $fund_id
                ));
                if (!empty($insert_id)) {
                    $data = array(
                        'message' => $success_icon . $wo['lang']['bank_transfer_request'],
                        'status' => 200
                    );
                }
            } else {
                $error = $error_icon . $wo['lang']['file_not_supported'];
                $data  = array(
                    'status' => 500,
                    'message' => $error
                );
            }
        } else {
            $data = array(
                'status' => 500,
                'message' => $error
            );
        }
    }
    if ($s == '2checkout') {
        if (empty($_POST['card_number']) || empty($_POST['card_cvc']) || empty($_POST['card_month']) || empty($_POST['card_year']) || empty($_POST['token']) || empty($_POST['card_name']) || empty($_POST['card_address']) || empty($_POST['card_city']) || empty($_POST['card_state']) || empty($_POST['card_zip']) || empty($_POST['card_country']) || empty($_POST['card_email']) || empty($_POST['card_phone']) || empty($_POST['amount']) || empty($_POST['fund_id'])) {
            $data = array(
                'status' => 400,
                'error' => $wo['lang']['please_check_details']
            );
        } else {
            $fund_id = Wo_Secure($_POST['fund_id']);
            $amount  = Wo_Secure($_POST['amount']);
            $fund    = $db->where('id', $fund_id)->getOne(T_FUNDING);
            if (!empty($fund)) {
                require_once 'assets/libraries/2checkout/Twocheckout.php';
                Twocheckout::privateKey($wo['config']['checkout_private_key']);
                Twocheckout::sellerId($wo['config']['checkout_seller_id']);
                if ($wo['config']['checkout_mode'] == 'sandbox') {
                    Twocheckout::sandbox(true);
                } else {
                    Twocheckout::sandbox(false);
                }
                try {
                    $amount1 = $_POST['amount'];
                    $charge  = Twocheckout_Charge::auth(array(
                        "merchantOrderId" => "123",
                        "token" => $_POST['token'],
                        "currency" => $wo['config']['2checkout_currency'],
                        "total" => $amount1,
                        "billingAddr" => array(
                            "name" => $_POST['card_name'],
                            "addrLine1" => $_POST['card_address'],
                            "city" => $_POST['card_city'],
                            "state" => $_POST['card_state'],
                            "zipCode" => $_POST['card_zip'],
                            "country" => $wo['countries_name'][$_POST['card_country']],
                            "email" => $_POST['card_email'],
                            "phoneNumber" => $_POST['card_phone']
                        )
                    ));
                    if ($charge['response']['responseCode'] == 'APPROVED') {
                        Wo_UpdateUserData($wo['user']['id'], array(
                            'address' => Wo_Secure($_POST['card_address']),
                            'city' => Wo_Secure($_POST['card_city']),
                            'state' => Wo_Secure($_POST['card_state']),
                            'zip' => Wo_Secure($_POST['card_zip'])
                        ));
                        $notes              = "Doanted to " . mb_substr($fund->title, 0, 100, "UTF-8");
                        $create_payment_log = mysqli_query($sqlConnect, "INSERT INTO " . T_PAYMENT_TRANSACTIONS . " (`userid`, `kind`, `amount`, `notes`) VALUES ({$wo['user']['user_id']}, 'DONATE', {$amount}, '{$notes}')");
                        $admin_com          = 0;
                        if (!empty($wo['config']['donate_percentage']) && is_numeric($wo['config']['donate_percentage']) && $wo['config']['donate_percentage'] > 0) {
                            $admin_com = ($wo['config']['donate_percentage'] * $amount) / 100;
                            $amount    = $amount - $admin_com;
                        }
                        $user_data = Wo_UserData($fund->user_id);
                        $db->where('user_id', $fund->user_id)->update(T_USERS, array(
                            'balance' => $user_data['balance'] + $amount
                        ));
                        $fund_raise_id           = $db->insert(T_FUNDING_RAISE, array(
                            'user_id' => $wo['user']['user_id'],
                            'funding_id' => $fund_id,
                            'amount' => $amount,
                            'time' => time()
                        ));
                        $post_data               = array(
                            'user_id' => Wo_Secure($wo['user']['user_id']),
                            'fund_raise_id' => $fund_raise_id,
                            'time' => time(),
                            'multi_image_post' => 0
                        );
                        $id                      = Wo_RegisterPost($post_data);
                        $notification_data_array = array(
                            'recipient_id' => $fund->user_id,
                            'type' => 'fund_donate',
                            'url' => 'index.php?link1=show_fund&id=' . $fund->hashed_id
                        );
                        Wo_RegisterNotification($notification_data_array);
                        $data = array(
                            'status' => 200,
                            'location' => $config['site_url'] . "/show_fund/" . $fund->hashed_id
                        );
                    } else {
                        $data = array(
                            'status' => 400,
                            'error' => $wo['lang']['2checkout_declined']
                        );
                        header("Content-type: application/json");
                        echo json_encode($data);
                        exit();
                    }
                }
                catch (Twocheckout_Error $e) {
                    $data = array(
                        'status' => 400,
                        'error' => $e->getMessage()
                    );
                }
            }
        }
    }
}
header("Content-type: application/json");
echo json_encode($data);
exit();
