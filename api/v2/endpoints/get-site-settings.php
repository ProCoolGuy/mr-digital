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
$get_config = Wo_GetConfig();
foreach ($non_allowed_config as $key => $value) {
    unset($get_config[$value]);
}
$get_config['logo_url'] = $config['theme_url'] . '/img/logo.' . $get_config['logo_extension'];
$get_config['page_categories'] = $wo['page_categories'];
$get_config['group_categories'] = $wo['group_categories'];
$get_config['blog_categories'] = $wo['blog_categories'];
$get_config['products_categories'] = $wo['products_categories'];
$get_config['job_categories'] = $wo['job_categories'];
$get_config['genders'] = $wo['genders'];
$get_config['currency_array'] = (Array) json_decode($get_config['currency_array']);
$get_config['currency_symbol_array'] = (Array) json_decode($get_config['currency_symbol_array']);
foreach ($wo['family'] as $key => $value) {
	$wo['family'][$key] = $wo['lang'][$value];
}
$get_config['family'] = $wo['family'];
if (!empty($wo['post_colors'])) {
	foreach ($wo['post_colors'] as $key => $color) {
		if (!empty($color->image)) {
			$wo['post_colors'][$key]->image = Wo_GetMedia($color->image);
		}
	}
}
$get_config['fields'] = Wo_GetUserCustomFields();
$get_config['movie_category'] = $wo['film-genres'];
$get_config['post_colors'] = $wo['post_colors'];
$get_config['page_sub_categories'] = $wo['page_sub_categories'];
$get_config['group_sub_categories'] = $wo['group_sub_categories'];
$get_config['products_sub_categories'] = $wo['products_sub_categories'];

$get_config['page_custom_fields'] = Wo_GetCustomFields('page');
$get_config['group_custom_fields'] = Wo_GetCustomFields('group');
$get_config['product_custom_fields'] = Wo_GetCustomFields('product');

$get_config['post_reactions_types'] = $wo['reactions_types'];
$get_config['pro_packages'] = $wo['pro_packages'];
$get_config['pro_packages_types'] = $wo['pro_packages_types'];
$response_data      = array(
    'api_status' => 200,
    'config' => $get_config
);