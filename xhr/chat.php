<?php
if ($f == 'chat') {
    if ($s == 'get_group_info') {
        $group_id  = Wo_Secure($_GET['group_id']);
        $group_tab = Wo_GroupTabData($group_id);
        if ($group_tab && is_array($group_tab)) {
            $wo['chat']['group']           = $group_tab;
            $wo['chat']['group']['avatar'] = $wo['config']['site_url'] . '/' . $wo['chat']['group']['avatar'];
            unset($wo['chat']['group']['messages']);
            $data = array(
                'status' => 200,
                'group' => $wo['chat']['group']
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'edit_group') {
        $data['status'] = 400;
        $group_id       = $id = Wo_Secure($_POST['group_id']);
        $group_tab      = Wo_GroupTabData($group_id);
        $error          = '';
        if ($group_tab && is_array($group_tab)) {
            if (!empty($_POST['group_name']) && (strlen($_POST['group_name']) < 4 || strlen($_POST['group_name']) > 15)) {
                $error           = true;
                $data['message'] = $error_icon . $wo['lang']['group_name_limit'];
            }
            if (!empty($_FILES["avatar"]) && isset($_FILES["avatar"])) {
                if (file_exists($_FILES["avatar"]["tmp_name"])) {
                    $image = getimagesize($_FILES["avatar"]["tmp_name"]);
                    if (!in_array($image[2], array(
                        IMAGETYPE_GIF,
                        IMAGETYPE_JPEG,
                        IMAGETYPE_PNG,
                        IMAGETYPE_BMP
                    ))) {
                        $error           = true;
                        $data['message'] = $error_icon . $wo['lang']['group_avatar_image'];
                    }
                }
            }
            if (!$error) {
                $update_data = array();
                if (!empty($_POST['group_name'])) {
                    $update_data['group_name'] = Wo_Secure($_POST['group_name']);
                }
                if (isset($_FILES["avatar"]["tmp_name"])) {
                    $fileInfo              = array(
                        'file' => $_FILES["avatar"]["tmp_name"],
                        'name' => $_FILES['avatar']['name'],
                        'size' => $_FILES["avatar"]["size"],
                        'type' => $_FILES["avatar"]["type"],
                        'types' => 'jpg,png,bmp,gif',
                        'compress' => false,
                        'crop' => array(
                            'width' => 70,
                            'height' => 70
                        )
                    );
                    $media                 = Wo_ShareFile($fileInfo);
                    $mediaFilename         = $media['filename'];
                    $update_data['avatar'] = $mediaFilename;
                }
                if (!empty($update_data)) {
                    @Wo_UpdateGChat($id, $update_data);
                    $data = array(
                        'status' => 200
                    );
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'count_online_users') {
        $html = Wo_CountOnlineUsers();
        $data = array(
            'status' => 200,
            'html' => $html
        );
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'chat_side') {
        if (Wo_CheckMainSession($hash_id) === true) {
            $online_users  = '';
            $offline_users = '';
            $OnlineUsers   = Wo_GetChatUsers('online');
            $OfflineUsers  = Wo_GetChatUsers('offline');
            $count_chat    = Wo_CountOnlineUsers();
            foreach ($OnlineUsers as $wo['chatList']) {
                $online_users .= Wo_LoadPage('chat/online-user');
            }
            foreach ($OfflineUsers as $wo['chatList']) {
                $offline_users .= Wo_LoadPage('chat/offline-user');
            }
            $data = array(
                'status' => 200,
                'online_users' => $online_users,
                'offline_users' => $offline_users,
                'count_chat' => $count_chat
            );
            if (!empty($_GET['user_id'])) {
                $user_id = Wo_Secure($_GET['user_id']);
                if (!empty($user_id)) {
                    $user_id = $_GET['user_id'];
                    $status  = Wo_IsOnline($user_id);
                    if ($status === true) {
                        $data['chat_user_tab'] = 200;
                    } else {
                        $data['chat_user_tab'] = 300;
                    }
                }
            }
            $data['messages'] = 0;
            $reactions        = array();
            if (!empty($_GET['user_id']) && isset($_GET['message_id'])) {
                $html    = '';
                $user_id = Wo_Secure($_GET['user_id']);
                if (!empty($user_id)) {
                    $user_id  = $_GET['user_id'];
                    $messages = Wo_GetMessages(array(
                        'after_message_id' => $_GET['message_id'],
                        'user_id' => $user_id,
                        'type' => 'user',
                        'not_seen' => 1
                    ));
                    if (count($messages) > 0) {
                        $messages_html = '';
                        foreach ($messages as $wo['chatMessage']) {
                            $messages_html .= Wo_LoadPage('chat/chat-list');
                        }
                        $data['chat_user_tab'] = 200;
                        $data['messages']      = 200;
                        $data['messages_html'] = $messages_html;
                        $data['receiver']      = $wo['user']['user_id'];
                        $data['sender']        = $user_id;
                    }
                    $reacted_messages = $db->where("message_id IN (SELECT m.id FROM " . T_MESSAGES . " m WHERE (m.from_id = '" . $user_id . "' AND m.to_id = '" . $wo['user']['user_id'] . "') OR (m.from_id = '" . $wo['user']['user_id'] . "' AND m.to_id = '" . $user_id . "'))")->orderBy("id", "Desc")->get(T_REACTIONS, 20);
                    foreach ($reacted_messages as $key => $value) {
                        $reactions[] = array(
                            'id' => $value->message_id,
                            'reactions' => Wo_GetPostReactions($value->message_id, 'message')
                        );
                    }
                    if (!empty($reactions)) {
                        $data['reactions'] = $reactions;
                    }
                }
            }
            $wo['chat']['color'] = Wo_GetChatColor($wo['user']['user_id'], $_GET['user_id']);
            $data['chat_color']  = $wo['chat']['color'];
            $data['can_seen']    = 0;
            if (!empty($_GET['last_id']) && $wo['config']['message_seen'] == 1) {
                $message_id = Wo_Secure($_GET['last_id']);
                if (!empty($message_id) || is_numeric($message_id) || $message_id > 0) {
                    $seen = Wo_SeenMessage($message_id);
                    if ($seen > 0) {
                        $data['can_seen'] = 1;
                        $data['time']     = $seen['time'];
                        $data['seen']     = $seen['seen'];
                    }
                }
            }
            $data['is_typing'] = 0;
            if (!empty($_GET['user_id']) && $wo['config']['message_typing'] == 1) {
                $isTyping = Wo_IsTyping($_GET['user_id']);
                if ($isTyping === true) {
                    $img               = Wo_UserData($_GET['user_id']);
                    $data['is_typing'] = 200;
                    $data['img']       = $img['avatar'];
                    $data['typing']    = $wo['config']['theme_url'] . '/img/loading_dots.gif';
                }
            }
            if (isset($_GET['last_group']) && is_numeric($_GET['last_group'])) {
                $new_groups = Wo_GetChatGroups();
                $groups     = '';
                if (is_array($new_groups) && count($new_groups) > 0) {
                    foreach ($new_groups as $wo['group']) {
                        $groups .= Wo_LoadPage('chat/group-list');
                    }
                }
                $data['chat_groups']         = $groups;
                $data['update_group_status'] = Wo_CheckLastGroupAction();
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'is_recipient_typing') {
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'recipient_is_typing') {
        if (!empty($_GET['recipient_id'])) {
            $isTyping = Wo_RegisterTyping($_GET['recipient_id'], 1);
            if ($isTyping === true) {
                $data = array(
                    'status' => 200
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'remove_typing') {
        if (!empty($_GET['recipient_id'])) {
            $isTyping = Wo_RegisterTyping($_GET['recipient_id'], 0);
            if ($isTyping === true) {
                $data = array(
                    'status' => 200
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update_online_recipients') {
        $html        = '';
        $OnlineUsers = Wo_GetChatUsers('online');
        foreach ($OnlineUsers as $wo['chatList']) {
            $html .= Wo_LoadPage('chat/online-user');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update_offline_recipients') {
        $html         = '';
        $OfflineUsers = Wo_GetChatUsers('offline');
        foreach ($OfflineUsers as $wo['chatList']) {
            $html .= Wo_LoadPage('chat/offline-user');
        }
        $data = array(
            'status' => 200,
            'html' => $html
        );
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'set-chat-color') {
        $recipient_user = false;
        $color          = false;
        $user_id        = false;
        $data           = array(
            'status' => 500
        );
        if (isset($_GET['recipient_user']) && is_numeric($_GET['recipient_user']) && $_GET['recipient_user'] > 0) {
            $recipient_user = Wo_Secure($_GET['recipient_user']);
        }
        if (isset($_GET['color']) && in_array($_GET['color'], $colors)) {
            $color = $_GET['color'];
        }
        if (isset($wo['user']['id'])) {
            $user_id = $wo['user']['id'];
        }
        $page_id = 0;
        if (!empty($_GET['page_id']) && is_numeric($_GET['page_id']) && $_GET['page_id'] > 0) {
            $page_id = Wo_Secure($_GET['page_id']);
        }
        if ($user_id && $color && $recipient_user) {
            if (Wo_UpdateChatColor($user_id, $recipient_user, $color, $page_id)) {
                $data = array(
                    'status' => 200,
                    'message' => "color added",
                    'color' => $color
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'search_for_recipients') {
        if (!empty($_POST['search_query'])) {
            $html   = '';
            $search = Wo_ChatSearchUsers($_POST['search_query']);
            foreach ($search as $wo['chatList']) {
                $html .= Wo_LoadPage('chat/search-result');
            }
            $data = array(
                'status' => 200,
                'html' => $html
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update_chat_status') {
        if (!empty($_POST['status'])) {
            $html   = '';
            $status = Wo_UpdateStatus($_POST['status']);
            if ($status == 0) {
                $data = array(
                    'status' => $status
                );
            } else if ($status == 1) {
                $data = array(
                    'status' => $status
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'load_chat_tab') {
        if ($wo['user']['message_privacy'] != 2) {
            if (!empty($_GET['recipient_id']) && is_numeric($_GET['recipient_id']) && $_GET['recipient_id'] > 0 && !empty($_GET['placement'])) {
                if (Wo_IsBlocked($_GET['recipient_id'])) {
                    $data = array(
                        'status' => 400
                    );
                } else {
                    if ($_GET['recipient_id'] != 0) {
                        $recipient_id = Wo_Secure($_GET['recipient_id']);
                        $recipient    = Wo_UserData($recipient_id);
                        if ($recipient['message_privacy'] != 2) {
                            if (isset($recipient['user_id'])) {
                                $wo['chat']['recipient'] = $recipient;
                                $wo['chat']['color']     = Wo_GetChatColor($wo['user']['user_id'], $recipient['user_id']);
                                $wo['chat']['story_id']  = 0;
                                if (!empty($_GET['story_id']) && is_numeric($_GET['story_id']) && $_GET['story_id'] > 0) {
                                    $wo['chat']['story_id'] = Wo_Secure($_GET['story_id']);
                                }
                                $data = array(
                                    'status' => 200,
                                    'html' => Wo_LoadPage('chat/chat-tab')
                                );
                                if (isset($_SESSION['chat_id'])) {
                                    if (strpos($_SESSION['chat_id'], ',') !== false) {
                                        $explode = @explode(',', $_SESSION['chat_id']);
                                        if (count($explode) > 2) {
                                            if (strpos($_SESSION['chat_id'], $recipient['user_id']) === false) {
                                                $_SESSION['chat_id'] = substr($_SESSION['chat_id'], 0, strrpos($_SESSION['chat_id'], ','));
                                                $_SESSION['chat_id'] .= ',' . Wo_Secure($recipient['user_id']);
                                            }
                                        } else {
                                            $_SESSION['chat_id'] .= ',' . Wo_Secure($recipient['user_id']);
                                        }
                                    } else if (strpos($_SESSION['chat_id'], $recipient['user_id']) === false) {
                                        $_SESSION['chat_id'] .= ',' . Wo_Secure($recipient['user_id']);
                                    } else {
                                        $_SESSION['chat_id'] = Wo_Secure($recipient['user_id']);
                                    }
                                } else {
                                    $_SESSION['chat_id'] = Wo_Secure($recipient['user_id']);
                                }
                            }
                        } else {
                            $data = array(
                                'status' => 400
                            );
                        }
                    }
                }
            } else if (isset($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
                $group_id = Wo_Secure($_GET['group_id']);
                if (Wo_IsGChatOwner($group_id) || Wo_IsGChatMemebers($group_id)) {
                    $group_tab = Wo_GroupTabData($group_id);
                    if ($group_tab && is_array($group_tab)) {
                        $wo['chat']['group']  = $group_tab;
                        $data                 = array(
                            'status' => 200,
                            'html' => Wo_LoadPage('chat/group-tab')
                        );
                        $_SESSION['group_id'] = $group_id;
                    }
                }
            } else if (isset($_GET['page_id']) && is_numeric($_GET['page_id']) && $_GET['page_id'] > 0) {
                $page_id  = Wo_Secure($_GET['page_id']);
                $page_tab = Wo_PageData($page_id);
                if (!empty($page_tab) && is_array($page_tab)) {
                    if ($wo['user']['user_id'] == $_GET['page_user_id'] || $wo['user']['user_id'] == $page_tab['user_id']) {
                        $wo['chat']['page']             = $page_tab;
                        $wo['chat']['page']['messages'] = Wo_GetPageMessages(array(
                            'page_id' => $page_id,
                            'from_id' => $page_tab['user_id'],
                            'to_id' => !empty($_GET['page_user_id']) ? Wo_Secure($_GET['page_user_id']) : 0
                        ));
                        $wo['chat']['from_id']          = !empty($_GET['from_id']) ? Wo_Secure($_GET['from_id']) : 0;
                        $wo['chat']['to_id']            = !empty($_GET['page_user_id']) ? Wo_Secure($_GET['page_user_id']) : 0;
                        $wo['chat']['user']             = Wo_UserData($wo['chat']['to_id']);
                        $wo['chat']['color']            = Wo_GetChatColor($wo['user']['user_id'], $wo['chat']['user']['user_id'], $page_id);
                        $data                           = array(
                            'status' => 200,
                            'html' => Wo_LoadPage('chat/page-tab')
                        );
                        $_SESSION['page_id']            = $page_id;
                    }
                }
            }
        } else {
            $data = array(
                'status' => 400
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'load_chat_messages') {
        if (!empty($_GET['recipient_id']) && is_numeric($_GET['recipient_id']) && $_GET['recipient_id'] > 0 && Wo_CheckMainSession($hash_id) === true) {
            $recipient_id = Wo_Secure($_GET['recipient_id']);
            if (!empty($_GET['product_id']) && is_numeric($_GET['product_id']) && $_GET['product_id'] > 0) {
                $messages = Wo_RegisterMessage(array(
                    'from_id' => Wo_Secure($wo['user']['user_id']),
                    'to_id' => $recipient_id,
                    'time' => time(),
                    'stickers' => '',
                    'product_id' => Wo_Secure($_GET['product_id'])
                ));
            }
            $html                = '';
            $messages            = Wo_GetMessages(array(
                'user_id' => $recipient_id,
                'type' => 'user'
            ));
            $wo['chat']['color'] = Wo_GetChatColor($wo['user']['user_id'], $recipient_id);
            foreach ($messages as $wo['chatMessage']) {
                $html .= Wo_LoadPage('chat/chat-list');
            }
            $data = array(
                'status' => 200,
                'messages' => $html
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'open_tab') {
        if (isset($_SESSION['open_chat'])) {
            if ($_SESSION['open_chat'] == 1) {
                $_SESSION['open_chat'] = 0;
            } else if ($_SESSION['open_chat'] == 0) {
                $_SESSION['open_chat'] = 1;
            }
        } else {
            $_SESSION['open_chat'] = 1;
        }
    }
    if ($s == 'send_message') {
        $reply_id = 0;
        if (!empty($_POST['reply_id']) && is_numeric($_POST['reply_id']) && $_POST['reply_id'] > 0) {
            $me                    = Wo_Secure($wo['user']['user_id']);
            $him                   = Wo_Secure($_POST['user_id']);
            $reply_id              = Wo_Secure($_POST['reply_id']);
            $can_reply_to_messages = $db->where("((to_id = ? AND from_id = ?)", array(
                $me,
                $him
            ))->orWhere("(to_id = ? AND from_id = ?))", array(
                $him,
                $me
            ))->where('id', $reply_id)->getOne(T_MESSAGES, 'id');
            if (empty($can_reply_to_messages->id)) {
                $reply_id = 0;
            }
        }
        if ($wo['config']['who_upload'] == 'pro' && $wo['user']['is_pro'] == 0 && !Wo_IsAdmin() && (!empty($_FILES['sendMessageFile']) || !empty($_POST['message-record']))) {
            $data['status']       = 500;
            $data['invalid_file'] = 3;
        } else {
            if ($wo['user']['message_privacy'] != 2) {
                if (!empty($_POST['user_id']) && Wo_CheckMainSession($hash_id) === true) {
                    $html          = '';
                    $media         = '';
                    $mediaFilename = '';
                    $mediaName     = '';
                    $invalid_file  = 0;
                    if (isset($_FILES['sendMessageFile']['name'])) {
                        if ($_FILES['sendMessageFile']['size'] > $wo['config']['maxUpload']) {
                            $invalid_file = 1;
                        } else if (Wo_IsFileAllowed($_FILES['sendMessageFile']['name']) == false) {
                            $invalid_file = 2;
                        } else {
                            $fileInfo      = array(
                                'file' => $_FILES["sendMessageFile"]["tmp_name"],
                                'name' => $_FILES['sendMessageFile']['name'],
                                'size' => $_FILES["sendMessageFile"]["size"],
                                'type' => $_FILES["sendMessageFile"]["type"]
                            );
                            $media         = Wo_ShareFile($fileInfo);
                            $mediaFilename = $media['filename'];
                            $mediaName     = $media['name'];
                        }
                    } else if (!empty($_POST['message-record']) && !empty($_POST['media-name'])) {
                        $mediaFilename = Wo_Secure($_POST['message-record']);
                        $mediaName     = Wo_Secure($_POST['media-name']);
                    }
                    $message_text = '';
                    if (!empty($_POST['textSendMessage'])) {
                        $message_text = $_POST['textSendMessage'];
                    }
                    $user_data = Wo_UserData($_POST['user_id']);
                    if (!empty($user_data) && $user_data['message_privacy'] == 2) {
                        exit();
                    }
                    if (!empty($user_data) && $user_data['message_privacy'] == 1 && Wo_IsFollowing($wo['user']['user_id'], $_POST['user_id']) === false) {
                        exit();
                    }
                    $is_sticker = ((isset($_POST['chatSticker']) && Wo_IsUrl($_POST['chatSticker']) && strpos($_POST['chatSticker'], '.gif') !== false && !$mediaFilename && !$mediaName) ? true : false);
                    if (!empty($_POST['chatSticker']) && !strpos($_POST['chatSticker'], '.gif')) {
                        $fileend       = '_sticker_' . rand(111111, 999999);
                        $mediaFilename = Wo_ImportImageFromUrl($_POST['chatSticker'], $fileend);
                        $is_sticker    = true;
                    } elseif (!empty($_POST['chatSticker']) && strpos($_POST['chatSticker'], '.gif')) {
                        $_POST['chatSticker'] = preg_replace('/on[^<>=]+=[^<>]*/m', '', $_POST['chatSticker']);
                        $_POST['chatSticker'] = preg_replace('/\((.*?)\)/m', '', $_POST['chatSticker']);
                        $_POST['chatSticker'] = strip_tags($_POST['chatSticker']);
                        $re  = '/(http|https):\/\/(.*)\.giphy\.com\/media\/(.*)\/(.*)\.gif\?(.*)/';
                        $str = $_POST['chatSticker'];
                        preg_match($re, $str, $matches, PREG_OFFSET_CAPTURE, 0);
                        if (!empty($matches) && !empty($matches[2]) && !empty($matches[2][0]) && !empty($matches[3]) && !empty($matches[3][0]) && !empty($matches[4]) && !empty($matches[4][0])) {
                            $_POST['chatSticker'] = "https://" . $matches[2][0] . ".giphy.com/media/" . $matches[3][0] . "/" . $matches[4][0] . ".gif";
                            $headers              = get_headers($_POST['chatSticker'], 1);
                            if (strpos($headers['Content-Type'], 'image/') !== false) {
                            } else {
                                $invalid_file         = 2;
                                $_POST['chatSticker'] = '';
                            }
                        } else {
                            $_POST['chatSticker'] = '';
                            $invalid_file         = 2;
                        }
                    }
                    $story_id = 0;
                    if (!empty($_POST['story_id']) && is_numeric($_POST['story_id']) && $_POST['story_id'] > 0) {
                        $story_id = Wo_Secure($_POST['story_id']);
                        $story    = $db->where('user_id', Wo_Secure($_POST['user_id']))->where('id', $story_id)->getValue(T_USER_STORY, 'COUNT(*)');
                        if ($story > 0) {
                            $story_id = Wo_Secure($_POST['story_id']);
                        } else {
                            $story_id = 0;
                        }
                    }
                    $messages = Wo_RegisterMessage(array(
                        'from_id' => Wo_Secure($wo['user']['user_id']),
                        'to_id' => Wo_Secure($_POST['user_id']),
                        'text' => Wo_Secure($message_text),
                        'media' => Wo_Secure($mediaFilename),
                        'mediaFileName' => Wo_Secure($mediaName),
                        'time' => time(),
                        'stickers' => (isset($_POST['chatSticker']) && Wo_IsUrl($_POST['chatSticker']) && strpos($_POST['chatSticker'], '.gif') !== false && !$mediaFilename && !$mediaName) ? $_POST['chatSticker'] : '',
                        'reply_id' => $reply_id,
                        'story_id' => $story_id
                    ));
                    if ($messages > 0) {
                        $messages            = Wo_GetMessages(array(
                            'message_id' => $messages,
                            'user_id' => $_POST['user_id']
                        ));
                        $wo['chat']['color'] = Wo_GetChatColor($wo['user']['user_id'], $_POST['user_id']);
                        foreach ($messages as $wo['chatMessage']) {
                            $html .= Wo_LoadPage('chat/chat-list');
                        }
                        $file = false;
                        if (isset($_FILES['sendMessageFile']['name']) && $_FILES['sendMessageFile']['size'] <= $wo['config']['maxUpload']) {
                            $file = true;
                        }
                        $data = array(
                            'status' => 200,
                            'html' => $html,
                            'file' => $file,
                            'stickers' => $is_sticker,
                            'invalid_file' => $invalid_file
                        );
                        if ($wo['config']['emailNotification'] == 1) {
                            $to_id        = $_POST['user_id'];
                            $recipient    = Wo_UserData($to_id);
                            $send_notif   = array();
                            $send_notif[] = (!empty($recipient) && ($recipient['lastseen'] < (time() - 120)));
                            $send_notif[] = ($recipient['e_last_notif'] < time() && $recipient['e_sentme_msg'] == 1);
                            if (!in_array(false, $send_notif)) {
                                $db->where("user_id", $to_id)->update(T_USERS, array(
                                    'e_last_notif' => (time() + 3600)
                                ));
                                $wo['emailNotification']['notifier'] = $wo['user'];
                                $wo['emailNotification']['type']     = 'sent_message';
                                $wo['emailNotification']['url']      = $recipient['url'];
                                $wo['emailNotification']['msg_text'] = Wo_Secure($message_text);
                                $send_message_data                   = array(
                                    'from_email' => $wo['config']['siteEmail'],
                                    'from_name' => $wo['config']['siteName'],
                                    'to_email' => $recipient['email'],
                                    'to_name' => $recipient['name'],
                                    'subject' => 'New notification',
                                    'charSet' => 'utf-8',
                                    'message_body' => Wo_LoadPage('emails/notifiction-email'),
                                    'is_html' => true
                                );
                                if ($wo['config']['smtp_or_mail'] == 'smtp') {
                                    $send_message_data['insert_database'] = 1;
                                }
                                Wo_SendMessage($send_message_data);
                            }
                        }
                    }
                    if ($invalid_file > 0 && empty($messages)) {
                        $data['status']       = 500;
                        $data['invalid_file'] = $invalid_file;
                    }
                } else if (isset($_GET['group_id']) && is_numeric($_GET['group_id']) && Wo_CheckMainSession($hash_id) === true) {
                    $html          = '';
                    $media         = '';
                    $mediaFilename = '';
                    $mediaName     = '';
                    $invalid_file  = 0;
                    if (isset($_FILES['sendMessageFile']['name'])) {
                        if ($_FILES['sendMessageFile']['size'] > $wo['config']['maxUpload']) {
                            $invalid_file = 1;
                        } else if (Wo_IsFileAllowed($_FILES['sendMessageFile']['name']) == false) {
                            $invalid_file = 2;
                        } else {
                            $fileInfo      = array(
                                'file' => $_FILES["sendMessageFile"]["tmp_name"],
                                'name' => $_FILES['sendMessageFile']['name'],
                                'size' => $_FILES["sendMessageFile"]["size"],
                                'type' => $_FILES["sendMessageFile"]["type"]
                            );
                            $media         = Wo_ShareFile($fileInfo);
                            $mediaFilename = $media['filename'];
                            $mediaName     = $media['name'];
                        }
                    }
                    $message_text = '';
                    if (!empty($_POST['textSendMessage'])) {
                        $message_text = $_POST['textSendMessage'];
                    }
                    $last_id = Wo_RegisterGroupMessage(array(
                        'from_id' => Wo_Secure($wo['user']['user_id']),
                        'group_id' => Wo_Secure($_GET['group_id']),
                        'text' => Wo_Secure($_POST['textSendMessage']),
                        'media' => Wo_Secure($mediaFilename),
                        'mediaFileName' => Wo_Secure($mediaName),
                        'time' => time(),
                        'reply_id' => $reply_id
                    ));
                    if ($last_id && $last_id > 0) {
                        @Wo_UpdateGChat(Wo_Secure($_GET['group_id']), array(
                            "time" => time()
                        ));
                        $messages = Wo_GetGroupMessages(array(
                            'id' => $last_id,
                            'group_id' => $_GET['group_id']
                        ));
                        foreach ($messages as $wo['chatMessage']) {
                            $html .= Wo_LoadPage('chat/group-chat-list');
                        }
                        $file = false;
                        if (isset($_FILES['sendMessageFile']['name'])) {
                            $file = true;
                        }
                        $data = array(
                            'status' => 200,
                            'html' => $html,
                            'file' => $file,
                            'invalid_file' => $invalid_file
                        );
                    }
                    if ($invalid_file > 0 && empty($last_id)) {
                        $data['status']       = 500;
                        $data['invalid_file'] = $invalid_file;
                    }
                } else if (isset($_GET['page_id']) && is_numeric($_GET['page_id']) && Wo_CheckMainSession($hash_id) === true) {
                    $page_data    = Wo_PageData($_GET['page_id']);
                    $invalid_file = 1;
                    if (!empty($page_data)) {
                        $html          = '';
                        $media         = '';
                        $mediaFilename = '';
                        $mediaName     = '';
                        $invalid_file  = 0;
                        if (isset($_FILES['sendMessageFile']['name'])) {
                            if ($_FILES['sendMessageFile']['size'] > $wo['config']['maxUpload']) {
                                $invalid_file = 1;
                            } else if (Wo_IsFileAllowed($_FILES['sendMessageFile']['name']) == false) {
                                $invalid_file = 2;
                            } else {
                                $fileInfo      = array(
                                    'file' => $_FILES["sendMessageFile"]["tmp_name"],
                                    'name' => $_FILES['sendMessageFile']['name'],
                                    'size' => $_FILES["sendMessageFile"]["size"],
                                    'type' => $_FILES["sendMessageFile"]["type"]
                                );
                                $media         = Wo_ShareFile($fileInfo);
                                $mediaFilename = $media['filename'];
                                $mediaName     = $media['name'];
                            }
                        } else if (!empty($_POST['message-record']) && !empty($_POST['media-name'])) {
                            $mediaFilename = Wo_Secure($_POST['message-record']);
                            $mediaName     = Wo_Secure($_POST['media-name']);
                        }
                        $message_text = '';
                        if (!empty($_POST['textSendMessage'])) {
                            $message_text = $_POST['textSendMessage'];
                        }
                        $to_id = $page_data['user_id'];
                        if ($page_data['user_id'] == $wo['user']['user_id']) {
                            if ($page_data['user_id'] == $_GET['to_id']) {
                                $to_id = Wo_Secure($_GET['from_id']);
                            } else {
                                $to_id = Wo_Secure($_GET['to_id']);
                            }
                        }
                        $last_id = Wo_RegisterPageMessage(array(
                            'from_id' => Wo_Secure($wo['user']['user_id']),
                            'page_id' => Wo_Secure($_GET['page_id']),
                            'to_id' => $to_id,
                            'text' => Wo_Secure($_POST['textSendMessage']),
                            'media' => Wo_Secure($mediaFilename),
                            'mediaFileName' => Wo_Secure($mediaName),
                            'time' => time(),
                            'stickers' => (isset($_POST['chatSticker']) && Wo_IsUrl($_POST['chatSticker']) && !$mediaFilename && !$mediaName) ? $_POST['chatSticker'] : '',
                            'reply_id' => $reply_id
                        ));
                        if ($last_id && $last_id > 0) {
                            $messages = Wo_GetPageMessages(array(
                                'id' => $last_id,
                                'page_id' => $_GET['page_id']
                            ));
                            foreach ($messages as $wo['chatMessage']) {
                                $wo['chat']['color'] = Wo_GetChatColor($wo['user']['user_id'], $to_id, Wo_Secure($_GET['page_id']));
                                $html .= Wo_LoadPage('chat/page-chat-list');
                            }
                            $file = false;
                            if (isset($_FILES['sendMessageFile']['name'])) {
                                $file = true;
                            }
                            $data = array(
                                'status' => 200,
                                'html' => $html,
                                'file' => $file,
                                'invalid_file' => $invalid_file
                            );
                        }
                    }
                    if ($invalid_file > 0 && empty($last_id)) {
                        $data['status']       = 500;
                        $data['invalid_file'] = $invalid_file;
                    }
                }
            } else {
                $data = array(
                    'status' => 400
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'register_message_record') {
        if (isset($_POST['audio-filename']) && isset($_FILES['audio-blob']['name'])) {
            $fileInfo       = array(
                'file' => $_FILES["audio-blob"]["tmp_name"],
                'name' => $_FILES['audio-blob']['name'],
                'size' => $_FILES["audio-blob"]["size"],
                'type' => $_FILES["audio-blob"]["type"]
            );
            $media          = Wo_ShareFile($fileInfo);
            $data['url']    = $media['filename'];
            $data['status'] = 200;
            $data['name']   = $media['name'];
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'change_chat_color') {
        $recipient_id = (isset($_GET['recipient_id'])) ? Wo_Secure($_GET['recipient_id']) : false;
        $user_id      = (isset($wo['user']['id'])) ? $wo['user']['id'] : false;
        $color        = (isset($_GET['color'])) ? Wo_Secure($_GET['color']) : false;
        if ($recipient_id && $user_id && $color) {
            if (Wo_UpdateChatColor($recipient_id, $user_id, $color)) {
                $data = array(
                    'status' => 200
                );
            }
        } else {
            $data = array(
                'status' => 500
            );
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_new_messages') {
        if (!empty($_GET['user_id']) && Wo_CheckMainSession($hash_id) === true) {
            $html    = '';
            $user_id = Wo_Secure($_GET['user_id']);
            if (!empty($user_id)) {
                $user_id  = $_GET['user_id'];
                $messages = Wo_GetMessages(array(
                    'after_message_id' => $_GET['message_id'],
                    'new' => true,
                    'user_id' => $user_id
                ));
                if (count($messages) > 0) {
                    foreach ($messages as $wo['chatMessage']) {
                        $html .= Wo_LoadPage('chat/chat-list');
                    }
                    $data = array(
                        'status' => 200,
                        'html' => $html,
                        'receiver' => $user_id,
                        'sender' => $wo['user']['user_id']
                    );
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'update_tab_status') {
        $html = '';
        if (!empty($_GET['user_id'])) {
            $user_id = Wo_Secure($_GET['user_id']);
            if (!empty($user_id)) {
                $user_id = $_GET['user_id'];
                $status  = Wo_IsOnline($user_id);
                if ($status === true) {
                    $data['status'] = 200;
                } else {
                    $data['status'] = 300;
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'close_chat') {
        if (isset($_SESSION['chat_id'])) {
            if (strpos($_SESSION['chat_id'], ',') !== false) {
                $_SESSION['chat_id'] = str_replace($_GET['id'] . ',', '', $_SESSION['chat_id']);
                $_SESSION['chat_id'] = str_replace(',' . $_GET['id'], '', $_SESSION['chat_id']);
            } else {
                unset($_SESSION['chat_id']);
            }
        }
        if (!empty($_GET['recipient_id']) && is_numeric($_GET['recipient_id'])) {
            if (!empty($_GET['story_id']) && is_numeric($_GET['story_id']) && $_GET['story_id'] > 0) {
                $story = $db->where('id', Wo_Secure($_GET['story_id']))->getOne(T_USER_STORY);
                if (!empty($story)) {
                    $data = array(
                        'url' => Wo_SeoLink('index.php?link1=messages&user=' . $_GET['recipient_id']) . "?story_id=" . $story->id
                    );
                } else {
                    $data = array(
                        'url' => Wo_SeoLink('index.php?link1=messages&user=' . $_GET['recipient_id'])
                    );
                }
            } else {
                $data = array(
                    'url' => Wo_SeoLink('index.php?link1=messages&user=' . $_GET['recipient_id'])
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'close_group') {
        $data = array(
            'status' => 304
        );
        if (isset($_SESSION['group_id'])) {
            unset($_SESSION['group_id']);
            $data['status'] = 200;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'close_page') {
        $data = array(
            'status' => 304
        );
        if (isset($_SESSION['page_id'])) {
            unset($_SESSION['page_id']);
            $data['status'] = 200;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'is_chat_on') {
        $data = array(
            'url' => Wo_SeoLink('index.php?link1=messages'),
            'chat' => $wo['config']['chatSystem']
        );
        if (!empty($_GET['recipient_id'])) {
            if (!empty($_GET['story_id']) && is_numeric($_GET['story_id']) && $_GET['story_id'] > 0) {
                $story = $db->where('id', Wo_Secure($_GET['story_id']))->getOne(T_USER_STORY);
                if (!empty($story)) {
                    $data = array(
                        'url' => Wo_SeoLink('index.php?link1=messages&user=' . $_GET['recipient_id']) . "?story_id=" . $story->id,
                        'chat' => $wo['config']['chatSystem']
                    );
                } else {
                    $data = array(
                        'url' => Wo_SeoLink('index.php?link1=messages&user=' . $_GET['recipient_id']),
                        'chat' => $wo['config']['chatSystem']
                    );
                }
            } else {
                $data = array(
                    'url' => Wo_SeoLink('index.php?link1=messages&user=' . $_GET['recipient_id']),
                    'chat' => $wo['config']['chatSystem']
                );
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_parts' && isset($_GET['name'])) {
        $name  = Wo_Secure($_GET['name']);
        $data  = array(
            'status' => 404
        );
        $parts = Wo_GetUsersByName($name, true);
        $html  = "";
        if (count($parts) > 0) {
            foreach ($parts as $wo['part']) {
                $html .= Wo_LoadPage('chat/chat-part-list');
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'search_parts' && isset($_GET['name']) && isset($_GET['group_id']) && Wo_IsGChatOwner($_GET['group_id'])) {
        $name  = Wo_Secure($_GET['name']);
        $group = Wo_Secure($_GET['group_id']);
        $data  = array(
            'status' => 404
        );
        $parts = Wo_GetUsersByName($name, true);
        $html  = "";
        if (count($parts) > 0) {
            foreach ($parts as $wo['part']) {
                $wo['part']['group_id'] = $group;
                $html .= Wo_LoadPage('chat/add-group-parts');
            }
            $data['status'] = 200;
            $data['html']   = $html;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'add_gchat_user' && isset($_GET['user_id']) && isset($_GET['group_id']) && Wo_IsGChatOwner($_GET['group_id'])) {
        $data = array(
            'status' => 304
        );
        $code = Wo_AddGChatPart($_GET['group_id'], $_GET['user_id']);
        if ($code === 0) {
            $data['status'] = 200;
            $data['code']   = 0;
        } else if ($code === 1) {
            $data['status'] = 200;
            $data['code']   = 1;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_new_group_messages') {
        if (!empty($_GET['group_id']) && Wo_CheckMainSession($hash_id) === true) {
            $html     = '';
            $group_id = Wo_Secure($_GET['group_id']);
            if (!empty($group_id)) {
                $messages = Wo_GetGroupMessages(array(
                    'offset' => $_GET['message_id'],
                    'group_id' => $_GET['group_id'],
                    'new' => true
                ));
                if (count($messages) > 0) {
                    foreach ($messages as $wo['chatMessage']) {
                        $html .= Wo_LoadPage('chat/group-chat-list');
                    }
                    $data = array(
                        'status' => 200,
                        'html' => $html
                    );
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'get_new_page_messages') {
        if (!empty($_GET['page_id']) && Wo_CheckMainSession($hash_id) === true) {
            $html    = '';
            $page_id = Wo_Secure($_GET['page_id']);
            if (!empty($page_id)) {
                $messages = Wo_GetPageMessages(array(
                    'offset' => $_GET['message_id'],
                    'page_id' => $_GET['page_id'],
                    'new' => true
                ));
                if (count($messages) > 0) {
                    foreach ($messages as $wo['chatMessage']) {
                        $html .= Wo_LoadPage('chat/page-chat-list');
                    }
                    $data = array(
                        'status' => 200,
                        'html' => $html
                    );
                }
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'clear_group_chat' && isset($_GET['group_id']) && is_numeric($_GET['group_id'])) {
        $id     = Wo_Secure($_GET['group_id']);
        $data   = array(
            'status' => 304
        );
        $result = Wo_ClearGChat($id);
        if ($result === true) {
            $data['status'] = 200;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'delete_group_chat' && isset($_GET['group_id']) && is_numeric($_GET['group_id'])) {
        $id     = Wo_Secure($_GET['group_id']);
        $data   = array(
            'status' => 304
        );
        $result = Wo_DeleteGChat($id);
        if ($result === true) {
            $data['status'] = 200;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'exit_group_chat' && isset($_GET['group_id']) && is_numeric($_GET['group_id'])) {
        $id     = Wo_Secure($_GET['group_id']);
        $data   = array(
            'status' => 304
        );
        $result = Wo_ExitGChat($id);
        if ($result === true) {
            $data['status'] = 200;
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'group_parts' && isset($_GET['group_id']) && is_numeric($_GET['group_id'])) {
        $id    = Wo_Secure($_GET['group_id']);
        $data  = array(
            'status' => 304
        );
        $parts = Wo_GetGChatMemebers($id);
        $data  = array();
        if (is_array($parts)) {
            $wo['group']             = array();
            $wo['group']['owner']    = Wo_IsGChatOwner($id);
            $wo['group']['parts']    = $parts;
            $wo['group']['group_id'] = $id;
            $data['status']          = 200;
            $data['count']           = count($parts);
            ;
            $data['parts'] = Wo_LoadPage('chat/manage');
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'create_group' && isset($_POST['group_name']) && isset($_POST['parts'])) {
        $error = false;
        $data  = array(
            'status' => 500,
            'message' => $error_icon . $wo['lang']['please_check_details']
        );
        if (strlen($_POST['group_name']) < 4 || strlen($_POST['group_name']) > 15) {
            $error           = true;
            $data['message'] = $error_icon . $wo['lang']['group_name_limit'];
        }
        if (isset($_FILES["avatar"])) {
            if (file_exists($_FILES["avatar"]["tmp_name"])) {
                $image = getimagesize($_FILES["avatar"]["tmp_name"]);
                if (!in_array($image[2], array(
                    IMAGETYPE_GIF,
                    IMAGETYPE_JPEG,
                    IMAGETYPE_PNG,
                    IMAGETYPE_BMP
                ))) {
                    $error           = true;
                    $data['message'] = $error_icon . $wo['lang']['group_avatar_image'];
                }
            }
        }
        if (!$error) {
            $users   = explode(',', Wo_Secure($_POST['parts']));
            $users[] = $wo['user']['id'];
            $name    = Wo_Secure($_POST['group_name']);
            $id      = Wo_CreateGChat($name, $users);
            if ($id && is_numeric($id)) {
                $data = array(
                    'status' => 200,
                    'group_id' => $id
                );
            }
            if (isset($_FILES["avatar"]["tmp_name"])) {
                $fileInfo      = array(
                    'file' => $_FILES["avatar"]["tmp_name"],
                    'name' => $_FILES['avatar']['name'],
                    'size' => $_FILES["avatar"]["size"],
                    'type' => $_FILES["avatar"]["type"],
                    'types' => 'jpg,png,bmp,gif',
                    'compress' => false,
                    'crop' => array(
                        'width' => 70,
                        'height' => 70
                    )
                );
                $media         = Wo_ShareFile($fileInfo);
                $mediaFilename = $media['filename'];
                @Wo_UpdateGChat($id, array(
                    "avatar" => $mediaFilename
                ));
            }
        }
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'delete_group_request' && !empty($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
        $db->where('user_id', $wo['user']['id'])->where('group_id', Wo_Secure($_GET['group_id']))->delete(T_GROUP_CHAT_USERS);
        $group_id          = Wo_Secure($_GET['group_id']);
        $group_chat        = Wo_GroupTabData($group_id);
        $notification_data = array(
            'recipient_id' => $group_chat['user_id'],
            'notifier_id' => $wo['user']['id'],
            'group_chat_id' => $group_id,
            'type' => 'declined_group_chat_request',
            'url' => 'index.php?link1=timeline&u=' . $wo['user']['username']
        );
        Wo_RegisterNotification($notification_data);
        $data['status'] = 200;
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'accept_group_request' && !empty($_GET['group_id']) && is_numeric($_GET['group_id']) && $_GET['group_id'] > 0) {
        $group_id = Wo_Secure($_GET['group_id']);
        $db->where('user_id', $wo['user']['id'])->where('group_id', $group_id)->update(T_GROUP_CHAT_USERS, array(
            'last_seen' => time(),
            'active' => '1'
        ));
        $group_chat        = Wo_GroupTabData($group_id);
        $notification_data = array(
            'recipient_id' => $group_chat['user_id'],
            'notifier_id' => $wo['user']['id'],
            'group_chat_id' => $group_id,
            'type' => 'accept_group_chat_request',
            'url' => 'index.php?link1=timeline&u=' . $wo['user']['username']
        );
        Wo_RegisterNotification($notification_data);
        $data['status'] = 200;
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
    if ($s == 'seen' && !empty($_POST['recipient_id']) && is_numeric($_POST['recipient_id']) && $_POST['recipient_id'] > 0) {
        $db->where('from_id', Wo_Secure($_POST['recipient_id']))->where('to_id', $wo['user']['id'])->update(T_MESSAGES, array(
            'seen' => time()
        ));
        $data['status'] = 200;
        header("Content-type: application/json");
        echo json_encode($data);
        exit();
    }
}
