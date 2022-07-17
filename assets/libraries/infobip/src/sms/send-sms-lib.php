<?php
/**
 * Send an SMS message by using Infobip API PHP Client.
 * 
 * For your convenience, environment variables are already pre-populated with your account data 
 * like authentication, base URL and phone number.
 * 
 * Please find detailed information in the readme file.
 */ 
require '../../vendor/autoload.php';
use GuzzleHttp\Client;
use Infobip\Api\SendSmsApi;
use Infobip\Configuration;
use Infobip\Model\SmsAdvancedTextualRequest;
use Infobip\Model\SmsDestination;
use Infobip\Model\SmsTextualMessage;
 
$BASE_URL = "https://k31we1.api.infobip.com";
$API_KEY = "aec429cbe536212c2a0aa23d9e4f1504-e299bb35-3f27-429f-affc-67137b804351";

$SENDER = "InfoSMS";
$RECIPIENT = "905392090652";
$MESSAGE_TEXT = "This is a sample message";
 
$configuration = (new Configuration())
    ->setHost($BASE_URL)
    ->setApiKeyPrefix('Authorization', 'App')
    ->setApiKey('Authorization', $API_KEY);
 
$client = new Client();
 
$sendSmsApi = new SendSMSApi($client, $configuration);
$destination = (new SmsDestination())->setTo($RECIPIENT);
$message = (new SmsTextualMessage())
    ->setFrom($SENDER)
    ->setText($MESSAGE_TEXT)
    ->setDestinations([$destination]);
 
$request = (new SmsAdvancedTextualRequest())->setMessages([$message]);
 
try {
    $smsResponse = $sendSmsApi->sendSmsMessage($request);
    echo ("Response body: " . $smsResponse);
} catch (Throwable $apiException) {
    echo("HTTP Code: " . $apiException->getCode() . "\n");
    echo ("Response body: " . $apiException->getResponseBody() . "\n");
}