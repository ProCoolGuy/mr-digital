
/*
  socket.on("notification", async (data, callback) => {
    let notificationData = await Wo_GetNotifications(userHashUserId[data.userId]);
    let not_temp = notificationTemplate({
      notificationRecipientId: notificationData.recipient_id,
      notificationUrl: notificationData.notification_url,
      notificationNotifierName: notificationData.notifier_name,
      type2NoName: false,
      notificationAjaxUrl: notificationData.ajax_url,
      viewedStory: false,
      pullLeft: "pull_left",
      notificationNotifierIcon: notificationData.notifier_icon,
      notificationTypeText: notificationData.type_text,
      notificationIcon: notificationData.icon,
      notificationTime: notificationData.time,
    })

    callback({
      html: not_temp
    })
  })

  socket.on("update_data", async (data, callback) => {
    let notificationCount = await Wo_CountNotifications(userHashUserId[data.userId]);
    let notificationData = await Wo_GetNotifications(userHashUserId[data.userId]);

    let messageCount = await Wo_CountMessages(userHashUserId[data.userId]);

    let not_temp = notificationTemplate({
      notificationRecipientId: notificationData.recipient_id,
      notificationUrl: notificationData.notification_url,
      notificationNotifierName: notificationData.notifier_name,
      type2NoName: false,
      notificationAjaxUrl: notificationData.ajax_url,
      viewedStory: false,
      pullLeft: "pull_left",
      notificationNotifierIcon: notificationData.notifier_icon,
      notificationTypeText: notificationData.type_text,
      notificationIcon: notificationData.icon,
      notificationTime: notificationData.time,
    })

    callback({
      notifications: notificationCount,
      html: not_temp,
      icon: notificationData.icon,
      title: notificationData.title,
      notification_text: notificationData.type_text,
      url: notificationData.url,
      pop: 200,
      messages: messageCount
    })
  })
*/

// function Wo_IsOnline($user_id) {
//   if (empty($user_id) || !is_numeric($user_id) || $user_id < 1) {
//       return false;
//   }
//   $user_id  = Wo_Secure($user_id);
//   $lastseen = Wo_UserData($user_id);
//   $time     = time() - 60;
//   if ($lastseen['lastseen'] < $time) {
//       return false;
//   } else {
//       return true;
//   }
// }
// function Wo_ChatSearchUsers($search_query = '') {
//   global $sqlConnect, $wo;
//   if ($wo['loggedin'] == false) {
//       return false;
//   }
//   $data         = array();
//   $time         = time() - 60;
//   $search_query = Wo_Secure($search_query);
//   $user_id      = Wo_Secure($wo['user']['user_id']);
//   $query_one    = "SELECT `user_id` FROM " . T_USERS . " WHERE (`user_id` IN (SELECT `following_id` FROM " . T_FOLLOWERS . " WHERE `follower_id` = {$user_id} AND `following_id` <> {$user_id} AND `active` = '1') AND `active` = '1'";
//   if (isset($search_query) && !empty($search_query)) {
//       $query_one .= " AND ((`username` LIKE '%$search_query%') OR CONCAT(`first_name`,  ' ', `last_name`) LIKE  '%{$search_query}%'))";
//   }
//   $query_one .= " ORDER BY `first_name` LIMIT 10";
//   $query = mysqli_query($sqlConnect, $query_one);
//   while ($fetched_data = mysqli_fetch_assoc($query)) {
//       $data[] = Wo_UserData($fetched_data['user_id']);
//   }
//   return $data;
// }

// function Wo_CountOnlineUsers() {
//   global $sqlConnect, $wo;
//   if ($wo['loggedin'] == false) {
//       return false;
//   }
//   $time         = time() - 60;
//   $user_id      = Wo_Secure($wo['user']['user_id']);
//   $query        = mysqli_query($sqlConnect, "SELECT COUNT(`user_id`) AS `online` FROM " . T_USERS . " WHERE `user_id` IN (SELECT `following_id` FROM " . T_FOLLOWERS . " WHERE `follower_id`= {$user_id} AND `following_id` <> {$user_id} AND `active` = '1') AND `lastseen` > {$time} AND `active` = '1' AND `user_id` NOT IN (SELECT `blocked` FROM " . T_BLOCKS . " WHERE `blocker` = '{$user_id}') AND `user_id` NOT IN (SELECT `blocker` FROM " . T_BLOCKS . " WHERE `blocked` = '{$user_id}') ORDER BY `lastseen` DESC");
//   $fetched_data = mysqli_fetch_assoc($query);
//   return $fetched_data['online'];
// }


// function periodicChatUpdate(){
//     global $sqlConnect, $wo;
//     if ($wo['loggedin'] == false) {
//         return false;
//     }
//     $data       = array();
//     $time       = time() - 60;
//     $user_id    = Wo_Secure($wo['user']['user_id']);
//     $query_text = "SELECT `user_id` FROM " . T_USERS . " WHERE `user_id` IN (SELECT `following_id` FROM " . T_FOLLOWERS . " WHERE `follower_id` = {$user_id} AND `following_id` <> {$user_id} AND `user_id` NOT IN (SELECT `blocked` FROM " . T_BLOCKS . " WHERE `blocker` = '{$user_id}') AND `user_id` NOT IN (SELECT `blocker` FROM " . T_BLOCKS . " WHERE `blocked` = '{$user_id}') AND `active` = '1')";
//     if ($type == 'online') {
//         $query_text .= " AND `lastseen` > {$time}";
//     } else if ($type == 'offline') {
//         $query_text .= " AND `lastseen` < {$time}";
//     }
//     $query_text .= " AND `active` = '1' ORDER BY `lastseen` DESC";
//     if ($type == 'offline') {
//         $query_text .= ' LIMIT 6';
//     }
//     $query = mysqli_query($sqlConnect, $query_text);
//     while ($fetched_data = mysqli_fetch_assoc($query)) {
//         $data[] = Wo_UserData($fetched_data['user_id']);
//     }
//     return $data;
// }


/** Notification */
  // if (Wo_CheckMainSession($hash_id) === true) {
  //     $sql_query             = mysqli_query($sqlConnect, "UPDATE " . T_APP_SESSIONS . " SET `time` = " . time() . " WHERE `session_id` = '{$session_id}'");
  //     $data['pop']           = 0;
  //     $data['status']        = 200;
  //     $data['notifications'] = Wo_CountNotifications(array(
  //         'unread' => true
  //     ));
  //     $data['html']          = '';
  //     $notifications         = Wo_GetNotifications(array(
  //         'type_2' => 'popunder',
  //         'unread' => true,
  //         'limit' => 1
  //     ));
  //     foreach ($notifications as $wo['notification']) {
  //         $data['html']              = Wo_LoadPage('header/notifecation');
  //         $data['icon']              = $wo['notification']['notifier']['avatar'];
  //         $data['title']             = $wo['notification']['notifier']['name'];
  //         $data['notification_text'] = $wo['notification']['type_text'];
  //         $data['url']               = $wo['notification']['url'];
  //         $data['pop']               = 200;
  //         if ($wo['notification']['seen'] == 0) {
  //             $query     = "UPDATE " . T_NOTIFICATION . " SET `seen_pop` = " . time() . " WHERE `id` = " . $wo['notification']['id'];
  //             $sql_query = mysqli_query($sqlConnect, $query);
  //         }
  //     }
  //     $data['messages'] = Wo_CountMessages(array(
  //         'new' => true
  //     ), 'interval');
  //     $chat_groups = Wo_CheckLastGroupUnread();
  //     $data['messages'] = $data['messages'] + count($chat_groups);
  //     $data['calls']    = 0;
  //     $data['is_call']  = 0;
  //     $check_calles     = Wo_CheckFroInCalls();
  //     if ($check_calles !== false && is_array($check_calles)) {
  //         $wo['incall']                 = $check_calles;
  //         $wo['incall']['in_call_user'] = Wo_UserData($check_calles['from_id']);
  //         $data['calls']                = 200;
  //         $data['is_call']              = 1;
  //         $data['calls_html']           = Wo_LoadPage('modals/in_call');
  //     }
  //     $data['audio_calls']   = 0;
  //     $data['is_audio_call'] = 0;
  //     $check_calles          = Wo_CheckFroInCalls('audio');
  //     if ($check_calles !== false && is_array($check_calles)) {
  //         $wo['incall']                 = $check_calles;
  //         $wo['incall']['in_call_user'] = Wo_UserData($check_calles['from_id']);
  //         $data['audio_calls']          = 200;
  //         $data['is_audio_call']        = 1;
  //         $data['audio_calls_html']     = Wo_LoadPage('modals/in_audio_call');
  //     }
  //     $data['followRequests']      = Wo_CountFollowRequests();
  //     $data['followRequests']      = $data['followRequests'] + Wo_CountGroupChatRequests();
  //     $data['notifications_sound'] = $wo['user']['notifications_sound'];
  // }
  // $data['count_num'] = 0;
  // if ($_GET['check_posts'] == 'true') {
  //     if (!empty($_GET['before_post_id']) && isset($_GET['user_id'])) {
  //         $html              = '';
  //         $postsData         = array(
  //             'before_post_id' => $_GET['before_post_id'],
  //             'publisher_id' => $_GET['user_id'],
  //             'limit' => 20,
  //             'ad-id' => 0,
  //             'placement' => 'multi_image_post'
  //         );
  //         $posts             = Wo_GetPosts($postsData);
  //         $count             = count($posts);
  //         if ($count == 1) {
  //             $data['count']     = str_replace('{count}', $count, $wo['lang']['view_more_post']);
  //         }
  //         else{
  //             $data['count']     = str_replace('{count}', $count, $wo['lang']['view_more_posts']);
  //         }

  //         $data['count_num'] = $count;
  //     }
  // } else if ($_GET['hash_posts'] == 'true') {
  //     if (!empty($_GET['before_post_id']) && isset($_GET['user_id'])) {
  //         $html              = '';
  //         $posts             = Wo_GetHashtagPosts($_GET['hashtagName'], 0, 20, $_GET['before_post_id']);
  //         $count             = count($posts);
  //         if ($count == 1) {
  //             $data['count']     = str_replace('{count}', $count, $wo['lang']['view_more_post']);
  //         }
  //         else{
  //             $data['count']     = str_replace('{count}', $count, $wo['lang']['view_more_posts']);
  //         }

  //         $data['count_num'] = $count;
  //     }
  // }
  // $send_messages_to_phones = Wo_MessagesPushNotifier();
  // header("Content-type: application/json");
  // echo json_encode($data);
  // exit();