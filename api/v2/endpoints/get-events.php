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

if (empty($_POST['fetch'])) {
    $error_code    = 3;
    $error_message = 'fetch (POST) is missing';
}

$options['offset'] = (!empty($_POST['offset'])) ? (int) $_POST['offset'] : 0;
$options['limit'] = (!empty($_POST['limit'])) ? (int) $_POST['limit'] : 20;

$options['my_limit'] = (!empty($_POST['my_limit'])) ? (int) $_POST['my_limit'] : 20;
$options['my_offset'] = (!empty($_POST['my_offset'])) ? (int) $_POST['my_offset'] : 0;

$options['going_limit'] = (!empty($_POST['going_limit'])) ? (int) $_POST['going_limit'] : 20;
$options['going_offset'] = (!empty($_POST['going_offset'])) ? (int) $_POST['going_offset'] : 0;


$options['interested_offset'] = (!empty($_POST['interested_offset'])) ? (int) $_POST['interested_offset'] : 0;
$options['interested_limit'] = (!empty($_POST['interested_limit'])) ? (int) $_POST['interested_limit'] : 20;

$options['invited_offset'] = (!empty($_POST['invited_offset'])) ? (int) $_POST['invited_offset'] : 0;
$options['invited_limit'] = (!empty($_POST['invited_limit'])) ? (int) $_POST['invited_limit'] : 20;

$options['past_offset'] = (!empty($_POST['past_offset'])) ? (int) $_POST['past_offset'] : 0;
$options['past_limit'] = (!empty($_POST['past_limit'])) ? (int) $_POST['past_limit'] : 20;

if (empty($error_code)) {

    $fetch = explode(',', $_POST['fetch']);
    $data  = array();
    foreach ($fetch as $key => $value) {
        $data[$value] = $value;
    }
    $response_data['events'] = array();
    $response_data['my_events'] = array();
    $response_data['going'] = array();
    $response_data['interested'] = array();
    $response_data['invited'] = array();
    $response_data['past'] = array();

    if (!empty($data['events'])) {
    	$events = array();
	    $get_events = Wo_GetEvents(array('offset' => $options['offset'], 'limit' => $options['limit']));
	    foreach ($get_events as $key => $event) {
	    	foreach ($non_allowed as $key => $value) {
	           unset($event['user_data'][$value]);
	        }
	    	$event['is_going'] = Wo_EventGoingExists($event['id']);
	    	$event['is_interested'] = Wo_EventInterestedExists($event['id']);
	        $event['going_count'] = Wo_TotalGoingUsers($event['id']);
	        $event['interested_count'] = Wo_TotalInterestedUsers($event['id']);
            $event['start_date'] = date($wo['config']['date_style'], strtotime($event['start_date']));
            $event['end_date'] = date($wo['config']['date_style'], strtotime($event['end_date']));
	    	$events[] = $event;
	    }
        $response_data['events'] = $events;
        $response_data['api_status'] = 200;
    }
    if (!empty($data['my_events'])) {
    	$my_events = array();
        $get_my_events = Wo_GetMyEvents($options['my_offset'],$options['my_limit']);
        foreach ($get_my_events as $key => $event) {
        	foreach ($non_allowed as $key => $value) {
               unset($event['user_data'][$value]);
            }
            $event['start_date'] = date($wo['config']['date_style'], strtotime($event['start_date']));
            $event['end_date'] = date($wo['config']['date_style'], strtotime($event['end_date']));
        	$my_events[] = $event;
        }
        $response_data['my_events'] = $my_events;
        $response_data['api_status'] = 200;
    }
    if (!empty($data['going'])) {
        $going = array();
        $get_my_events = Wo_GetGoingEvents($options['going_offset'],$options['going_limit']);
        foreach ($get_my_events as $key => $event) {
            foreach ($non_allowed as $key => $value) {
               unset($event['user_data'][$value]);
            }
            $event['start_date'] = date($wo['config']['date_style'], strtotime($event['start_date']));
            $event['end_date'] = date($wo['config']['date_style'], strtotime($event['end_date']));
            $going[] = $event;
        }
        $response_data['going'] = $going;
        $response_data['api_status'] = 200;
    }
    if (!empty($data['interested'])) {
        $interested = array();
        $get_my_events = Wo_GetInterestedEvents($options['interested_offset'],$options['interested_limit']);
        foreach ($get_my_events as $key => $event) {
            foreach ($non_allowed as $key => $value) {
               unset($event['user_data'][$value]);
            }
            $event['start_date'] = date($wo['config']['date_style'], strtotime($event['start_date']));
            $event['end_date'] = date($wo['config']['date_style'], strtotime($event['end_date']));
            $interested[] = $event;
        }
        $response_data['interested'] = $interested;
        $response_data['api_status'] = 200;
    }
    if (!empty($data['invited'])) {
        $invited = array();
        $get_my_events = Wo_GetInvitedEvents($options['invited_offset'],$options['invited_limit']);
        foreach ($get_my_events as $key => $event) {
            foreach ($non_allowed as $key => $value) {
               unset($event['user_data'][$value]);
            }
            $event['start_date'] = date($wo['config']['date_style'], strtotime($event['start_date']));
            $event['end_date'] = date($wo['config']['date_style'], strtotime($event['end_date']));
            $invited[] = $event;
        }
        $response_data['invited'] = $invited;
        $response_data['api_status'] = 200;
    }
    if (!empty($data['past'])) {
        $past = array();
        $get_my_events = Wo_GetPastEvents($options['past_offset'],$options['past_limit']);
        foreach ($get_my_events as $key => $event) {
            foreach ($non_allowed as $key => $value) {
               unset($event['user_data'][$value]);
            }
            $event['start_date'] = date($wo['config']['date_style'], strtotime($event['start_date']));
            $event['end_date'] = date($wo['config']['date_style'], strtotime($event['end_date']));
            $past[] = $event;
        }
        $response_data['past'] = $past;
        $response_data['api_status'] = 200;
    }
}