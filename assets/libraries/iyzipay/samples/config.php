<?php
require_once(dirname(__DIR__).'/IyzipayBootstrap.php');

IyzipayBootstrap::init();
$url = 'https://sandbox-api.iyzipay.com';
if ($wo['config']['iyzipay_mode'] == '0') {
	$url = 'https://merchant.iyzipay.com';
}

class IyzipayConfig
{
    public static function options()
    {
    	global $wo,$url;

        $options = new \Iyzipay\Options();
        $options->setApiKey($wo['config']['iyzipay_key']);
        $options->setSecretKey($wo['config']['iyzipay_secret_key']);
        $options->setBaseUrl($url);

        return $options;
    }
}
$ConversationId = rand(11111111,99999999);
$request = new \Iyzipay\Request\CreateCheckoutFormInitializeRequest();
$request->setLocale(\Iyzipay\Model\Locale::TR);
$request->setConversationId($ConversationId);
$request->setCurrency(\Iyzipay\Model\Currency::TL);
$request->setBasketId("B".rand(11111111,99999999));
$request->setPaymentGroup(\Iyzipay\Model\PaymentGroup::PRODUCT);
$request->setEnabledInstallments(array(2, 3, 6, 9));


$buyer = new \Iyzipay\Model\Buyer();
$buyer->setId($wo['config']['iyzipay_buyer_id']);
$buyer->setName($wo['config']['iyzipay_buyer_name']);
$buyer->setSurname($wo['config']['iyzipay_buyer_surname']);
$buyer->setGsmNumber($wo['config']['iyzipay_buyer_gsm_number']);
$buyer->setEmail($wo['config']['iyzipay_buyer_email']);
$buyer->setIdentityNumber($wo['config']['iyzipay_identity_number']);
$buyer->setRegistrationAddress($wo['config']['iyzipay_address']);
$buyer->setCity($wo['config']['iyzipay_city']);
$buyer->setCountry($wo['config']['iyzipay_country']);
$buyer->setZipCode($wo['config']['iyzipay_zip']);
$request->setBuyer($buyer);


$shippingAddress = new \Iyzipay\Model\Address();
$shippingAddress->setContactName($wo['config']['iyzipay_buyer_name'].' '.$wo['config']['iyzipay_buyer_surname']);
$shippingAddress->setCity($wo['config']['iyzipay_city']);
$shippingAddress->setCountry($wo['config']['iyzipay_country']);
$shippingAddress->setAddress($wo['config']['iyzipay_address']);
$shippingAddress->setZipCode($wo['config']['iyzipay_zip']);
$request->setShippingAddress($shippingAddress);

$billingAddress = new \Iyzipay\Model\Address();
$billingAddress->setContactName($wo['config']['iyzipay_buyer_name'].' '.$wo['config']['iyzipay_buyer_surname']);
$billingAddress->setCity($wo['config']['iyzipay_city']);
$billingAddress->setCountry($wo['config']['iyzipay_country']);
$billingAddress->setAddress($wo['config']['iyzipay_address']);
$billingAddress->setZipCode($wo['config']['iyzipay_zip']);
$request->setBillingAddress($billingAddress);