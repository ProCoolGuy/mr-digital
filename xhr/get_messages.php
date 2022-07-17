<?php 
if ($f == 'get_messages') {
    if (Wo_CheckMainSession($hash_id) === true) {
        $data     = array(
            'status' => 200,
            'html' => ''
        );
        $data['message'] = $wo['lang']['no_more_message_to_show'];

        $messages = Wo_GetMessagesUsers($wo['user']['user_id'], '', 5);
        //$page_messages = Wo_GetPageChatList($wo['user']['user_id'], 5);
        $groups_messages = Wo_GetGroupsListAPP(array('limit' => 5));
        $array = array();
        if (!empty($messages)) {
            foreach ($messages as $key => $value) {
                $array[] = $value;
            }
        }
        // if (!empty($page_messages)) {
        //     foreach ($page_messages as $key => $value) {
        //         $array[] = $value;
        //     }
        // }
        if (!empty($groups_messages)) {
            foreach ($groups_messages as $key => $value) {
                $array[] = $value;
            }
        }

        array_multisort( array_column($array, "chat_time"), SORT_DESC, $array );
        if (!empty($array)) {
            $array_count = 0;
            foreach ($array as $key => $value) {
                if ($array_count < 5) {
                    if (!empty($value['group_id']) && !empty($value['last_message'])) {
                        $wo['group'] = $value;
                        $data['html'] .= Wo_LoadPage('header/group_messages');
                    }
                    elseif (!empty($value['message']['page_id']) && $value['message']['page_id'] > 0) {
                        $wo['page_message'] = array();
                        $message = Wo_GetPageMessages(array(
                                                'page_id' => $value['message']['page_id'],
                                                'from_id' => $value['message']['user_id'],
                                                'to_id'   => $value['message']['conversation_user_id'],
                                                'limit' => 1,
                                                'limit_type' => 1
                                            ));
                        $wo['page_message']['message'] = $message[0];
                        $data['html'] .= Wo_LoadPage('header/page_messages');
                    }
                    elseif(!empty($value['message']['user_id']) && $value['message']['user_id'] > 0){
                        $message = Wo_GetMessagesHeader(array('user_id' => $value['user_id']), 'user');
                        if (!empty($message['messageUser'])) {
                            $wo['message'] = $value;
                            $data['html'] .= Wo_LoadPage('header/messages');
                        }
                    }
                    $array_count = $array_count + 1;
                }
            }
        }
        else {
            $data['message'] = $wo['lang']['no_more_message_to_show'];
        }




        //$sorted = array_orderby($array, 'user_id', SORT_DESC);
        // print_r($array);
        // if (!empty($messages) || !empty($groups_messages)) {
        //     $messages_count = 0;
        //     if (!empty($messages) && !empty($groups_messages) && (count($messages) >= count($groups_messages))) {
        //         foreach ($messages as $key => $wo['message']) {
        //             $message = Wo_GetMessagesHeader(array('user_id' => $wo['message']['user_id']), 'user');
        //             if (!empty($message) && !empty($message['user_id'])) {
        //                 foreach ($groups_messages as $group_key => $group_value) {
        //                     if ($message['time'] < $group_value['time']) {
        //                             $wo['group'] = $groups_messages[$group_key];
        //                             if (!empty($wo['group']['last_message']) && $messages_count < 5) {
        //                                 $data['html'] .= Wo_LoadPage('header/group_messages');
        //                                 $messages_count = $messages_count + 1;
        //                                 unset($groups_messages[$group_key]);
        //                             }
        //                     }
        //                 }
        //                 if ($messages_count < 5 && !empty($message['messageUser'])) {
        //                     $data['html'] .= Wo_LoadPage('header/messages'); 
        //                     $messages_count = $messages_count + 1;
        //                 }
        //             }
        //             else{
        //                 $data['message'] = $wo['lang']['no_more_message_to_show'];
        //             }
        //         }
        //         if ($messages_count < 5 && !empty($groups_messages)) {
        //             foreach ($groups_messages as $group_key => $group_value) {
        //                 $wo['group'] = $groups_messages[$group_key];
        //                 if (!empty($wo['group']['last_message']) && $messages_count < 5) {
        //                     $data['html'] .= Wo_LoadPage('header/group_messages');
        //                     $messages_count = $messages_count + 1;
        //                     unset($groups_messages[$group_key]);
        //                 }
        //             }
        //         }


        //     }
        //     elseif (!empty($messages) && !empty($groups_messages) && (count($messages) < count($groups_messages))) {
        //         foreach ($groups_messages as $key => $wo['group']) {
        //             foreach ($messages as $messages_key => $messages_value) {
        //                 $message = Wo_GetMessagesHeader(array('user_id' => $messages_value['user_id']), 1);
        //                 if ($message['time'] > $wo['group']['time']) {
        //                         $wo['message'] = $messages[$messages_key];
        //                         if ($messages_count < 5 && !empty($message['messageUser'])) {
        //                             $data['html'] .= Wo_LoadPage('header/messages'); 
        //                             $messages_count = $messages_count + 1;
        //                             unset($messages[$messages_key]);
        //                         }
        //                 }
        //             }
        //             if (!empty($wo['group']['last_message']) && $messages_count < 5) {
        //                 $data['html'] .= Wo_LoadPage('header/group_messages');
        //                 $messages_count = $messages_count + 1;
        //             }
        //         }
        //         if ($messages_count < 5 && !empty($messages)) {
        //             foreach ($messages as $messages_key => $messages_value) {
        //                 $message = Wo_GetMessagesHeader(array('user_id' => $messages_value['user_id']), 1);
        //                 $wo['message'] = $messages[$messages_key];
        //                 if ($messages_count < 5 && !empty($message['messageUser'])) {
        //                     $data['html'] .= Wo_LoadPage('header/messages'); 
        //                     $messages_count = $messages_count + 1;
        //                     unset($messages[$messages_key]);
        //                 }
        //             }
        //         }
        //     }
        //     elseif (!empty($messages) && empty($groups_messages)) {
        //         foreach ($messages as $key => $wo['message']) {
        //             $message = Wo_GetMessagesHeader(array('user_id' => $wo['message']['user_id']), 1);
        //             if (!empty($message['messageUser'])) {
        //                 $data['html'] .= Wo_LoadPage('header/messages');
        //             }
        //         }
        //     }
        //     elseif (empty($messages) && !empty($groups_messages)) {
        //         foreach ($groups_messages as $key => $wo['group']) {
        //             if (!empty($wo['group']['last_message'])) {
        //                 $data['html'] .= Wo_LoadPage('header/group_messages');
        //             }
        //         }
        //     }
        // }else {
        //     $data['message'] = $wo['lang']['no_more_message_to_show'];
        // }


        // if (count($messages) > 0 || count($groups_messages) > 0) {
        //     if (!empty($messages)) {
        //         foreach ($messages as $key => $wo['message']) {
        //             $message = Wo_GetMessagesHeader(array('user_id' => $wo['message']['user_id']), 1);
        //             if (!empty($groups_messages)) {
        //                 foreach ($groups_messages as $group_key => $group_value) {
        //                     if ($message['time'] < $group_value['time']) {
        //                             $wo['group'] = $groups_messages[$group_key];
        //                             $data['html'] .= Wo_LoadPage('header/group_messages');
        //                             unset($groups_messages[$group_key]);
        //                     }
        //                 }
        //             }
        //             $data['html'] .= Wo_LoadPage('header/messages'); 
        //         }
        //     }
        // } 
        $data['messages_url']  = Wo_SeoLink('index.php?link1=messages');
        $data['messages_text'] = $wo['lang']['see_all'];
    }
    header("Content-type: application/json");
    echo json_encode($data);
    exit();
}
