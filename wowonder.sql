-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2022 at 05:09 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wowonder_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_receipts`
--

CREATE TABLE `bank_receipts` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `fund_id` int(11) NOT NULL DEFAULT 0,
  `description` tinytext NOT NULL,
  `price` varchar(50) NOT NULL DEFAULT '0',
  `mode` varchar(50) NOT NULL DEFAULT '',
  `approved` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `receipt_file` varchar(250) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_at` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `broadcast`
--

CREATE TABLE `broadcast` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `image` varchar(150) CHARACTER SET utf8 DEFAULT 'upload/photos/d-group.jpg',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `broadcast_users`
--

CREATE TABLE `broadcast_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `broadcast_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `wondertage_settings`
--

CREATE TABLE `wondertage_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` varchar(20000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wondertage_settings`
--

INSERT INTO `wondertage_settings` (`id`, `name`, `value`) VALUES
(1, 'tag_trend', '1'),
(2, 'tag_header_layout', '0'),
(3, 'tag_welcome_layout', '0'),
(4, 'tag_prods_autoload', '0'),
(5, 'tag_expand_search', '0'),
(6, 'tag_show_side_trend', '0'),
(7, 'tag_auto_dark', '0'),
(8, 'tag_anron_ico_head', '0'),
(9, 'tag_prods_slider', '1'),
(10, 'tag_send_comment', '0'),
(11, 'tag_profile_donation', '1'),
(12, 'tag_profile_qr', '1'),
(13, 'tag_prods_cat_slider', '1'),
(14, 'tag_wallet_layout', '1'),
(15, 'tag_go_pro_layout', '1'),
(16, 'tag_show_password', '1'),
(17, 'tag_prods_layout', '1'),
(18, 'tag_ads_layout', '0'),
(19, 'tag_wallet_layout', '0'),
(20, 'tag_album_layout', '0'),
(21, 'tag_blog_layout', '0'),
(22, 'tag_friends_nearby_layout', '0'),
(23, 'tag_games_layout', '0'),
(24, 'tag_group_layout', '0'),
(25, 'tag_home_layout', '0'),
(26, 'tag_job_layout', '0'),
(27, 'tag_messages_layout', '0'),
(28, 'tag_page_layout', '0'),
(29, 'tag_search_layout', '0'),
(30, 'tag_settings_layout', '0'),
(31, 'tag_timeline_layout', '0'),
(32, 'tag_extra_opts', '0'),
(33, 'tag_posts_feed', '0'),
(34, 'tag_artplayer', '0'),
(35, 'tag_show_comments', '0'),
(36, 'tag_hide_menu', '0');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Activities`
--

CREATE TABLE `Wo_Activities` (
  `id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL DEFAULT 0,
  `post_id` int(255) NOT NULL DEFAULT 0,
  `reply_id` int(11) UNSIGNED DEFAULT 0,
  `comment_id` int(11) UNSIGNED DEFAULT 0,
  `follow_id` int(11) NOT NULL DEFAULT 0,
  `activity_type` varchar(32) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_AdminInvitations`
--

CREATE TABLE `Wo_AdminInvitations` (
  `id` int(11) NOT NULL,
  `code` varchar(300) NOT NULL DEFAULT '0',
  `posted` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Ads`
--

CREATE TABLE `Wo_Ads` (
  `id` int(11) NOT NULL,
  `type` varchar(32) NOT NULL DEFAULT '',
  `code` text DEFAULT NULL,
  `active` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Ads`
--

INSERT INTO `Wo_Ads` (`id`, `type`, `code`, `active`) VALUES
(1, 'header', '', '0'),
(2, 'sidebar', '', '0'),
(4, 'footer', '', '0'),
(5, 'post_first', '', '0'),
(6, 'post_second', '', '0'),
(7, 'post_third', '', '0');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Affiliates_Requests`
--

CREATE TABLE `Wo_Affiliates_Requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `amount` varchar(100) NOT NULL DEFAULT '0',
  `full_amount` varchar(100) NOT NULL DEFAULT '',
  `iban` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `country` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `full_name` varchar(150) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `swift_code` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `address` varchar(600) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_AgoraVideoCall`
--

CREATE TABLE `Wo_AgoraVideoCall` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL DEFAULT 0,
  `to_id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'video',
  `room_name` varchar(50) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT 0,
  `called` int(11) NOT NULL DEFAULT 0,
  `declined` int(11) NOT NULL DEFAULT 0,
  `access_token` text CHARACTER SET utf8 DEFAULT NULL,
  `access_token_2` text CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Albums_Media`
--

CREATE TABLE `Wo_Albums_Media` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `review_id` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Announcement`
--

CREATE TABLE `Wo_Announcement` (
  `id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `time` int(32) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Announcement_Views`
--

CREATE TABLE `Wo_Announcement_Views` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `announcement_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Apps`
--

CREATE TABLE `Wo_Apps` (
  `id` int(11) NOT NULL,
  `app_user_id` int(11) NOT NULL DEFAULT 0,
  `app_name` varchar(32) NOT NULL,
  `app_website_url` varchar(55) NOT NULL,
  `app_description` text NOT NULL,
  `app_avatar` varchar(100) NOT NULL DEFAULT 'upload/photos/app-default-icon.png',
  `app_callback_url` varchar(255) NOT NULL,
  `app_id` varchar(32) NOT NULL,
  `app_secret` varchar(55) NOT NULL,
  `active` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_AppsSessions`
--

CREATE TABLE `Wo_AppsSessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `session_id` varchar(120) NOT NULL DEFAULT '',
  `platform` varchar(32) NOT NULL DEFAULT '',
  `platform_details` text DEFAULT NULL,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Apps_Hash`
--

CREATE TABLE `Wo_Apps_Hash` (
  `id` int(11) NOT NULL,
  `hash_id` varchar(200) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `active` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Apps_Permission`
--

CREATE TABLE `Wo_Apps_Permission` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_AudioCalls`
--

CREATE TABLE `Wo_AudioCalls` (
  `id` int(11) NOT NULL,
  `call_id` varchar(30) NOT NULL DEFAULT '0',
  `access_token` text DEFAULT NULL,
  `call_id_2` varchar(30) NOT NULL DEFAULT '',
  `access_token_2` text DEFAULT NULL,
  `from_id` int(11) NOT NULL DEFAULT 0,
  `to_id` int(11) NOT NULL DEFAULT 0,
  `room_name` varchar(50) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT 0,
  `called` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `declined` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Bad_Login`
--

CREATE TABLE `Wo_Bad_Login` (
  `id` int(11) NOT NULL,
  `ip` varchar(100) NOT NULL DEFAULT '',
  `time` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Banned_Ip`
--

CREATE TABLE `Wo_Banned_Ip` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(32) NOT NULL DEFAULT '',
  `reason` varchar(1000) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Blocks`
--

CREATE TABLE `Wo_Blocks` (
  `id` int(11) NOT NULL,
  `blocker` int(11) NOT NULL DEFAULT 0,
  `blocked` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Blog`
--

CREATE TABLE `Wo_Blog` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL DEFAULT 0,
  `title` varchar(120) NOT NULL DEFAULT '',
  `content` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `posted` varchar(300) DEFAULT '0',
  `category` int(255) DEFAULT 0,
  `thumbnail` varchar(100) DEFAULT 'upload/photos/d-blog.jpg',
  `view` int(11) DEFAULT 0,
  `shared` int(11) DEFAULT 0,
  `tags` varchar(300) DEFAULT '',
  `active` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_BlogCommentReplies`
--

CREATE TABLE `Wo_BlogCommentReplies` (
  `id` int(11) NOT NULL,
  `comm_id` int(11) NOT NULL DEFAULT 0,
  `blog_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `text` text DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `posted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_BlogComments`
--

CREATE TABLE `Wo_BlogComments` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `posted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_BlogMovieDisLikes`
--

CREATE TABLE `Wo_BlogMovieDisLikes` (
  `id` int(11) NOT NULL,
  `blog_comm_id` int(20) NOT NULL DEFAULT 0,
  `blog_commreply_id` int(20) NOT NULL DEFAULT 0,
  `movie_comm_id` int(20) NOT NULL DEFAULT 0,
  `movie_commreply_id` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `blog_id` int(50) NOT NULL DEFAULT 0,
  `movie_id` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_BlogMovieLikes`
--

CREATE TABLE `Wo_BlogMovieLikes` (
  `id` int(11) NOT NULL,
  `blog_comm_id` int(20) NOT NULL DEFAULT 0,
  `blog_commreply_id` int(20) NOT NULL DEFAULT 0,
  `movie_comm_id` int(20) NOT NULL DEFAULT 0,
  `movie_commreply_id` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `blog_id` int(50) NOT NULL DEFAULT 0,
  `movie_id` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Blogs_Categories`
--

CREATE TABLE `Wo_Blogs_Categories` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Blogs_Categories`
--

INSERT INTO `Wo_Blogs_Categories` (`id`, `lang_key`) VALUES
(2, '1421'),
(3, '1424'),
(4, '1427'),
(5, '1430'),
(6, '1433'),
(7, '1436'),
(8, '1439'),
(9, '1442'),
(10, '1445'),
(11, '1448'),
(12, '1451'),
(13, '1454'),
(14, '1457'),
(15, '1460'),
(16, '1463'),
(17, '1466'),
(18, '1469');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Blog_Reaction`
--

CREATE TABLE `Wo_Blog_Reaction` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `blog_id` int(11) NOT NULL DEFAULT 0,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `reply_id` int(11) NOT NULL DEFAULT 0,
  `reaction` varchar(50) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Codes`
--

CREATE TABLE `Wo_Codes` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  `app_id` varchar(50) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Colored_Posts`
--

CREATE TABLE `Wo_Colored_Posts` (
  `id` int(11) NOT NULL,
  `color_1` varchar(50) NOT NULL DEFAULT '',
  `color_2` varchar(50) NOT NULL DEFAULT '',
  `text_color` varchar(50) NOT NULL DEFAULT '',
  `image` varchar(250) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_CommentLikes`
--

CREATE TABLE `Wo_CommentLikes` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Comments`
--

CREATE TABLE `Wo_Comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `record` varchar(255) NOT NULL DEFAULT '',
  `c_file` varchar(255) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_CommentWonders`
--

CREATE TABLE `Wo_CommentWonders` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Comment_Replies`
--

CREATE TABLE `Wo_Comment_Replies` (
  `id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_file` varchar(300) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Comment_Replies_Likes`
--

CREATE TABLE `Wo_Comment_Replies_Likes` (
  `id` int(11) NOT NULL,
  `reply_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Comment_Replies_Wonders`
--

CREATE TABLE `Wo_Comment_Replies_Wonders` (
  `id` int(11) NOT NULL,
  `reply_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Config`
--

CREATE TABLE `Wo_Config` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` varchar(20000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Config`
--

INSERT INTO `Wo_Config` (`id`, `name`, `value`) VALUES
(1, 'siteName', 'WoWonder'),
(2, 'siteTitle', 'WoWonder'),
(3, 'siteKeywords', 'social, wowonder, social site'),
(4, 'siteDesc', 'WoWonder v3.0.2 is a Social Networking Platform. With our new feature, user can wonder posts, photos,'),
(5, 'siteEmail', 'deendoughouz@gmail.com'),
(6, 'defualtLang', 'english'),
(7, 'emailValidation', '0'),
(8, 'emailNotification', '0'),
(9, 'fileSharing', '1'),
(10, 'seoLink', '1'),
(11, 'cacheSystem', '0'),
(12, 'chatSystem', '1'),
(13, 'useSeoFrindly', '1'),
(14, 'reCaptcha', '0'),
(15, 'reCaptchaKey', ''),
(16, 'user_lastseen', '1'),
(17, 'age', '1'),
(18, 'deleteAccount', '1'),
(19, 'connectivitySystem', '0'),
(20, 'profileVisit', '1'),
(21, 'maxUpload', '96000000'),
(22, 'maxCharacters', '640'),
(23, 'message_seen', '1'),
(24, 'message_typing', '1'),
(25, 'google_map_api', 'AIzaSyBOfpaMO_tMMsuvS2T4zx4llbtsFqMuT9Y'),
(26, 'allowedExtenstion', 'jpg,png,jpeg,gif,mkv,docx,zip,rar,pdf,doc,mp3,mp4,flv,wav,txt,mov,avi,webm,wav,mpeg'),
(27, 'censored_words', ''),
(28, 'googleAnalytics', ''),
(29, 'AllLogin', '0'),
(30, 'googleLogin', '0'),
(31, 'facebookLogin', '0'),
(32, 'twitterLogin', '0'),
(33, 'linkedinLogin', '0'),
(34, 'VkontakteLogin', '0'),
(35, 'facebookAppId', ''),
(36, 'facebookAppKey', ''),
(37, 'googleAppId', ''),
(38, 'googleAppKey', ''),
(39, 'twitterAppId', ''),
(40, 'twitterAppKey', ''),
(41, 'linkedinAppId', ''),
(42, 'linkedinAppKey', ''),
(43, 'VkontakteAppId', ''),
(44, 'VkontakteAppKey', ''),
(45, 'theme', 'wowonder'),
(46, 'second_post_button', 'reaction'),
(47, 'instagramAppId', ''),
(48, 'instagramAppkey', ''),
(49, 'instagramLogin', '0'),
(50, 'header_background', '#1e2321'),
(51, 'header_hover_border', '#333333'),
(52, 'header_color', '#ffffff'),
(53, 'body_background', '#f9f9f9'),
(54, 'btn_color', '#ffffff'),
(55, 'btn_background_color', '#a52729'),
(56, 'btn_hover_color', '#ffffff'),
(57, 'btn_hover_background_color', '#bf3737'),
(58, 'setting_header_color', '#ffffff'),
(59, 'setting_header_background', '#a84849'),
(60, 'setting_active_sidebar_color', '#ffffff'),
(61, 'setting_active_sidebar_background', '#a84849'),
(62, 'setting_sidebar_background', '#ffffff'),
(63, 'setting_sidebar_color', '#444444'),
(64, 'logo_extension', 'png'),
(65, 'online_sidebar', '1'),
(66, 'background_extension', 'jpg'),
(67, 'profile_privacy', '1'),
(68, 'video_upload', '1'),
(69, 'audio_upload', '1'),
(70, 'smtp_or_mail', 'mail'),
(71, 'smtp_username', ''),
(72, 'smtp_host', ''),
(73, 'smtp_password', ''),
(74, 'smtp_port', '587'),
(75, 'smtp_encryption', 'tls'),
(76, 'sms_or_email', 'mail'),
(77, 'sms_username', ''),
(78, 'sms_password', ''),
(79, 'sms_phone_number', ''),
(80, 'is_ok', '1'),
(81, 'pro', '1'),
(82, 'paypal_id', ''),
(83, 'paypal_secret', ''),
(84, 'paypal_mode', 'sandbox'),
(85, 'weekly_price', '3'),
(86, 'monthly_price', '8'),
(87, 'yearly_price', '89'),
(88, 'lifetime_price', '259'),
(89, 'post_limit', '40'),
(90, 'user_limit', '10'),
(91, 'css_upload', '0'),
(92, 'smooth_loading', '1'),
(93, 'header_search_color', '#0f1110'),
(94, 'header_button_shadow', '#ffffff'),
(95, 'currency', 'USD'),
(97, 'games', '1'),
(98, 'last_backup', '00-00-0000'),
(99, 'pages', '1'),
(100, 'groups', '1'),
(101, 'order_posts_by', '0'),
(102, 'btn_disabled', '#a52729'),
(103, 'developers_page', '1'),
(104, 'user_registration', '1'),
(105, 'maintenance_mode', '0'),
(106, 'video_chat', '0'),
(107, 'video_accountSid', ''),
(108, 'video_apiKeySid', ''),
(109, 'video_apiKeySecret', ''),
(110, 'video_configurationProfileSid', ''),
(111, 'eapi', ''),
(112, 'favicon_extension', 'png'),
(113, 'monthly_boosts', '5'),
(114, 'yearly_boosts', '20'),
(115, 'lifetime_boosts', '40'),
(116, 'chat_outgoing_background', '#fff9f9'),
(117, 'windows_app_version', '1.0'),
(118, 'widnows_app_api_id', '4bdde3b3317ae7e40a884fe280e0c72b'),
(119, 'widnows_app_api_key', 'd1283b82c0fd79aabbe18003dcc51adb'),
(120, 'stripe_id', ''),
(121, 'stripe_secret', ''),
(122, 'credit_card', 'no'),
(123, 'bitcoin', 'no'),
(124, 'm_withdrawal', '50'),
(125, 'amount_ref', '0.10'),
(126, 'affiliate_type', '0'),
(127, 'affiliate_system', '1'),
(128, 'classified', '1'),
(129, 'amazone_s3', '0'),
(130, 'bucket_name', ''),
(131, 'amazone_s3_key', ''),
(132, 'amazone_s3_s_key', ''),
(133, 'region', 'us-east-1'),
(134, 'alipay', 'no'),
(135, 'is_utf8', '1'),
(136, 'sms_t_phone_number', ''),
(137, 'audio_chat', '0'),
(138, 'sms_twilio_username', ''),
(139, 'sms_twilio_password', ''),
(140, 'sms_provider', 'twilio'),
(141, 'footer_background', ''),
(142, 'footer_background_2', ''),
(143, 'footer_text_color', ''),
(144, 'classified_currency', 'USD'),
(145, 'classified_currency_s', '$'),
(146, 'mime_types', 'text/plain,video/mp4,video/mov,video/mpeg,video/flv,video/avi,video/webm,audio/wav,audio/mpeg,video/quicktime,audio/mp3,image/png,image/jpeg,image/gif,application/pdf,application/msword,application/zip,application/x-rar-compressed,text/pdf,application/x-pointplus,text/css'),
(147, 'footer_background_n', ''),
(148, 'blogs', '1'),
(149, 'can_blogs', '1'),
(150, 'push', '0'),
(151, 'android_m_push_id', ''),
(152, 'android_m_push_key', ''),
(153, 'events', '1'),
(154, 'forum', '1'),
(155, 'last_update', '1554124551'),
(156, 'movies', '1'),
(157, 'yandex_translation_api', 'trnsl.1.1.20170601T212421Z.5834b565b8d47a18.2620528213fbf6ee3335f750659fc342e0ea7923'),
(158, 'update_db_15', '1503149537'),
(159, 'ad_v_price', '0.01'),
(160, 'ad_c_price', '0.05'),
(161, 'emo_cdn', 'https://cdnjs.cloudflare.com/ajax/libs/emojione/2.1.4/assets/png/'),
(162, 'user_ads', '1'),
(163, 'user_status', '1'),
(164, 'date_style', 'm/d/y'),
(165, 'stickers', '1'),
(166, 'giphy_api', '420d477a542b4287b2bf91ac134ae041'),
(167, 'find_friends', '1'),
(168, 'update_db_152', '1504450479'),
(169, 'android_push_native', '0'),
(170, 'android_push_messages', '0'),
(171, 'update_db_153', 'updated'),
(172, 'ads_currency', 'USD'),
(173, 'web_push', '0'),
(174, 'playtube_url', 'https://playtubescript.com'),
(175, 'connectivitySystemLimit', '5000'),
(176, 'video_ad_skip', '6'),
(177, 'update_user_profile', '120'),
(178, 'cache_sidebar', '1'),
(179, 'android_n_push_id', ''),
(180, 'android_n_push_key', ''),
(181, 'ftp_host', ''),
(182, 'ftp_port', '21'),
(183, 'ftp_username', ''),
(184, 'ftp_password', ''),
(185, 'ftp_upload', '0'),
(186, 'ftp_endpoint', ''),
(187, 'ftp_path', './'),
(188, 'transaction_log', 'yes'),
(189, 'coinpayments_secret', ''),
(190, 'coinpayments_id', ''),
(191, 'infobip_username', ''),
(192, 'infobip_password', ''),
(193, 'updatev2', 'done'),
(194, 'amount_percent_ref', '0'),
(195, 'gift_system', '0'),
(196, 'social_share_twitter', '1'),
(197, 'social_share_google', '1'),
(198, 'social_share_facebook', '1'),
(199, 'social_share_whatsup', '1'),
(200, 'social_share_pinterest', '1'),
(201, 'social_share_linkedin', '1'),
(202, 'social_share_telegram', '1'),
(203, 'stickers_system', '0'),
(204, 'dollar_to_point_cost', '1000'),
(205, 'comments_point', '10'),
(206, 'likes_point', '5'),
(207, 'dislikes_point', '2'),
(208, 'wonders_point', '3'),
(209, 'reaction_point', '5'),
(210, 'createpost_point', '15'),
(211, 'point_allow_withdrawal', '0'),
(212, 'sticky_video_player', '0'),
(213, 'point_level_system', '0'),
(214, 'comment_reports', '1'),
(215, 'popular_posts', '1'),
(216, 'auto_friend_users', ''),
(217, 'spaces_key', ''),
(218, 'spaces_secret', ''),
(219, 'space_name', ''),
(220, 'space_region', ''),
(221, 'spaces', '0'),
(222, 'watermark', '0'),
(223, 'google_map', '1'),
(224, 'login_auth', '0'),
(225, 'two_factor', '1'),
(226, 'two_factor_type', 'email'),
(227, 'last_notification_delete_run', '1645546002'),
(228, 'ios_push_messages', '0'),
(229, 'ios_m_push_id', ''),
(230, 'ios_m_push_key', ''),
(231, 'ios_push_native', '0'),
(232, 'ios_n_push_id', ''),
(233, 'ios_n_push_key', ''),
(234, 'web_push_id', ''),
(235, 'web_push_key', ''),
(236, 'profile_back', '0'),
(237, 'free_day_limit', '1000'),
(238, 'adult_images', '0'),
(239, 'adult_images_action', '1'),
(240, 'adult_images_file', ''),
(241, 'pro_day_limit', '2000'),
(242, 'vision_api_key', ''),
(243, 'bank_payment', 'yes'),
(244, 'bank_transfer_note', 'In order to confirm the bank transfer, you will need to upload a receipt or take a screenshot of your transfer within 1 day from your payment date. If a bank transfer is made but no receipt is uploaded within this period, your order will be cancelled. We will verify and confirm your receipt within 3 working days from the date you upload it.'),
(245, 'bank_description', '<div class=\"bank_info\">\r\n                        <div class=\"dt_settings_header bg_gradient\">\r\n                            <div class=\"dt_settings_circle-1\"></div>\r\n                            <div class=\"dt_settings_circle-2\"></div>\r\n                            <div class=\"bank_info_innr\">\r\n                                <svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\"><path fill=\"currentColor\" d=\"M11.5,1L2,6V8H21V6M16,10V17H19V10M2,22H21V19H2M10,10V17H13V10M4,10V17H7V10H4Z\"></path></svg>\r\n                                <h4 class=\"bank_name\">Garanti Bank</h4>\r\n                                <div class=\"row\">\r\n                                    <div class=\"col col-md-12\">\r\n                                        <div class=\"bank_account\">\r\n                                            <p>4796824372433055</p>\r\n                                            <span class=\"help-block\">Account number / IBAN</span>\r\n                                        </div>\r\n                                    </div>\r\n                                    <div class=\"col col-md-12\">\r\n                                        <div class=\"bank_account_holder\">\r\n                                            <p>Antoian Kordiyal</p>\r\n                                            <span class=\"help-block\">Account name</span>\r\n                                        </div>\r\n                                    </div>\r\n                                    <div class=\"col col-md-6\">\r\n                                        <div class=\"bank_account_code\">\r\n                                            <p>TGBATRISXXX</p>\r\n                                            <span class=\"help-block\">Routing code</span>\r\n                                        </div>\r\n                                    </div>\r\n                                    <div class=\"col col-md-6\">\r\n                                        <div class=\"bank_account_country\">\r\n                                            <p>United States</p>\r\n                                            <span class=\"help-block\">Country</span>\r\n                                        </div>\r\n                                    </div>\r\n                                </div>\r\n                            </div>\r\n                        </div>\r\n                    </div>'),
(246, 'recaptcha_secret_key', ''),
(247, 'createblog_point', '15'),
(248, 'deepsound_url', 'https://deepsoundscript.com'),
(249, 'english', '1'),
(250, 'arabic', '1'),
(251, 'dutch', '1'),
(252, 'french', '1'),
(253, 'german', '1'),
(254, 'italian', '1'),
(255, 'portuguese', '1'),
(256, 'russian', '1'),
(257, 'spanish', '1'),
(258, 'turkish', '1'),
(259, 'currency_array', '[\"USD\",\"EUR\",\"JPY\",\"TRY\",\"GBP\",\"RUB\",\"PLN\",\"ILS\",\"BRL\",\"INR\"]'),
(260, 'currency_symbol_array', '{\"USD\":\"&#36;\",\"EUR\":\"&#8364;\",\"JPY\":\"&#165;\",\"TRY\":\"&#8378;\",\"GBP\":\"&#163;\",\"RUB\":\"&#8381;\",\"PLN\":\"&#122;&#322;\",\"ILS\":\"&#8362;\",\"BRL\":\"&#82;&#36;\",\"INR\":\"&#8377;\"}'),
(261, 'paypal_currency', 'USD'),
(262, 'stripe_currency', 'USD'),
(263, '2checkout_currency', 'USD'),
(264, 'version', '4.0.1'),
(265, 'forum_visibility', '1'),
(266, 'events_visibility', '1'),
(267, 'product_visibility', '1'),
(268, 'paypal', 'no'),
(269, 'poke_system', '1'),
(270, 'afternoon_system', '1'),
(271, 'providers_array', ''),
(272, 'colored_posts_system', '0'),
(273, 'checkout_payment', 'no'),
(274, 'checkout_mode', 'sandbox'),
(275, 'checkout_seller_id', ''),
(276, 'checkout_publishable_key', ''),
(277, 'checkout_private_key', ''),
(278, 'job_system', '1'),
(279, 'weather_widget', '1'),
(280, 'common_things', '1'),
(281, 'funding_system', '1'),
(282, 'weather_key', ''),
(283, 'funding_request', 'all'),
(284, 'donate_percentage', '0'),
(285, 'post_approval', '0'),
(286, 'auto_page_like', ''),
(287, 'auto_group_join', ''),
(288, 'memories_system', '1'),
(289, 'membership_system', '0'),
(290, 'recurring_payment', 'off'),
(291, 'who_upload', 'all'),
(292, 'Who_call', 'all'),
(293, 'blog_approval', '0'),
(294, 'refund_system', 'on'),
(295, 'paystack_payment', 'no'),
(296, 'paystack_secret_key', ''),
(297, 'cashfree_payment', 'no'),
(298, 'cashfree_client_key', ''),
(299, 'cashfree_secret_key', ''),
(300, 'msg91_authKey', ''),
(301, 'offer_system', '1'),
(302, 'nearby_shop_system', '1'),
(303, 'nearby_business_system', '1'),
(304, 'prevent_system', '1'),
(305, 'bad_login_limit', '4'),
(306, 'lock_time', '10'),
(307, 'password_complexity_system', '0'),
(308, 'invite_links_system', '0'),
(309, 'user_links_limit', '10'),
(310, 'expire_user_links', 'month'),
(311, 'shout_box_system', '1'),
(312, 'bank_withdrawal_system', '1'),
(313, 'live_video', '0'),
(314, 'live_token', ''),
(315, 'live_account_id', ''),
(316, 'razorpay_payment', 'no'),
(317, 'razorpay_key_id', ''),
(318, 'razorpay_key_secret', ''),
(319, 'paysera_payment', 'no'),
(320, 'paysera_project_id', ''),
(321, 'paysera_sign_password', ''),
(322, 'paysera_mode', '1'),
(323, 'cloud_upload', '0'),
(324, 'cloud_file_path', ''),
(325, 'cloud_bucket_name', ''),
(326, 'live_video_save', '0'),
(327, 'notify_new_post', '0'),
(328, 'agora_app_id', ''),
(329, 'agora_live_video', '0'),
(330, 'millicast_live_video', '0'),
(331, 'agora_customer_id', ''),
(332, 'agora_customer_certificate', ''),
(333, 'yahoo_consumer_key', ''),
(334, 'yahoo_consumer_secret', ''),
(335, 'cashfree_mode', 'sandBox'),
(336, 'amazone_s3_2', '0'),
(337, 'bucket_name_2', ''),
(338, 'amazone_s3_key_2', ''),
(339, 'amazone_s3_s_key_2', ''),
(340, 'region_2', 'eu-west-1'),
(341, 'node_socket_flow', '0'),
(342, 'redis', 'N'),
(343, 'youtube_api_key', ''),
(344, 'redis_port', '3080'),
(345, 'nodejs_port', '3000'),
(346, 'nodejs_ssl', '0'),
(347, 'nodejs_key_path', ''),
(348, 'nodejs_cert_path', ''),
(349, 'nodejs_ssl_port', '449'),
(350, 'nodejs_live_notification', '1'),
(351, 'auto_username', '0'),
(352, 'agora_app_certificate', ''),
(353, 'agora_chat_video', '0'),
(354, 'agora_chat_app_id', ''),
(355, 'agora_chat_app_certificate', ''),
(356, 'agora_chat_customer_id', ''),
(357, 'agora_chat_customer_certificate', ''),
(358, 'qqLogin', '0'),
(359, 'qqAppId', ''),
(360, 'qqAppkey', ''),
(361, 'WeChatLogin', '0'),
(362, 'WeChatAppId', ''),
(363, 'WeChatAppkey', ''),
(364, 'DiscordLogin', '0'),
(365, 'DiscordAppId', ''),
(366, 'DiscordAppkey', ''),
(367, 'MailruLogin', '0'),
(368, 'MailruAppId', ''),
(369, 'MailruAppkey', ''),
(370, 'twilio_video_chat', '0'),
(371, 'ffmpeg_binary_file', './ffmpeg/ffmpeg'),
(372, 'ffmpeg_system', 'off'),
(373, 'convert_speed', 'fast'),
(374, 'allowedffmpegExtenstion', 'mov,mp4,m4a,3gp,3g2,mj2,asf,avi,flv,webm,m4v,mpeg,mpeg,mpeg,ogv,mkv,webm,mov'),
(375, 'ffmpeg_mime_types', 'application/vnd.ms-asf,video/x-msvideo,video/x-flv,video/webm,video/x-m4v,video/mp4,video/mpeg,video/ogg,video/x-matroska,video/quicktime,video/x-ms-wmv,video/x-msvideo'),
(376, 'msg91_dlt_id', ''),
(377, 'store_system', 'on'),
(378, 'exchange', ''),
(379, 'exchange_update', ''),
(380, 'store_commission', '0'),
(381, 'store_review_system', 'off'),
(382, 'website_mode', 'facebook'),
(383, 'post_location', '1'),
(384, 'post_feelings', '1'),
(385, 'post_poll', '1'),
(386, 'affiliate_level', '1'),
(387, 'coinbase_payment', '0'),
(388, 'coinbase_key', ''),
(389, 'wasabi_storage', '0'),
(390, 'wasabi_access_key', ''),
(391, 'wasabi_secret_key', ''),
(392, 'wasabi_bucket_name', ''),
(393, 'wasabi_bucket_region', 'us-west-1'),
(394, 'remember_device', '1'),
(395, 'infobip_api_key', ''),
(396, 'infobip_base_url', ''),
(397, 'yandex_map', '0'),
(398, 'yandex_map_api', ''),
(399, 'yoomoney_payment', '0'),
(400, 'yoomoney_wallet_id', ''),
(401, 'yoomoney_notifications_secret', ''),
(402, 'iyzipay_payment', '0'),
(403, 'iyzipay_mode', '1'),
(404, 'iyzipay_key', ''),
(405, 'iyzipay_secret_key', ''),
(406, 'iyzipay_buyer_id', ''),
(407, 'iyzipay_buyer_name', ''),
(408, 'iyzipay_buyer_surname', ''),
(409, 'iyzipay_buyer_gsm_number', ''),
(410, 'iyzipay_buyer_email', ''),
(411, 'iyzipay_identity_number', ''),
(412, 'iyzipay_address', ''),
(413, 'iyzipay_city', ''),
(414, 'iyzipay_country', ''),
(415, 'iyzipay_zip', ''),
(416, 'securionpay_payment', '0'),
(417, 'securionpay_public_key', ''),
(418, 'securionpay_secret_key', ''),
(419, 'authorize_payment', '0'),
(420, 'authorize_test_mode', 'SANDBOX'),
(421, 'authorize_login_id', ''),
(422, 'authorize_transaction_key', ''),
(423, 'OkLogin', '0'),
(424, 'OkAppId', ''),
(425, 'OkAppPublickey', ''),
(426, 'OkAppSecretkey', ''),
(427, 'native_android_messenger_url', ''),
(428, 'native_android_timeline_url', ''),
(429, 'native_ios_messenger_url', ''),
(430, 'native_ios_timeline_url', ''),
(431, 'native_windows_messenger_url', '');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_CustomPages`
--

CREATE TABLE `Wo_CustomPages` (
  `id` int(11) NOT NULL,
  `page_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `page_title` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `page_content` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `page_type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Custom_Fields`
--

CREATE TABLE `Wo_Custom_Fields` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `type` varchar(50) DEFAULT '',
  `length` int(11) NOT NULL DEFAULT 0,
  `placement` varchar(50) NOT NULL DEFAULT '',
  `required` varchar(11) NOT NULL DEFAULT 'on',
  `options` text DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Egoing`
--

CREATE TABLE `Wo_Egoing` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Einterested`
--

CREATE TABLE `Wo_Einterested` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Einvited`
--

CREATE TABLE `Wo_Einvited` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `inviter_id` int(11) NOT NULL,
  `invited_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Emails`
--

CREATE TABLE `Wo_Emails` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `email_to` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `subject` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `message` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Events`
--

CREATE TABLE `Wo_Events` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL DEFAULT '',
  `location` varchar(300) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date NOT NULL,
  `end_time` time NOT NULL,
  `poster_id` int(11) NOT NULL,
  `cover` varchar(500) NOT NULL DEFAULT 'upload/photos/d-cover.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Family`
--

CREATE TABLE `Wo_Family` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `member` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `requesting` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Followers`
--

CREATE TABLE `Wo_Followers` (
  `id` int(11) NOT NULL,
  `following_id` int(11) NOT NULL DEFAULT 0,
  `follower_id` int(11) NOT NULL DEFAULT 0,
  `is_typing` int(11) NOT NULL DEFAULT 0,
  `active` int(255) NOT NULL DEFAULT 1,
  `notify` int(11) NOT NULL DEFAULT 0,
  `time` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Forums`
--

CREATE TABLE `Wo_Forums` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '',
  `description` varchar(300) NOT NULL DEFAULT '',
  `sections` int(11) NOT NULL DEFAULT 0,
  `posts` int(11) NOT NULL DEFAULT 0,
  `last_post` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_ForumThreadReplies`
--

CREATE TABLE `Wo_ForumThreadReplies` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL DEFAULT 0,
  `forum_id` int(11) NOT NULL DEFAULT 0,
  `poster_id` int(11) NOT NULL DEFAULT 0,
  `post_subject` varchar(300) NOT NULL DEFAULT '',
  `post_text` text NOT NULL,
  `post_quoted` int(11) NOT NULL DEFAULT 0,
  `posted_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Forum_Sections`
--

CREATE TABLE `Wo_Forum_Sections` (
  `id` int(11) NOT NULL,
  `section_name` varchar(200) NOT NULL DEFAULT '',
  `description` varchar(300) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Forum_Threads`
--

CREATE TABLE `Wo_Forum_Threads` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `headline` varchar(300) NOT NULL DEFAULT '',
  `post` text NOT NULL,
  `posted` varchar(20) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT 0,
  `forum` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Funding`
--

CREATE TABLE `Wo_Funding` (
  `id` int(11) NOT NULL,
  `hashed_id` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(600) NOT NULL DEFAULT '',
  `amount` varchar(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `image` varchar(200) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Funding_Raise`
--

CREATE TABLE `Wo_Funding_Raise` (
  `id` int(11) NOT NULL,
  `funding_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `amount` varchar(11) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Games`
--

CREATE TABLE `Wo_Games` (
  `id` int(11) NOT NULL,
  `game_name` varchar(50) NOT NULL,
  `game_avatar` varchar(100) NOT NULL,
  `game_link` varchar(100) NOT NULL,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Games_Players`
--

CREATE TABLE `Wo_Games_Players` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `game_id` int(11) NOT NULL DEFAULT 0,
  `last_play` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Gender`
--

CREATE TABLE `Wo_Gender` (
  `id` int(11) NOT NULL,
  `gender_id` varchar(50) NOT NULL DEFAULT '0',
  `image` varchar(300) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Gifts`
--

CREATE TABLE `Wo_Gifts` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `media_file` varchar(250) NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_GroupAdmins`
--

CREATE TABLE `Wo_GroupAdmins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `general` int(11) NOT NULL DEFAULT 1,
  `privacy` int(11) NOT NULL DEFAULT 1,
  `avatar` int(11) NOT NULL DEFAULT 1,
  `members` int(11) NOT NULL DEFAULT 0,
  `analytics` int(11) NOT NULL DEFAULT 1,
  `delete_group` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_GroupChat`
--

CREATE TABLE `Wo_GroupChat` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `avatar` varchar(3000) NOT NULL DEFAULT 'upload/photos/d-group.jpg',
  `time` varchar(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_GroupChatUsers`
--

CREATE TABLE `Wo_GroupChatUsers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `active` enum('1','0') NOT NULL DEFAULT '1',
  `last_seen` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Groups`
--

CREATE TABLE `Wo_Groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `group_name` varchar(32) NOT NULL DEFAULT '',
  `group_title` varchar(40) NOT NULL DEFAULT '',
  `avatar` varchar(120) NOT NULL DEFAULT 'upload/photos/d-group.jpg ',
  `cover` varchar(120) NOT NULL DEFAULT 'upload/photos/d-cover.jpg  ',
  `about` varchar(550) NOT NULL DEFAULT '',
  `category` int(11) NOT NULL DEFAULT 1,
  `sub_category` varchar(50) NOT NULL DEFAULT '',
  `privacy` enum('1','2') NOT NULL DEFAULT '1',
  `join_privacy` enum('1','2') NOT NULL DEFAULT '1',
  `active` enum('0','1') NOT NULL DEFAULT '0',
  `registered` varchar(32) NOT NULL DEFAULT '0/0000',
  `time` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Groups_Categories`
--

CREATE TABLE `Wo_Groups_Categories` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Groups_Categories`
--

INSERT INTO `Wo_Groups_Categories` (`id`, `lang_key`) VALUES
(2, '1420'),
(3, '1423'),
(4, '1426'),
(5, '1429'),
(6, '1432'),
(7, '1435'),
(8, '1438'),
(9, '1441'),
(10, '1444'),
(11, '1447'),
(12, '1450'),
(13, '1453'),
(14, '1456'),
(15, '1459'),
(16, '1462'),
(17, '1465'),
(18, '1468');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Group_Members`
--

CREATE TABLE `Wo_Group_Members` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Hashtags`
--

CREATE TABLE `Wo_Hashtags` (
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL DEFAULT '',
  `tag` varchar(255) NOT NULL DEFAULT '',
  `last_trend_time` int(11) NOT NULL DEFAULT 0,
  `trend_use_num` int(11) NOT NULL DEFAULT 0,
  `expire` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_HiddenPosts`
--

CREATE TABLE `Wo_HiddenPosts` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_HTML_Emails`
--

CREATE TABLE `Wo_HTML_Emails` (
  `id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Wo_HTML_Emails`
--

INSERT INTO `Wo_HTML_Emails` (`id`, `name`, `value`) VALUES
(1, 'activate', '<p> </p>\n<p>Actionable emails e.g. reset password</p>\n<table class=\"body-wrap\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;\" bgcolor=\"#f6f6f6\">\n<tbody>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;\" valign=\"top\"> </td>\n<td class=\"container\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;\" valign=\"top\" width=\"600\">\n<div class=\"content\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;\">\n<table class=\"main\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#fff\">\n<tbody>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-wrap\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 20px;\" valign=\"top\">\n<table style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-block\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\" valign=\"top\">\n<h3>Hello {{USERNAME}},</h3>\nThank you for joining our community.</td>\n</tr>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-block\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\" valign=\"top\">Please confirm your email address by clicking the link below.</td>\n</tr>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-block\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\" valign=\"top\"><a class=\"btn-primary\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; color: #fff; text-decoration: none; line-height: 2em; font-weight: bold; text-align: center; cursor: pointer; display: inline-block; border-radius: 5px; text-transform: capitalize; background-color: #a84849; margin: 0; border-color: #a84849; border-style: solid; border-width: 10px 20px;\" href=\"{{SITE_URL}}/index.php?link1=activate&amp;email={{EMAIL}}&amp;code={{CODE}}\">Confirm email address</a></td>\n</tr>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-block\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\" valign=\"top\">{{SITE_NAME}} Team.</td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</div>\n</td>\n<td style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;\" valign=\"top\"> </td>\n</tr>\n</tbody>\n</table>'),
(2, 'invite', '<p>Hi there, <br /><br /> You have received an invitation request from your friend <a style=\"color: {{backgound_color}};\" href=\"{{URL}}\">{{NAME}}</a> to join our social network community <a style=\"color: {{backgound_color}};\" href=\"{{SITE_URL}}/register?ref={{USERNAME}}\">{{SITE_NAME}}</a>.<br /><br /> <a style=\"color: &lt;?php echo $wo[\'config\'][\'btn_background_color\'];\" href=\"{{SITE_URL}}/register?ref={{USERNAME}}\">Let\'s contact &amp; find your friends !</a> <br /><br /> {{SITE_NAME}} Team. <br /> Best regards.</p>'),
(3, 'login_with', '<p>Hello {{FIRST_NAME}}, <br /><br /> Thank you for joining {{SITE_NAME}}!<br /><br /> Your temporary login credentials are: <br /><br /> Username: {{USERNAME}}<br /> Password: {{EMAIL}}<br /><br /> Please change your password as soon as possible to fully secure your account. <br /><br /> Best Regards,<br /> {{SITE_NAME}} Team.</p>'),
(4, 'notification', '<p> </p>\n<table class=\"body-wrap\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;\" bgcolor=\"#f6f6f6\">\n<tbody>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;\" valign=\"top\"> </td>\n<td class=\"container\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;\" valign=\"top\" width=\"600\">\n<div class=\"content\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;\">\n<table class=\"main\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#fff\">\n<tbody>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"alert alert-warning\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 16px; vertical-align: top; color: #fff; font-weight: 500; text-align: center; border-radius: 3px 3px 0 0; background-color: #e24141; margin: 0; padding: 10px;\" align=\"center\" valign=\"top\" bgcolor=\"#FF9F00\">New notification from {{SITE_NAME}}</td>\n</tr>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-wrap\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 20px;\" valign=\"top\">\n<table style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-block\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\" valign=\"top\"><a style=\"text-decoration: none; color: #444;\" href=\"{{NOTIFY_URL}}\"><img style=\"width: 60px; float: left; border-radius: 100px; margin-right: 10px;\" src=\"{{NOTIFY_AVATAR}}\" alt=\"\" /> {{NOTIFY_NAME}}</a>\n<div style=\"color: #666; font-size: 12px;\"><strong> {{TEXT_TYPE}}: </strong> {{TEXT}}</div>\n</td>\n</tr>\n<tr style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n<td class=\"content-block\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 5px;\" valign=\"top\"><a class=\"btn-primary\" style=\"font-family: \'Helvetica Neue\',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 12px; color: #fff; text-decoration: none; line-height: 2em; font-weight: bold; text-align: center; cursor: pointer; display: inline-block; border-radius: 5px; text-transform: capitalize; background-color: #a84849; margin: 0; border-color: #a84849; border-style: solid; border-width: 4px 10px;\" href=\"{{URL}}\">View on {{SITE_NAME}}</a></td>\n</tr>\n</tbody>\n</table>\n</td>\n</tr>\n</tbody>\n</table>\n</div>\n</td>\n</tr>\n</tbody>\n</table>'),
(5, 'payment_declined', '<p>Hello {{name}}, <br /><br /> Unfortunately your payment of ${{amount}} was declined. <br /><br /> For more info, please reply to this email. <br /><br /> Kind regards,<br /> {{site_name}} Team</p>'),
(6, 'payment_approved', '<p>Hello {{name}}, <br /><br /> Your payment request of ${{amount}} is approved. <br /><br /> We have sent you money ! <br /><br /> Kind regards,<br /> {{site_name}} Team</p>'),
(7, 'recover', '<p>Hello {{USERNAME}}, <br /> <br /> To reset your password <a href=\"{{LINK}}\">Click Here</a> <br /><br /> {{SITE_NAME}} Team, <br /> Regards,</p>'),
(8, 'unusual_login', '<p>Hi {{USERNAME}},<br /><br /> Please verify that it’s you<br /><br /> Your sign in attempt seems a little different than usual. This could be because you are signing in from a different device or a different location.<br /><br /> If you are attempting to sign-in, please use the following code to confirm your identity:<br /><br /> {{CODE}}<br /><br /> Here are the details of the sign-in attempt:<br /> Date: {{DATE}}<br /> Account: {{EMAIL}}<br /> Location: {{COUNTRY_CODE}}<br /> IP Address: {{IP_ADDRESS}}<br /> City: {{CITY}}<br /><br /> If this wasn’t you, please reset your password.<br /><br /> Yours securely,<br /> Team {{SITE_NAME}}</p>'),
(9, 'account_deleted', 'Hi {{name}},<br><br> We are here to inform you that your account on {{SITE_NAME}} was deleted and all your data were erased.<br><br>Best regards,<br> {{SITE_NAME}} team.');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Invitation_Links`
--

CREATE TABLE `Wo_Invitation_Links` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `invited_id` int(11) NOT NULL DEFAULT 0,
  `code` varchar(300) NOT NULL DEFAULT '',
  `time` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Job`
--

CREATE TABLE `Wo_Job` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `title` varchar(200) NOT NULL DEFAULT '',
  `location` varchar(100) NOT NULL DEFAULT '',
  `lat` varchar(50) NOT NULL DEFAULT '',
  `lng` varchar(50) NOT NULL DEFAULT '',
  `minimum` varchar(50) NOT NULL DEFAULT '0',
  `maximum` varchar(50) NOT NULL DEFAULT '0',
  `salary_date` varchar(50) NOT NULL DEFAULT '',
  `job_type` varchar(50) NOT NULL DEFAULT '',
  `category` varchar(50) NOT NULL DEFAULT '',
  `question_one` varchar(200) NOT NULL DEFAULT '',
  `question_one_type` varchar(100) NOT NULL DEFAULT '',
  `question_one_answers` text DEFAULT NULL,
  `question_two` varchar(200) NOT NULL DEFAULT '',
  `question_two_type` varchar(100) NOT NULL DEFAULT '',
  `question_two_answers` text DEFAULT NULL,
  `question_three` varchar(200) NOT NULL DEFAULT '',
  `question_three_type` varchar(100) NOT NULL DEFAULT '',
  `question_three_answers` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(300) NOT NULL DEFAULT '',
  `image_type` varchar(11) NOT NULL DEFAULT '',
  `currency` varchar(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT 1,
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Job_Apply`
--

CREATE TABLE `Wo_Job_Apply` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `job_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `user_name` varchar(100) NOT NULL DEFAULT '',
  `phone_number` varchar(50) NOT NULL DEFAULT '',
  `location` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `question_one_answer` varchar(200) NOT NULL DEFAULT '',
  `question_two_answer` varchar(200) NOT NULL DEFAULT '',
  `question_three_answer` varchar(200) NOT NULL DEFAULT '',
  `position` varchar(100) NOT NULL DEFAULT '',
  `where_did_you_work` varchar(100) NOT NULL DEFAULT '',
  `experience_description` varchar(300) NOT NULL DEFAULT '',
  `experience_start_date` varchar(50) NOT NULL DEFAULT '',
  `experience_end_date` varchar(50) NOT NULL DEFAULT '',
  `time` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Job_Categories`
--

CREATE TABLE `Wo_Job_Categories` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Job_Categories`
--

INSERT INTO `Wo_Job_Categories` (`id`, `lang_key`) VALUES
(1, '1580'),
(2, '1581'),
(3, '1582'),
(4, '1583'),
(5, '1584'),
(6, '1585'),
(7, '1586'),
(8, '1587'),
(9, '1588'),
(10, '1589'),
(11, '1590'),
(12, '1591'),
(13, '1592'),
(14, '1593'),
(15, '1594'),
(16, '1595'),
(17, '1596'),
(18, '1597'),
(19, '1598'),
(20, '1599'),
(21, '1600'),
(22, '1601'),
(23, '1602');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Langs`
--

CREATE TABLE `Wo_Langs` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(100) NOT NULL DEFAULT '',
  `english` text DEFAULT NULL,
  `arabic` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dutch` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `french` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `german` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `italian` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `portuguese` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `russian` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `spanish` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `turkish` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Langs`
--

INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1, 'login', '', 'Login', 'تسجيل الدخول', 'Inloggen', 'S&#39;identifier', 'Anmelden', 'Entra', 'Login', 'Вход', 'Acceder', 'Giriş'),
(2, 'register', '', 'Register', 'التسجيل', 'Registereren', 'Enregistrez', 'Registrieren', 'Iscriviti', 'Registrar', 'Регистрация', 'Registrar', 'Kayıt'),
(3, 'guest', '', 'Guest', 'زائر', 'Gast', 'Client', 'Gast', 'Ospite', 'Visitante', 'Гость', 'Huésped', 'Konuk'),
(4, 'username', '', 'Username', 'اسم المستخدم', 'Gebruikersnaam', 'le nom d&#39;utilisateur', 'Benutzername', 'Nome Utente', 'Nome de usu&amp;aacute;rio', 'Имя пользователя', 'Nombre de Usuario', 'Kullanıcı adı'),
(5, 'email', '', 'E-mail', 'البريد الإلكتروني', 'E-mail', 'E-mail', 'Email', 'E-mail', 'E-mail', 'E-mail адрес', 'E-mail', 'E-posta'),
(6, 'password', '', 'Password', 'كلمة المرور', 'Wachtwoord', 'Mot de passe', 'Passwort', 'Password', 'Senha', 'Пароль', 'Contraseña', 'Şifre'),
(7, 'new_password', '', 'New password', 'كلمة المرورالجديدة', 'Nieuw wachtwoord', 'Nouveau mot de passe', 'Neues Passwort', 'Nuova password', 'Nova senha', 'Новый пароль', 'Nueva Contraseña', 'Yeni Şifre'),
(8, 'remember_me', '', 'Remember me', 'تذكرني', 'Onthoud mij', 'Souviens-toi de moi', 'Angemeldet bleiben', 'Resta collegato', 'Lembrar', 'Запомнить меня', 'Recordarme', 'Beni hatırla'),
(9, 'or_login_with', '', 'Or login with', 'أو أدخل عن طريق', 'Of login met', 'Ou connectez-vous avec', 'oder Anmeldung mit', 'o entra con', 'Ou ent&amp;atilde;o fa&amp;ccedil;a login por', 'Или войдите через', 'O Acceder con:', 'Ya ile giriş'),
(10, 'forget_password', '', 'Forgot Password?', 'هل نسيت كلمة المرور؟', 'Wachtwoord vergeten?', 'Mot de passe oublié?', 'Passwort Vergessen?', 'Password dimenticata?', 'Esqueceu sua senha?', 'Забыли пароль?', '¿Olvidaste tu Contraseña?', 'Parolanızı unuttunuz mu?'),
(11, 'email_address', '', 'E-mail address', 'البريد الإلكتروني', 'Email', 'E-mail address', 'Emailadresse', 'Indirizo email', 'E-mail', 'E-mail адрес', 'Direcci&amp;oacute; de E-mail', 'E-posta'),
(12, 'confirm_password', '', 'Confirm Password', 'تأكيد كلمة المرور', 'Bevestig wachtwoord', 'Confirmez le mot de passe', 'Passwort bestätigen', 'Conferma Password', 'Confirmar senha', 'Подтвердите Пароль', 'Confirmar Contraseña', 'Şifreyi Onayla'),
(13, 'lets_go', '', 'Let&#039;s Go !', 'تسجيل', 'Ga verder!', 'Allons-y!', 'Los gehts!', 'Andiamo! !', 'Vamos l&amp;aacute;!', 'Войти!', '¡Vamos!', 'Haydi gidelim !'),
(14, 'recover_password', '', 'Recover', 'إعادة تعيين', 'Recover', 'Récupérer', 'Passwort wiederherstellen', 'Recuperare', 'Recuperar', 'Отправить', 'Recuperar', 'Kurtarmak'),
(15, 'reset_new_password_label', '', 'Reset Your Password', 'إعادة تعيين كلمة المرور', 'Reset Je Wachtwoord', 'Réinitialisez votre mot de passe', 'Passwort zurücksetzen', 'Resetta la tua password', 'Redefinir senha', 'Сбросить пароль', 'Reiniciar Contraseña', 'Şifrenizi sıfırlamak'),
(16, 'reset_password', '', 'Reset', 'إعادة تعيين', 'Reset', 'Réinitialiser', 'Zurücksetzen', 'Resetta', 'Resetar', 'Сброс', 'Reiniciar', 'Reset'),
(17, 'invalid_token', '', 'Invalid Token', 'رابط خاطأ', 'Verkeerde sleutel', 'Jeton Invalide', 'Ungültiges Zeichen', 'Gettone non valido', 'Token inv&amp;aacute;lido', 'Недопустимый маркер', 'Token Invalido', 'Geçersiz Jetonu'),
(18, 'incorrect_username_or_password_label', '', 'Incorrect username or password', 'اسم المستخدم أو كلمة المرور غير صحيح', 'Gebruikersnaam of wachtwoord klopt niet', 'Identifiant ou mot de passe incorrect', 'Benutzername oder Passwort falsch', 'Nome utente o password errati', 'Nome de usu&amp;aacute;rio ou senha incorreto', 'Неверное имя пользователя или пароль', 'Usuario y/o Contraseña incorrectos', 'Yanlış kullanıcı adı ya da parola'),
(19, 'account_disbaled_contanct_admin_label', '', 'Your account has been disabled, please contact us .', 'لقد تم إيقاف حسابك مؤقتاَ , يرجى الإتصال بنا .', 'Je account is inactief gesteld. Neem contact op met account@babster.nl.', 'Votre compte a été désactivé, s&#39;il vous plaît contactez-nous .', 'Dein Konto wurde deaktiviert. Bitte setze dich mit uns in Verbindung.', 'Il tuo account è stato disabilitato, non esitate a contattarci.', 'Sua conta foi desativada.', 'Ваш аккаунт был отключен, пожалуйста, свяжитесь с нами.', 'Tu cuenta ha sido des habilitada, por favor cont&amp;aacute;ctanos .', 'Hesabınız devre dışı bırakıldı, lütfen bize ulaşın.'),
(20, 'account_not_active_label', '', 'You have to activate your account.', 'يجب عليك تفعيل الحساب', 'Je moet je account eerst activeren.', 'Vous devez activer votre compte.', 'Bitte aktiviere dein Konto.', 'Devi attivare il tuo account.', 'Voc&amp;ecirc; tem que ativar sua conta.', 'Вы должны активировать свою учетную запись.', 'Primero debes activar tu cuenta.', 'Hesabınızı etkinleştirmek gerekiyor.'),
(21, 'successfully_logged_label', '', 'Successfully Logged in, Please wait..', 'تم تسجيل الدخول .. الرجاء الإنتظار', 'Succesvol ingelogt, een momentje..', 'Connecté avec succès, S&#39;il vous plaît attendre..', 'Erfolgreich angemeldet, bitte warten..', 'Collegato con successo, Siete pregati di attendere..', 'Login efetuado com sucesso. Por favor aguarde...', 'Успешный вход. Пожалуйста, подождите...', 'Acceso permitido, por favor espere..', 'Başarıyla Girildi, lütfen bekleyin ..'),
(22, 'please_check_details', '', 'Please check your details.', 'الرجاء مراجعة المعلومات التي أدخلتها', 'Controleer je details.', 'S&#39;il vous plaît vérifier vos coordonnées.', 'Bitte überprüfe deine Angaben.', 'Si prega di verificare i tuoi dati.', 'Por favor marque os detalhes', 'Пожалуйста, проверьте свои данные.', 'Por favor revisa tus detalles.', 'Bilgilerinizi kontrol edin.'),
(23, 'username_exists', '', 'Username is already exists.', 'اسم المستخدم موجود بالفعل', 'Gebruikersnaam bestaad al.', 'Nom d&#39;utilisateur est existe déjà.', 'Benutzername existiert bereits.', 'Il nome utente è già esistente.', 'Desculpe, este nome de usu&amp;aacute;rio j&amp;aacute; esta em uso.', 'Имя пользователя уже существует.', 'Nombre de usuario ya existe.', 'Kullanıcı adı zaten var olduğunu.'),
(24, 'username_characters_length', '', 'Username must be between 5 / 32', 'اسم المستخدم يجب ان يكون بين 5 إلى 32 حرف', 'Gebruikersnaam moet tussen de 5 en 32 tekens lang zijn', 'Nom d&#39;utilisateur doit être comprise entre 5/32', 'Benutzername muss zwischen 5 und 32 Zeichen sein', 'Nome utente deve essere compresa tra 5 a 32 lettere', 'O nome de usu&amp;aacute;rio deve conter entre 5 / 32 caracteres.', 'Имя пользователя должно быть между 5/32 символами', 'Nombre de usuario debe ser de entre 5 / 32 caracteres', 'Kullanıcı adı 5/32 arasında olmalıdır'),
(25, 'username_invalid_characters', '', 'Invalid username characters', 'صيغة اسم المستخدم خاطئة، الرجاء كتابة اسم المستخدم بالإنجليزية وبلا مسافة مثال enbrash', 'Ongeldige tekens in je gebruikersnaam', 'Caractères de nom d&#39;utilisateur non valides', 'Benutzername enthält unzulässige Zeichen', 'Caratteri Nome utente non valido', 'Caracteres inv&amp;aacute;lidos', 'Недопустимые символы в Имени пользователя', 'Caracteres Inv&amp;aacute;lidos', 'Geçersiz kullanıcı adı karakterleri'),
(26, 'password_invalid_characters', '', 'Invalid password characters', 'صيغة كلمة المرور خاطئة', 'Ongeldige tekens in je wachtwoord', 'Caractères de mot de passe invalide', 'Passwort enthält unzulässige Zeichen', 'Caratteri della password non validi', 'Caracteres inv&amp;aacute;lidos', 'Недопустимые символы в пароле', 'Caracteres Inv&amp;aacute;lidos', 'Geçersiz şifre karakteri'),
(27, 'email_exists', '', 'This e-mail is already in use', 'البريد الإلكتروني مستخدم بالفعل', 'Dit email adres is al ingebruik.', 'Cet e-mail est déjà utilisée', 'Emailadresse wird bereits benutzt', 'Questa e-mail è già in uso', 'J&amp;aacute; existe uma conta registrar nesse e-mail.', 'E-mail адре уже используется', 'Este correo ya est&amp;aacute; en uso', 'E-posta kullanımda'),
(28, 'email_invalid_characters', '', 'This e-mail is invalid.', 'صيغة البريد الإلكتروني خاطئة', 'Dit is een ongeldige email.', 'Cet e-mail est invalide.', 'Ungültige Emailadresse.', 'Questa e-mail non è valido.', 'E-mail inv&amp;aacute;lido.', 'Недействительный адрес электронной почты.', 'Este correo es invalido.', 'E-posta geçersiz.'),
(29, 'password_short', '', 'Password is too short.', 'كلمة المرور قصيرة جداَ', 'Wachtwoord is te kort.', 'Mot de passe est trop court.', 'Passwort ist zu kurz.', 'La password è troppo corta.', 'Senha muito pequena.', 'Пароль слишком короткий.', 'Contrase&amp;ntilde;a muy corta.', 'Şifre çok kısa.'),
(30, 'password_mismatch', '', 'Password not match.', 'كلمة المرور غير متطابقة', 'Wachtwoorden komen niet overeen.', 'Mot de passe ne correspond.', 'Passwörter stimmen nicht überein.', 'La password non corrisponde.', 'As senhas n&amp;atilde;o conferem.', 'Пароли не совпадают.', 'Contrase&amp;ntilde; diferente.', 'Şifre eşleşmiyor.'),
(31, 'reCaptcha_error', 'Please check the re-captcha.', 'Please check the re-captcha.', 'يرجى التحقق من إعادة اختبار captcha.', 'Controleer de re-captcha.', 'S&#039;il vous plaît vérifier le re-captcha.', 'Bitte überprüfen Sie das Captcha erneut.', 'Si prega di controllare il re-captcha.', 'Por favor, verifique o re-captcha.', 'Пожалуйста, проверьте повторную капчу.', 'Por favor, compruebe el re-captcha.', 'Lütfen re-captcha&#039;yı kontrol edin.'),
(32, 'successfully_joined_label', '', 'Successfully joined, Please wait..', 'تم الإشتراك بنجاح , الرجاء الإنتظار ..', 'Succesvol geregistreerd, een momentje..', 'Réussir rejoint, S&#39;il vous plaît attendre..', 'Erfolgreich beigetreten, bitte warten..', 'Iscrizione con sucesso, attendere prego..', 'Registrado com sucesso, Por favor aguarde..', 'Успешный вход. Пожалуйста, подождите...', 'Unido satisfactoriamente, Por favor espera..', 'Başarıyla katıldı! Lütfen bekleyin ..'),
(33, 'account_activation', '', 'Account Activation', 'تفعيل الحساب', 'Account activicatie', 'Activation de compte', 'Konto Aktivierung', 'Account attivato', 'Ativa&amp;ccedil;&amp;atilde;o de Conta', 'Активация аккаунта', 'Activaci&amp;oacute;n de cuenta', 'Hesap Aktivasyonu'),
(34, 'successfully_joined_verify_label', '', 'Registration successful! We have sent you an email, Please check your inbox/spam to verify your email.', 'تم الإشتراك بنجاح! لقد تم إرسال رمز التعيل إلى بريدك الإلكتروني', 'Succesvol geregistreerd, check je inbox/spam voor de activicatie mail.', 'Inscription réussi! Nous vous avons envoyé un e-mail, S&#39;il vous plaît vérifier votre boîte de réception / spam pour vérifier votre email.', 'Registrierung war erfolgreich! Wir haben dir eine Email gesandt: Bitte überprüfe dein Postfach und Spamordner zum aktivieren deines Kontos.', 'Registrazione di successo! Ti abbiamo inviato una e-mail, controlla la tua posta in arrivo / spam per verificare la tua email.', 'Registrado com sucesso! Enviamos um email, verifique a caixa de entrada/spam para verificar seu e-mail.', 'Поздравляем вы успешно зарегистрировались! Мы отправили Вам письмо с ссылкой для подтверждения регистрации. Пожалуйста, проверьте ваш почтовый ящик. Рекомендуем проверить папку «Спам» — возможно письмо попало туда.', 'Registro exitoso, te hemos enviado un correo de verificaci&amp;oacute;n, Revisa tu bandeja de entrada de correo.', 'Kayıt başarılı! Size bir e-posta gönderdik, e-postanızı doğrulamak için gelen / spam kontrol edin.'),
(35, 'email_not_found', '', 'We can&#039;t find this email.', 'البريد الإلكتروني غير موجود', 'We kunnen deze email niet vinden.', 'Nous ne pouvons pas trouver cet e-mail.', 'Email konnte nicht gefunden werden.', 'Non e possibile trovare questo indirizzo mail.', 'n&amp;atilde;o podemos encontrar este e-mail.', 'Мы не можем найти этот E-mail.', 'No encontramos este E-mail.', 'Biz bu e-postayı bulamıyor.'),
(36, 'password_rest_request', '', 'Password reset request', 'طلب إعادة تعيين كلمة المرور', 'Wachtwoord reset aanvraag', 'Demande de réinitialisation de mot', 'Passwort-Reset-Anfrage', 'Richiesta di reimpostazione della password', 'Pedido para resetar senha', 'Запрос Восстановление пароля', 'Solicitud de reinicio de contraseña', 'Parola sıfırlama isteği'),
(37, 'email_sent', '', 'E-mail has been sent successfully', 'لقد تم إرسال الرسالة', 'Email is succesvol verzonden', 'Le courriel a été envoyé avec succès', 'Email wurde erfolgreich versendet', 'E-mail è stata inviata con successo', 'E-mail enviado com sucesso.', 'Письмо отправлено', 'Correo enviado correctamente', 'E-posta başarıyla gönderildi'),
(38, 'processing_error', '', 'An error found while processing your request, please try again later.', 'حدث خطأ عند المعالجة , الرجاء المحاولة لاحقاَ', 'Er is een fout opgetreden, probeer het later nog eens.', 'Une erreur est survenue lors du traitement de votre demande, s&#39;il vous plaît réessayer plus tard.', 'In der Bearbeitung wurde ein Fehler festgestellt. Bitte versuche es später noch einmal.', 'Un errore durante l&#039;elaborazione della richiesta, riprova più tardi.', 'Algo de errado aconteceu. Por favor, tente novamente mais tarde.', 'Обнаружена ошибка при обработке вашего запроса, пожалуйста, попробуйте еще раз', 'Un error a ocurrido procesando tu solicitud, Intenta de nuevo mas tarde.', 'İsteğiniz işlenirken hata, lütfen tekrar deneyiniz bulundu'),
(39, 'password_changed', '', 'Password successfully changed !', 'تم تغيير كلمة المرور بنجاح', 'Wachtwoord succesvol gewijzigd !', 'Mot de passe changé avec succès !', 'Passwort erfolgreich geändert!', 'Password cambiata con successo!', 'Senha trocada com sucesso !', 'Пароль успешно изменен!', '¡ Contrase&amp;ntilde;a modificada correctamente !', 'Şifre başarıyla değiştirildi !'),
(40, 'please_choose_correct_date', '', 'Please choose a correct date.', 'الرجاء أختيار تاريخ الميلاد الصحيح', 'Selecteer een geldige datum.', 'S&#39;il vous plaît choisir une date correcte.', 'Bitte gebe ein korrektes Datum an.', 'Scegliere una data corretta.', 'Selecione uma data correta.', 'Пожалуйста, выберите правильную дату.', 'Por favor elige una fecha correcta.', 'Doğru tarih seçiniz.'),
(41, 'setting_updated', '', 'Setting successfully updated !', 'تم تحديث المعلومات بنجاح !', 'Instellingen succesvol gewijzigd!', 'Réglage de mise à jour avec succès !', 'Einstellungen erfolgreich übernommen!', 'Impostazioni aggiornate correttamente!', 'Configura&amp;ccedil;&amp;otilde;es atualizadas !', 'Настройки успешно обновлены!', '¡ Configuraci&amp;oacute;n correctamente guardada !', 'Ayar Başarıyla Güncellendi!'),
(42, 'current_password_mismatch', '', 'Current password not match', 'كلمة المرور الحالية غير صحيحة', 'Huidig wachtwoord komt niet overeen', 'Mot de passe actuel ne correspond pas', 'Aktuelles Passwort stimmt nicht', 'Password corrente non corrisponde', 'Sua senha atual n&amp;atilde;o confere', 'Текущий пароль не совпадает', 'Contrase&amp;ntilde;a actual diferente', 'Mevcut şifre eşleşmiyor'),
(43, 'website_invalid_characters', '', 'Website is invalid.', 'صيغة الموقع الإلكتروني غير صحيحة', 'Website is niet geldig.', 'Site Web est invalide.', 'Webseite ist ungültig.', 'Sito web non è valido.', 'Site inv&amp;aacute;lido.', 'Недопустимые символы в сайте.', 'El sitio web es invalido.', 'Web sitesi geçersiz.'),
(44, 'account_deleted', '', 'Account successfully deleted, please wait..', 'تم حذف حسابك نهائياَ , الرجاء الإنتظار ..', 'Account is succesvol gewijzigd, een momentje..', 'Compte supprimé avec succès, s&#39;il vous plaît patienter..', 'Konto erfolgreich gelöscht, bitte warten..', 'Account cancellato con successo, si prega di attendere..', 'Conta deletada, por favor aguarde..', 'Аккаунт успешно удален, пожалуйста, подождите...', 'Cuenta eliminada correctamente, por favor espere..', 'Başarıyla silindi Hesap, lütfen bekleyin ..'),
(45, 'home', '', 'Home', 'الصفحة الرئيسية', 'Home', 'Domicile', 'Start', 'Home', 'In&amp;iacute;cio', 'Главная', 'Inicio', 'Ana Sayfa'),
(46, 'advanced_search', '', 'Advanced Search', 'البحث المتقدم', 'Uitgebreid zoeken', 'Recherche Avancée', 'Erweiterte Suche', 'Ricerca avanzata', 'Pesquisa avan&amp;ccedil;ada', 'Расширенный поиск', 'B&amp;uacute;squeda Avanzada', 'Gelişmiş Arama'),
(47, 'search_header_label', '', 'Search for people, pages, groups and #hashtags', 'إبحث عن أعضاء, #هاشتاغ', 'Zoek mensen, #hastags en andere dingen..', 'Recherche de personnes, et les choses #hashtags', 'Suche Personen, #hashtags und Dinge', 'Cerca per persone, cose e #hashtags', 'Procurar pessoas, #hashtags ou coisas', 'Поиск людей, мест или #хэштегов', 'Buscar Otakus, #hashtags y lolis', 'Kişiler, #hashtags ve şeyler ara'),
(48, 'no_result', '', 'No result to show', 'لم يتم العثور على أي نتائج', 'Geen resultaten gevonden', 'Aucun résultat trouvé', 'Leider keine Ergebnisse', 'Nessun risultato trovato', 'Nada encontrado', 'Не найдено ни одного результата', 'Sin resultados', 'Herhangi bir ürün bulunamadı'),
(49, 'last_seen', '', 'Last Seen:', 'آخر ظهور:', 'Laatst gezien:', 'Dernière Visite:', 'Zuletzt online vor:', 'Ultimo accesso:', 'Visto por &amp;uacute;ltimo:', 'Был@:', 'Hace', 'Son Görülen:'),
(50, 'accept', '', 'Accept', 'قبول', 'Accepteren', 'Acceptez', 'Akzeptieren', 'Accettare', 'Aceitar', 'принимать', 'Aceptar', 'Kabul etmek'),
(51, 'cancel', '', 'Cancel', 'إلغاء', 'Weiger', 'Annuler', 'Abbruch', 'Cancella', 'Cancelar', 'Отмена', 'Cancelar', 'Iptal'),
(52, 'delete', '', 'Delete', 'حذف', 'Verwijder', 'Effacer', 'Löschen', 'Ellimina', 'Deletar', 'Удалить', 'Eliminar', 'Sil'),
(53, 'my_profile', '', 'My Profile', 'صفحتي الشخصية', 'Mijn Profiel', 'Mon profil', 'Mein Profil', 'Mio Profilo', 'Meu Perfil', 'Мой профиль', 'Mi Perfil', 'Profilim'),
(54, 'saved_posts', '', 'Saved Posts', 'المنشورات المحفوظة', 'Opgeslagen berichten', 'Messages Enregistrés', 'Gespeicherte Beiträge', 'Post Salvati', 'Posts Salvos', 'Сохраненные заметки', 'Posts Guardados', 'Kayıtlı Mesajlar'),
(55, 'setting', '', 'Settings', 'الإعدادات', 'Instellingen', 'Réglage', 'Einstellungen', 'Impostazioni', 'Configura&amp;ccedil;&amp;otilde;es', 'Настройки', 'Configuraci&amp;oacute;n', 'Ayarlar'),
(56, 'admin_area', '', 'Admin Area', 'لوحة المدير', 'Beheerpaneel', 'Admin Area', 'Administration', 'Area Administratore', 'Admin', 'Админка', 'Área del Admin', 'Yönetici Alanı'),
(57, 'log_out', '', 'Log Out', 'تسجيل الخروج', 'Uitloggen', 'Se déconnecter', 'Abmelden', 'Esci', 'Sair', 'Выйти', 'Cerrar Sesión', 'Çıkış Yap'),
(58, 'no_new_notification', '', 'You do not have any notifications', 'لا يوجد إشعارات', 'Je hebt geen meldingen', 'Vous ne disposez pas de toutes les notifications', 'Derzeit keine neuen Benachrichtigungen', 'Non avete notifiche', 'Voc&amp;ecirc; tem 0 notifica&amp;ccedil;&amp;otilde;es', 'Нет новых уведомлений', 'No tienes nuevas notificaciones', 'Bildirim yok'),
(59, 'no_new_requests', '', 'You do not have any requests', 'لا يوجد طلبات صداقة', 'Je hebt geen verzoeken', 'Vous ne disposez pas de toutes les demandes', 'Derzeit keine neuen Anfragen', 'Non avete alcuna richiesta', 'Voc&amp;ecirc; tem 0 pedidos de amizade', 'Нет новых запросов', 'No tienes nuevas solicitudes', 'Istekler yok'),
(60, 'followed_you', '', 'followed you', 'تابعك', 'volgt je', 'je t&#39;ai suivi', 'folgt dir jetzt', 'Ti segue', 'Seguiu voc&amp;ecirc;', 'последовал@ за тобой', 'te ha seguido', 'Seni takip etti.'),
(61, 'comment_mention', '', 'mentioned you on a comment.', 'أشار لك في تعليق', 'heeft je vermeld in een reactie.', 'vous avez mentionné sur un commentaire.', 'hat dich in einem Kommentar erwähnt.', 'lei ha citato un commento.', 'mencionou voc&amp;ecirc; em um coment&amp;aacute;rio.', 'упомянул@ вас в комментарии.', 'te ha mencionado en un comentario.', 'Bir yorumum sizden bahsetti.'),
(62, 'post_mention', '', 'mentioned you on a post.', 'أشار لك في منشور', 'heeft je vermeld in een bericht.', 'vous avez mentionné sur un poteau.', 'hat dich in einem Beitrag erwähnt.', 'lei ha citato in un post.', 'mencionou voc&amp;ecirc; em um post.', 'упомянул@ вас в заметке.', 'te menciono en una publicaci&amp;oacute;.', 'Bir yayında sizden bahsetti.'),
(63, 'posted_on_timeline', '', 'posted on your timeline.', 'نشر على حائطك', 'heeft een krabbel op je tijdlijn geplaats.', 'posté sur votre timeline.', 'hat an deine Pinwand geschrieben.', 'pubblicato sulla timeline.', 'postou algo em sua linha do tempo.', 'Публикация на стене', 'publico en tu timeline.', 'Zaman çizelgesi Yayınlanan.'),
(64, 'profile_visted', '', 'visited your profile.', 'زار صفحتك الشخصية', 'heeft je profiel bezocht.', 'visité votre profil.', 'hat dein Profil besucht.', 'ha visitato il tuo profilo.', 'te visitou.', 'посетил@ ваш профиль.', 'visitó tu perfil', 'Profilinizi ziyaret etti.'),
(65, 'accepted_friend_request', '', 'accepted your friend request.', 'قبل طلب الصداقة', 'heeft je vriendschapsverzoek geaccepteerd.', 'accepté votre demande d&#39;ami.', 'hat deine Freundschaftsanfrage akzeptiert.', 'ha accettato la tua richiesta di amicizia.', 'aceitou seu pedido de amizade.', 'принял@ запрос о дружбе.', 'acepto tu solicitud de amistad.', 'Arkadaşlık isteğin kabul edildi.'),
(66, 'accepted_follow_request', '', 'accepted your follow request.', 'قبل طلب المتابعة', 'heeft je volgverzoek geaccepteerd.', 'accepté votre demande de suivi.', 'hat deine Folgenanfrage akzeptiert.', 'ha accettato la tua richiesta di follow/segumento.', 'aceitou que voc&amp;ecirc; siga ele.', 'принять запрос.', 'acepto tu solicitud de seguimiento.', 'Senin takip talebi kabul etti.'),
(67, 'liked_comment', '', 'liked your comment &quot;{comment}&quot;', 'أعجب بتعليقك &quot;{comment}&quot;', 'respecteerd je reactie &quot;{comment}&quot;', 'aimé votre commentaire &quot;{comment}&quot;', 'gefällt dein Kommentar &quot;{comment}&quot;', 'piace il tuo commento &quot;{comment}&quot;', 'curtiu seu coment&amp;aacute;rio &quot;{comment}&quot;', 'нравится Ваш комментарий &quot;{comment}&quot;', 'le gusta tu comentario &quot;{comment}&quot;', 'Yorumunuzu Beğendi &quot;{comment}&quot;'),
(68, 'wondered_comment', '', 'wondered your comment &quot;{comment}&quot;', 'تعجب من تعليقك &quot;{comment}&quot;', 'wondered je reactie &quot;{comment}&quot;', 'demandé votre commentaire &quot;{comment}&quot;', 'wundert sich über deinen Kommentar &quot;{comment}&quot;', 'si chiedeva il tuo commento &quot;{comment}&quot;', 'n&amp;atilde;o curtiu seu coment&amp;aacute;rio &quot;{comment}&quot;', 'не нравится &quot;{comment}&quot;', 'le sorprendioo tu comentario &quot;{comment}&quot;', 'Yorumunuzu merak etti &quot;{comment}&quot;'),
(69, 'liked_post', '', 'liked your {postType} {post}', 'أعجب ب {postType} الخاص بك {post}', 'respecteerd je {postType} {post}', 'aimé votre {postType} {post}', 'gefällt dein {postType} {post}', 'piace il {postType} {post}', 'curtiu seu {postType} {post}', 'нравится {postType} {post}', 'le gusta tu {postType} {post}', 'Senin {postType} Beğendi {post}'),
(70, 'wondered_post', '', 'wondered your {postType} {post}', 'تعجب ب {postType} الخاص بك {post}', 'wondered je {postType} {post}', 'demandé votre {postType} {post}', 'wundert sich über deinen {postType} {post}', 'si chiedeva il tuo {postType} {post}', 'n&amp;atilde;o curtiu seu {postType} {post}', 'не нравится {postType} {post}', 'le sorprendio tu {postType} {post}', 'Senin {postType} merak etti {post}'),
(71, 'share_post', '', 'shared your {postType} {post}', 'شارك {postType} الخاص بك {post}', 'deelde je {postType} {post}', 'partagé votre {postType} {post}', 'hat deinen {postType} {post} geteilt', 'ha condiviso il tuo {postType} {post}', 'compartilhou {postType} {post}', 'сделал@ перепост {postType} {post}', 'ha compartido tu {postType} {post}', 'Senin {postType} paylaştı {post}'),
(72, 'commented_on_post', '', 'commented on your {postType} {post}', 'علق على {postType} {post}', 'reageerde op je {postType} {post}', 'commenté sur votre {postType} {post}', 'hat deinen {postType} {post} kommentiert', 'ha commentato il tuo {postType} {post}', 'comentou em seu {postType} {post}', 'прокомментировал {postType} {post}', 'comento en tu {postType} {post}', 'Senin {postType} yorumlananlar {post}'),
(73, 'activity_liked_post', '', 'liked {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'أعجب &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;بمنشور&lt;/a&gt; {user}.', 'respecteerd {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;bericht&lt;/a&gt;.', 'aimé {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;poster&lt;/a&gt;.', 'gefällt {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;Beitrag&lt;/a&gt;.', 'piace {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'curtiu {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'нравится &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;заметка&lt;/a&gt; {user}.', 'le gust&amp;oacute; la &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;publicaci&amp;oacute;n&lt;/a&gt; de {user} .', '{user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt; beğendi.'),
(74, 'activity_wondered_post', '', 'wondered {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'تعجب &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;بمنشور&lt;/a&gt; {user}.', 'wondered {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;bericht&lt;/a&gt;.', 'demandé {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;poster&lt;/a&gt;.', 'wundert sich über {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;Beitrag&lt;/a&gt;.', 'chiedeva {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'n&amp;atilde;o curtiu {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'не нравится &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;заметка&lt;/a&gt; {user}.', 'le sorprendio la &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;publicaci&amp;oacute;n&lt;/a&gt; de {user} .', 'Wondered {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.'),
(75, 'activity_share_post', '', 'shared {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'شارك &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;منشور&lt;/a&gt; {user}.', 'deelde {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;bericht&lt;/a&gt;.', 'partagé {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;poster&lt;/a&gt;.', 'hat {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;Beitrag&lt;/a&gt; geteilt.', 'condiviso {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'compartilhou {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'поделился &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;заметкой&lt;/a&gt; {user}.', 'compartio la &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;publicaci&amp;oacute;n&lt;/a&gt; de {user} .', 'Shared {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.'),
(76, 'activity_commented_on_post', '', 'commented on {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'علق على &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;منشور&lt;/a&gt; {user}.', 'reageerde op {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;bericht&lt;/a&gt;.', 'commenté sur {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;poster&lt;/a&gt;.', 'hat {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;Beitrag&lt;/a&gt; kommentiert.', 'ha commentato in {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'Comentou no {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'прокомментировал@ &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;заметку&lt;/a&gt; {user}.', 'comento en la &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;publicaci&amp;oacute;n de &lt;/a&gt;{user} .', 'Commented on {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.'),
(77, 'video_n_label', '', 'video.', 'الفيديو', 'video.', 'vidéo.', 'Video', 'video.', 'v&amp;iacute;deo.', 'видео.', 'video.', 'video'),
(78, 'post_n_label', '', 'post.', 'المنشور', 'bericht.', 'poster.', 'Beitrag', 'post.', 'post.', 'пост.', 'post.', 'post'),
(79, 'photo_n_label', '', 'photo.', 'الصورة', 'foto.', 'photo.', 'Foto', 'imagini.', 'foto.', 'фото.', 'foto.', 'fotoğraf'),
(80, 'file_n_label', '', 'file.', 'الملف', 'bestand.', 'fichier.', 'Datei', 'file.', 'arquivo.', 'файл.', 'archivo.', 'dosya'),
(81, 'vine_n_label', '', 'vine video.', 'فيديو الفاين', 'vine video.', 'vine vidéo.', 'Vine-Video', 'vine video.', 'Vine.', 'видео.', 'vine.', 'vine video'),
(82, 'sound_n_label', '', 'sound.', 'الملف الصوتي', 'muziek.', 'du son.', 'Musik', 'musica.', 'som.', 'аудио.', 'sonido.', 'ses'),
(83, 'avatar_n_label', '', 'profile picture.', 'صورتك الشخصية', 'profiel foto.', 'Photo de profil.', 'Profilbild', 'imagine di profilo.', 'imagem de perfil.', 'Фото профиля', 'foto de perfil.', 'profil fotoğrafı'),
(84, 'error_not_found', '', '404 Error', 'خطأ 404', '404 Error', '404 Erreur', '404 Fehler', '404 Errore', 'Erro 404', 'Ошибка 404', 'Error 404', '404 Hatası'),
(85, 'sorry_page_not_found', '', 'Sorry, page not found!', 'عذراَ , الصفحة المطلوبة غير موجودة .', 'Sorry, pagina niet gevonden!', 'Désolé, page introuvable!', 'Entschuldigung: Seite wurde nicht gefunden!', 'la pagina non trovata!', 'P&amp;aacute;gina n&amp;atilde;o encontrada!', 'Извините, страница не обнаружена!', 'Gommen ne, pagina no encontrada!', 'Maalesef sayfa bulunamadı!'),
(86, 'page_not_found', '', 'The page you are looking for could not be found. Please check the link you followed to get here and try again.', 'الصفحة التي طلبتها غير موجودة , الرجاء فحص الرابط مرة أخرى', 'The page you are looking for could not be found. Please check the link you followed to get here and try again.', 'La page que vous recherchez n&#39;a pu être trouvée. S&#39;il vous plaît vérifier le lien que vous avez suivi pour arriver ici et essayez à nouveau.', 'Die Seite die du besuchen möchtest, wurde nicht gefunden. Bitte überprüfe den Link auf Richtigkeit und versuche es erneut.', 'La pagina che stai cercando non è stato trovato. Si prega di controllare il link che hai seguito per arrivare qui e riprovare.', 'A p&amp;aacute;gina que voc&amp;ecirc; esta procurando n&amp;atilde;o foi encontrada. Confira o link e tente novamente.', 'Упс! Мы не можем найти страницу, которую вы ищете. Вы ввели неправильный адрес, или такая страница больше не существует.', 'La p&amp;aacute;gina que est&amp;aacute;s buscando no se encuentra. Por favor revisa el link y vuelve a intentar.', 'Aradığınız sayfa bulunamadı. Buraya ve tekrar denemek için izlenen linki kontrol edin.'),
(87, 'your_account_activated', '', 'Your account have been successfully activated!', 'لقد تم تفعيل حسابك بنجاح !', 'Je account is succesvol geactiveerd!', 'Votre compte a été activé avec succès!', 'Dein Konto wurde erfolgreich aktiviert!', 'Il tuo account è stato attivato con successo!', 'Conta ativada!', 'Ваша учетная запись была успешно активирована!', '¡Tu cuenta ha sido activada exitosamente!', 'Hesabınız başarıyla aktive edildi!'),
(88, 'free_to_login', '', 'You&#039;r free to &lt;a href=&quot;{site_url}&quot;&gt;{login}&lt;/a&gt; !', 'يمكنك الآن &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Je kan &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Votre libre &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Bitte hier &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Siete liberi di  &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Fa&amp;ccedil;a &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Вы&#039;r войти &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Eres libre de &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; !', 'Sen serbestsin &lt;a href=&quot;http://localhost/wowonder_update&quot;&gt;{login}&lt;/a&gt; ! için'),
(89, 'general_setting', '', 'General Setting', 'المعلومات العامة', 'General Setting', 'Cadre général', 'Allgemeine Einstellungen', 'Impostazioni Generali', 'Configura&amp;ccedil;&amp;otilde;es gerais', 'Общие настройки', 'Configuraci&amp;oacute;n General', 'Genel Ayar'),
(90, 'login_setting', '', 'Login Setting', 'ملعومات الدخول', 'Login Setting', 'Connexion Cadre', 'Anmeldungseinstellungen', 'Impostazioni di accesso', 'Configura&amp;ccedil;&amp;otilde;es de login', 'Войти Настройки', 'Configuraci&amp;oactute;n de Acceso', 'Üye Girişi Ayarı'),
(91, 'manage_users', '', 'Manage Users', 'إدارة المستخدمين', 'Manage Users', 'gérer les utilisateurs', 'Benutzer verwalten', 'Gestisci Utenti', 'Editar usu&amp;aacute;rios', 'Управление пользователями', 'Manejar Usuarios', 'Kullanıcıları Yönet'),
(92, 'manage_posts', '', 'Manage Posts', 'إدارة المنشورات', 'Manage Posts', 'gérer les messages', 'Beiträge verwalten', 'Gestisci Posts', 'Editar posts', 'Управление сообщения', 'Manejar Publicaciones', 'Mesajlar Yönet'),
(93, 'manage_reports', '', 'Manage Reports', 'إدارة التبليغات', 'Manage Reports', 'gérer les rapports', 'Meldungen verwalten', 'Gestisci Segnalazioni', 'Vizualizar reports', 'Управление отчетами', 'Manenjar Reportes', 'Raporlar Yönet'),
(94, 'advertisement', '', 'Advertisement', 'الإعلانات', 'Advertisement', 'Publicité', 'Werbung', 'Publicita', 'Divulga&amp;ccedil;&amp;atilde;o', 'Реклама', 'Aviso', 'Reklâm'),
(95, 'more', '', 'More', 'أكثر', 'Meer', 'Plus', 'mehr', 'Più', 'Mais', 'еще', 'Más información', 'daha'),
(96, 'cache_system', '', 'Cache System', 'نظام الكاش', 'Cache System', 'Système de cache', 'Cachsystem', 'Cache di Systema', 'Cache', 'система кэша', 'Cache', 'Önbellek Sistemi'),
(97, 'chat_system', '', 'Chat System', 'نظام الدردشة', 'Chat System', 'système chat', 'Chatsystem', 'Sistema Chat', 'Sistema do chat', 'Чат системы', 'Chat', 'Sohbet Sistemi'),
(98, 'email_validation', '', 'Email validation', 'تأكيد الحساب عبر الايميل', 'Email validation', 'Email de validation', 'Emailbestätigung', 'Email di convalida', 'Valida&amp;ccedil;&amp;atilde;o de Email', 'E-mail валидации', 'Validaci&amp;oacute;n de correo', 'E-posta Doğrulama'),
(99, 'email_notification', '', 'Email notification', 'إرسال الإشعارات عبر الايميل', 'Email notification', 'Notification par courriel', 'Email-Benachrichtigungen', 'Notifiche Email', 'Notifica&amp;ccedil;&amp;atilde;o de Email', 'E-mail уведомления', 'Notificaciones', 'E-posta Bildirimi'),
(100, 'smooth_links', '', 'Smooth links', 'الروابط القصيرة', 'Smooth links', 'liens lisses', 'Einfache Links', 'Collegamenti Smooth', 'Links permitidos', 'Гладкие Ссылки', 'Smooth links', 'Pürüzsüz Bağlantılar'),
(101, 'seo_friendly_url', '', 'SEO friendly url', 'الروابط الداعة لمواقع البحث', 'SEO friendly url', 'SEO URL conviviale', 'SEO freundliche URL', 'SEO amicizie url', 'URL', 'SEO Дружественные ссылки', 'url amigable para SEO', 'SEO dost URL'),
(102, 'file_sharing', '', 'File sharing', 'مشاركة الملفات', 'File sharing', 'Partage de fichier', 'Datenaustausch', 'Condivisione di file', 'Compartilhar arquivo', 'обмена файлами', 'Compartir Archivos', 'Dosya paylaşımak'),
(103, 'themes', '', 'Themes', 'شكل الموقع', 'Themes', 'thèmes', 'Design', 'Temi', 'Temas', 'Темы', 'Temas', 'Temalar'),
(104, 'user_setting', '', 'User Settings', 'إعدادات المستخدم', 'Gebruikersinstellingen', 'Paramètres utilisateur', 'Benutzereinstellungen', 'Impostazioni utente', 'Configurações do usuário', 'Пользовательские настройки', 'Ajustes de usuario', 'Kullanıcı ayarları'),
(105, 'site_setting', '', 'Site Setting', 'إعدادات الموقع', 'Site Setting', 'site Cadre', 'Seiteneinstellungen', 'impostazioni del sito', 'Configura&amp;ccedil;&amp;otilde;es do site', 'настройка сайта', 'Configuraci&amp;oacute;n de sitio', 'Sitede Ayarı'),
(106, 'cache_setting_info', '', 'Enable cache system to speed up your website, Recommended more than 10,000 active users.', 'فعل نظام الكاش لتسريع الموقع, يستحسن إستخدامه لأكثر من 10 آلاف مستخدم.', 'Enable cache system to speed up your website, Recommended more than 10,000 active users.', 'Activer système de cache pour accélérer votre site, a recommandé plus de 10.000 utilisateurs actifs.', 'Aktiviere das Cachesystem um die Seiten schneller zu machen, Empfehlenswert ab 10,000 aktiven Benutzern.', 'Abilita sistema di cache per velocizzare il tuo sito web, consigliato più di 10.000 utenti attivi.', 'Ativar o cache para aumentar a velocidade do site, Recomendado se tiver mais de 10,000 usu&amp;aacute;rios ativos.', 'Включить систему кэш для ускорения вашего сайта, Рекомендуем более 10000 активных пользователей.', 'Habilitar cache para aumentar la velocidad de tu sitio, Recomendado para m&amp;aacute;s de 10,000 usuarios activos.', 'Web sitenizi hızlandırmak için önbellek sistemi etkinleştirin, 10.000 &#039;den fazla aktif kullanıcı önerilir.'),
(107, 'chat_setting_info', '', 'Enable chat system to chat with friends on the buttom of the page', 'فعل نظام الدردشة للدردشة مع الإصدقاء في يمين أسفل الصفحة.', 'Enable chat system to chat with friends on the buttom of the page', 'Activer système chat pour discuter avec des amis sur le fond de la page', 'Aktiviere das Chatsystem zum chatten mit Freunden', 'Attivare il sistema chat per chiacchierare con gli amici in fondo alla pagina', 'Ativar sistema de chat para conversas com seus amigos no rodap&amp;eacute; da p&amp;aacute;gina', 'Включить чат системы для общаться с друзьями на дне страницы', 'Habilitar cache de chat, para hablar con amigos al pie del sitio', 'Sayfanın altındaki arkadaşlarınızla sohbet etmek için sohbet sistemini etkinleştirme'),
(108, 'email_validation_info', '', 'Enable email validation to send activation link when user registred.', 'لإرسال رمز التاكيد عبر البريد الإلكتروني عندما يسجل المستخدم.', 'Enable email validation to send activation link when user registred.', 'Activer la validation de messagerie pour envoyer le lien d&#39;activation lorsque l&#39;utilisateur référencée.', 'Aktiviere Email-Aktivierung zum Senden eines Aktivierungslinks wenn sich ein Benutzer registriert.', 'Abilitare la convalida e-mail per inviare link di attivazione quando utente registrato.', 'Ativar valida&amp;ccedil;&amp;atilde;o de e-mail quando um usu&amp;aacute;rio se registrar.', 'Включить проверку электронной почты, чтобы отправить ссылку активации, когда зарегистрированный пользователь.', 'Habilitar validaci&amp;oacute;n de correo para usuarios registrados.', 'Kullanıcı kayıt sırasında aktivasyon bağlantısını göndermek için e-posta doğrulama etkinleştirin.'),
(109, 'email_notification_info', '', 'Enable email notification to send user notification via email.', 'لإرسال الإشعارات عبر البريد الإلكتروني.', 'Enable email notification to send user notification via email.', 'Activer la notification par e-mail pour envoyer une notification par e-mail de l&#39;utilisateur.', 'Aktiviere Email-Benachrichtigungen zum Senden von Benachrichtigungen an die Benutzer.', 'Abilita notifica e-mail per inviare via e-mail di notifica all&#039;utente.', 'Enviar notifica&amp;ccedil;&amp;otilde;es por e-mail.', 'Включить уведомление по электронной почте, чтобы отправить уведомление пользователя по электронной почте.', 'Habilitar notificaci&amp;oacute;n por correo para enviar al usuario.', 'E-posta yoluyla kullanıcı bildirim göndermek için e-posta bildirimi etkinleştirin.'),
(110, 'smooth_links_info', '', 'Enable smooth links, e.g.{site_url}/home.', 'لإستخدام الروابط القصيرة, مثال: http://localhost/wowonder_update/home.', 'Enable smooth links, e.g.http://localhost/wowonder_update/home.', 'Activer les liens lisses, e.g.http://localhost/wowonder_update/home.', 'Aktiviere Einfache Links, z.B.http://localhost/wowonder_update/start', 'Abilita collegamenti regolari, e.g.http://localhost/wowonder_update/home.', 'Ativar links limpos, exemplo.http://localhost/wowonder_update/home.', 'Включить гладкие ссылки, напримерhttp://localhost/wowonder_update/home.', 'Habilitar smooth links, e.g.http://localhost/wowonder_update/home.', 'Pürüzsüz bağlantıları etkinleştirme, e.g.http://localhost/wowonder_update/home.'),
(111, 'seo_frindly_info', '', 'Enable SEO friendly url, e.g.{site_url}//1_hello-how-are-you-doing.html', 'لإستخدام الروابط المساعدة لمواقع البحث, مثال: http://localhost/wowonder_update/1_hello-how-are-you-doing.html', 'Enable SEO friendly url, e.g.http://localhost/wowonder_update//1_hello-how-are-you-doing.html', 'Activer SEO URL conviviale, e.g.http://localhost/wowonder_update//1_hello-how-are-you-doing.html', 'Aktiviere SEO freundliche URL, z.B.http://localhost/wowonder_update//1_hallo-was-machst-du-gerade.html', 'Abilita SEO friendly url, e.g.http://localhost/wowonder_update//1_hello-how-are-you-doing.html', 'Ativar SEO URL, exemplo.http://localhost/wowonder_update//1_hello-how-are-you-doing.html', 'Включить SEO Дружественные ссылки, напримерhttp://localhost/wowonder_update//1_hello-how-are-you-doing.html', 'Habilitar url amigable para SEO, e.g.http://localhost/wowonder_update//1_hello-how-are-you-doing.html', 'SEO dostu url etkinleştirme, e.g.http://localhost/wowonder_update//1_hello-how-are-you-doing.html'),
(112, 'file_sharing_info', '', 'Enable File sharing to share &amp; upload videos,images,files,sounds, etc..', 'لمشاركة الملفات : صوت , فيديو , صورة , الخ ..', 'Enable File sharing to share &amp; upload videos,images,files,sounds, etc..', 'Activez le partage de fichiers pour partager et télécharger des vidéos, des images, des fichiers, des sons, etc...', 'Aktiviere Datenaustausch zum teilen und hochladen von: Videos, Bildern, Dateien, Musik, etc..', 'Attivare la condivisione di file per condividere e caricare video, immagini, file, suoni, ecc..', 'Ativar o compartilhamento de arquivos, para compartilhar videos,imagens,arquivos,sons,etc..', 'Включить общий доступ к файлам, чтобы разделить и загрузить видео, изображения, файлы, звуки и т.д ..', 'Habilitar compartir archivos, para subir v&amp;iacute;deos, sonido, im&amp;aacute;genes , etc..', 'Paylaşmak &amp; vb video, görüntü, dosyaları, sesler, yüklemek için Dosya paylaşımını etkinleştirin ..'),
(113, 'cache', '', 'Cache', 'الكاش', 'Cache', 'Cache', 'Cache', 'Cache', 'Cache', 'кэш', 'Cache', 'Önbellek'),
(114, 'site_information', '', 'Site Information', 'معلومات الموقع', 'Site Information', 'Informations sur le site', 'Seiteninformationen', 'Informazioni sul sito', 'Informa&amp;ccedil;&amp;otilde;es do Site', 'информация о сайте', 'Informaci&amp;oacute;n del sitio', 'Site Bilgileri'),
(115, 'site_title_name', '', 'Site Name &amp; Title:', 'اسم الموقع و عنوانه:', 'Site Name &amp; Title:', 'Site Nom et titre:', 'Seitenname und Titel:', 'Nome del sito &amp; Titolo:', 'Nome e t&amp;iacute;tulo do Site:', 'Название сайта и Заголовок:', 'Nombre y t&amp;iacute;tulo del sitio:', 'Site Adı &amp; Başlık:'),
(116, 'site_name', '', 'Site name', 'اسم الموقع', 'Site name', 'Nom du site', 'Seitenname', 'Nome del sito', 'Nome do Site', 'Название сайта', 'Nombre del sitio', 'Site adı'),
(117, 'site_title', '', 'Site title', 'عنوان الموقع', 'Site title', 'Titre du site', 'Seitentitel', 'Titolo del sito', 'T&amp;iacute;tulo do Site', 'Заголовок сайта', 'T&amp;iacute;tulo del sitio', 'Site başlığı'),
(118, 'site_keywords_description', '', 'Site Keywords &amp; Description:', 'وصف الموقع والكلمات المفتاحية:', 'Site Keywords &amp; Description:', 'Site Mots-clés et description:', 'Seiten-Schlüsselwörter und Beschreibung:', 'Chave di ricerca e descrizione del sito:', 'Descri&amp;ccedil;&amp;atilde;o das palavras-chaves:', 'Сайт Ключевые слова и Описание:', 'Palabras clave y Descripci&amp;oacute;:', 'Sitede Anahtar kelimeler ve Açıklama:'),
(119, 'site_keywords', '', 'Site Keywords', 'كلمات مفتاحية, مثال: موقع, تواصل اجتماعي, الخ ..', 'Site Keywords (eg: social,wownder ..)', 'site Mots-clés (eg: social,wownder ..)', 'Seiten-Schlüsselwörter (z.B: social,wundern ..)', 'Parole chiave del sito (ad esempio: il mio social network, social etc ..)', 'Palavras-chaves do site', 'Ключевые слова Сайт (например: социальная, лучше ..)', 'Palabras clave (ej: social,wownder ..)', 'Site Anahtar kelimeler (eg: social,wownder ..)'),
(120, 'site_description', '', 'Site Description', 'وصف الموقع', 'Site Description', 'description du site', 'Seitenbeschreibung', 'Descrizione del stio', 'Descri&amp;ccedil;&amp;atilde;o do site', 'описание сайта', 'Descripci&amp;oacute;n del sitio', 'Site Açıklaması'),
(121, 'site_email', '', 'Site E-mail', 'بريد الموقع الإلكتروني:', 'Site E-mail', 'Site E-mail', 'System-Email', 'Indirizo email del sito', 'E-mail do site', 'Сайт E-mail', 'E-mail del sitio', 'Site E-posta'),
(122, 'site_lang', '', 'Default Language', 'اللغة الأساسية:', 'Default Language', 'Langage par défaut', 'Standard-Sprache', 'Lingua di default', 'Linguagem padr&amp;ccedil;o', 'Язык по умолчанию', 'Lenguaje por defecto', 'Varsayılan dil'),
(123, 'theme_setting', '', 'Theme Setting', 'إعدادات شكل الموقع', 'Theme Setting', 'thème Cadre', 'Design Einstellungen', 'Impostazione tema', 'Configura&amp;ccedil;&amp;otilde;es do tema', 'тема настройка', 'Configuraci&amp;oacute;n de Tema', 'Tema Ayarı'),
(124, 'activeted', '', 'Activated', 'مفعل', 'Activeted', 'Activeted', 'Aktiviert', 'Attiva', 'Ativado', 'активировал', 'Activado', 'Aktif'),
(125, 'version', '', 'Version:', 'الإصدار:', 'Version:', 'Version:', 'Version:', 'Versione:', 'Vers&amp;ccedil;o:', 'Версия:', 'Versi&amp;oacute;n:', 'Sürüm:'),
(126, 'author', '', 'Author:', 'المالك:', 'Author:', 'Auteur:', 'Autor:', 'Author:', 'Autor:', 'Автор:', 'Autor:', 'Yazar:'),
(127, 'user_status', '', 'User status', 'حالة المستخدم', 'User status', 'Le statut de l&#39;utilisateur', 'Benutzerstatus', 'Status del utente', 'Status do usu&amp;aacute;rio', 'Статус пользователь', 'Estatus de usuario', 'Kullanıcı durumu'),
(128, 'online_lastseen', '', '(online/last seen)', '(متصل / آخر ظهور)', '(online/last seen)', '(en ligne / vu la dernière fois)', '(online/zuletzt online)', '(Attvo/Ultima visita)', '(online/visto por &amp;uacute;ltimo)', '(онлайн / в последний раз был@)', '(En linea/visto hace)', '(çevrimiçi / son görüldüğü)'),
(129, 'enable', '', 'Enable', 'تفعيل', 'Enable', 'Activer', 'Aktivieren', 'Attiva', 'Ativar', 'Включить', 'Habilitado', 'Etkinleştirmek'),
(130, 'disable', '', 'Disable', 'إلغاء التفعيل', 'Disable', 'désactiver', 'Deaktivieren', 'Disattiva', 'Desativar', 'Отключить', 'Des habilitado', 'Devre dışı'),
(131, 'allow_users_to_delete', '', 'Allow users to delete their account', 'السماح للمستخدم بحذف حسابه؟', 'Allow users to delete their account:', 'Autoriser les utilisateurs à supprimer son compte:', 'Benutzern erlauben ihr Konto zu löschen:', 'Consentire agli utenti di cancellare il proprio account:', 'Permitir que usu&amp;uacute;rios deletem suas contas', 'Разрешить пользователям удалять свой счет:', 'Permitir a usuarios eliminar su cuenta:', 'Kullanıcıların kendi hesabını silmek için izin verin:'),
(132, 'profile_visit_notification', '', 'Profile visit notification', 'تلقي الإشعارات عند زيارة الصفحة الشخصية؟', 'Profile visit notification:', 'Profil notification de visite:', 'Profilbesucher Benachrichtigung:', 'Notifiche sula visita del tuo profilo:', 'Notifica&amp;ccedil;&amp;atilde;o de visita no perfil', 'Профиль уведомление визит:', 'Notificaci&amp;oacute;n de visita de perfil:', 'Profil ziyaret bildirimi:'),
(133, 'display_user_age_as', '', 'Display user age as', 'أظهار العمر ك؟', 'Display user age as:', 'Display user d&#39;âge:', 'Zeige das Alter eines Users als:', 'Mostra eta utente come:', 'Mostrar idade como', 'Показать возраст пользователя, как:', 'Mostrar edad de usuario como:', 'Ekran kullanıcı yaşı olarak:'),
(134, 'date', '', 'Date', 'التاريخ', 'Date', 'Rendez-vous amoureux', 'Datum', 'Data', 'Data', 'Дата', 'Fecha', 'Tarih'),
(135, 'age', '', 'Age', 'العمر', 'Age', 'Âge', 'Alter', 'Eta', 'Idade', 'Возраст', 'Edad', 'Yaş'),
(136, 'connectivity_system', '', 'Connectivity System', 'نظام الصداقة:', 'Connectivity System:', 'Système de connectivité:', 'Communityart:', 'Connettività del Sistema:', 'Conectividade do sistema', 'Связь система:', 'Sistema de Conectividad:', 'Bağlantı Sistemi:');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(137, 'connectivity_system_note', '', '&lt;span style=&quot;color:red;&quot;&gt;Note:&lt;/span&gt; If you change the system to another one, all existing followings, followers, friends will be deleted.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;ملاحظة:&lt;/span&gt; عند تغيير نظام الصداقة كل الصداقات , المتابعات سوف تحذف من قاعدة البيانات , الرجاء الحذر !&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Note:&lt;/span&gt; If you migrate from one system to another, all existing followings, followers, friends, memberships will be deleted to avoid issues.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Note:&lt;/span&gt; If you migrate from one system to another, all existing followings, followers, friends, memberships will be deleted to avoid issues.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Achtung:&lt;/span&gt; Wenn Du von einem System zu einem anderen migrierst, werden alle existierenden: Folger, Verfolger, Freunde, Mitgliedschaften gelöscht um Probleme zu vermeiden.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Nota:&lt;/span&gt; Se si esegue la migrazione da un sistema all&#039;altro, tutti i seguenti esistenti, seguaci, amici, appartenenze verranno eliminati per evitare problemi.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Observa&amp;ccedil;&amp;atilde;o:&lt;/span&gt; Se voc&amp;ecirc; mudar o sistema, todos aqueles que voc&amp;ecirc; segue, que te seguem e seus amigos ser&amp;ccedil;o perdidos.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Примечание:&lt;/span&gt;  При переходе от одной системы к другой, все существующие Подписан, последователи, друзья, членство будет удален, чтобы избежать проблем.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Nota:&lt;/span&gt; Si migras de un sistema a otro, Toda la informaci&amp;oacute;n existente, seguidos, seguidores, etc.., ser&amp;aacute; eliminada para evitar conflictos.&lt;/small&gt;', '&lt;span style=&quot;color:red;&quot;&gt;Not:&lt;/span&gt; Eğer bir sistemden diğerine göç, tüm mevcut followings, takipçileri, arkadaşlar, üyelikleri sorunları önlemek için silinir.&lt;/small&gt;'),
(138, 'friends_system', '', 'Friends system', 'نظام الصداقة مثل فيسبوك', 'Friends system', 'Système d&#39;amis', 'Freundesystem', 'Sistema Amici', 'Sistema de amigos', 'Друзья система', 'Sistema de amigos', 'Arkadaşlar Sistemi'),
(139, 'follow_system', '', 'Follow system', 'نظام المتابعة مثل تويتر', 'Follow system', 'système de suivi', 'Folgensystem', 'Sistema con seguire/Follow', 'Sistema de seguidores', 'Следуйте системы', 'Sistema de seguidores', 'Takip Sistemi'),
(140, 'max_upload_size', '', 'Max upload size for videos, images, sounds, and files', 'الحد الأقصى لحجم الرفع:', 'Max upload size:', 'Taille maximale de téléchargement:', 'Maximale Dateigröße zum hochladen:', 'Dimensione massima di upload:', 'Tamanho m&amp;aacute;ximo de v&amp;iacute;deos, imagens, sons e arquivos', 'Максимальный размер загрузки:', 'Limite de subida:', 'Max upload size:'),
(141, 'max_characters_length', '', 'Max characters length', 'الحد الأقصى لعدد الأحرف:', 'Max characters length:', 'Max longueur des caractères:', 'Maximale Zeichenlänge:', 'Lunghezza massima caratteri:', 'Max characters length', 'Макс символов длиной:', 'Limite de caracteres:', 'Maksimum yükleme boyutu:'),
(142, 'allowed_extenstions', '', 'Allowed extenstions', 'صيغ الملفات المسومح يها:', 'Allowed extenstions:', 'extensions autorisées:', 'Erlaubte Endungen:', 'Estensioni ammessi:', 'Extens&amp;otilde;es permitidas', 'Допустимые расширения:', 'Extensiones permitidas:', 'İzin Uzantıları:'),
(143, 'reCaptcha_setting', '', 'reCaptcha Setting', 'إعدادات الريكابتا', 'reCaptcha Setting', 'reCaptcha Cadre', 'reCaptcha Einstellungen', 'reCaptcha Impostazioni', 'Configura&amp;ccedil;&amp;atilde;o do reCaptcha', 'настройка ReCaptcha', 'Configuraci&amp;oacute;n reCaptcha', 'Tuttum Ayarı'),
(144, 'reCaptcha_key_is_required', '', 'reCaptcha key is required', 'مفتاح الريكابتشا مطلوب', 'reCaptcha key is required', 'reCaptcha clé est nécessaire', 'reCaptcha schlüßel ist erforderlich', 'reCaptcha Chiave e richesta', 'a chave do reCaptcha &amp;eacute; necess&amp;aacute;ria', 'Ключ ReCaptcha требуется', 'Llave de reCaptcha es requerida', 'Tuttum anahtarı gereklidir'),
(145, 'reCaptcha_key', '', 'reCaptcha Key', 'مفتاح الريكابتشا:', 'reCaptcha Key :', 'reCaptcha clé :', 'reCaptcha Schlüßel :', 'reCaptcha chiave :', 'chave do reCaptcha', 'Ключ ReCaptcha :', 'Llave de reCaptcha :', 'Tuttum Anahtarı:'),
(146, 'google_analytics', '', 'Google Analytics', 'تحليل غوغل', 'Google Analytics', 'Google Analytics', 'Google Analytics', 'Google Analytics', 'Google Analytics', 'Гугл Аналитика', 'Google Analytics', 'Google Analiz'),
(147, 'google_analytics_code', '', 'Google analytics code', 'كود لتحليل غوغل', 'Google analytics code:', 'Google code Google Analytics:', 'Google Analytics Code:', 'Google analytics Codice:', 'C&amp;oacute;digo do Google analytics', 'Гугл Аналитика код:', 'Google analytics code:', 'Google Analytics Kodu:'),
(148, 'cache_setting', '', 'Cache Setting', 'إعدادات الكاش', 'Cache Setting', 'cache Cadre', 'Cache Einstellungen', 'Cache Impostazioni', 'Configura&amp;ccedil;&amp;atilde;o de Cache', 'настройка кэша', 'Configuraci&amp;oacute;n de Cache', 'Önbellek Ayarı'),
(149, 'cache_recomended_clear', '', 'It&#039;s highly recommended to clear the cache.', 'انه من المستحين أن تمسح الكاش.', 'It&#039;s highly recommended to clear the cache.', 'Il est fortement recommandé de vider le cache.', 'Es ist sehr empfehlenswert den Cache zu säubern.', 'Si raccomanda di cancellare la cache.', '&amp;eacute; recomend&amp;aacute;vel que voc&amp;ecirc; limpe o cache.', 'Это рекомендуется очистить кэш.', 'Es altamente recomendado limpiar la cache.', 'Oldukça önbelleği temizlemek için tavsiye edilir.'),
(150, 'cache_size', '', 'Cache Size:', 'حجم الكاش:', 'Cache Size:', 'Taille du cache:', 'Cachegröße:', 'Cache Dimensioni:', 'Tamanho do cache:', 'Размер кэша:', 'Tamaño de Cache:', 'Önbellek Boyutu:'),
(151, 'clear_cache', '', 'Clear Cache', 'مسح الكاش', 'Clear Cache', 'Vider le cache', 'Cache säubern', 'Pulisci Cache', 'Limpar Cache', 'Очистить кэш', 'Limpiar Cache', 'Önbelleği'),
(152, 'social_login', '', 'Social login', 'دخول التواصل الإجتماعي', 'Social login', 'Social login', 'Social Anmeldung', 'Social login', 'Login', 'Социальный вход', 'Social login', 'Sosyal giriş'),
(153, 'social_login_api', '', 'Social login API&#039;S', 'ال API الخاص ب الدخول بإستخدام التواصل الإجتماعي', 'Social login API&#039;S', 'Social login API&#39;S', 'Social Anmeldung API&#039;S', 'Social login API&#039;S', 'Login API', 'Социальный вход API &#039;S', 'APIS sociales', 'Sosyal giriş APIler'),
(154, 'facebook', '', 'Facebook', 'الفسبوك', 'Facebook', 'Facebook', 'Facebook', 'Facebook', 'Facebook', 'Facebook', 'Facebook', 'Facebook'),
(155, 'google', '', 'Google+', 'غوغل بلاس', 'Google+', 'Google+', 'Google+', 'Google+', 'Google+', 'Google+', 'Google+', 'Google+'),
(156, 'twitter', '', 'Twitter', 'تويتر', 'Twitter', 'Twitter', 'Twitter', 'Twitter', 'Twitter', 'Твиттер', 'Twitter', 'Twitter'),
(157, 'linkedin', '', 'Linkedin', 'لينكد إن', 'Linkedin', 'Linkedin', 'Linkedin', 'Linkedin', 'Linkedin', 'Linkedin', 'Linkedin', 'Linkedin'),
(158, 'vkontakte', '', 'Vkontakte', 'في كينتاكتا', 'Vkontakte', 'Vkontakte', 'Vkontakte', 'Vkontakte', 'Vkontakte', 'Вконтакте', 'Vkontakte', 'Vkontakte'),
(159, 'facebook_api', '', 'Facebook API', 'فيسبوك API', 'Facebook API', 'Facebook API', 'Facebook API', 'Facebook API', 'Facebook API', 'Facebook API', 'Facebook API', 'Facebook API'),
(160, 'google_api', '', 'Google API', 'غوغل API', 'Google API', 'Google API', 'Google API', 'Google API', 'Google API', 'Google API', 'Google API', 'Google API'),
(161, 'twitter_api', '', 'Twitter API', 'تويتر API', 'Twitter API', 'Twitter API', 'Twitter API', 'Twitter API', 'Twitter API', 'Твиттер API', 'Twitter API', 'Twitter API'),
(162, 'linkedin_api', '', 'Linkedin API', 'لينكد إن API', 'Linkedin API', 'Linkedin API', 'Linkedin API', 'Linkedin API', 'Linkedin API', 'Linkedin API', 'Linkedin API', 'Linkedin API'),
(163, 'vkontakte_api', '', 'Vkontakte API', 'في كينتاكتا API', 'Vkontakte API', 'Vkontakte API', 'Vkontakte API', 'Vkontakte API', 'Vkontakte API', 'Vkontakte API', 'Vkontakte API', 'Vkontakte API'),
(164, 'app_id', '', 'App ID', 'رقم التطبيق', 'App ID', 'App ID', 'App ID', 'App ID', 'App ID', 'App ID', 'ID de aplicaci&amp;oacute;n', 'App Kimliği'),
(165, 'app_secret_key', '', 'App Secret Key', 'مفتاح التطبيق', 'App Secret Key', 'App Secret Key', 'App Geheim Schlüssel', 'Chiave segreta delle app', 'Chave Secreta APP', 'App Секретный ключ', 'Llave secreta de aplicaci&amp;oacute;n', 'App Gizli Anahtarı'),
(166, 'login_with', '', 'Login with', 'تسجيل الدخول عن طريق:', 'Login with', 'Connectez-vous avec', 'Anmelden mit', 'Entra con', 'Logar com', 'Войдите с', 'Ingresar con', 'İle giriş'),
(167, 'id', '', 'ID', 'ID', 'ID', 'ID', 'ID', 'ID', 'ID', 'ID', 'ID', 'ID'),
(168, 'source', '', 'Source', 'المصدر', 'Source', 'La source', 'Quelle', 'Fonte', 'Source', 'Источник', 'Fuente', 'Kaynak'),
(169, 'status', '', 'Status', 'الحالة', 'Status', 'statut', 'Status', 'Stato', 'Status', 'Состояние', 'Estado', 'Statü'),
(170, 'pending', '', 'Pending', 'قيد الإنتظار', 'Pending', 'en attendant', 'Anstehend', 'In atesa', 'Pendente', 'В ожидании', 'Pendiente', 'Bekleyen'),
(171, 'first_name', '', 'First name', 'الإسم', 'First name', 'Prénom', 'Vorname', 'Nome', 'Primeiro nome', 'Имя', 'Nombre', 'İsim'),
(172, 'last_name', '', 'Last name', 'الكنية', 'Last name', 'Nom de famille', 'Nachname', 'Cognome', '&amp;uacute;ltimo nome', 'Фамилия', 'Apellido', 'Soyadı'),
(173, 'about_me', '', 'About me', 'عني', 'About me', 'A propos de moi', 'Über mich', 'Su di me', 'Sobre', 'Обо мне', 'Sobre mi', 'Benim hakkımda'),
(174, 'website', '', 'Website', 'الموقع الإلكتروني', 'Website', 'Website', 'Webseite', 'Sito Web', 'Website', 'Веб-сайт', 'Website', 'Web Sitesi'),
(175, 'action', '', 'Action', 'عمل ', 'Actie', 'action', 'Aktion', 'Azione', 'Açao', 'действие', 'Acción', 'Aksiyon'),
(176, 'show_more_users', '', 'Show more users', 'عرض المزيد من المستخدمين', 'Show more users', 'Afficher plus d&#39;utilisateurs', 'Zeige mehr Benutzer', 'Mostra piu utenti', 'Mostrar mais usu&amp;uacute;rios', 'Показать больше пользователей', 'Mostrar m&amp;aacute;s usuarios', 'Daha fazla kullanıcı göster'),
(177, 'no_more_users_to_show', '', 'No more users to show', 'لا يوجد المزيد', 'No more users to show', 'Pas plus aux utilisateurs d&#39;afficher', 'Keine weiteren Benutzer', 'Nessun altro utente da mostrare', 'N&amp;atilde;o me mostre mais usu&amp;uacute;rios', 'Нет больше пользователей, чтобы показать', 'No hay m&amp;aacute;s usuarios', 'Artık kullanıcılar göstermek için'),
(178, 'user_delete_confirmation', '', 'Are you sure you want to delete this user?', 'هل أنت متأكد من حفذ هذا المستخدم؟', 'Are you sure you want to delete this user?', 'Êtes-vous sûr de vouloir supprimer cet utilisateur?', 'Diesen Benutzer wirklich löschen?', 'Sei sicuro di voler eliminare questo utente?', 'Gostaria mesmo de deletar esse usu&amp;uacute;rio?', 'Вы уверены, что хотите удалить этого пользователя?', '¿Seguro que deseas eliminar este amigo?', 'Bu kullanıcıyı silmek istediğinizden emin misiniz?'),
(179, 'post_delete_confirmation', '', 'Are you sure you want to delete this post?', 'هل أنت متأكد من حفذ هذا المنشور؟', 'Are you sure you want to delete this post?', 'Es-tu sur de vouloir supprimer cette annonce?', 'Diesen Beitrag wirklich löschen?', 'Sei sicuro di voler eliminare questo post?', 'Gostaria mesmo de deletar esse post?', 'Вы уверены, что хотите удалить это сообщение?', '¿Seguro que deseas eliminar est&amp;aacute; punlicaci&amp;oacute;n?', 'Bu mesajı silmek istediğinizden emin misiniz?'),
(180, 'show_more_posts', '', 'Show more posts', 'عرض المزيد من المنشورات', 'Show more posts', 'Montrer plus d&#39;articles', 'Zeige mehr Beiträge', 'Mostra gli altri messaggi', 'Mostrar mais posts', 'Показать еще записи', 'Mostrar m&amp;aacute;s publicaciones', 'Daha fazla mesajları göster'),
(181, 'no_more_posts', '', 'No more posts', 'لا يوجد المزيد', 'No more posts', 'Pas plus de postes', 'Keine weiteren Beiträge', 'Non ci sono altri post', 'N&amp;atilde;o me mostre mais posts', 'Нет заметок для отображения', 'No hay mas publicaciones', 'Daha mesajlar yok'),
(182, 'no_posts_found', '', 'No posts to show', 'لا يوجد منشورات', 'No posts found', 'Aucun post trouvé', 'Keine Beiträge gefunden', 'nesun post trovato', 'Nenhum post encontrado', 'Заметки не найдены', 'Publicaci&amp;oacute;n no encontrada', 'Mesajlar yok'),
(183, 'publisher', '', 'Publisher', 'الناشر', 'Publisher', 'Éditeur', 'Herausgeber', 'Editore', 'Publicador', 'опубликовал@', 'Editor', 'Yayımcı'),
(184, 'there_are_not_new_posts_for_now', '', 'There are not new post for now', 'لا يوجد منشورات جديدة', 'There are not new post for now', 'Il n&#39;y a pas pour le moment nouveau poste', 'Derzeit keine neuen Beiträge', 'Nessun nuovo post per ora', 'Nenhum post novo', 'На данный момент нет новых сообщений', 'No hay mas publicaciones por ahora', 'Henüz okunmamış Mesaja vardır'),
(185, 'post_link', '', 'Post link', 'رابط المنشور', 'Post link', 'lien Poster', 'Beitragslink', 'Post link', 'Link do post', 'Заметка ссылка', 'Publicar link', 'Mesaj bağlantı'),
(186, 'time', '', 'Time', 'الوقت', 'Time', 'Temps', 'Zeit', 'Orario', 'Tempo', 'Время', 'Hora', 'Zaman'),
(187, 'post', '', 'Post', 'المنشور', 'Post', 'Poster', 'Beitrag', 'Post', 'Post', 'Заметка', 'Publicacion', 'Mesaj'),
(188, 'no_posts_yet', '', '{name} has not posted anything yet', '{name} لم ينشر أي منشور بعد.', '{name} has not posted anything yet', '{name} n&#39;a pas encore posté rien', '{name} hat noch keine Beiträge erstellt', '{name} non ha pubblicato ancora nulla', '{name} n&amp;atilde;o postou nada ainda', '{name} еще ничего не опубликовано', '{name} no ha publicado nada a&amp;uacute;n', '{name} bir şey yayınlamadı'),
(189, 'search', '', 'Search', 'بحث', 'Search', 'Recherche', 'Suche', 'Cerca', 'Procurar', 'Поиск', 'Buscar', 'Aramak'),
(190, 'on', '', 'On', 'تفعيل', 'On', 'Sur', 'An', 'Attivo', 'On', 'Открыт', 'Encender', 'Açık'),
(191, 'off', '', 'Off', 'إالغاء', 'Off', 'De', 'Aus', 'Spento', 'Off', 'Закрыт', 'Apagar', 'Kapalı'),
(192, 'save', '', 'Save', 'حفظ', 'Save', 'sauvegarder', 'Speichern', 'Salva', 'Salvar', 'Сохранить', 'Guardar', 'Kaydet'),
(193, 'saved', '', 'Saved !', 'تم الحفظ !', 'Saved !', 'Enregistré !', 'Gespeichert!', 'Salvato !', 'Salvo !', 'Сохранено!', '¡ Guardado !', 'Kaydedilen!'),
(194, 'reporter', '', 'Reporter', 'البالغ', 'Reporter', 'Journaliste', 'Meldungen', 'Rapporter', 'Usu&amp;uacute;rio', 'Отчет', 'Reportes', 'Muhabir'),
(195, 'time_reported', '', 'Time Reported', 'زمن التبليغ', 'Time Reported', 'temps Rapporté', 'Meldungs Zeit', 'Tempo Segnalato', 'Hor&amp;aacute;rio', 'Время отчета', 'Hora reportada', 'Bildiren Zaman'),
(196, 'there_are_no_new_reports', '', 'There are no new reports for now.', 'لا يوجد تبليغات جديدة', 'There are no new reports for now.', 'Il n&#39;y a pas de nouveaux rapports pour l&#39;instant.', 'Derzeit keine neuen Meldungen.', 'Non ci sono nuovi report per ora.', 'Nenhum report novo.', 'На данный момент нет новых отчетов.', 'No hay nuevos reportes por ahora.', 'Henüz yeni raporlar vardır.'),
(197, 'open_post', '', 'Open Post', 'أفتح المنشور', 'Open Post', 'Ouvrir Poste', 'Beitrag öffnen', 'Apri il post', 'Abrir Post', 'Открыть заметку', 'Abrir publicaci&amp;oacute;n', 'Henüz Raporlar Vardır Yeni.'),
(198, 'mark_safe', '', 'Mark Safe', 'تعيين كآمن', 'Mark Safe', 'Mark Safe', 'Als sicher markieren', 'Mark sicuro', 'Marcar como seguro', 'Безопасно', 'Marcar como seguro', 'Mark Güvenli'),
(199, 'delete_post', '', 'Delete Post', 'حذف', 'Delete Post', 'Delete Post', 'Beitrag löschen', 'Cancella questo Post', 'Deletar Post', 'Удалить заметку', 'Eliminar publicaci&amp;oacute;n', 'Sil'),
(200, 'advertisement_setting', '', 'Advertisement Setting', 'إعدادات الإعلانات', 'Advertisement Setting', 'Cadre Publicité', 'Werbeeinstellungen', 'Impostazione Pubblicità', 'Configura&amp;ccedil;&amp;otilde;es de divulga&amp;ccedil;&amp;atilde;o', 'Реклама настройки', 'Configuraci&amp;oacuten; de avisos', 'Reklam Ayarı'),
(201, 'more_setting', '', 'More Setting', 'المزيد', 'More Setting', 'plus Cadre', 'Mehr Einstellungen', 'Piu Impostazioni', 'Mais configura&amp;ccedil;&amp;otilde;es', 'Расширенные настройки', 'M&amp;aacute;s configuraciones', 'Daha Ayar'),
(202, 'mailing_users', '', 'Mailing list', 'القائمة البريدية', 'Mailing list', 'Liste de diffusion', 'Mail an alle User', 'Lista di email', 'Lista dos emails', 'Список рассылки', 'Lista de correos', 'Mail listesi'),
(203, 'send', '', 'Send', 'إرسال', 'Send', 'Envoyer', 'Senden', 'Invia', 'Enviar', 'Отправить', 'Enviar', 'Gönder'),
(204, 'mailing_subject', '', 'Subject..', 'الموضوع..', 'Subject..', 'Assujettir..', 'Gegenstand..', 'Subject..', 'T&amp;iacute;tulo..', 'Тема..', 'Tema..', 'Konu ..'),
(205, 'mailing_message', '', 'Message..', 'الرسالة..', 'Message..', 'Message..', 'Nachricht..', 'Messaggio..', 'Mensagem..', 'Сообщение..', 'Mensaje..', 'Mesaj..'),
(206, 'announcement', '', 'Announcement', 'تصريح', 'Announcement:', 'Annonce:', 'Ankündigung:', 'Annuncio:', 'Aviso', 'Объявление:', 'Anuncio:', 'Duyuru:'),
(207, 'new_announcement', '', 'New announcement', 'تصريح جديد', 'New announcement ..', 'nouvelle annonce ..', 'Neue Ankündigung ..', 'Nuovo annuncio ..', 'Novo aviso', 'Новое объявление...', 'Nuevo anuncio ..', 'Yeni duyuru ..'),
(208, 'add', '', 'Add', 'إضافة', 'Add', 'Ajouter', 'Hinzufügen', 'Aggiungi', 'Add', 'Добавить', 'Agregar', 'Ekle'),
(209, 'views', '', 'Views', 'الآراء', 'Uitzichten', 'Vues', 'Ansichten', 'Visualizzazioni', 'Visualizações', 'Просмотры', 'Puntos de vista', 'Görüntüler'),
(210, 'there_are_no_active_announcements', '', 'There are no active announcements.', 'لا يوجد تصريحات مفعلة', 'There are no active announcements.', 'Il n&#39;y a pas d&#39;annonces actives.', 'Derzeit keine aktiven Ankündigungen.', 'Non ci sono annunci attivi.', 'Nenhum aviso novo.', 'Нет активных объявлений.', 'No hay avisos activos.', 'Aktif duyurular hiç yok.'),
(211, 'there_are_no_inactive_announcements', '', 'There are no inactive announcements.', 'لايوجد تصريحات غير مفعلة', 'There are no inactive announcements.', 'Il n&#39;y a aucune annonce inactifs.', 'Derzeit keine Inaktiven Ankündigungen.', 'Non ci sono annunci inattivi.', 'Nenhum aviso inativo.', 'Нет неактивных объявления.', 'No hay avisos inactivos.', 'Aktif değil duyurular hiç yok.'),
(212, 'add_friend', '', 'Add Friend', 'إضافة صديق', 'Voeg toe', 'Ajouter', 'Als Freund', 'Aggiungi Amico', 'Adicionar como amigo', 'Добавить друга', 'Agregar amigo', 'Arkadaş ekle'),
(213, 'follow', '', 'Follow', 'متابعة', 'Volgen', 'Suivre', 'folgen', 'Segui', 'Seguir', 'Следовать', 'Seguir', 'Takip et'),
(214, 'following', '', 'Following', 'متابَعون', 'Volgend', 'Suivant', 'folgt', 'Following', 'Seguindo', 'Следую', 'Siguiendo', 'Aşağıdaki'),
(215, 'following_btn', '', 'Following', 'متابع', 'Volgend', 'Suivant', 'folgt', 'Following', 'Seguindo', 'Следую', 'Siguiendo', 'Aşağıdaki'),
(216, 'followers', '', 'Followers', 'متابِعون', 'Volgers', 'Les adeptes', 'verfolger', 'Followers', 'Seguidores', 'Подписчики', 'Seguidores', 'İzleyiciler'),
(217, 'message', '', 'Message', 'رسالة', 'Stuur bericht', 'Message', 'Nachricht', 'Messaggio', 'Mensagem', 'Сообщение', 'Mensaje', 'Mesaj'),
(218, 'requested', '', 'Requested', 'طلب', 'Aangevraagd', 'Demandé', 'Gewünscht', 'richiesto', 'Requeridos', 'запрошенный', 'Pedido', 'İstenen'),
(219, 'friends_btn', '', 'Friends', 'الإصدقاء', 'Vrienden', 'Friends', 'Freunde', 'Amici', 'Amigos', 'Друзья', 'Amigos', 'Arkadaşlar'),
(220, 'online', '', 'Online', 'متصل', 'Online', 'Online', 'Online', 'In Linea', 'Online', 'Онлайн', 'Conectado', 'Çevrimiçi'),
(221, 'offline', '', 'Offline', 'غير متصل', 'Offline', 'Offline', 'Offline', 'Offline', 'Offline', 'Оффлайн', 'Desconectado', 'Çevrimdışı'),
(222, 'you_are_currently_offline', '', 'You are currently offline, turn on the chat to start chatting.', 'غير متصل', 'Je bent momenteel offline', 'Vous êtes actuellement déconnecté', 'Du wirst als Offline angezeigt!', 'Attualmente sei offline', 'Voc&amp;ecirc; esta offline', 'На данный момент вы в оффлайн', 'Est&amp;aacute;s actualmente desconectado.', 'Şu anda çevrimdışı olan'),
(223, 'no_offline_users', '', 'No offline users.', 'لا يوجد أصدقاء غير متصلين', 'Geen offline mensen.', 'Aucun utilisateur hors ligne.', 'Freunde Offline.', 'Nessun utente in offline.', 'Nenhum usu&amp;uacute;rio offline.', 'Нет пользователей оффлайн.', 'Sin usuarios desconectados.', 'Hiçbir çevrimdışı kullanıcıları.'),
(224, 'no_online_users', '', 'No online users.', 'لا يوجد أصدقاء متصلين', 'Geen online mensen.', 'Aucun membre en ligne.', 'Freunde Online.', 'Nessun utente in linea.', 'Nenhum usu&amp;uacute;rio Online.', 'Нет пользователей онлайн.', 'Sin usuarios conectados.', 'Hiçbir online kullanıcılar.'),
(225, 'search_for_users', '', 'Search for users', 'إبحث عن مستخدمين', 'Zoek mensen', 'Recherche d&#39;utilisateurs', 'Freund suchen', 'Cerca per utente', 'Procurar usu&amp;uacute;rios', 'Поиск пользователей', 'Buscar usuarios', 'Kullanıcıları için ara'),
(226, 'no_users_found', '', 'No users to show', 'لا يوجد نتائج', 'Geen mensen gevonden.', 'Aucun utilisateur trouvé.', 'Leider kein Treffer.', 'nessun utente trovato.', 'Nenhum usu&amp;uacute;rio encontrado.', 'Не найдено ни одного пользователя.', 'Usuario no encontrado.', 'Kullanıcı bulunamadı.'),
(227, 'seen', '', 'Seen', 'تمت القراءة', 'Gezien', 'vu', 'Gesehen', 'Visto', 'Visto', 'посещений', 'Visto', 'Görülme'),
(228, 'load_more_posts', '', 'Load more posts', 'تحميل المزيد من المنشورات', 'Laad meer berichten', 'Chargez plus de postes', 'Mehr Beiträge laden', 'Carica piu notizie', 'Carregar mais posts', 'Загрузка заметок', 'Cargar m&amp;aacute;s publicaciones', 'Daha fazla Mesajları yükle'),
(229, 'load_more_users', '', 'Load more users', 'تحميل المزيد من المستخدمين', 'Laad meer mensen', 'Charger plusieurs utilisateurs', 'Mehr Benutzer laden', 'Carica piu utenti', 'Carregar mais usu&amp;uacute;rios', 'Загрузить больше', 'Cargar m&amp;aacute;S usuarios', 'Daha fazla kullanıcı yükle'),
(230, 'there_are_no_tags_found', '', 'No results found for your query.', 'لا يوجد منشورات حول هذه التاغ', 'Geen resultaten gevonden.', 'Aucun résultat n&#39;a été trouvé pour votre recherche.', 'Keine Ergebnisse für deine Anfrage gefunden.', 'Nessun risultato corrisponde alla tua richiesta.', 'Nenhum resultado encontrado.', 'Не найдено ни одной метки.', 'Sin resultados para tu b&amp;uacute;squeda.', 'Bulunan hiçbir etiket bulunmamaktadır.'),
(231, 'there_are_no_saved_posts', '', 'You don&#039;t have any saved posts.', 'لا يوجد منشورات محفوظة', 'Je hebt geen opgeslagen berichten.', 'Vous ne disposez pas de messages enregistrés.', 'Keine gespeicherten Beiträge.', 'Non avete nessun post salvato.', 'Voc&amp;ecirc; n&amp;atilde;o tem nenhum post salvo.', 'Нет сохраненных заметок.', 'No tienes ning&amp;uacute;na publicaci&amp;oacute;n guardada.', 'Kaydedilmiş bir konu bulunmuyor.'),
(232, 'messages', '', 'Messages', 'الرسائل', 'Berichten', 'Messages', 'Nachrichten', 'Messaggi', 'Mensagens', 'Переписка', 'Mensajes', 'Mesajlar'),
(233, 'write_something', '', 'Write Something ..', 'أكتب رسالة ..', 'Schrijf iets ..', 'Écrire quelque chose ..', 'Schreibe etwas..', 'Scrivi qualcosa ..', 'Escreva algo ..', 'Напишите что-нибудь...', 'Escribe algo ..', 'Bir şey yaz ..'),
(234, 'no_more_message_to_show', '', 'No more message', 'لا يوجد رسائل', 'Geen berichten om weer te geven', 'Pas plus un message', 'Keine weiteren Nachrichten', 'Niente più messaggi', 'Nenhuma mensagem nova', 'Нет больше сообщений', 'No hay mensajes', 'Artık mesajı'),
(235, 'view_more_messages', '', 'View more messages', 'تحميل المزيد من الرسائل', 'Bekijk meer berichten', 'Voir plus de messages', 'Mehr Nachrichten ansehen', 'Vedi più messaggi', 'Ver mais mensagens', 'Посмотреть больше сообщений', 'Ver m&amp;aacute;s mensajes', 'Daha fazla ileti görüntüle'),
(236, 'sorry_cant_reply', '', 'Sorry, you can&#039;t reply to this user.', 'عذراَ لا يمكنك إرسال رسالة لهذا المستخدم.', 'Sorry, je kan niet reageren op dit bericht.', 'Désolé, vous ne pouvez pas répondre à cet utilisateur.', 'Du kannst diesem Benutzer nicht antworten.', 'Siamo spiacenti, non è possibile rispondere a questo utente.', 'Voc&amp;ecirc; n&amp;atilde;o pode responder este usu&amp;uacute;rio.', 'Извините, вы не можете ответить.', 'Disculpa, no puedes responder a este usuario.', 'Maalesef, bu kullanıcı cevap veremezsiniz.'),
(237, 'choose_one_of_your_friends', '', 'Choose one of your friends', 'أخنر واحداَ من أصدقائك', 'Selecteer een van je vrienden', 'Choisissez un de vos amis', 'Wähle einen deiner Freunde', 'Scegli uno dei tuoi amici', 'Escolha um de seus amigos', 'Выберите одного из ваших друзей', 'Elige uno de tus amigos', 'Arkadaşlarınızla birini seçin'),
(238, 'and_say_hello', '', 'And Say Hello !', 'و قل له مرحباً !', 'En zeg Hallo !', 'Et dire Bonjour !', 'und sage Hallo!', 'E dire Ciao !', 'E diga ol&amp;aacute; !', 'И скажите что-нибудь!', '¡ Y dile algo!', 'Ve Merhaba Deyin!'),
(239, 'download', '', 'Download', 'تحميل', 'Download', 'Télécharger', 'Herunterladen', 'Download', 'Download', 'Скачать', 'Descargar', 'İndir'),
(240, 'update_your_info', '', 'Update your info', 'تحديث المعلومات الخاصة بك', 'Update je informatie', 'Mettre à jour vos informations', 'Aktualisiere deine Informationen', 'Aggiorna le tue informazioni', 'Atualizar sua informa&amp;ccedil;&amp;atilde;o', 'Обновите свою информацию', 'Actualizar tu informaci&amp;oacute;n', 'Bilgilerinizi güncelleyin'),
(241, 'choose_your_username', '', 'Choose your username:', 'أختر اسم مستخدم خاص بك :', 'Kies een gebruikersnaam:', 'Choisissez votre nom d&#39;utilisateur:', 'Wähle deinen Benutzernamen:', 'Scegli il tuo username:', 'Escolha seu nome de usu&amp;uacute;rio:', 'Выберите ваше имя пользователя:', 'Escoje tu nombre de usuario:', 'Kullanıcı adınızı seçin:'),
(242, 'create_your_new_password', '', 'Create your new password:', 'أنشء كملنة المرور:', 'Geef een nieuw wachtwoord op:', 'Créer votre nouveau mot de passe:', 'Erstelle dein neues Passwort:', 'Crea la tua nuova password:', 'Nova Senha:', 'Создать новый пароль:', 'Crear tu nueva contrase&amp;ntilde;a:', 'Yeni şifrenizi oluşturun:'),
(243, 'update', '', 'Update', 'تحديث', 'Update', 'Mettre à jour', 'Aktualisieren', 'Aggiorna', 'Atualizar', 'Обновить', 'Actualizar', 'Güncelleme'),
(244, 'delete_comment', '', 'Delete Comment', 'حذف التعليق', 'Verwijder reactie', 'supprimer les commentaires', 'Kommentar löschen', 'Ellimina il commento', 'Deletar coment&amp;aacute;rio', 'Удалить комментарий', 'Eliminar comentario', 'Yorum Sil'),
(245, 'confirm_delete_comment', '', 'Are you sure that you want to delete this comment ?', 'هل أنت متاكد من حذف هذا التعليق ؟', 'Weet je zeker dat je deze reactie wil verwijderen?', 'Etes-vous sûr que vous voulez supprimer ce commentaire ?', 'Diesen Kommentar wirklich löschen ?', 'Sei sicuro di voler eliminare questo commento ?', 'Deletar coment&amp;aacute;rio ?', 'Вы уверены, что хотите удалить этот комментарий?', '¿ Seguro que deseas eliminar est&amp;eacute; comentario ?', 'Bu yorumu silmek istediğinizden emin misiniz?'),
(246, 'confirm_delete_post', '', 'Are you sure that you want to delete this post ?', 'هل أنت متاكد من حذف هذا المنشور ؟', 'Weet je zeker dat je dit bericht wil verwijderd?', 'Etes-vous sûr que vous voulez supprimer ce message ?', 'Diesen Beitrag wirklich löschen ?', 'Sei sicuro di voler eliminare questo post?', 'Deletar post ?', 'Вы уверены, что хотите удалить эту заметку?', '¿ Seguro que deseas eliminar est&amp;aacute; publicaci&amp;oacute;n?', 'Eğer bu mesajı silmek istediğinizden emin misiniz?'),
(247, 'edit_post', '', 'Edit Post', 'تعديل', 'Wijzig bericht', 'Modifier le message', 'Betrag bearbeiten', 'Modifica Post', 'Editar Post', 'Редактировать заметку', 'Editar Publicaci&amp;oacute;n', 'Düzenle'),
(248, 'session_expired', '', 'Session Expired', 'انتهت الجلسة !', 'Sessie is verlopen', 'La session a expiré', 'Sitzung abgelaufen', 'Sessione scaduta', 'Sess&amp;ccedil;o expirada', 'Время сессии истекло', 'Sesi&amp;oacute;n Expirada', 'Oturum süresi doldu'),
(249, 'session_expired_message', '', 'Your Session has been expired, please login again.', 'لقد تم أنتهاء جلستك, الرجاء الدخول مرة أخرى', 'Je sessie is verlopen, log opnieuw in.', 'Votre session a expiré, s&#39;il vous plaît vous connecter à nouveau.', 'Deine Sitzung ist abgelaufen, bitte melde dich erneut an.', 'La tua sessione è scaduta, effettua il login di nuovo.', 'Sess&amp;ccedil;o expirada. Fa&amp;ccedil;a login para continuar.', 'Время сессии истекло, пожалуйста, войдите еще раз.', 'Tu sesi&amp;oacute;n ha expirado, ingresa nuevamente.', 'Sizin Oturum süresi dolmuş olması, tekrar giriş yapınız.'),
(250, 'country', '', 'Country', 'البلد', 'Land', 'Pays', 'Land', 'Nazione', 'Pa&amp;iacute;s', 'Страна', 'Pa&amp;iacute;s', 'Ülke'),
(251, 'all', '', 'All', 'الكل', 'Alle', 'Tous', 'Alle', 'Tutti', 'Tudo', 'Все', 'Todo', 'Hepsi'),
(252, 'gender', '', 'Gender', 'الجنس', 'Geslacht', 'Genre', 'Geschlecht', 'Genere', 'Genero', 'Пол', 'Genero', 'Cinsiyet'),
(253, 'female', 'gender', 'Female', 'أنثى', 'Vrouw', 'Femelle', 'Weiblich', 'Femmina', 'Mulher', 'Женский', 'Mujer', 'Dişi'),
(254, 'male', 'gender', 'Male', 'ذكر', 'Man', 'Mâle', 'Männlich', 'Maschio', 'Homem', 'Мужской', 'Hombre', 'Erkek'),
(255, 'profile_picture', '', 'Profile Picture', 'الصورة الشخصية', 'Profielfoto', 'Photo de profil', 'Profilfoto', 'Immagine del profilo', 'Imagem de Perfil', 'Профиль фото', 'Imagen de perfil', 'Profil fotoğrafı'),
(256, 'result', '', 'Result', 'النتائج:', 'Resultaat:', 'Résultat:', 'Ergebnis:', 'Risultato:', 'Resultado', 'Результат:', 'Resultado:', 'Sonuç:'),
(257, 'yes', '', 'Yes', 'نعم', 'Ja', 'Oui', 'Ja', 'Si', 'Sim', 'Да', 'Si', 'Evet'),
(258, 'no', '', 'No', 'لا', 'Nee', 'Non', 'Nein', 'No', 'N&amp;atilde;o', 'Нет', 'No', 'Hayır'),
(259, 'verified_user', '', 'Verified User', 'حساب موثّق', 'Bekende Babster', 'vérifié utilisateur', 'Verifiziertes Mitglied', 'Utente Verificato', 'Contribuidor', 'Проверенный пользователь', 'Usuario Verificado', 'Doğrulanmış Kullanıcı'),
(260, 'change_password', '', 'Change Password', 'تغير كلمة المرور', 'Wijzig Wachtwoord', 'Changer le mot de passe', 'Passwort ändern', 'Cambiare la password', 'Mudar Senha', 'Изменить пароль', 'Cambiar contrase&amp;ntilde;a', 'Şifre değiştir'),
(261, 'current_password', '', 'Current Password', 'كلمة المرور الحالية', 'Huidig wachtwoord', 'Mot de passe actuel', 'Aktuelles Passwort', 'Password attuale', 'Senha Atual', 'Текущий пароль', 'Contrase&amp;ntilde;a actual', 'Şifreniz'),
(262, 'repeat_password', '', 'Repeat password', 'أعادة كلمة المرور', 'Herhaal wachtwoord', 'Répéter le mot de passe', 'Passwort wiederholen', 'Ripeti la password', 'Confirme sua senha atual', 'Повторите пароль', 'Repetir contrase&amp;ntilde;a', 'Şifreyi tekrar girin'),
(263, 'general', '', 'General', 'العامة', 'Algemeen', 'Général', 'Allgemein', 'Generale', 'Geral', 'Основные', 'General', 'Genel'),
(264, 'profile', '', 'Profile', 'الصفحة الشخصية', 'Profiel', 'Profil', 'Profil', 'Profilo', 'Perfil', 'Профиль', 'Perfil', 'Profil'),
(265, 'privacy', '', 'Privacy', 'الخصوصية', 'Privacy', 'Intimité', 'Privatsphäre', 'Privacy', 'Privacidade', 'Конфиденциальность', 'Privacidad', 'Gizlilik'),
(266, 'delete_account', '', 'Delete Account', 'حذف الحساب', 'Verwijder je account', 'Effacer le compte', 'Konto löschen', 'Ellimina Account', 'Deletar conta', 'Удалить аккаунт', 'Eliminar cuenta', 'Hesabım sil'),
(267, 'delete_account_confirm', '', 'Are You sure that you want to delete your account, and leave our network ?', 'هل أنت متأكد من حذف حسابك , وترك موقعنا ؟', 'Weet je zeker dat je je account voor goed wil verwijderen?', 'Etes-vous sûr que vous voulez supprimer votre compte, et de laisser notre réseau ?', 'Möchtest du Dein Konto wirklich löschen und &quot;wen-kennt-wer&quot; verlassen?', 'Sei sicuro di voler eliminare il tuo account, e lasciare la nostra rete?', 'Deletar conta e sair da nossa rede social ?', 'Вы уверены, что хотите удалить свой аккаунт, и оставить нашу сеть?', '¿ Seguro que deseas eliminar tu cuenta ?', 'Hesabınızı silmek ve ağımızı ayrılmak istediğinizden emin misiniz?'),
(268, 'delete_go_back', '', 'No, I&#039;ll Think', 'لا , ليس الآن.', 'Nee, liever niet', 'Non, je vais y réfléchir', 'Ich möchte nochmal eine Nacht drüber schlafen', 'No, ci penserò', 'N&amp;atilde;o, irei pensar melhor.', 'Нет, я подумаю', 'No, fue un error', 'Hayır, bence olacak'),
(269, 'verified', '', 'Verified', 'توثيق', 'Geverifieerd', 'vérifié', 'Verifiziert', 'Verificato', 'Verificado', 'Подтвержден', 'Verificado', 'Doğrulanmış'),
(270, 'not_verified', '', 'Not verified', 'غير موثّق', 'Niet Geverifieerd', 'non vérifié', 'Nicht verifiziert', 'Non Verificato', 'N&amp;atilde;o &amp;eacute; verificado', 'Не подтвержден', 'No verificado', 'Doğrulanmadı'),
(271, 'admin', '', 'Admin', 'مدير', 'Admin', 'Administrateur', 'Admin', 'Administratore', 'Admin', 'Админ', 'Administrador', 'Yönetici'),
(272, 'user', '', 'User', 'مستخدم', 'Gebruiker', 'Utilisateur', 'Benutzer', 'Utente', 'Usu&amp;uacute;rio', 'Пользователь', 'Usuario', 'Kullanıcı'),
(273, 'verification', '', 'Verification', 'التأكيد', 'Verificatie', 'Vérification', 'Verifizierung', 'Verifica', 'Verifica&amp;ccedil;&amp;atilde;o', 'Верификация', 'Verificaci&amp;oacute;n', 'Doğrulama'),
(274, 'type', '', 'Type', 'النوع', 'Type', 'Type', 'Typ', 'Tipo', 'Tipo', 'Тип', 'Tipo', 'Tip'),
(275, 'birthday', '', 'Birthday', 'تاريخ الميلاد', 'Geboortedatum', 'Anniversaire', 'Geburtstag', 'Compleano', 'Anivers&amp;aacute;rio', 'Дата рождения', 'Cumplea&amp;ntilde;os', 'Doğum Günü'),
(276, 'active', '', 'Active', 'مفعل', 'Actief', 'actif', 'Aktiv', 'Attivo', 'Ativo', 'Активный', 'Activo', 'Aktif'),
(277, 'inactive', '', 'inactive', 'غير مفعل', 'Inactief', 'inactif', 'Inaktiv', 'Innativo', 'Desativar Login', 'Неактивный', 'Inactivo', 'Pasif'),
(278, 'privacy_setting', '', 'Privacy Setting', 'إعدادات الخصوصية', 'Privacy Instellingen', 'Paramètre de confidentialité', 'Privatsphäre Einstellungen', 'Impostazione di Privacy', 'Configura&amp;ccedil;&amp;otilde;es de privacidade', 'Настройки конфиденциальности', 'Configuraci&amp;oacute;n de privacidad', 'Gizlilik ayarı'),
(279, 'follow_privacy_label', '', 'Who can follow me ?', 'من يستطيع متابعتي ؟', 'Wie kan mij volgen?', 'Qui peut me suivre ?', 'Wer darf mir folgen?', 'Chi può seguirmi?', 'Quem pode me seguir ?', 'Кто может следовать за мной?', '¿ Qui&amp;eacute;n puede seguirme ?', 'Kim beni takip edebilirim?'),
(280, 'everyone', '', 'Everyone', 'الكل', 'Iedereen', 'Toutes les personnes', 'Jeder', 'Tutti', 'Todos', 'Все', 'Todos pueden ver', 'Herkes'),
(281, 'my_friends', '', 'My Friends', 'أصدقائي', 'Mijn vrienden', 'Mes amis', 'Meine Freunde', 'Miei amici', 'Amigos', 'Мои друзья', 'Mis Amigos', 'Arkadaşlarım'),
(282, 'no_body', '', 'No body', 'لا أحد', 'Niemand', 'Personne', 'Niemand', 'Nessuno', 'Ningu&amp;eacute;m', 'Никто', 'Nadie', 'hiçbir vücut'),
(283, 'people_i_follow', '', 'People I Follow', 'أعضاء أتابعهم', 'Mensen die ik volg', 'Les gens que je suivre', 'Personen denen ich folge', 'Persone che Seguo', 'Pessoas que eu sigo', 'За кем я следую', 'Personas que sigo', 'İnsanlar izleyin'),
(284, 'people_follow_me', '', 'People Follow Me', 'أعضاء يتابعونني', 'Mensen die mij volgen', 'Les gens Follow Me', 'Persone die mir folgen', 'Persone che mi seguono', 'Pessoas que me seguem', 'Кто следует за мной', 'Personas que me sigue', 'İnsanlar beni takip etti'),
(285, 'only_me', '', 'Only me', 'أنا فقط', 'Alleen ik', 'Seulement moi', 'Nur ich', 'Solo Io', 'apenas eu', 'Только мне', 'Solo yo', 'Sadece ben'),
(286, 'message_privacy_label', '', 'Who can message me ?', 'من يستطيع إرسال رسالة لي ؟', 'Wie kan mij een bericht sturen?', 'Qui peut me message ?', 'Wer darf mir Nachrichten schreiben?', 'Chi può inviarmi i messaggi?', 'quem pode me enviar mensagem ?', 'Кто может отправлять мне сообщения?', '¿Qui&amp;eacute;n puede enviarme mensajes?', 'Kim bana mesaj olabilir?'),
(287, 'timeline_post_privacy_label', '', 'Who can post on my timeline ?', 'من يستطيع النشر على حائطي ؟', 'Wie kan mij krabbelen?', 'Qui peut poster sur mon calendrier ?', 'Wer darf an meine Pinwand schreiben?', 'Chi può postare su mia timeline?', 'quem pode postar na minha linha do tempo ?', 'Кто может публиковать на моей стене?', '¿Qui&amp;eacute;n puede publicar en mi perfil?', 'Benim zaman çizelgesi üzerinde kim gönderebilir?'),
(288, 'activities_privacy_label', '', 'Show my activities ?', 'إضهار إنشطتي', 'Laat mijn activiteiten zien?', 'Afficher mes activités ?', 'Zeige meine Aktivitäten?', 'Visualizza le mie attività?', 'Mostrar minhas atividades ?', 'Показывать мою деятельность?', '¿Mostrar mi actividad?', 'Benim faaliyetleri göster?'),
(289, 'show', '', 'Show', 'إظهار', 'Ja', 'Montrer', 'Zeigen', 'Mostra', 'Mostrar', 'Показать', 'Mostrar', 'Göster'),
(290, 'hide', '', 'Hide', 'أخفي', 'Nee', 'Cache', 'Verstecken', 'Nascondi', 'Esconder', 'Скрывать', 'Ocultar', 'Gizl'),
(291, 'confirm_request_privacy_label', '', 'Confirm request when someone follows you ?', 'قبول الطلب أو رفضه عندما يتابعك مستخدم ؟', 'Bevestig verzoek wanneer iemand jou volgt?', 'Confirmer la demande quand quelqu&#39;un vous suit ?', 'Anfrage bestätigen wenn mir jemand folgen möchte?', 'Confermare richiesta quando qualcuno ti segue?', 'Aceitar que a pessoa te siga ?', 'Подтверждать запрос когда кто-то следует за вами?', '¿Confirmar cuando alguien te sigue?', 'Birisi size izlediğinde isteği onaylayın?'),
(292, 'lastseen_privacy_label', '', 'Show my last seen ?', 'إظهار أخر ظهور ؟', 'Laat mijn laatst gezien zien?', 'Afficher mon dernière fois ?', 'Zeigen was ich zuletzt gesehen habe?', 'Mostra mia ultima visita?', 'Mostrar a &amp;uacute;ltima vez que voc&amp;ecirc; foi visto ?', 'Показывать мой последний визит?', '¿Mostrar mi &amp;uacute;ltima conexi&amp;oacute;n?', 'Benim son görüldüğü göster?'),
(293, 'site_eg', '', '(e.g: http://www.siteurl.com)', '(مثال: http://www.enbrash.com)', '(e.g: http://www.siteurl.com)', '(e.g: http://www.siteurl.com)', '(z.B.: http://www.meine-seite.de)', '(Esempio: http://www.siteurl.com)', '(exemplo: http://www.siteurl.com)', '(например: http://www.siteurl.com)', '(e.j: http://www.siteurl.com)', '(örneğin: http://www.siteurl.com)'),
(294, 'profile_setting', '', 'Profile Setting', 'إعدادات الصفحة الشخصية', 'Profiel Instellingen', 'Profile Setting', 'Profil Einstellungen', 'Impostazioni Profilo', 'Configura&amp;ccedil;&amp;otilde;es de Perfil', 'Профиль настройки', 'Configuraci&amp;oacute;n de perfil', 'Profil Ayarı'),
(295, 'pinned_post', '', 'Pinned', 'مثبت', 'Vastgezete Bericht', 'épinglé', 'Angepinnt', 'Appuntato', 'Fixo', 'Важная', 'Anotado', 'Sabitlenmiş'),
(296, 'pin_post', '', 'Pin Post', 'تثبيت', 'Vastzetten', 'Pin Poster', 'Beitrag Anpinnen', 'Appunta un Post', 'Fixar post', 'Закрепить заметку', 'Anotar publicaci&amp;oacute;n', 'Pim'),
(297, 'unpin_post', '', 'Unpin Post', 'إلغاء تثبيت', 'Niet meer vastzetten', 'Détacher Poster', 'Beitrag Abpinnen', 'Rimuovi il Post Appuntato', 'Desafixar Post', 'Снять заметку', 'Des anotar publicaci&amp;oacute;n', 'Kaldırılıncaya'),
(298, 'open_post_in_new_tab', '', 'Open post in new tab', 'أفتح في صفحة جديدة', 'Open bericht in nieuw tapblad', 'Ouvrir dans un nouvel onglet après', 'Beitrag in neuem Fenster öffnen', 'Alberino aperto in una nuova scheda', 'Abrir post em uma nova aba', 'Открыть в новой вкладке', 'Abrir en nueva pestaña', 'Yeni sekmede aç sonrası'),
(299, 'unsave_post', '', 'Unsave Post', 'إلغاء حفظ المنشور', 'Verwijderen', 'unsave Poster', 'Beitrag nicht mehr speichern', 'Non salvare post', 'N&amp;atilde;o salvar post', 'Не сохранять заметку', 'No guardar publicaci&amp;oacute;n', 'Kaydetme Seçeneğini'),
(300, 'save_post', '', 'Save Post', 'حفظ المنشور', 'Opslaan', 'Sauvegarder Poster', 'Beitrag speichern', 'Salva Post', 'Salvar Post', 'Сохранить заметку', 'Guardar publicaci&amp;oacute;n', 'Kaydet Mesaj'),
(301, 'unreport_post', '', 'Unreport Post', 'إلغاء التبليغ', 'Verwijder Aangeven', 'Unreport Poster', 'Beitrag nicht mehr melden', 'Ellimina segnalazione di questo Post', 'N&amp;atilde;o reportar Post', 'Не жаловаться', 'Quitar reporte', 'Rapor sil'),
(302, 'report_post', '', 'Report Post', 'تبليغ المنشور', 'Bericht aangeven', 'Signaler le message', 'Beitrag melden', 'Segnala questo Post', 'Reportar Post', 'Пожаловаться', 'Reportar publicaci&amp;oacute;n', 'Rapor'),
(303, 'shared_this_post', '', 'Shared this post', 'شارك هذا المنشور', 'Heeft dit bericht gedeeld', 'Partagé ce post', 'hat diesen Beitrag geteilt', 'Condividi questo Post', 'Compartilhar post', 'поделился этой записью', 'Comparti&amp;oacute; est&amp;aacute; publicaci&amp;oacute;n', 'Bu yazı paylaştı'),
(304, 'changed_profile_picture_male', '', 'changed his profile picture', 'غير صورته الشخصية', 'Heeft zijn profielfoto gewijzigd', 'Changé sa photo de profil', 'hat sein Profilbild geändert', 'Cambiato l&#039;immagine del profilo', 'Mudou sua imagem de perfil', 'изменил свою фотографию', 'Cambio su foto de perfil', 'Onun profil resimlerini değiştirdi'),
(305, 'changed_profile_picture_female', '', 'changed her profile picture', 'غيرت صورتها الشخصية', 'Heeft haar profielfoto gewijzigd', 'A changé sa photo de profil', 'hat ihr Profilbild geändert', 'Cambiato sua immagine del profilo', 'Mudou sua imagem de perfil', 'изменила свою фотографию', 'Cambio su foto de perfil', 'Onun profil resimlerini değiştirdi'),
(306, 'post_login_requriement', '', 'Please log in to like, wonder, share and comment!', 'الرجاء الدخول لعمل إعجاب , تعجب , وكومنت !', 'Login om te respecteren, te reageren!', 'S&#039;il vous plaît vous connecter à aimer, étonnant, partager et commenter !', 'Bitte melde dich zuerst an!', 'Effettua il login per piacere, meraviglia, condividere e commentare!', 'Fa&amp;ccedil;a login para compartilhar, curtir, comentar, etc !', 'Пожалуйста войдите или зарегистрируйтесь, чтобы добавлять &quot;Мне нравится&quot; и комментарии!', '¡ Ingresa para dar Like, Comentar, Seguir y muchas cosas m&amp;aacute;s !', 'Merak, pay gibi ve Yorumlamak için giriş yapınız!'),
(307, 'likes', '', 'Likes', 'الإعجابات', 'Respects', 'Aime', 'Gefällt mir', 'Mi piace', 'Curtiu', 'Нравится', 'Me gusta', 'Beğeniler'),
(308, 'like', '', 'Like', 'إعجاب', 'Respect!', 'Aimer', 'Gefällt mir', 'Mi piace', 'Curtir', 'Мне нравится', 'Me gusta', 'Beğen'),
(309, 'wonder', '', 'Wonder', 'تعجب', 'Wonder', 'Merveille', 'Wundert mich', 'Wonder', 'N&amp;atilde;o curtir', 'Удивляться!', 'Me sorprende', 'Merak et'),
(310, 'wonders', '', 'Wonders', 'التعجبات', 'Super Respects', 'Merveilles', 'Verwundert', 'Wonders', 'Dislikes', 'Удивляться', 'Me sorprende', 'Merakler'),
(311, 'share', '', 'Share', 'شارك', 'Delen', 'Partagez', 'Teilen', 'Condividi', 'Compartilhar', 'Перепост', 'Compartir', 'Paylaş'),
(312, 'comments', '', 'Comments', 'التعليقات', 'Reacties', 'commentaires', 'Kommentare', 'Commenti', 'Coment&amp;aacute;rios', 'Комментарии', 'Comentarios', 'Yorumlar'),
(313, 'no_likes', '', 'No likes yet', 'لا يوجد إعجابات', 'Geen respects', 'Aucune aime encore', 'Noch keine Gefällt mir Angaben', 'Non hai ancora un mi piace', 'Nenhuma curtida ainda', 'Пока нет &quot;Мне нравится&quot;', 'Sin Me Gusta', 'Hiç beğeniler yok'),
(314, 'no_wonders', '', 'No wonders yet', 'لا يوجد تعجبات', 'Geen super respects', 'Pas encore wondres', 'Noch keine Verwunderungen', 'Ancora nessun wondres', 'Nenhum dislike ainda', 'Неудивительно, пока', 'Sin Me Sorprende', 'Hiç merakler yok'),
(315, 'write_comment', '', 'Write a comment and press enter', 'اكتب تعليق وأضغط أنتر ..', 'Schrijf je reactie en druk dan op enter', 'Ecrire un commentaire et appuyez sur Entrée', 'Schreibe einen Kommentar und drücke Enter', 'Scrivi un commento e premere invio', 'Escreva um coment&amp;aacute;rio e d&amp;ecirc; enter', 'Напишите комментарий и нажмите клавишу ВВОД', 'Escribe un comentario y presiona enter', 'Bir yorum yazın ve enter tuşuna basın ..'),
(316, 'view_more_comments', '', 'View more comments', 'إظهار المزيد من التعليقات', 'Bekijk meer reacties', 'Voir plus de commentaires', 'Mehr Kommentare zeigen', 'Visualizza più commenti', 'Vizualizar mais coment&amp;aacute;rios', 'Посмотреть больше комментариев', 'Ver m&amp;aacute;s comentarios', 'Daha fazla yorum'),
(317, 'welcome_to_news_feed', '', 'Welcome to your News Feed !', 'أهلا بك في صفحة أحدث المنشورات !', 'Welkom op je tijdlijn !', 'Bienvenue à votre Nouvelles RSS!', 'Willkkommen in deinem News-Feed!', 'Benvenuto nel tuo News Feed!', 'Bem vindo as nossa not&amp;iacute;cias !', 'Добро пожаловать в ленту новостей!', '¡ Bienvenido a tu muro de noticias !', 'Hoş geldiniz!'),
(318, 'say_hello', '', 'Say Hello !', 'قل مرحباً !', 'Zeg snel Hallo !', 'Dis bonjour !', 'Sag Hallo!', 'Saluta !', 'Diga Ol&amp;aacute; !', 'Скажи привет!', '¡ Di hola !', 'Merhaba de !'),
(319, 'publisher_box_placeholder', '', 'What&#039;s going on? #Hashtag.. @Mention.. Link..', 'ما الذي يحصل الآن ؟ #هاشتاغ .. @إشارة', 'Hoe gaat het vandaag? #Hashtag.. @Vermeld..', 'Ce qui se passe? #hashtag ..@Mention..', 'Was ist los? #Hashtag.. @Erwähnen..', 'A cosa sti pensando? ..', 'O que voc&amp;ecirc; esta fazendo? #Hashtag.. @Mencione.. Link..', 'Что у Вас нового? #Хэштегом... @Упоминание...', '¿ Que est&amp;aacute;s pensando ? #Anime #lolis.. @Otakus..', 'Ne söylemek istersin ? #Hashtag .. @Mansiyon ..'),
(320, 'youtube_link', '', 'Youtube Link', 'رابط اليوتيوب', 'Youtube Link', 'Youtube Link', 'Youtube Link', 'Youtube Link', 'Youtube Link', 'Youtube Ссылка', 'Link de Youtube', 'Youtube Bağlantısık'),
(321, 'vine_link', '', 'Vine Link', 'رابط الفاين', 'Vine Link', 'Vine Link', 'Vine Link', 'Vine Link', 'Vine Link', 'Vine Ссылка', 'Link de Vine', 'Vine Bağlantı'),
(322, 'soundcloud_link', '', 'SoundCloud Link', 'رابط الساوندكلاود', 'SoundCloud Link', 'SoundCloud Link', 'SoundCloud Link', 'SoundCloud Link', 'SoundCloud Link', 'SoundCloud Ссылка', 'Link de SoundCloud', 'Soundcloud Bağlantı'),
(323, 'maps_placeholder', '', 'Where are you ?', 'أين أنت الآن ؟', 'Waar ben je ?', 'Où es tu?', 'Wo bist du?', 'Dove ti trovi?', 'Onde voc&amp;ecirc; esta ?', 'Это где?', '¿ Donde est&amp;aacute;s ?', 'Neredesin ?'),
(324, 'post_label', '', 'Post', 'نشر', 'Plaats', 'Poster', 'LOS', 'Post', 'Post', 'Отправить', 'Publicar', 'Gönder'),
(325, 'text', '', 'Text', 'النصوص', 'Tekst', 'Envoyer des textos', 'Text', 'Testo', 'Texto', 'Заметки', 'Texto', 'Metin'),
(326, 'photos', '', 'Photos', 'الصور', 'Foto&#039;s', 'Photos', 'Fotos', 'Foto', 'Fotos', 'Фото', 'Fotos', 'Resimler'),
(327, 'sounds', '', 'Sounds', 'الموسيقى', 'muziek', 'Des sons', 'Musik', 'Musica', 'Sons', 'Аудио', 'Sonidos', 'Sesler'),
(328, 'videos', '', 'Videos', 'الفيديو', 'Video&#039;s', 'Les vidéos', 'Videos', 'Video', 'V&amp;iacute;deos', 'Видео', 'Videos', 'Videolar'),
(329, 'maps', '', 'Maps', 'الخرائط', 'Maps', 'Plans', 'Karten', 'Mappe', 'Mapas', 'Карты', 'Mapas', 'Haritalar'),
(330, 'files', '', 'Files', 'الملفات', 'Files', 'Dossiers', 'Dateien', 'File', 'Arquivos', 'Файлы', 'Archivos', 'Dosyalar'),
(331, 'not_following', '', 'Not following any user', 'لا يوجد متابِعين', 'Volgt nog geen mensen', 'Ne pas suivre tout utilisateur', 'folgt niemandem', 'Non seguire qualsiasi utente', 'N&amp;atilde;o segue ningu&amp;eacute;m', 'Не следовать', 'No sigues a ning&amp;uacute;n usuario', 'Herhangi kullanıcıları takip Değil'),
(332, 'no_followers', '', 'No followers yet', 'لا يوجد متابَعين', 'Heeft geen volgers', 'Pas encore adeptes', 'hat keine Verfolger', 'Non hai ancora nessuno che ti segue', 'Nenhum seguidor ainda', 'Пока нет последователей', 'Sin seguidores', 'Henüz takipçileri'),
(333, 'details', '', 'Details', 'المعلومات العامة', 'Details', 'Détails', 'Einzelheiten', 'Detagli', 'Detalhes', 'Информация', 'Detalles', 'Detaylar'),
(334, 'social_links', '', 'Social Links', 'الروابط الاجتماعية', 'Sociale Links', 'Liens sociaux', 'Sociallinks', 'Link Sociali', 'Redes Sociais', 'Социальные ссылки', 'Enlaces Sociales', 'Sosyal Bağlantılar'),
(335, 'online_chat', '', 'Chat', 'الأصدقاء المتصلين', 'Online vrienden', 'amis en ligne', 'Freunde Online', 'Utenti Attivi', 'Amigos Online', 'Друзья онлайн', 'Amigos Conectados', 'Çevrimiçi arkadaş'),
(336, 'about', '', 'About', 'حول', 'About', 'Sur', 'Über Uns', 'Su di noi', 'Sobre', 'О нас', 'Pin', 'Yaklaşık'),
(337, 'contact_us', '', 'Contact Us', 'إتصل بنا', 'Contact Us', 'Contactez nous', 'Kontaktiere uns', 'Contattaci', 'Contato', 'Контакты', 'Contacto', 'Bize Ulaşın'),
(338, 'privacy_policy', '', 'Privacy Policy', 'سياسة الخصوصية', 'Privacy Policy', 'politique de confidentialité', 'Datenschutz', 'Privacy Policy', 'Privacidade', 'Политика', 'Pol&amp;iacute;tica', 'Gizlilik Politikası'),
(339, 'terms_of_use', '', 'Terms of Use', 'شروط الاستخدام', 'Terms of Use', 'Conditions d&#39;utilisation', 'Nutzungsbedingungen', 'Condizioni d&#039;uso', 'Termos de Uso', 'Условия', 'Condiciones', 'Kullanım Şartları'),
(340, 'developers', '', 'Developers', 'المطورين', 'Developers', 'Développeurs', 'Entwickler', 'Sviluppatori', 'Desenvolvedores', 'Разработчикам', 'Developers', 'Geliştiriciler'),
(341, 'language', '', 'Language', 'اللغة', 'Language', 'Langue', 'Sprache', 'Lingua', 'Linguagem', 'Язык', 'Idioma', 'Dil'),
(342, 'copyrights', '', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}', '© {date} {site_name}'),
(343, 'year', '', 'year', 'سنة', 'jaar', 'an', 'Jahr', 'Anno', 'ano', 'год', 'A&amp;ntilde;o', 'yıl'),
(344, 'month', '', 'month', 'شهر', 'maand', 'mois', 'Monat', 'mese', 'm&amp;ecirc;s', 'месяц', 'mes', 'ay'),
(345, 'day', '', 'day', 'يوم', 'dag', 'jour', 'Tag', 'giorno', 'dia', 'день', 'd&amp;iacute;a', 'gün'),
(346, 'hour', '', 'hour', 'ساعة', 'uur', 'heure', 'Stunde', 'ora', 'hora', 'час', 'hora', 'saat'),
(347, 'minute', '', 'minute', 'دقيقة', 'minuut', 'minute', 'Minute', 'minuto', 'minuto', 'минут', 'minuto', 'dakika');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(348, 'second', '', 'second', 'ثانية', 'seconde', 'deuxième', 'Sekunde', 'secondo', 'segundo', 'секунд', 'segundo', 'saniye'),
(349, 'years', '', 'years', 'سنوات', 'jaren', 'années', 'Jahre', 'anni', 'anos', 'лет', 'a&amp;ntilde;os', 'yıllar'),
(350, 'months', '', 'months', 'اشهر', 'maanden', 'mois', 'Monate', 'messi', 'meses', 'месяцев', 'meses', 'aylar'),
(351, 'days', '', 'days', 'أيام', 'dagen', 'jours', 'Tage', 'giorni', 'dias', 'дней', 'd&amp;iacute;as', 'günler'),
(352, 'hours', '', 'hours', 'ساعات', 'uren', 'des heures', 'Stunden', 'ore', 'horas', 'часов', 'horas', 'saatler'),
(353, 'minutes', '', 'minutes', 'دقائق', 'minuten', 'minutes', 'Minuten', 'minuti', 'minutos', 'минут', 'minutos', 'dakika'),
(354, 'seconds', '', 'seconds', 'ثانية', 'seconden', 'secondes', 'Sekunden', 'secondi', 'segundos', 'секунд', 'segundos', 'saniye'),
(355, 'time_ago', '', 'ago', 'منذ', 'geleden', 'depuis', '', 'fa', 'atr&amp;aacute;s', 'назад', '', 'önce'),
(356, 'time_from_now', '', 'from now', 'من الآن', 'van nu', 'à partir de maintenant', 'ab jetzt', 'da adesso', 'agora', 'С этого момента', 'desde ahora', 'şu andan itibaren'),
(357, 'time_any_moment_now', '', 'any moment now', 'في أي لحظة الآن', 'een moment geleden', 'd un moment', 'jeden Moment', 'da un momento all&#039;altro', 'algum tempo atr&amp;aacute;s', 'В любой момент', 'cualquier momento', 'Şimdi her an'),
(358, 'time_just_now', '', 'Just now', 'ألآن', 'Net geplaats', 'Juste maintenant', 'Gerade eben', 'Proprio adesso', 'Neste momento', 'Прямо сейчас', 'Ahora', 'Şu anda'),
(359, 'time_about_a_minute_ago', '', 'about a minute ago', 'منذ دقيقة', 'een minuut geleden', 'Il ya environ une minute', 'Vor einer Minute', 'circa un minuto fa', 'minuto atr&amp;aacute;s', 'минуту назад', 'Hace un minuto', 'yaklaşık bir dakika önce'),
(360, 'time_minute_ago', '', '%d minutes ago', 'منذ %d دقائق', '%d minuten geleden', '%d il y a quelques minutes', 'vor %d Minuten', '%d minuti fa', '%d minutos atras', '%d минут назад', 'hace %d minutos', '%d dakika önce'),
(361, 'time_about_an_hour_ago', '', 'about an hour ago', 'منذ ساعة', 'een uur geleden', 'il y a à peu près une heure', 'Vor einer Stunde', 'circa un&#039;ora fa', 'uma hora atr&amp;aacute;s', 'около часа назад', 'Hace una hora', 'yaklaşık bir saat önce'),
(362, 'time_hours_ago', '', '%d hours ago', 'منذ %d ساعات', '%d uren geleden', '%d il y a des heures', 'vor %d Stunden', '%d ore fa', '%d horas atras', '%d часов назад', 'Hace %d horas', '%d saatler önce'),
(363, 'time_a_day_ago', '', 'a day ago', 'منذ يوم', 'a dag geleden', 'a Il ya jour', 'Gestern', 'a giorni fa', 'dia atr&amp;aacute;s', 'день назад', 'Hace un dia', 'bir gün önce'),
(364, 'time_a_days_ago', '', '%d days ago', 'منذ %d أيام', '%d dagen geleden', '%d il y a quelques jours', 'vor %d Tagen', '%d giorni fa', '%d dias atras', '%d дней назад', 'Hace %d dias', '%d gün önce'),
(365, 'time_about_a_month_ago', '', 'about a month ago', 'منذ شهر', 'een maand geleden', 'il y a environ un mois', 'vor einem Monat', 'circa un mese fa', 'um m&amp;ecirc;s atr&amp;aacute;s', 'Около месяца назад', 'Hace un mes', 'yaklaşık bir ay önce'),
(366, 'time_months_ago', '', '%d months ago', 'منذ %d أشهر', '%d maanden geleden', '%d il y a des mois', 'vor %d Monaten', '%d mesi fa', '%d meses atr&amp;aacute;s', '%d месяц назад', 'Hace %d meses', '%d aylar önce'),
(367, 'time_about_a_year_ago', '', 'about a year ago', 'منذ سنة', 'een jaar geleden', 'Il ya environ un an', 'vor einem Jahr', 'circa un anno fa', 'um ano atr&amp;aacute;s', 'около года назад', 'Hace un año', 'yaklaşık bir yıl önce'),
(368, 'time_years_ago', '', '%d years ago', 'منذ %d سنوات', '%d jaar geleden', '%d il y a des années', 'vor %d Jahren', '%d anni fa', '%d anos atr&amp;aacute;s', '%d много лет назад', 'Hace %d años', '%d yıllar önce'),
(369, 'latest_activities', '', 'Latest Activities', 'آخر النشاطات', 'Laatste Activiteiten', 'Dernières activités', 'Letzte Aktivitäten', 'Ultimi Attività', '&amp;uacute;ltimas atividades', 'Последнии действия', 'Actividad reciente', 'Son Aktiviteler'),
(370, 'no_activities', '', 'No new activities', 'لا يوجد نشاطات', 'Geen nieuwe activiteiten', 'Pas de nouvelles activités', 'Keine neuen Aktivitäten', 'Non ci sono nuove attività', 'Nenhuma atividade nova', 'Нет действий', 'No hay actividad reciente', 'Aktiviteler yok'),
(371, 'trending', '', 'Trending !', 'الهاشتاغات النشطة !', 'Populair!', 'Trending !', 'Im Trend!', 'Tendenza !', 'Assunto do momento !', 'Тенденции!', '¡ Popular !', 'Trend!'),
(372, 'load_more_activities', '', 'Load more activities', 'تحميل المزيد من النشاطات', 'Laad meer activiteiten', 'Chargez plus d&#39;activités', 'Weitere Aktivitäten laden', 'Carica altri attività', 'Carregar mais atividades', 'Загрузить больше', 'Cargar mas actividad', 'Daha fazla faaliyetleri yükle'),
(373, 'no_more_actitivties', '', 'No more actitivties', 'لا يوجد المزيد من النشاطات', 'Geen andere activiteiten', 'Pas plus d&#39;activités', 'Keine weiteren Aktivitäten', 'Nessun altro attività', 'Nenhuma atividade nova', 'Нет больше действий', 'No hay mas actividad', 'Daha faaliyetler yok'),
(374, 'people_you_may_know', '', 'People you may know', 'مستخدمين قد تعرفهم', 'Mensen die je misschien kent', 'Les gens que vous connaissez peut-être', 'Personen die Du vielleicht kennst', 'Persone che Potresti Conoscere', 'Pessoas que voc&amp;ecirc; talvez conhe&amp;ccedil;a', 'Люди, которых вы можете знать', 'Personas que tal vez conozcas', 'Tanıyor olabileceğin kişiler'),
(375, 'too_long', '', 'Too long', 'طويل جداَ', 'Te lang', 'Trop long', 'Zu Lang', 'Troppo lungo', 'Muito grande.', 'Слишком длинный', 'Muy largo', 'Too long'),
(376, 'too_short', '', 'Too short.', 'قصير جداَ', 'To kort.', 'Trop court.', 'Zu Kurz.', 'Troppo corto.', 'Muito curto.', 'Слишком короткий.', 'Muy corto.', 'Too short.'),
(377, 'available', '', 'Available !', 'متاح !', 'Beschikbaar!', 'Disponible !', 'Verfügbar!', 'A disposizione !', 'Available !', 'Доступный!', '¡ Disponible !', 'Available !'),
(378, 'in_use', '', 'In use.', 'مستخدم', 'In gebruik.', 'En service.', 'In Benutzung.', 'In uso.', 'Em uso.', 'В использовании.', 'En uso.', 'In use.'),
(379, 'username_invalid_characters_2', '', 'Username should not contain any special characters, symbols or spaces.', 'يجب اسم المستخدم أن لا يحتوي على أية أحرف خاصة أو رموز أو مسافات.', 'Gebruikersnaam mag geen speciale tekens bevatten.', 'Nom d&#39;utilisateur ne doit pas contenir de caractères, symboles ou espaces spéciaux.', 'Bitte keine Sonder- oder Leerzeichen verwenden.', 'Nome utente non deve contenere caratteri speciali, simboli o spazi.', 'O nome de usu&amp;uacute;rio N&amp;atilde;o deve conter nenhum carectere especial, s&amp;iacute;mbolo ou espa&amp;ccedil;os.', 'Имя пользователя не должно содержать каких-либо специальных символов или пробелов.', 'Nombre de usuario no valido, no debe contener s&amp;iacute;mbolos, caracteres especiales o espacios.', 'Username should not contain any special characters, symbols or spaces.'),
(380, 'liked', '', 'Liked', 'معجب', 'Vond', 'A aimé', 'gefällt dir', 'Piacuto', 'Curtiu', 'Нравится', 'Me gusta', 'Beğendim'),
(381, 'my_pages', '', 'My Pages', 'صفحاتي', 'Mijn pagina&#039;s', 'Mes Pages', 'Meine Seiten', 'Mie Pagine', 'Minhas P&amp;aacute;ginas', 'Мои Страницы', 'Mis páginas', 'Benim Sayfalar'),
(382, 'liked_page', '', 'Liked your page ({page_name})', 'أعجب بصفحتك ({page_name})', 'Vond je pagina ({page_name})', 'a aimé votre page ({page_name})', 'gefällt Deine Seite ({page_name})', 'Piaciuto tua pagina ({page_name})', 'Curtiu sua p&amp;aacute;gina ({page_name})', 'нравится ваша страница ({page_name})', 'Me gustó tu página ({page_name})', 'Sayfanızı Beğendi ({page_name})'),
(383, 'this_week', '', 'This week', 'إعجابات هذا الإسبوع', 'Deze week', 'Cette semaine', 'in dieser Woche', 'Questa settimana', 'Essa semana', 'На этой неделе', 'Esta semana', 'Bu hafta'),
(384, 'posts', '', 'posts', 'المشاركات ', 'posts', 'des postes', 'Beiträge', 'messaggi', 'Postagens', 'сообщений', 'Mensajes', 'Mesajları'),
(385, 'located_in', '', 'Located in', 'موجود في', 'Gelegen in', 'Situé dans', 'Wohnt in', 'Situata in', 'Localiza&amp;ccedil;&amp;atilde;o', 'Город', 'Situado en', 'Bulunan'),
(386, 'phone_number', '', 'Phone', 'الهاتف', 'Telefoon', 'Téléphone', 'Telefon', 'Telefono', 'Telefone', 'Телефон', 'Teléfono', 'Telefon'),
(387, 'company', '', 'Company', 'شركة', 'Bedrijf', 'Compagnie', 'Unternehmen', 'Azienda', 'Empresa', 'Компания', 'Empresa', 'şirket'),
(388, 'category', '', 'Category', 'القسم', 'Categorie', 'Catégorie', 'Kategorie', 'Categoria', 'Categoria', 'Категория', 'Categoría', 'Kategori'),
(389, 'search_for_posts', '', 'Search for posts', 'إبحث عن منشورات', 'Zoeken naar berichten', 'Rechercher les messages', 'Nach Beiträgen suchen', 'Cerca messaggi', 'Procurar posts', 'Поиск заметок', 'Buscar mensajes', 'Mesajları ara'),
(390, 'create_new_page', '', 'Create New Page', 'إنشاء صفحة جديدة', 'Nieuwe pagina', 'Créer une page', 'Neue Seite erstellen', 'Crea nuova pagina', 'Criar uma nova p&amp;aacute;gina', 'Создать страницу', 'Crear nueva página', 'Yeni Sayfa Oluştur'),
(391, 'page_name', '', 'Page name', 'إسم الصفحة (الذي يظهر في رابط الصفحة)', 'Pagina naam', 'Nom de la page', 'Seitenname', 'Nome della Pagina', 'Nome da p&amp;aacute;gina', 'Название', 'Nombre de la página', 'Sayfa adı'),
(392, 'page_title', '', 'Page title', 'عنوان الصفحة', 'Pagina titel', 'Titre de la page', 'Seitentitel', 'Titolo della Pagina', 'T&amp;iacute;tulo da p&amp;aacute;gina', 'Заголовок', 'Título de la página', 'Sayfa başlığı'),
(393, 'your_page_title', '', 'Your page title', 'عنوان صفحتك', 'Uw pagina titel', 'Votre titre de la page', 'Dein Seitentitel', 'Il tuo titolo della Pagina', 'T&amp;iacute;tulo da sua p&amp;aacute;gina', 'Заголовок страницы', 'Tu página de título', 'Sizin sayfa başlık'),
(394, 'page_category', '', 'Page Category', 'القسم', 'Pagina Categorie', 'page Catégorie', 'Seiten-Kategorie', 'Categoria', 'Categoria da p&amp;aacute;gina', 'Категория', 'Página Categoría', 'Sayfa Kategori'),
(395, 'page_description', '', 'Page description', 'حول الصفحة', 'Pagina beschrijving', 'Description de la page', 'Seitenbeschreibung', 'Descrivi la tua pagina', 'Descri&amp;ccedil;&amp;atilde;o da p&amp;aacute;gina', 'Описание страницы', 'Descripción de la página', 'Sayfa açıklaması'),
(396, 'page_description_info', '', 'Your Page description, Between 10 and 200 characters max.', 'معلومات حول صفحتك', 'Uw pagina beschrijving, tussen de 10 en 200 karakters max.', 'Votre description de la page, entre 10 et 200 caractères max.', 'Deine Seitenbeschreibung, zwischen 10 und 200 Zeichen max.', 'La tua descrizione pagina, tra i 10 ei 200 caratteri massimo.', 'A descri&amp;ccedil;&amp;atilde;o da sua p&amp;aacute;gina deve conter entre 10 e 200 caracteres.', 'Описание страницы между 10 и 200 символов макс.', 'Su descripción de página, entre 10 y 200 caracteres máx.', '10 ve 200 karakter max Arasında Sayfanız açıklama'),
(397, 'create', '', 'Create', 'إنشاء', 'Creëren', 'Créer', 'Erstellen', 'Crea', 'Criar', 'Создать', 'Crear', 'Yarat'),
(398, 'page_name_exists', '', 'Page name is already exists.', 'إسم الصفحة مستخدم بل الفعل', 'Pagina naam is al bestaat.', 'Nom de la page est existe déjà.', 'Seitenname ist bereits vorhanden.', 'Nome della pagina è esiste già.', 'O nome dessa p&amp;aacute;gina j&amp;aacute; esta sendo usado.', 'Название страницы уже существует.', 'Nombre de la página es que ya existe.', 'Sayfa adı zaten var olduğunu.'),
(399, 'page_name_characters_length', '', 'Page name must be between 5 / 32', 'إسم الصفحة يجب ان يكون بين 5 الى 32 حرف', 'Pagina naam moet tussen 5/32', 'Nom de la page doit être comprise entre 5/32', 'Seitenname muss zwischen 5 und 32 Zeichen bestehen', 'Nome della pagina deve essere compresa tra 5/32', 'O nome da p&amp;aacute;gina deve conter entre 5 / 32 caracteres', 'Название страницы должно быть между 5/32 символами', 'Nombre de la página debe estar entre 5/32', 'Sayfa adı 5/32 arasında olmalıdır'),
(400, 'page_name_invalid_characters', '', 'Invalid page name characters', 'صيغة اسم الصفحة خاطئة', 'Ongeldige pagina naam tekens', 'Invalides nom de la page caractères', 'Ungültige Zeichen vorhanden', 'Caratteri del nome di pagina non valida', 'Caracteres inv&amp;aacute;lidos', 'Недопустимые символы в Названии страницы', 'Caracteres del nombre de la página no válidos', 'Geçersiz sayfa adı karakterleri'),
(401, 'edit', '', 'Edit', 'تصحيح', 'Bewerk', 'modifier', 'Bearbeiten', 'Modifica', 'Editar', 'редактировать', 'Editar', 'Düzenleme'),
(402, 'page_information', '', 'Page Information', 'معلومات الصفحة', 'Pagina Informatie', 'Informations sur la page', 'Seiteninformationen', 'Informazioni pagina', 'Informa&amp;ccedil;&amp;otilde;es da p&amp;aacute;gina', 'Информация о странице', 'Página de información', 'Sayfa Bilgileri'),
(403, 'delete_page', '', 'Delete Page', 'حذف الصفحة', 'Pagina Verwijderen', 'supprimer la page', 'Seite löschen', 'Ellimina Pagina', 'Deletar p&amp;aacute;gina', 'Удалить страницу', 'Eliminar página', 'Sayfayı Sil'),
(404, 'location', '', 'Location', 'موقع', 'Plaats', 'Emplacement', 'Lage', 'Posizione', 'localização', 'Расположение', 'Ubicación', 'Konum'),
(405, 'pages_you_may_like', '', 'Pages you may like', 'صفحات قد تعجبك', 'Pagina&#039;s die je misschien graag', 'Pages que vous aimerez', 'Seiten, die Dir gefallen', 'Pagine che potete gradire', 'P&amp;aacute;ginas que talvez voc&amp;ecirc; goste', 'Рекомендуемые страницы', 'Páginas que le gustará', 'Eğer gibi olabilir Sayfalar'),
(406, 'show_more_pages', '', 'Show more pages', 'أظهر المزيد من الثفحات', 'Toon meer pagina&#039;s', 'Voir plus de pages', 'Zeige mehr Seiten', 'Mostra più pagine', 'Mostrar mais p&amp;aacute;ginas', 'Показать больше страниц', 'Mostrar más páginas', 'Daha fazla sayfa göster'),
(407, 'no_more_pages', '', 'No more pages to show', 'لا يوجد المزيد', 'Geen pagina te tonen', 'No more pages to show', 'Keine weiteren Seiten vorhanden,', 'Niente più pagine per mostrare', 'Nenhuma p&amp;aacute;gina nova para mostrar', 'Нет больше страниц', 'No más páginas para mostrar', 'Yok daha fazla sayfa göstermek için'),
(408, 'page_delete_confirmation', '', 'Are you sure you want to delete this page?', 'هل أنت متأكد أنك تريد حذف هذه الصفحة ؟', 'Bent u zeker dat u deze pagina wilt verwijderen?', 'Etes-vous sûr de vouloir supprimer cette page?', 'Bist Du sicher das Du diese Seite löschen möchtest?', 'Sei sicuro di voler cancellare questa pagina?', 'Deletar p&amp;aacute;gina?', 'Вы уверены, что хотите удалить эту страницу?', '¿Seguro que quieres borrar esta página?', 'Bu sayfayı silmek istediğinizden emin misiniz?'),
(409, 'manage_pages', '', 'Manage Pages', 'إدارة الصفحات', 'Pagina&#039;s beheren', 'gérer les pages', 'Seiten verwalten', 'Gestisci Pagine', 'Editar p&amp;aacute;ginas', 'Управление страницами', 'Gestionar páginas', 'Sayfaları Yönet'),
(410, 'owner', '', 'Owner', 'المدير', 'Eigenaar', 'Propriétaire', 'Inhaber', 'Proprietario', 'Dono', 'Владелец', 'Propietario', 'Sahib'),
(411, 'no_pages_found', '', 'No pages to show', 'لا يوجد صفحات', 'Geen pagina&#039;s gevonden', 'Aucune page trouvé', 'Keine Seiten gefunden', 'Nessuna pagina trovata', 'Nenhuma p&amp;aacute;gina encontrada', 'Не найдено ни одной страницы', 'No se encontraron páginas', 'Hiçbir sayfalar bulunamadı'),
(412, 'welcome_wonder', '', 'Wonder', 'تعجب', 'Wonder', 'Merveille', 'Wundern', 'Wonder', 'N&amp;atilde;o curtiu', 'Pintter', 'Pintter', 'şaşkınlık'),
(413, 'welcome_connect', '', 'Connect', 'إتصل', 'Aansluiten', 'connecter', 'Verbinden', 'Connettiti', 'Conectar', 'Подключайтесь', 'Conectar', 'Bağlamak'),
(414, 'welcome_share', '', 'Share', 'شارك', 'Delen', 'Partagez', 'Teilen', 'Condividi', 'Compartilhar', 'Делитесь', 'Compartir', 'Pay'),
(415, 'welcome_discover', '', 'Discover', 'إستكشف', 'Ontdekken', 'Découvrir', 'Entdecken', 'Scoprire', 'Descobrir', 'Знакомьтесь', 'Descubrir', 'Keşfedin'),
(416, 'welcome_find_more', '', 'Find more', 'جد المزيد', 'Vind meer', 'Trouve plus', 'Mehr fnden', 'Trova più', 'Procurar mais', 'Найдите больше', 'Encuentra más', 'Daha fazla bul'),
(417, 'welcome_mobile', '', 'Mobile Friendly', 'متناسق مع جميع الأجهزة', 'Mobile Vriendelijk', 'mobile bienvenus', '100% Mobilfreundlich', 'Mobile Friendly', 'Amigos pelo celular', 'Адаптивный дизайн', 'Mobile Amistoso', 'Mobil Dostu'),
(418, 'welcome_wonder_text', '', 'Wonder (NEW), ability to wonder a post if you don&#039;t like it.', 'تعجب (جديد), ميزة جديدة تستطيع من خلالها التعجب بل المنشورات.', 'Wonder (NEW), de mogelijkheid om een bericht af of je niet bevalt.', 'Wonder (NOUVEAU), la capacité à se demander un poste si vous ne l&#39;aimez pas.', '(NEU) Wundern, die Möglichkeit, einen Beitrag zu markieren, in Frage zu stellen, weil Du es nicht glaubst oder verstehst.', 'Wonder (NEW), capacità di stupirsi un post, se non ti piace.', 'N&amp;atilde;o curtir (NEW), abilidade para N&amp;atilde;o curtir um post.', 'Свободно и без ограничений, делитесь своими публикациями со всем миром.', 'Libre y sin restricciones, asombroso para compartir tus publicaciones en todo el mundo.', 'Eğer beğenmezseniz bir yazı merak (YENİ), yetenek Wonder.'),
(419, 'welcome_connect_text', '', 'Connect with your family and friends and share your moments.', 'تواصل مع عائلتك وأصدقائك شارك اللحظات الخاصة بك.', 'Verbinden met je familie en vrienden en deel je momenten.', 'Connectez-vous avec votre famille et vos amis et partager vos moments.', 'Ein modernes soziales Netzwerk für den Kontakt zu Deiner Familie und Freunden.', 'Connettiti con la tua famiglia e gli amici e condividere i tuoi momenti.', 'Conecte com seus amigos e fam&amp;iacute;lia, e compartilhe seus momentos.', 'Общайтесь с вашей семьей и друзьями, поделитесь своими лучшими моментами.', 'Conéctate con tu familia y amigos para compartir los mejores momentos.', 'Aileniz ve arkadaşlarınızla bağlamak ve anları paylaşmak.'),
(420, 'welcome_share_text', '', 'Share what&#039;s new and life moments with your friends.', 'شارك الحظات الجديدة في حياتك مع أصدقائك.', 'Deel wat nieuw is en het leven momenten met je vrienden.', 'Partager ce sont des moments de nouvelles et de la vie avec vos amis.', 'Teile mit Deinen Freunden, Nachbarn und Kollegen alles was neu ist. Zeige was Dir gefällt.', 'Condividi ciò che è nuovo e la vita momenti con i tuoi amici.', 'Compartilhe o que acontece em sua vida com seus amigos.', 'Поделитесь своим контентом с помощью Pintter и получите самое лучшее продвижение.', 'Comparte todos tus contenidos a través de Pintter y consigue la mejor promoción.', 'Arkadaşlarınızla yeni ve yaşam anları ne paylaşın.'),
(421, 'welcome_discover_text', '', 'Discover new people, create new connections and make new friends.', 'إكتشف أشخاص جدد، وأنشىء اتصالات جديدة وكون صداقات جديدة.', 'Ontdek nieuwe mensen, nieuwe verbindingen te maken en nieuwe vrienden maken.', 'Découvrez de nouvelles personnes, créer de nouvelles connexions et de faire de nouveaux amis.', 'Entdecke neue Leute, neue Verbindungen und neue Freunde.', 'Scoprire nuove persone, creare nuove connessioni e fare nuove amicizie.', 'Descubra novas pessoas, fa&amp;ccedil;a amigos e se divirta!', 'Откройте для себя новых людей, создавайте связи и заводите новых друзей.', 'Descubre nuevas personas, haz nuevas conexiones y nuevos contactos.', 'Yeni insanlarla keşfedin, yeni bağlantılar oluşturmak ve yeni arkadaşlar.'),
(422, 'welcome_find_more_text', '', 'Find more of what you&#039;re looking for with WoWonder Search.', 'أبحث عن ما تريد مع  نظام بحث واواندر', 'Vind meer van wat je zoekt met WoWonder Search.', 'Trouver plus de ce que vous n &#39;êtes à la recherche d&#39;avec WoWonder Recherche.', 'Finde viel mehr, was Du mit wen-kennt-wer-Suche suchst.', 'Trova più di quello che stai cercando con WoWonder Ricerca.', 'Veja mais do que voc&amp;ecirc; esta procurando com o WoWonder Search.', 'Узнайте больше о том, что вы ищете с помощью функции поиска Pintter.', 'Encuentras más de lo que estás buscando con el nuevo Pintter Buscador.', 'Eğer WoWonder Arama ile aradığınızı daha bulun.'),
(423, 'welcome_mobile_text', '', '100% screen adaptable on all tablets and smartphones.', '100% متناسق مع جميع الأجهزة من الهواتف الذكية والتابلت', '100% scherm passen op alle tablets en smartphones.', 'Écran 100% adaptable sur toutes les tablettes et les smartphones.', '100% für Dein Tablet und Smartphone angepasst.', 'Schermo100%  adattato su tutti i tablet e smartphone.', 'Tela 100% adapt&amp;aacute;vel em todos os tablets e smartphones.', '100% адаптируется к любому мобильному экрану, таблету или смарт-устройству.', '100% adaptable a cualquier pantalla móvil, tabletas o dispositivo inteligentes.', 'Tüm tabletler ve akıllı telefonlarda uyarlanabilir %100 ekran.'),
(424, 'working_at', '', 'Working at', 'يعمل في', 'Werken bij', 'Travailler à', 'Arbeitet bei', 'Lavorare in', 'Trabalhando em', 'Работает в', 'Trabajando en', 'Çalışmak'),
(425, 'relationship', '', 'Relationship', 'الحالة الإجتماعية', 'Verhouding', 'Relation', 'Beziehung', 'Relazione', 'Relacionamento', 'Отношения', 'Relación', 'ilişki'),
(426, 'none', '', 'None', 'غير محدد', 'Geen', 'Aucun', 'Keine', 'Nessuna', 'Nenhum', 'Не выбрано', 'Ninguno', 'Hiçbiri'),
(427, 'avatar', '', 'Avatar', 'الصورة الشخصية', 'Avatar', 'Avatar', 'Profilbild', 'Avatar', 'Avatar', 'Аватар', 'Avatar', 'Avatar'),
(428, 'cover', '', 'Cover', 'الغلاف', 'Deksel', 'Couverture', 'Titelbild', 'Immagine di copertura', 'Capa', 'Обложка', 'Fondo', 'Kapak'),
(429, 'background', '', 'Background', 'خلفية صفحتك الشحصية', 'Achtergrond', 'Contexte', 'Hintergrund', 'Sfondo', 'Fundo', 'Задний план', 'Fondo de Pantalla', 'Geçmiş'),
(430, 'theme', '', 'Theme', 'الثيم', 'Thema', 'Thème', 'Thema', 'Temi', 'Tema', 'Тема', 'Tema', 'Tema'),
(431, 'deafult', '', 'Default', 'الإفتراضي', 'Standaard', 'Défaut', 'Standard', 'Predefinito', 'Padr&amp;ccedil;o', 'По умолчанию', 'Defecto', 'Standart'),
(432, 'my_background', '', 'My Background', 'الخاص بي', 'Mijn Achtergrond', 'Mon arrière-plan', 'Mein Hintergrund', 'Mio Sfondo', 'Meu fundo', 'Мой фон', 'Mi pasado', 'Benim Arkaplan'),
(433, 'company_website', '', 'Company website', 'الموقع الإلكتروني للعمل', 'Bedrijfs websitee', 'Site Web de l&#39;entreprise', 'Unternehmenswebseite', 'Sito Sociaeta', 'Site da empresa', 'Веб-сайт компании', 'Página Web de la compañía', 'Şirket Web Sitesi'),
(434, 'liked_my_page', '', 'Liked My Page', 'معجبين بصفحتي', 'Vond Mijn pagina', 'Aimé Ma Page', 'gefällt meine Seite', 'Mi è piaciuta la mia pagina', 'Curtiu minha p&amp;aacute;gina', 'Понравилась моя страница', 'Me gustó mi página', 'Benim Sayfam Beğendi'),
(435, 'dislike', '', 'Dislike', 'عدم الإعجاب', 'Afkeer', 'Aversion', 'nicht gefallen', 'Antipatia', 'N&amp;atilde;o curtir', 'Не нравится', 'No me gusta', 'Beğenmeme'),
(436, 'dislikes', '', 'Dislikes', 'غير معجبين', 'Antipathieën', 'Dégoûts', 'Unbeliebt', 'Antipatia', 'N&amp;atilde;o curtiu', 'Не нравится', 'No le gusta', 'Sevmedikleri'),
(437, 'disliked_post', '', 'disliked your {postType} {post}', 'لم يعجب {postType} {post}', 'hekel aan je {postType} {post}', 'détesté votre {postType} {post}', 'gefällt dein Beitrag {postType} {post} nicht', 'antipatia tuo {postType} {post}', 'N&amp;atilde;o curtiu seu {postType} {post}', 'не нравится {postType} {post}', 'no le gusta tu {postType} {post}', 'senin {postType} sevmiyordu {post}'),
(438, 'disliked_comment', '', 'disliked your comment &quot;{comment}&quot;', 'لم يعجب بتعليقك &quot;{comment}&quot;', 'hekel aan je reactie &quot;{comment}&quot;', 'détesté votre commentaire &quot;{comment}&quot;', 'gefällt dein Kommentar &quot;{comment}&quot;', 'antipatia tuo commento &quot;{comment}&quot;', 'N&amp;atilde;o curtiu seu coment&amp;aacute;rio &quot;{comment}&quot;', 'не нравится ваш комментарий &quot;{comment}&quot;', 'no le gustaba su comentario &quot;{comment}&quot;', 'sevilmeyen Yorumunuzu &quot;{comment}&quot;'),
(439, 'activity_disliked_post', '', 'disliked {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'لم يعجب &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;بمنشور&lt;/a&gt; {user} .', 'hekel {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'détesté {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'unbeliebt {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt; Beitrag &lt;/a&gt;.', 'antipatia {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'N&amp;atilde;o curtiu {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', '{user} не нравится &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;пост&lt;/a&gt;.', 'No me gustó {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt; posterior &lt;/a&gt;.', 'Sevmediği {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt; yazılan &lt;/a&gt;.'),
(440, 'second_button_type', '', 'Second post button type', 'نوع الزر الثاني للمنشور', 'Tweede post type knop', 'Deuxième poste de type bouton', 'Zweiter Likebutton', 'Secondo palo tipo di pulsante', 'Segundo tipo de bot&amp;ccedil;o', 'Второй тип кнопки', 'Segundo mensaje de tipo botón', 'İkinci sonrası düğmesi tipi'),
(441, 'group_name', '', 'Group name', 'إسم المجموعة', 'Groepsnaam', 'Nom de groupe', 'Gruppenname', 'Nome del gruppo', 'Nome do grupo', 'URL группы', 'Nombre del grupo', 'Grup ismi'),
(442, 'group_title', '', 'Group title', 'عنوان المجموعة', 'Groep titel', 'Titre de groupe', 'Gruppentitel', 'Titolo del gruppo', 'T&amp;iacute;tulo do grupo', 'Название группы', 'Título del Grupo', 'Grup başlık'),
(443, 'my_groups', '', 'My Groups', 'مجموعاتي', 'Mijn Groepen', 'Mes Groupes', 'Meine Gruppen', 'I miei gruppi', 'Meus grupos', 'Мои группы', 'Mis grupos', 'Gruplar'),
(444, 'school', '', 'School', 'المدرسة', 'School', 'L&#39;école', 'Schule', 'Scuola', 'Escola', 'Школа', 'Colegio', 'Okul'),
(445, 'site_keywords_help', '', 'Example: social, wowonder, social site', 'Example: social, wowonder, social site', 'Example: social, wowonder, social site', 'Example: social, wowonder, social site', 'Beispiel: soziale, wen-kennt-wer, soziale Website', 'Esempio: sociale, wowonder, sito di social', 'Exemplo: social, wowonder, site social', 'Пример: социальная сеть, pintter, социальный сайт', 'Ejemplo:, wowonder, sitio social sociales', 'Örnek: Sosyal, wowonder, sosyal sitesi'),
(446, 'message_seen', '', 'Message Seen', 'الرسائل المقروئة', 'Bericht Seen', 'Vu message', 'Nachricht gesehen', 'Messaggio Visto', 'Mensagem lida', 'Прочитал@', 'Mensaje Seen', 'İleti Seen'),
(447, 'recommended_for_powerful', '', 'Recommended for powerful servers', 'مستحسن للاسيرفرات القوية', 'Aanbevolen voor krachtige servers', 'Recommandé pour les puissants serveurs', 'Empfohlen für leistungsstarke Server', 'Consigliato per potenti server', 'Recomendado para servi&amp;ccedil;os pesados', 'Рекомендуется для мощных серверов', 'Recomendado para servidores de gran alcance', 'Güçlü sunucular için önerilen'),
(448, 'message_typing', '', 'Chat typing system', 'نظام &quot;يكتب&quot; للشات', 'Chat typering systeem', 'Système de typage chat', 'Chat Typisierungssystem', 'Sistema di digitazione Chat', 'Sistema de digita&amp;ccedil;&amp;atilde;o', 'Набирает сообщение', 'Sistema de tipificación de Chat', 'Sohbet yazarak sistemi'),
(449, 'reCaptcha', '', 'reCaptcha', 'reCaptcha', 'reCaptcha', 'reCaptcha', 'reCaptcha', 'reCaptcha', 'reCaptcha', 'ReCaptcha', 'reCaptcha', 'Tuttum'),
(450, 'instagram', 'Instagram', 'Instagram', 'إينستاجرام', 'Instagram', 'Instagram', 'Instagram', 'Instagram', 'Instagram', 'Instagram', 'Instagram', 'Instagram'),
(451, 'profile_visit_notification_help', '', 'if you don&#039;t share your visit event , you won&#039;t be able to see other people visiting your profile.', 'اذا لم تفعل زيارة الصفحة , فانك لن تكون قادرا على رؤية الاخرين وهم يزورون صفحتك.', 'als u niet uw bezoek evenement te delen, zult u niet in staat zijn om andere mensen een bezoek aan uw profiel te zien.', 'si vous ne partagez pas votre événement de la visite, vous ne serez pas en mesure de voir d&#39;autres gens qui visitent votre profil.', 'Wenn Du Deine Profilbesuche nicht teilen willst, können andere nicht sehen wenn du ihr Profil besucht hast.', 'se non si condivide il vostro evento visita, non sarà in grado di vedere altre persone che visitano il tuo profilo.', 'Se voc&amp;ecirc; N&amp;atilde;o abilitar a notifica&amp;ccedil;&amp;atilde;o de perfil, voc&amp;ecirc; N&amp;atilde;o poder&amp;aacute; ver quem visitou seu perfil.', 'Если отключить это уведомление, вы не будете получать уведомления о том кто посещал ваш профиль.', 'Si desactivas esta notificación tu tampoco recibirás avisos de visita de otros usuarios.', 'Eğer ziyaret olayı paylaşmak yoksa, profilinizi ziyaret eden diğer kişileri görmek mümkün olmayacaktır.'),
(452, 'account_delete', '', 'Delete Account', 'حذف الحساب', 'Account verwijderen', 'Effacer le compte', 'Konto löschen', 'Eliminare l&#039;account', 'Deletar conta', 'Удалить аккаунт', 'Borrar cuenta', 'Hesabı sil'),
(453, 'ip_address', '', 'IP Address', 'IP عنوان', 'IP Address', 'Adresse IP', 'IP Adresse', 'Indirizzo IP', 'Endere&amp;ccedil;o IP', 'Айпи адрес', 'Dirección IP', 'IP adresi'),
(454, 'manage_groups', '', 'Manage Groups', 'إدارة المجموعات', 'Groepen beheren', 'Gérer les groupes', 'Gruppen verwalten', 'Gestisci gruppi', 'Editar grupos', 'Управление группами', 'Administrar grupos', 'Grupları Yönet'),
(455, 'group_delete_confirmation', '', 'Are you sure you want to delete this group?', 'هل أنت متأكد أنك تريد حذف هذه المجموعة؟', 'Bent u zeker dat u deze groep wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ce groupe?', 'Bist Du sicher das Du diese Gruppe löschen möchtest?', 'Sei sicuro di voler eliminare questo gruppo?', 'Deletar este grupo?', 'Вы уверены, что хотите удалить эту группу?', '¿Seguro que quieres borrar este grupo?', 'Bu grubu silmek istediğinizden emin misiniz?'),
(456, 'no_more_groups', '', 'No more groups to show', 'لا يوجد المزيد من المجموعات', 'Geen groepen tonen', 'Pas de plusieurs groupes pour montrer', 'Keine weiteren Gruppen,', 'Nessun altro gruppo per mostrare', 'Nenhum grupo para mostrar', 'Нет больше групп для отображения', 'No hay más grupos que mostrar', 'Artık gruplar göstermek için'),
(457, 'show_more_groups', '', 'Show more groups', 'عرض المزيد من المجموعات', 'Toon meer groepen', 'Montrer plus de groupes', 'Mehrere Gruppen anzeigen', 'Mostra più gruppi', 'Mostrar mais grupos', 'Показать больше групп', 'Mostrar más grupos', 'Daha fazla gruplar göster'),
(458, 'members', '', 'Members', 'أفراد', 'leden', 'Membres', 'Mitglieder', 'Utenti', 'Membros', 'члены', 'Miembros', 'Üyeler'),
(459, 'verifications_requests', '', 'Verification Requests', 'طلبات الحسابات المؤكدة', 'Verificatie Verzoeken', 'Demandes de vérification', 'Verifizierungsanfragen', 'Richieste di verifica', 'Pedidos de verifica&amp;ccedil;&amp;atilde;o', 'Запросы', 'Solicitudes verificación', 'Doğrulama İstekleri'),
(460, 'verify', '', 'Verify', 'تأكيد', 'Verifiëren', 'Vérifier', 'Überprüfen', 'Verificare', 'Verificar', 'Добавить', 'Verificar', 'Doğrulamak'),
(461, 'ignore', '', 'Ignore', 'تجاهل', 'Negeren', 'Ignorer', 'Ignorieren', 'Ignorare', 'Ignorar', 'Игнорировать', 'Ignorar', 'Ignore'),
(462, 'page', '', 'Page', 'صفحة', 'Pagina', 'Page', 'Seite', 'Pagina', 'P&amp;aacute;gina', 'Страница', 'Página', 'Sayfa'),
(463, 'no_new_verification_requests', '', 'No new verification requests', 'لا يوجد طلبات جديدة للتحقق', 'Geen nieuwe verificatie aanvragen', 'Aucune nouvelle demande de vérification', 'Keine neuen Verifizierungsanfragen', 'Non ci sono nuove richieste di verifica', 'Nenhum pedido de verifica&amp;ccedil;&amp;atilde;o', 'Нет новых запросов', 'No hay nuevas solicitudes de verificación', 'Yeni doğrulama istekleri'),
(464, 'ban_user', '', 'Ban User', 'حظر العضو', 'Ban gebruiker', 'Ban User', 'Gesperrte Benutzer', 'Ban utente', 'Banir usu&amp;uacute;rio', 'Забанить', 'Ban usuario', 'Ban User'),
(465, 'banned', '', 'Banned', 'المحظور', 'Verboden', 'Banned', 'Verboten', 'Vietato', 'Banido', 'Забанен', 'Banned', 'Yasaklı'),
(466, 'there_are_no_banned_ips', '', 'There are no banned ips.', 'لا يوجد ips محطورة', 'Er zijn geen verboden ips.', 'Il n&#39;y a pas ips interdits.', 'Es sind keine gesperrte IPs.', 'Non ci sono ips vietati.', 'Nenhum IP banido.', 'Нет забаненных IPS.', 'No hay ips prohibidas.', 'Hiçbir yasak ips bulunmamaktadır.'),
(467, 'invalid_ip', '', 'Invalid ip address.', 'عنوان IP غير صالح.', 'Ongeldig IP-adres.', 'Adresse IP non valide.', 'Ungültige IP-Adresse.', 'Indirizzo IP non valido.', 'IP inv&amp;aacute;lido.', 'Неверный IP адрес.', 'Dirección IP no válida.', 'Geçersiz IP adresi.'),
(468, 'ip_banned', '', 'IP address successfully banned.', 'عنوان IP حظرت بنجاح.', 'IP-adres succesvol verbannen.', 'Adresse IP banni avec succès.', 'IP-Adresse erfolgreich verboten.', 'Indirizzo IP vietato con successo.', 'IP banido.', 'IP-адрес успешно забанен.', 'Dirección IP prohibida éxito.', 'IP adresi başarıyla yasaklandı.'),
(469, 'ip_exist', '', 'IP address already exist', 'عنوان IP موجودة بالفعل', 'IP-adres bestaan', 'Adresse IP existent déjà', 'Bereits vorhanden IP-Adresse', 'Indirizzo IP già esistente', 'J&amp;aacute; existe este IP', 'IP-адрес уже существует', 'Dirección IP ya existen', 'IP adresi zaten mevcut'),
(470, 'please_add_ip', '', 'Please add an ip address', 'يرجى إضافة عنوان IP', 'Voeg een ip-adres', 'S&#39;il vous plaît ajouter une adresse ip', 'Bitte füge eine IP-Adresse hinzu', 'Si prega di aggiungere un indirizzo IP', 'Adicione um IP', 'Пожалуйста, добавьте IP адрес', 'Por favor, añada una dirección IP', 'Bir ip adresinizi ekleyiniz'),
(471, 'ip_deleted', '', 'IP address successfully deleted', 'عنوان IP حذف بنجاح', 'IP-adres succesvol verwijderd', 'Adresse IP supprimé avec succès', 'IP-Adresse erfolgreich gelöscht', 'Indirizzo IP eliminato', 'IP deletado', 'IP-адрес успешно удален', 'Dirección IP eliminado correctamente', 'IP adresi başarıyla silindi'),
(472, 'email_me_when', '', 'Email me when', 'أرسل لي عندما', 'E-mail me als', 'Envoyez-moi lorsque', 'Email-Bnachrichtigung, wenn:', 'Inviami una email quando', 'Enviar e-mail quando algu&amp;eacute;m', 'Напишите, когда', 'Envíame un email:', 'Bana e-posta'),
(473, 'e_likes_my_posts', '', 'Someone liked my posts', 'شخص اعجب بمنشوري', 'Iemand hield van mijn berichten', 'Quelqu&#39;un aimait mes messages', 'Jemand wundert sich über meinen Beitrag', 'Qualcuno è piaciuto miei post', 'Curtir meus posts', 'Нравятся мои заметки', 'Cuando a alguien le gusta mis posts', 'Birisi Mesajları sevdim'),
(474, 'e_wondered_my_posts', '', 'Someone wondered my posts', 'شخص تعجب بمنشوري', 'Iemand vroeg me af van mijn berichten', 'Quelqu&#39;un demanda mes messages', 'Jemand mag meine Beiträge nicht', 'Qualcuno chiese miei post', 'Dar dislike em meus posts', 'Не нравятся мои заметки', 'Cuando alguien pregunta en mis posts', 'Birisi Mesajları merak'),
(475, 'e_commented_my_posts', '', 'Someone commented on my posts', 'شخص علق على منشوراتي', 'Iemand heeft gereageerd op mijn berichten', 'Quelqu&#39;un a commenté mes messages', 'Jemand kommentiert meine Beiträge', 'Qualcuno ha commentato i miei post', 'Comentar meus posts', 'Прокомментировали мои заметки', 'Cuando alguien comenta mis posts', 'Birisi benim mesajlar yorumladı'),
(476, 'e_shared_my_posts', '', 'Someone shared on my posts', 'شخص شارك منشوراتي', 'Iemand gedeeld op mijn berichten', 'Quelqu&#39;un partagé sur mes posts', 'Jemand teilt meine Beiträge', 'Qualcuno ha condiviso i miei post', 'Compartilhar meus posts', 'Поделились моими заметками', 'Cuando alguien comparte mis posts', 'Birisi benim yazılarda paylaştı'),
(477, 'e_followed_me', '', 'Someone followed me', 'شخص تابعني', 'Iemand volgde mij', 'Quelqu&#39;un m&#39;a suivi', 'Jemand folgt mir', 'Qualcuno mi ha seguito', 'Me seguir', 'Следуют за мной', 'Cuando alguien me sigue', 'Biri beni takip'),
(478, 'e_liked_page', '', 'Someone liked my pages', 'شخص أعجب بصفحة خاصة بي', 'Iemand hield van mijn pagina&#039;s', 'Quelqu&#39;un aimait mes pages', 'Jemand gefällt meine Seiten', 'Qualcuno è piaciuto mie pagine', 'Curtir minha p&amp;aacute;gina', 'Нравится моя страница', 'Cuando a alguien le gusta mis páginas', 'Birisi sayfalarını sevdim'),
(479, 'e_visited_my_profile', '', 'Someone visited my profile', 'شخص زار صفحتي الشخصية', 'Iemand bezocht mijn profiel', 'Quelqu&#39;un a visité mon profil', 'Jemand hat mein Profil besucht', 'Qualcuno ha visitato il mio profilo', 'Visitar meu perfil', 'Посетили мой профиль', 'Cuando alguien ha visitó mi perfil', 'Birisi profilimi ziyaret'),
(480, 'e_mentioned_me', '', 'Someone mentioned me', 'شخص ذكرني', 'Iemand noemde me', 'Quelqu&#39;un a parlé de moi', 'Jemand erwähnte mich', 'Qualcuno mi ha detto', 'Te mencionar', 'Упомянули меня', 'Cuando alguien me menciona', 'Biri bana söz'),
(481, 'e_joined_group', '', 'Someone joined my groups', 'شخص انضم الى مجموعاتي', 'Iemand trad mijn groepen', 'Quelqu&#39;un a rejoint mes groupes', 'Jemand ist meiner Gruppe beigetreten', 'Qualcuno è entrato miei gruppi', 'Entrar no meu grupo', 'Вступили в мою группу', 'Cuando alguien se une a mis grupos', 'Birisi grupları katıldı'),
(482, 'e_accepted', '', 'Someone accepted my friend/follow requset', 'شخص قبل طلب صادقتي/متابعتي', 'Iemand aanvaard mijn vriend / follow verzoek', 'Quelqu&#39;un a accepté mon ami / suivre la demande', 'Jemand akzeptiert mein Freundschaftsanfrage', 'Qualcuno ha accettato il mio amico / seguire la richiesta', 'Aceitar o meu pedido para seguir/adicionar aos amigos', 'Приняли дружбу / запрос следовать', 'Cuando alguien acepta mi petición', 'Birisi arkadaşım / takip et requset kabul'),
(483, 'e_profile_wall_post', '', 'Someone posted on my timeline', 'شخص نشر على صفحتي الشخصية', 'Iemand gepost op mijn timeline', 'Quelqu&#39;un a posté sur mon calendrier', 'Jemand hat etwas in mein Profil geschrieben', 'Qualcuno ha postato su mia timeline', 'Postar em sua linha do tempo', 'Публикация на стене профиля', 'Cuando alguien escribe en mi muro', 'Birisi benim zaman çizelgesi yayınlanan'),
(484, 'no_groups_found', '', 'No groups to show', 'لا يوجد مجموعات', 'Geen groepen gevonden', 'Pas de groupes trouvés', 'Keine Gruppen gefunden', 'Nessun gruppo trovato', 'Nenhum grupo encontrado', 'Группы не найдены', 'No se encontraron grupos', 'Grup bulunamadı'),
(485, 'group_information', '', 'Group information', 'معلومات المجموعة', 'Groep informatie', 'L&#39;information de groupe', 'Gruppenthemen', 'Informazioni Gruppo', 'Informa&amp;ccedil;&amp;otilde;es do grupo', 'Информация о группе', 'Información del Grupo', 'Grup bilgileri'),
(486, 'delete_group', '', 'Delete Group', 'حذف المجموعة', 'Groep verwijderen', 'Supprimer le groupe', 'Gruppe löschen', 'Elimina gruppo', 'Deletar grupo', 'Удалить группу', 'Eliminar grupo', 'Grubu Sil'),
(487, 'group_name_exists', '', 'Group name is already exists.', 'اسم المجموعة موجود بالفعل.', 'Groepsnaam is al bestaat.', 'Le nom du groupe est existe déjà.', 'Gruppenname ist bereits vorhanden.', 'Il nome del gruppo è già esistente.', 'Nome do grupo j&amp;aacute; esta em uso.', 'Название группы уже существует.', 'El nombre del grupo es ya existe.', 'Grup adı zaten var olduğunu.'),
(488, 'group_name_invalid_characters', '', 'Invalid group name characters', 'أحرف اسم مجموعة غير صالحة', 'Ongeldige naam van de groep tekens', 'Invalides nom de groupe caractères', 'Ungültige Gruppenname Zeichen', 'Caratteri del nome del gruppo non validi', 'Caracteres inv&amp;aacute;lidos', 'Недопустимые символы в URL группы', 'Caracteres del nombre de grupo no válido', 'Geçersiz grup adı karakter'),
(489, 'group_name_characters_length', '', 'Group name must be between 5 / 32', 'يجب أن يكون اسم المجموعة بين 5/32 حرف', 'Groepsnaam moet tussen 5/32', 'Le nom du groupe doit être comprise entre 5/32', 'Gruppenname muss zwischen 5 und 32 Zeichen bestehen', 'Il nome del gruppo deve essere compresa tra 5/32', 'O nome do grupo deve conter entre 5 / 32 caracteres', 'URL группы должен быть между 5/32 символами', 'Nombre del grupo debe estar entre 5/32', 'Grup ismi 5/32 arasında olmalıdır'),
(490, 'no_requests_found', '', 'No requests to show', 'لم يتم العثور على أية طلبات!', 'Geen verzoeken gevonden!', 'Aucune demande trouvée!', 'Keine Anfragen gefunden!', 'Nessuna richiesta trovata!', 'Não foram encontrados pedidos!', 'Запросов не найдено!', 'No se han encontrado solicitudes!', 'İstek bulunamadı!'),
(491, 'remove', '', 'Remove', 'إزالة', 'Verwijderen', 'Enlever', 'Entfernen', 'Rimuovere', 'Remover', 'Удалить', 'Eliminar', 'Kaldır'),
(492, 'no_members_found', '', 'No members to show', 'لم يتم العثور على أي أعضاء ', 'Er zijn geen leden gevonden', 'Aucun membre trouvé', 'Keine Mitglieder gefunden', 'Nessun membro trovato', 'Nenhum membro encontrado', 'Участники не найдены', 'No se encontraron miembros', 'Üye bulunamadı'),
(493, 'group_deleted', '', 'Group successfully deleted', 'تم حذف المجموعة بنجاح', 'Groep succesvol verwijderd', 'Groupe supprimé avec succès', 'Gruppe erfolgreich gelöscht', 'Gruppo cancellato con successo', 'Grupo deletado', 'Группа успешно удалена', 'Grupo eliminado correctamente', 'Grup başarıyla silindi'),
(494, 'create_new_group', '', 'Create New Group', 'إنشاء مجموعة جديدة', 'Nieuwe groep', 'Créer un nouveau groupe', 'Neue Gruppe erstellen', 'Crea nuovo gruppo', 'Criar novo grupo', 'Создать новую группу', 'Crear nuevo grupo', 'Yeni Grup Oluştur'),
(495, 'my_games', '', 'My Games', 'ألعابي', 'Mijn games', 'Mes Jeux', 'Meine Spiele', 'I miei giochi', 'Meus jogos', 'Мои игры', 'Mis juegos', 'Benim Oyunlar'),
(496, 'no_games_found', '', 'No games to show', 'لم يتم العثور على ألعاب', 'Geen games gevonden', 'Pas de jeux trouvés', 'Keine Spiele gefunden', 'Nessun gioco trovato', 'Nenhum jogo encontrado', 'Игры не найдены', 'No se han encontrado juegos', 'Hiçbir oyun bulunamadı'),
(497, 'groups', '', 'Groups', 'المجموعات', 'Groepen', 'Groupes', 'Gruppen', 'Gruppi', 'Grupos', 'Группы', 'Grupos', 'Gruplar'),
(498, 'no_friends', '', 'No friends yet', 'ليس لديه أصدقاء حتى الآن', 'Nog geen vriendent', 'Pas encore d&#39;amis', 'Noch keine Freunde', 'Non ci sono ancora amici', 'Nenhum amigo', 'Нет друзей', 'No tiene amigos todavía', 'Hiç arkadaşım yok'),
(499, 'no_groups', '', 'Didn&#039;t join any groups yet', 'لم ينضم أي مجموعة حتى الآن', 'Heeft een groep nog niet mee', 'N&#39;a pas encore de rejoindre les groupes', 'Hat noch keiner Gruppe beigetreten', 'Non ha ancora aderire a nessun gruppo', 'N&amp;atilde;o entrou em nenhum grupo', 'Не вступать ни в какие группы', 'No unirse a ningún grupo todavía', 'Henüz hiçbir gruba katılmadı'),
(500, 'load_more_pages', '', 'Load more pages', 'تحميل المزيد من الصفحات', 'Laad meer pagina&#039;s', 'Chargez plus de pages', 'Weitere Seiten laden', 'Caricare più pagine', 'Carregar mais p&amp;aacute;ginas', 'Загрузить больше страниц', 'Cargar más páginas', 'Daha fazla sayfaları yük'),
(501, 'load_more_groups', '', 'Load more groups', 'تحميل المزيد من المجموعات', 'Laad meer groepen', 'Chargez plusieurs groupes', 'Weitere Gruppen laden', 'Carica altri gruppi', 'Carregar mais grupos', 'Загрузить больше групп', 'Cargar más grupos', 'Daha fazla gruplar yükle'),
(502, 'joined_group', '', 'Joined your group ({group_name})', 'إنضم الى مجموعتك ({group_name})', 'Toegetreden tot de groep ({group_name})', 'Rejoint notre groupe ({group_name})', 'ist deiner Gruppe ({group_name}) beigetreten', 'Iscritto il nostro gruppo ({group_name})', 'Entrou no seu grupo ({group_name})', 'вступил@ в ({group_name})', 'Se ha unido a tu grupo ({group_name})', 'Kayıt grup ({group_name})'),
(503, 'happy', '', 'Happy', 'السعادة', 'Blij', 'Heureux', 'glücklich', 'Contento', 'Feliz', 'Счастливый', 'Feliz', 'Mutlu'),
(504, 'loved', '', 'Loved', 'الحب', 'Hield', 'Aimé', 'begeistert', 'Amato', 'Apaixonado', 'Влюбленный', 'Me encantaron', 'Sevilen'),
(505, 'sad', '', 'Sad', 'حزين', 'verdrietig', 'Triste', 'Traurig', 'Triste', 'Triste', 'Грустный', 'Triste', 'Üzgün'),
(506, 'so_sad', '', 'Very sad', 'الحزن الشديد', 'Zeer triest', 'Très triste', 'sehr traurig', 'Molto triste', 'Muito triste', 'Очень грустный', 'Muy triste', 'Çok üzgün'),
(507, 'angry', '', 'Angry', 'غاضب', 'Boos', 'En colère', 'Wütend', 'Arrabbiato', 'Bravo', 'Сердитый', 'Enojado', 'kızgın'),
(508, 'confused', '', 'Confused', 'الحيرة', 'Verward', 'Confus', 'verwirrt', 'Confuso', 'Confuso', 'В замешательстве', 'Confuso', 'Şaşkın'),
(509, 'smirk', '', 'Hot', 'ساخن', 'Warm', 'Chaud', 'Heiß', 'Caldo', 'Sexy', 'Горячий', 'Caliente', 'Sıcak'),
(510, 'broke', '', 'Broken', 'الاحباط', 'Gebroken', 'Brisé', 'am Boden zerstört', 'Rotte', 'Tra&amp;iacute;do', 'Сломанный', 'Roto', 'Broken'),
(511, 'expressionless', '', 'expressionless', 'مستغرب', 'Wezenloos', 'Inexpressif', 'ausdruckslos', 'Inespressivo', 'Sem express&amp;atilde;o', 'Без выражений', 'inexpresivo', 'ifadesiz'),
(512, 'cool', '', 'Cool', 'الروعة', 'Koel', 'Bien', 'cool', 'Bene', 'Legal', 'Круто', 'Guay', 'Güzel'),
(513, 'funny', '', 'Funny', 'الضحك', 'Grappig', 'Amusant', 'komisch', 'Divertente', 'Divertido', 'Веселая', 'Divertido', 'Komik'),
(514, 'tired', '', 'Tired', 'التعب', 'Moe', 'Fatigué', 'müde', 'Stanco', 'Cansado', 'Устала', 'Cansado', 'Yorgun'),
(515, 'lovely', '', 'Lovely', 'محب', 'Heerlijk', 'Charmant', 'sehr verliebt', 'Bello', 'Amavel', 'Прекрасный', 'Encantador', 'Güzel'),
(516, 'blessed', '', 'Blessed', 'المنحة', 'Gezegend', 'Béni', 'gesegnet', 'Benedetto', 'AbeN&amp;atilde;oado', 'Благословенный', 'Bendito', 'Mübarek'),
(517, 'shocked', '', 'Shocked', 'الصدمة', 'Geschokt', 'Choqué', 'schockiert', 'Scioccato', 'Chocado', 'В шоке', 'Conmocionado', 'Şokta'),
(518, 'sleepy', '', 'Sleepy', 'النعاس', 'Slaperig', 'Somnolent', 'schläfrig', 'Assonnato', 'Dormindo', 'Сонный', 'Soñoliento', 'Uykulu'),
(519, 'pretty', '', 'Pretty', 'الجمال', 'Mooi', 'Assez', 'hübsch', 'Bella', 'Bonito', 'Милая', 'bastante', 'Oldukça'),
(520, 'bored', '', 'Bored', 'الملل', 'Verveeld', 'Ennuyé', 'gelangweilt', 'Annoiato', 'Entediado', 'Скучающий', 'aburrido', 'Bıkkın'),
(521, 'total_users', '', 'Total Users', 'كل المستخدمين', 'Totaal aantal leden', 'Nombre d&#39;utilisateurs', 'Benutzer insgesamt', 'Totale Utenti', 'Total de usu&amp;uacute;rios', 'Всего пользователей', 'Total de usuarios', 'Toplam Kullanıcılar'),
(522, 'users', '', 'Users', 'المستخدمين', 'Gebruikers', 'Utilisateurs', 'Benutzer', 'Utenti', 'Usu&amp;uacute;rios', 'Пользователи', 'Usuarios', 'Kullanıcılar'),
(523, 'pages', '', 'Pages', 'الصفحات', 'Pagina&#039;s', 'Pages', 'Seiten', 'Pagine', 'P&amp;aacute;ginas', 'Страницы', 'Páginas', 'Sayfalar'),
(524, 'games', '', 'Games', 'الألعاب', 'Spelen', 'Jeux', 'Spiele', 'Giochi', 'Jogos', 'Игры', 'Juegos', 'Oyunlar'),
(525, 'online_users', '', 'Online Users', 'المستخدمين المتصلين', 'Online Gebruikers', 'Utilisateurs en ligne', 'User online', 'Utenti Online', 'Usu&amp;uacute;rios online', 'Сейчас на сайте', 'Usuarios en línea', 'Çevrimiçi Kullanıcılar'),
(526, 'recent_searches', '', 'Recent Searches', 'عمليات البحث الأخيرة', 'Recente zoekopdrachten', 'Recherches récentes', 'Letzte Suche', 'Ricerche recenti', 'Procuras recentes', 'Последние поисковые запросы', 'Búsquedas recientes', 'Son aramalar'),
(527, 'clear', '', 'Clear', 'مسح', 'Duidelijk', 'Clair', 'Klar', 'Chiaro', 'Limpar', 'Очистить', 'Claro', 'Açık'),
(528, 'search_filter', '', 'Search filter', 'البحث المتقدم', 'Search filter', 'Filtre de recherche', 'Suchfilter', 'Filtro di ricerca', 'Filtro de pesquisa', 'Фильтр поиска', 'Filtro de búsqueda', 'Arama filtresi'),
(529, 'keyword', '', 'Keyword', 'الكلمة', 'Zoekfilter', 'Mot-clé', 'Stichwort', 'Parola chiave', 'Palavra-chave', 'Ключевое слово', 'Palabra clave', 'Kelime'),
(530, 'what_are_looking_for', '', 'What are looking for ?', 'عن ماذا تبحث؟', 'Wat zoekt?', 'Que cherchez?', 'Was suchst du?', 'Quello che sono in cerca di ?', 'O que voc&amp;ecirc; esta procurando ?', 'Что вы ищете?', '¿Que están buscando ?', 'Ne arıyorsun?'),
(531, 'changed_profile_cover_picture_male', '', 'changed his profile cover', 'غير صورة الغلاف الخاص به', 'Veranderd zijn profiel deksel', 'Changé sa couverture de profil', 'hat sein Titelbild geändert', 'Cambiato la sua copertura del profilo', 'Trocou sua capa de perfil', 'Сменил обложку', 'Cambió su foto de perfil', 'Onun profil kapağı Değiştirildi'),
(532, 'changed_profile_cover_picture_female', '', 'changed her profile cover', 'غيرت صورة الغلاف الخاصة بها', 'Veranderde haar profiel deksel', 'Changé son profil couvercle', 'hat ihr Titelbild geändert', 'Cambiato suo profilo baiar', 'Trocou sua capa de perfil', 'Сменила обложку', 'Cambió su foto de perfil', 'Onun profil kapağı Değiştirildi'),
(533, 'latest_games', '', 'Latest games', 'آخر الألعاب', 'Nieuwste games', 'Derniers jeux', 'Neueste Spiele', 'Ultimi giochi', 'Jogos novos', 'Последние игры', 'Últimos Juegos', 'Son Eklenen Oyunlar'),
(534, 'no_albums_found', '', 'You haven&#39;t created any albums yet.', 'لا يوجد البومات', 'Geen albums gevonden', 'Aucun album n&#39;a été trouvé', 'Kein Album gefunden', 'Nessun album trovato', 'Nenhum &amp;aacute;lbum encontrado', 'Альбомов не найдено', 'No hay álbumes encontrados', 'Albüm bulunamadı'),
(535, 'create_album', '', 'Create album', 'إنشاء ألبوم', 'Maak een album', 'Créer un album', 'Album erstellen', 'Creare album', 'Criar &amp;aacute;lbum', 'Создать альбом', 'Crear albúm', 'Albüm oluştur'),
(536, 'my_albums', '', 'My Albums', 'البوماتي', 'Mijn Albums', 'Mes albums', 'Meine Alben', 'I miei album', 'Meus &amp;aacute;lbuns', 'Мои альбомы', 'Mis álbumes', 'Albümlerim'),
(537, 'album_name', '', 'Album name', 'اسم الالبوم', 'Albumnaam', 'Nom de l&#39;album', 'Name des Albums', 'Nome album', 'Nome do &amp;aacute;lbum', 'Название альбома', 'Nombre del álbum', 'Albüm adı'),
(538, 'upload', '', 'Upload', 'رفع', 'Uploaden', 'Télécharger', 'Hochladen', 'Caricare', 'Carregar', 'Загрузить', 'Subir', 'Yükleme'),
(539, 'add_photos', '', 'Add photos', 'إضافة صور', 'Foto&#039;s toevoegen', 'Ajouter des photos', 'Fotos hinzufügen', 'Aggiungi foto', 'Adicionar fotos', 'Добавить фотографии', 'Agregar fotos', 'Fotoğraf ekle');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(540, 'replies', '', 'Replies', 'ردود', 'Antwoorden', 'Réponses', 'Antworten', 'risposte', 'Respostas', 'Ответы', 'Respuestas', 'Cevaplar'),
(541, 'reply_to_comment', '', 'Reply to comment', 'ردعلى التعليق', 'Reageer op reactie', 'Répondre au commentaire', 'Auf Kommentar antworten', 'Rispondi al commento', 'Responder o coment&amp;aacute;rio', 'Ответить на комментарий', 'Responder al comentario', 'Yorumu yanıtla'),
(542, 'replied_to_comment', '', 'replied to your comment &quot;{comment}&quot;', 'رد على تعليقك &quot;{comment}&quot;', 'beantwoord je reactie &quot;{comment}&quot;', 'répondu à votre commentaire &quot;{comment}&quot;', 'hat auf Deinen Kommentar geantwortet &quot;{comment}&quot;', 'Risposto al tuo commento &quot;{comment}&quot;', 'respondeu seu coment&amp;aacute;rio &quot;{comment}&quot;', 'ответил@ на ваш комментарий &quot;{comment}&quot;', 'respondió a tu comentario &quot;{comment}&quot;', 'Yorumlarınız yanıtladı &quot;{comment}&quot;'),
(543, 'comment_reply_mention', '', 'mentioned you in a reply &quot;{comment}&quot;', 'ذكرك في رد على تعليق &quot;{comment}&quot;', 'je genoemd in een antwoord &quot;{comment}&quot;', 'vous avez mentionné dans une réponse &quot;{comment}&quot;', 'hat dich in einer Antwort erwähnt &quot;{comment}&quot;', 'ti ha menzionato in una risposta &quot;{comment}&quot;', 'mencionou voc&amp;ecirc; em uma resposta &quot;{comment}&quot;', 'упомянул@ вас в комментарии &quot;{comment}&quot;', 'te ha mencionado en una respuesta &quot;{comment}&quot;', 'bir cevapta sizden bahsetti &quot;{comment}&quot;'),
(544, 'also_replied', '', 'replied to the comment &quot;{comment}&quot;', 'رد على التعليق &quot;{comment}&quot;', 'antwoordde op de reactiefeed &quot;{comment}&quot;', 'répondu au commentaire &quot;{comment}&quot;', 'hat auf den Kommentar zurück kommentiert &quot;{comment}&quot;', 'risposto al commento &quot;{comment}&quot;', 'respondeu o coment&amp;aacute;rio &quot;{comment}&quot;', 'ответил@ на комментарий &quot;{comment}&quot;', 'respondió al comentario &quot;{comment}&quot;', 'yorumuna cevap verdi, &quot;{comment}&quot;'),
(545, 'liked_reply_comment', '', 'liked your reply &quot;{comment}&quot;', 'أعجب بردك &quot;{comment}&quot;', 'vond uw antwoord &quot;{comment}&quot;', 'aimé votre réponse &quot;{comment}&quot;', 'gefält deine Antwort &quot;{comment}&quot;', 'piaciuto vostra risposta &quot;{comment}&quot;', 'curtiu sua resposta &quot;{comment}&quot;', 'понравился ваш ответ &quot;{comment}&quot;', 'gustado su respuesta &quot;{comment}&quot;', 'Cevabınızı &quot;{comment}&quot; sevdi'),
(546, 'wondered_reply_comment', '', 'wondered your reply &quot;{comment}&quot;', 'تعجب بردك &quot;{comment}&quot;', 'afgevraagd uw antwoord &quot;{comment}&quot;', 'demandé votre réponse &quot;{comment}&quot;', 'wundert sich über deine Antwort &quot;{comment}&quot;', 'wondered la tua risposta &quot;{comment}&quot;', 'n&amp;atilde;o curtiu sua resposta &quot;{comment}&quot;', 'Не нравится ваш ответ &quot;{comment}&quot;', 'preguntó su respuesta &quot;{comment}&quot;', 'Cevabınızı &quot;{comment}&quot; merak'),
(547, 'disliked_reply_comment', '', 'disliked your reply &quot;{comment}&quot;', 'لم يعجب بردك &quot;{comment}&quot;', 'hekel aan uw antwoord &quot;{comment}&quot;', 'détesté votre réponse &quot;{comment}&quot;', 'gefällt deine Antwort &quot;{comment}&quot;', 'non amava la sua risposta &quot;{comment}&quot;', 'n&amp;atilde;o curtiu sua resposta &quot;{comment}&quot;', 'Не нравится ответ &quot;{comment}&quot;', 'no le gustaba su respuesta &quot;{comment}&quot;', 'Cevabınızı &quot;{comment}&quot; sevmiyordu'),
(548, 'profile_visit_notification_p', '', 'Send users a notification when i visit their profile?', 'إرسال المستخدمين إخطارا عندما أقوم بزيارة صفحته الشخصية؟', 'Stuur gebruikers een melding wanneer ik bezoek hun profiel?', 'Envoyer utilisateurs une notification lorsque je visite son profil?', 'Benutzern eine Benachrichtigung senden, wenn ich ihr Profil besucht habe?', 'Inviare agli utenti una notifica durante la mia visita il loro profilo?', 'Enviar notifica&amp;ccedil;&amp;atilde;o para usu&amp;uacute;rios quando visitar o perfil?', 'Отправлять пользователям уведомления, когда я посещаю их профили?', '¿Enviar a los usuarios aviso de visita?', 'Ben kendi profilini ziyaret ettiğinizde kullanıcılara bir bildirim gönder?'),
(549, 'showlastseen_help', '', 'if you don&#039;t share your last seen , you won&#039;t be able to see other people last seen.', 'اذا لم تشارك اخر ظهور لك , فانك لن تكون قادرا على رؤية اخر ظهور المستخدمين.', 'als je het niet eens met je voor het laatst gezien, zult u niet in staat zijn om andere mensen het laatst gezien.', 'si vous ne partagez pas votre dernière fois, vous ne serez pas en mesure de voir d&#39;autres personnes la dernière fois.', 'wenn du nicht teilen willst was du dir als letztes angesehen hast, kannst Du auch nicht sehen was andere sich angesehen haben.', 'se non si condivide il visto l&#039;ultima volta, non sarà in grado di vedere altre persone visto l&#039;ultima volta.', 'Se voc&amp;ecirc; N&amp;atilde;o compartilhar a &amp;uacute;ltima vez que voc&amp;ecirc; foi visto, voc&amp;ecirc; tamb&amp;eacute;m N&amp;atilde;o poder&amp;aacute; ver a ultima vez que os outros usu&amp;uacute;rios foram vistos.', 'Если отключить это уведомление, вы не сможете видеть последнее подключение других пользователей..', 'Si desactivas esta notificación tu tampoco podrás ver la conexión de otros usuarios.', 'Eğer son görüldüğü paylaşmak yoksa, son görüldüğü diğer insanları görmek mümkün olmayacaktır.'),
(550, 'timeline_birthday_label', '', 'Who can see my birthday?', 'من يمكنه رؤية تاريخ ميلادي؟', 'Wie kan mijn verjaardag zien?', 'Qui peut voir mon anniversaire?', 'Wer kann mein Geburtstag sehen?', 'Chi può vedere il mio compleanno?', 'Quem pode ver a data do meu anivers&amp;aacute;rio?', 'Кто может видеть мой день рождения?', '¿Quién puede ver mi cumpleaños?', 'Kim benim doğum günüm görebilir?'),
(551, 'people_likes_this', '', 'people like this', 'مستخدم معجبين بهذا', 'mensen vinden dit leuk', 'personnes aiment ce', '„Gefällt mir“ Angaben', 'persone piace questo', 'pessoas gostaram disso', 'Нравится', 'Me gusta', 'Bu gibi insanlar'),
(552, 'page_inviate_label', '', 'Invite friends to like this Page', 'إدعو أصدقائك للإجاب بهذه الصفحة', 'Vrienden uitnodigen om deze pagina graag', 'Inviter des amis à aimer cette page', 'Freunde einladen, denen diese Seite gefallen könnte', 'Invita gli amici a piacere questa Pagina', 'Convidar pessoas para curtir essa p&amp;aacute;gina', 'Пригласить друзей', 'Invitar amigos', 'Sayfaya sevmeye arkadaşlarınızı davet edin'),
(553, 'invite_your_frineds', '', 'Invite your friends/followers', 'إدعوا اصدقائك/متابعينك', 'Nodig je vrienden / volgelingen', 'Invitez vos amis / followers', 'Laden Sie Ihre Freunde / Follower', 'Invita i tuoi amici / seguaci', 'Convidar seus amigos/seguidores', 'Пригласить друзей', 'Invita a tus amigos / seguidores para ver si les gusta esto', 'Arkadaşların / takipçileri davet'),
(554, 'not_invite', '', 'You don&#039;t have any more friends to invite', 'لا يوجد المزيد للدعوة', 'U hoeft niet meer vrienden uitnodigen', 'Vous ne disposez pas d&#39;autres amis à inviter', 'Du hast keine weiteren Freunde eingeladen', 'On avete più amici per invitare', 'Voc&amp;ecirc; j&amp;aacute; convidou todos seus amigos', 'У Вас нет друзей, чтобы пригласить', 'No tienes más amigos que invitar...', 'Davet etmek artık arkadaş yok'),
(555, 'invite', '', 'Invite', 'إدعو', 'Nodigen', 'Invitez', 'Einladen', 'Invitare', 'Convidar', 'Пригласить', 'Invitación', 'Davet etmek'),
(556, 'invited_page', '', 'invited you to like ({page_name})', 'دعاك للاعجاب بل الصفحة ({page_name})', 'u uitgenodigd om te willen ({page_name})', 'vous invite à aimer ({page_name})', 'Ich möchte dich gerne zu ({page_name}) einladen', 'invitato a piacere ({page_name})', 'Convidou voc&amp;ecirc; para curtir ({page_name})', 'предлагает вам отметить страницу ({page_name}) как понравившуюся', 'te invito para ver si te gusta ({page_name})', 'Hoşunuza davet etti ({page_name})'),
(557, 'accepted_invited_page', '', 'accepted your request to like ({page_name})', 'قبل دعوتك للإجاب ب ({page_name})', 'aanvaard uw verzoek te willen ({page_name})', 'accepté votre demande d&#39;aimer ({page_name})', 'Deine Beitrittsanfrage für die Seite ({page_name}) wurde genehmigt', 'accettato la richiesta di piacere ({page_name})', 'aceitou sua solicita&amp;ccedil;&amp;atilde;o para curtir ({page_name})', 'принял@ ваше приглашение в ({page_name})', 'acepto tu invitación a ({page_name})', 'İsteğiniz sevmeye kabul edilir ({page_name})'),
(558, 'call_to_action', '', 'Call to action', 'Call to action', 'Oproep tot actie', 'Appel à l&#39;action', 'Was möchtest du tun?', 'Chiamare all&#039;azione', 'Ligar a&amp;ccedil;&amp;atilde;o', 'Призыв к действию', 'Llamar a la acción', 'Eylem çağrısı'),
(559, 'call_to_action_target', '', 'Call to target url', 'Call to target url', 'Bellen om url richten', 'Appel à l&#39;URL cible', 'Rufe das URL-Ziel auf', 'Chiama per indirizzare url', 'Ligar a uma URL definida', 'Введите URL сайта', 'Insertar url', 'Url hedef Çağrı'),
(560, 'call_action_type_url_invalid', '', 'Call to action website is invalid', 'Call to action website is invalid', 'Oproep tot actie website is ongeldig', 'Appel à l&#39;action est site de invalide', 'Es besteht Handlungsbedarf, Website ist ungültig', 'Chiama per il sito di azione non è valido', 'Website inv&amp;aacute;lido', 'Неправильный URL', 'Llamado a la página web de acción no es válido', 'Eylem web Çağrı geçersiz'),
(561, 'avatar_and_cover', '', 'Avatar &amp; Cover', 'الصورة الشخصية والغلاف', 'Avatar &amp; Cover', 'Avatar &amp; Cover', 'Profil- und Titelbild', 'Avatar &amp; Coprire', 'Avatar &amp; Capa', 'Аватар и обложка', 'Avatar y Fondo', 'Avatar &amp; Kapak'),
(562, 'online_sidebar_admin_label', '', 'Enable online users to show active users in sidebar.', 'مكن لإظهار المستخدمين النشطين في الشريط الجانبي.', 'Toelaten online gebruikers actieve gebruikers te laten zien in de zijbalk.', 'Permettre aux utilisateurs en ligne pour montrer aux utilisateurs actifs dans la barre latérale.', 'Aktivieren Internetuser zu aktiven Nutzern in Seitenleiste zeigen.', 'Abilita utenti per mostrare agli utenti attivi in sidebar.', 'Permitir que usu&amp;uacute;rios vizualizem os usu&amp;uacute;rios ativos na sidebar.', 'Включить онлайн-пользователей, показать активных пользователей в боковой панели.', 'Permita que los usuarios en línea para usuarios activos mostrar en la barra lateral.', 'Kenar çubuğundaki aktif kullanıcıya göstermek için çevrimiçi kullanıcıları etkinleştirin.'),
(563, 'not_active', '', 'Not active', 'غير فعال', 'Niet actief', 'Pas actif', 'Nicht aktiv', 'Non attivo', 'Não ativo', 'Не активен', 'No activo', 'Aktif değil'),
(564, 'females', '', 'Females', 'الإناث', 'Niet geactiveerd', 'Femmes', 'Frauen', 'Femmine', 'Mulheres', 'Женщины', 'Las hembras', 'Dişiler'),
(565, 'males', '', 'Males', 'الذكور', 'Mannetjes', 'Les mâles', 'Männlich', 'Maschi', 'Homens', 'Мужчины', 'Los machos', 'Erkekler'),
(566, 'dashboard', '', 'Dashboard', 'اللوحة الرئيسية', 'Dashboard', 'Tableau de bord', 'Übersicht', 'Cruscotto', 'Painel', 'Информационная панель', 'Tablero de instrumentos', 'Dashboard'),
(567, 'albums', '', 'Albums', 'الألبومات', 'Albums', 'Albums', 'Alben', 'Albums', '&amp;aacute;lbuns', 'Альбомы', 'Álbumes', 'Albümler'),
(568, 'name', '', 'Name', 'الإسم', 'Naam', 'Prénom', 'Name', 'Nome', 'Nome', 'Имя', 'Nombre', 'Isim'),
(569, 'players', '', 'Players', 'اللاعبين', 'Spelers', 'Des joueurs', 'Spieler', 'Giocatori', 'Jogadores', 'Игроки', 'Jugadores', 'Oyuncular'),
(570, 'add_new_game', '', 'Add New Game', 'إضافة لعبة جديدة', 'Voeg een nieuwe game', 'Ajouter un nouveau jeu', 'Neues Spiel hinzufügen', 'Aggiungi nuovo gioco', 'Adicionar um novo jogo', 'Добавить новую игру', 'Añadir Nuevo Juego', 'Yeni Oyun Ekle'),
(571, 'game_added', '', 'Game added', 'تم الإضافة بنجاح', 'Spel toegevoegd', 'jeu ajouté', 'Spiel hinzugefügt', 'Gioco aggiunto', 'Jogo adicionado', 'Игра добавлена', 'Juego añadió', 'Oyun eklendi'),
(572, 'url_not_supported_game', '', 'This url is not supported', 'هذا الرابط غير مدعوم', 'Deze url wordt niet ondersteund', 'Cet URL est pas pris en charge', 'Diese URL wird nicht unterstützt', 'Questo URL non è supportata', 'URL inv&amp;aacute;lida', 'Этот URL-адрес не поддерживается', 'Esta url no es compatible', 'Bu url desteklenmiyor'),
(573, 'please_add_a_game', '', 'Please add a game url', 'يرجى إضافة رابط لعبة', 'Voeg dan een spel url', 'S&#39;il vous plaît ajouter une url de jeu', 'Bitte füge ein Spiel hinzu', 'Si prega di aggiungere un URL di gioco', 'Please add a game url', 'Пожалуйста, добавьте игру URL', 'Por favor, añada una url juego', 'Bir oyun url ekleyin'),
(574, 'active_announcements', '', 'Active announcements', 'إعلانات نشطة', 'actieve aankondigingen', 'Annonces actives', 'Aktive Ankündigungen', 'Annunci attivi', 'Avisos ativos', 'Активные объявления', 'Anuncios activos', 'Aktif duyurular'),
(575, 'inactive_announcements', '', 'Inactive announcements', 'إعلانات غير نشطة', 'inactief aankondigingen', 'Annonces inactifs', 'Inaktive Ankündigungen', 'Annunci inattivi', 'Avisos in&amp;aacute;tivos', 'Неактивные объявления', 'Anuncios inactivos', 'Etkin olmayan duyurular'),
(576, 'ban', '', 'Ban', 'حظر', 'Ban', 'Ban', 'Verbot', 'Bandire', 'Ban', 'Запрет', 'Prohibición', 'Yasak'),
(577, 'new_email', '', 'New E-mail', 'رسالة جديدة', 'Nieuwe E-mail', 'Nouveau E-mail', 'Neue Email', 'Nuova Email', 'Novo e-mail', 'Новый E-mail', 'Nuevo Email', 'Yeni e-posta'),
(578, 'html_allowed', '', 'Html allowed', 'ال html مسموح', 'Html toegestaan', 'HTML autorisée', 'HTML erlaubt', 'Html permesso', 'HTML permitida', 'HTML разрешено', 'Html permitido', 'Html izin'),
(579, 'send_me_to_my_email', '', 'Send to my email', 'ارسل الى بريدي الالكتروني', 'Stuur naar mijn e-mail', 'Envoyer à mon e-mail', 'An meine Emailadresse senden', 'Invia alla mia email', 'Enviar para o meu email', 'Отправить на мою электронную почту', 'Enviar a mi correo electrónico', 'Benim e-posta gönder'),
(580, 'test_message', '', 'Test message', 'جرب الراسلة أولا', 'Test bericht', 'Message test', 'Testnachricht', 'Messaggio di testo', 'Mensagem teste', 'Тестовое сообщение', 'Mensaje de prueba', 'Deney mesajı'),
(581, 'joined_members', '', 'Joined Members', 'الأعضاء', 'Toegetreden leden', 'Membres Inscrit', 'Registrierte Mitglieder', 'Iscritto membri', 'Membros', 'Регистрация Пользователей', 'Miembros Antigüedad', 'Katılım Üyeler'),
(582, 'join_requests', '', 'Join Requests', 'طلبات الإنضمام', 'Join Verzoeken', 'Rejoignez Demandes', 'Registrierte Anfragen', 'Join Richieste', 'Pedidos para entrar', 'Регистрация запросов', 'Únete Solicitudes', 'İstekler katılın'),
(583, 'verified_pages', '', 'Verified Pages', 'الصفحاتالؤكدة', 'Verified Pages', 'Pages Vérifié', 'Verifizierte Seiten', 'Verificato Pagine', 'P&amp;aacute;ginas verificadas', 'Официальные страницы', 'Verificado Páginas', 'Doğrulanmış Sayfalar'),
(584, 'file_sharing_extenstions', '', 'File sharing extensions (separated with comma,)', 'ملحقات تبادل الملفات (مفصولة بفاصلة،)', 'Sharing bestandsextensies (gescheiden met een komma,)', '', 'Daten-Transfer-Erweiterungen (mit Komma getrennt,)', 'Estensioni di file sharing (separati da una virgola,)', 'Compartilhar arquivos (separados por uma v&amp;iacute;rgula,)', 'Расширения обмена файлов (через запятую,)', 'Extensiones de intercambio de archivos (separados con comas,)', 'Dosya paylaşımı uzantıları (virgül ile ayrılmış)'),
(585, 'word_cons', '', 'Words to be censored, separated by a comma (,)', 'كلمات البذيئة، مفصولة بفاصلة (،)', 'Woorden worden gecensureerd, gescheiden door een komma (,)', 'Partage de fichiers extensions (séparées par des virgules,)', 'Zensierte Worte mit einem Komma trennen, (,)', 'Parole da censurati, separati da una virgola (,)', 'Palavras censuradas, separadas por v&amp;iacute;rgula (,)', 'Слова подвергаться цензуре, разделенных запятыми (,)', 'Palabras para ser censurados, separados por una coma (,)', 'Kelimeler sansür edilmesi, virgülle ayrılmış (,)'),
(586, 'join', '', 'Join', 'أنضم', 'Toetreden', 'Joindre', 'Beitreten', 'Aderire', 'Entrar', 'Вступить', 'Unirse', 'Katılmak'),
(587, 'joined', '', 'Joined', 'منضم', 'Geregistreerd', 'Inscrit', 'Beigetreten', 'Iscritto', 'Entrou', 'Выйти', 'Unido', 'Katılım'),
(588, 'request', '', 'Request', 'اطلب', 'Verzoek', 'Demande', 'Anfordern', 'Richiesta', 'Solicitar', 'Запрос', 'Petición', 'İstek'),
(589, 'edit_comment', '', 'Edit comment', 'تحرير تعليق', 'Reactie bewerken', 'Modifier commentaire', 'Kommentar bearbeiten', 'Modifica commento', 'Editar coment&amp;aacute;rio', 'Редактировать комментарий', 'Editar comentario', 'Düzenleme Yorum'),
(590, 'last_play', '', 'Last Play:', 'آخر نشاط', 'Laatste Play:', 'Dernière lecture:', 'Letztes Spiel:', 'Ultimo Gioco:', '&amp;uacute;ltimo jogo:', 'Последняя игра:', 'Último juego:', 'Son Oyun:'),
(591, 'play', '', 'Play', 'العب', 'Spelen', 'Joue', 'Spielen', 'Giocare', 'Jogar', 'Играть', 'Jugar', 'Oyna'),
(592, 'confirm_request_group_privacy_label', '', 'Confirm request when someone joining this group ?', 'إرسال طلب عندما يقوم شخص بل الإنضمام لهذه المجموعة؟', 'Bevestigt aanvraag als iemand mee deze groep?', 'Confirmer la demande lorsque quelqu&#39;un se joindre à ce groupe?', 'Anfrage bestätigen, wenn jemand dieser Gruppe beitreten will?', 'Confermare richiesta quando qualcuno entrare in questo gruppo ?', 'Confirmar solicita&amp;ccedil;&amp;atilde;o quando algu&amp;eacute;m quiser fazer parte do grupo ?', 'Подтверждать запрос когда, кто-то хочет присоединиться к этой группе?', 'Confirmar pedido cuando alguien unirse a este grupo?', 'Birisi bu gruba katılmadan isteği onaylayın?'),
(593, 'who_can_see_group_posts', '', 'Who can see group&#039;s posts ?', 'Who can see group&#039;s posts ?', 'Wie kan groepen berichten zien?', 'Qui peut voir des groupes messages?', 'Wer kann Gruppenbeiträge sehen?', 'Chi può vedere gruppi di messaggi?', 'Quem pode ver os posts do grupo ?', 'Кто может видеть сообщения группы?', '¿Quién puede ver los mensajes de este grupo?', 'Kim grubun mesajları görebilirim?'),
(594, 'joined_users', '', 'Joined users', 'الأعشاء المنضمين', 'Geregistreerd gebruikers', 'Inscrit utilisateurs', 'Registriert Nutzer', 'Iscritto utenti', 'Usu&amp;uacute;rios', 'Вступившие пользователи', 'Usuarios Antigüedad', 'Katılım kullanıcılar'),
(595, 'living_in', '', 'Living in', 'يسكن في', 'Leven in', 'Vivre dans', 'Lebt in', 'Residente a', 'Morando em', 'Страна', 'Viviendo en', 'Yaşayan'),
(596, 'design', '', 'Design', 'تصميم', 'Design', 'Design', 'Design', 'Design', 'Design', 'дизайн', 'Desiño', 'Dizayn'),
(597, 'people_you_may_want_to_meet', '', 'People you may want to meet', 'Pأعضاء قد ترغل في لقائهم', 'Mensen die je misschien wilt ontmoeten', 'Les personnes que vous pouvez rencontrer', 'Vielleicht kennst du', 'La gente si consiglia di rispettare', 'Pessoas que voc&amp;ecirc; talvez conhe&amp;ccedil;a', 'Люди, которых вы можете знать', 'La gente es posible que desee conocer', 'İnsanlar karşılamak isteyebilirsiniz'),
(598, 'added_new_photos_to', '', 'added new photos to', 'أضاف صور جديدة الى', 'Toegevoegd nieuwe foto&#039;s aan', 'ajoutés nouvelles photos à', 'hat neue Fotos hinzugefügt', 'aggiunte nuove foto', 'adicionou novas fotos', 'Добавлены новые фотографии в', 'añadido nuevas fotos a', 'eklenen yeni fotoğraf'),
(599, 'is_feeling', '', 'is feeling', 'يشعر ب', 'is het gevoel', 'est le sentiment', 'ist', 'è la sensazione', 'se sentindo', 'это чувство', 'es la sensación', 'duygu olduğunu'),
(600, 'is_traveling', '', 'is traveling to', 'يسافر إلى', 'is reizen naar', 'se rend à', 'ist auf Reisen', 'è un viaggio in', 'viajando para', 'едет в', 'está viajando a', 'için seyahat ediyor'),
(601, 'is_listening', '', 'is listening to', 'يستمع إلى', 'luistert naar', 'écoute', 'hört zu', 'è l&#039;ascolto', 'ouvindo', 'слушает', 'está escuchando', 'dinliyor'),
(602, 'is_playing', '', 'is playing', 'يلعب ب', 'speelt', 'est en train de jouer', 'spielt', 'sta giocando', 'jogando', 'играет', 'está jugando', 'oynuyor'),
(603, 'is_watching', '', 'is watching', 'يشاهد', 'is aan het kijken', 'regarde', 'beobachtet', 'sta guardando', 'assistindo', 'смотрит', 'esta viendo', 'izliyor'),
(604, 'feeling', '', 'Feeling', 'يشعر', 'Gevoel', 'Sentiment', 'Gefühl', 'Sensazione', 'Sentindo', 'Настроение', 'Sensación', 'Duygu'),
(605, 'traveling', '', 'Traveling to', 'يسافر', 'Reizen naar', 'Voyager à', 'Reisen', 'In viaggio verso', 'Viajando para', 'Путешествую', 'Viajando a', 'Seyahat'),
(606, 'watching', '', 'Watching', 'يشاهد', 'Kijken', 'En train de regarder', 'Ansehen', 'Guardando', 'Assistindo', 'Смотрю', 'Acecho', 'İzlenen'),
(607, 'playing', '', 'Playing', 'يلعب', 'Spelen', 'En jouant', 'Spielend', 'Giocando', 'Jogando', 'Играю', 'Jugando', 'Oynama'),
(608, 'listening', '', 'Listening to', 'يستمع إلى', 'Luisteren naar', 'Écouter', 'Hören', 'Ascoltare', 'ouvindo', 'Слушаю', 'Escuchar', 'Dinliyorum'),
(609, 'feeling_q', '', 'What are you feeling ?', 'بماذا تعشر؟', 'Wat voel je ?', 'Que ressentez vous ?', 'Was fühlst du ?', 'Cosa senti ?', 'Como voc&amp;ecirc; esta se sentindo ?', 'Что чувствуете?', 'Que estás sintiendo ?', 'Ne hissediyorsun ?'),
(610, 'traveling_q', '', 'Where are you traveling ?', 'الى أين تسافر', 'Waar wilt u verblijven?', 'Où êtes-vous?', 'Wohin möchtest du reisen?', 'Dove si viaggia ?', 'Para onde esta viajando ?', 'Куда едите?', 'A donde viajas ?', 'Nereye seyahat?'),
(611, 'watching_q', '', 'What are you watching ?', 'ماذا تشاهد؟', 'Waar ben je naar aan het kijken ?', 'Qu&#39;est-ce que vous regardez ?', 'Was schaust Du ?', 'Cosa stai guardando ?', 'O que esta assistindo ?', 'Что смотришь?', 'Qué estás viendo ?', 'Ne izliyorsun ?'),
(612, 'playing_q', '', 'What are you Playing ?', 'ماذا تلعب؟', 'Wat ben je aan het spelen ?', 'A quoi tu joues ?', 'Was spielst du ?', 'A cosa stai giocando ?', 'O que esta jogando ?', 'Во что играешь?', '¿A qué juegas?', 'Ne oynuyorsun ?'),
(613, 'listening_q', '', 'What are you Listening to ?', 'إلى ماذا تستمع؟', 'Waar ben je naar aan het luisteren ?', 'Qu&#39;écoutes-tu ?', 'Was hörst du ?', 'Cosa stai ascoltando ?', 'O que esta ouvindo ?', 'Что слушаешь?', 'Qué estás escuchando ?', 'Ne dinliyorsun ?'),
(614, 'feel_d', '', 'What are you doing ?', 'ماذا تغعل؟', 'Wat ben je aan het doen ?', 'Qu&#39;est-ce que tu fais ?', 'Was machst Du?', 'Che stai facendo?', 'O que esta fazendo ?', 'Что делаете?', 'Que estas haciendo ?', 'Ne yapıyorsun ?'),
(615, 'studying_at', '', 'Studying at', 'يدرس في', 'Studeren aan', 'Etudier à', 'Studiert an', 'Studiare a', 'Estudando em', 'Образование', 'Estudiando en', 'Öğrenim'),
(616, 'company_website_invalid', '', 'Company website is invalid', 'موقع الشركة غير صالح', 'Website van het bedrijf is ongeldig', 'Site de la société est invalide', 'Unternehmens-Website ist ungültig', 'Sito internet della Società non è valido', 'Site da empresa inv&amp;aacute;lido', 'Веб-сайт компании является недействительным', 'Página web de la empresa no es válido', 'Şirket web sitesi geçersiz'),
(617, 'page_deleted', '', 'Page deleted successfully', 'الصفحة حذفت بنجاح', 'Pagina succesvol verwijderd', 'Page supprimée avec succès', 'Seite erfolgreich gelöscht', 'Pagina eliminato con successo', 'P&amp;aacute;gina deletada', 'Страница успешно удалена', 'Página eliminado correctamente', 'Sayfa başarıyla silindi'),
(618, 'cover_n_label', '', 'cover image.', 'صورة الغلاف.', 'Bedekken afbeelding.', 'Image de couverture.', 'Titelbild.', 'immagine di copertina.', 'Capa.', 'обложка.', 'Imagen de portada.', 'Kapak resmi.'),
(619, 'suggested_groups', '', 'Suggested groups', 'المجموعات المقترحة', 'Voorgestelde groepen', 'Groupes suggérés', 'Vorgeschlagene Gruppen', 'Gruppi suggeriti', 'Grupos sugeridos', 'Рекомендуемые группы', 'Grupos sugeridos', 'Önerilen gruplar'),
(620, 'accepted_join_request', '', 'accepted your request to join ({group_name})', 'قبل طلب للإنضمام الى ({group_name})', 'aanvaard uw verzoek om lid te worden ({group_name})', 'accepté votre demande d&#39;adhésion ({group_name})', 'Deine Beitrittsanfrage wurde akzeptiert ({group_name})', 'accettato tua richiesta di iscrizione ({group_name})', 'aceitou sua solicita&amp;ccedil;&amp;atilde;o para se juntar ao ({group_name})', 'Запрос принят на вступление в ({group_name})', 'aceptó su solicitud para unirse ({group_name})', 'İsteğiniz katılmak için kabul edilir ({group_name})'),
(621, 'requested_to_join_group', '', 'requested to join your group', 'طلب منك الإنضمام الى مجموعتك', 'verzocht om uw groep aan te sluiten', 'demandé à rejoindre votre groupe', 'lädt dich ein, dieser Gruppe beizutreten', 'richiesto di unirsi al vostro gruppo', 'pediu para entrar no seu grupo', 'хочет присоединиться к вашей группе', 'solicitado a unirse a su grupo', 'senin gruba katılmak istedi'),
(622, 'no_one_posted', '', 'No posts to show', 'لا يوجد اي منشور بعد', 'Maar niemand geplaatst', 'Personne encore posté', 'Doch niemand geschrieben', 'Nessuno ha scritto ancora', 'Nenhum post ainda', 'Еще ничего не опубликовано', 'Nadie ha escrito todavía', 'Henüz hiç kimse gönderildi'),
(623, 'add_your_frineds', '', 'Add your friends to this group', 'إضافة أصدقائك إلى هذه المجموعة', 'Voeg uw vrienden aan deze groep', 'Ajouter à vos amis de ce groupe', 'Füge deine Freunde zu dieser Gruppe hinzu', 'Aggiungi ai tuoi amici di questo gruppo', 'Adicionar amigos à este grupo', 'Добавить друзей в эту группу', 'Añadir amigos a este grupo', 'Bu gruba arkadaşlarınızı ekleyin'),
(624, 'added_all_friends', '', 'There are no friends to add them', 'لا يوجد أصدقاء للإضافة', 'Er zijn geen vrienden om ze toe te voegen', 'Il n&#39;y a aucun ami à les ajouter', 'Es gibt keine Freunde, um sie hinzuzufügen', 'Non ci sono amici da aggiungere loro', 'Nenhum amigo dispon&amp;iacute;vel para ser adicionado', 'Добавить всех друзей', 'No hay amigos para agregarlos', 'Eklemek için hiçbir arkadaş yok'),
(625, 'added_you_to_group', '', 'added you to the group ({group_name})', 'أضافك الى المجموعة ({group_name})', 'u hebt toegevoegd aan de groep ({group_name})', 'vous ajouté au groupe ({group_name})', 'hat dich zur Gruppe ({group_name}) hinzugefügt', 'ti ha aggiunto al gruppo ({group_name})', 'adicionado ao grupo ({group_name})', 'добавил@ вас в группу ({group_name})', 'te agrego al grupo ({group_name})', 'sizi grubuna ekledi ({group_name})'),
(626, 'group_type', '', 'Group type', 'نوع المجموعة', 'groepstype', 'Type de groupe', 'Gruppentyp', 'Tipo di gruppo', 'Estilo do Grupo', 'Тип группы', 'Tipo de grupo', 'Grup türü'),
(627, 'public', '', 'Public', 'عام', 'Openbaar', 'Public', 'Öffentlichkeit', 'Pubblico', 'P&amp;uacute;blico', 'Открытая группа', 'Público', 'Kamu'),
(628, 'private', '', 'Private', 'خاص', 'Private', 'Privé', 'Privat', 'Privato', 'Privado', 'Закрытая группа', 'Privado', 'Özel'),
(629, 'reports', '', 'Reports', 'الإبلاغات', 'Rapporten', 'Rapports', 'Meldungen', 'Rapporti', 'Reportes', 'Отчеты', 'Informes', 'Raporlar'),
(630, 'no_dislikes', '', 'No dislikes yet', 'لا يوجد غير معجبين', 'nog geen hekel', 'Pas encore aversions', 'Keiner dem das nicht gefällt', 'Non hai ancora un antipatie', 'Nenhum dislike ainda', 'Пока нет &quot;Не нравится&quot;', 'Sin embargo no le gusta', 'Henüz sevmeyen'),
(631, 'disliked', '', 'Disliked', 'غير معجب', 'Bevallen', 'N&#39;a pas aimé', 'unbeliebt', 'Malvisto', 'N&amp;atilde;o curtiu', 'Не нравится', 'No me gustó', 'Sevmediği'),
(632, 'wondered', '', 'Wondered', 'متعجب', 'Afgevraagd', 'Demandé', 'Verwundert', 'Si chiese', 'N&amp;atilde;o curtiu', 'Не нравится', 'Se preguntó', 'Merak eti'),
(633, 'terms', '', 'Terms Pages', 'صفحات الموقع', 'Algemene Pagina', 'Conditions Pages', 'Allgemeine Seiten', 'Condizioni Pagine', 'Termos', 'Правила и условия', 'Condiciones Páginas', 'Şartlar Sayfalar'),
(634, 'profile_privacy', '', 'User Profile Privacy', 'خصوصية الحساب الشخصي', 'User Profile Privacy', 'Profil de confidentialité', 'Benutzerprofil Datenschutz', 'Profilo Utente Privacy', 'Privacidade do perfil', 'Профиль конфиденциальности', 'Perfil de usuario de Privacidad', 'Kullanıcı Profili Gizlilik'),
(635, 'profile_privacy_info', '', 'Enable it to allow non logged users to view users profiles.', 'مكن هذه الميزة للسماح بعرض المستخدمين لغير المسجلين.', 'In staat stellen om niet-aangemelde gebruikers gebruikers profielen te bekijken.', 'Activer qu&#39;il permette non connecté aux utilisateurs de voir les profils des utilisateurs.', 'Aktivieren Sie es, damit nicht angemeldete Benutzer, um Benutzer Profile anzusehen.', 'Consentirle di consentire agli utenti non registrati di visualizzare profili utenti.', 'Permitir usu&amp;uacute;rios que N&amp;atilde;o est&amp;ccedil;o logados de ver os perfils.', 'Включите его, чтобы не являющихся зарегистрированные пользователи для просмотра профили пользователей.', 'Activar para permitir que los usuarios no iniciar sesión para ver los perfiles de los usuarios.', 'Olmayan açmış olan kullanıcılar profillerini görüntülemek için izin için etkinleştirin.'),
(636, 'video_upload', '', 'Video Upload', 'رفع الفيديو', 'Video uploaden', 'Video Upload', 'Video hochladen', 'Carica video', 'Carregar v&amp;iacute;deo', 'Видео Загрузить', 'Vídeo Subir', 'Video Yükleme'),
(637, 'video_upload_info', '', 'Enable video upload to share &amp; upload videos to the site.', 'مكن هذه الميزة  لتحميل وتبادل الفيديو على الموقع.', 'Enable video uploaden om te delen en video&#039;s uploaden naar de site.', 'Activer télécharger la vidéo pour partager et télécharger des vidéos sur le site.', 'Aktivieren Sie Video-Upload zu teilen und Videos auf der Website.', 'Abilita video upload per condividere e caricare i video al sito.', 'Carregar v&amp;iacute;deo e compartilhar ele no site.', 'Включить видео загрузки, чтобы разделить и загрузить видео на сайт.', 'Habilitar subida de vídeo para compartir y subir videos al sitio.', 'Paylaşmak ve siteye video yüklemek için video upload etkinleştirin.'),
(638, 'audio_upload', '', 'Audio Upload', 'رفع الموسيقى', 'Audio uploaden', 'Audio Upload', 'Audio hochladen', 'Audio Upload', 'Carregar audio', 'Аудио Загрузить', 'Audio Subir', 'Ses Yükleme'),
(639, 'audio_upload_info', '', 'Enable audio upload to share &amp; upload sounds to the site.', 'مكن هذه الميزة  لتحميل وتبادل الصوتيات على الموقع.', 'Enable audio uploaden om te delen en uploaden geluiden naar de site.', 'Activer audio upload pour partager et télécharger des sons sur le site.', 'Aktivieren Sie Audio-Upload zu teilen und Upload-Sounds auf der Website.', 'Abilita audio upload per condividere e caricare i suoni al sito.', 'Carregar audios e compartilhar no site.', 'Включить аудио загрузки, чтобы разделить и загрузки звучит на сайт.', 'Habilitar audio upload compartir y cargar suena al sitio.', 'Paylaşmak ses yükleme etkinleştirin ve upload sitesine geliyor.'),
(640, 'read_more', '', 'Read more', 'المزيد ..', 'Lees Meer..', 'En lire plus..', 'Weiterlesen', 'Leggi di più..', 'Ler mais', 'Показать полностью...', 'Lee mas..', 'Daha fazla..'),
(641, 'read_less', '', 'Read less', 'أخفاء ..', 'Lees Minder..', 'Lire moins..', 'Weniger lesen', 'Leggi meno..', 'Ler menos', 'Свернуть...', 'Cerrar..', 'Az Oku..'),
(642, 'add_photo', '', 'Add a photo.', 'أضِف صورة.', 'Voeg een foto toe.', 'Ajouter une photo.', 'Füge ein Bild hinzu.', 'Aggiungi una foto.', 'Adicionar foto.', 'Добавьте фотографию.', 'Añade una foto.', 'Bir fotoğraf ekle.'),
(643, 'add_photo_des', '', 'Show your unique personality and style.', 'أظهِر شخصيّتك وأسلوبك الفريد.', 'Voeg een foto toe.', 'Affichez votre personnalité et votre style uniques.', 'Zeige Deine einzigartige Persönlichkeit und Deinen Stil.', 'Mostra la tua personalità e il tuo stile.', 'Mostrar sua personalidade e estilo.', 'Продемонстрируйте свою индивидуальность и неповторимый стиль.', 'Muestra tu estilo y personalidad única.', 'Eşsiz karakterini ve tarzını yansıt.'),
(644, 'start_up_skip', '', 'Or Skip this step for now.', 'تخطّى هذه الخطوة الآن', 'Deze stap voor nu overslaan', 'Sauter cette étape pour le moment', 'Diesen Schritt vorerst überspringen', 'Salta questo passaggio per ora', 'Pular.', 'Пропустить этот шаг', 'Omitir este paso por ahora', 'Bu adımı şimdilik atla'),
(645, 'start_up_continue', '', 'Save &amp; Continue', 'المتابعة', 'Opslaan &amp; Doorgaan', 'Enregistrer &amp; Continuer', 'Speichern und weiter', 'Salva e continua', 'Salvar e continuar', 'Сохранить &amp; Продолжить', 'Guardar y Continuar', 'Kaydet ve Devam Et'),
(646, 'tell_us', '', 'Tell us about you.', 'أخبرنا عنك.', 'Vertel ons over jou.', 'Parlez-nous de vous.', 'Erzählen Sie uns von Ihnen.', 'Parlaci di te.', 'Fale sobre voc&amp;ecirc;.', 'Расскажите о себе.', 'Cuéntanos acerca de ti.', 'Senin hakkında bilgi verin.'),
(647, 'tell_us_des', '', 'Share your information with our community.', 'تبادل المعلومات الخاصة بك مع مجتمعنا.', 'Deel je informatie met onze gemeenschap.', 'Partager vos informations avec notre communauté.', 'Ihre Daten an unsere Community.', 'Condividere le informazioni con la nostra comunità.', 'Compartilhe informa&amp;ccedil;&amp;otilde;es.', 'Поделитесь информацией с нашим сообществом.', 'Comparta su información con nuestra comunidad.', 'Eden ile bilgilerinizi paylaşın.'),
(648, 'get_latest_activity', '', 'Get latest activities from our popular users.', 'الحصول على أحدث الأنشطة من أكثر المستخدمين شعبية لدينا.', 'Ontvang de meest recente activiteiten van onze populaire gebruikers.', 'Obtenir les dernières activités de nos utilisateurs populaires.', 'Holen Sie sich aktuelle Aktivitäten aus unserer beliebten Nutzer.', 'Ottenere ultime attività dei nostri utenti popolari.', 'Veja novas informa&amp;ccedil;&amp;otilde;es dos usu&amp;uacute;rios mais populares.', 'Следите за последними действиями популярных пользователей.', 'Obtener las últimas actividades de los usuarios populares.', 'Bizim popüler kullanıcılardan son faaliyetleri alın.'),
(649, 'follow_head', '', 'Follow our famous users.', 'تابع أشهر المستخدمين.', 'Volg onze beroemde gebruikers.', 'Suivez nos utilisateurs célèbres.', 'Folgen Sie unseren berühmten Nutzer.', 'Segui i nostri utenti famosi.', 'Siga os usu&amp;uacute;rios famosos.', 'Следуйте за нашими знаменитыми пользователями.', 'Siga nuestros usuarios más populares.', 'Bizim ünlü kullanıcıları izleyin.'),
(650, 'follow_num', '', 'Follow {number} &amp; Finish', 'تابع {number} وإستمر', 'Volg {number} &amp; Finish', 'Suivez {number} &amp; Terminer', 'Folgen Sie {number} &amp; Finish', 'Seguire {number} &amp; Finitura', 'Seguir {number} &amp; terminar', 'Следовать за {number}', 'Siga {number} y Finalizar', '{number} Takip et ve bit'),
(651, 'looks_good', '', 'Looks good.', 'يبدو جيّدًا.', 'Ziet er goed uit.', 'Ça a l&#39;air bien.', 'Sieht gut aus.', 'Sembra buono.', 'Parece legal.', 'Неплохо.', 'Se ve bien.', 'İyi görünüyor.'),
(652, 'looks_good_des', '', 'You&#039;ll be able to add more to your profile later.', 'ستكون قادرًا على إضافة المزيد لملفك الشخصيّ لاحقًا.', 'Je kunt later meer toevoegen aan je profiel.', 'Vous serez en mesure de compléter votre profil ultérieurement.', 'Du wirst später mehr zu Deinem Profil hinzufügen können.', 'Più tardi potrai aggiungere altro al tuo profilo.', 'Voc&amp;ecirc; poder&amp;aacute; adicionar mais em seu perfil depois.', 'Вы сможете добавить другую информацию в свой профиль позже.', 'Podrás añadir más a tu perfil después.', 'Daha sonra profiline yeni şeyler ekleyebilirsin.'),
(653, 'upload_your_photo', '', 'Upload your photo', 'إرفع صورتك', 'Upload je foto', 'Téléchargez votre photo', 'Lade Dein Bild hoch', 'Carica la tua foto', 'Carregar foto', 'Загрузите вашу фотографию', 'Sube tu foto', 'Fotoğrafını yükle'),
(654, 'please_wait', '', 'Please wait..', 'الرجاء الإنتظار..', 'Even geduld aub..', 'S&#39;il vous plaît, attendez..', 'Warten Sie mal..', 'Attendere prego..', 'Aguarde..', 'Пожалуйста подождите..', 'Por favor espera..', 'Lütfen bekleyin..'),
(655, 'username_or_email', '', 'Username or E-mail', 'اسم المستخدم أو البريد الإلكتروني', 'Gebruikersnaam of E-mail', 'Nom d&#39;utilisateur ou email', 'Benutzername oder E-Mail-Adresse', 'Nome utente o E-mail', 'Nome de usuário ou E-mail', 'Никнейм или E-mail адрес', 'Usuario o correo electrónico', 'Kullanıcı adı ya da email'),
(656, 'email_setting', '', 'E-mail Setting', 'إعداد البريد الإلكتروني', 'E-mail instellen', 'E-mail Réglage', 'E-Mail Einstellung', 'E-mail Impostazione', 'Configuração de E-mail', 'Электронная почта Настройка', 'Ajuste de Correo', 'E-posta Ayarı'),
(657, 'years_old', '', 'years old', 'سنوات', 'jaar oud', 'ans', 'Jahre alt', 'Anni', 'anos', 'лет', 'años', 'yaşında'),
(658, 'friends_birthdays', '', 'Friends Birthdays', 'اعياد ميلاد الاصدقاء', 'Verjaardagen van vrienden', 'Annivarsaire d&#39;amis', 'Geburtstage von Freunden', 'amici Compleanni', 'Aniversários de Amigos', 'Друзья Дни рождения', 'Cumpleaños de amigos', 'Arkadaşlarının Doğumgünü'),
(659, 'sms_setting', '', 'SMS Setting', 'اعدادات الرسائل القصيرة', 'SMS Instellingen', 'Paramètres SMS', 'SMS Einstellungen', 'Impostazione SMS', 'Configuração de SMS', 'SMS Настройка', 'Configuración SMS', 'SMS Ayarları'),
(660, 'smooth_loading', '', 'Smooth Loading', 'تحمبل سلس', 'Gelijdelijk laden', 'Chargement régulier', 'Schnelles Laden', 'Smooth Caricamento', 'Carregamento Suave', 'Гладкая загрузка', 'Cargando', 'Düzgün Yükleme'),
(661, 'boosted_pages_viewable', '', 'Boosted pages are already viewable by all our community members.', 'الصفحات المعززة يتم مشاهدتها من قبل جميع افراد المجتمع', 'Omhoog geplaatste pagina&#039;s zijn al zichtbaar voor leden.', 'Les pages boostées sont déjà visibles par tous les membres de votre communauté', 'Hervorgehobene Seiten sind sofort für alle Mitglieder der Community Sichtbar.', 'pagine potenziato sono già visualizzabili da tutti i membri della community.', 'Páginas impulsionadas já estão visíveis por todos os membros da nossa comunidade.', 'Усиленные страницы уже доступны для просмотра всеми нашими членами сообщества.', 'Tus paginas promocionadas seran vistas en toda la comunidad.', 'Yükseltilen sayfalar tüm kullanıcılarımız tarafından görüntülenebilir.'),
(662, 'boost_page_in_same_time', '', 'You&#039;re a {type_name}, You&#039;re just able to boost {can_boost} pages at the same time.', 'صفحة في نفس الوقت{can_boost}بامكانك فقط تسريع ,{type_name} انت', 'Je bent {type_name}, Je kan nu  {can_boost} omhoog plaatsen.', 'Vous êtes un {type_name}, vous pouvez booster {can_boost} pages en même temps.', 'Du nutzt einen {type_name} Account, Du kannst nicht {can_boost} Seiten zur selben Zeit hervorheben.', 'Sei un {type_name}, Sei solo in grado di aumentare {can_boost} pagine in tempo stesso.', 'Você é um {type_name}, Vocêé apenas capaz de impulsionar {pode_impulsionar} páginas ao mesmo tempo.', 'Ты {type_name}, Вы просто в состоянии повысить {can_boost} может увеличить страницы в то же самое время.', 'Tu {type_name}, solo puedes promocionar {can_boost} paginas al mismo tiempo.', 'Sen bir {type_name}, aynı zamanda {can_boost} sadece sayfaları yükseltebilirsin.'),
(663, 'boost_posts_in_same_time', '', 'You&#039;re a {type_name}, You&#039;re just able to boost {can_boost} posts at the same time.', 'صفحة في نفس الوقت{can_boost}بامكانك فقط تسريع ,{type_name} انت', 'Je bent {type_name}, Je kan nu {can_boost} berichten omhoog plaatsen.', 'You&#39;re a {type_name}, vous pouvez booster {can_boost} posts en même temps.', 'Du nutzt einen {type_name} Account, Du kannst nicht  {can_boost} Beiträge zur selben Zeit hervorheben.', 'Sei un {type_name}, Sei solo in grado di aumentare {can_boost} messaggi in tempo stesso.', 'Você é um {type_name}, Vocêé apenas capaz de impulsionar {pode_impulsionar} postagens ao mesmo tempo.', 'Ты {type_name}, Вы просто в состоянии повысить {can_boost} может увеличить посты в то же самое время.', 'Tu {type_name}, solo puedes promocionar {can_boost} posts al mismo tiempo.', 'Sen bir {type_name}, aynı zamanda {can_boost} sadece mesajları yükseltebilirsin.'),
(664, 'there_are_no_boosted_pages', '', 'There are no boosted pages yet.', 'لا يوجد صفحات معززة الان', 'Er zijn geen omhoog geplaatste pagina&#039;s.', 'Il n&#39;y a pas encore de pages boostées.', 'Es gibt zu Zeit keine hervorgehobenen Seiten.', 'Non ci sono ancora pagine potenziati.', 'Não há páginas impulsionadas ainda.', 'Там нет Boosted страниц пока.', 'No hay paginas promocionados aún.', 'Henüz yükseltilmiş sayfa bulunmuyor.'),
(665, 'there_are_no_boosted_posts', '', 'There are no boosted posts yet.', 'لا يوجد صفحات معززة الان', 'Er zijn geen omhoog geplaatste berichten.', 'Il n&#39;y a pas encore de posts boostés.', 'Es gibt zur Zeit noch keine hervorgehobenen Beiträge.', 'Non ci sono ancora messaggi potenziati.', 'Não há postagens impulsionadas ainda.', 'Там нет Boosted сообщений пока.', 'No hay post promocionados aún.', 'Henüz yükseltilmiş mesaj bulunmuyor.'),
(666, 'discover_pro_types', '', 'Discover more features with {sitename} PRO packages !', 'اكتشاف المزيد للمحترفين من الميزات مع حزم {sitename}', 'Ontdek meer opties met {sitename} PRO!', 'Découvrez plus de fonctionnalités avec {sitename} PRO !', 'Entdecke mehr Funktionen mit dem {sitename} Pro-Paket !', 'Scopri di più caratteristiche con WoWonder pacchetti PRO !', 'Descubra mais recursos com WoWonder PRO packages !', 'Откройте для себя больше возможностей с WoWonder пакетами PRO !', 'Descubre mas {sitename} funciones con los nuevos paquetes!', '{sitename} PRO paketleri ile daha fazla özellik keşfedin !'),
(667, 'star', '', 'Star', 'برونزي', 'Ster', 'Etoile', 'Star', 'Star', 'Estrela', 'Star', 'Star', 'Yıldız'),
(668, 'hot', '', 'Hot', 'فضي', 'Heet', 'Hot', 'Hot', 'Hot', 'Quente', 'Hot', 'Hot', 'Sıcak'),
(669, 'ultima', '', 'Ultima', 'ذهبي', 'Ultimate', 'Ultima', 'Ultima', 'Ultima', 'Ultima', 'Ultima', 'Ultima', 'Ultima'),
(670, 'vip', '', 'Vip', 'ماسي', 'VIP', 'Vip', 'Vip', 'Vip', 'Vip', 'Vip', 'Vip', 'Vip'),
(671, 'featured_member', '', 'Featured member', 'عضو متميز', 'Aanbevolen lid', 'Membres en vedette', 'Besonderes Mitglied', 'membro In primo piano', 'Membro em destaque', 'Показанный член', 'Miembros destacados', 'Önerilen üye'),
(672, 'see_profile_visitors', '', 'See profile visitors', 'رأيت صفحات الشخصية للزوار', 'Bekijk profiel bezoekers', 'Voir le profil des visiteurs', 'Sehe wer dein Profil besucht hat', 'Vedi visitatori profilo', 'Veja os perfis de visitantes', 'См посетителей профиля', 'Ver visitantes en su perfil', 'Profil ziyaretçilerini gör'),
(673, 'show_hide_lastseen', '', 'Show / Hide last seen', 'اظهار/إخفاء أخر ظهور', 'Verberg laatst gezien', 'Voir / Cacher la dernière fois vu', 'Anzeigen oder Verstecke zuletzt gesehen', 'Mostra / Nascondi visto l&#039;ultima volta', 'Mostra / Esconder visto por último', 'Показать / Скрыть последний раз видели', 'Ver / Ocultar ultimas visitas', 'Son görünmeyi Göster / Gizle'),
(674, 'verified_badge', '', 'Verified badge', 'شارة التحقق', 'Vericatie Badge', 'Badge Vérifié', 'Verifiziert Abzeichen', 'distintivo verificato', 'Crachá verificado', 'Проверенные значок', 'Cuenta Verificada', 'Onaylanmış rozet'),
(675, 'post_promotion_star', '', 'Posts promotion&lt;br&gt;', 'نشر تريج&lt;br&gt;&lt;small&gt;(غير متاح)&lt;/small&gt;', 'Bericht promotie&lt;br&gt;&lt;small&gt;(Niet beschikbaar)&lt;/small&gt;', 'Promotion de post&lt;br&gt;&lt;small&gt;(Indisponible)&lt;/small&gt;', 'Beitrags Promotion&lt;br&gt;&lt;small&gt;(Nicht verfügbar)&lt;/small&gt;', 'la promozione Messaggio&lt;br&gt;&lt;small&gt;(Non disponibile)&lt;/small&gt;', 'Pós promoção&lt;br&gt;&lt;small&gt;(Não disponível)&lt;/small&gt;', 'продвижение сообщение&lt;br&gt;&lt;small&gt;(Недоступен)&lt;/small&gt;', 'Promocionar publicación&lt;br&gt;&lt;small&gt;(No Disponible)&lt;/small&gt;', 'Mesaj tanıtımı&lt;br&gt;&lt;small&gt;(Mevcut değil)&lt;/small&gt;'),
(676, 'page_promotion_star', '', 'Pages promotion&lt;br&gt;', 'صفحة الترويج&lt;br&gt;&lt;small&gt;(غير متاحة)&lt;/small&gt;', 'Pagina promotie&lt;br&gt;&lt;small&gt;(Niet beschkbaar)&lt;/small&gt;', 'Promotion de page&lt;br&gt;&lt;small&gt;(Indisponible)&lt;/small&gt;', 'Seiten Promotion&lt;br&gt;&lt;small&gt;(Nicht verfügbar)&lt;/small&gt;', 'promozione pagina&lt;br&gt;&lt;small&gt;(Non disponibile)&lt;/small&gt;', 'Pré promoção&lt;br&gt;&lt;small&gt;(Não disponível)&lt;/small&gt;', 'продвижение Page&lt;br&gt;&lt;small&gt;(Недоступен)&lt;/small&gt;', 'Promocionar pagina&lt;br&gt;&lt;small&gt;(No Disponible)&lt;/small&gt;', 'Sayfa tanıtımı&lt;br&gt;&lt;small&gt;(Mevcut değil)&lt;/small&gt;'),
(677, '0_discount', '', '0% discount', '0% تخفيض', '0% korting', '0% de réduction', '0% Nachlass', '0% sconto', '0% de desconto', '0% скидка', '0% descuento', '0% indirim'),
(678, '10_discount', '', '10% discount', '10% تخفيض', '10% korting', '10% de réduction', '10% Nachlass', '10% sconto', '10% de desconto', '10% скидка', '10% descuento', '10% indirim'),
(679, '20_discount', '', '20% discount', '20% تخفيض', '20% korting', '20% de réduction', '20% Nachlass', '20% dsconto', '20% de desconto', '20% скидка', '20% descuento', '20% indirim'),
(680, '60_discount', '', '60% discount', '60% تخفيض', '60% korting', '60% de réduction', '60% Nachlass', '60% sconto', '60% de desconto', '60% скидка', '60% descuento', '60% indirim'),
(681, 'per_week', 'Per Week', 'Per Week', 'في الاسبوع', 'Per week', 'Par semaine', 'Pro Woche', 'A settimana', 'Por semana', 'В неделю', 'Por semana', 'Haftada'),
(682, 'per_month', 'Per Month', 'Per Month', 'كل شهر', 'Per maand', 'Par mois', 'Pro Monat', 'Al mese', 'Por mês', 'В месяц', 'Por mes', 'Her ay'),
(683, 'per_year', 'Per Year', 'Per Year', 'كل سنة', 'Per jaar', 'Par an', 'Pro Jahr', 'Per anno', 'Por ano', 'В год', 'Por año', 'Yıl başına'),
(684, 'life_time', '', 'life time', 'مدى الحياة', 'levens lang', 'à vie', 'Lebenslang', 'tutta la vita', 'tempo de vida', 'продолжительность жизни', 'de por vida', 'ömür boyu'),
(685, 'upgrade_now', '', 'Upgrade Now', 'ترقية الان', 'Upgrade Nu', 'Mise à jour maintenant', 'Jetzt Upgraden', 'Aggiorna ora', 'Atualize Agora', 'Обнови сейчас', 'Actualiza ahora', 'Hemen Yükselt'),
(686, 'boosted_posts', '', 'Boosted Posts', 'المشاركات المعززت', 'Omhoog geplaatse berichten', 'Posts boostés', 'hervorgehobene Beiträge', 'Messaggi potenziato', 'Postagens Impulsionadas', 'Усиленные Сообщений', 'Promocionar Posts', 'yükseltılan Mesajlar'),
(687, 'boosted_pages', '', 'Boosted Pages', 'الصفحات المعززت', 'Omhoog geplaatsen pagina&#039;s', 'Pages boostées', 'hervorgehobene Seiten', 'Pagine potenziato', 'Páginas Impulsionadas', 'Усиленные Страницы', 'Promocionar Paginas', 'yükseltılan Sayfalar'),
(688, 'put_me_here', '', 'Put Me Here', 'ضعني هنا', 'Zet mij hier nier', 'Me mettre ici', 'Setze mich Hier', 'Mettimi qui', 'Me Coloque Aqui', 'Put Me Здесь', 'Poner aqui', 'buraya koy'),
(689, 'promoted', '', 'Promoted', 'معزز', 'Advertenties', 'Promoted', 'Promotions', 'Promossa', 'Promovido', 'Повышен', 'Promocionar', 'Tanıtılan'),
(690, 'oops_something_went_wrong', '', 'Oops ! Something went wrong.', 'Oops ! حدث خطأ ما', 'Oeps ! Er ging iets mis.', 'Oops ! Quelquechose s&#39;est mal passé.', 'Oops ! Irgendetwas ist schief gegangen.', 'Oops! Qualcosa è andato storto.', 'Oops! Algo deu errado.', 'К сожалению! Что-то пошло не так.', 'Oops ! Algo salio mal.', 'Hata ! Bir şeyler yanlış gitti.'),
(691, 'try_again', '', 'Try again', 'حاول مجددا', 'Probeer het opnieuw', 'Essayez encore', 'Versuche es erneut', 'Riprova', 'Tente novamente', 'Попробуй еще раз', 'Trata de nuevo', 'Tekrar deneyin'),
(692, 'boost_page', '', 'Boost Page', 'اضافة صفحة', 'Plaats pagina omhoog', 'Booster Page', 'Seite hervorheben', 'Boost Pagina', 'Página Impulsionada', 'Повышение Page', 'Promocionar Pagina', 'Sayfa yükselt'),
(693, 'page_boosted', '', 'Page Boosted', 'الصفحة المعززة', 'Pagina omhoog geplaatst', 'Page Boostée', 'Die Seite wurde hervorgehoben', 'pagina potenziato', 'Página Impulsionada', 'Страница Boosted', 'Pagina promocionada', 'yükseltılan Sayfa'),
(694, 'un_boost_page', '', 'Un-Boost Page', 'الصفحة الغير معززة', 'Verwijder omhoog plaatsing', 'Un-Boost Page', 'Seite nicht mehr hervorheben', 'Un-Boost Pagina', 'Desimpulsionar Página', 'Un-наддув Page', 'Des-promover pagina', 'Sayfayı yükseltma'),
(695, 'edit_page_settings', '', 'Edit Page Settings', 'تعديل إعدادات الصفحة', 'Verander pagina instellingen', 'Editer paramètres de la Page', 'Seiten Einstellungen bearbeiten', 'Modifica impostazioni pagina', 'Editar as configurações de página', 'Изменить настройки страницы', 'Editar ajustes de página', 'Sayfa Ayarlarını Düzenle'),
(696, 'blocked_users', '', 'Blocked Users', 'المستخدمين المحظورين', 'Geblokkerde Gebruikers', 'Utilisateurs bloqués', 'Blockierte Mitglieder', 'Gli utenti bloccati', 'Usuários Bloqueados', 'Заблокированные пользователи', 'Blockear usuario', 'Bloklu Kullanıcılar'),
(697, 'un_block', '', 'Un-Block', 'غير محضور', 'Deblokkeer', 'Débloquer', 'Blockierung aufheben', 'Sbloccare', 'Desbloquear', 'открыть', 'Des-blockear', 'Blok yükselt'),
(698, 'css_file', '', 'CSS file', 'CSS ملف', 'CSS bestand', 'fichier CSS', 'CSS Datei', 'file CSS', 'arquivo CSS', 'файл CSS', 'Archivo CCS', 'CSS dosyası'),
(699, 'css_status_default', '', 'Default design', 'التصميم الاولي', 'Standaard design', 'Design par défaut', 'Standart Design', 'disegno predefinito', 'Design padrão', 'дизайн По умолчанию', 'diseño por defecto', 'Varsayılan dizayn'),
(700, 'css_status_my', '', 'My CSS file', 'الخاص بي CSS ملف', 'Mijn CSS bestand', 'Mon fichier CSS', 'Meine CSS Datei', 'Il mio file CSS', 'Meu arquivo CSS', 'Мой файл CSS', 'Mi CSS', 'CSS dosyam');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(701, 'css_file_info', '', 'You can fully design your profile by uploading your own CSS file', 'CSS الخاص بك يمكنك تصميم كامل ملف التعريف الخاص بك عن طريق تحميل ملف', 'Je kan je profiel helemaal pimpen door je eigen CSS bestand te uploaden', 'Vous pouvez modifier le design de votre profil via le téléversement de votre propre fichier CSS', 'Du kannst dein Profil komplett selbst Designen in dem du deine CSS Datei hoch lädst', 'È possibile progettare completamente il proprio profilo caricando il proprio file CSS', 'Você pode projetar totalmente o seu perfil através de upload do seu próprio arquivo CSS', 'Вы можете полностью создать свой профиль, загрузив свой собственный файл CSS', 'Ahora puedes rediseñar tu perfil con tu propio estilo (Css)', 'Kendi Css dosyanızı yükleyerek profilinizi tamamen siz tasarlayabilirsiniz.'),
(702, 'invite_your_frineds_home', '', 'Invite Your Friends', 'دعوة اصدقائك', 'Nodig je vrienden uit', 'Inviter vos amis', 'Lade deine Freunde ein', 'Invita i tuoi amici', 'Convidar Seus Amigos', 'Пригласить друзей', 'Invita a tus amigos', 'Arkadaşlarını Davet Et'),
(703, 'send_invitation', '', 'Send Invitation', 'إرسال الدعوة', 'Verstuur', 'Envoyer Invitation', 'Einladung Versenden', 'Spedire un invito', 'Enviar Convite', 'Выслать пригласительное', 'Enviar invitación', 'Davetiye gönder'),
(704, 'boost_post', '', 'Boost Post', 'تعزيز المنشور', 'Plaast bericht omhoog', 'Boost Post', 'Beitrag Hervorheben', 'Boost Messaggio', 'Impulsionar Postagem', 'Повысьте Post', 'Promocionar post', 'Boost Post'),
(705, 'unboost_post', '', 'UnBoost Post', 'عدم تعزيز المنشور', 'Verwijder', 'Un-Boost Post', 'Beitrag nicht mehr Hervorheben', 'UnBoost Messaggio', 'Desimpulsionar Postagem', 'UnBoost сообщение', 'Des-promocionar post', 'Un-Boost Post'),
(706, 'drag_to_re', '', 'Drag to reposition cover', 'اسحب لتعديل الصورة', 'Sleep naar de juiste positie', 'Faites glisser pour repositionner la couverture', 'Ziehe das Cover mit der Maus um es neu zu Positionieren', 'Trascinare per riposizionare la copertura', 'Arraste para reposicionar a cobertura', 'Перетащите, чтобы изменить положение крышки', 'Arrastra la portada para recortarla', 'Kapağı yeniden konumlandırmak için sürükleyin'),
(707, 'block_user', '', 'Block User', 'حضر المستخدم', 'Blokkeer gebruiker', 'Bloquer l&#39;utilisateur', 'Mitglied Blocken', 'Blocca utente', 'Bloquear Usuário', 'Заблокировать пользователя', 'Blockear usuario', 'Kullanıcı Blok'),
(708, 'edit_user', '', 'Edit User', 'تعديل حساب العضو', 'Wijzig gebruiker', 'Editer Utilisateur', 'Mitglied Bearbeiten', 'Modifica utente', 'Editar Usuário', 'Изменить пользователя', 'Editar usuario', 'Kullanıcıyı Düzenle'),
(709, 'cong', '', 'Congratulations ! You&#039;re now a &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'مبروك! انت الان &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Gefeliciteerd ! Je bent nu een &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Félicitation ! Vous êtes maintenant un &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Herzlichen Glückwunsch! Du bist nun ein &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Complimenti ! Ora sei un &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Parabéns ! Você é agora um &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Поздравления ! Ты теперь &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Felicidades! Ahora &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}', 'Tebrikler ! Artık sen bir &lt;span style=&quot;color:{color}&quot;&gt;&lt;i class=&quot;fa fa-{icon} fa-fw&quot;&gt;&lt;/i&gt;{type_name}'),
(710, 'cong_2', '', 'Start browsing the new features', 'بدء تصفح الميزات الجديدة', 'Bekijk nu je nieuwe opties', 'Commencer à naviguer sur les nouvelles fonctionnalités', 'Beginne dir die neuen Funktionen anzusehen', 'Avviare la navigazione le nuove funzionalità', 'Começe a navegar os novos recursos', 'Начать просмотр новых функций', 'Comiencza a utilizar las nuevas funciones', 'Yeni özellikleri taramaya başlayın'),
(711, 'activation_oops', '', 'Oops, looks like your account is not activated yet.', 'Oops, .يبدو انه لم يتم تنشيط حسابك بعد', 'Oeps, het lijkt er op of je account nog niet is geactiveerd.', 'Oops, votre compte n&#39;est pas encore activé.', 'Oops, so wie es aussieht wurde dein Account Nachbericht aktiviert.', 'Spiacenti, sembra che il tuo account non è ancora attivato.', 'Oops, parece que sua conta não está ativada ainda.', 'К сожалению, похоже, ваша учетная запись еще не активирована.', 'Oops, Parece que su cuenta no está activada aún.', 'Hata, hesabınız henüz aktif edilmemiş gibi görünüyor.'),
(712, 'activation_method', '', 'Please choose a method below to activate your account.', '.يرجى اختيار طريقة لتفعيل حسابك أدناه', 'Selecteer een optie om je account te activeren.', 'Merci de choisir une méthode ci*dessous pour activer votre compte.', 'Bitte suche dir eine unten stehende Methode aus um dein Account zu aktivieren.', 'Si prega di scegliere un metodo seguito per attivare il tuo account.', 'Por favor escolha um método abaixo para ativar sua conta.', 'Пожалуйста, выберите метод ниже, чтобы активировать учетную запись.', 'Por favor trata con otro metodo para activar tu cuenta.', 'Hesabınızı etkinleştirmek için aşağıda ki yöntemlerden birini seçiniz.'),
(713, 'activation_email', '', 'Via E-mail', 'عن طريق البريد', 'Via E-mail', 'Par E-mail', 'Via E-mail', 'Via posta elettronica', 'Via E-mail', 'По электронной почте', 'Via E-mail', 'E-mail ile'),
(714, 'activation_phone', '', 'Via Phone Number', 'عن طريق الهاتف', 'Via Telefoonnummer', 'Par téléphone', 'Via Telefonnummer', 'Via Numero di telefono', 'Via Número de Telefone', 'Via номеру телефона', 'Via SMS', 'Telefon Numarası ile'),
(715, 'activation_or', '', 'Or', 'أو', 'Of', 'Ou', 'Oder', 'O', 'Ou', 'Или', 'O', 'yada'),
(716, 'activation_send_code', '', 'Send Confirmation Code', 'إرسال رمز التأكيد', 'Stuur activatie code', 'Envoyer le code confirmation', 'Sende uns deinen Bestätigungs Code Manuell', 'Invia codice di conferma', 'Enviar Confirmação do Código', 'Отправить код подтверждения', 'Enviar código de activación', 'Onay Kodu Gönder'),
(717, 'activation_get_code_again', '', 'Didn&#039;t get the code?', 'لم يتم استقبال الرمز؟', 'Code niet ontvangen?', 'Didn&#39;t get the code?', 'Du hast keinen Code erhalten?', 'Non avere il codice?', 'Não obteve o código?', 'Не получить код?', 'No he recivido código?', 'Onay kodunu almadınız mı?'),
(718, 'activation_resend', '', 'Resend', 'اعادت ارسال', 'Verstuur opnieuw', 'Renvoyer', 'Erneut Senden', 'inviare di nuovo', 'Re-enviar', 'Отправить', 'Re-enviar', 'Tekrar gönder'),
(719, 'activation_should_receive', '', 'You should receive the code within', 'يجب استقبال الرمز في مدة', 'Je zult de code ontvangen', 'You should receive the code within', 'Du solltest den Code in Kürze erhalten.', 'Si dovrebbe ricevere il codice all&#039;interno', 'Você deve receber o código dentro de', 'Вы должны получить код внутри', 'Debería recibir el código dentro de', 'içinde kodu almalısınız'),
(720, 'confirm', '', 'Confirm', 'تأكيد', 'Bevestig', 'Confirmer', 'Bestätigen', 'Confermare', 'Confirmar', 'подтвердить', 'Confirmar', 'Onayla'),
(721, 'phone_num_ex', '', 'Phone number (eg. +905...)', '(eg. +905...) رقم الهاتف', 'Telefoonnumer (bijv. +31...)', 'Numéro de téléphone (eg. +33...)', 'Telefonnummer  (z.b +49...)', 'Numero di telefono (eg. +905...)', 'Número de telefone (ex. +905...)', 'Номер телефона (eg. +905...)', 'Numero de Telefono (eg. +001...)', 'Telefon Numarası (örn. +905...)'),
(722, 'error_while_activating', '', 'Error while activating your account.', '.خطأ أثناء تفعيل حسابك', 'Error tijdens het activeren van uw account.', 'Error while activating your account.', 'Fehler beim aktivieren deines Accounts.', 'Errore durante l&#039;attivazione dell&#039;account.', 'Erro ao ativar a sua conta.', 'Ошибка при активации учетной записи.', 'Error al activar su cuenta.', 'Hesabınızı onaylarken hata oluştu.'),
(723, 'wrong_confirmation_code', '', 'Wrong confirmation code.', '.خطأ في رمز التأكيد', 'Ongeldige code.', 'Code de confirmation erroné.', 'Falscher bestätigungs Code.', 'codice di conferma errato.', 'Código de confirmação incorreto.', 'Неправильный код подтверждения.', 'Este código no es valido.', 'Yanlış onay kodu.'),
(724, 'failed_to_send_code', '', 'Failed to send the confirmation code.', '.فشل في إرسال رمز التأكيد', 'Het is niet gelukt de code te verzenden.', 'Impossible d&#39;envoyer le code de confirmation.', 'Fehler beim senden des bestätigungs Code.', 'Impossibile inviare il codice di conferma.', 'Não foi possível enviar o código de confirmação.', 'Не удалось отправить код подтверждения.', 'No se pudo enviar código de activación.', 'Onay kodu gönderilirken hata oluştu.'),
(725, 'worng_phone_number', '', 'Wrong phone number.', '.رقم الهاتف خاطئ', 'Geen geldige telefoonnummer.', 'Numéro de téléphone erroné.', 'Falsche Telefonnummer.', 'numero di telefono sbagliato.', 'Número de telefone incorreto.', 'Неправильный номер телефона.', 'Numero incorrecto.', 'Yanlış telefon numarası.'),
(726, 'phone_already_used', '', 'Phone number already used.', '.رقم الهاتف موجود', 'Telefoonnummer is al in gebruik.', 'Numéro de téléphone déjà utilisé.', 'Die angebene Telefonnummer wird bereits verwendet.', 'Numero di telefono già in uso.', 'Número de telefone já em uso.', 'Номер телефона уже используется.', 'Este nuemero ya a sido usado.', 'Telefon numarası kullanılıyor.'),
(727, 'sms_has_been_sent', '', 'SMS has been sent successfully.', '.تم ارسا الرسالة النصية بنجاح', 'SMS is succsesvol verzonden.', 'SMS envoyé avec succès.', 'Die SMS wurde erfolgreich versendet.', 'SMS è stato inviato con successo.', 'SMS foi enviado com sucesso.', 'SMS было отправлено успешно.', 'El código de activación a sido enviado.', 'SMS başarıyla gönderildi.'),
(728, 'error_while_sending_sms', '', 'Error while sending the SMS, please try another number.', '.خطأ أثناء إرسال الرسالة القصيرة، يرجى المحاولة باستخدام رقم آخر', 'We konden de SMS niet versturen, probeer een ander nummer.', 'Erreur lors de l&#39;envooi du SMS, merci d&#39;essayer un autre numéro de téléphone.', 'Fehler beim Versenden der SMS, bitte versuche eine andere Telefonnummer.', 'Errore durante l&#039;invio del SMS, prova un altro numero.', 'Erro ao enviar o SMS, por favor tente outro número.', 'Ошибка при отправке SMS, пожалуйста, попробуйте другой номер.', 'Error al enviar código de activacion, por favor trata con otro numero .', 'SMS gönderilemiyor, lütfen farklı numara deneyiniz.'),
(729, 'failed_to_send_code_fill', '', 'Failed to send the confirmation code, please select one of the activation methods.', '.فشل في إرسال رمز التأكيد، يرجى ملء إحدى خانات التنشيط', 'Het is niet gelukt de code te versturen, probeer een andere methoda.', 'Impossible d&#39;envoyer le code de confirmation, essayez une des méthodes d&#39;activation.', 'Fehler beim Versenden des bestätigungs Code, bitte wählen eine andere aktivierungs Methode.', 'Impossibile inviare il codice di conferma, selezionare uno dei metodi di attivazione.', 'Não foi possível enviar o código de confirmação, por favor preencha um dos métodos de ativação.', 'Не удалось отправить код подтверждения, пожалуйста, выберите один из предложенных способов активации.', 'Error al enviar código de activacion, por favor trata con otro metodo.', 'Onay kodu gönderilemiyor, lütfen aktivasyon yöntemlerinden birini seçiniz.'),
(730, 'email_sent_successfully', '', 'E-mail has been sent successfully, please check your inbox or spam folder for the activation link.', '.تم إرسال البريد الإلكتروني بنجاح، يرجى مراجعة مجلد البريد الوارد أو الرسائل غير المرغوب فيها لرابط التفعيل', 'E-mail is succesvol verzonden, kijk ook in uw spam/ongewenste inbox.', 'E-mail envoyé avec succès, merci de vérifier votre boite de réception et dossier spam pour le lien d&#39;activation.', 'Es wurde dir eine Email gesendet, bitte überprüfe deinen Postfach und gegebenfalls auch den Spam Ordner.', 'E-mail è stata inviata con successo, controllare la cartella Posta in arrivo o spam per il link di attivazione.', 'E-mail foi enviado com sucesso, verifique a sua pasta caixa de entrada ou de spam para o link de ativação.', 'Электронная почта была успешно отправлена, пожалуйста, проверьте свой почтовый ящик или спам папку для ссылки активации.', 'El correo a sido enviado, por favor check your inbox or spam folder for the activation link.', 'E-mail gönderildi, aktivasyon linki için lütfen mesaj kutunuzu yada spam kutusunu kontrol ediniz.'),
(731, 'limit_exceeded', '', 'Limit exceeded, please try again later.', '.لقد تجاوزت الحد المسموح به، يرجى المحاولة مرة أخرى في وقت لاحق', 'Te vaak geprobeerd, probeer het later nog eens.', 'Limite dépassé, merci de réessayer plus tard.', 'Anzahl an versuche überschritten , bitte versuche es später nochmal..', 'Limite superato, riprova più tardi.', 'Limite excedido, tente novamente mais tarde.', 'Превышен лимит, пожалуйста, повторите попытку позже.', 'Límite excedido, por favor trata mas tarde.', 'Limit aşıldı, lütfen daha sonra tekrar deneyin.'),
(732, 'failed_to_send_code_email', '', 'Error while sending the SMS, please try another number or activate your account via email by logging into your account.', '.خطأ أثناء إرسال الرسائل القصيرة، يرجى المحاولة رقم آخر أو تفعيل حسابك عبر البريد الإلكتروني عن طريق الدخول في حسابك', 'Probeer je account te verifiëren via de e-mail, we konden geen sms sturen.', 'Erreur lors de l&#39;envoi du SMS, merci d&#39;essayer un autre numéro ou activer votre compte par e-mail en vous connectant à votre compte.', 'Fehler beim Versenden der SMS, bitte benutze eine andere Telefonnummer  oder aktiviere deinen Account via Email, indem  du dich mit deinem Account Anmeldest.', 'Errore durante l&#039;invio del SMS, prova un altro numero o attivare il tuo account tramite e-mail accedendo al proprio conto.', 'Erro ao enviar o SMS, tente outro número ou ativar sua conta via e-mail, entrando em sua conta.', 'Ошибка при отправке SMS, пожалуйста, попробуйте другой номер или активировать свою учетную запись через электронную почту, войдя в свой аккаунт.', 'Error al enviar código de activacion, por favor trata con otro numero o activa tu cuenta via email accediendo a tu cuenta .', 'SMS gönderilemiyor, lütfen başka bir numara deneyiniz yada hesabınıza giriş yaparak hesabınızı mail ile etkinleştiriniz.'),
(733, 'free_member', '', 'Free Member', 'عضو عادي', 'Gratis Lid', 'Free member', 'Kostenlose Mitgliedschaft', 'Free Member', 'Membro grátis', 'Free Member', 'Usuario gratis', 'Ücretsiz üye'),
(734, 'star_member', '', 'Star Member', 'عضو برونزي', 'Ster Lid', 'Star Member', 'Star Mitgliedschaft', 'Star Member', 'Membro estrela', 'Star Member', 'Usuario star', 'Yıldız üye'),
(735, 'hot_member', '', 'Hot Member', 'عضو فضي', 'Hot Lid', 'Hot Member', 'Hot Mitgliedschaft', 'Hot Member', 'Membro Quente', 'Hot Member', 'Usuario hot', 'Sıcak Üye'),
(736, 'ultima_member', '', 'Ultima Member', 'عضو ذهبي', 'Ultimate Lid', 'Ultima Member', 'Ultima Mitgliedschaft', 'Ultima Member', 'Ultima Member', 'Ultima Member', 'Usuario ultima', 'Ultima Üye'),
(737, 'vip_member', '', 'Vip Member', 'عضو ماسي', 'VIP Lid', 'Vip Member', 'Vip Mitgliedschaft', 'Vip Member', 'Membro Vip', 'Vip Member', 'Usuario VIP', 'Vip Üye'),
(738, 'moderator', '', 'Moderator', 'مشرف', 'Moderator', 'Modérateur', 'Moderator', 'Moderator', 'Moderador', 'Moderator', 'Moderador', 'Moderator'),
(739, 'member_type', '', 'Member Type', 'نوع العضوية', 'Member soort', 'Type de membres', 'Mitglieds Typ', 'Member Type', 'Tipo de Membro', 'Member Type', 'Tipo de menbresia', 'Üye Türü'),
(740, 'membership', '', 'Membership', 'العضوية', 'Membership', 'Membership', 'Mitgliedschaft', 'membri', 'Filiação', 'членство', 'Membresia', 'Üyelik'),
(741, 'upgrade', '', 'Upgrade', 'الترقية', 'Upgrade', 'Mise à jour', 'Upgrade', 'aggiornamento', 'Atualização', 'Обновить', 'Actualización', 'Yükselt'),
(742, 'error_please_try_again', '', 'Error, Please try again later.', '.خطئ, يرجى المحاولة لاحقا', 'Error, probeer het later opnieuw.', 'Erreur, merci de réessayer plus tard.', 'Fehler, bitte versuche es später nochmal.', 'Errore, riprova più tardi.', 'Erro, Por favor tente novamente.', 'Ошибка, пожалуйста, повторите попытку позже.', 'Error, trata de nuevo.', 'Hata, Lütfen daha sonra tekrar deneyin.'),
(743, 'upgrade_to_pro', '', 'Upgrade To Pro', 'لترقية الى مزايا أكثر', 'Upgraden naar Pro', 'Passer à Pro', 'Upgrade auf Pro', 'Aggiornamento a Pro', 'Upgrade To Pro', 'Обновление до Pro', 'Para actualizar Pro', 'Pro&#039;ya yükselt'),
(744, 'no_answer', '', 'No answer', 'لا يوجد رد', 'Geen antwoord', 'Pas de réponse', 'Keine Antwort', 'Nessuna risposta', 'Sem resposta', 'Нет ответа', 'Sin respuesta', 'Cevap yok'),
(745, 'please_try_again_later', '', 'Please try again later.', 'الرجاء المحاولة لاحقا.', 'Probeer het later opnieuw.', 'Veuillez réessayer plus tard.', 'Bitte versuchen Sie es später noch einmal.', 'Per favore riprova più tardi.', 'Por favor, tente novamente mais tarde.', 'Пожалуйста, повторите попытку позже.', 'Por favor, inténtelo de nuevo más tarde.', 'Lütfen daha sonra tekrar deneyiniz.'),
(746, 'answered', '', 'Answered !', 'تم الرد !', 'Beantwoord !', 'répondre !', 'Beantwortet !', 'Risposte !', 'Respondidas !', 'Ответил !', 'Contestada !', 'Yanıtlanan !'),
(747, 'call_declined', '', 'Call declined', 'تم فصل الإتصال من قبل المستخدم', 'Call gedaald', 'Appel refusé', 'Anruf abgelehnt', 'chiamata rifiutato', 'chamada diminuiu', 'Вызов отказался', 'Llamar declinó', 'çağrı reddedildi'),
(748, 'call_declined_desc', '', 'The recipient has declined the call, please try again later.', 'تم فصل الإتصال من قبل المستخدم, الرجاء المحاولة لاحقا.', 'De ontvanger heeft de oproep geweigerd, probeer het later opnieuw.', 'Le destinataire a refusé l&#39;appel, s&#39;il vous plaît essayer à nouveau plus tard.', 'Der Empfänger hat den Anruf abgelehnt, bitte versuchen Sie es später noch einmal.', 'Il destinatario ha rifiutato la chiamata, si prega di riprovare più tardi.', 'O destinatário recusou a chamada, por favor tente novamente mais tarde.', 'Получатель отклонил вызов, пожалуйста, повторите попытку позже.', 'El receptor ha rechazado la llamada, por favor intente de nuevo más tarde.', 'Alıcı çağrıyı reddetti, daha sonra tekrar deneyin.'),
(749, 'new_video_call', '', 'New video call', 'إتصال فيديو', 'Nieuwe video-oproep', 'Nouvel appel vidéo', 'Neue Videoanruf', 'Nuovo video chiamata', 'chamada de vídeo novo', 'Новое видео вызова', 'Nueva llamada de video', 'Yeni video görüşmesi'),
(750, 'new_video_call_desc', '', 'wants to video chat with you.', 'يريد ان يحدثك عن طريق الفيديو.', 'wil video chatten met je.', 'veut le chat vidéo avec vous.', 'möchte mit Ihnen Video-Chat.', 'vuole chat video con te.', 'quer vídeo chat com você.', 'хочет видео-чат с вами.', 'quiere chatear con video con usted.', 'Sizinle görüntülü sohbet etmek istiyor.'),
(751, 'decline', '', 'Decline', 'فصل', 'Afwijzen', 'Déclin', 'Ablehnen', 'Declino', 'Declínio', 'снижение', 'Disminución', 'düşüş'),
(752, 'accept_and_start', '', 'Accept &amp; Start', 'القبول &amp; البدأ', 'Accepteer &amp; Start', 'Accepter &amp; Start', 'Akzeptieren &amp; Start', 'Accetta &amp; Start', 'Aceitar &amp; Start', 'принимать', 'Aceptar &amp; Start', 'Kabul Et ve Başlaı'),
(753, 'calling', '', 'Calling', 'يتم الإتصال', 'Roeping', 'Appel', 'Berufung', 'chiamata', 'chamada', 'призвание', 'Vocación', 'çağrı'),
(754, 'calling_desc', '', 'Please wait for your friend answer.', 'الرجاء الإنتظار لحين يتم الرد من قبل المستخدم.', 'Wacht tot je vriend antwoord op de video chat starten.', 'S&#39;il vous plaît attendre votre ami répondre à démarrer le chat vidéo.', 'Bitte warten Sie, Ihr Freund das Video-Chat zu starten beantworten.', 'Si prega di attendere per il vostro amico a rispondere per avviare la chat video.', 'Por favor aguarde o amigo responder para iniciar o bate-papo de vídeo.', 'Пожалуйста, подождите, ваш друг ответить, чтобы начать видео чат.', 'Por favor, espere a que su amigo responde a iniciar el chat de vídeo.', 'Arkadaşınız, video sohbet başlatmak için cevap için bekleyin.'),
(755, 'your_friends_chat', '', 'You&#039;re friends on {site_name}', 'أنتم أصدقاء في {site_name}', 'Je bent vrienden op {site_name}', 'Vous êtes amis sur {site_name}', 'Sie sind freunde auf {site_name}', 'Sei amici su {site_name}', 'Você é amigos {site_name}', 'Вы друзья на {site_name}', 'Eres amigos en {site_name}', 'Üzerinde dostuz {site_name}'),
(756, 'your_following', '', 'You&#039;re following', 'أنت تتابع', 'Je volgt', 'Vous suivez', 'Sie folgen', 'Stai seguendo', 'Você está seguindo', 'Вы следующие', 'Usted está siguiendo', 'İzlediğiniz'),
(757, 'see_all', '', 'See all', 'الكل', 'alles zien', 'Voir tout', 'Alles sehen', 'Vedi tutti', 'Ver todos', 'Увидеть все', 'Ver todo', 'Hepsini gör'),
(758, 'me', '', 'Me', 'أنا', 'Me', 'Moi', 'Mich', 'Me', 'Mim', 'меня', 'Yo', 'Ben'),
(759, 'post_promotion_hot', '', 'Boost up to {monthly_boosts} posts&lt;br&gt;', 'نشر اكثر من {monthly_boosts} منشورات &lt;br&gt;&lt;small&gt;({monthly_boosts} في نفس الوقت 7/24)&lt;/small&gt;', '{monthly_boosts} berichten omhoog plaatsen&lt;br&gt;&lt;small&gt;({monthly_boosts} tegelijk 7/24)&lt;/small&gt;', 'Boost up to {monthly_boosts} posts&lt;br&gt;&lt;small&gt;({monthly_boosts} in same time 7/24)&lt;/small&gt;', 'Bis zu {monthly_boosts} Beiträge hervorheben&lt;br&gt;&lt;small&gt;({monthly_boosts} Beiträge gleichen Zeit 7/24)&lt;/small&gt;', 'Boost fino a {monthly_boosts} posti&lt;br&gt;&lt;small&gt;({monthly_boosts} nel contempo 7/24)&lt;/small&gt;', 'Impulsionar até {monthly_boosts} postagens&lt;br&gt;&lt;small&gt;({monthly_boosts} ao mesmo tempo 7/24)&lt;/small&gt;', 'Повышение до {monthly_boosts} сообщений&lt;br&gt;&lt;small&gt;({monthly_boosts} в то же время 7/24)&lt;/small&gt;', 'Promociona asta {monthly_boosts} posts&lt;br&gt;&lt;small&gt;({monthly_boosts} al mismo tiempo 7/24)&lt;/small&gt;', '{monthly_boosts} mesaj yükselt&lt;br&gt;&lt;small&gt;({monthly_boosts} aynı zamanda 7/24)&lt;/small&gt;'),
(760, 'page_promotion_hot', '', 'Boost up to {monthly_boosts} pages&lt;br&gt;', 'نشر اكثر من {monthly_boosts} صفحات&lt;br&gt;&lt;small&gt;({monthly_boosts} في نفس الوقت 7/24)&lt;/small&gt;', '{monthly_boosts} pagina&#039;s omhoog plaatsen&lt;br&gt;&lt;small&gt;({monthly_boosts} tegelijk 7/24)&lt;/small&gt;', 'Boost up to {monthly_boosts} pages&lt;br&gt;&lt;small&gt;({monthly_boosts} in same time 7/24)&lt;/small&gt;', 'Bis zu {monthly_boosts} Seiten hervorheben&lt;br&gt;&lt;small&gt;({monthly_boosts} Seiten zur gleichen Zeit 7/24)&lt;/small&gt;', 'Boost fino a {monthly_boosts} pagine&lt;br&gt;&lt;small&gt;({monthly_boosts} nel contempo 7/24)&lt;/small&gt;', 'Impulsionar até {monthly_boosts} páginas&lt;br&gt;&lt;small&gt;({monthly_boosts} ao mesmo tempo 7/24)&lt;/small&gt;', 'Повышение до {monthly_boosts} страниц&lt;br&gt;&lt;small&gt;({monthly_boosts} в то же время 7/24)&lt;/small&gt;', 'Promociona asta {monthly_boosts} paginas&lt;br&gt;&lt;small&gt;({monthly_boosts} al mismo tiempo 7/24)&lt;/small&gt;', '{monthly_boosts} sayfa yükselt&lt;br&gt;&lt;small&gt;({monthly_boosts} aynı zamanda 7/24)&lt;/small&gt;'),
(761, 'post_promotion_ultima', '', 'Boost up to {yearly_boosts} posts&lt;br&gt;', 'نشر اكثر من {yearly_boosts} منشورات&lt;br&gt;&lt;small&gt;({yearly_boosts} في نفس الوقت 7/24)&lt;/small&gt;', '{yearly_boosts} berichten omhoog plaatsen&lt;br&gt;&lt;small&gt;({yearly_boosts} tegelijk 7/24)&lt;/small&gt;', 'Boost up to {yearly_boosts} posts&lt;br&gt;&lt;small&gt;({yearly_boosts} in same time 7/24)&lt;/small&gt;', 'Bis zu {yearly_boosts} Beiträge hervorheben&lt;br&gt;&lt;small&gt;({yearly_boosts} Beiträge zur gleichen Zeit 7/24)&lt;/small&gt;', 'Boost fino a {yearly_boosts} posti&lt;br&gt;&lt;small&gt;({yearly_boosts} nel contempo 7/24)&lt;/small&gt;', 'Impulsionar até {yearly_boosts} postagens&lt;br&gt;&lt;small&gt;({yearly_boosts} ao mesmo tempo 7/24)&lt;/small&gt;', 'Повысить до {yearly_boosts} должностей&lt;br&gt;&lt;small&gt;({yearly_boosts} в то же время 7/24)&lt;/small&gt;', 'Promociona asta {yearly_boosts} posts&lt;br&gt;&lt;small&gt;({yearly_boosts} al mismo tiempo 7/24)&lt;/small&gt;', '{yearly_boosts} mesaj yükselt&lt;br&gt;&lt;small&gt;({yearly_boosts} aynı zamanda 7/24)&lt;/small&gt;'),
(762, 'page_promotion_ultima', '', 'Boost up to {yearly_boosts} pages&lt;br&gt;', 'نشر اكثر من {yearly_boosts} صفحات&lt;br&gt;&lt;small&gt;({yearly_boosts} في نفس الوقت 7/24)&lt;/small&gt;', '{yearly_boosts} pagina&#039;s omhoog plaatsen&lt;br&gt;&lt;small&gt;({yearly_boosts} tegelijk 7/24)&lt;/small&gt;', 'Boost up to {yearly_boosts} pages&lt;br&gt;&lt;small&gt;({yearly_boosts} in same time 7/24)&lt;/small&gt;', 'Bis zu {yearly_boosts} Seiten hervorheben&lt;br&gt;&lt;small&gt;({yearly_boosts} Seiten zur gleichen Zeit 7/24)&lt;/small&gt;', 'Boost fino a {yearly_boosts} pagine&lt;br&gt;&lt;small&gt;({yearly_boosts} nel contempo 7/24)&lt;/small&gt;', 'Impulsionar até {yearly_boosts} páginas&lt;br&gt;&lt;small&gt;({yearly_boosts} ao mesmo tempo 7/24)&lt;/small&gt;', 'Повышение до {yearly_boosts} страниц&lt;br&gt;&lt;small&gt;({yearly_boosts} в то же время 7/24)&lt;/small&gt;', 'Promociona asta {yearly_boosts} paginas&lt;br&gt;&lt;small&gt;({yearly_boosts} al mismo tiempo 7/24)&lt;/small&gt;', '{yearly_boosts} sayfa yükselt&lt;br&gt;&lt;small&gt;({yearly_boosts} aynı zamanda 7/24)&lt;/small&gt;'),
(763, 'post_promotion_vip', '', 'Boost up to {lifetime_boosts} posts&lt;br&gt;', 'نشر اكثر من {lifetime_boosts} منشورات&lt;br&gt;&lt;small&gt;({lifetime_boosts} في نفس الوقت 7/24)&lt;/small&gt;', 'Boost up to {lifetime_boosts} posts&lt;br&gt;&lt;small&gt;({lifetime_boosts} in same time 7/24)&lt;/small&gt;', 'Boost up to {lifetime_boosts} posts&lt;br&gt;&lt;small&gt;({lifetime_boosts} in same time 7/24)&lt;/small&gt;', 'Bis zu {lifetime_boosts} Beiträge hervorheben&lt;br&gt;&lt;small&gt;({lifetime_boosts} Beiträge zur gleichen Zeit 7/24)&lt;/small&gt;', 'Boost fino a {lifetime_boosts} posti&lt;br&gt;&lt;small&gt;({lifetime_boosts} nel contempo 7/24)&lt;/small&gt;', 'Impulsionar até {lifetime_boosts} postagens&lt;br&gt;&lt;small&gt;({lifetime_boosts} ao mesmo tempo 7/24)&lt;/small&gt;', 'Повысить до {lifetime_boosts} должностей&lt;br&gt;&lt;small&gt;({lifetime_boosts} in same time 7/24)&lt;/small&gt;', 'Promociona asta {lifetime_boosts} posts&lt;br&gt;&lt;small&gt;({lifetime_boosts} al mismo tiempo 7/24)&lt;/small&gt;', '{lifetime_boosts} mesaj yükselt&lt;br&gt;&lt;small&gt;({lifetime_boosts} aynı zamanda 7/24)&lt;/small&gt;'),
(764, 'page_promotion_vip', '', 'Boost up to {lifetime_boosts} pages&lt;br&gt;', 'نشر اكثر من {lifetime_boosts} صفحات&lt;br&gt;&lt;small&gt;({lifetime_boosts} في نفس الوقت 7/24)&lt;/small&gt;', 'Boost up to {lifetime_boosts} pages&lt;br&gt;&lt;small&gt;({lifetime_boosts} in same time 7/24)&lt;/small&gt;', 'Boost up to {lifetime_boosts} pages&lt;br&gt;&lt;small&gt;({lifetime_boosts} in same time 7/24)&lt;/small&gt;', 'Bis zu {lifetime_boosts} Seiten hervorheben&lt;br&gt;&lt;small&gt;({lifetime_boosts} Seiten zur gleichen Zeit 7/24)&lt;/small&gt;', 'Boost fino a {lifetime_boosts} pagine&lt;br&gt;&lt;small&gt;({lifetime_boosts} nel contempo 7/24)&lt;/small&gt;', 'Impulsionar até {lifetime_boosts} páginas&lt;br&gt;&lt;small&gt;({lifetime_boosts} ao mesmo tempo 7/24)&lt;/small&gt;', 'Повышение до {lifetime_boosts} страниц&lt;br&gt;&lt;small&gt;({lifetime_boosts} в то же время 7/24)&lt;/small&gt;', 'Promociona asta {lifetime_boosts} paginas&lt;br&gt;&lt;small&gt;({lifetime_boosts} al mismo tiempo 7/24)&lt;/small&gt;', '{lifetime_boosts} sayfa yükselt&lt;br&gt;&lt;small&gt;({lifetime_boosts} aynı zamanda 7/24)&lt;/small&gt;'),
(765, 'sign_up', '', 'Sign up', 'التسجيل', 'Aanmelden', 'S&#39;inscrire', 'Anmelden', 'Registrazione', 'inscrever-se', 'зарегистрироваться', 'Regístrate', 'Kaydol'),
(766, 'youtube', '', 'YouTube', 'يوتيوب', 'YouTube', 'YouTube', 'YouTube', 'YouTube', 'Youtube', 'YouTube', 'Youtube', 'YouTube'),
(767, 'my_products', '', 'My Products', 'منتجاتي', 'mijn producten', 'Mes produits', 'Meine Produkte', 'I miei prodotti', 'meus produtos', 'Мои продукты', 'Mis productos', 'Ürünlerim'),
(768, 'choose_a_payment_method', '', 'Choose a payment method', 'اختر طريقة الدفع', 'Kies een betaalmethode', 'Choisissez une méthode de paiement', 'Wählen Sie eine Zahlungsmethode', 'Scegliere un metodo di pagamento', 'Escolha um método de pagamento', 'Выберите способ оплаты', 'Elija un método de pago', 'Bir ödeme yöntemi seçin'),
(769, 'paypal', '', 'PayPal', 'باي بال', 'PayPal', 'PayPal', 'PayPal', 'PayPal', 'PayPal', 'PayPal', 'PayPal', 'PayPal'),
(770, 'credit_card', '', 'Credit Card', 'بطاقة ائتمان', 'Credit Card', 'Credit Card', 'Kreditkarte', 'Carta di credito', 'Cartão de crédito', 'Кредитная карта', 'Tarjeta de crédito', 'Kredi Kartı'),
(771, 'bitcoin', '', 'Bitcoin', 'بيتكوين', 'Bitcoin', 'Bitcoin', 'Bitcoin', 'Bitcoin', 'Bitcoin', 'Bitcoin', 'Bitcoin', 'Bitcoin'),
(772, 'categories', '', 'Categories', 'الإقسام', 'Categorieën', 'Catégories', 'Kategorien', 'Categorie', 'Categorias', 'категории', 'Categorías', 'Kategoriler'),
(773, 'latest_products', '', 'Latest Products', 'آخر المنتجات', 'nieuwste producten', 'Derniers produits', 'Neueste Produkte', 'Gli ultimi prodotti', 'Produtos Mais recentes', 'Последние поступления', 'últimos productos', 'Yeni ürünler'),
(774, 'search_for_products_main', '', 'Search for products', 'إبحث عن منتج', 'Zoeken naar producten', 'Recherche de produits', 'Suche nach Produkten', 'Ricerca di prodotti', 'Pesquisa de produtos', 'Поиск продукции', 'Búsqueda de productos', 'Ürün ara'),
(775, 'search_for_products', '', 'Search for products in {category_name}', 'بحث عن منتج في {category_name}', 'Zoeken naar producten in {category_name}', 'Recherche de produits dans {category_name}', 'Suche nach Produkten im {category_name}', 'Ricerca di prodotti in {category_name}', 'Pesquisa para os produtos em {category_name}', 'Поиск продукции в {category_name}', 'Búsqueda de productos en {category_name}', 'Ürünlerde ara {category_name}'),
(776, 'no_available_products', '', 'No available products to show.', 'لا توجد منتجات متاحة.', 'Geen beschikbare tonend.', 'Pas de produits disponibles pour afficher.', 'Keine verfügbaren Produkte zu zeigen.', 'Non ci sono prodotti disponibili da mostrare.', 'Não há produtos disponíveis para mostrar.', 'Нет доступных продуктов для отображения.', 'No hay productos disponibles para mostrar.', 'Kullanılabilir bir ürün bulunamadı'),
(777, 'load_more_products', '', 'Load more products', 'تحميل المزيد من المنتجات', 'Laad meer producten', 'Chargez plus de produits', 'Laden Sie weitere Produkte', 'Caricare più prodotti', 'Carregar mais produtos', 'Загрузить больше продуктов', 'Cargar más productos', 'Daha fazla ürün göster'),
(778, 'sell_new_product', '', 'Sell new product', 'بيع منتج جديد', 'Verkoop een nieuw product', 'Vente nouveau produit', 'Verkauf neuer Produkte', 'Vendita nuovo prodotto', 'Vender novo produto', 'Продаем новый продукт', 'Vender nuevos productos', 'Yeni bir ürün sat'),
(779, 'description', '', 'Description', 'الوصف', 'Beschrijving', 'La description', 'Beschreibung', 'Descrizione', 'Descrição', 'Описание', 'Descripción', 'Açıklama'),
(780, 'please_describe_your_product', '', 'Please describe your product.', 'يرجى وصف المنتج الخاص بك.', 'Beschrijf uw product.', 'S&#39;il vous plaît décrire votre produit.', 'Bitte beschreiben Sie Ihr Produkt.', 'Si prega di descrivere il tuo prodotto.', 'Por favor, descreva o seu produto.', 'Пожалуйста, опишите ваш продукт.', 'Por favor describa su producto.', 'Ürününüzü açıklayın'),
(781, 'used', '', 'Used', 'مستعمل', 'Gebruikt', 'Utilisé', 'Benutzt', 'Usato', 'Usava', 'Используемый', 'Usado', 'Kullanılan'),
(782, 'new', '', 'New', 'جديد', 'Nieuwe', 'Nouveau', 'Neu', 'Nuovo', 'Novo', 'новый', 'Nuevo', 'Yeni'),
(783, 'price', '', 'Price', 'السعر', 'Prijs', 'Prix', 'Preis', 'Prezzo', 'Preço', 'Цена', 'Precio', 'Fiyat'),
(784, 'your_product_price', '', 'Your product price in USD currency ($), e.g (10.99)', 'سعر المنتج في الدولار ($), مثال (10.99)', 'Uw product prijs in USD valuta ($), e.g (10.99)', 'Votre prix du produit en monnaie USD ($), e.g (10.99)', 'Ihr Produktpreis in USD ($), e.g (10.99)', 'Il prezzo del prodotto in valuta USD ($), e.g (10.99)', 'Seu preço do produto em USD ($), por exemplo (10,99)', 'Ваша цена продукта в USD валюте ($) области, например (10,99)', 'Su precio del producto en USD ($), por ejemplo (10.99)', 'Ürün fiyatı dolar para birimi cinsinden ($), ör: (10.99)'),
(785, 'edit_product', '', 'Edit product', 'تحرير المنتج', 'Product bewerken', 'Modifier le produit', 'Bearbeiten Produkt', 'Modifica del prodotto', 'Editar produto', 'Изменить продукт', 'Editar producto', 'Ürün düzenle'),
(786, 'publish', '', 'Publish', 'نشر', 'Publiceren', 'Publier', 'Veröffentlichen', 'Pubblicare', 'Publicar', 'Публиковать', 'Publicar', 'Yayınla'),
(787, 'more_info', '', 'More info', 'المزيد', 'Meer informatie', 'More info', 'Mehr Infos', 'Ulteriori informazioni', 'Mais informações', 'Больше информации', 'Más información', 'Daha fazla bilgi'),
(788, 'contact_seller', '', 'Contact seller', 'تواصل مع البائع', 'De aanbieders contacteren', 'Contacter le vendeur', 'Verkäufer kontaktieren', 'Contatta il venditore', 'Contactar fornecedor', 'Связаться с продавцом', 'Contacte al vendedor', 'Satıcı olmak için başvurun'),
(789, 'by_product', '', 'By &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, posted {product_time}, in &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'بواسطة &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, نشر {product_time}, في &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Door &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, gepost {product_time}, in &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Par &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, posté {product_time}, dans &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Durch &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, gesendet {product_time}, im &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Di &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, postato {product_time}, in &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Por &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, postou {product_time}, em &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'По &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, размещенном {product_time}, в &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Por &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, publicado {product_time}, en &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;', 'Satışda olan ürün: &lt;a href=&quot;{product_url}&quot;&gt;{product_name}&lt;/a&gt;, Satışa başladığı zaman: {product_time}, Satış kategorisi: &lt;a href=&quot;{product_category}&quot;&gt;{product_category_name}&lt;/a&gt;'),
(790, 'payment_declined', '', 'Payment declined, please try again later.', 'حدثت مشكلة ، يرجى المحاولة مرة أخرى في وقت لاحق.', 'Betaling geweigerd, probeer het later opnieuw.', 'Paiement refusé, s&#39;il vous plaît essayer à nouveau plus tard.', 'Zahlung abgelehnt, bitte versuchen Sie es später noch einmal.', 'Pagamento rifiutato, riprova più tardi.', 'Pagamento recusado, por favor tente novamente mais tarde.', 'Платеж отклонен, пожалуйста, повторите попытку позже.', 'Pago rechazado, por favor intente de nuevo más tarde.', 'Ödeme reddedildi, lütfen daha sonra tekrar deneyin.'),
(791, 'c_payment', '', 'Confirming payment, please wait..', 'تأكيد الدفع، يرجى الانتظار ..', 'Bevestiging van de betaling, even geduld aub ..', 'paiement confirmant, s&#39;il vous plaît patienter ..', 'Bestätigen Zahlung, bitte warten ..', 'Confermando il pagamento, si prega di attendere ..', 'Confirmação do pagamento, aguarde por favor ..', 'Подтверждение оплаты, пожалуйста, подождите ..', 'Confirmar el pago, por favor espere ..', 'Ödeme kontrol ediliyor, lütfen bekleyin.'),
(792, 'earn_users', '', 'Earn up to ${amount} for each user your refer to us !', 'إكسب ما يصل الى ${amount} لكل مستخدم يسجل من جانبك !', 'Verdien tot ${amount} voor elke gebruiker je verwijzen naar ons!', 'Gagnez jusqu&#39;à ${amount} pour chaque utilisateur de votre référence à nous!', 'Verdienen Sie bis zu ${amount} Für jeden Benutzer beziehen Ihr uns!', 'Guadagna fino a ${amount} per ogni utente il vostro si riferiscono a noi!', 'Ganhe até ${amount} para cada usuário sua referem-se a nós!', 'Заработайте до ${amount} для каждого пользователя вашего обратитесь к нам!', 'Gane hasta ${amount} para cada usuario su refieren a nosotros!', 'Her kullanıcıdan ${amount} daha fazla kazanmak için bizi izleyin.'),
(793, 'earn_users_pro', '', 'Earn up to ${amount} for each user your refer to us and will subscribe to any of our pro packages.', 'إكسب ما يصل الى ${amount} لكل مستخدم يسجل من جانبك ويشترك باحدى عروضنا', 'Verdien tot ${amount} voor elke gebruiker je verwijzen naar ons en zal zich abonneren op een van onze propakketten.', 'Gagnez jusqu&#39;à ${amount} pour chaque utilisateur de votre référence à nous et souscrira à un de nos forfaits pro.', 'Verdienen Sie bis zu ${amount} Für jeden Benutzer beziehen Ihr für uns und wird zu einem unserer Pro-Pakete abonnieren.', 'Guadagna fino a ${amount} per ogni utente il vostro si riferiscono a noi e sottoscriverà uno qualsiasi dei nostri pacchetti pro.', 'Ganhe até ${amount} para cada usuário sua referem-se a nós e vai inscrever-se a qualquer um dos nossos profissionais pacotes.', 'Заработайте до ${amount} для каждого пользователя вашего обратитесь к нам и подписаться на любой из наших профессиональных пакетов.', 'Gane hasta ${amount} para cada usuario su refieren a nosotros y suscribirse a cualquiera de nuestros redactores paquetes.', 'Her kullanıcıdan ${amount} kazanmak için daha fazla pro paketlerimize abone olacak.'),
(794, 'my_affiliates', '', 'My Affiliates', 'دعوة الأصدقاء بالمكافأة', 'Mijn Affiliates', 'Mes Affiliés', 'Meine Affiliates', 'I miei affiliati', 'meus Afiliados', 'Мои Филиалы', 'Mis Afiliados', 'Benim referanslarım'),
(795, 'my_balance', '', 'Current balance', 'رصيدي', 'Mijn balans', 'Mon solde', 'Mein Gleichgewicht', 'Il mio equilibrio', 'Meu saldo', 'Мой баланс', 'Mi balance', 'Bakiyem'),
(796, 'your_ref_link', '', 'Your affiliate link is', 'اللينك الخاص بك هو', 'Uw affiliate link is', 'Votre lien d&#39;affiliation est', 'Ihre Affiliate Link ist', 'Il tuo link:', 'Sua ligação da filial é', 'Ваша партнерская ссылка', 'Su red de afiliados es', 'Referans adresi'),
(797, 'your_balance', '', 'Your balance is ${balance}, minimum withdrawal request is ${m_withdrawal}', 'رصيدك هو ${balance}, الحد الأدنى لطلب السحب ${m_withdrawal}', 'Uw saldo is ${balance}, minimum een verzoek tot uitbetaling ${m_withdrawal}', 'Votre solde est ${balance}, demande de retrait minimum est ${m_withdrawal}', 'Ihre Waage ist ${balance}, minimum withdrawal request is ${m_withdrawal}', 'La bilancia è ${balance}, richiesta di prelievo minimo è ${m_withdrawal}', 'Seu saldo é de R ${balance} equilíbrio, o pedido de retirada mínima é de R ${m_withdrawal}', 'Ваш баланс составляет ${balance} баланс, минимальный запрос на вывод средств составляет ${m_withdrawal}', 'Su saldo es de ${balance} equilibrio, la solicitud de retiro mínimo es ${m_withdrawal}', 'Bakiyeniz ${balance}, minimum çekebileceğiniz tutar ${m_withdrawal}'),
(798, 'your_balance_is', '', 'Your balance is', 'رصيدك هو', 'Uw saldo is', 'Votre solde est', 'Ihre waage ist', 'La bilancia è', 'Seu saldo é', 'Ваш баланс', 'Su saldo es', 'Bakiyeniz'),
(799, 'paypal_email', '', 'PayPal email', 'أيميل البايبال الخاص بك', 'PayPal email', 'PayPal email', 'PayPal email', 'PayPal email', 'Email do Paypal', 'PayPal по электронной почте', 'E-mail de Paypal', 'PayPal e-posta adresi'),
(800, 'amount_usd', '', 'Amount (USD)', 'القيمة (دولار امريكي)', 'Bedrag (USD)', 'Montant (USD)', 'Menge (USD)', 'Quantità (USD)', 'Montante (USD)', 'Сумма (USD)', 'Monto (USD)', 'Tutar (USD)'),
(801, 'request_withdrawal', '', 'Request withdrawal', 'اسحب الرصيد', 'verzoek tot uitbetaling', 'Demande de retrait', 'Antrag rückzug', 'richiesta di prelievo', 'pedido de retirada', 'Запрос вывода', 'solicitud de retiro', 'Para çekme talebi'),
(802, 'payment_history', '', 'Payment History', 'تاريخ الدفع', 'Betaalgeschiedenis', 'Historique de paiement', 'Zahlungshistorie', 'Storico dei pagamenti', 'Histórico de pagamento', 'История платежей', 'historial de pagos', 'Ödeme tarihi'),
(803, 'amount', '', 'Amount', 'القيمة', 'Bedrag', 'Montant', 'Menge', 'Quantità', 'Quantidade', 'Количество', 'Cantidad', 'Tutar'),
(804, 'declined', '', 'Declined', 'تم الرفض', 'Afgewezen', 'Refusée', 'Abgelehnt', 'Rifiutato', 'Recusado', 'Отклонено', 'disminuido', 'Reddedildi'),
(805, 'approved', '', 'Approved', 'م القبول', 'Aangenomen', 'A approuvé', 'Genehmigt', 'Approvato', 'aprovado', 'утвержденный', 'Aprobado', 'Onaylandı'),
(806, 'total_votes', '', 'Total votes', 'مجموع الأصوات', 'Totaal aantal stemmen', 'Des votes', 'Anzahl der Kundenbewertungen', 'Totale voti', 'total de votos', 'Всего голосов', 'Total de votos', 'Toplam oy'),
(807, 'mark_as_sold', '', 'Mark Product As Sold', 'تم بيع المنتج', 'Mark Product zoals verkocht', 'Marque produit vendu', 'Mark erhältliche Erzeugnis', 'Mark prodotto commerciale', 'Mark produto comercializado', 'Маркировка продукта Как Продано', 'Marca de producto comercializado', 'Satılan ürün'),
(808, 'added_new_product_for_sell', '', 'added new product for sell.', 'ضاف منتج جديد للبيع.', 'toegevoegd nieuw product voor verkoopt.', 'nouveau produit ajouté pour vendre.', 'hinzugefügt neues Produkt zu verkaufen.', 'nuovo prodotto aggiunto per vendere.', 'adicionou novo produto para vender.', 'добавлен новый продукт для продажи.', 'añadido nuevo producto para la venta.', 'Yeni ürün satış için eklendi'),
(809, 'product_name', '', 'Product Name', 'اسم المنتج', 'productnaam', 'Nom du produit', 'Produktname', 'nome del prodotto', 'Nome do Produto', 'наименование товара', 'nombre del producto', 'Ürün adı'),
(810, 'in_stock', '', 'In stock', 'متاح', 'Op voorraad', 'en magasin', 'Auf Lager', 'Disponibile', 'Em estoque', 'В наличии', 'En stock', 'Stokda kaç adet var'),
(811, 'sold', '', 'Sold', 'تم البيع', 'Uitverkocht', 'Vendu', 'Verkauft', 'Venduto', 'Vendido', 'Продан', 'Vendido', 'Satılan'),
(812, 'answer', '', 'Answer', 'الجواب', 'Antwoord', 'Répondre', 'Antworten', 'Risposta', 'Responda', 'Ответ', 'Responder', 'Cevap'),
(813, 'add_answer', '', 'Add answer', 'إضافة جواب', 'Antwoord toevoegen', 'Ajouter une réponse', 'In Antwort', 'Aggiungi risposta', 'Adicionar resposta', 'Добавить ответ', 'Añadir respuesta', 'Cevap ekle'),
(814, 'authenticating', '', 'Authenticating', 'جاري تدقيق المعلومات', 'Authentiserende', 'Authentifier', 'Authentifizieren', 'autenticazione', 'autenticação', 'удостовер', 'de autenticación', 'Kimlik doğrulama'),
(815, 'welcome_back', '', 'Welcome back!', 'أهلا بك!', 'Welkom terug!', 'Nous saluons le retour!', 'Willkommen zurück!', 'Ben tornato!', 'Bem vindo de volta!', 'Добро пожаловать!', '¡Dar una buena acogida!', 'Tekrar hoşgeldiniz!'),
(816, 'welcome_', '', 'Welcome!', 'أهلا بك!', 'Welkom!', 'Bienvenue!', 'Willkommen!', 'Benvenuto!', 'Bem vinda!', 'Добро пожаловать!', '¡Bienvenido!', 'Hoşgediniz!'),
(817, 'connect_with_people', '', 'Connect with people.', 'تواصل مع الناس.', 'Contact maken met mensen.', 'Communiquer avec les gens.', 'Verbinden Sie sich mit Menschen.', 'Connettiti con persone.', 'Conectar com as pessoas.', 'Общайтесь с людьми.', 'Conectar con la gente.', 'İnsanlarla sürekli bağlantıda ol.'),
(818, 'make_new_friends', '', 'Make new friends.', 'كون صداقات جديدة.', 'Maak nieuwe vrienden.', 'Se faire de nouveaux amis.', 'Neue Freunde finden.', 'Fare nuovi amici.', 'Fazer novos amigos.', 'Завести новых друзей.', 'Hacer nuevos amigos.', 'Yeni arkadaşlar edin.'),
(819, 'share_your_memories', '', 'Share your memories.', 'شارك ذكرياتك.', 'Deel je herinneringen.', 'Partagez vos souvenirs.', 'Teilen Sie Ihre Erinnerungen.', 'Condividi i tuoi ricordi.', 'Partilhar as suas memórias.', 'Поделитесь своими воспоминаниями.', 'Compartir sus recuerdos.', 'Anılarını paylaş.'),
(820, 'create_new_relationships', '', 'Create new relationships.', 'أنشىء علاقات جديدة.', 'Maak nieuwe relaties.', 'Créer de nouvelles relations.', 'Erstellen Sie neue Beziehungen.', 'Crea nuove relazioni.', 'Criar novos relacionamentos.', 'Создание новых отношений.', 'Crear nuevas relaciones.', 'Yeni bir ilişki oluştur.'),
(821, 'discover_new_places', '', 'Discover new places.', 'إكتشف أماكن جديدة.', 'Ontdek nieuwe plaatsen.', 'Découvrez de nouveaux endroits.', 'Entdecken Sie neue Orte.', 'Scoprire posti nuovi.', 'Descubra novos lugares.', 'Откройте для себя новые места.', 'Descubrir nuevos lugares.', 'Yeni yerler keşfet.'),
(822, 'forgot_your_password', '', 'Forgot your password?', 'هل نسيت كلمة المرور?', 'Je wachtwoord vergeten?', 'Mot de passe oublié?', 'Haben Sie Ihr Passwort vergessen', 'Hai dimenticato la password?', 'Esqueceu sua senha?', 'Забыли пароль?', '¿Olvidaste tu contraseña?', 'Şifreni mi unuttun?'),
(823, 'invalid_markup', '', 'Invalid markup, please try to reset your password again', 'العلامة غير صالحة، يرجى المحاولة لإعادة تعيين كلمة المرور الخاصة بك مرة أخرى', 'Ongeldige markup, dan kunt u proberen om uw wachtwoord opnieuw in te resetten', 'balisage non valide, s&#39;il vous plaît essayez de réinitialiser votre mot de passe', 'Ungültige Markup, versuchen Sie Ihr Passwort wieder zurücksetzen', 'markup non valido, provare a reimpostare nuovamente la password', 'marcação inválida, por favor, tente redefinir sua senha novamente', 'Недопустимая разметка, пожалуйста, попробуйте сбросить пароль еще раз', 'marcado no válido, intenta restablecer la contraseña de nuevo', 'Geçersiz karakter kullandınız lütfen tekrar deneyin.'),
(824, 'go_back', '', 'Go back', 'الرجوع', 'Go back', 'Go back', 'Geh zurück', 'Go back', 'Volte', 'Возвращаться', 'Regresa', 'Geri git'),
(825, 'terms_agreement', '', 'By creating your account, you agree to our', 'قبل إنشاء الحساب الخاص بك، فإنك توافق على', 'Door het maken van uw account, gaat u akkoord met onze', 'En créant votre compte, vous acceptez nos', 'Durch die Erstellung Ihres Kontos stimmen Sie unseren', 'Creando il tuo account, accettate la nostra', 'Ao criar sua conta, você concorda com a nossa', 'При создании учетной записи, вы согласны с нашими', 'Al crear su cuenta, usted está de acuerdo con nuestra', 'Hesabınızı oluşturduğunuzda gizlilik şartlarımızı kabul etmiş sayılırsınız.'),
(826, 'please_choose_price', '', 'Please choose a price for your product', 'الرجاء اختيار سعر المنتج الخاص بك', 'Kies een prijs voor uw product', 'S&#39;il vous plaît choisir un prix pour votre produit', 'Bitte wählen Sie einen Preis für Ihr Produkt', 'Scegliere un prezzo per il prodotto', 'Por favor, escolha um preço para seu produto', 'Пожалуйста, выберите цену для вашего продукта', 'Por favor, elija un precio para su producto', 'Lütfen dürtmek için bir fiyat seçiniz'),
(827, 'please_choose_c_price', '', 'Please choose a correct value for your price', 'الرجاء اختيار القيمة الصحيحة للسعر الخاص بك', 'Kies een juiste waarde voor uw prijs', 'S&#39;il vous plaît choisir une valeur correcte pour votre prix', 'Bitte wählen Sie einen korrekten Wert für Ihr Preis', 'Scegliere un valore corretto per il vostro prezzo', 'Por favor, escolha um valor correto para o seu preço', 'Пожалуйста, выберите правильное значение для вашей цене', 'Por favor, elija un valor correcto para el precio', 'Lütfen fiyatı güncellerken bir değer giriniz'),
(828, 'please_upload_image', '', 'Please upload at least 1 photo', 'يرجى تحميل صورة واحد كحد ادنى', 'Upload ten minste 1 foto', 'S&#39;il vous plaît télécharger au moins 1 photo', 'Bitte laden Sie mindestens 1 Foto', 'Carica almeno 1 foto', 'Faça o upload de pelo menos 1 foto', 'Пожалуйста, загрузите по крайней мере 1 фото', 'Sube al menos 1 foto', 'Lütfen en az bir fotoğraf yükleyin'),
(829, 'you_have_already_voted', '', 'You have already voted this poll.', 'لقد قمت بالتصويت بالفعل لهذا الإستطلاع.', 'Je hebt al deze poll gestemd.', 'Vous avez déjà voté ce sondage.', 'Sie haben bereits abgestimmt diese Umfrage.', 'Hai già votato questo sondaggio.', 'Você já votou nesta enquete.', 'Вы уже голосовали этот опрос.', 'Ya ha votado esta encuesta.', 'Zaten bu ankete oy kullandın'),
(830, 'you_have_pending_request', '', 'You have already a pending request.', 'لديك بالفعل طلب معلق.', 'U heeft al een aanvraag in behandeling.', 'Vous avez déjà une demande en attente.', 'Sie haben bereits eine ausstehende Anforderung.', 'Hai già una richiesta in sospeso.', 'Você já tem um pedido pendente.', 'У вас есть уже отложенный запрос.', 'Ya tiene una solicitud pendiente.', 'Bekleyen bir isteğin var'),
(831, 'invalid_amount_value', '', 'Invalid amount value', 'قيمة غير صالحة', 'Ongeldig bedrag waarde', 'valeur de quantité non valide', 'Ungültige Betragswert', 'valore di importo non valido', 'valor montante inválido', 'Неверное значение суммы', 'valor de la cantidad no válida', 'Geçersiz bir miktar yazdın');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(832, 'invalid_amount_value_your', '', 'Invalid amount value, your amount is:', 'قيمة غير صالحة, رصيدك هو:', 'Ongeldig bedrag waarde, uw bedrag is:', 'Valeur de quantité non valide, le montant est:', 'Ungültige Menge Wert, Ihre Menge ist:', 'valore di importo non valido, l&#039;importo è:', 'valor montante inválido, o valor é:', 'Неверное значение суммы, ваша сумма:', 'valor de la cantidad no válida, su cantidad es:', 'Geçersiz bir miktar yazdınız, bu tutar geöerli değildir:'),
(833, 'invalid_amount_value_withdrawal', '', 'Invalid amount value, minimum withdrawal request is:', 'قيمة غير صالحة, الحد الأدنى لطلب السحب:', 'Ongeldig bedrag waarde, minimum een verzoek tot uitbetaling:', 'valeur de quantité non valide, demande de retrait minimum est de:', 'Ungültige Betragswert , mindestauszahlungs anforderung ist:', 'Invalid amount value, minimum withdrawal request is:', 'valor montante inválido, o pedido de retirada mínima é:', 'Неверное значение суммы, минимальный запрос на вывод средств является:', 'valor de la cantidad no válida, la solicitud de retiro mínimo es:', 'Geçersiz tutar yazdınız minimum para çekme talebi:'),
(834, 'you_request_sent', '', 'Your request has been sent, you&#039;ll receive an email regarding the payment details soon.', 'تم إرسال طلبك، سوف تتلقى رسالة بريد إلكتروني حول تفاصيل المبلغ في وقت قريب.', 'Uw aanvraag is verzonden, zult u een e-mail met betrekking tot de betalingsgegevens binnenkort.', 'Votre demande a été envoyée, vous recevrez un e-mail concernant les détails de paiement bientôt.', 'Ihre Anfrage gesendet wurde, erhalten Sie eine E-Mail in Bezug auf die Zahlungsdetails erhalten bald.', 'La vostra richiesta è stata inviata, riceverai una e-mail per quanto riguarda i dati di pagamento al più presto.', 'O seu pedido foi enviado, você receberá um e-mail sobre os detalhes de pagamento em breve.', 'Ваш запрос был отправлен, вы получите по электронной почте о деталях платежа в ближайшее время.', 'Su solicitud ha sido enviado, recibirá un correo electrónico con respecto a los datos de pago pronto.', 'Para çekme isteğiniz başarı bir şekilde bize ulaştı yakında bununla ilgili bir e-posta göndereceğiz.'),
(835, 'turn_off_notification', '', 'Turn off notification sound', 'إيقاف صوت الإعلام', 'Schakel meldingsgeluid', 'Désactiver la notification sonore', 'Schalten Sie eine Benachrichtigung Sound', 'Disattiva suono di notifica', 'Desligar o som de notificação', 'Выключите звук уведомления', 'Desactivar el sonido de notificación', 'Bildirim sesini kapat'),
(836, 'turn_on_notification', '', 'Turn on notification sound', 'تشغيل صوت الإعلام', 'Zet meldingsgeluid', 'Activer la notification sonore', 'Schalten Sie eine Benachrichtigung Sound', 'Accendere il suono di notifica', 'Ligar som de notificação', 'Включите звук уведомления', 'Activar el sonido de notificación', 'Bildirim sesini aç'),
(837, 'view_more_posts', '', 'View {count} new posts', 'إظهار {count} منشور جديد', 'Uitzicht {count} nieuwe berichten', 'Vue {count} de nouveaux messages', 'Aussicht {count} neuen beiträge', 'Vista {count} nuovo messaggio', 'Veja {count} novas mensagens', 'Просмотр {count} новых сообщений', 'Ver {count} mensajes nuevos', 'Yeni mesajları görüntüle {count}'),
(838, 'store_posts_by', '', 'Store posts by', 'صنف المنشورات', 'Store berichten van', 'postes de magasins par', 'Zeige Beiträge', 'Visualizza i messaggi di', 'mensagens de loja por', 'Магазин сообщения от', 'almacenar mensajes de', 'Mağazada paylaşan'),
(839, 'new_audio_call', '', 'New audio call', 'إتصال جديد', 'Nieuwe audiogesprek', 'Nouveau appel audio', 'Neuer Audioanruf', 'Nuova chiamata audio', 'Nova chamada de áudio', 'Новый аудио вызов', 'Nueva llamada de audio', 'Yeni sesli çağrı'),
(840, 'new_audio_call_desc', '', 'wants to talk with you.', 'يريد التحدث معك.', 'wil met je praten.', 'Veut parler avec vous', 'Möchte mit Ihnen sprechen.', 'vuole parlare con te.', 'Quer falar com você', 'хочет поговорить с вами.', 'Quiere hablar contigo', 'Seninle konuşmak istiyor.'),
(841, 'audio_call', '', 'Audio call', 'مكالمة صوتية', 'audio oproep', 'Appel audio', 'Audioanruf', 'chiamata audio', 'Chamada de áudio', 'Аудиовызов', 'llamada de audio', 'Sesli arama'),
(842, 'audio_call_desc', '', 'talking with', 'يتحدث مع', 'praten met', 'parler avec', 'sprechen mit', 'parlando con', 'conversando com', 'говорить с', 'Hablando con', 'ile konuşmak'),
(843, 'market', '', 'Market', 'السوق', 'Markt', 'Marché', 'Markt', 'Mercato', 'Mercado', 'рынок', 'Mercado', 'Piyasa'),
(844, 'comment_post_label', '', 'Comment', 'علق', 'Kommentar', 'Commentaire', 'Kommentar', 'Commento', 'Comentario', 'Комментарий', 'Comentario', 'Yorum Yap'),
(846, 'by', '', 'By', 'بواسطة', 'Door', 'Par', 'Durch', 'Di', 'De', 'От', 'Por', 'Tarafından'),
(847, 'load_more_blogs', '', 'Load more articles', 'تحميل المزيد من المقالات', 'Laad meer artikelen', NULL, 'Laden Sie weitere Artikel', 'Carica altri articoli', 'Carregar mais artigos', 'Загрузить другие статьи', 'Cargar más artículos', 'Daha fazla makale yükle'),
(848, 'blog', '', 'Blog', 'مدونة', 'blog', 'Blog', 'Blog', 'blog', 'Blog', 'Блог', 'Blog', 'Blog'),
(849, 'no_blogs_found', '', 'No articles found', 'لم يتم العثور على أية مقالات', 'Geen artikelen gevonden', 'Aucun article trouvé', 'Keine Artikel gefunden', 'Nessun articolo trovato', 'Nenhum artigo encontrado', 'Статьи не найдены', 'No se encontraron artículos', 'Makale bulunamadı'),
(850, 'most_recent_art', '', 'Most recent articles', 'أحدث المقالات', 'Meest recente artikelen', 'Articles les plus récents', 'Die neuesten Artikel', 'Articoli più recenti', 'Artigos mais recentes', 'Последние статьи', 'Artículos más recientes', 'En yeni makaleler'),
(851, 'create_new_article', '', 'Create new article', 'إنشاء مقالة جديدة', 'Nieuwe artikel', 'Créer un nouvel article', 'Erstellen Sie einen neuen Artikel', 'Crea un nuovo articolo', 'Criar novo artigo', 'Создать новую статью', 'Crear un nuevo artículo', 'Yeni makale oluştur'),
(852, 'my_articles', '', 'My articles', 'مقالاتي', 'mijn artikelen', 'Mes articles', 'Meine Artikel', 'I miei articoli', 'Meus artigos', 'Мои статьи', 'Mis artículos', 'Makalelerim'),
(853, 'title', '', 'Title', 'عنوان', 'Titel', 'Titre', 'Titel', 'Titolo', 'Título', 'заглавие', 'Título', 'Başlık'),
(854, 'content', '', 'Content', 'يحتوى', 'Inhoud', 'Contenu', 'Inhalt', 'Soddisfare', 'Conteúdo', 'Содержание', 'Contenido', 'İçerik'),
(855, 'select', '', 'Select', 'تحديد', 'kiezen', 'Sélectionner', 'Wählen', 'Selezionare', 'Selecionar', 'Выбрать', 'Seleccionar', 'Seç'),
(856, 'tags', '', 'Tags', 'العلامات', 'Tags', 'Mots clés', 'Tags', 'tag', 'Tag', 'Теги', 'Etiquetas', 'Etiketler'),
(857, 'thumbnail', '', 'Thumbnail', 'صورة مصغرة', 'thumbnail', 'La vignette', 'Miniaturansicht', 'Thumbnail', 'Miniatura', 'Значок видео', 'Miniatura', 'Küçük resim'),
(858, 'published', '', 'Published', 'نشرت', 'Gepubliceerd', 'Publié', 'Veröffentlicht', 'Pubblicato', 'Publicados', 'Опубликовано', 'Publicado', 'Yayınlanan'),
(860, 'article_updated', '', 'Your article has been successfully updated', 'تم تحديث مقالتك بنجاح', 'Uw artikel is bijgewerkt', 'Votre article a été mis à jour avec succès', 'Ihr Artikel wurde erfolgreich aktualisiert', 'Il tuo articolo è stato aggiornato con successo', 'Seu artigo foi atualizado com sucesso', 'Ваша статья успешно обновлена', 'Su artículo ha sido actualizado con éxito', 'Makaleniz başarıyla güncellendi'),
(861, 'article_added', '', 'Your article has been successfully added', 'تمت إضافة مقالتك بنجاح', 'Uw artikel is succesvol toegevoegd', 'Votre article a été ajouté avec succès', 'Ihr Artikel wurde erfolgreich hinzugefügt', 'Il tuo articolo è stato aggiunto', 'Seu artigo foi adicionado com êxito', 'Ваша статья успешно добавлена', 'Su artículo ha sido añadido correctamente', 'Makalen başarıyla eklendi'),
(862, 'title_more_than10', '', 'Title should be more than 10 characters', 'يجب أن يكون العنوان أكثر من 10 أحرف', 'Titel moet meer zijn dan 10 tekens', 'Le titre doit comporter plus de 10 caractères', 'Titel sollte mehr als 10 Zeichen sein', 'Il titolo dovrebbe essere più di 10 caratteri', 'O título deve ter mais de 10 caracteres', 'Заголовок должен содержать более 10 символов.', 'El título debe tener más de 10 caracteres', 'Başlık en fazla 10 karakter olmalıdır'),
(863, 'desc_more_than32', '', 'Description should be more than 32 characters', 'يجب أن يكون الوصف أكثر من 32 حرفا', 'Beschrijving moet meer zijn dan 32 tekens', 'La description doit comporter plus de 32 caractères', 'Beschreibung sollte mehr als 32 Zeichen sein', 'Descrizione dovrebbe essere più di 32 caratteri', 'A descrição deve ter mais de 32 caracteres', 'Описание должно содержать более 32 символов.', 'La descripción debe tener más de 32 caracteres', 'Açıklama 32 karakterden uzun olmalı'),
(864, 'please_fill_tags', '', 'Please fill the tags field', 'يرجى ملء حقل العلامات', 'Vul het veld labels', 'Remplissez le champ tags', 'Bitte füllen Sie das Etikettenfeld aus', 'Si prega di compilare il campo tag', 'Preencha o campo de tags', 'Пожалуйста, заполните поле тегов', 'Por favor rellene el campo de etiquetas', 'Lütfen etiketler alanını doldurun'),
(865, 'error_found', '', 'Error found, please try again later', 'حدث خطأ، يرجى إعادة المحاولة لاحقا', 'Fout gevonden, probeer het later opnieuw', 'Une erreur a été trouvée, réessayez plus tard', 'Fehler gefunden, bitte später nochmal versuchen', 'Errore trovato, si prega di riprovare più tardi', 'Ocorreu um erro, tente novamente mais tarde', 'Ошибка найдена. Повторите попытку позже.', 'Error encontrado. Vuelve a intentarlo más tarde.', 'Hata bulundu, lütfen daha sonra tekrar deneyin.'),
(866, 'posted_on_blog', '', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'نشر {BLOG_TIME} في {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Posted {BLOG_TIME} in {CATEGORY_NAME}.', 'Yayınlanan {BLOG_TIME} {CATEGORY_NAME} da.'),
(867, 'created_new_blog', '', 'created a new article', 'إنشاء مقالة جديدة', 'creëerde nieuwe artikel', 'Nouvel article créé', 'Erstellt neuen Artikel', 'nuovo articolo creato', 'Criou um novo artigo', 'Создал новую статью', 'Creó nuevo artículo', 'Yeni makale yazdı'),
(868, 'forum', '', 'Forum', 'منتدى', 'Forum', 'Forum', 'Forum', 'Forum', 'Fórum', 'Форум', 'Foro', 'forum'),
(870, 'last_post', '', 'Last Post', 'آخر مشاركة', 'Laatste bericht', 'Dernier commentaire', 'Letzter Beitrag', 'Ultimo messaggio', 'Última postagem', 'Последний пост', 'Ultima publicación', 'Son Posta'),
(871, 'topic', '', 'topic', 'موضوع', 'onderwerp', 'sujet', 'Thema', 'argomento', 'tema', 'тема', 'tema', 'konu'),
(872, 'thread_search', '', 'Threads search', 'بحث المواضي ', 'Zoek naar discussies', 'Recherche de threads', 'Threads suchen', 'Ricerca di thread', 'Pesquisa de Threads', 'Поиск по темам', 'Búsqueda de hilos', 'Konular arama'),
(873, 'create_new_topic', '', 'Create new topic', 'إنشاء موضوع جديد ', 'Maak een nieuw onderwerp aan', 'Créer un nouveau sujet', 'Neues Thema erstellen', 'Crea nuovo argomento', 'Criar novo tópico', 'Создать новую тему', 'Crear nuevo tema', 'Yeni konu oluştur'),
(874, 'jump_to', '', 'Jump to', 'انتقل الى ', 'Spring naar', 'Sauter à', 'Springen zu', 'Salta a', 'Pule para', 'Перейти к', 'Salta a', 'Atlamak'),
(875, 'my_threads', '', 'My Threads', 'المواضيع ', 'Mijn draden', 'Mes fils', 'Meine Fäden', 'I miei fili', 'Meus tópicos', 'Мои темы', 'Mis hilos', 'Konuları ekle'),
(876, 'my_messages', '', 'My Messages', 'رسائلي ', 'Mijn berichten', 'Mes messages', 'Meine Nachrichten', 'I miei messaggi', 'Minhas mensagens', 'Мои сообщения', 'Mis mensajes', 'Mesajlarım'),
(877, 'headline', '', 'Headline', 'العنوان ', 'opschrift', 'Gros titre', 'Überschrift', 'Titolo', 'Título', 'Заголовок', 'Titular', 'manşet'),
(878, 'your_post', '', 'Your post', 'منشورك ', 'Uw bericht', 'Votre publication', 'Deine Post', 'Il tuo post', 'Sua postagem', 'Ваше сообщение', 'Tu mensaje', 'Senin gönderin'),
(879, 'reply', '', 'Reply', 'الرد ', 'Antwoord', 'Répondre', 'Antworten', 'rispondere', 'Resposta', 'Ответить', 'Respuesta', 'cevap'),
(880, 'started_by', '', 'Started by', 'بدأ ب ', 'Begonnen door', 'Commencé par', 'Angefangen von', 'Iniziato da', 'Começado por', 'Начато', 'Comenzado por', 'Başlatan'),
(881, 'site_admin', '', 'Site Admin', 'مسؤول الموقع ', 'Site Admin', 'Administrateur du site', 'Site Admin', 'Amministrazione del sito', 'Administrador do Site', 'Администратор сайта', 'Administrador del sitio', 'Site Yöneticisi'),
(882, 'registered', '', 'Registered', 'مسجل ', 'Geregistreerd', 'Inscrit', 'Eingetragen', 'Registrato', 'Registrado', 'зарегистрированный', 'Registrado', 'Kayıtlı'),
(884, 'reply_to_topic', '', 'Reply to this topic', 'الرد على هذا الموضوع ', 'Antwoord op dit onderwerp', 'Répondre à ce sujet', 'Antwort auf dieses Thema', 'Rispondi a questo argomento', 'Responder a este tópico', 'Ответить в эту тему Открыть новую тему', 'Responder a este tema', 'Bu konuyu cevapla'),
(885, 'topic_review', '', 'Topic review', 'مراجعة الموضوع ', 'Onderwerp review', 'Examen de sujet', 'Thema Bewertung', 'Revisione degli argomenti', 'Revisão do tópico', 'Обзор темы', 'Revisión de temas', 'Konu incelemesi'),
(886, 'your_reply', '', 'Your Reply', 'ردك ', 'Uw reactie', 'Votre réponse', 'Deine Antwort', 'La tua risposta', 'Sua resposta', 'Ваш ответ', 'Tu respuesta', 'Cevabınızı'),
(887, 'list_of_users', '', 'List of users', 'قائمة المستخدمين ', 'Lijst van gebruikers', 'Liste des utilisateurs', 'Liste der Benutzer', 'Elenco degli utenti', 'Lista de usuários', 'Список пользователей', 'Lista de usuarios', 'Kullanıcı listesi'),
(888, 'post_count', '', 'Posts count', 'عدد المشاركات ', 'Berichten tellen', 'Nombre de postes', 'Beiträge zählen', 'I numeri contano', 'Posts count', 'Количество сообщений', 'Los posts cuentan', 'Mesaj sayısı'),
(889, 'referrals', '', 'Referrals', 'الإحالات ', 'Verwijzingen', 'Renvois', 'Verweise', 'Referenti', 'Referências', 'Переходов', 'Referencias', 'Tavsiye'),
(890, 'last_visit', '', 'Last visit', 'الزيارة الأخيرة ', 'Laatste bezoek', 'Derniere visite', 'Letzter Besuch', 'Lultima visita', 'Ultima visita', 'Последнее посещение', 'Última visita', 'Son ziyaret'),
(891, 'general_search_terms', '', 'General search terms', 'عبارات البحث العامة ', 'Algemene zoektermen', 'Conditions générales de recherche', 'Allgemeine Suchbegriffe', 'Termini di ricerca generali', 'Termos gerais de pesquisa', 'Общие условия поиска', 'Términos generales de búsqueda', 'Genel arama terimleri'),
(892, 'search_for_term', '', 'Search for term', 'البحث عن مصطلح ', 'Zoek naar term', 'Rechercher un terme', 'Suche nach Begriff', 'Cerca termine', 'Pesquisar termo', 'Поиск термина', 'Buscar término', 'Terimi ara'),
(893, 'search_in', '', 'Search in', 'بحث في ', 'Zoek in', 'Rechercher dans', 'Suchen in', 'Cerca nel', 'Procure em', 'Поиск в', 'Busca en', 'Araştır'),
(894, 'search_in_forums', '', 'Search Forums', 'البحث في المنتديات ', 'Zoeken in forums', 'Rechercher dans les forums', 'Foren durchsuchen', 'Cerca i forum', 'Pesquisar Fóruns', 'Поиск по форуму Главная страница форума Форум', 'Buscar en los foros', 'Forumlarda Ara'),
(895, 'search_in_threads', '', 'Search in threads', 'البحث في المواضيع ', 'Zoek in discussies', 'Rechercher dans les discussions', 'Suche in Threads', 'Cerca nei thread', 'Pesquisar nos tópicos', 'Искать в темах', 'Buscar en temas', 'Konuları ara'),
(896, 'search_in_messages', '', 'Search in messages', 'البحث في الرسائل ', 'Zoek in berichten', 'Rechercher dans les messages', 'Suche in Nachrichten', 'Cerca nei messaggi', 'Pesquisar em mensagens', 'Искать в сообщениях', 'Buscar en mensajes', 'Mesajlarda ara'),
(897, 'search_subject_only', '', 'Search subject only', 'موضوع البحث فقط ', 'Zoek alleen onderwerp', 'Rechercher uniquement sur le sujet', 'Nur Suchbegriff suchen', 'Cerca solo il soggetto', 'Procurar somente assunto', 'Только поиск', 'Solo tema de búsqueda', 'Sadece konu ara'),
(898, 'threads', '', 'threads', 'الخيوط ', 'threads', 'Fils', 'Fäden', 'fili', 'tópicos', 'потоки', 'trapos', 'ipler'),
(900, 'posted', '', 'Posted', 'تم النشر ', 'Geplaatst', 'Publié', 'Gesendet', 'Pubblicato', 'Postou', 'Сообщение', 'Al corriente', 'Gönderildi'),
(901, 'no_forums_found', '', 'No forums to show', 'لم يتم العثور على منتديات ', 'Geen forums gevonden', 'Aucun forum trouvé', 'Keine Foren gefunden', 'Nessun forum trovato', 'Nenhum fórum encontrado', 'Форум не найден', 'No se encontraron foros', 'Hiçbir forum bulunamadı'),
(902, 'never', '', 'Never', 'أبدا ', 'Nooit', 'Jamais', 'Nie', 'Mai', 'Nunca', 'Никогда', 'Nunca', 'Asla'),
(903, 'no_replies_found', '', 'No replies to show', 'لم يتم العثور على أية ردود ', 'Geen antwoorden gevonden', 'Aucune réponse trouvée', 'Keine Antworten gefunden', 'Nessuna risposta trovata', 'Nenhuma resposta encontrada', 'Нет ответов', 'No se encontraron respuestas', 'Yanıt bulunamadı'),
(904, 'no_threads_found', '', 'No threads to show', 'لم يتم العثور على سلاسل محادثات ', 'Geen discussies gevonden', 'Aucun sujet trouvé', 'Keine Fäden gefunden', 'Non sono stati trovati thread', 'Nenhum tópico encontrado', 'Темы не найдены', 'No se encontraron hilos', 'Konu bulunamadı'),
(906, 'no_sections_found', '', 'No sections to show', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(907, 'wrote', '', 'wrote', 'كتب ', 'schreef', 'a écrit', 'schrieb', 'ha scritto', 'escrevi', 'писал', 'Escribió', 'yazdı'),
(909, 'edit_topic', '', 'Edit topic', 'تعديل الموضوع ', 'Bewerk onderwerp', 'Modifier le sujet', 'Thema bearbeiten', 'Modifica argomento', 'Editar tópico', 'Изменить тему', 'Editar tema', 'Konuyu düzenle'),
(910, 'reply_saved', '', 'Your reply was successfully saved', 'تم حفظ ردك بنجاح ', 'Uw antwoord is succesvol opgeslagen', 'Votre réponse a été enregistrée avec succès', 'Ihre Antwort wurde erfolgreich gespeichert', 'La tua risposta è stata salvata correttamente', 'Sua resposta foi salva com êxito', 'Ваш ответ был успешно сохранен', 'Tu respuesta se ha guardado correctamente.', 'Yanıtınız başarıyla kaydedildi'),
(911, 'reply_added', '', 'Your reply was successfully added', 'تمت إضافة ردك بنجاح', 'Je antwoord is succesvol toegevoegd', 'Votre réponse a été ajoutée avec succès', 'Ihre Antwort wurde erfolgreich hinzugefügt', 'La tua risposta è stata aggiunta con successo', 'Sua resposta foi adicionada com êxito', 'Ваш ответ был успешно добавлен', 'Tu respuesta se ha agregado correctamente.', 'Yanıtınız başarıyla eklendi'),
(912, 'forum_post_added', '', 'Your forum has been successfully added', 'تمت إضافة مشاركة المنتدى بنجاح ', 'Uw forum is succesvol toegevoegd', 'Votre forum a été ajouté avec succès', 'Dein Forum wurde erfolgreich hinzugefügt', 'Il tuo forum è stato aggiunto con successo', 'Seu fórum foi adicionado com sucesso', 'Ваш форум успешно добавлен', 'Tu foro se ha agregado correctamente', 'Forumunuz başarıyla eklendi'),
(914, 'help', '', 'Help', 'مساعدة ', 'Helpen', 'Aidez-moi', 'Hilfe', 'Aiuto', 'Socorro', 'Помощь', 'Ayuda', 'yardım et'),
(915, 'search_terms_more4', '', 'Type in one or more search terms, each must be at least 4 characters', 'اكتب عبارة بحث واحدة أو أكثر، ويجب ألا يقل عدد الأحرف عن 4 أحرف ', 'Typ één of meer zoektermen, ieder moet minstens 4 karakters', 'Tapez un ou plusieurs termes de recherche, chacun doit être dau moins 4 caractères', 'Geben Sie einen oder mehrere Suchbegriffe ein, die jeweils muss mindestens 4 Zeichen lang sein', 'Geben Sie einen oder mehrere Suchbegriffe ein, die jeweils muss mindestens 4 Zeichen lang sein', 'Digite um ou mais termos de pesquisa, cada um deve ter pelo menos 4 caracteres', 'Введите одно или несколько поисковых терминов, каждый из них должен быть не менее 4-х символов', 'Tipo de uno o más términos de búsqueda, cada uno debe tener al menos 4 caracteres', 'Bir veya daha fazla arama terimi girin, her En Az 4 karakter olmalıdır'),
(916, 'events', '', 'Events', 'أحداث', 'Evenementen', 'Événements', 'Veranstaltungen', 'eventi', 'Eventos', 'Мероприятия', 'Eventos', 'Olaylar'),
(917, 'going', '', 'Going', 'ذاهب', 'gaand', 'Aller', 'Gehen', 'Andando', 'Indo', 'Пойду', 'Yendo', 'gidiş'),
(918, 'interested', '', 'Interested', 'يستفد', 'Geïnteresseerd', 'Intéressé', 'Interessiert', 'Interessato', 'Interessado', 'интересное', 'Interesado', 'ilgili'),
(919, 'past', '', 'Pastor', 'الماضي', 'Verleden', 'Passé', 'Vergangenheit', 'Passato', 'Passado', 'прошлые', 'Pasado', 'geçmiş'),
(920, 'invited', '', 'invited', 'دعوة', 'Uitgenodigd', 'Invité', 'Eingeladen', 'Invitato', 'Convidamos', 'приглашенни', 'Invitado', 'Davetli'),
(921, 'you_are_going', '', 'You are going', 'انت ذاهب', 'Jij gaat', 'Vous allez', 'Du gehst', 'Stai andando', 'Você está indo', 'Вы собираетесь', 'Usted va', 'Gidiyorsun'),
(922, 'you_are_interested', '', 'You are interested', 'كنت مهتما', 'Je bent geïnteresseerd', 'Tu es intéressé', 'Sie sind interessiert', 'Sei interessato', 'Você está interessado', 'Вы заинтересованы', 'Tú estás interesado', 'İlgilisin'),
(923, 'start_date', '', 'Start date', 'تاريخ البدء', 'Begin datum', 'Date de début', 'Anfangsdatum', 'Data dinizio', 'Data de início', 'Дата начала', 'Fecha de inicio', 'Başlangıç tarihi'),
(924, 'end_date', '', 'End date', 'تاريخ الانتهاء', 'Einddatum', 'Date de fin', 'Enddatum', 'Data di fine', 'Data final', 'Дата окончания', 'Fecha final', 'Bitiş tarihi'),
(926, 'event', '', 'Event', 'هدف', 'Evenement', 'un événement', 'Event', 'Evento', 'Evento', 'Мероприятие', 'Evento', 'Olay'),
(927, 'no_events_found', '', 'No events to show', 'لم يتم العثور على أية أحداث', 'Geen evenementen gevonden', 'Aucun événement trouvé', 'Keine Veranstaltungen gefunden', 'Nessun evento trovato', 'Nenhum evento encontrado', 'События не найдены', 'No se han encontrado eventos', 'Etkinlik bulunamadı'),
(928, 'event_you_may_like', '', 'Events you may like', 'الأحداث التي قد تعجبك', 'Evenementen die je misschien leuk vindt', 'Événements que vous aimeriez', 'Veranstaltungen, die Sie mögen können', 'Eventi che ti piacciono', 'Eventos que você pode gostar', 'Мероприятия, которые могут вам понравиться', 'Eventos que te pueden gustar', 'Beğeneceğiniz etkinlikler'),
(929, 'going_people', '', 'Going people', 'الذهاب الناس', 'Mensen gaan', 'Aller aux gens', 'Leute gehen', 'Andando gente', 'Indo as pessoas', 'Идущие люди', 'Personas que van', 'İnsanlara gidiyor'),
(930, 'interested_people', '', 'Interested people', 'الناس المهتمين', 'Geïnteresseerde mensen', 'Les personnes intéressées', 'Interessierte Leute', 'Persone interessate', 'Pessoas interessadas', 'Заинтересованные лица', 'Personas interesadas', 'İlgilenen insanlar'),
(931, 'invited_people', '', 'Invited people', 'الأشخاص المدعوون', 'Uitgenodigde mensen', 'Personnes invitées', 'Eingeladene Leute', 'Persone invitate', 'Pessoas convidadas', 'Приглашенные люди', 'Personas invitadas', 'Davet edilenler'),
(932, 'event_added', '', 'Your event was successfully added', 'تمت إضافة هذا الحدث الخاص بك بنجاح', 'Uw evenement is toegevoegd', 'Votre événement a été ajouté avec succès', 'Ihre Veranstaltung wurde erfolgreich hinzugefügt', 'Il vostro evento è stato aggiunto', 'Seu evento foi adicionado com sucesso', 'Ваше мероприятие успешно добавлено', 'Su caso se ha añadido con éxito', 'Etkinliğiniz başarıyla eklendi'),
(933, 'event_saved', '', 'Your event was successfully saved.', 'تم حفظ هذا الحدث الخاص بك', 'Uw evenement is opgeslagen', 'Votre événement a été enregistré', 'Ihre Veranstaltung wurde gespeichert', 'Il vostro evento è stato salvato', 'Seu evento foi salvo', 'Ваше мероприятие успешно сохранено', 'Su caso se ha guardado', 'Etkinlik kaydedildi'),
(934, 'confirm_delete_event', '', 'You are sure that you want to delete this event', 'كنت متأكدا من أنك تريد حذف هذا الحدث', 'Bent u zeker dat u wilt dit evenement verwijderen', 'Vous êtes sûr que vous voulez supprimer cet événement', 'Sie sind sicher, dass Sie dieses Ereignis löschen möchten', 'Sei sicuro di voler eliminare questo evento', 'Você tem certeza de que deseja excluir este evento', 'Вы уверены что Вы хотите удалить это событие', 'Está seguro de que desea eliminar este evento', 'Sen bu etkinliği silmek istediğinizden emin misiniz'),
(935, 'load_more', '', 'Load more', 'تحميل أكثر', 'Meer laden', 'Chargez plus', 'laden Sie mehr', 'caricare più', 'Coloque mais', 'Показать еще', 'Cargar más', 'daha fazla yükle'),
(936, 'subject', '', 'Subject', 'موضوع', 'Onderwerpen', 'Assujettir', 'Fach', 'Soggetto', 'Sujeito', 'Предмет', 'Tema', 'konu'),
(937, 'go', '', 'Go', 'اذهب', 'Gaan', 'Aller', 'Gehen', 'Partire', 'Ir', 'Идти', 'Ir', 'Gitmek'),
(938, 'created_new_event', '', 'created new event', 'حدث جديد', 'Aangemaakt nieuw evenement', 'Nouvel événement créé', 'Neue Veranstaltung erstellt', 'Ha creato un nuovo evento', 'Criou um novo evento', 'Создано новое мероприятие', 'Creó nuevo evento', 'Yeni bir etkinlik yarattı'),
(939, 'my_events', '', 'My events', 'أحداثي', 'Mijn gebeurtenissen', 'Mes événements', 'Meine ereignisse', 'I miei eventi', 'Meus eventos', 'Мои мероприятия', 'Mis eventos', 'Etkinliklerim'),
(940, 'is_interested', '', 'is interested on your event \"{event_name}\"', 'مهتم بحدثك \"{event_name}\"', 'Is geïnteresseerd in je evenement \"{event_name}\"', 'Est intéressé par votre événement \"{event_name}\"', 'Interessiert sich für deine Veranstaltung \"{event_name}\"', 'È interessato al tuo evento \"{event_name}\"', 'Está interessado no seu evento \"{event_name}\"', 'Заинтересовано в вашем мероприятии \"{event_name}\"', 'Está interesado en su evento \"{event_name}\"', '\"{Event_name}\" etkinliğinizle ilgileniyor.'),
(941, 'is_going', '', 'is going to your event \"{event_name}\"', 'هو الذهاب إلى الحدث \"{event_name}\"', 'Gaat naar je evenement \"{event_name}\"', 'Va à votre événement \"{event_name}\"', 'Geht zu deiner Veranstaltung \"{event_name}\"', 'Sta andando al tuo evento \"{event_name}\"', 'Está indo para o seu evento \"{event_name}\"', 'Идет на ваше мероприятие \"{event_name}\"', 'Va a su evento \"{event_name}\"', '\"{Event_name}\" etkinliğine gidiyor'),
(942, 'invited_you_event', '', 'invited you to go the event \"{event_name}\"', 'دعاك إلى الذهاب إلى الحدث \"{event_name}\"', 'Heeft u uitgenodigd om het evenement te gaan \"{event_name}\"', NULL, 'Lud dich ein, die Veranstaltung zu starten \"{event_name}\"', NULL, 'Convidou você para ir ao evento \"{event_name}\"', 'Приглашает вас на мероприятие \"{event_name}\"', 'Te invitó a ir al evento \"{event_name}\"', 'Sizi \"{event_name}\" etkinliğine davet etti.'),
(943, 'replied_to_topic', '', 'replied to your topic', 'أجاب على الموضوع', 'Antwoordde op je onderwerp', 'A répondu à votre sujet', 'Antwortete auf dein Thema', 'Ha risposto al tuo argomento', 'Respondeu ao seu tópico', 'Ответил на вашу тему', 'Respondió a su tema', 'Cevabınız cevaplandı'),
(944, 'movies', '', 'Movies', 'أفلام', 'Dioscoop', 'Films', 'Kino', 'Film', 'Filmes', 'Кино', 'Películas', 'Filmler'),
(945, 'translate', '', 'Translate', 'ترجم', 'Vertalen', 'Traduire', 'übersetzen', 'Tradurre', 'Traduzir', 'перевести', 'Traducciones', 'çevirmek'),
(946, 'genre', '', 'Genre', 'نوع أدبي', 'Genre', 'Genre', 'Genre', 'Genere', 'Gênero', 'Жанр', 'Genre', 'tarz'),
(947, 'recommended', '', 'Recommended', 'موصى به', 'Aanbevolen', 'Recommandé', 'empfohlen', 'Raccomandato', 'Recomendado', 'Рекомендуемые', 'Se recomienda', 'Tavsiye'),
(948, 'most_watched', '', 'Most watched', 'الأكثر مشاهدة', 'Meest bekeken', 'Le plus regardé', 'Die meisten angeschaut ', 'Più visto', 'Mais visto', 'Понравившиеся', 'Más información', 'En çok izlenen'),
(949, 'stars', '', 'Stars', 'نجوم', 'Stars', 'Etoiles', 'Sterne', 'Stars', 'Estrelas', 'Звезды', 'Estrellas', 'yıldız'),
(951, 'no_movies_found', '', 'No movies to show', 'لم يتم العثور على الأفلام', 'Geen films gevonden', 'Pas de films trouvés', 'Keine Filme gefunden', 'Nessun film trovato', 'Não há filmes encontrados', 'Фильмы не найдены', 'No movies found', 'Filmlerde Bulunan'),
(952, 'producer', '', 'Producer', 'منتج', 'Producent', 'Producteur', 'Produzent', 'Produttore', 'Produtor', 'Продюсер', 'Producer', 'yapımcı'),
(953, 'release', '', 'Release', 'إطلاق', 'Vrijlating', 'Sortie', 'Veröffentlichung', 'Rilascio', 'Lançamento', 'Релиз', 'Versión', 'salıverme'),
(954, 'quality', '', 'Quality', 'جودة', 'Kwaliteit', 'Qualité', 'Qualität', 'Qualità', 'Qualidade', 'Качество', 'Calidad', 'kalite'),
(955, 'more_like_this', '', 'More like this', 'أكثر من هذا القبيل', 'Meer in deze trant', 'Plus darticles', 'Ähnliche Titel', 'Altri risultati simili', 'Mais como este', 'Похожие фильмы', 'Más información', 'Buna benzer'),
(956, 'wallet', '', 'Wallet', 'محفظة نقود', 'Portemonnee', 'Portefeuille', 'Brieftasche', 'Portafoglio', 'Carteira', 'Бумажник', 'Billetera', 'Cüzdan'),
(958, 'bidding', '', 'Bidding', 'مزايدة', 'bod', 'Enchère', 'Bieten', 'offerta', 'Licitação', 'торги', 'Ofertas', 'teklif verme'),
(959, 'clicks', '', 'Clicks', 'نقرات', 'klikken', 'Clics', 'Klicks', 'clic', 'Cliques', 'щелчки', 'Clics', 'Tıklanma'),
(960, 'url', '', 'Url', 'رابط', 'url', 'Url', 'Url', 'url', 'Url', 'Веб-сайт', 'Url', 'URL'),
(961, 'audience', '', 'Audience', 'جمهور', 'Publiek', 'Public', 'Publikum', 'Pubblico', 'Público', 'Аудитория', 'Audiencia', 'seyirci'),
(962, 'select_image', '', 'Select an image', 'حدد صورة', 'Selecteer een afbeelding', 'Sélectionnez une image', 'Wählen Sie ein Bild aus', 'Selezionare unimmagine', 'Selecione uma imagem', 'Выберите изображение', 'Seleccione una imagen', 'Bir resim seçin'),
(964, 'replenish_my_balance', '', 'Replenish my balance', 'تجديد رصيد بلدي', 'Herstel mijn saldo', 'Récupérer mon solde', 'Fülle meine Balance auf', 'Riempire il mio equilibrio', 'Reabasteça meu saldo', 'Пополнить баланс', 'Reponer mi saldo', 'Bakiyemi yenile'),
(965, 'continue', '', 'Continue', 'استمر', 'voortzetten', 'Continuer', 'Fortsetzen', 'Continua', 'Continuar', 'Продолжить', 'Continuar', 'Devam et'),
(966, 'replenishment_notif', '', 'Your balance has been replenished by', 'تمت إعادة تجديد رصيدك بواسطة', 'Uw saldo is aangevuld door', 'Votre solde a été reconstitué par', 'Ihr Gleichgewicht wurde ergänzt durch', 'Il tuo equilibrio è stato riempito da', 'Seu saldo foi reabastecido por', 'Ваш баланс был пополнен', 'Tu saldo ha sido reabastecido por', 'Bakiyeniz, tarafından yeniden dolduruldu.'),
(967, 'ads', '', 'Advertising', 'إعلان', 'Reclame', 'Publicité', 'Werbung', 'Pubblicità', 'Publicidade', 'Реклама', 'Publicidad', 'Ilan'),
(968, 'confirm_delete_ad', '', 'Are you sure that you want to delete this campaign? This action can&#39;t be undo.', 'هل أنت متأكد أنك تريد حذف هذا الإعلان', 'Weet u zeker dat u deze advertentie wilt verwijderen', 'Êtes-vous sûr de vouloir supprimer cette annonce?', 'Möchten Sie diese Anzeige wirklich löschen?', 'Sei sicuro di voler cancellare questo annuncio', 'Tem certeza de que quer apagar este anúncio', 'Вы уверены, что хотите удалить эту рекламу', 'Estás seguro de que quieres eliminar esta publicidad', 'Bu reklamı silmek istediğinizden emin misiniz'),
(969, 'delete_ad', '', 'Delete campaign', 'حذف الإعلان', 'Verwijder advertentie', 'Supprimer lannonce', 'Anzeige löschen', 'Elimina annuncio', 'Eliminar anúncio', 'Удалить объявление', 'Eliminar anuncio', 'Reklamı sil'),
(970, 'no_ads_found', '', 'No ads found. Create new ad and start getting traffic!', 'لم يتم العثور على أية إعلانات', 'Geen advertenties gevonden', 'Aucune annonce na été trouvée', 'Keine Anzeigen gefunden', 'Nessun annuncio trovato', 'Nenhum anúncio encontrado', 'Объявления не найдены', 'No se han encontrado anuncios', 'Hiç ilan bulunamadı'),
(972, 'appears', '', 'Placement', 'تحديد مستوى', 'Plaatsing', 'Placement', 'Platzierung', 'Posizionamento', 'Colocação', 'размещение', 'Colocación', 'Yerleştirme'),
(973, 'sidebar', '', 'Sidebar', 'الشريط الجانبي', 'sidebar', 'Barre latérale', 'Seitenleiste', 'Sidebar', 'Barra Lateral', 'Боковая панель', 'Barra lateral', 'Kenar çubuğu'),
(974, 'select_a_page_or_link', '', 'Select a page or enter a link to your site', 'حدد صفحة أو أدخل رابطا إلى موقعك', 'Selecteer een pagina of voer een link in op uw site', 'Sélectionnez une page ou entrez un lien vers votre site', 'Wählen Sie eine Seite aus oder geben Sie einen Link zu Ihrer Website ein', 'Seleziona una pagina o inserisci un link al tuo sito', 'Selecione uma página ou insira um link para o seu site', 'Выберите страницу или введите ссылку на свой сайт', 'Seleccione una página o ingrese un enlace a su sitio', 'Bir sayfa seçin veya sitenize bir bağlantı girin'),
(975, 'story', '', 'Story', 'قصة', 'Verhaal', 'Récit', 'Geschichte', 'Storia', 'História', 'История', 'Historia', 'Öykü'),
(976, 'max_number_status', '', 'The maximum number can not exceed 20 files at a time!', 'الحد الأقصى لعدد لا يمكن أن يتجاوز 20 ملفات في وقت واحد!', 'Het maximaal aantal kan niet meer dan 20 bestanden tegelijkertijd overschrijden!', 'Le nombre maximal ne peut pas dépasser 20 fichiers à la fois!', 'Die maximale Anzahl darf maximal 20 Dateien nicht überschreiten!', 'Il numero massimo non può superare 20 file alla volta!', 'O número máximo não pode exceder 20 arquivos de cada vez!', 'Максимальное число не может превышать 20 файлов за раз!', '¡El número máximo no puede superar los 20 archivos a la vez!', 'Maksimum sayı, aynı anda 20 dosya aşamaz!'),
(977, 'status_added', '', 'Your status has been successfully added!', 'تمت إضافة حالتك بنجاح!', 'Uw status is succesvol toegevoegd!', 'Votre statut a été ajouté avec succès!', 'Ihr Status wurde erfolgreich hinzugefügt!', 'Il tuo stato è stato aggiunto con successo!', 'Seu status foi adicionado com sucesso!', 'Ваш статус успешно добавлен!', '¡Tu estado se ha agregado correctamente!', 'Durumunuz başarıyla eklendi!'),
(978, 'create_new_status', '', 'Create New Status', 'إنشاء حالة جديدة', 'Maak een nieuwe status aan', 'Créer un nouvel état', 'Neuen Status anlegen', 'Crea nuovo stato', 'Criar novo status', 'Создать новый статус', 'Crear nuevo estado', 'Yeni Durum Oluştur'),
(979, 'sponsored', '', 'Sponsored', 'برعاية', 'Sponsored', 'Sponsorisé', 'Gefördert', 'sponsorizzati', 'Patrocinadas', 'Рекламные', 'Patrocinado', 'Sponsor'),
(980, 'notification_sent', '', 'Your notification has been sent successfully', 'تم إرسال الإشعار بنجاح', 'Uw melding is succesvol verzonden', 'Votre notification a été envoyée avec succès', 'Ihre Benachrichtigung wurde erfolgreich gesendet', 'La tua notifica è stata inviata correttamente', 'Sua notificação foi enviada com sucesso', 'Ваше уведомление отправлено успешно', 'Tu notificación se ha enviado correctamente', 'Bildiriminiz başarıyla gönderildi'),
(981, 'hide_post', '', 'Hide post', 'آخر اخفاء', 'Verberg post', 'Masquer la publication', 'Beitrag ausblenden', 'Nascondi post', 'Ocultar postagem', 'Скрыть сообщение', 'Esconder la publicación', 'Postayı gizle'),
(982, 'verification_sent', '', 'Your verification request  soon will be considered!', 'سيتم النظر في طلب التحقق قريبا!', 'Uw verificatieaanvraag zal binnenkort worden overwogen!', 'Votre demande de vérification sera bientôt prise en considération!', 'Ihre Bestätigungsanforderung wird bald berücksichtigt!', 'La tua richiesta di verifica sarà presto presa in considerazione!', 'Seu pedido de verificação em breve será considerado!', 'Ваш запрос на подтверждение скоро будет рассмотрен!', 'Su solicitud de verificación pronto será considerada!', 'Doğrulama isteğiniz yakında değerlendirilecek!'),
(983, 'profile_verification', '', 'Verification of the profile!', 'التحقق من الملف الشخصي!', 'Verificatie van het profiel!', 'Vérification du profil!', 'Überprüfung des Profils!', 'Verifica del profilo!', 'Verificação do perfil!', 'Проверка профиля!', 'Verificación del perfil!', 'Profilin doğrulanması!'),
(984, 'verification_complete', '', 'Congratulations your profile is verified!', 'تهانينا تم التحقق من ملفك الشخصي!', 'Gefeliciteerd, uw profiel is geverifieerd!', 'Félicitations, votre profil est vérifié!', 'Herzlichen Glückwunsch, Ihr Profil wird bestätigt!', 'Complimenti il ​​tuo profilo è verificato!', 'Parabéns seu perfil está verificado!', 'Поздравляем Ваш профиль проверен!', '¡Felicidades tu perfil está verificado!', 'Tebrikler, profiliniz doğrulandı!'),
(985, 'upload_docs', '', 'Upload documents', 'تحميل المستندات', 'Documenten uploaden', 'Télécharger des documents', 'Dokumente hochladen', 'Carica i documenti', 'Carregar documentos', 'Загрузить документы', 'Subir documentos', 'Belgeleri yükle'),
(986, 'select_verif_images', '', 'Please upload a photo with your passport / ID  & your distinct photo', 'يرجى تحميل صورة مع جواز سفرك / إد & أمب؛ صورتك المميزة', 'Upload een foto met uw paspoort / ID & amp; Jouw eigen foto', 'Veuillez télécharger une photo avec votre passeport / ID & amp; Votre photo distincte', 'Bitte laden Sie ein Foto mit Ihrem Pass / ID & amp; Ihr eigenes Foto', 'Carica una foto con il tuo passaporto / ID & amp; La tua foto distinta', 'Carregue uma foto com seu passaporte / ID & amp; Sua foto distinta', 'Пожалуйста, загрузите фотографию с вашим паспортом / ID и amp; Твоя отличная фотография', 'Cargue una foto con su pasaporte / ID & amp; Tu foto distinta', 'Lütfen pasaportunuzla bir fotoğraf yükleyin / kimliği ve amp; Farklı fotoğrafın'),
(987, 'passport_id', '', 'Copy of your passport or ID card', 'جواز السفر / بطاقة الهوية', 'Paspoort / ID kaart', 'Passeport / carte didentité', 'Pass / ID-Karte', 'Passaporto / id carta', 'Passaporte / cartão de identificação', 'Паспорт / удостоверение личности', 'Pasaporte / tarjeta de identificación', 'Pasaport / kimlik kartı'),
(988, 'your_photo', '', 'Your photo', 'صورتك', 'Je foto', 'Ta photo', 'Dein Foto', 'La tua foto', 'Sua foto', 'Твое фото', 'Tu foto', 'Senin resmin'),
(989, 'please_select_passport_id', '', 'Please select your passport/id and photo!', 'يرجى تحديد جواز السفر / معرف والصورة!', 'Selecteer alstublieft uw paspoort / id en foto!', 'Sélectionnez votre passeport / id et photo!', 'Bitte wählen Sie Ihren Pass / id und Foto!', 'Seleziona il tuo passaporto / id e foto!', 'Selecione seu passaporte / id e foto!', 'Выберите свой паспорт / удостоверение личности и фото!', 'Por favor, seleccione su pasaporte / identificación y foto!', 'Lütfen pasaportunuzun / kimlik numaranızı ve fotoğrafınızı seçin!'),
(990, 'passport_id_invalid', '', 'The passport/id picture must be an image', 'يجب أن تكون صورة الجواز / الصورة صورة', 'De paspoort / id foto moet een afbeelding zijn', 'Limage passeport / id doit être une image', 'Das Pass / id Bild muss ein Bild sein', 'Limmagine del passaporto / id deve essere unimmagine', 'A imagem de passaporte / id deve ser uma imagem', 'Паспорт / идентификатор должен быть изображением', 'La imagen del pasaporte / id debe ser una imagen', 'Pasaport / id resmi bir resim olmalıdır'),
(991, 'user_picture_invalid', '', 'The user picture must be an image', 'يجب أن تكون صورة المستخدم صورة', 'De gebruikersfoto moet een afbeelding zijn', 'Limage utilisateur doit être une image', 'Das Benutzerbild muss ein Bild sein', 'Limmagine dellutente deve essere unimmagine', 'A imagem do usuário deve ser uma imagem', 'Изображение пользователя должно быть изображением', 'La imagen del usuario debe ser una imagen', 'Kullanıcı resmi bir resim olmalıdır'),
(992, 'verification_request_sent', '', 'Your request was successfully sent, in the very near future we will consider it!', 'تم إرسال طلبك بنجاح، في المستقبل القريب جدا سوف ننظر فيه!', 'Uw aanvraag is succesvol verzonden, in de nabije toekomst zullen we het overwegen!', 'Votre demande a été envoyée avec succès, dans un avenir très proche, nous lexaminerons!', 'Ihre Anfrage wurde erfolgreich gesendet, in naher Zukunft werden wir es betrachten!', 'La tua richiesta è stata inviata con successo, nel prossimo futuro lo considereremo!', 'Seu pedido foi enviado com sucesso, no futuro muito próximo, vamos considerá-lo!', 'Ваш запрос был успешно отправлен, в самом ближайшем будущем мы это рассмотрим!', 'Su solicitud fue enviada con éxito, en un futuro muy próximo lo consideraremos!', 'İsteğiniz başarıyla gönderildi, çok yakın bir zamanda bunu düşünüyoruz!'),
(993, 'shared', '', 'shared', 'مشترك', 'gedeelde', 'partagé', 'Geteilt', 'diviso', 'Compartilhado', 'Поделился', 'Compartido', 'Paylaşılan'),
(994, 'post_shared', '', 'Post was successfully added to your timeline!', 'تمت إضافة المشاركة بنجاح إلى المخطط الزمني!', 'Post is succesvol toegevoegd aan je tijdlijn!', 'Le message a été ajouté avec succès à votre calendrier!', 'Post wurde erfolgreich zu deinem Zeitplan hinzugefügt!', 'Lalberino è stato aggiunto con successo alla tua timeline!', 'O post foi adicionado com sucesso à sua linha de tempo!', 'Сообщение было успешно добавлено на ваш график!', '¡Se ha agregado el mensaje a tu línea de tiempo!', 'Mesaj, zaman çizelgesine başarıyla eklendi!'),
(995, 'important', '', 'Important!', 'مهم!', 'Belangrijk!', 'Important!', 'Wichtig!', 'Importante!', 'Importante!', 'Важно!', '¡Importante!', 'Önemli!'),
(996, 'unverify', '', 'Please note that if you change the username you will lose verification', 'يرجى ملاحظة أنه في حالة تغيير اسم المستخدم، فستفقد التحقق', 'Houd er rekening mee dat als u de gebruikersnaam wijzigt, u de verificatie verliest', 'Veuillez noter que si vous modifiez le nom dutilisateur, vous allez perdre la vérification', 'Bitte beachten Sie, dass Sie bei der Änderung des Benutzernamens die Bestätigung verlieren', 'Si prega di notare che se si modifica il nome utente perderà la verifica', 'Observe que se você alterar o nome de usuário, você perderá a verificação', 'Обратите внимание, что если вы измените имя пользователя, вы потеряете подтверждение', 'Tenga en cuenta que si cambia el nombre de usuario, perderá la verificación', 'Kullanıcı adını değiştirirseniz doğrulamayı kaybedeceğinizi lütfen unutmayın'),
(997, 'friend_privacy', '', 'Who can see my friends?', 'الذين يمكن أن نرى أصدقائي', 'Wie kan mijn vrienden zien', 'Qui peut voir mes amis', 'Wer kann meine Freunde sehen', 'Chi può vedere i miei amici', 'Quem pode ver meus amigos', 'Кто может видеть моих друзей', '¿Quién puede ver a mis amigos?', 'Arkadaşlarımı kim görebilir?'),
(998, 'added_group_admin', '', 'added you group admin', 'أضافك مشرف المجموعة', 'Toegevoegd je groep admin', 'Ajoute ton administrateur de groupe', 'Fügte Ihnen gruppe admin hinzu', NULL, 'Adicionou você administrador do grupo', 'Добавлен администратор группы', 'Agregó tu grupo de administración', 'Grup yöneticisi ekledi'),
(999, 'added_page_admin', '', 'added you page admin', 'أضافك مشرف الصفحة', 'Toegevoegd u pagina admin', 'A ajouté votre page admin', 'Fügte Ihnen die Seite admin hinzu', NULL, 'Adicionou você admin da página', 'Добавлено администратором страницы', 'Agregó tu página admin', 'Size sayfa admin ekledi'),
(1000, 'no_messages', '', 'No messages yet here.', 'لا توجد رسائل حتى الآن.', 'Nog geen berichten hier.', NULL, 'Noch keine Nachrichten.', 'Non ci sono ancora messaggi qui.', 'Ainda não há mensagens aqui.', 'Пока сообщений нет.', 'Aún no hay mensajes.', 'Henüz mesaj yok.'),
(1001, 'conversation_deleted', '', 'Conversation has been deleted!', 'تم حذف المحادثة!', 'Conversatie is verwijderd!', 'La conversation a été supprimée!', 'Konversation wurde gelöscht!', 'La conversazione è stata cancellata!', 'A conversa foi excluída!', 'Разговор удален!', '¡Se ha eliminado la conversación!', 'İleti dizisi silindi!'),
(1002, 'close', '', 'Close', 'قريب', 'Dichtbij', 'Fermer', 'Schließen', 'Vicino', 'Fechar', 'Закрыть', 'Cerca', 'Kapat'),
(1004, 'exit_group', '', 'Exit group', 'خروج من المجموعة', 'Exitgroep', 'Groupe de sortie', 'Exit-Gruppe', 'Esci dal gruppo', 'Grupo de saída', 'Группа выхода', 'Salir del grupo', 'Grubundan çık'),
(1005, 'clear_history', '', 'Clear history', 'تاريخ واضح', 'Geschiedenis wissen', 'Histoire claire', 'Geschichte löschen', 'Cancellare la cronologia', 'Apagar o histórico', 'Удалить переписку', 'Borrar historial', 'Geçmişi temizle'),
(1006, 'group_members', '', 'Group members', 'أعضاء المجموعة', 'Groepsleden', 'Les membres du groupe', 'Gruppenmitglieder', 'Membri del gruppo', 'Membros do grupo', 'Участники группы', 'Miembros del grupo', 'Grup üyeleri'),
(1007, 'add_parts', '', 'Add participant', 'إضافة مشارك', 'Voeg deelnemer toe', 'Ajouter un participant', 'Teilnehmer hinzufügen', 'Aggiungi partecipante', 'Adicionar participante', 'Добавить участника', 'Añada participante', 'Katılımcı ekle'),
(1008, 'unreport', '', 'Cancel Report', 'إلغاء التقرير', 'Annuleren rapport', 'Annuler le rapport', 'Bericht abbrechen', 'Annulla rapporto', 'Cancelar relatório', 'Отменить отчет', 'Cancelar informe', 'Raporu İptal Et'),
(1009, 'report_user', '', 'Report this User', 'الإبلاغ عن هذا المستخدم', 'Rapporteer deze gebruiker', 'Signaler cet utilisateur', 'Diesen Nutzer melden', 'Segnala questo utente', 'Denunciar este usuário', 'Сообщить об этом пользователе', 'Reportar a este usuario', 'Bu kullanıcıyı rapor et'),
(1010, 'report_page', '', 'Report this Page', 'الإبلاغ عن هذه الصفحة', 'Meld deze pagina aan', 'Signaler cette page', 'Diese Seite melden', 'Segnala questa pagina', 'Informe esta página', 'Сообщить об этой странице', 'Informar sobre esta página', 'Bu sayfayı bildir'),
(1011, 'report_group', '', 'Report this Group', 'الإبلاغ عن هذه المجموعة', 'Meld deze groep aan', 'Signaler ce groupe', 'Diese Gruppe melden', 'Segnala questo gruppo', 'Denunciar este grupo', 'Сообщить об этой группе', 'Reportar este grupo', 'Bu Grubu Rapor Et'),
(1012, 'page_rated', '', 'You have already rated this page!', 'لقد قيمت هذه الصفحة من قبل!', 'U heeft deze pagina al beoordeeld!', 'Vous avez déjà noté cette page!', 'Sie haben diese Seite bereits bewertet!', 'Hai già valutato questa pagina!', 'Você já avaliou esta página!', 'Вы уже оценили эту страницу!', '¡Ya has calificado esta página!', 'Bu sayfaya zaten puan verdiniz!'),
(1013, 'rating', '', 'Rating', 'تقييم', 'Beoordeling', 'Évaluation', 'Bewertung', 'Valutazione', 'Avaliação', 'Рейтинг', 'Clasificación', 'Değerlendirme'),
(1014, 'reviews', '', 'Reviews', 'التعليقات', 'beoordelingen', 'Avis', 'Bewertungen', 'Recensioni', 'Rever', 'Отзывы', 'Comentarios', 'yorumlar'),
(1015, 'rate', '', 'Rate', 'معدل', 'tarief', 'Taux', 'Preis', 'Vota', 'Taxa', 'Ставка', 'Tarifa', 'oran'),
(1016, 'your_review', '', 'Write your review.', 'اكتب مراجعتك.', 'Schrijf je beoordeling.', 'Donnez votre avis.', 'Schreiben Sie eine Bewertung.', 'Scrivi la tua recensione.', 'Escreva sua revisão.', 'Напишите свой отзыв.', 'Escribe tu reseña.', 'Yorumunuzu yazın.'),
(1017, 'ad_saved', '', 'Your ad has been successfully saved!', 'تم حفظ إعلانك بنجاح!', 'Uw advertentie is succesvol opgeslagen!', 'Votre annonce a été enregistrée avec succès!', 'Ihre Anzeige wurde erfolgreich gespeichert!', 'Il tuo annuncio è stato salvato con successo!', 'Seu anúncio foi salvo com sucesso!', 'Ваше объявление успешно сохранено!', 'Tu anuncio se ha guardado correctamente.', 'Reklamınız başarıyla kaydedildi!'),
(1018, 'ad_added', '', 'Your ad has been successfully added!', 'تمت إضافة إعلانك بنجاح!', 'Uw advertentie is succesvol toegevoegd!', 'Votre annonce a été ajoutée avec succès!', 'Ihre Anzeige wurde erfolgreich hinzugefügt!', 'Il tuo annuncio è stato aggiunto con successo!', 'Seu anúncio foi adicionado com sucesso!', 'Ваше объявление было успешно добавлено!', 'Su anuncio se ha agregado correctamente.', 'Reklamınız başarıyla eklendi!'),
(1019, 'invalid_ad_picture', '', 'The ads picture must be an image!', 'يجب أن تكون صورة الإعلانات صورة!', 'De advertentie foto moet een afbeelding zijn!', NULL, 'Das Anzeigenbild muss ein Bild sein!', NULL, 'A imagem dos anúncios deve ser uma imagem!', 'Изображение объявления должно быть изображением!', '¡La imagen de los anuncios debe ser una imagen!', 'Reklam resimleri bir resim olmalıdır!'),
(1020, 'enter_valid_desc', '', 'Please enter a valid description!', 'الرجاء إدخال وصف صالح!', 'Vul alstublieft een geldige omschrijving in!', 'Entrez une description valable!', 'Bitte geben Sie eine gültige Beschreibung ein!', 'Inserisci una descrizione valida!', 'Digite uma descrição válida!', 'Введите действительное описание!', 'Por favor ingrese una descripción válida!', 'Lütfen geçerli bir açıklama girin!'),
(1021, 'enter_valid_titile', '', 'Please enter a valid title!', 'يرجى إدخال عنوان صالح!', 'Vul alstublieft een geldige titel in!', 'Entrez un titre valide!', 'Bitte geben Sie einen gültigen Titel ein!', 'Si prega di inserire un titolo valido!', 'Digite um título válido!', 'Введите действительный заголовок!', '¡Por favor ingrese un título válido!', 'Lütfen geçerli bir başlık girin!'),
(1022, 'enter_valid_url', '', 'Please enter a valid link!', 'الرجاء إدخال رابط صالح!', 'Vul alstublieft een geldige link in!', 'Veuillez entrer un lien valide!', 'Bitte geben Sie einen gültigen Link ein!', 'Inserisci un link valido!', 'Digite um link válido!', 'Пожалуйста, введите действующую ссылку!', 'Ingrese un enlace válido!', 'Lütfen geçerli bir bağlantı girin!'),
(1023, 'invalid_company_name', '', 'Please enter a valid company name!', 'الرجاء إدخال اسم شركة صالح!', 'Vul alstublieft een geldige bedrijfsnaam in!', NULL, 'Bitte geben Sie einen gültigen Firmennamen ein!', 'Inserisci un nome aziendale valido!', 'Digite um nome válido da empresa!', 'Укажите действительное название компании!', 'Introduzca un nombre de empresa válido!', 'Lütfen geçerli bir şirket adı girin!'),
(1024, 'mother', '', 'Mother', 'أم', 'Moeder', 'Mère', 'Mutter', 'Madre', 'Mãe', 'Мама', 'Madre', 'anne'),
(1025, 'father', '', 'Father', 'الآب', 'Vader', 'Père', 'Vater', 'Padre', 'Pai', 'Отец', 'Padre', 'baba'),
(1026, 'daughter', '', 'Daughter', 'ابنة', 'Dochter', 'Fille', 'Tochter', 'Figlia', 'Filha', 'Дочь', 'Hija', 'Kız evlat'),
(1027, 'son', '', 'Son', 'ابن', 'Zoon', 'Fils', 'Sohn', 'Figlio', 'Filho', 'Сын', 'Hijo', 'Oğul'),
(1028, 'sister', '', 'Sister', 'أخت', 'Zus', 'Sœur', 'Schwester', 'Sorella', 'Irmã', 'Сестра', 'Hermana', 'Kız kardeş'),
(1029, 'brother', '', 'Brother', 'شقيق', 'Broer', 'Frère', 'Bruder', 'Fratello', 'Irmão', 'Брат', 'Hermano', 'Erkek kardeş'),
(1030, 'auntie', '', 'Auntie', 'عمة', 'Tante', 'Tata', 'Tante', 'Auntie', 'Tia', 'тетушка', 'Tía', 'teyzeciğim'),
(1031, 'uncle', '', 'Uncle', 'اخو الام', 'Oom', 'Oncle', 'Onkel', 'Zio', 'Tio', 'Дядя', 'Tío', 'Amca dayı');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1032, 'niece', '', 'Niece', 'ابنة الاخ', 'Nicht', 'Nièce', 'Nichte', 'Nipote', 'Sobrinha', 'Племянница', 'Sobrina', 'Yeğen'),
(1033, 'nephew', '', 'Nephew', 'ابن أخ', 'Neef', 'Neveu', 'Neffe', 'Nipote', 'Sobrinho', 'Племянник', 'Sobrino', 'Erkek yeğen'),
(1034, 'cousin_female', '', 'Cousin (female)', 'ابن عم (أنثى)', 'Neef (vrouwelijk)', 'Cousine)', 'Cousine)', 'Cugina)', 'Prima)', 'Двоюродная сестра)', 'Prima)', 'Kuzenim (kadın)'),
(1035, 'cousin_male', '', 'Cousin (male)', 'ابن عم (ذكور)', 'Neef)', 'Cousin Male)', 'Cousin)', 'Cugino maschio)', 'Primo)', 'Двоюродный брат)', 'Primo varón)', 'Erkek kuzen)'),
(1036, 'grandmother', '', 'Grandmother', 'جدة', 'Grootmoeder', 'Grand-mère', 'Oma', 'Nonna', 'Avó', 'Бабушка', 'Abuela', 'büyükanne'),
(1037, 'grandfather', '', 'Grandfather', 'جد', 'Grootvader', 'Grand-père', 'Großvater', 'Nonno', 'Avô', 'Дед', 'Abuelo', 'Büyük baba'),
(1038, 'granddaughter', '', 'Granddaughter', 'حفيدة', 'Kleindochter', 'Petite fille', 'Enkelin', 'Nipotina', 'Neta', 'Внучка', 'Nieta', 'Kız torun'),
(1039, 'grandson', '', 'Grandson', 'حفيد', 'Kleinzoon', 'Petit fils', 'Enkel', 'Nipote', 'Neto', 'Внук', 'Nieto', 'Erkek torun'),
(1040, 'stepsister', '', 'Stepsister', 'مثل اختي', 'Stiefzuster', 'Demi-soeur', 'Stiefschwester', 'Sorellastra', 'Meia-irmã', 'Сводная сестра', 'Hermanastra', 'Üvey kızkardeş'),
(1041, 'stepbrother', '', 'Stepbrother', 'أخ غير شقيق', 'stiefbroeder', 'Beau-frère', 'Stiefbruder', 'Fratellastro', 'Meio-irmão', 'Сводный брат', 'Hermanastro', 'Üvey erkek kardeş'),
(1042, 'stepmother', '', 'Stepmother', 'زوجة الأب', 'Stiefmoeder', 'Stepmother', 'Stiefmutter', 'Matrigna', 'Madrasta', 'Мачеха', 'Madrastra', 'üvey anne'),
(1043, 'stepfather', '', 'Stepfather', 'زوج الأم', 'Stiefvader', 'Beau-père', 'Stiefvater', 'Patrigno', 'Padrasto', 'Отчим', 'Padrastro', 'üvey baba'),
(1044, 'stepdaughter', '', 'Stepdaughter', 'ربيبة', 'Stiefdochter', 'Belle fille', 'Stieftochter', 'Figliastra', 'Enteada', 'Падчерица', 'Hijastra', 'üvey kız'),
(1045, 'sister_in_law', '', 'Sister-in-law', 'أخت الزوج أو اخت الزوجة', 'Schoonzuster', 'Belle-soeur', 'Schwägerin', 'Cognata', 'Cunhada', 'Золовка', 'Cuñada', 'Baldız'),
(1046, 'brother_in_law', '', 'Brother-in-law', 'شقيق الزوج', 'Zwager', 'Beau-frère', 'Schwager', 'Cognato', 'Cunhado', 'Шурин', 'Cuñado', 'Kayınbirader'),
(1047, 'mother_in_law', '', 'Mother-in-law', 'حماة \" أم الزوج أو أم الزوجة', 'Schoonmoeder', 'Belle-mère', 'Schwiegermutter', 'Suocera', 'Sogra', 'Свекровь', 'Suegra', 'Kayınvalide'),
(1048, 'father_in_law', '', 'Father-in-law', 'ووالد بالتبنى', 'Schoonvader', 'Beau-père', 'Schwiegervater', 'Suocero', 'Sogro', 'Тесть', 'Suegro', 'Kayınpeder'),
(1049, 'daughter_in_law', '', 'Daughter-in-law', 'ابنة بالنسب', 'Schoondochter', 'Belle-fille', 'Schwiegertochter', 'Nuora', 'Nora', 'Невестка', 'Hijastra', 'Gelin'),
(1050, 'son_in_law', '', 'Son-in-law', 'ابنه قانونياً', 'Schoonzoon', 'Beau fils', 'Schwiegersohn', 'Genero', 'Genro', 'Зять', 'Yerno', 'Damat'),
(1051, 'sibling_gender_neutral', '', 'Sibling (gender neutral)', 'الأخوة (محايدة جنسانيا)', 'Broers en zussen (geslachtsneutraal)', 'Sibling (genre neutre)', 'Geschwister (geschlechtsneutral)', 'Fidanzamento (genere neutro)', 'Irmão (neutro em termos de gênero)', 'Сиблинг (гендерно нейтральный)', 'Hermano (neutral de género)', 'Kardeşlik (cinsiyete dayalı)'),
(1052, 'parent_gender_neutral', '', 'Parent (gender neutral)', 'الوالد (محايد جنسانيا)', 'Ouder (geslachtsneutraal)', 'Parent (genre neutre)', 'Elternteil (geschlechtsneutral)', 'Genitore (genere neutro)', 'Pais (neutro em termos de gênero)', 'Родитель (гендерно нейтральный)', 'Padre (neutral de género)', 'Ebeveyn (cinsiyete dayalı)'),
(1053, 'child_gender_neutral', '', 'Child (gender neutral)', 'الطفل (محايد جنسانيا)', 'Kind (geslachtsneutraal)', 'Enfant (genre neutre)', 'Kind (geschlechtsneutral)', 'Bambino (sesso neutro)', 'Criança (neutro em termos de gênero)', 'Ребенок (гендерно нейтральный)', 'Niño (neutral de género)', 'Çocuk (cinsiyete dayalı)'),
(1054, 'sibling_of_parent_gender_neutral', '', 'Sibling of Parent (gender neutral)', 'شقيق الوالد (محايد جنسانيا)', 'Broers en zussen van ouder (geslachtsneutraal)', 'Sibling of Parent (genre neutre)', 'Geschwister der Eltern (geschlechtsneutral)', 'Fratellanza del genitore (neutralità di genere)', 'Sibling of Parent (neutro em termos de gênero)', 'Братство родителей (гендерно нейтральный)', 'Hermano de padre (neutral de género)', 'Ebeveynin Kardeşliği (cinsiyete dayalı)'),
(1055, 'child_of_sibling_gender_neutral', '', 'Child of Sibling (gender neutral)', 'طفل الأخوة (محايد جنسانيا)', 'Kind van broer en zus (geslachtsneutraal)', 'Enfant de fratrie (genre neutre)', 'Kind des Geschwisters (geschlechtsneutral)', 'Bambino di fratelli (neutralità di genere)', 'Criança do irmão (neutro em termos de gênero)', 'Ребенок Сиблинга (гендерно нейтральный)', 'Hijo de hermano (neutral de género)', 'Kardeşlik çocuğu (cinsiyete dayalı tarafsız)'),
(1056, 'cousin_gender_neutral', '', 'Cousin (gender neutral)', 'ابن عم (محايدة جنسانيا)', 'Neef (geslachtsneutraal)', 'Cousin (genre neutre)', 'Cousin (geschlechtsneutral)', 'Cugino (neutralità di genere)', 'Primo (neutro em termos de gênero)', 'Кузен (гендерно нейтральный)', 'Primo (neutral de género)', 'Kuzenim (cinsiyete aykırı)'),
(1057, 'grandparent_gender_neutral', '', 'Grandparent (gender neutral)', 'الجد (محايد جنسانيا)', 'Grootouder (geslachtsneutraal)', 'Grandparent (genre neutre)', 'Großeltern (geschlechtsneutral)', 'Nonno (neutralità di genere)', 'Avós (neutro em termos de gênero)', 'Бабушка и дедушка (гендерный нейтраль)', 'Abuelo (neutral de género)', 'Büyükbaba (cinsiyet eşitliği yok)'),
(1058, 'grandchild_gender_neutral', '', 'Grandchild (gender neutral)', 'حفيد (محايد جنسانيا)', 'Grootkind (geslachtsneutraal)', 'Petit-fils (genre neutre)', 'Enkelkind (geschlechtsneutral)', 'Nipote (neutralità di genere)', 'Neto (neutro em termos de gênero)', 'Внуки (гендерно нейтральные)', 'Nieto (neutral de género)', 'Torun (cinsiyete dayalı)'),
(1059, 'step_sibling_gender_neutral', '', 'Step-sibling (gender neutral)', 'أخوة الخطوة (محايدة جنسانيا)', 'Step-sibling (gender neutraal)', 'Échec-frère (genre neutre)', 'Schritt-Geschwister (geschlechtsneutral)', 'Step-sibling (gender neutral)', 'Irmão-irmão (neutro em termos de gênero)', 'Step-sibling (гендерно нейтральный)', 'Hermanastro (neutral de género)', 'Adım kardeş (cinsiyete dayalı)'),
(1060, 'step_parent_gender_neutral', '', 'Step-parent (gender neutral)', 'الخطوة الوالد (محايدة جنسانيا)', 'Step-parent (gender neutraal)', 'Step-parent (genre neutre)', 'Schritt-Elternteil (geschlechtsneutral)', 'Step-parent (neutralità di genere)', 'Etapa-pai (neutro em termos de gênero)', 'Пошаговый (гендерно нейтральный)', 'El padrastro (neutral de género)', 'Veli-ebeveyn (cinsiyete dayalı)'),
(1061, 'stepchild_gender_neutral', '', 'Stepchild (gender neutral)', 'ستيبشيلد (محايد جنسانيا)', 'Stepchild (gender neutraal)', 'Stepchild (genre neutre)', 'Stepchild (geschlechtsneutral)', 'Stepchild (genere neutro)', 'Stepchild (neutro em termos de gênero)', 'Stepchild (гендерно нейтральный)', 'Stepchild (neutral de género)', 'Üvey çocuk (cinsiyete aykırı)'),
(1062, 'sibling_in_law_gender_neutral', '', 'Sibling-in-law (gender neutral)', 'شقيق الزوج (محايد جنسانيا)', 'Sibling-in-law (gender neutraal)', 'Sage-frère (genre neutre)', 'Schwangerschaft (geschlechtsneutral)', 'Sibling-in-law (gender neutral)', 'Irmão-irmão (neutro em termos de gênero)', 'Сиблинг в законе (гендерно нейтральный)', 'Cuñados (neutral de género)', 'Kayın üstü (cinsiyete dayalı)'),
(1063, 'parent_in_law_gender_neutral', '', 'Parent-in-law (gender neutral)', 'الوالد (محايد جنسانيا)', 'Schoonmoeder (geslachtsneutraal)', 'Parent-en-loi (neutre pour le genre)', 'Schwiegertochter (geschlechtsneutral)', 'Genitore di sesso (neutralità di genere)', 'Sogro (neutro em termos de gênero)', 'Зять (гендерно нейтральный)', 'Suegro (neutral de género)', 'Kayınvalides (cinsiyet eşitli değil)'),
(1064, 'child_in_law_gender_neutral', '', 'Child-in-law (gender neutral)', 'صهر الطفل (محايد جنسانيا)', 'Schoonzoon (geslachtsneutraal)', 'Bien-être (genre neutre)', 'Schwiegervater (geschlechtsneutral)', 'Suono (neutrale di genere)', 'Nora (neutro em termos de gênero)', 'Тед (гендерно нейтральный)', 'Niño (s) (género neutral)', 'Kayın-kuşun (cinsiyet eşitli)'),
(1065, 'add_to_family', '', 'Add to family', 'إضافة إلى الأسرة', 'Voeg toe aan familie', 'Ajouter à la famille', 'Zu Familie hinzufügen', 'Aggiungi alla famiglia', 'Adicionar à família', 'Добавить в подборку', 'Añadir a la familia', 'Ailenize ekleyin'),
(1067, 'family_member', '', 'Family Member', 'عضو الأسرة', 'Familielid', 'Membre de la famille', 'Familienmitglied', 'Membro della famiglia', 'Membro da família', 'Член семьи', 'Miembro de la familia', 'Aile üyesi'),
(1068, 'family_members', '', 'Family members', 'أفراد الأسرة', 'Familieleden', 'Membres de la famille', 'Familienmitglieder', 'Membri della famiglia', 'Membros da família', 'Члены семьи', 'Miembros de la familia', 'Aile üyeleri'),
(1069, 'add_as', '', 'Add as', 'أضفه ك', 'Toevoegen als', 'Ajouter comme', 'Hinzufügen Als', 'Aggiungi come', 'Adicionar como', 'Добавить как', 'Agregar como', 'Olarak ekle'),
(1070, 'confirm_remove_family_member', '', 'Are you sure that you want to remove this member from your family?', 'هل تريد بالتأكيد إزالة هذا العضو من عائلتك؟', 'Weet u zeker dat u dit lid van uw familie wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ce membre de votre famille?', 'Sind Sie sicher, dass Sie dieses Mitglied aus Ihrer Familie entfernen möchten?', 'Sei sicuro di voler rimuovere questo membro dalla tua famiglia?', 'Tem certeza de que deseja remover esse membro da sua família?', 'Вы уверены, что хотите удалить этого участника из своей семьи?', '¿Estás seguro de que deseas eliminar este miembro de tu familia?', 'Bu üyeyi ailenden kaldırmak istediğinizden emin misiniz?'),
(1071, 'family_member_added', '', 'New member was successfully added to your family list!', 'تمت إضافة عضو جديد بنجاح إلى قائمة عائلتك!', 'Nieuw lid is succesvol toegevoegd aan je familielijst!', 'Un nouveau membre a été ajouté avec succès à votre liste de famille!', 'Neues Mitglied wurde erfolgreich zu Ihrer Familienliste hinzugefügt!', 'Nuovo membro è stato aggiunto con successo alla tua lista di famiglia!', 'Novo membro foi adicionado com sucesso à sua lista de família!', 'Новый член был успешно добавлен в список ваших семей!', '¡El nuevo miembro se agregó a su lista de familia!', 'Yeni üye, aileniz listesine başarıyla eklendi!'),
(1072, 'request_sent', '', 'Your request was successfully sent!', 'تم إرسال طلبك بنجاح!', 'Uw verzoek is succesvol verzonden!', 'Votre demande a été envoyée avec succès!', 'Ihre Anfrage wurde erfolgreich gesendet!', 'La tua richiesta è stata inviata con successo!', 'Seu pedido foi enviado com sucesso!', 'Ваш запрос был успешно отправлен!', '¡Su solicitud ha sido enviada correctamente!', 'Talebiniz başarıyla gönderildi!'),
(1073, 'request_accepted', '', 'Accepted your request to be your @', 'قبلت طلبك ليكون الخاص بك @', 'Geaccepteerd uw verzoek om uw @', 'A accepté votre demande pour être votre @', 'Akzeptiert Ihre Anfrage zu Ihrem @', 'Accettato la tua richiesta per essere il tuo @', 'Aceitou seu pedido para ser seu @', 'Принял ваш запрос как ваш @', 'Aceptado su solicitud para ser su @', '@ Olmak isteğinizi kabul ettiniz'),
(1074, 'sent_u_request', '', 'Listed you as his @', 'المدرجة لك كما له @', 'Heb je gezien als zijn @', NULL, 'Listed Sie als seine @', 'Ti ha elencato come suo @', 'Listou você como seu @', 'Перечислил вас как его @', 'Listado como su @', 'Seni onun @'),
(1075, 'requests', '', 'Requests', 'طلبات', 'verzoeken', 'Demandes', 'Anfragen', 'richieste', 'solicitações de', 'Запросы', 'Peticiones', 'İstekler'),
(1077, 'relation_with', '', 'In relations with ', 'في العلاقات مع', 'In relaties met', 'En relation avec', 'Im Zusammenhang mit', 'Nelle relazioni con', 'Em relação com', 'В отношениях с', 'En las relaciones con', 'Ile ilişkilerinde'),
(1078, 'married_to', '', 'Married to ', 'متزوج من', 'Getrouwd met', 'Marié à', 'Verheiratet mit', 'Sposato con', 'Casado com', 'В браке с', 'Casado con', 'Evli'),
(1079, 'engaged_to', '', 'Engaged to ', 'مخطوب ل', 'verloofd met', 'Fiancé à', 'verlobt mit', 'fidanzato con', 'noivo de', 'Помолвлены с', 'comprometido con', 'Etkileşim kurdu'),
(1080, 'relationship_status', '', 'Relationship Status ', 'الحالة الاجتماعية', 'Relatie status', 'Statut de la relation', 'Beziehungsstatus', 'stato delle relazioni', 'status de relacionamento', 'Семейное положение', 'estado civil', 'ilişki durumu'),
(1081, 'relationship_request', '', 'Relationship request ', 'طلب العلاقة', 'Verzoek om relatie', 'Demande de relation', 'Beziehungsanfrage', 'Richiesta di relazione', 'Pedido de relacionamento', 'Запрос на отношении', 'Solicitud de relación', 'Ilişki talebi'),
(1082, 'relhip_request_accepted', '', 'Accepted your request @ ', 'قبل طلبك @', 'Geaccepteerd uw aanvraag @', 'A accepté votre demande @', 'Akzeptiert Ihre Anfrage @', 'Accettato la tua richiesta @', 'Aceitou seu pedido @', 'Принял(а) ваш запрос @', 'Aceptado su solicitud @', 'İsteğiniz kabul edildi @'),
(1083, 'relation_rejected', '', 'rejected your relation request @', 'رفض طلب علاقتك @', 'Heeft uw relatieverzoek geweigerd @', 'Rejeté votre demande de relation @', 'Abgelehnt Ihre Beziehung Anfrage @', 'Ha respinto la tua richiesta di relazione @', 'Rejeitou sua solicitação de relacionamento @', 'Отклонил(a) ваш запрос отношения @', 'Rechazó su solicitud de relación @', 'Ilişki isteğini reddetti @'),
(1084, 'file_too_big', '', 'File size error: The file exceeds allowed the limit ({file_size}) and can not be uploaded.', 'خطأ في حجم الملف: يتجاوز الملف الحد المسموح به ({file_size}) ولا يمكن تحميله.', 'Bestandsgrootte fout: Het bestand overschrijdt de limiet toegestaan ​​({file_size}) en kan niet worden geüpload.', 'Erreur de taille de fichier: le fichier dépasse autorisé la limite ({image_fichier}) et ne peut pas être téléchargé.', 'Dateigrößenfehler: Die Datei überschreitet die Begrenzung ({file_size}) und kann nicht hochgeladen werden.', 'Errore di dimensione del file: il file supera il limite consentito ({file_size}) e non può essere caricato.', 'Erro de tamanho de arquivo: o arquivo excede permitido o limite ({file_size}) e não pode ser carregado.', 'Ошибка размера файла: файл превышает допустимый предел ({file_size}) и не может быть загружен.', 'Error de tamaño de archivo: El archivo excede el límite permitido ({file_size}) y no se puede cargar.', 'Dosya boyutu hatası: Dosya limiti aştı ({file_size}) ve yüklenemiyor.'),
(1085, 'file_not_supported', '', 'Unable to upload a file: This file type is not supported.', 'تعذر تحميل ملف: نوع الملف هذا غير متوافق.', 'Kan een bestand niet uploaden: dit bestandstype wordt niet ondersteund.', NULL, 'Kann eine Datei nicht hochladen: Dieser Dateityp wird nicht unterstützt.', 'Impossibile caricare un file: questo tipo di file non è supportato.', 'Não é possível carregar um arquivo: esse tipo de arquivo não é suportado.', 'Не удалось загрузить файл. Этот тип файла не поддерживается.', 'No se puede cargar un archivo: este tipo de archivo no es compatible.', 'Dosya yüklenemiyor: Bu dosya türü desteklenmiyor.'),
(1087, 'find_friends_nearby', '', 'Find friends', 'البحث عن أصدقاء', 'Zoek vrienden', 'Retrouver des amis', 'Freunde finden', 'Trova amici', 'Encontrar amigos', 'Найти друзей', 'Encontrar amigos', 'Arkadaşları bul'),
(1088, 'location_dist', '', 'Location distance', 'مسافة الموقع', 'Locatie afstand', 'Distance demplacement', 'Standortabstand', 'Distanza della posizione', 'Distância de localização', 'Месторасположение', 'Ubicación distancia', 'Yer mesafesi'),
(1089, 'close_to_u', '', 'close to you', 'قريب منك', 'dicht bij jou', 'près de vous', 'nah bei dir', 'vicino a te', 'perto de você', 'близко к тебе', 'cerca de usted', 'sana yakın'),
(1090, 'find_friends', '', 'Find friends', 'البحث عن أصدقاء', 'Zoek vrienden', 'Trouver des amis', 'Freunde finden', 'Trova amici', 'Encontrar amigos', 'Найти друзей', 'Encontrar amigos', 'Arkadaşları bul'),
(1091, 'distance', '', 'distance', 'مسافه: بعد', 'afstand', 'distance', 'Entfernung', 'distanza', 'distância', 'расстояние', 'distancia', 'mesafe'),
(1092, 'distance_from_u', '', 'distance from you', 'المسافة منك', 'Afstand van jou', 'Distance de vous', 'Entfernung von Ihnen', 'Distanza da te', 'Distância de você', 'Расстояние от вас', 'Distancia de ti', 'Senden uzaklık'),
(1093, 'show_location', '', 'Show location', 'إظهار الموقع', 'Toon locatie', NULL, 'Lage anzeigen', 'Mostra la posizione', 'Mostrar localização', 'Показать на карте', 'Mostrar ubicación', 'Yeri göster'),
(1094, 'share_my_location', '', 'Share my location with public?', 'هل تريد مشاركة موقعي مع الجمهور؟', 'Deel mijn locatie met publiek?', 'Partagez mon emplacement avec le public?', 'Teilen Sie meinen Standort mit der Öffentlichkeit?', 'Condividi la mia posizione con il pubblico?', 'Compartilhe minha localização com o público?', 'Поделитесь своим местоположением с публикой?', 'Compartir mi ubicación con público?', 'Konumumu halkla paylaşmak mı istiyorsunuz?'),
(1095, 'enter_valid_title', '', 'Please enter a valid title', 'يرجى إدخال عنوان صالح', 'Vul alstublieft een geldige titel in', 'Entrez un titre valide', 'Bitte geben Sie einen gültigen Titel ein', 'Si prega di inserire un titolo valido', 'Insira um título válido', 'Введите действительное название', 'Ingrese un título válido', 'Lütfen geçerli bir başlık girin'),
(1096, 'pay_per_click', '', 'Pay Per Click (${{PRICE}})', 'الدفع لكل نقرة (${{PRICE}})', 'Betaal per klik (${{PRICE}})', 'Pay Per Click (${{PRICE}})', 'Pay Per Click (${{PRICE}})', 'Pay Per Click (${{PRICE}})', 'Pay Per Click (${{PRICE}})', 'Платить за клик (${{PRICE}})', 'Pago por clic (${{PRICE}})', 'Tıklama başına Öde (${{PRICE}})'),
(1097, 'pay_per_imprssion', '', 'Pay Per Impression (${{PRICE}})', 'الدفع لكل ظهور (${{PRICE}})', 'Betaal per indruk (${{PRICE}})', 'Pay per Impression (${{PRICE}})', 'Pay per Impression (${{PRICE}})', 'Pay Per Impression (${{PRICE}})', 'Pague por impressão (${{PRICE}})', 'Платить за показ (${{PRICE}})', 'Pago por impresión (${{PRICE}})', 'Gösterim Başına Ödeme (${{PRICE}})'),
(1098, 'top_up', '', 'Top up', 'فوق حتى', 'Top up', 'Remplir', 'Nachfüllen', 'Riempire', 'Completar', 'Пополнить', 'Completar', 'Ekleyin'),
(1099, 'balance_is_0', '', 'Your current wallet balance is: 0, please top up your wallet to continue.', 'رصيد المحفظة الحالي هو: 0، يرجى متابعة محفظتك للمتابعة.', 'Uw huidige portemonneebalans is: 0, vul uw portemonnee aan om door te gaan.', 'Votre solde de portefeuille actuel est: 0, veuillez compléter votre portefeuille pour continuer.', 'Ihre aktuelle Brieftasche Gleichgewicht ist: 0, bitte nach oben Ihre Brieftasche, um fortzufahren.', 'Il tuo saldo attuale del portafoglio è: 0, ti preghiamo di riempire il portafoglio per continuare.', 'Seu saldo de carteira atual é: 0, por favor, complete sua carteira para continuar.', 'Ваш текущий баланс кошелька: 0, пожалуйста, пополните свой кошелек, чтобы продолжить.', 'Su saldo de cartera actual es: 0, por favor, recargue su cartera para continuar.', 'Mevcut cüzdan bakiyeniz: 0, devam etmek için lütfen cüzdanınızı doldurun.'),
(1100, 'messages_delete_confirmation', '', 'Are you sure you want to delete this conversation?', 'هل تريد بالتأكيد حذف هذه المحادثة؟', 'Weet u zeker dat u dit gesprek wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer cette conversation?', 'Sind Sie sicher, dass Sie diese Konversation löschen möchten?', 'Sei sicuro di voler eliminare questa conversazione?', 'Tem certeza de que deseja excluir esta conversa?', 'Вы действительно хотите удалить этот разговор?', '¿Seguro que quieres eliminar esta conversación?', 'Bu sohbeti silmek istediğinizden emin misiniz?'),
(1101, 'currency', '', 'Currency', 'دقة', 'Valuta', 'Devise', 'Währung', 'Moneta', 'Moeda', 'валюта', 'Moneda', 'Para birimi'),
(1102, 'friends_stories', '', 'Friends Stories', 'قصص الأصدقاء', 'Vriendenverhalen', NULL, 'Freunde Geschichten', 'Storie di amici', 'Histórias de amigos', 'Истории друзей', 'Historias de amigos', 'Arkadaş Hikayeleri'),
(1103, 'no_messages_here_yet', '', 'No messages yet here.', 'لا توجد رسائل حتى الآن.', 'Nog geen berichten hier.', NULL, 'Noch keine Mitteilungen.', 'Non ci sono ancora messaggi qui.', 'Ainda não há mensagens aqui.', 'Пока сообщений нет.', 'Aún no hay mensajes.', 'Henüz mesaj yok.'),
(1104, 'conver_deleted', '', 'Conversation has been deleted.', 'تم حذف المحادثة.', 'Conversatie is verwijderd.', 'La conversation a été supprimée.', 'Konversation wurde gelöscht.', 'La conversazione è stata eliminata.', 'A conversa foi excluída.', 'Разговор удален.', 'Se ha eliminado la conversación.', 'Sohbet silindi.'),
(1105, 'group_name_limit', '', 'Group name must be 4/15 characters', 'يجب أن يكون اسم المجموعة 4/15 حرفا', 'De groepsnaam moet 4/15 karakters zijn', 'Le nom du groupe doit comporter 4/15 caractères', 'Der Gruppenname muss 4/15 Zeichen lang sein', 'Il nome del gruppo deve essere di 4/15 caratteri', 'O nome do grupo deve ser de 4/15 caracteres', 'Имя группы должно быть 4/15 символов', 'El nombre del grupo debe tener 4/15 caracteres', 'Grup adı 4/15 karakter olmalıdır'),
(1106, 'group_avatar_image', '', 'Group avatar must be an image', 'يجب أن تكون الصورة الرمزية للمجموعة صورة', 'Groep avatar moet een afbeelding zijn', NULL, 'Gruppen-Avatar muss ein Bild sein', NULL, 'O avatar do grupo deve ser uma imagem', 'Групповой аватар должен быть изображением', 'El avatar del grupo debe ser una imagen', 'Grup avatar bir resim olmalı'),
(1107, 'explore', '', 'Explore', 'إستكشاف', 'Onderzoeken', 'Explorer', 'Erforschen', 'Esplorare', 'Explorar', 'Исследовать', 'Explorar', 'Keşfetmek'),
(1108, 'format_image', '', 'File Format image', 'تنسيق ملف الصورة', 'Bestandsformaat afbeelding', 'Image au format du fichier', 'Dateiformat Bild', 'Immagine del formato file', 'Imagem do formato do arquivo', 'Изображение формата файла', 'Imagen de formato de archivo', 'Dosya Biçimi resmi'),
(1109, 'format_video', '', 'File Format video', 'تنسيق ملف الفيديو', 'Bestandsformaat video', 'Format de fichier vidéo', 'Dateiformatvideo', 'Formato file video', 'Vídeo do formato do arquivo', 'Формат файла видео', 'Formato de archivo video', 'Dosya Biçimi videosu'),
(1110, 'video', '', 'Video', 'فيديو', 'Video', 'Vidéo', 'Video', 'video', 'Vídeo', 'видео', 'Vídeo', 'Video'),
(1111, 'video_player', '', 'VideoPlayer', 'مشغل فديوهات', 'Video speler', 'Lecteur vidéo', 'Videoplayer', 'Lettore video', 'VideoPlayer', 'Видео проигрыватель', 'Reproductor de video', 'Video oynatıcı'),
(1112, 'no_file_chosen', '', 'No file chosen', 'لم تقم باختيار ملف', 'Geen bestand gekozen', 'Aucun fichier choisi', 'Keine Datei ausgewählt', 'Nessun file scelto', 'Nenhum arquivo selecionado', 'Файл не выбран', 'Ningún archivo elegido', 'Dosya seçili değil'),
(1113, 'choose_file', '', 'Choose File', 'اختر ملف', 'Kies bestand', 'Choisir le fichier', 'Datei wählen', 'Scegli il file', 'Escolher arquivo', 'Выберите файл', 'Elija el archivo', 'Dosya seçin'),
(1114, 'media', '', 'Media File', 'ملف وسائط', 'Media bestand', 'Fichier multimédia', 'Mediendatei', 'File multimediale', 'Arquivo de mídia', 'Файл мультимедиа', 'Archivo multimedia', 'Medya dosyası'),
(1115, 'select_valid_img_vid', '', 'Media file is invalid. Please select a valid image or video', 'ملف الوسائط غير صالح. الرجاء تحديد صورة أو فيديو صالحين', 'Mediabestand is ongeldig. Selecteer een geldige afbeelding of video', 'Le fichier multimédia est invalide. Veuillez sélectionner une image ou une vidéo valide', 'Mediendatei ist ungültig. Bitte wählen Sie ein gültiges Bild oder Video aus', 'Il file multimediale non è valido. Si prega di selezionare unimmagine o un video valido', 'O arquivo de mídia é inválido. Selecione uma imagem ou vídeo válido', 'Недопустимый файл мультимедиа. Выберите действительное изображение или видео', 'El archivo multimedia no es válido. Seleccione una imagen o video válido', 'Medya dosyası geçersiz. Lütfen geçerli bir resim veya video seçin'),
(1116, 'select_valid_img', '', 'Media file is invalid. Please select a valid image', 'ملف الوسائط غير صالح. الرجاء تحديد صورة صالحة', 'Mediabestand is ongeldig. Selecteer een geldige afbeelding', 'Le fichier multimédia est invalide. Veuillez sélectionner une image valide', 'Mediendatei ist ungültig. Bitte wählen Sie ein gültiges Bild', 'Il file multimediale non è valido. Si prega di selezionare unimmagine valida', 'O arquivo de mídia é inválido. Selecione uma imagem válida', 'Недопустимый файл мультимедиа. Выберите действительное изображение', 'El archivo multimedia no es válido. Seleccione una imagen válida', 'Medya dosyası geçersiz. Lütfen geçerli bir resim seçin'),
(1117, 'select_valid_vid', '', 'Media file is invalid. Please select a valid video', 'ملف الوسائط غير صالح. الرجاء تحديد فيديو صالح', 'Mediabestand is ongeldig. Selecteer een geldige video', 'Le fichier multimédia est invalide. Veuillez sélectionner une vidéo valide', 'Mediendatei ist ungültig. Bitte wählen Sie ein gültiges Video aus', 'Il file multimediale non è valido. Si prega di selezionare un video valido', 'O arquivo de mídia é inválido. Selecione um vídeo válido', 'Недопустимый файл мультимедиа. Выберите действительное видео', 'El archivo multimedia no es válido. Seleccione un video válido', 'Medya dosyası geçersiz. Lütfen geçerli bir video seçin'),
(1118, 'drop_img_here', '', 'Drop Image Here', 'إسقاط الصورة هنا', 'Zet hier een afbeelding neer', 'Déposer limage ici', 'Bild hier ablegen', 'Rilascia limmagine qui', 'Largue a imagem aqui', 'Отбросьте изображение здесь', 'Dejar caer la imagen aquí', 'Buraya Resim Aç'),
(1119, 'or', '', 'OR', 'أو', 'OF', 'OU', 'ODER', 'O', 'OU', 'ИЛИ', 'O', 'VEYA'),
(1120, 'browse_to_upload', '', 'Browse To Upload', 'تصفح لتحميل', 'Blader naar uploaden', 'Parcourir pour télécharger', 'Durchsuchen zum Hochladen', 'Sfoglia per caricare', 'Navegue para carregar', 'Просмотр загрузки', 'Buscar para cargar', 'Yüklemeye Gözat'),
(1121, 'pr_completion', '', 'Profile Completion', 'الملف الشخصي الانتهاء', 'Profiel voltooiing', 'Achèvement du profil', 'Profil Fertigstellung', 'Completamento del profilo', 'Conclusão do perfil', 'Завершение профиля', 'Terminación del perfil', 'Profil Tamamlama'),
(1122, 'ad_pr_picture', '', 'Add your profile picture', 'إضافة صورة ملفك الشخصي', 'Voeg je profielfoto toe', 'Ajouter votre photo de profil', 'Fügen Sie Ihr Profilbild hinzu', 'Aggiungi la tua immagine del profilo', 'Adicione sua foto de perfil', 'Добавьте свое фото профиля', 'Agrega tu foto de perfil', 'Profil resmini ekle'),
(1123, 'add_ur_name', '', 'Add your name', 'أضف اسمك', 'Voeg je naam toe', 'Ajoutez votre nom', 'Fügen Sie Ihren Namen hinzu', 'Aggiungi il tuo nome', 'Adicione seu nome', 'Добавьте свое имя', 'Agrega tu nombre', 'Adınızı ekleyin'),
(1124, 'ad_ur_workplace', '', 'Add your workplace', 'أضف مكان عملك', 'Voeg uw werkplek toe', 'Ajoutez votre lieu de travail', 'Fügen Sie Ihren Arbeitsplatz hinzu', 'Aggiungi il tuo posto di lavoro', 'Adicione seu local de trabalho', 'Добавьте свое рабочее место', 'Agregue su lugar de trabajo', 'İş yerinizi ekleyin'),
(1125, 'ad_ur_country', '', 'Add your country', 'أضف بلدك', 'Voeg uw land toe', 'Ajoutez votre pays', 'Fügen Sie Ihr Land hinzu', 'Aggiungi il tuo paese', 'Adicione seu país', 'Добавьте свою страну', 'Agrega tu país', 'Ülkenizi ekle'),
(1126, 'ad_ur_address', '', 'Add your address', 'أضف عنوانك', 'Voeg uw adres toe', 'Ajoutez votre adresse', 'Fügen Sie Ihre Adresse hinzu', 'Aggiungi il tuo indirizzo', 'Adicione seu endereço', 'Добавьте свой адрес', 'Agrega tu dirección', 'Adresinizi ekleyin'),
(1127, 'e_sent_msg', '', 'Someone Send me a message', 'شخص أرسل لي رسالة', 'Iemand Stuur mij een bericht', 'Quelquun Envoyez moi un message', 'Jemand Senden Sie mir eine Nachricht', 'Qualcuno Inviami un messaggio', 'Alguém Envie-me uma mensagem', 'Кто-нибудь Послать мне сообщение', 'Alguien me envía un mensaje', 'Birisi bana bir mesaj gönder'),
(1128, 'send_money', '', 'Send money', 'إرسال الأموال', 'Stuur geld', 'Envoyer de largent', 'Geld schicken', 'Inviare soldi', 'Enviar dinheiro', 'Отправлять деньги', 'Enviar dinero', 'Para göndermek'),
(1129, 'u_send_money', '', 'You can send money to your friends, acquaintances or anyone', 'يمكنك إرسال الأموال إلى أصدقائك، معارفك أو أي شخص', 'Je kunt geld sturen naar je vrienden, kennissen of wie dan ook', 'Vous pouvez envoyer de largent à vos amis, connaissances ou nimporte qui', 'Sie können Geld an Ihre Freunde, Bekannten oder irgendjemanden senden', 'Puoi inviare denaro ai tuoi amici, conoscenti o chiunque altro', 'Você pode enviar dinheiro para seus amigos, conhecidos ou qualquer um', 'Вы можете отправлять деньги своим друзьям, знакомым или кому-либо', 'Puede enviar dinero a sus amigos, conocidos o cualquier persona', 'Arkadaşlarınız, tanıdıklarınız veya herhangi birisine para gönderebilirsiniz.'),
(1130, 'available_balance', '', 'Available balance', 'الرصيد المتوفر', 'Beschikbaar saldo', 'Solde disponible', 'Verfügbares Guthaben', 'Saldo disponibile', 'Saldo disponível', 'Доступные средства', 'Saldo disponible', 'Kalan bakiye'),
(1131, 'send_to', '', 'To who you want to send?', 'ارسل إلى', 'Verzenden naar', 'Envoyer à', 'Senden an', 'Inviare a', 'Enviar para', 'Отправить', 'Enviar a', 'Gönderildi'),
(1132, 'search_name_or_email', '', 'Search by username or email', 'البحث عن اسم المستخدم، والبريد الإلكتروني', 'Zoeken naar gebruikersnaam, e-mail', 'Recherche de nom dutilisateur, e-mail', 'Suchen Sie nach Benutzername, E-Mail', 'Cerca nome utente, e-mail', 'Procure por nome de usuário, e-mail', 'Поиск имени пользователя, электронной почты', 'Buscar nombre de usuario, correo electrónico', 'Kullanıcı adını, e-postasını ara'),
(1133, 'money_sent_to', '', 'Your money was successfully sent to', 'تم إرسال أموالك بنجاح إلى', 'Uw geld is succesvol verzonden naar', 'Votre argent a été envoyé avec succès à', 'Ihr Geld wurde erfolgreich an gesendet', 'Il tuo denaro è stato inviato con successo', 'Seu dinheiro foi enviado com sucesso para', 'Ваши деньги были успешно отправлены', 'Su dinero fue enviado exitosamente a', 'Paranız başarıyla gönderildi'),
(1134, 'sent_you', '', 'Sent you', 'ارسلت لك', 'Stuurde je', 'Vous a envoyé', 'Hat dich geschickt', 'Ti ho inviato', 'Enviei a você', 'Отправлено Вам', 'Enviado', 'Seni gönderdi'),
(1135, 'amount_exceded', '', 'The amount exceded your current balance!', 'المبلغ المستحق رصيدك الحالي!', 'Het bedrag overschreed je huidige saldo!', 'Le montant a dépassé votre solde actuel!', 'Der Betrag übertraf Ihr aktuelles Guthaben!', 'Limporto ha superato il tuo saldo attuale!', 'O valor excedeu o seu saldo atual!', 'Сумма превысила ваш текущий баланс!', '¡La cantidad excedió su saldo actual!', 'Miktar, şu anki bakiyenizi aştı!'),
(1136, 'custom_thumbnail', '', 'Custom Thumbnail', 'صورة مصغرة مخصصة', 'Aangepaste miniatuur', 'Miniature personnalisée', 'Benutzerdefiniertes Miniaturbild', 'Miniatura personalizzata', 'Miniatura personalizada', 'Пользовательская миниатюра', 'Miniatura personalizada', 'Özel Küçük Boy'),
(1137, 'cntc_limit_reached', '', 'You have reached your limit of {{CNTC_LIMIT}} friends!', 'لقد بلغت الحد المسموح به لعدد {{CNTC_LIMIT}} من الأصدقاء!', 'U heeft uw limiet van {{CNTC_LIMIT}} vrienden bereikt!', 'Vous avez atteint la limite de vos amis {{CNTC_LIMIT}}!', 'Du hast dein Limit von {{CNTC_LIMIT}} Freunden erreicht!', 'Hai raggiunto il limite di {{CNTC_LIMIT}} amici!', 'Você atingiu seu limite de amigos {{CNTC_LIMIT}}!', 'Вы достигли своего предела {{CNTC_LIMIT}} друзей!', '¡Has alcanzado el límite de {{CNTC_LIMIT}} amigos!', '{{CNTC_LIMIT}} arkadaşınızla ilgili sınırınıza ulaştınız!'),
(1150, 'people', '', 'People', 'اشخاص', 'Mensen', 'Gens', 'Menschen', 'Persone', 'Ludzie', 'люди', 'Gente', 'İnsanlar'),
(1151, 'nature', '', 'Nature', 'طبيعة', 'Natuur', 'La nature', 'Natur', 'Natura', 'Natura', 'Природа', 'Naturaleza', 'Doğa'),
(1152, 'share_to', '', 'Share to', 'مشاركة ل', 'Delen naar', 'Partager à', 'Teilen mit', 'Condividere a', 'Dzielić się z', 'Поделиться с', 'Compartir a', 'Ile paylaş'),
(1153, 'timeline', '', 'Timeline', 'الجدول الزمني', 'Tijdlijn', 'Chronologie', 'Zeitleiste', 'Sequenza temporale', 'Oś czasu', 'График', 'Cronología', 'Zaman çizelgesi'),
(1154, 'pinterest', '', 'Pinterest', 'موقع Pinterest', 'Pinterest', 'Pinterest', 'Pinterest', 'Pinterest', 'Pinterest', 'Pinterest', 'Pinterest', 'pinterest'),
(1155, 'group', '', 'Group', 'مجموعة', 'Groep', 'Groupe', 'Gruppe', 'Gruppo', 'Grupa', 'группа', 'Grupo', 'grup'),
(1156, 'pro_members', '', 'Pro Members', 'الأعضاء المحترفون', 'Pro-leden', 'Membres Pro', 'Pro Mitglieder', 'Membri Pro', 'Pro Członkowie', 'Пользователи', 'Miembros Pro', 'Profesyonel Üyeler'),
(1158, 'popular_posts', '', 'Popular Posts', 'منشورات شائعة', 'populaire posts', 'Messages populaires', 'Beliebte Beiträge', 'Post popolari', 'popularne posty', 'популярные посты', 'entradas populares', 'popüler gönderiler'),
(1159, 'duration', '', 'Duration', 'المدة الزمنية', 'Looptijd', 'Durée', 'Dauer', 'Durata', 'Trwanie', 'продолжительность', 'Duración', 'süre'),
(1160, 'pro_feature_control_profile', '', 'Pro features give you complete control over your profile.', 'تمنحك الميزات الاحترافية تحكمًا كاملاً في ملفك الشخصي.', 'Pro-functies geven u volledige controle over uw profiel.', 'Les fonctionnalités Pro vous donnent un contrôle total sur votre profil.', 'Pro-Funktionen geben Ihnen die vollständige Kontrolle über Ihr Profil.', 'Le funzionalità Pro ti danno il controllo completo sul tuo profilo.', 'Funkcje Pro zapewniają pełną kontrolę nad Twoim profilem.', 'Функции Pro дают вам полный контроль над вашим профилем.', 'Las funciones Pro le brindan un control total sobre su perfil.', 'Pro özellikleri profilinizde tam kontrol sağlar.'),
(1161, 'why_choose_pro', '', 'Why Choose PRO?', 'لماذا اخترت للمحترفين؟', 'Waarom kiezen voor PRO?', 'Pourquoi choisir PRO?', 'Warum wählen Sie PRO?', 'Perché scegliere PRO?', 'Dlaczego warto wybrać PRO?', 'Почему выбирают PRO?', '¿Por qué elegir PRO?', 'PRO Neden Tercih Edilir?'),
(1162, 'whatsapp', '', 'WhatsApp', 'ال WhatsApp', 'WhatsApp', 'WhatsApp', 'WhatsApp', 'WhatsApp', 'Whatsapp', 'WhatsApp', 'WhatsApp', 'Naber'),
(1164, 'post_login_requriement_dislike', '', 'Please log in to like, dislike, share and comment!', 'الرجاء تسجيل الدخول لإبداء الإعجاب ، وعدم الإعجاب ، والمشاركة والتعليق!', 'Meld u aan om leuk te vinden, niet leuk te vinden, te delen en te reageren!', 'Veuillez vous connecter pour aimer, ne pas aimer, partager et commenter!', 'Bitte einloggen um zu mögen, nicht mögen, teilen und kommentieren!', 'Effettua il login per piacere, non mi piace, condividi e commenta!', 'Por favor, faça o login para curtir, não gostar, compartilhar e comentar!', 'Пожалуйста, войдите в систему, чтобы не любить, делиться и комментировать!', 'Por favor inicie sesión para gustar, no me gusta, compartir y comentar!', 'Lütfen beğenmek, beğenmemek, paylaşmak ve yorum yapmak için giriş yapın!'),
(1165, 'post_login_requriement_none', '', 'Please log in to like, share and comment!', 'يرجى تسجيل الدخول لإبداء الإعجاب والمشاركة والتعليق!', 'Log in om leuk te vinden, delen en reageren!', 'Veuillez vous connecter pour aimer, partager et commenter!', 'Bitte einloggen um zu liken, teilen und kommentieren!', 'Effettua il login per piacere, condividere e commentare!', 'Por favor, faça o login para curtir, compartilhar e comentar!', 'Войдите, чтобы добавить, поделиться и прокомментировать!', 'Por favor inicie sesión para gustar, compartir y comentar!', 'Lütfen beğenmek, paylaşmak ve yorum yapmak için giriş yapın!'),
(1166, 'e_disliked_my_posts', '', 'Someone disliked my posts', 'شخص لم يعجبني مشاركاتي', 'Iemand vond mijn berichten niet leuk', NULL, 'Jemand hat meine Beiträge nicht gemocht', 'A qualcuno non sono piaciuti i miei post', 'Alguém não gostou de minhas postagens', 'Кто-то не любил мои сообщения', 'A alguien no le gustó mis publicaciones', 'Birisi yayınlarımı beğenmedi'),
(1167, 'edit_ads', '', 'Edit campaign', 'تحرير الإعلانات', 'Bewerk advertenties', 'Modifier les annonces', 'Anzeigen bearbeiten', 'Modifica annunci', 'Editar anúncios', 'Редактировать объявления', 'Editar anuncios', 'Reklamları düzenle'),
(1168, 'manage_ads', '', 'Manage ads', 'إدارة الإعلانات', 'Advertenties beheren', 'Gerer annonces', 'Anzeigen verwalten', 'Gestisci annunci', 'Gerenciar anúncios', 'Управление объявлениями', 'Administrar anuncios', 'Reklamları yönet'),
(1169, 'create_new_ads', '', 'New campaign', 'إنشاء إعلان جديد', 'Maak een nieuwe advertentie', 'Créer une nouvelle annonce', 'Erstellen Sie eine neue Anzeige', 'Crea un nuovo annuncio', 'Crie um novo anúncio', 'Создать новое объявление', 'Crear nuevo anuncio', 'Yeni reklam oluştur'),
(1170, 'create_events', '', 'Create new event', 'حدث جديد Craete', 'Craete nieuw evenement', 'Craete nouvel événement', 'Craete neues Ereignis', 'Craete nuovo evento', 'Novo evento Craete', 'Новое событие Craete', 'Nuevo evento de Craete', 'Craete yeni etkinlik'),
(1171, 'edit_event', '', 'Edit event', 'تحرير الحدث', 'Gebeurtenis bewerken', 'Modifier l&#039;événement', 'Veranstaltung bearbeiten', 'Modifica evento', 'Editar evento', 'Изменить событие', 'Editar evento', 'Etkinliği düzenle'),
(1172, 'event_going', '', 'Events Going', 'أحداث الذهاب', 'Evenementen gaan', 'Evénements', 'Veranstaltungen gehen', 'Eventi in corso', 'Eventos indo', 'События', 'Eventos en marcha', 'Olaylar Gidiyor'),
(1173, 'event_intersted', '', 'Events Interested', 'الأحداث المهتمة', 'Evenementen Geïnteresseerd', 'Événements intéressés', 'Veranstaltungen interessiert', 'Eventi interessati', 'Eventos Interessados', 'События', 'Eventos Interesados', 'İlgi Alanları'),
(1174, 'event_invited', '', 'Invited', 'دعوة', 'Uitgenodigd', 'Invité', 'Eingeladen', 'Invitato', 'Convidamos', 'приглашенный', 'Invitado', 'Davetli'),
(1175, 'events_past', '', 'Past Events', 'الأحداث الماضية', 'Vorige evenementen', 'Événements passés', 'Vergangene Ereignisse', 'Eventi passati', 'Eventos passados', 'Прошедшие события', 'Eventos pasados', 'Geçmiş Etkinlikler'),
(1176, 'events_upcoming', '', 'Upcoming Events', 'الأحداث القادمة', 'aankomende evenementen', 'évènements à venir', 'Kommende Veranstaltungen', 'Prossimi eventi', 'próximos eventos', 'Предстоящие События', 'Próximos Eventos', 'Yaklaşan Etkinlikler'),
(1177, 'crop_your_avatar', '', 'Crop your avatar', 'اقتصاص الصورة الرمزية الخاصة بك', 'Snijd je avatar bij', 'Recadrez votre avatar', 'Beschneide deinen Avatar', 'Ritaglia il tuo avatar', 'Recorte seu avatar', 'Обрезать аватар', 'Recorta tu avatar', 'Avatarını kırp'),
(1178, 'cookie_message', '', 'This website uses cookies to ensure you get the best experience on our website.', 'يستخدم موقع الويب هذا ملفات تعريف الارتباط لضمان حصولك على أفضل تجربة على موقعنا.', 'Deze website maakt gebruik van cookies om ervoor te zorgen dat u de beste ervaring op onze website krijgt.', 'Ce site utilise des cookies pour vous assurer la meilleure expérience sur notre site.', 'Diese Website verwendet Cookies, um sicherzustellen, dass Sie die beste Erfahrung auf unserer Website erhalten.', 'Questo sito Web utilizza i cookie per assicurarti di ottenere la migliore esperienza sul nostro sito web.', 'Este site usa cookies para garantir que você obtenha a melhor experiência em nosso site.', 'На этом веб-сайте используются файлы cookie, чтобы вы могли получить лучший опыт на нашем веб-сайте.', 'Este sitio web utiliza cookies para garantizar que obtenga la mejor experiencia en nuestro sitio web.', 'Bu web sitesi, web sitemizde en iyi deneyimi yaşamanızı sağlamak için çerezleri kullanır.'),
(1179, 'cookie_dismiss', '', 'Got It!', 'فهمتك!', 'Begrepen!', 'Je l&#039;ai!', 'Ich habs!', 'Fatto!', 'Consegui!', 'Понял!', '¡Lo tengo!', 'Anladım!'),
(1180, 'cookie_link', '', 'Learn More', 'أعرف أكثر', 'Kom meer te weten', 'Apprendre encore plus', 'Erfahren Sie mehr', 'Per saperne di più', 'Saber mais', 'Выучить больше', 'Aprende más', 'Daha fazla bilgi edin'),
(1181, 'terms_accept', '', 'Please agree to the Terms of use & Privacy Policy', 'يرجى الموافقة على شروط الاستخدام وسياسة الخصوصية', 'Ga akkoord met de gebruiksvoorwaarden en het privacybeleid', 'Veuillez accepter les conditions d&#039;utilisation et la politique de confidentialité', 'Bitte stimme den Nutzungsbedingungen und Datenschutzrichtlinien zu', 'Si prega di accettare i Termini d&#039;uso e l&#039;informativa sulla privacy', 'Por favor, aceite os Termos de Uso e Política de Privacidade', 'Пожалуйста, соглашайтесь с Условиями использования и Политикой конфиденциальности', 'Acepta los Términos de uso y la Política de privacidad', 'Lütfen Kullanım Koşulları ve Gizlilik Politikasını kabul edin'),
(1182, 'good_morning', '', 'Good morning', 'صباح الخير', 'Goedemorgen', 'Bonjour', 'Guten Morgen', 'Buongiorno', 'Bom Dia', 'Доброе утро', 'Buenos días', 'Günaydın'),
(1183, 'good_afternoon', '', 'Good afternoon', 'طاب مسائك', 'Goedenmiddag', 'bonne après-midi', 'guten Tag', 'Buon pomeriggio', 'Boa tarde', 'Добрый день', 'Buenas tardes', 'Tünaydın'),
(1184, 'good_evening', '', 'Good evening', 'مساء الخير', 'Goedenavond', 'Bonsoir', 'Guten Abend', 'Buonasera', 'Boa noite', 'Добрый вечер', 'Buenas tardes', 'İyi akşamlar'),
(1185, 'create_ads', '', 'Create advertisement', 'إنشاء الإعلان', 'Maak advertentie', 'Créer une publicité', 'Erstellen Sie Werbung', 'Crea pubblicità', 'Criar anúncio', 'Создать рекламу', 'Crear publicidad', 'Reklam oluştur'),
(1187, 'phonenumber_exists', '', 'phone number already exists.', 'رقم الهاتف موجود بالفعل.', 'telefoonnummer bestaat al', 'le numéro de téléphone existe déjà.', 'Telefonnummer existiert bereits.', 'il numero di telefono Ã¨ giÃ  esistente', 'número de telefone já existe.', 'номер телефона уже существует.', 'número de teléfono ya existe', 'telefon numarası zaten mevcut.'),
(1188, 'recover_password_by_email', '', 'Recover by email', 'الاسترداد عن طريق البريد الإلكتروني', 'Herstel per e-mail', 'Récupérer par email', 'Wiederherstellen per E-Mail', 'Recupera per email', 'Recuperar por email', 'Восстановление по электронной почте', 'Recuperar por correo electrónico', 'E-posta ile kurtar'),
(1189, 'recover_password_by_sms', '', 'Recover by SMS', 'استرداد عن طريق الرسائل القصيرة', 'Herstel via sms', 'Récupérer par sms', 'Wiederherstellen per SMS', 'Recupera per sms', 'Recuperar por sms', 'Восстановление по SMS', 'Recuperar por SMS', 'Sms ile kurtarma'),
(1190, 'phonenumber_not_found', '', 'The phone number is not found', 'رقم الهاتف غير موجود', 'Het telefoonnummer kan niet worden gevonden', 'Le numéro de téléphone est introuvable', 'Die Telefonnummer wurde nicht gefunden', 'Il numero di telefono non Ã¨ stato trovato', 'O número de telefone não foi encontrado', 'Номер телефона не найден', 'El número de teléfono no se encuentra', 'Telefon numarası bulunamadı'),
(1191, 'phone_invalid_characters', '', 'The phone number is invalid', 'رقم الهاتف غير صالح أو يحتوي على أحرف', 'Het telefoonnummer is ongeldig of heeft tekens', 'Le numéro de téléphone est invalide ou contient des caractères', 'Die Telefonnummer ist ungültig oder hat Zeichen', 'Il numero di telefono non Ã¨ valido o contiene caratteri', 'O número de telefone é inválido ou tem caracteres', 'Недопустимый номер телефона.', 'El número telefónico es inválido', 'Telefon numarası geçersiz veya karakterleri var'),
(1192, 'recoversms_sent', '', 'Recover SMS has been sent successfully', 'تم إرسال رسالة SMS الاسترداد بنجاح', 'Recover SMS is succesvol verzonden', 'Récupérer des SMS a été envoyé avec succès', 'SMS wiederherstellen wurde erfolgreich gesendet', 'Recover SMS Ã¨ stato inviato con successo', 'Recuperar SMS foi enviado com sucesso', 'Восстановление SMS отправлено успешно', 'Recuperar SMS ha sido enviado con éxito', 'Recover SMS başarıyla gönderildi'),
(1193, 'transaction_log', '', 'Transactions', 'المعاملات', 'transacties', 'Transactions', 'Transaktionen', 'Le transazioni', 'Transações', 'операции', 'Actas', 'işlemler'),
(1194, 'v2latest_activities', '', 'Latest activities', 'أحدث الأنشطة', 'Laatste activiteiten', 'Dernières activités', 'Neueste Aktivitäten', 'Ultime attivitÃ', 'Últimas atividades', 'Последние мероприятия', 'Últimas actividades', 'Son etkinlikler'),
(1195, 'v2wallettopup', '', 'Wallet Topup', 'Wallet Topup', 'Portemonnee-opwaardering', 'Portefeuille Topup', 'Brieftasche aufladen', 'Portafoglio Topup', 'Carteira Topup', 'В корзину', 'Última recarga de billetera', 'Cüzdan Toplaması'),
(1196, 'v2adsspentdaily', '', 'Ads spent daily', 'الإعلانات التي تنفق يوميا', 'Advertenties die dagelijks worden besteed', 'Annonces dépensées quotidiennement', 'Anzeigen täglich ausgegeben', 'Annunci spesi ogni giorno', 'Anúncios gastos diariamente', 'Объявления, потраченные ежедневно', 'Anuncios gastados diariamente', 'Günlük olarak harcanan reklamlar'),
(1197, 'v2prosystemtransactions', '', 'Pro system transactions', 'معاملات نظام برو', 'Pro systeemtransacties', 'Transactions système pro', 'Pro System Transaktionen', 'Transazioni di sistema Pro', 'Transações do sistema Pro', 'Про системные транзакции', 'Transacciones del sistema Pro', 'Pro sistem işlemleri'),
(1198, 'no_transactions_found', '', 'Looks like you don&#39;t have any transaction yet!', 'لم يتم العثور على أي معاملات', 'Geen transacties gevonden', 'Aucune transaction trouvée', 'Keine Transaktionen gefunden', 'Nessuna transazione trovata', 'Nenhuma transação encontrada', 'Не найдено транзакций', 'No se encontraron transacciones', 'İşlem bulunamadı'),
(1199, 'estimated_reach', '', 'Estimated reach', 'الوصول المقدر', 'Geschat bereik', 'Portée estimée', 'Geschätzte Reichweite', 'Portata stimata', 'Alcance estimado', 'Предполагаемый охват', 'Alcance estimado', 'Tahmini erişim'),
(1200, 'confirmation_code_is', '', 'Your confirmation code is', 'رمز التأكيد الخاص بك هو', 'Uw bevestigingscode is', 'Votre code de confirmation est', 'Ihr Bestätigungscode lautet', 'Il tuo codice di conferma Ã¨', 'Seu código de confirmação é', 'Ваш код подтверждения', 'Tu código de confirmación es', 'Onay kodunuz'),
(1201, 'website_use_cookies', '', 'This website uses cookies to ensure you get the best experience on our website.', 'يستخدم موقع الويب هذا ملفات تعريف الارتباط لضمان حصولك على أفضل تجربة على موقعنا.', 'Deze website maakt gebruik van cookies om ervoor te zorgen dat u de beste ervaring op onze website krijgt.', 'Ce site utilise des cookies pour vous garantir la meilleure expérience sur notre site.', 'Diese Website verwendet Cookies, um sicherzustellen, dass Sie die beste Erfahrung auf unserer Website erhalten.', 'Questo sito Web utilizza i cookie per assicurarti di ottenere la migliore esperienza sul nostro sito web.', 'Este site usa cookies para garantir que você obtenha a melhor experiência em nosso site.', 'На этом веб-сайте используются файлы cookie, чтобы вы могли получить лучший опыт на нашем веб-сайте.', 'Este sitio web utiliza cookies para garantizar que obtenga la mejor experiencia en nuestro sitio web.', 'Bu web sitesi, web sitemizde en iyi deneyimi yaşamanızı sağlamak için çerezleri kullanır.'),
(1202, 'got_it', '', 'Got it!', 'فهمتك!', 'Begrepen!', 'Je l&#039;ai!', 'Ich habs!', 'Fatto!', 'Consegui!', 'Понял!', 'Lo tengo !', 'Anladım!'),
(1203, 'learn_more1', '', 'Learn more', 'أعرف أكثر', 'Kom meer te weten', 'Apprendre encore plus', 'Mehr erfahren', 'Per saperne di piÃ¹', 'Saber mais', 'Выучить больше', 'Aprende más', 'Daha fazla bilgi edin'),
(1204, 'poke_user', '', 'Poke', 'نكز', 'Por', 'Poussée', 'Sack', 'colpire', 'Cutucar', 'совать', 'Meter', 'dürtme'),
(1205, 'you_have_poked', '', 'You have poked', 'لقد نقزت', 'Je hebt geplooid', 'Vous avez fourré', 'Du hast Poked', 'Hai poked', 'Você cutucou', 'Вы ткнули', 'Has pinchado', 'poked var'),
(1206, 'no_pokes_found', '', 'No pokes to show', 'لم يتم العثور على نداءات', 'Geen pokes gevonden', 'Aucun coup trouvé', 'Keine Stichel gefunden', 'Nessun problema trovato', 'Nenhum poke encontrado', 'Ничего не найдено', 'No se encontraron golpes', 'Poke bulunamadı'),
(1207, 'people_who_poked_you', '', 'People who poked you', 'الناس الذين طعنك', 'Mensen die je hebben gepakt', 'Les gens qui vous ont piqué', 'Leute, die dich angestupst haben', 'Persone che ti hanno stuzzicato', 'Pessoas que te cutucaram', 'Люди, которые ткнули вас', 'Gente que te pinchó', 'Seni düren insanlar'),
(1208, 'poke_back', '', 'Poke back', 'أعد النظر', 'Terug prikken', 'Envoyer un poke en retour', 'Zurückstupsen', 'Colpisci', 'Puxar de volta', 'Откинуть назад', 'Empujar hacia atrás', 'Geri dürt'),
(1209, 'txt_poked', '', 'Poked!', 'مطعون!', 'Prikte!', 'Fourré!', 'Stocherte!', 'InfilÃ²!', 'Cutucado!', 'тыкат!', 'meter!', 'Dürttü!'),
(1210, 'pokes', '', 'Pokes', 'الوخزات', 'Pokes', 'Pokes', 'Pokes', 'poke', 'Puxões', 'тыкат', 'meter', 'Dürtmeler'),
(1211, 'popular_posts_comments', '', 'Popular posts &amp; comments', 'المشاركات الشعبية والتعليقات', 'Populaire berichten en reacties', 'Messages et commentaires populaires', 'Beliebte Posts &amp; Kommentare', 'Post e commenti popolari', 'Posts e comentários populares', 'Популярные сообщения и комментарии', 'Publicaciones populares y comentarios', 'Popüler yazılar ve yorumlar'),
(1212, 'load_more_videos', '', 'Load more videos', 'تحميل المزيد من أشرطة الفيديو', 'Laad meer video&#039;s', 'Charger plus de vidéos', 'Laden Sie mehr Videos', 'Carica altri video', 'Carregar mais vídeos', 'Загрузить видео', 'Cargar más videos', 'Daha fazla video yükle'),
(1213, 'load_more_photos', '', 'Load more photos', 'تحميل المزيد من الصور', 'Laad meer foto&#039;s', 'Charger plus de photos', 'Laden Sie mehr Fotos', 'Carica piÃ¹ foto', 'Carregar mais fotos', 'Загрузить больше фотографий', 'Cargar más fotos', 'Daha fazla fotoğraf yükle'),
(1214, 'no_more_videos_to_show', '', 'No more videos to show', 'لا مزيد من مقاطع الفيديو للعرض', 'geen video&#039;s meer om te laten zien', 'plus de vidéos à montrer', 'keine weiteren Videos zu zeigen', 'non piÃ¹ video da mostrare', 'não há mais vídeos para mostrar', 'Больше нет видео для показа', 'No más videos para mostrar', 'gösterilecek video yok');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1215, 'no_more_photos_to_show', '', 'No more photos to show', 'لا مزيد من الصور للعرض', 'geen foto&#039;s meer om te laten zien', 'plus de photos à montrer', 'keine weiteren Fotos zu zeigen', 'non piÃ¹ foto da mostrare', 'não há mais fotos para mostrar', 'Больше фотографий, чтобы показать', 'No más fotos para mostrar', 'gösterilecek başka fotoğraf yok'),
(1216, 'poked_you', '', 'Poked you', 'وكزتك', 'Prikte jou', 'Vous a Poké', 'Hat dich gestoßen', 'Ti ho mandato un poke', 'Tocou em você', 'Толкнул тебя', 'Te pinchó', 'Seni dürttü'),
(1217, 'gift_added', '', 'Gift added successfully', 'إضافة هدية بنجاح', 'Gift toevoegen succesvol', 'Cadeau ajouter avec succès', 'Geschenk wurde erfolgreich hinzugefügt', 'Regalo aggiunto con successo', 'Dom adicionar com sucesso', 'Подарок успешно добавлен', 'Regalo agregado con éxito', 'Hediye başarıyla eklendi'),
(1218, 'error_while_add_gift', '', 'Error while adding the gift', 'خطأ أثناء إضافة هدية', 'Fout bij het toevoegen van een cadeau', 'Erreur lors de l&#039;ajout d&#039;un cadeau', 'Fehler beim Hinzufügen eines Geschenks', 'Errore durante l&#039;aggiunta di un regalo', 'Erro ao adicionar um presente', 'Ошибка при добавлении подарка', 'Error al agregar el regalo', 'Hediye eklerken hata oluştu'),
(1219, 'send_a_gift', '', 'Send a gift', 'ارسل هدية', 'Verstuur een cadeau', 'Envoyer un cadeau', 'Ein Geschenk senden', 'Manda un regalo', 'Envie um presente', 'Отправить подарок', 'Enviar un regalo', 'Hediye gönder'),
(1220, 'gift_sent_succesfully', '', 'Gift sent successfully', 'الهدية ارسلت بنجاح', 'Gift met succes verzonden', 'Cadeau envoyé avec succès', 'Geschenk erfolgreich gesendet', 'Regalo inviato con successo', 'Presente enviado com sucesso', 'Подарок успешно отправлен', 'Regalo enviado con éxito', 'Hediye başarıyla gönderildi'),
(1221, 'send_gift_to_you', '', 'sent you a gift', 'أرسل لك هدية', 'Heeft je een geschenk gestuurd', 'Vous a envoyé un cadeau', 'Sende dir ein Geschenk', 'Ti ho mandato un regalo', 'Te mandei um presente', 'отправил вам подарок', 'te envió un regalo', 'Sana bir hediye gönderdi'),
(1222, 'my_pokes', '', 'My Pokes', 'بلدي Pokes', 'Mijn porren', 'Mes coups de coude', 'Meine Pokes', 'I miei PokÃ©', 'Meus puxões', 'Мои поры', 'My Pokes', 'Benim Pokes'),
(1223, 'telegram', '', 'Telegram', 'برقية', 'Telegram', 'Telegram', 'Telegram', 'Telegramma', 'Telegram', 'Телеграмма', 'Telegrama', 'Telgraf'),
(1224, 'no_more_posts_to_show', '', 'No more posts to show', 'لا مزيد من المشاركات للعرض', 'Geen posts meer om te laten zien', 'Plus de messages à afficher', 'Keine weiteren Posts zum Anzeigen', 'Non ci sono piÃ¹ post da mostrare', 'Não há mais postagens para mostrar', 'Нет больше сообщений для отображения', 'No hay más publicaciones para mostrar', 'Gösterilecek başka yayın yok'),
(1225, 'keyboard_shortcut_help', '', 'Keyboard shortcut help', 'تعليمات اختصار لوحة المفاتيح', 'Help voor sneltoetsen', 'Aide sur le raccourci clavier', 'Tastaturkürzel Hilfe', 'Guida rapida alla tastiera', 'Ajuda de atalhos de teclado', 'Краткий справочник по клавиатуре', 'Ayuda contextual de teclado', 'Klavye Kısayolu Yardımı'),
(1226, 'keyboard_shortcut_j', '', 'Scroll to the next post', 'انتقل إلى المشاركة التالية', 'Ga naar het volgende bericht', 'Faites défiler jusqu&#039;au prochain message', 'Scrolle zum nächsten Beitrag', 'Scorri fino al prossimo post', 'Vá até a próxima postagem', 'Перейдите к следующему сообщению', 'Desplazarse a la siguiente publicación', 'Bir sonraki gönderiye git'),
(1227, 'keyboard_shortcut_k', '', 'Scroll to the previous post', 'انتقل إلى الوظيفة السابقة', 'Ga naar het vorige bericht', 'Faites défiler jusqu&#039;au message précédent', 'Scrollen Sie zum vorherigen Beitrag', 'Scorri fino al post precedente', 'Role até a postagem anterior', 'Перейдите к предыдущему сообщению', 'Desplazarse a la publicación anterior', 'Önceki yayına git'),
(1228, 'sticker_added', '', 'Sticker added successfully', 'تمت إضافة الملصق بنجاح', 'Sticker met succes toegevoegd', 'Autocollant ajouté avec succès', 'Aufkleber erfolgreich hinzugefügt', 'Adesivo aggiunto con successo', 'Etiqueta adicionada com sucesso', 'Стикер добавлен успешно', 'Adhesivo agregado con éxito', 'Sticker başarıyla eklendi'),
(1229, 'error_while_add_sticker', '', 'Error while adding the sticker', 'حدث خطأ أثناء إضافة الملصق', 'Fout tijdens het toevoegen van de sticker', 'Erreur lors de l&#039;ajout de l&#039;autocollant', 'Fehler beim Hinzufügen des Aufklebers', 'Errore durante l&#039;aggiunta dell&#039;adesivo', 'Erro ao adicionar o adesivo', 'Ошибка при добавлении наклейки', 'Error al agregar la pegatina', 'Çıkartma eklenirken hata oluştu'),
(1230, 'reacted_to_your_post', '', 'reacted to your post', 'رد على مشاركتك', 'reageerde op je bericht', 'réagi à votre message', 'reagierte auf Ihren Posten', 'ha reagito al tuo post', 'reagiu ao seu post', 'отреагировал на ваш пост', 'reaccionado a tu publicación', 'yayına tepki gösterdi'),
(1231, 'points', '', 'Points', 'نقاط', 'punten', 'Points', 'Punkte', 'Punti', 'Pontos', 'Точки', 'Puntos', 'makas'),
(1232, 'my_points', '', 'My Points', 'نقاطي', 'Mijn punten', 'Mes points', 'Meine Punkte', 'I miei punti', 'Meus pontos', 'Мои очки', 'Mis puntos', 'Puanlarım'),
(1233, 'my_earnings', '', 'My Earnings', 'أجوري', 'mijn Inkomens', 'Mes gains', 'mein Einkommen', 'I miei guadagni', 'meus ganhos', 'мой заработок', 'Mis Ganancias', 'Kazançlarım'),
(1234, 'earn_text_like', '', 'Earn %d points by liking any post', 'اربح  %d نقطة عن طريق الإعجاب بأي مشاركة', 'Verdien %d punten door een post te waarderen', 'Gagnez %d points en aimant n&#039;importe quel poste', 'Verdiene %d Punkte, indem du jeden Beitrag magst', 'Guadagna %d punti gradendo qualsiasi post', 'Ganhe %d pontos por gostar de qualquer postagem', 'зарабатывать %d очков, любя любую запись', 'Ganar %d puntos por dar me gusta a cualquier publicación', 'Herhangi bir gönderiyi beğenerek %d puan kazan'),
(1235, 'earn_text_dislike', '', 'Earn %d points by disliking any post', 'اربح  %d من النقاط عن طريق عدم الإعجاب بأي مشاركة', 'Verdien %d punten door een post te negeren', 'Gagnez %d points en ne détestant aucun message', 'Verdienen Sie %d Punkte, indem Sie einen Beitrag ablehnen', 'Guadagna %d punti non amando nessun post', 'Ganhe %d pontos por não gostar de nenhum post', 'зарабатывать %d очков, не приветствуя любую должность', 'Ganar %d puntos por desagradar cualquier publicación', 'Herhangi bir gönderiyi beğenmediğinizde %d puan kazanın'),
(1236, 'earn_text_comment', '', 'Earn %d points by commenting any post', 'اربح  %d من خلال تعليق أي مشاركة', 'Verdien %d punten door een bericht te becommentariëren', 'Gagnez %d points en commentant n&#039;importe quel article', 'Verdiene %d Punkte, indem du einen Beitrag kommentierst', 'Guadagna %d punti commentando qualsiasi post', 'Ganhe %d pontos comentando qualquer post', 'зарабатывать %d указывает, комментируя любую запись', 'Ganar %d puntos al comentar cualquier publicación', 'Herhangi bir gönderiye yorum yaparak %d puan kazan'),
(1237, 'earn_text_wonder', '', 'Earn %d points by wondering any post', 'أربح  %d من النقاط بالتعجب عن أي مشاركة', 'Verdien %d punten door een bericht te vragen', 'Gagnez %d points en vous demandant n&#039;importe quel message', 'Verdienen Sie %d Punkte, indem Sie sich jeden Post fragen', 'Guadagna %d punti chiedendo qualsiasi post', 'Ganhe %d pontos imaginando qualquer postagem', 'зарабатывать %d очков, задаваясь вопросом о любом сообщении', 'Ganar %d puntos al preguntarse cualquier publicación', 'Herhangi bir gönderiyi merak ederek %d puan kazanın'),
(1238, 'earn_text_create_post', '', 'Earn %d points by creating a new post', 'اربح  %d نقطة عن طريق إنشاء منشور جديد', 'Verdien %d punten door een nieuw bericht te maken', 'Gagnez %d points en créant un nouveau message', 'Verdiene %d Punkte, indem du einen neuen Beitrag erstellst', 'Guadagna %d punti creando nuovi post', 'Ganhe %d pontos criando nova postagem', 'зарабатывать %d путем создания нового сообщения', 'Ganar %d puntos al crear una nueva publicación', 'Yeni gönderi oluşturarak %d puan kazanın'),
(1239, 'earn_text_reaction', '', 'Earn %d points by reacting on any post', 'اربح  %d نقطة عن طريق التفاعل على أي مشاركة', 'Verdien %d punten door op een bericht te reageren', 'Gagnez %d points en réagissant à n&#039;importe quel poste', 'Verdiene %d Punkte, indem du auf jeden Post reagierst', 'Guadagna %d punti reagendo su qualsiasi post', 'Ganhe %d pontos ao reagir em qualquer postagem', 'зарабатывать %d очков, реагируя на любую должность', 'Ganar %d puntos al reaccionar en cualquier publicación', 'Herhangi bir gönderiye yanıt vererek %d puan kazanın'),
(1240, 'no_reactions', '', 'No reactions yet', 'لا ردود أفعال حتى الآن', 'Nog geen reacties', 'Aucune réaction encore', 'Noch keine Reaktionen', 'Nessuna reazione ancora', 'Nenhuma reação ainda', 'Еще нет реакций', 'Aún no hay reacciones', 'Henüz tepki yok'),
(1241, 'love', '', 'Love', 'حب', 'Liefde', 'Amour', 'Liebe', 'Amore', 'Ame', 'Люблю', 'Amor', 'Aşk'),
(1242, 'haha', '', 'HaHa', 'هههه', 'HaHa', 'HaHa', 'HaHa', 'HaHa', 'HaHa', 'HaHa', 'HaHa', 'HaHa'),
(1243, 'wow', '', 'WoW', 'رائع', 'Wauw', 'Sensationnel', 'Beeindruckend', 'Wow', 'Uau', 'WoW', 'WoW', 'Vay'),
(1246, 'reacted_to_your_comment', '', 'reacted to your comment', 'رد على تعليقك', 'reageerde op je reactie', 'réagi à ton commentaire', 'reagierte auf Ihren Kommentar', 'ha reagito al tuo commento', 'reagiu ao seu comentário', 'отреагировал на ваш комментарий', 'reaccionó a tu comentario', 'Yorumunuza tepki gösterdi'),
(1247, 'reacted_to_your_replay', '', 'reacted to your reply', 'رد على ردك', 'reageerde op je antwoord', 'réagi à votre réponse', 'reagierte auf Ihre Antwort', 'ha reagito alla tua risposta', 'reagiu à sua resposta', 'отреагировал на ваш ответ', 'reaccionado a tu respuesta', 'cevabınıza tepki gösterdi'),
(1248, 'activity_reacted_post', '', 'reacted to {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'افتعل على  {user} &lt;a class=\\&quot;main-color\\&quot; href=\\&quot;{post}\\&quot;&gt;منشور&lt;/a&gt;.', 'reageerde op {user} &lt;a class=\\&quot;main-color\\&quot; href=\\&quot;{post}\\&quot;&gt;post&lt;/a&gt;.', 'réagi à {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt; poster &lt;/a&gt;.', 'reagierte auf {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;post&lt;/a&gt;.', 'ha reagito a {user} &lt;a class=\\&quot;main-color\\&quot; href=\\&quot;{post}\\&quot;&gt;post&lt;/a&gt;.', 'reagiu a {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt; postagem &lt;/a&gt;.', 'отреагировал на {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;после&lt;/a&gt;.', 'reaccionado a {user} &lt;a class=&quot;main-color&quot; href=&quot;{post}&quot;&gt;enviar&lt;/a&gt;.', '{user} &lt;a class=\\&quot;main-color\\&quot; href=\\&quot;{post}\\&quot;&gt;yayına&lt;/a&gt; tepki gösterdi.'),
(1249, 'comment_reported', '', 'Comment reported successfully.', 'تم الإبلاغ عن التعليق بنجاح.', 'Reactie succesvol gerapporteerd.', 'Commentaire signalé avec succès.', 'Kommentar erfolgreich gemeldet', 'Commento riportato con successo.', 'Comentário relatado com sucesso.', 'Комментарий успешно передан.', 'Comentario reportado con éxito', 'Yorum başarıyla bildirildi.'),
(1250, 'report_comment', '', 'Report comment', 'الإبلاغ عن تعليق', 'Rapporteer commentaar', 'Rapport de commentaire', 'Kommentar melden', 'Segnala commento', 'Reportar comentário', 'Сообщить модератору', 'Informar comentario', 'Yorumu bildir'),
(1251, 'comment_unreported', '', 'Report deleted successfully', 'تقرير تعليق حذف بنجاح', 'Commentaarrapport succesvol verwijderd', 'Supprimer le rapport de commentaire avec succès', 'Kommentarbericht erfolgreich löschen', 'Il rapporto di commento cancella con successo', 'Comentário comentário excluir com sucesso', 'Отчет удалён успешно', 'Informe borrado con éxito', 'Yorum raporu başarıyla silinsin'),
(1252, 'suggested_pages', '', 'Suggested pages', 'الصفحات المقترحة', 'Voorgestelde pagina&#039;s', 'Pages suggérées', 'Vorgeschlagene Seiten', 'Pagine suggerite', 'Páginas sugeridas', 'Предлагаемые страницы', 'Páginas sugeridas', 'Önerilen sayfalar'),
(1254, 'unverified', '', 'Unverified', 'غير مثبت عليه', 'geverifieerde', 'Non vérifié', 'Nicht überprüft', 'Non verificato', 'Não verificado', 'непроверенный', 'Inconfirmado', 'Doğrulanmamış'),
(1255, 'mutual_friends', '', 'Mutual Friends', 'الاصدقاء المشتركه', 'Gemeenschappelijke vrienden', 'Amis communs', 'Gemeinsame Freunde', 'Amici in comune', 'Amigos em comum', 'Общие друзья', 'Amigos en común', 'Ortak arkadaşlar'),
(1256, 'no_mutual_friends', '', 'No mutual friends to show', 'لم يتم العثور على أصدقاء مشتركين', 'Geen wederzijdse vrienden gevonden', 'Aucun ami commun trouvé', 'Keine gemeinsamen Freunde gefunden', 'Nessun amico comune trovato', 'Nenhum amigo em comum encontrado', 'Общих друзей не найдено', 'No se encontraron amigos en común', 'Karşılıklı arkadaş bulunamadı'),
(1257, 'viewed_your_story', '', 'viewed your story', 'ينظر قصتك', 'heb je verhaal bekeken', 'vu votre histoire', 'habe deine Geschichte gesehen', 'ho visto la tua storia', 'viu sua história', 'посмотрел ваш рассказ', 'visto tu historia', 'hikayeni inceledi'),
(1258, 'commented_on_blog', '', 'commented on your article', 'علق على مقالك', 'hebben gereageerd op je artikel', 'a commenté votre article', 'hat deinen Artikel kommentiert', 'ha commentato il tuo articolo', 'comentou no seu artigo', 'прокомментировал вашу статью', 'comentó tu artículo', 'makaleniz hakkında yorum yaptı'),
(1259, 'are_you_sure_unfriend', '', 'Are you sure you want to unfriend?', 'هل أنت متأكد أنك تريد غير صديق؟', 'Weet je zeker dat je wilt ontvrienden?', 'Êtes-vous sûr de vouloir vous libérer?', 'Bist du sicher, dass du dich unfreundst?', 'Sei sicuro di voler disapprovare?', 'Tem certeza de que quer desamor?', 'Вы уверены, что хотите недобросовестно?', '¿Estás seguro de que quieres unirte?', 'Arkadaşlık etmek istediğinden emin misin?'),
(1260, 'manage_sessions', '', 'Manage Sessions', 'إدارة الجلسات', 'Sessies beheren', 'Gérer les sessions', 'Sitzungen verwalten', 'Gestisci sessioni', 'Gerenciar Sessões', 'Управление сеансами', 'Administrar Sesiones', 'Oturumları Yönet'),
(1261, 'platform', '', 'Platform', 'برنامج', 'Platform', 'Plate-forme', 'Plattform', 'piattaforma', 'Plataforma', 'Платформа', 'Plataforma', 'platform'),
(1262, 'browser', '', 'Browser', 'المتصفح', 'browser', 'Navigateur', 'Browser', 'Browser', 'Navegador', 'браузер', 'Navegador', 'Tarayıcı'),
(1263, 'last_active', '', 'Last active', 'الماضي نشط', 'Laatst actief', 'Dernière activité', 'Letzte Aktivität', 'Ultimo attivo', 'Ativo pela última vez', 'Последнее посещение', 'Último Activo', 'Son aktif'),
(1264, 'notification_settings', '', 'Notification Settings', 'إعدادات الإشعار', 'Notificatie instellingen', 'Paramètres de notification', 'Benachrichtigungseinstellungen', 'Impostazioni di notifica', 'Configurações de notificação', 'Настройки уведомлений', 'Configuración de las notificaciones', 'Bildirim ayarları'),
(1265, 'notify_me_when', '', 'Notify me when', 'اعلمني عندما', 'Laat me weten wanneer', 'Me prévenir quand', 'Benachrichtigen Sie mich, wenn', 'Avvisami quando', 'Notifique-me quando', 'Уведомить меня, когда', 'Notifícame cuando', 'Ne zaman bana bildir'),
(1266, 'username_is_banned', '', 'The username is blacklisted and not allowed, please choose another username.', 'اسم المستخدم مدرج في القائمة السوداء وغير مسموح به ، يرجى اختيار اسم مستخدم آخر.', 'De gebruikersnaam staat op de zwarte lijst en is niet toegestaan, kies een andere gebruikersnaam.', 'Le nom d&#039;utilisateur est sur liste noire et n&#039;est pas autorisé, veuillez choisir un autre nom d&#039;utilisateur.', 'Der Benutzername ist auf der Blacklist und nicht erlaubt, bitte wähle einen anderen Benutzernamen.', 'Il nome utente Ã¨ nella lista nera e non Ã¨ permesso, per favore scegli un altro nome utente.', 'O nome de usuário está na lista negra e não é permitido, por favor, escolha outro nome de usuário.', 'Имя пользователя занесено в черный список и не разрешено, выберите другое имя пользователя.', 'El nombre de usuario está en la lista negra y no está permitido, elija otro nombre de usuario.', 'Kullanıcı adı kara listede ve izin verilmiyor, lütfen başka bir kullanıcı adı seçin.'),
(1267, 'email_is_banned', '', 'The email address is blacklisted and not allowed, please choose another email.', 'عنوان البريد الإلكتروني مدرج في القائمة السوداء وغير مسموح به ، يرجى اختيار بريد إلكتروني آخر.', 'Het e-mailadres staat op de zwarte lijst en is niet toegestaan, kies een andere e-mail.', 'L&#039;adresse e-mail est sur liste noire et n&#039;est pas autorisée, veuillez choisir un autre e-mail.', 'Die E-Mail-Adresse ist auf der schwarzen Liste und nicht erlaubt. Bitte wählen Sie eine andere E-Mail.', 'L&#039;indirizzo email Ã¨ nella lista nera e non Ã¨ consentito, per favore scegli un&#039;altra email.', 'O endereço de e-mail está na lista negra e não é permitido, por favor, escolha outro e-mail.', 'Адрес электронной почты занесен в черный список и не разрешен, выберите другое электронное письмо.', 'La dirección de correo electrónico está en la lista negra y no está permitida, elija otro correo electrónico.', 'E-posta adresi kara listeye alınmış ve izin verilmemiştir, lütfen başka bir e-posta adresi seçin.'),
(1268, 'activities', '', 'Activities', 'أنشطة', 'Activiteiten', 'Activités', 'Aktivitäten', 'attivitÃ', 'actividades', 'мероприятия', 'Ocupaciones', 'faaliyetler'),
(1269, 'activity_is_following', '', 'started following {user}', 'يتابع {user}', 'volgt {user}', 'suit {user}', 'folgt {user}', 'sta seguendo {utente}', 'está seguindo {user}', 'начал следовать {user}', 'comenzó a seguir {user}', '{user} takip ediyor'),
(1270, 'activity_is_friend', '', 'become friends with {user}', 'أصبح أصدقاء مع {user}', 'word vrienden met {user}', 'devenir amis avec {user}', 'Freunde werden mit {user}', 'diventare amici con {utente}', 'tornar-se amigo de {user}', 'дружить с {user}', 'hacerse amigo de {user}', '{user} ile arkadaş olun'),
(1271, 'index_my_page_privacy', '', 'Allow search engines to index my profile and posts?', 'السماح لمحركات البحث بفهرسة ملفي الشخصي والمشاركات؟', 'Sta zoekmachines toe mijn profiel en berichten te indexeren?', 'Autoriser les moteurs de recherche à indexer mon profil et mes publications?', 'Lassen Suchmaschinen mein Profil und Beiträge indizieren?', 'Permetti ai motori di ricerca di indicizzare il mio profilo e i miei post?', 'Permitir que os mecanismos de pesquisa indexem meu perfil e minhas postagens?', 'Разрешить поисковым системам индексировать мой профиль и сообщения?', '¿Permitir que los motores de búsqueda indexen mi perfil y mis publicaciones?', 'Arama motorlarının profilimi ve yayınlarımı dizine eklemesine izin verilsin mi?'),
(1272, 'mark_all_as_read', '', 'Mark all conversations as read', 'اجعل كل المحادثات مقروءة', 'Markeer alle gesprekken als gelezen', 'Marquer toutes les conversations comme lues', 'Markieren Sie alle Konversationen als gelesen', 'Segna tutte le conversazioni come letti', 'Marcar todas as conversas como lidas', 'Отметить все разговоры как прочитанные', 'Marcar todas las conversaciones como leídas', 'Tüm konuşmaları okundu olarak işaretle'),
(1273, 'havent_finished_post', '', 'You haven&#039;t finished your post yet. Do you want to leave without finishing?', 'لم تنته مشاركتك بعد. هل تريد المغادرة دون الانتهاء؟', 'Je hebt je bericht nog niet voltooid. Wil je vertrekken zonder te eindigen?', 'Vous n&#039;avez pas encore terminé votre message. Voulez-vous partir sans finir?', 'Du hast deinen Beitrag noch nicht beendet. Willst du ohne zu beenden gehen?', 'Non hai ancora finito il tuo post. Vuoi andartene senza finire?', 'Você ainda não terminou sua postagem. Você quer sair sem terminar?', 'Ты еще не закончил свой пост. Вы хотите уйти, не закончив?', 'Aún no has terminado tu publicación. ¿Quieres irte sin terminar?', 'Mesajınızı henüz bitirmediniz. Bitirmeden ayrılmak ister misin?'),
(1274, 'earned_points_goto', '', 'Your earned points will automatically go to', 'سوف تذهب تلقائيا النقاط الخاصة بك', 'Je verdiende punten gaan automatisch naar', 'Vos points gagnés iront automatiquement à', 'Ihre gesammelten Punkte werden automatisch an', 'I tuoi punti guadagnati andranno automaticamente a', 'Seus pontos ganhos irão automaticamente para', 'Ваши заработанные очки автоматически перейдут на', 'Tus puntos ganados irán automáticamente a', 'Kazanılan puanlarınız otomatik olarak'),
(1275, 'night_mode', '', 'Night mode', 'الوضع الليلي', 'Nachtstand', 'Mode nuit', 'Nacht-Modus', 'ModalitÃ  notturna', 'Modo noturno', 'Ночной режим', 'Modo nocturno', 'Gece modu'),
(1276, 'light_mode', '', 'Light mode', 'وضع الإضاءة', 'Lichtmodus', 'Mode léger', 'Lichtmodus', 'ModalitÃ  luce', 'Modo de luz', 'Режим освещения', 'Modo de luz', 'Işık modu'),
(1277, 'keyboard_shortcuts', '', 'Keyboard shortcuts', 'اختصارات لوحة المفاتيح', 'Toetsenbord sneltoetsen', 'Raccourcis clavier', 'Tastatürkürzel', 'Tasti rapidi', 'Atalhos do teclado', 'Горячие клавиши', 'Atajos de teclado', 'Klavye kısayolları'),
(1278, 'comment', '', 'Comment', 'تعليق', 'Commentaar', 'Commentaire', 'Kommentar', 'Commento', 'Comente', 'Комментарий', 'Comentario', 'Yorum Yap'),
(1279, 'write_something_here', '', 'Write something here..', 'اكتب شيئًا هنا ..', 'Schrijf hier iets ...', 'Ecrivez quelque chose ici ..', 'Schreib etwas hier ..', 'Scrivi qualcosa qui ..', 'Escreva alguma coisa aqui ..', 'Напишите что-нибудь здесь.', 'Escribe algo aquí ..', 'Burada bir şeyler yaz.'),
(1280, 'view_profile', '', 'View Profile', 'عرض الصفحة الشخصية', 'Bekijk profiel', 'Voir le profil', 'Profil anzeigen', 'Vedi profilo', 'Ver perfil', 'Просмотреть профиль', 'Ver perfil', 'Profili Görüntüle'),
(1281, 'block', '', 'Block', 'منع', 'Blok', 'Bloc', 'Block', 'Bloccare', 'Quadra', 'блок', 'Bloquear', 'Blok'),
(1282, 'create_page', '', 'Create Page', 'انشاء صفحة', 'Creëer pagina', 'Créer une page', 'Seite erstellen', 'Crea pagina', 'Criar página', 'Создать страницу', 'Crear página', 'Sayfa oluştur'),
(1283, 'create_group', '', 'Create Group', 'إنشاء مجموعة', 'Maak een groep', 'Créer un groupe', 'Gruppe erstellen', 'Creare un gruppo', 'Criar grupo', 'Создать группу', 'Crea un grupo', 'Grup oluştur'),
(1284, 'create_event', '', 'Create Event', 'انشاء حدث', 'Creëer evenement', 'Créer un évènement', 'Ereignis erstellen', 'Crea Evento', 'Criar Evento', 'Создать событие', 'Crear evento', 'Etkinlik oluşturmak'),
(1285, 'create_ad', '', 'Create Ad', 'أعلن', 'Maak advertentie', 'Créer une publicité', 'Anzeige erstellen', 'Crea annuncio', 'Criar um anúncio', 'Создать объявление', 'Crear anuncio', 'Reklam oluştur'),
(1286, 'create_blog', '', 'Create Blog', 'انشاء مدونة', 'Maak een blog', 'Créer un blog', 'Blog erstellen', 'Crea blog', 'Criar Blog', 'Создать блог', 'Blog creativo', 'Blog yarat'),
(1287, 'good_morning_quote', '', 'Every new day is a chance to change your life.', 'كل يوم جديد هو فرصة لتغيير حياتك.', 'Elke nieuwe dag is een kans om je leven te veranderen.', 'Chaque nouveau jour est une chance de changer de vie.', 'Jeder neue Tag ist eine Chance, dein Leben zu verändern.', 'Ogni nuovo giorno Ã¨ un&#039;opportunitÃ  per cambiare la tua vita.', 'Todo novo dia é uma chance de mudar sua vida.', 'Каждый новый день - это шанс изменить вашу жизнь.', 'Cada nuevo día es una oportunidad para cambiar tu vida.', 'Her yeni günde hayatınızı değiştirmek için bir şans.'),
(1288, 'good_afternoon_quote', '', 'May this afternoon be light, blessed, enlightened, productive and happy.', 'نرجو أن يكون هذا المساء خفيفًا ومباركًا ومستنيرًا ومنتجًا وسعيدًا.', 'Moge vanmiddag licht, gezegend, verlicht, productief en gelukkig zijn.', 'Puisse cet après-midi être léger, béni, éclairé, productif et heureux.', 'Möge heute Nachmittag hell, gesegnet, erleuchtet, produktiv und glücklich sein.', 'Possa questo pomeriggio essere leggero, benedetto, illuminato, produttivo e felice.', 'Que esta tarde seja leve, abençoada, iluminada, produtiva e feliz.', 'Пусть сегодня днем светлый, благословенный, просвещенный, продуктивный и счастливый.', 'Que esta tarde sea luz, bendita, iluminada, productiva y feliz.', 'Bu öğleden sonra hafif, kutsanmış, aydınlanmış, üretken ve mutlu olabilir.'),
(1289, 'good_evening_quote', '', 'Evenings are life’s way of saying that you are closer to your dreams.', 'الأمسيات هي طريقة الحياة للقول بأنك أقرب إلى أحلامك.', 'Avonden zijn de manier om te zeggen dat je dichter bij je dromen bent.', 'Les soirées sont la manière de la vie de dire que vous êtes plus proche de vos rêves.', 'Abende sind die Lebensart zu sagen, dass Sie Ihren Träumen näher sind.', 'Le sere sono il modo in cui la vita ti dice che sei piÃ¹ vicino ai tuoi sogni.', 'As noites são a maneira da vida de dizer que você está mais perto de seus sonhos.', 'Вечера - это способ жизни сказать, что вы ближе к своим мечтам.', 'Las noches son la forma en que la vida dice que estás más cerca de tus sueños.', 'Akşamlar yaşamın, hayallerinize daha yakın olduğunuzu söyleme biçimidir.'),
(1290, 'day_mode', '', 'Day mode', 'وضع اليوم', 'Dagmodus', 'Mode jour', 'Tagesmodus', 'ModalitÃ  giorno', 'Modo dia', 'Дневной режим', 'Modo día', 'Gündüz modu'),
(1291, 'disable_comments', '', 'Disable comments', 'تعطيل التعليقات', 'Schakel opmerkingen uit', 'Désactiver les commentaires', 'Kommentare deaktivieren', 'Disabilita commenti', 'Desativar comentários', 'Отключить комментарии', 'Desactivar Comentarios', 'Yorumları devre dışı bırak'),
(1292, 'enable_comments', '', 'Enable comments', 'تمكين التعليقات', 'Reacties inschakelen', 'Activer les commentaires', 'Kommentare aktivieren', 'Abilita commenti', 'Ativar comentários', 'Включить комментарии', 'Habilitar comentarios', 'Yorumları etkinleştir'),
(1293, 'comments_disabled', '', 'Comments are disabled by %d', 'التعليقات معطلة بواسطة d%', 'Reacties zijn uitgeschakeld door %d', 'Les commentaires sont désactivés par %d', 'Kommentare sind von %d deaktiviert', 'I commenti sono disabilitati da %d', 'Comentários desativados por %d', 'Комментарии отключены на %d', 'Los comentarios están deshabilitados por %d', 'Yorumlar %d tarafından devre dışı bırakıldı'),
(1294, 'confirm_your_account', '', 'Confirm your account', 'اكد حسابك', 'Bevestig je account', 'Confirmez votre compte', 'Bestätigen Sie ihr Konto', 'Conferma il tuo account', 'Confirme sua conta', 'Подтвердите свой аккаунт', 'Confirme su cuenta', 'Hesabını onayla'),
(1295, 'sign_in_attempt', '', 'Your sign in attempt seems a little different than usual, This could be because you are signing in from a different device or a different location.', 'تبدو محاولة تسجيل الدخول مختلفة قليلاً عن المعتاد ، وقد يرجع هذا إلى أنك تقوم بتسجيل الدخول من جهاز مختلف أو موقع مختلف.', 'Uw inlogpoging lijkt een beetje anders dan anders. Dit zou kunnen zijn omdat u zich aanmeldt vanaf een ander apparaat of een andere locatie.', 'Votre tentative de connexion semble légèrement différente de celle habituelle. Cela peut être dû au fait que vous vous connectez depuis un autre appareil ou un autre emplacement.', 'Ihr Anmeldeversuch scheint ein wenig anders als sonst. Dies könnte daran liegen, dass Sie sich von einem anderen Gerät oder einem anderen Standort aus anmelden.', 'Il tuo tentativo di accesso sembra leggermente diverso dal solito. Ciò potrebbe essere dovuto al fatto che stai effettuando l&#039;accesso da un dispositivo diverso o da un&#039;altra posizione.', 'Sua tentativa de login parece um pouco diferente do normal. Isso pode ter ocorrido porque você está fazendo login de um dispositivo diferente ou de um local diferente.', 'Ваша попытка входа выглядит немного иначе, чем обычно. Это может быть связано с тем, что вы входите с другого устройства или в другое место.', 'El intento de inicio de sesión parece un poco diferente de lo habitual. Esto podría deberse a que se está iniciando desde un dispositivo diferente o desde una ubicación diferente.', 'Oturum açma girişiminiz normalden biraz farklı görünüyor, Bunun nedeni farklı bir cihazdan veya farklı bir konumdan oturum açmanız olabilir.'),
(1296, 'we_have_sent_you_code', '', 'We have sent you an email with the confirmation code.', 'لقد أرسلنا لك رسالة إلكترونية تحتوي على رمز التأكيد.', 'We hebben u een e-mail gestuurd met de bevestigingscode.', 'Nous vous avons envoyé un email avec le code de confirmation.', 'Wir haben Ihnen eine E-Mail mit dem Bestätigungscode gesendet.', 'Ti abbiamo inviato un&#039;e-mail con il codice di conferma.', 'Enviamos um e-mail para você com o código de confirmação.', 'Мы отправили вам электронное письмо с кодом подтверждения.', 'Te hemos enviado un correo electrónico con el código de confirmación.', 'Onay kodunu içeren bir e-posta gönderdik.'),
(1297, 'two_factor', '', 'Two-factor authentication', 'توثيق ذو عاملين', 'Twee-factor-authenticatie', 'Authentification à deux facteurs', 'Zwei-Faktor-Authentifizierung', 'Autenticazione a due fattori', 'Autenticação de dois fatores', 'Двухфакторная аутентификация', 'Autenticación de dos factores', 'İki faktörlü kimlik doğrulama'),
(1298, 'to_log_in_two_factor', '', 'To log in, you need to verify your identity.', 'لتسجيل الدخول ، تحتاج إلى التحقق من هويتك.', 'Om u aan te melden, moet u uw identiteit verifiëren.', 'Pour vous connecter, vous devez vérifier votre identité.', 'Um sich einzuloggen, müssen Sie Ihre Identität bestätigen.', 'Per accedere, è necessario verificare la propria identità.', 'Para fazer login, você precisa verificar sua identidade.', 'Чтобы войти в систему, вам необходимо подтвердить свою личность.', 'Para iniciar sesión, necesita verificar su identidad.', 'Giriş yapmak için kimliğinizi doğrulamanız gerekir.'),
(1299, 'sent_two_factor_both', '', 'We have sent you the confirmation code to your phone and to your email address.', 'لقد أرسلنا إليك رمز التأكيد إلى هاتفك وإلى عنوان بريدك الإلكتروني.', 'We hebben je de bevestigingscode gestuurd naar je telefoon en naar je e-mailadres.', 'Nous vous avons envoyé le code de confirmation sur votre téléphone et sur votre adresse e-mail.', 'Wir haben Ihnen den Bestätigungscode an Ihr Telefon und an Ihre E-Mail-Adresse gesendet.', 'Ti abbiamo inviato il codice di conferma sul tuo telefono e sul tuo indirizzo email.', 'Enviamos o código de confirmação para o seu telefone e para o seu endereço de e-mail.', 'Мы отправили вам код подтверждения на ваш телефон и на ваш адрес электронной почты.', 'Le hemos enviado el código de confirmación a su teléfono y a su dirección de correo electrónico.', 'Size onay kodunu telefonunuza ve e-posta adresinize gönderdik.'),
(1300, 'sent_two_factor_email', '', 'We have sent you the confirmation code to your email address.', 'لقد أرسلنا إليك رمز التأكيد إلى عنوان بريدك الإلكتروني.', 'We hebben je de bevestigingscode gestuurd naar je e-mailadres.', 'Nous vous avons envoyé le code de confirmation à votre adresse e-mail.', 'Wir haben Ihnen den Bestätigungscode an Ihre E-Mail-Adresse gesendet.', 'Ti abbiamo inviato il codice di conferma al tuo indirizzo email.', 'Nós lhe enviamos o código de confirmação para o seu endereço de e-mail.', 'Мы отправили вам код подтверждения на ваш адрес электронной почты.', 'Le hemos enviado el código de confirmación a su dirección de correo electrónico.', 'Size e-posta adresinize onay kodunu gönderdik.'),
(1301, 'sent_two_factor_phone', '', 'We have sent you the confirmation code to your phone number.', 'لقد أرسلنا إليك رمز التأكيد إلى رقم هاتفك.', 'We hebben je de bevestigingscode naar je telefoonnummer gestuurd.', 'Nous vous avons envoyé le code de confirmation sur votre numéro de téléphone.', 'Wir haben Ihnen den Bestätigungscode an Ihre Telefonnummer gesendet.', 'Ti abbiamo inviato il codice di conferma al tuo numero di telefono.', 'Enviamos o código de confirmação para o seu número de telefone.', 'Мы отправили вам код подтверждения на ваш номер телефона.', 'Le hemos enviado el código de confirmación a su número de teléfono.', 'Telefon numaranıza onay kodunu gönderdik.'),
(1302, 'two_factor_description', '', 'Turn on 2-step login to level-up your account&#039;s security, Once turned on, you&#039;ll use both your password and a 6-digit security code sent to your phone or email to log in.', 'شغّل تسجيل الدخول المكوَّن من خطوتين لتحسين مستوى أمان حسابك ، وبمجرد تشغيله ، ستستخدم كل من كلمة المرور ورمز الأمان المكون من 6 أرقام والمرسلين إلى هاتفك أو بريدك الإلكتروني لتسجيل الدخول.', 'Schakel authenticatie in 2 stappen in om de beveiliging van uw account te verbeteren. Wanneer u eenmaal bent ingeschakeld, gebruikt u zowel uw wachtwoord als een uit 6 cijfers bestaande beveiligingscode die naar uw telefoon of e-mailadres is gestuurd om in te loggen.', 'Activez la connexion en deux étapes pour renforcer la sécurité de votre compte. Une fois activé, vous utiliserez votre mot de passe et un code de sécurité à 6 chiffres envoyé à votre téléphone ou à un courrier électronique pour vous connecter.', 'Aktivieren Sie die 2-stufige Anmeldung, um die Sicherheit Ihres Kontos zu erhöhen. Nach dem Einschalten verwenden Sie sowohl Ihr Passwort als auch einen 6-stelligen Sicherheitscode, der an Ihr Telefon oder Ihre E-Mail-Adresse gesendet wird, um sich anzumelden.', 'Attiva l&#039;accesso in due passaggi per aumentare la sicurezza del tuo account. Una volta attivato, utilizzerai sia la tua password sia un codice di sicurezza a 6 cifre inviato al tuo telefono o e-mail per accedere.', 'Ative o login em duas etapas para aumentar o nível de segurança da sua conta. Depois de ativada, você usará a senha e um código de segurança de seis dígitos enviados para o seu telefone ou e-mail para fazer login.', 'Включите двухэтапный вход для повышения безопасности своей учетной записи. После включения вы будете использовать как свой пароль, так и 6-значный код безопасности, отправленный на ваш телефон или электронную почту, чтобы войти в систему.', 'Active el inicio de sesión en 2 pasos para subir de nivel la seguridad de su cuenta. Una vez que lo haya hecho, utilizará su contraseña y un código de seguridad de 6 dígitos que se le enviará a su teléfono o correo electrónico para iniciar sesión.', 'Hesabınızın güvenliğini artırmak için 2 adımlı giriş özelliğini açın. Açtıktan sonra, giriş yapmak için hem şifrenizi hem de telefonunuza veya e-posta adresinize gönderilen 6 basamaklı bir güvenlik kodunu kullanırsınız.'),
(1303, 'my_campaigns', '', 'Campaigns', 'حملاتي', 'Mijn campagnes', 'Mes campagnes', 'Meine Kampagnen', 'Le mie campagne', 'Minhas Campanhas', 'Мои Кампании', 'Mis campañas', 'Kampanyalarım'),
(1304, 'my_wallet', '', 'Wallet & Credits', 'محفظتى', 'Mijn portemonnee', 'Mon portefeuille', 'Mein Geldbeutel', 'Il mio portafoglio', 'Minha carteira', 'Мой бумажник', 'Mi billetera', 'Cüzdanım'),
(1305, 'stats', '', 'Analytics', 'احصائيات', 'Stats', 'Statistiques', 'Statistiken', 'Statistiche', 'Estatísticas', 'Статистика', 'Estadísticas', 'İstatistikleri'),
(1306, 'choose_audience', '', 'Choose Audience', 'اختر الجمهور', 'Kies Doelgroep', 'Choisissez l&#039;audience', 'Wählen Sie Zielgruppe', 'Scegli il pubblico', 'Escolher Audiência', 'Выберите аудиторию', 'Elegir audiencia', 'Kitle Seç'),
(1307, 'launch_ad', '', 'Launch Ad', 'إطلاق الإعلان', 'Advertentie lanceren', 'Annonce de lancement', 'Anzeige starten', 'Avvia annuncio', 'Anúncio de lançamento', 'Запустить объявление', 'Anuncio de lanzamiento', 'Reklamı Başlat'),
(1308, 'pay_per_clicks', '', 'Pay Per Click', 'تدفع عن كل نقرة', 'Betaal per klik', 'Payer avec un clic', 'Pay Per Click', 'Pay per click', 'Pago por clique', 'Оплата за клик', 'Pago por clic', 'Tıklama başına ödeme'),
(1309, 'pay_per_imprssions', '', 'Pay Per Impression', 'ادفع لكل انطباع', 'Betaal per indruk', 'Pay Per Impression', 'Pay Per Impression', 'Paga per impressione', 'Pay Per Impression', 'Оплата за показ', 'Pago por impresión', 'Gösterim Başına Ödeme'),
(1310, 'explore_latest_articles', '', 'Explore the latest articles', 'استكشاف أحدث المقالات', 'Ontdek de nieuwste artikelen', 'Explorez les derniers articles', 'Entdecken Sie die neuesten Artikel', 'Esplora gli ultimi articoli', 'Explore os artigos mais recentes', 'Ознакомьтесь с последними статьями', 'Explora los últimos artículos', 'En son makaleleri keşfedin'),
(1311, 'search_for_article', '', 'Search for articles', 'البحث عن المقالات ..', 'Zoeken naar artikelen ..', 'Rechercher des articles ..', 'Artikel suchen ..', 'Cerca articoli ..', 'Procure por artigos ..', 'Поиск статей ..', 'Búsqueda de artículos ..', 'Makaleleri arayın ..'),
(1312, 'authors', '', 'Authors', 'المؤلفون', 'auteurs', 'Auteurs', 'Autoren', 'autori', 'Autores', 'Авторы', 'Autores', 'Yazarlar'),
(1313, 'news_feed', '', 'News Feed', 'تغذية الأخبار', 'Nieuwsfeed', 'Fil d&#039;actualité', 'Neuigkeiten', 'Notizie', 'Notícias', 'Новостная лента', 'Noticias', 'Haber akışı'),
(1314, 'video_call', '', 'Video call', 'مكالمة فيديو', 'Video-oproep', 'Appel vidéo', 'Videoanruf', 'Video chiamata', 'Video chamada', 'Видеозвонок', 'Videollamada', 'Görüntülü arama'),
(1315, 'open_in_new_tab', '', 'Open in new tab', 'فتح في علامة تبويب جديدة', 'Openen in nieuw tabblad', 'Ouvrir dans un nouvel onglet', 'In neuem Tab öffnen', 'Apri in una nuova scheda', 'Abrir em nova aba', 'Открыть в новой вкладке', 'Abrir en una pestaña nueva', 'Yeni sekmede aç'),
(1316, 'change_color', '', 'Change color', 'غير اللون', 'Verander kleur', 'Changer de couleur', 'Farbe ändern', 'Cambia colore', 'Mudar cor', 'Сменить цвет', 'Cambiar el color', 'Rengi değiştir'),
(1317, 'image', '', 'Image', 'صورة', 'Beeld', 'Image', 'Bild', 'Immagine', 'Imagem', 'Образ', 'Imagen', 'görüntü'),
(1318, 'voice', '', 'Voice', 'صوت', 'Stem', 'Voix', 'Stimme', 'Voce', 'Voz', 'голос', 'Voz', 'ses'),
(1319, 'gif', '', 'GIF', 'GIF', 'GIF', 'GIF', 'GIF', 'GIF', 'GIF', 'GIF', 'GIF', 'GIF'),
(1320, 'stickers', '', 'Stickers', 'ملصقات', 'stickers', 'Des autocollants', 'Aufkleber', 'Adesivi', 'Adesivos', 'Наклейки', 'Pegatinas', 'Çıkartma'),
(1321, 'stop', '', 'Stop', 'توقف', 'Hou op', 'Arrêtez', 'Halt', 'Stop', 'Pare', 'Стоп', 'Detener', 'durdurmak'),
(1322, 'contact_help', '', 'Let us help you solve your issue.', 'دعنا نساعدك في حل مشكلتك.', 'Laat ons u helpen met het oplossen van uw probleem.', 'Laissez-nous vous aider à résoudre votre problème.', 'Lassen Sie sich von uns bei der Lösung Ihres Problems unterstützen.', 'Lascia che ti aiutiamo a risolvere il tuo problema.', 'Deixe-nos ajudar você a resolver seu problema.', 'Позвольте нам помочь вам решить вашу проблему.', 'Permítanos ayudarle a resolver su problema.', 'Sorununuzu çözmenize yardımcı olalım.'),
(1323, 'info', '', 'Info', 'معلومات', 'info', 'Info', 'Info', 'Informazioni', 'Info', 'Информация', 'Información', 'Bilgi'),
(1324, 'users_found', '', 'users found', 'وجدت المستخدمين', 'gebruikers gevonden', 'utilisateurs trouvés', 'Benutzer gefunden', 'utenti trovati', 'usuários encontrados', 'пользователи нашли', 'usuarios encontrados', 'kullanıcılar bulundu'),
(1325, 'users_playing', '', 'users playing', 'يلعب المستخدمون', 'gebruikers spelen', 'utilisateurs jouant', 'spielende Benutzer', 'utenti che giocano', 'usuários jogando', 'пользователи играют', 'usuarios jugando', 'oynayan kullanıcılar'),
(1326, 'popular_games', '', 'Popular Games', 'العاب شعبية', 'Populaire spellen', 'Jeux populaires', 'Beliebte Spiele', 'Giochi popolari', 'Jogos Populares', 'Популярные игры', 'Juegos populares', 'Popüler Oyunlar'),
(1327, 'whats_happening', '', 'What&#039;s happening', 'ماذا يحدث', 'Wat is er gaande', 'Que ce passe-t-il', 'Was ist los', 'Cosa sta succedendo', 'O que está acontecendo', 'Что происходит', 'Qué esta pasando', 'Ne oluyor'),
(1328, 'discount', '', 'Discount', 'خصم', 'Korting', 'Remise', 'Rabatt', 'Sconto', 'Desconto', 'скидка', 'Descuento', 'İndirim'),
(1329, 'pick_your_plan', '', 'Pick your Plan', 'اختر خطتك', 'Kies je plan', 'Choisissez votre plan', 'Wähle deinen Plan aus', 'Scegli il tuo piano', 'Escolha seu plano', 'Выберите свой план', 'Elige tu plan', 'Planını Seç'),
(1330, 'trusted_payment_methods', '', 'Trusted payment methods', 'طرق الدفع الموثوقة', 'Betrouwbare betaalmethoden', 'Modes de paiement approuvés', 'Vertrauenswürdige Zahlungsmethoden', 'Metodi di pagamento affidabili', 'Métodos de pagamento confiáveis', 'Доверенные способы оплаты', 'Métodos de pago de confianza', 'Güvenilir ödeme yöntemleri'),
(1331, 'secure_payments', '', 'Secure payments', 'المدفوعات الآمنة', 'Veilige betalingen', 'Paiements sécurisés', 'Sichere Zahlungen', 'Pagamenti sicuri', 'Pagamentos Seguros', 'Безопасные платежи', 'Pagos seguros', 'Güvenli ödemeler'),
(1332, 'group_settings', '', 'Group Settings', 'إعدادات المجموعة', 'Groepsinstellingen', 'Paramètres de groupe', 'Gruppeneinstellungen', 'Impostazioni di gruppo', 'Configurações de Grupo', 'Настройки группы', 'Ajustes de grupo', 'Grup ayarları'),
(1333, 'page_settings', '', 'Page Settings', 'إعدادات الصفحة', 'Pagina-instellingen', 'Paramètres de page', 'Seiteneinstellungen', 'Impostazioni della pagina', 'Configurações de página', 'Настройки страницы', 'Configuración de página', 'Sayfa Ayarları'),
(1335, 'security', '', 'Security', 'الأمان', 'Veiligheid', 'Sécurité', 'Sicherheit', 'Sicurezza', 'Segurança', 'Безопасность', 'Seguridad', 'Güvenlik'),
(1336, 'earnings', '', 'Earnings', 'أرباح', 'verdiensten', 'Gains', 'Verdienste', 'guadagni', 'Ganhos', 'прибыль', 'Ganancias', 'Kazanç'),
(1337, 'open_original', '', 'Open original', 'فتح الأصلي', 'Open het origineel', 'Ouvrir l&#039;original', 'Original öffnen', 'Apri originale', 'Abrir original', 'Открыть оригинал', 'Abrir original', 'Orijinali aç'),
(1338, 'no_comments_found', '', 'No comments to show', 'لا توجد تعليقات', 'Geen reacties gevonden', 'Aucun commentaire trouvé', 'Keine Kommentare gefunden', 'Nessun commento trovato', 'Nenhum comentário encontrado', 'Комментариев не найдено', 'No se encontraron comentarios', 'Yorum bulunamadı'),
(1339, 'delete_conversation', '', 'Delete Conversation', 'مسح المحادثة', 'Verwijder gesprek', 'Supprimer la conversation', 'Konversation löschen', 'Cancella la conversazione', 'Apagar conversa', 'Удалить беседу', 'Eliminar la conversación', 'Konuşmayı sil'),
(1340, 'images', '', 'Images', 'صور', 'Afbeeldingen', 'Images', 'Bilder', 'immagini', 'Imagens', 'Изображений', 'Imágenes', 'Görüntüler'),
(1341, 'topics', '', 'Topics', 'المواضيع', 'Onderwerpen', 'Les sujets', 'Themen', 'Temi', 'Tópicos', 'темы', 'Los temas', 'Başlıklar'),
(1342, 'search_type', '', 'Search type', 'نوع البحث', 'Zoektype', 'Type de recherche', 'Suchtyp', 'Tipo di ricerca', 'Tipo de pesquisa', 'Тип поиска', 'Tipo de búsqueda', 'Arama Tipi'),
(1343, 'search_section', '', 'Search section', 'قسم البحث', 'Zoek sectie', 'Section de recherche', 'Suchbereich', 'Sezione di ricerca', 'Seção de pesquisa', 'Раздел поиска', 'Sección de búsqueda', 'Arama bölümü'),
(1344, 'watch_now', '', 'Watch Now', 'شاهد الآن', 'Kijk nu', 'Regarde maintenant', 'Schau jetzt', 'Guarda ora', 'Assista agora', 'Смотри', 'Ver ahora', 'İzle şimdi'),
(1345, 'new_product', '', 'New Product', 'منتج جديد', 'Nieuw product', 'Nouveau produit', 'Neues Produkt', 'Nuovo prodotto', 'Novo produto', 'Новый продукт', 'Nuevo producto', 'Yeni ürün'),
(1346, 'latest', '', 'Latest', 'آخر', 'Laatste', 'Dernier', 'Neueste', 'Più recente', 'Mais recentes', 'Самый последний', 'Último', 'son'),
(1347, 'price_low', '', 'Price Low', 'سعر منخفض', 'Prijs laag', 'Prix ​​bas', 'Preis niedrig', 'Prezzo basso', 'Preço baixo', 'Низкая цена', 'Precio bajo', 'Fiyat Düşük'),
(1348, 'price_high', '', 'Price High', 'سعر مرتفع', 'Prijs hoog', 'Prix ​​haut', 'Preis hoch', 'Prezzo alto', 'Preço alto', 'Высокая цена', 'Precio alto', 'Fiyat yüksek'),
(1349, 'view', '', 'View', 'رأي', 'Uitzicht', 'Vue', 'Aussicht', 'vista', 'Visão', 'Посмотреть', 'Ver', 'Görünüm'),
(1350, 'buy', '', 'Buy', 'يشترى', 'Kopen', 'Acheter', 'Kaufen', 'Acquistare', 'Comprar', 'купить', 'Comprar', 'satın almak'),
(1351, 'community', '', 'Community', 'تواصل اجتماعي', 'Gemeenschap', 'Communauté', 'Gemeinschaft', 'Comunità', 'Comunidade', 'сообщество', 'Comunidad', 'Topluluk'),
(1352, 'skip', '', 'Skip', 'تخطى', 'Overspringen', 'Sauter', 'Überspringen', 'Salta', 'Pular', 'Пропускать', 'Omitir', 'atlamak'),
(1353, 'choose_image', '', 'Choose Image', 'اختر صورة', 'Kies Afbeelding', 'Choisir une image', 'Bild auswählen', 'Scegli immagine', 'Escolher imagem', 'Выберите изображение', 'Elegir imagen', 'Resim Seç'),
(1354, 'upload_images', '', 'Upload Images', 'تحميل الصور', 'upload afbeeldingen', 'Importer des images', 'Bilder hochladen', 'Carica immagini', 'Enviar imagens', 'загрузить изображения', 'Subir imagenes', 'Resim Yükle'),
(1355, 'create_poll', '', 'Create Poll', 'إنشاء استطلاع', 'Maak peiling', 'Créer un sondage', 'Umfrage erstellen', 'Crea sondaggio', 'Criar enquete', 'Создать опрос', 'Crear encuesta', 'Anket Yarat'),
(1356, 'upload_video', '', 'Upload Video', 'رفع فيديو', 'Upload video', 'Télécharger une video', 'Video hochladen', 'Carica video', 'Envio vídeo', 'Загрузить видео', 'Subir video', 'Video yükle'),
(1357, 'create_post', '', 'Create post', 'إنشاء منشور', 'Maak bericht', 'Créer un post', 'Beitrag erstellen', 'Crea un post', 'Criar post', 'Создать пост', 'Crear publicación', 'Gönderi oluştur'),
(1358, 'record_voice', '', 'Record voice', 'سجل صوت', 'Spraak opnemen', 'Enregistrer la voix', 'Aufnahmestimme', 'Registra la voce', 'Gravar voz', 'Запись голоса', 'Grabar voz', 'Ses kaydı'),
(1359, 'feelings', '', 'Feelings', 'مشاعر', 'Gevoelens', 'Sentiments', 'Gefühle', 'sentimenti', 'Sentimentos', 'Чувства', 'Sentimientos', 'duygular'),
(1360, 'sell_product', '', 'Sell product', 'بيع المنتج', 'Verkoop product', 'Vendre un produit', 'Produkt verkaufen', 'Vendere il prodotto', 'Vender produto', 'Продать товар', 'Vender producto', 'Ürün satmak'),
(1361, 'upload_files', '', 'Upload Files', 'تحميل الملفات', 'Upload bestanden', 'Télécharger des fichiers', 'Daten hochladen', 'Caricare files', 'Fazer upload de arquivos', 'Загрузить файлы', 'Subir archivos', 'Dosyaları yükle'),
(1362, 'stories', '', 'Stories', 'قصص', 'verhalen', 'Histoires', 'Geschichten', 'Storie', 'Histórias', 'Рассказы', 'Cuentos', 'Hikayeler'),
(1363, 'create_story', '', 'Create new story', 'خلق قصة جديدة', 'Maak een nieuw verhaal', 'Créer une nouvelle histoire', 'Erstelle eine neue Geschichte', 'Crea una nuova storia', 'Crie uma nova história', 'Создать новую историю', 'Crear nueva historia', 'Yeni hikaye oluştur'),
(1364, 'no_more_views', '', 'No more views', 'لا مزيد من وجهات النظر', 'Geen zicht meer', 'Pas plus de vues', 'Keine weiteren Ansichten', 'Niente più visualizzazioni', 'Não há mais vistas', 'Нет больше просмотров', 'No mas vistas', 'Başka görüntü yok'),
(1365, 'whats_going', '', 'What is going on', 'ما الذي يجري', 'Wat is er aan de hand', 'Que se passe-t-il', 'Was ist los', 'Cosa sta succedendo', 'O que está acontecendo', 'Что здесь происходит', 'Que esta pasando', 'Ne oluyor'),
(1366, 'view_more_post', '', 'View {count} new post', 'عرض {count} مشاركة جديدة', 'Bekijk {count} nieuwe post', 'Voir {count} new post', '{count} neuen Beitrag anzeigen', 'Visualizza {count} nuovo post', 'Ver {count} nova postagem', 'Посмотреть {count} новое сообщение', 'Ver {count} nueva publicación', '{count} yeni yayınını görüntüleyin'),
(1367, 'my_info', '', 'My Information', 'معلوماتي', 'Mijn informatie', 'Mon information', 'Meine Information', 'Le mie informazioni', 'Minha informação', 'Моя информация', 'Mi informacion', 'Benim bilgim'),
(1368, 'to_download', '', 'Please choose which information you would like to download', 'يرجى اختيار المعلومات التي ترغب في تنزيلها', 'Kies alstublieft welke informatie u wilt downloaden', 'Veuillez choisir les informations que vous souhaitez télécharger', 'Bitte wählen Sie aus, welche Informationen Sie herunterladen möchten', 'Si prega di scegliere quali informazioni si desidera scaricare', 'Por favor escolha qual informação você gostaria de baixar', 'Пожалуйста, выберите, какую информацию вы хотели бы скачать', 'Por favor, elija la información que desea descargar', 'Lütfen hangi bilgileri indirmek istediğinizi seçin'),
(1369, 'download_file', '', 'Download', 'تحميل', 'Download', 'Télécharger', 'Herunterladen', 'Scaricare', 'Baixar', 'Скачать', 'Descargar', 'İndir'),
(1370, 'file_ready', '', 'Your file is ready to download!', 'ملفك جاهز للتنزيل!', 'Uw bestand is klaar om te downloaden!', 'Votre fichier est prêt à être téléchargé!', 'Ihre Datei steht zum Download bereit!', 'Il tuo file è pronto per il download!', 'Seu arquivo está pronto para download!', 'Ваш файл готов к загрузке!', 'Su archivo está listo para descargar!', 'Dosyanız indirilmeye hazır!'),
(1371, 'my_information', '', 'My Information', 'معلوماتي', 'Mijn informatie', 'Mon information', 'Meine Information', 'Le mie informazioni', 'Minha informação', 'Моя информация', 'Mi informacion', 'Benim bilgim'),
(1372, 'generate_file', '', 'Generate file', 'توليد الملف', 'Genereer bestand', 'Générer un fichier', 'Datei generieren', 'Genera file', 'Gerar arquivo', 'Создать файл', 'Generar archivo', 'Dosya oluştur'),
(1373, 'edit_group', 'Edit group', 'Edit group', 'تحرير المجموعة', 'Groep bewerken', 'Editer le groupe', 'Gruppe bearbeiten', 'Modifica gruppo', 'Editar grupo', 'Редактировать группу', 'Editar grupo', 'Grubu düzenle');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1374, 'adult_image_file', 'We have detected some adult content on the image you uploaded, therefore we have declined your uploa', 'We have detected some adult content on the image you uploaded, therefore we have declined your upload process.', 'لقد اكتشفنا بعض محتوى البالغين على الصورة التي قمت بتحميلها ، وبالتالي فقد رفضنا عملية التحميل.', 'We hebben een aantal inhoud voor volwassenen gevonden in de afbeelding die je hebt geüpload. Daarom hebben we je uploadproces geweigerd.', 'Nous avons détecté du contenu réservé aux adultes sur l&#039;image que vous avez téléchargée. Par conséquent, nous avons refusé votre processus de téléchargement.', 'Wir haben in dem von Ihnen hochgeladenen Bild einige Inhalte für Erwachsene gefunden. Daher haben wir Ihren Upload-Vorgang abgelehnt.', 'Abbiamo rilevato alcuni contenuti per adulti nell&#039;immagine caricata, pertanto abbiamo rifiutato la procedura di caricamento.', 'Detetámos algum conteúdo adulto na imagem que carregou, por isso, recusámos o seu processo de carregamento.', 'Мы обнаружили контент для взрослых на загруженном вами изображении, поэтому мы отклонили процесс загрузки.', 'Hemos detectado contenido para adultos en la imagen que subiste, por lo tanto, hemos rechazado tu proceso de carga.', 'Yüklediğiniz resimdeki bazı yetişkinlere uygun içerik tespit ettik, bu nedenle yükleme işleminizi reddetti.'),
(1375, 'view_image', 'View Image', 'View Image', 'عرض الصورة', 'Bekijk afbeelding', 'Voir l&#039;image', 'Bild ansehen', 'Guarda l&#039;immagine', 'Ver imagem', 'Посмотреть изображение', 'Ver imagen', 'Resmi görüntüle'),
(1376, 'phone_number_error', 'Phone number should be as this format: +90..', 'Phone number should be as this format: +90..', 'يجب أن يكون رقم الهاتف بهذا الشكل: +90 ..', 'Het telefoonnummer moet de volgende indeling hebben: +90 ..', 'Le numéro de téléphone doit être au format suivant: +90 ..', 'Die Telefonnummer sollte folgendes Format haben: +90 ..', 'Il numero di telefono deve essere in questo formato: +90 ..', 'Número de telefone deve ser como este formato: +90 ..', 'Номер телефона должен быть в таком формате: +90 ..', 'El número de teléfono debe tener este formato: +90 ..', 'Telefon numarası şu şekilde olmalıdır: +90 ..'),
(1377, 'something_wrong', 'Something went wrong, please try again later.', 'Something went wrong, please try again later.', 'هناك شئ خاطئ، يرجى المحاولة فى وقت لاحق.', 'Er is iets misgegaan. Probeer het later opnieuw.', 'Quelque chose c&#039;est mal passé. Merci d&#039;essayer plus tard.', 'Etwas ist schief gelaufen, bitte versuchen Sie es später erneut.', 'Qualcosa è andato storto, ti preghiamo di riprovare più tardi.', 'Algo deu errado, por favor, tente novamente mais tarde.', 'Что-то пошло не так. Пожалуйста, повторите попытку позже.', 'Algo salió mal, por favor intente de nuevo más tarde.', 'Bir şeyler yanlış oldu. Lütfen sonra tekrar deneyiniz.'),
(1378, 'confirmation_code', 'Confirmation code', 'Confirmation code', 'تأكيد الكود', 'Bevestigingscode', 'Code de confirmation', 'Bestätigungscode', 'Codice di conferma', 'Código de confirmação', 'Код для подтверждения', 'Código de confirmación', 'Onay kodu'),
(1379, 'your_phone_verified', 'Your phone number has been successfully verified.', 'Your phone number has been successfully verified.', 'تم التحقق من رقم هاتفك بنجاح.', 'Uw telefoonnummer is succesvol geverifieerd.', 'Votre numéro de téléphone a été vérifié avec succès.', 'Ihre Telefonnummer wurde erfolgreich verifiziert.', 'Il tuo numero di telefono è stato verificato con successo.', 'Seu número de telefone foi confirmado com sucesso.', 'Ваш номер телефона был успешно подтвержден.', 'Su número de teléfono ha sido verificado con éxito.', 'Telefon numaranız başarıyla doğrulandı.'),
(1380, 'your_email_verified', 'Your E-mail has been successfully verified.', 'Your E-mail has been successfully verified.', 'تم التحقق من بريدك الإلكتروني بنجاح.', 'Uw e-mail is succesvol geverifieerd.', 'Votre courriel a été vérifié avec succès.', 'Ihre E-Mail-Adresse wurde erfolgreich verifiziert.', 'La tua e-mail è stata verificata con successo.', 'Seu e-mail foi verificado com sucesso.', 'Ваш E-mail был успешно подтвержден.', 'Su correo electrónico ha sido verificado con éxito.', 'E-posta adresiniz başarıyla doğrulandı.'),
(1381, 'your_phone_email_verified', 'Your phone number and E-mail have been successfully verified.', 'Your phone number and E-mail have been successfully verified.', 'تم التحقق من رقم هاتفك والبريد الإلكتروني بنجاح.', 'Uw telefoonnummer en e-mail zijn succesvol geverifieerd.', 'Votre numéro de téléphone et votre adresse e-mail ont été vérifiés avec succès.', 'Ihre Telefonnummer und E-Mail-Adresse wurden erfolgreich verifiziert.', 'Il tuo numero di telefono e l&#039;e-mail sono stati verificati con successo.', 'Seu número de telefone e e-mail foram verificados com sucesso.', 'Ваш номер телефона и адрес электронной почты были успешно проверены.', 'Su número de teléfono y correo electrónico se han verificado con éxito.', 'Telefon numaranız ve E-posta adresiniz başarıyla doğrulandı.'),
(1382, 'confirmation_email_sent', 'A confirmation email has been sent.', 'A confirmation email has been sent.', 'تم إرسال رسالة تأكيد بالبريد الإلكتروني.', 'Er is een bevestigingsmail verzonden.', 'Un email de confirmation a été envoyé.', 'Eine Bestätigungs-E-Mail wurde gesendet.', 'È stata inviata una email di conferma.', 'Um email de confirmação foi enviado.', 'Письмо с подтверждением было отправлено.', 'Un correo electrónico de confirmación ha sido enviado.', 'Bir onay e-postası gönderildi.'),
(1383, 'confirmation_message_sent', 'A confirmation message was sent.', 'A confirmation message was sent.', 'تم إرسال رسالة تأكيد.', 'Er is een bevestigingsbericht verzonden.', 'Un message de confirmation a été envoyé.', 'Eine Bestätigungsnachricht wurde gesendet.', 'È stato inviato un messaggio di conferma.', 'Uma mensagem de confirmação foi enviada.', 'Подтверждение было отправлено.', 'Se envió un mensaje de confirmación.', 'Bir onay mesajı gönderildi.'),
(1384, 'confirmation_message_email_sent', 'A confirmation message and email were sent.', 'A confirmation message and email were sent.', 'تم إرسال رسالة تأكيد والبريد الإلكتروني.', 'Een bevestigingsbericht en e-mail zijn verzonden.', 'Un message de confirmation et un email ont été envoyés.', 'Eine Bestätigungsnachricht und eine E-Mail wurden gesendet.', 'Sono stati inviati un messaggio di conferma e un&#039;e-mail.', 'Uma mensagem de confirmação e email foram enviados.', 'Подтверждение и электронное письмо были отправлены.', 'Se envió un mensaje de confirmación y correo electrónico.', 'Bir onay mesajı ve e-posta gönderildi.'),
(1385, 'confirmation_email', 'We have sent an email that contains the confirmation code to verify your new email.', 'We have sent an email that contains the confirmation code to verify your new email.', 'لقد أرسلنا رسالة بريد إلكتروني تحتوي على رمز التأكيد للتحقق من بريدك الإلكتروني الجديد.', 'We hebben een e-mail gestuurd met de bevestigingscode om uw nieuwe e-mailadres te verifiëren.', 'Nous avons envoyé un email contenant le code de confirmation pour vérifier votre nouvel email.', 'Wir haben eine E-Mail mit dem Bestätigungscode zur Bestätigung Ihrer neuen E-Mail gesendet.', 'Abbiamo inviato un&#039;email che contiene il codice di conferma per verificare la tua nuova email.', 'Enviámos um email com o código de confirmação para confirmar o seu novo email.', 'Мы отправили письмо, содержащее код подтверждения, чтобы подтвердить ваш новый адрес электронной почты.', 'Hemos enviado un correo electrónico que contiene el código de confirmación para verificar su nuevo correo electrónico.', 'Yeni e-postanızı doğrulamak için onay kodunu içeren bir e-posta gönderdik.'),
(1386, 'confirmation_message', 'We have sent a message that contains the confirmation code to verify your new phone.', 'We have sent a message that contains the confirmation code to verify your new phone.', 'لقد أرسلنا رسالة تحتوي على رمز التأكيد للتحقق من هاتفك الجديد.', 'We hebben een bericht verzonden met de bevestigingscode om je nieuwe telefoon te verifiëren.', 'Nous avons envoyé un message contenant le code de confirmation pour vérifier votre nouveau téléphone.', 'Wir haben eine Nachricht mit dem Bestätigungscode zur Bestätigung Ihres neuen Telefons gesendet.', 'Abbiamo inviato un messaggio che contiene il codice di conferma per verificare il tuo nuovo telefono.', 'Enviamos uma mensagem que contém o código de confirmação para confirmar seu novo telefone.', 'Мы отправили сообщение с кодом подтверждения для подтверждения вашего нового телефона.', 'Hemos enviado un mensaje que contiene el código de confirmación para verificar su nuevo teléfono.', 'Yeni telefonunuzu doğrulamak için onay kodunu içeren bir mesaj gönderdik.'),
(1387, 'confirmation_email_message_text', 'We have sent a message and an email that contain the confirmation code to enable two-factor authenti', 'We have sent a message and an email that contain the confirmation code to enable two-factor authentication.', 'لقد أرسلنا رسالة ورسالة بريد إلكتروني تحتوي على رمز التأكيد لتمكين المصادقة الثنائية.', 'We hebben een bericht en een e-mail verzonden met de bevestigingscode om verificatie met twee factoren mogelijk te maken.', 'Nous avons envoyé un message et un courrier électronique contenant le code de confirmation pour permettre une authentification à deux facteurs.', 'Wir haben eine Nachricht und eine E-Mail mit dem Bestätigungscode für die Zwei-Faktor-Authentifizierung gesendet.', 'Abbiamo inviato un messaggio e un&#039;email contenente il codice di conferma per abilitare l&#039;autenticazione a due fattori.', 'Enviamos uma mensagem e um email que contém o código de confirmação para ativar a autenticação de dois fatores.', 'Мы отправили сообщение и электронное письмо с кодом подтверждения, чтобы включить двухфакторную аутентификацию.', 'Hemos enviado un mensaje y un correo electrónico que contiene el código de confirmación para habilitar la autenticación de dos factores.', 'İki faktörlü kimlik doğrulamayı etkinleştirmek için onay kodunu içeren bir mesaj ve e-posta gönderdik.'),
(1388, 'confirmation_email_text', 'We have sent an email that contains the confirmation code to enable Two-factor authentication.', 'We have sent an email that contains the confirmation code to enable Two-factor authentication.', 'لقد أرسلنا رسالة بريد إلكتروني تحتوي على رمز التأكيد لتمكين المصادقة الثنائية.', 'We hebben een e-mail gestuurd met de bevestigingscode om Two-factor-authenticatie in te schakelen.', 'Nous avons envoyé un courrier électronique contenant le code de confirmation pour activer l&#039;authentification à deux facteurs.', 'Wir haben eine E-Mail mit dem Bestätigungscode für die Zwei-Faktor-Authentifizierung gesendet.', 'Abbiamo inviato un messaggio di posta elettronica contenente il codice di conferma per abilitare l&#039;autenticazione a due fattori.', 'Enviamos um email que contém o código de confirmação para ativar a autenticação de dois fatores.', 'Мы отправили электронное письмо с кодом подтверждения для включения двухфакторной аутентификации.', 'Hemos enviado un correo electrónico que contiene el código de confirmación para habilitar la autenticación de dos factores.', 'İki faktörlü kimlik doğrulamayı etkinleştirmek için onay kodunu içeren bir e-posta gönderdik.'),
(1389, 'confirmation_message_text', 'We have sent a message that contains the confirmation code to enable Two-factor authentication.', 'We have sent a message that contains the confirmation code to enable Two-factor authentication.', 'لقد أرسلنا رسالة تحتوي على رمز التأكيد لتمكين المصادقة الثنائية.', 'We hebben een bericht verzonden met de bevestigingscode om tweeledige verificatie in te schakelen.', 'Nous avons envoyé un message contenant le code de confirmation pour activer l&#039;authentification à deux facteurs.', 'Wir haben eine Nachricht mit dem Bestätigungscode zur Aktivierung der Zwei-Faktor-Authentifizierung gesendet.', 'Abbiamo inviato un messaggio che contiene il codice di conferma per abilitare l&#039;autenticazione a due fattori.', 'Enviamos uma mensagem que contém o código de confirmação para ativar a autenticação de dois fatores.', 'Мы отправили сообщение с кодом подтверждения для включения двухфакторной аутентификации.', 'Hemos enviado un mensaje que contiene el código de confirmación para habilitar la autenticación de dos factores.', 'İki faktörlü kimlik doğrulamayı etkinleştirmek için onay kodunu içeren bir mesaj gönderdik.'),
(1390, 'share_post_on_group', 'Share post on a group', 'Share post on a group', 'مشاركة المشاركة على مجموعة', 'Deel bericht over een groep', 'Partager un post sur un groupe', 'Post in einer Gruppe teilen', 'Condividi post su un gruppo', 'Compartilhar postagem em um grupo', 'Поделиться постом в группе', 'Compartir publicación en un grupo', 'Bir gruptaki yayını paylaş'),
(1391, 'please_group_name', 'Please write the group name', 'Please write the group name', 'يرجى كتابة اسم المجموعة', 'Schrijf de groepsnaam op', 'S&#039;il vous plaît écrivez le nom du groupe', 'Bitte geben Sie den Gruppennamen an', 'Si prega di scrivere il nome del gruppo', 'Por favor, escreva o nome do grupo', 'Пожалуйста, напишите название группы', 'Por favor escriba el nombre del grupo', 'Lütfen grup adını yazınız'),
(1392, 'share_post_on_page', 'Share to a page', 'Share to a page', 'مشاركة إلى صفحة', 'Deel naar een pagina', 'Partager sur une page', 'Teilen Sie auf einer Seite', 'Condividi su una pagina', 'Compartilhar para uma página', 'Поделиться на странице', 'Compartir en una página', 'Bir sayfada paylaş'),
(1393, 'please_page_name', 'Please type the page name', 'Please type the page name', 'يرجى كتابة اسم الصفحة', 'Voer de paginanaam in', 'Veuillez taper le nom de la page', 'Bitte geben Sie den Seitennamen ein', 'Si prega di digitare il nome della pagina', 'Por favor, digite o nome da página', 'Пожалуйста, введите название страницы', 'Por favor escriba el nombre de la página', 'Lütfen sayfa adını yazın'),
(1394, 'share_post_on_user', 'Share to user', 'Share to user', 'حصة للمستخدم', 'Deel met gebruiker', 'Partager avec l&#039;utilisateur', 'Für den Benutzer freigeben', 'Condividi per l&#039;utente', 'Compartilhar para o usuário', 'Поделиться с пользователем', 'Compartir al usuario', 'Kullanıcıya paylaş'),
(1395, 'post_shared_successfully', 'Post has been successfully shared.', 'Post has been successfully shared.', 'تمت مشاركة المشاركة بنجاح.', 'Post is succesvol gedeeld.', 'La publication a été partagée avec succès.', 'Beitrag wurde erfolgreich geteilt.', 'Post è stato condiviso con successo.', 'Post foi compartilhado com sucesso.', 'Пост был успешно опубликован.', 'La publicación ha sido compartida con éxito.', 'Yayın başarıyla paylaşıldı.'),
(1396, 'to', 'To', 'To', 'إلى', 'Naar', 'À', 'Zu', 'A', 'Para', 'к', 'A', 'için'),
(1397, 'share_new_post', 'Share the post on', 'Share the post on', 'مشاركة المنشور على', 'Deel het bericht op', 'Partager le post sur', 'Teilen Sie den Beitrag auf', 'Condividi il post su', 'Compartilhe a postagem em', 'Поделиться постом на', 'Comparte la publicación en', 'Yayını paylaş'),
(1398, 'shared_a_post', 'shared a', 'shared a', 'شارك', 'gedeeld', 'partagé un', 'geteilt a', 'condiviso a', 'compartilhou um', 'поделился', 'compartió un', 'paylaştı'),
(1399, 'shared_your_post', 'shared your post', 'shared your post', 'شارك مشاركتك', 'heeft je bericht gedeeld', 'partagé votre post', 'hat deinen Beitrag geteilt', 'ha condiviso il tuo post', 'compartilhou sua postagem', 'поделился своим постом', 'compartió su publicación', 'yayınınızı paylaştı'),
(1400, 'shared_a_post_in_timeline', 'shared a post to your timeline', 'shared a post to your timeline', 'شارك منشورًا في الجدول الزمني الخاص بك', 'heeft een bericht gedeeld op je tijdlijn', 'partagé un post sur votre timeline', 'hat einen Beitrag auf Ihrer Timeline geteilt', 'ha condiviso un post sulla tua cronologia', 'compartilhou uma postagem na sua linha do tempo', 'поделился сообщением с вашей временной шкалой', 'compartió una publicación en su línea de tiempo', 'zaman çizelgenize bir yayın paylaştı'),
(1401, 'no_shared', 'No shares yet', 'No shares yet', 'لا يوجد سهم حتى الآن', 'Nog geen aandelen', 'Pas encore d&#039;actions', 'Noch keine Aktien', 'Nessuna azione ancora', 'Ainda sem ações', 'Еще нет акций', 'No hay acciones aún', 'Henüz paylaşım yok'),
(1402, 'member', 'Member', 'Member', 'عضو', 'Lid', 'Membre', 'Mitglied', 'Membro', 'Membro', 'член', 'Miembro', 'üye'),
(1403, 'pro_con', 'Congratulations ! You&#039;re now a', 'Congratulations ! You&#039;re now a', 'تهانينا ! انت الان', 'Gefeliciteerd! Je bent nu een', 'Toutes nos félicitations ! Vous êtes maintenant un', 'Herzliche Glückwünsche ! Du bist jetzt ein', 'Congratulazioni! Ora sei un', 'Parabéns! Você é agora um', 'Поздравляю! Теперь ты', 'Felicidades ! Ahora eres un', 'Tebrikler! Sen şimdi'),
(1404, 'other', 'Other', 'Other', 'آخر', 'anders', 'Autre', 'Andere', 'Altro', 'De outros', 'Другой', 'Otro', 'Diğer'),
(1405, 'all_', 'All', 'All', 'الكل', 'Allemaal', 'Tout', 'Alles', 'Tutti', 'Todos', 'Все', 'Todos', 'Herşey'),
(1406, 'users_liked_post', 'People liked this post', 'People liked this post', 'أحب الناس هذا المنصب', 'Mensen vonden deze post leuk', 'Les gens ont aimé ce post', 'Die Leute mochten diesen Beitrag', 'Alla gente è piaciuto questo post', 'Pessoas gostaram deste post', 'Людям понравился этот пост', 'A la gente le ha gustado esta publicación.', 'İnsanlar bu yayını beğendi'),
(1407, 'users_wondered_post', 'People wondered this post', 'People wondered this post', 'تساءل الناس هذا المنصب', 'Mensen vroegen zich af deze post', 'Les gens se demandaient ce post', 'Die Leute wunderten sich über diesen Beitrag', 'La gente si chiedeva questo post', 'As pessoas se perguntaram este post', 'Люди задавались вопросом этот пост', 'La gente se preguntaba esta publicación.', 'İnsanlar bu yayını merak etti'),
(1408, 'users_shared_post', 'People shared this post', 'People shared this post', 'شارك الناس هذا المنشور', 'Mensen hebben dit bericht gedeeld', 'Les gens ont partagé ce post', 'Die Leute haben diesen Beitrag geteilt', 'Le persone hanno condiviso questo post', 'As pessoas compartilharam esta postagem', 'Люди поделились этим постом', 'Personas compartieron esta publicación', 'İnsanlar bu yayını paylaştı'),
(1409, 'users_reacted_post', 'People reacted to this post', 'People reacted to this post', 'كان رد فعل الناس على هذا المنصب', 'Mensen reageerden op dit bericht', 'Les gens ont réagi à ce post', 'Die Leute haben auf diesen Beitrag reagiert', 'Le persone hanno reagito a questo post', 'As pessoas reagiram a este post', 'Люди отреагировали на этот пост', 'La gente reaccionó a este post.', 'İnsanlar bu yayına yanıt verdi'),
(1410, 'users_wondered_comment', 'People wondered this comment', 'People wondered this comment', 'تساءل الناس هذا التعليق', 'Mensen vroegen zich af deze opmerking', 'Les gens se demandaient ce commentaire', 'Die Leute wunderten sich über diesen Kommentar', 'La gente si chiedeva questo commento', 'As pessoas se perguntaram esse comentário', 'Люди задавались вопросом этот комментарий', 'La gente se pregunta este comentario.', 'İnsanlar bu yorumu merak etti'),
(1411, 'users_liked_comment', 'People liked this comment', 'People liked this comment', 'أحب الناس هذا التعليق', 'Mensen vonden deze reactie leuk', 'Les gens ont aimé ce commentaire', 'Die Leute mochten diesen Kommentar', 'Alla gente è piaciuto questo commento', 'Pessoas gostaram deste comentário', 'Людям понравился этот комментарий', 'La gente ha gustado este comentario.', 'İnsanlar bu yorumu beğendi'),
(1413, 'my', 'My', 'My', 'لي', 'Mijn', 'ma', 'Meine', 'Mio', 'Minhas', 'мой', 'Mi', 'Benim'),
(1414, 'bank_transfer', 'Bank transfer', 'Bank transfer', 'التحويل المصرفي', 'overschrijving', 'virement', 'Banküberweisung', 'trasferimento bancario', 'transferência bancária', 'банковский перевод', 'transferencia bancaria', 'banka transferi'),
(1415, 'bank_transfer_request', 'Your request has been successfully sent, we will notify you once it&#039;s approved', 'Your request has been successfully sent, we will notify you once it&#039;s approved', 'تم إرسال طلبك بنجاح ، وسوف نخطرك بمجرد الموافقة عليه', 'Uw verzoek is succesvol verzonden, wij zullen u op de hoogte brengen zodra het is goedgekeurd', 'Votre demande a été envoyée avec succès, nous vous en informerons une fois approuvée', 'Ihre Anfrage wurde erfolgreich gesendet, wir werden Sie benachrichtigen, sobald sie genehmigt wurde', 'La tua richiesta è stata inviata con successo, ti avviseremo una volta approvata', 'O seu pedido foi enviado com sucesso, iremos notificá-lo assim que for aprovado', 'Ваш запрос был успешно отправлен, мы сообщим вам, как только он будет одобрен', 'Su solicitud ha sido enviada exitosamente, le notificaremos una vez que sea aprobada.', 'İsteğiniz başarıyla gönderildi, onaylandıktan sonra sizi bilgilendireceğiz'),
(1416, 'bank_pro', 'Your bank receipt has been approved!', 'Your bank receipt has been approved!', 'تمت الموافقة على إيصالك المصرفي!', 'Uw bank-factuur is goedgekeurd!', 'Votre facture bancaire a été approuvée!', 'Ihre Bankquittung wurde genehmigt!', 'La tua ricevuta bancaria è stata approvata!', 'Seu recibo bancário foi aprovado!', 'Ваша банковская квитанция была подтверждена!', 'Su recibo bancario ha sido aprobado!', 'Banka dekontunuz onaylandı!'),
(1417, 'bank_decline', 'Your bank receipt has been declined!', 'Your bank receipt has been declined!', 'تم رفض إيصالك المصرفي!', 'Uw bankbewijs is geweigerd!', 'Votre facture bancaire a été refusée!', 'Ihr Bankbeleg wurde abgelehnt!', 'La tua ricevuta bancaria è stata rifiutata!', 'Seu recibo bancário foi recusado!', 'Ваша банковская квитанция была отклонена!', 'Su recibo bancario ha sido rechazado!', 'Banka dekontunuz reddedildi!'),
(1418, 'my_timeline', 'My Timeline', 'My Timeline', 'بلدي الجدول الزمني', 'Mijn tijdlijn', 'Ma chronologie', 'Mein Zeitplan', 'La mia cronologia', 'Minha linha do tempo', 'Мой график', 'Mi línea de tiempo', 'Benim zaman çizelgem'),
(1419, '1419', 'category', 'Cars and Vehicles', 'السيارات والمركبات', 'Cars and Vehicles', 'Voitures et Véhicules', 'Autos und Fahrzeuge', 'Motori', 'Carros e Ve&iacute;culos', 'Автомобили и транспорт', 'Automóviles y Vehículos', 'Otomobil ve Araçlar'),
(1420, '1420', 'category', 'Cars and Vehicles', 'السيارات والمركبات', 'Cars and Vehicles', 'Voitures et Véhicules', 'Autos und Fahrzeuge', 'Motori', 'Carros e Ve&iacute;culos', 'Автомобили и транспорт', 'Automóviles y Vehículos', 'Otomobil ve Araçlar'),
(1421, '1421', 'category', 'Cars and Vehicles', 'السيارات والمركبات', 'Cars and Vehicles', 'Voitures et Véhicules', 'Autos und Fahrzeuge', 'Motori', 'Carros e Ve&iacute;culos', 'Автомобили и транспорт', 'Automóviles y Vehículos', 'Otomobil ve Araçlar'),
(1422, '1422', 'category', 'Comedy', 'كوميديا', 'Comedy', 'Comédie', 'Komödie', 'Commedia', 'Com&eacute;dia', 'Комедия', 'Negocios y Oportunidades', 'Komedi'),
(1423, '1423', 'category', 'Comedy', 'كوميديا', 'Comedy', 'Comédie', 'Komödie', 'Commedia', 'Com&eacute;dia', 'Комедия', 'Negocios y Oportunidades', 'Komedi'),
(1424, '1424', 'category', 'Comedy', 'كوميديا', 'Comedy', 'Comédie', 'Komödie', 'Commedia', 'Com&eacute;dia', 'Комедия', 'Negocios y Oportunidades', 'Komedi'),
(1425, '1425', 'category', 'Economics and Trade', 'الاقتصاد والتجارة', 'Economics and Trade', 'Economie et Commerce', 'Wirtschaft und Handel', 'Economia e commercio', 'Com&eacute;rcio e Economia', 'Экономика и торговля', 'Economía y Comercio', 'Ekonomi ve Ticaret'),
(1426, '1426', 'category', 'Economics and Trade', 'الاقتصاد والتجارة', 'Economics and Trade', 'Economie et Commerce', 'Wirtschaft und Handel', 'Economia e commercio', 'Com&eacute;rcio e Economia', 'Экономика и торговля', 'Economía y Comercio', 'Ekonomi ve Ticaret'),
(1427, '1427', 'category', 'Economics and Trade', 'الاقتصاد والتجارة', 'Economics and Trade', 'Economie et Commerce', 'Wirtschaft und Handel', 'Economia e commercio', 'Com&eacute;rcio e Economia', 'Экономика и торговля', 'Economía y Comercio', 'Ekonomi ve Ticaret'),
(1428, '1428', 'category', 'Education', 'ثقافة', 'Education', 'Éducation', 'Bildung', 'Istruzione', 'Educa&ccedil;&atilde;o', 'Образование', 'Educación', 'Eğitim'),
(1429, '1429', 'category', 'Education', 'ثقافة', 'Education', 'Éducation', 'Bildung', 'Istruzione', 'Educa&ccedil;&atilde;o', 'Образование', 'Educación', 'Eğitim'),
(1430, '1430', 'category', 'Education', 'ثقافة', 'Education', 'Éducation', 'Bildung', 'Istruzione', 'Educa&ccedil;&atilde;o', 'Образование', 'Educación', 'Eğitim'),
(1431, '1431', 'category', 'Entertainment', 'تسلية', 'Entertainment', 'Divertissement', 'Unterhaltung', 'Entertainment', 'Entretenimento', 'Развлечения', 'Entretenimiento', 'Eğlence'),
(1432, '1432', 'category', 'Entertainment', 'تسلية', 'Entertainment', 'Divertissement', 'Unterhaltung', 'Entertainment', 'Entretenimento', 'Развлечения', 'Entretenimiento', 'Eğlence'),
(1433, '1433', 'category', 'Entertainment', 'تسلية', 'Entertainment', 'Divertissement', 'Unterhaltung', 'Entertainment', 'Entretenimento', 'Развлечения', 'Entretenimiento', 'Eğlence'),
(1434, '1434', 'category', 'Movies & Animation', 'أفلام ورسوم متحركة', 'Movies & Animation', 'Films & Animations', 'Filme und Animation', 'Film e Animazione', 'Filmes e Anima&ccedil;&otilde;es', 'Фильмы и анимация', 'Cine y Animación', 'Film ve Animasyon'),
(1435, '1435', 'category', 'Movies & Animation', 'أفلام ورسوم متحركة', 'Movies & Animation', 'Films & Animations', 'Filme und Animation', 'Film e Animazione', 'Filmes e Anima&ccedil;&otilde;es', 'Фильмы и анимация', 'Cine y Animación', 'Film ve Animasyon'),
(1436, '1436', 'category', 'Movies & Animation', 'أفلام ورسوم متحركة', 'Movies & Animation', 'Films & Animations', 'Filme und Animation', 'Film e Animazione', 'Filmes e Anima&ccedil;&otilde;es', 'Фильмы и анимация', 'Cine y Animación', 'Film ve Animasyon'),
(1437, '1437', 'category', 'Gaming', 'الألعاب', 'Gaming', 'Jeux', 'Spiele', 'Gioco', 'Jogos', 'Азартные игры', 'Juego de azar', 'Kumar'),
(1438, '1438', 'category', 'Gaming', 'الألعاب', 'Gaming', 'Jeux', 'Spiele', 'Gioco', 'Jogos', 'Азартные игры', 'Juego de azar', 'Kumar'),
(1439, '1439', 'category', 'Gaming', 'الألعاب', 'Gaming', 'Jeux', 'Spiele', 'Gioco', 'Jogos', 'Азартные игры', 'Juego de azar', 'Kumar'),
(1440, '1440', 'category', 'History and Facts', 'تاريخ وحقائق', 'History and Facts', 'Histoire et faits', 'Geschichte und Fakten', 'storia e fatti', 'Fatos e Hist&oacute;ria', 'История и факты', 'Historia y Datos', 'Tarihi ve Gerçekler'),
(1441, '1441', 'category', 'History and Facts', 'تاريخ وحقائق', 'History and Facts', 'Histoire et faits', 'Geschichte und Fakten', 'storia e fatti', 'Fatos e Hist&oacute;ria', 'История и факты', 'Historia y Datos', 'Tarihi ve Gerçekler'),
(1442, '1442', 'category', 'History and Facts', 'تاريخ وحقائق', 'History and Facts', 'Histoire et faits', 'Geschichte und Fakten', 'storia e fatti', 'Fatos e Hist&oacute;ria', 'История и факты', 'Historia y Datos', 'Tarihi ve Gerçekler'),
(1443, '1443', 'category', 'Live Style', 'نمط العيش', 'Live Style', 'Art de vivre', 'Live Style', 'Stile Live', 'Estilo de Vida', 'Образ жизни', 'Estilos de vida', 'Canlı Stil'),
(1444, '1444', 'category', 'Live Style', 'نمط العيش', 'Live Style', 'Art de vivre', 'Live Style', 'Stile Live', 'Estilo de Vida', 'Образ жизни', 'Estilos de vida', 'Canlı Stil'),
(1445, '1445', 'category', 'Live Style', 'نمط العيش', 'Live Style', 'Art de vivre', 'Live Style', 'Stile Live', 'Estilo de Vida', 'Образ жизни', 'Estilos de vida', 'Canlı Stil'),
(1446, '1446', 'category', 'Natural', 'الطبيعة', 'Natural', 'Naturel', 'Natürliches', 'naturale', 'Natural', 'Природа', 'Servicios', 'Doğal'),
(1447, '1447', 'category', 'Natural', 'الطبيعة', 'Natural', 'Naturel', 'Natürliches', 'naturale', 'Natural', 'Природа', 'Servicios', 'Doğal'),
(1448, '1448', 'category', 'Natural', 'الطبيعة', 'Natural', 'Naturel', 'Natürliches', 'naturale', 'Natural', 'Природа', 'Servicios', 'Doğal'),
(1449, '1449', 'category', 'News and Politics', 'الأخبار والسياسة', 'News and Politics', 'Nouvelles et Politique', 'Nachrichten und Politik', 'News and Politics', 'Not&iacute;cias e Pol&iacute;tica', 'Новости и политика', 'Noticias y Política', 'Haberler ve Politika'),
(1450, '1450', 'category', 'News and Politics', 'الأخبار والسياسة', 'News and Politics', 'Nouvelles et Politique', 'Nachrichten und Politik', 'News and Politics', 'Not&iacute;cias e Pol&iacute;tica', 'Новости и политика', 'Noticias y Política', 'Haberler ve Politika'),
(1451, '1451', 'category', 'News and Politics', 'الأخبار والسياسة', 'News and Politics', 'Nouvelles et Politique', 'Nachrichten und Politik', 'News and Politics', 'Not&iacute;cias e Pol&iacute;tica', 'Новости и политика', 'Noticias y Política', 'Haberler ve Politika'),
(1452, '1452', 'category', 'People and Nations', 'الناس والأمم', 'People and Nations', 'Les gens et les Nations', 'Menschen und Nationen', 'Persone e delle Nazioni', 'Na&ccedil;&otilde;es e Pessoas', 'Люди и Нация', 'Pueblos y Naciones', 'İnsanlar ve Milletler'),
(1453, '1453', 'category', 'People and Nations', 'الناس والأمم', 'People and Nations', 'Les gens et les Nations', 'Menschen und Nationen', 'Persone e delle Nazioni', 'Na&ccedil;&otilde;es e Pessoas', 'Люди и Нация', 'Pueblos y Naciones', 'İnsanlar ve Milletler'),
(1454, '1454', 'category', 'People and Nations', 'الناس والأمم', 'People and Nations', 'Les gens et les Nations', 'Menschen und Nationen', 'Persone e delle Nazioni', 'Na&ccedil;&otilde;es e Pessoas', 'Люди и Нация', 'Pueblos y Naciones', 'İnsanlar ve Milletler'),
(1455, '1455', 'category', 'Pets and Animals', 'الحيوانات الأليفة والحيوانات', 'Pets and Animals', 'Animaux et Animaux', 'Haustiere und Tiere', 'Animali e Animali', 'Animais', 'Животные', 'Animales y mascotas', 'Evcil ve Hayvanlar'),
(1456, '1456', 'category', 'Pets and Animals', 'الحيوانات الأليفة والحيوانات', 'Pets and Animals', 'Animaux et Animaux', 'Haustiere und Tiere', 'Animali e Animali', 'Animais', 'Животные', 'Animales y mascotas', 'Evcil ve Hayvanlar'),
(1457, '1457', 'category', 'Pets and Animals', 'الحيوانات الأليفة والحيوانات', 'Pets and Animals', 'Animaux et Animaux', 'Haustiere und Tiere', 'Animali e Animali', 'Animais', 'Животные', 'Animales y mascotas', 'Evcil ve Hayvanlar'),
(1458, '1458', 'category', 'Places and Regions', 'الأماكن والمناطق', 'Places and Regions', 'Lieux et régions', 'Orte und Regionen', 'Luoghi e Regioni', 'Lugares e Regi&otilde;es', 'Места и регионы', 'Lugares y Regiones', 'Yerler ve Bölgeler'),
(1459, '1459', 'category', 'Places and Regions', 'الأماكن والمناطق', 'Places and Regions', 'Lieux et régions', 'Orte und Regionen', 'Luoghi e Regioni', 'Lugares e Regi&otilde;es', 'Места и регионы', 'Lugares y Regiones', 'Yerler ve Bölgeler'),
(1460, '1460', 'category', 'Places and Regions', 'الأماكن والمناطق', 'Places and Regions', 'Lieux et régions', 'Orte und Regionen', 'Luoghi e Regioni', 'Lugares e Regi&otilde;es', 'Места и регионы', 'Lugares y Regiones', 'Yerler ve Bölgeler'),
(1461, '1461', 'category', 'Science and Technology', 'العلوم والتكنولوجيا', 'Science and Technology', 'Science et technologie', 'Wissenschaft und Technik', 'Scienze e Tecnologia', 'Ci&ecirc;ncia e Tecnologia', 'Наука и технология', 'Ciencia y Tecnología', 'Bilim ve Teknoloji'),
(1462, '1462', 'category', 'Science and Technology', 'العلوم والتكنولوجيا', 'Science and Technology', 'Science et technologie', 'Wissenschaft und Technik', 'Scienze e Tecnologia', 'Ci&ecirc;ncia e Tecnologia', 'Наука и технология', 'Ciencia y Tecnología', 'Bilim ve Teknoloji'),
(1463, '1463', 'category', 'Science and Technology', 'العلوم والتكنولوجيا', 'Science and Technology', 'Science et technologie', 'Wissenschaft und Technik', 'Scienze e Tecnologia', 'Ci&ecirc;ncia e Tecnologia', 'Наука и технология', 'Ciencia y Tecnología', 'Bilim ve Teknoloji'),
(1464, '1464', 'category', 'Sport', 'رياضة', 'Sport', 'Sport', 'Sport', 'Sport', 'Esporte', 'Спорт', 'Deporte', 'Spor'),
(1465, '1465', 'category', 'Sport', 'رياضة', 'Sport', 'Sport', 'Sport', 'Sport', 'Esporte', 'Спорт', 'Deporte', 'Spor'),
(1466, '1466', 'category', 'Sport', 'رياضة', 'Sport', 'Sport', 'Sport', 'Sport', 'Esporte', 'Спорт', 'Deporte', 'Spor'),
(1467, '1467', 'category', 'Travel and Events', 'سفر وأحداث', 'Travel and Events', 'Voyage et événement', 'Reisen und Veranstaltungen', 'Viaggi ed Eventi', 'Viagens e Eventos', 'Путешествия и события', 'Viajes y Eventos', 'Gezi ve Etkinlikler'),
(1468, '1468', 'category', 'Travel and Events', 'سفر وأحداث', 'Travel and Events', 'Voyage et événement', 'Reisen und Veranstaltungen', 'Viaggi ed Eventi', 'Viagens e Eventos', 'Путешествия и события', 'Viajes y Eventos', 'Gezi ve Etkinlikler'),
(1469, '1469', 'category', 'Travel and Events', 'سفر وأحداث', 'Travel and Events', 'Voyage et événement', 'Reisen und Veranstaltungen', 'Viaggi ed Eventi', 'Viagens e Eventos', 'Путешествия и события', 'Viajes y Eventos', 'Gezi ve Etkinlikler'),
(1470, '1470', 'category', 'Apparel & Accessories', 'ملابس واكسسوارات', 'Apparel & Accessories', 'Apparel & Accessories', 'Apparel & Accessories', 'Apparel & Accessories', 'Apparel & Accessories', 'Apparel & Accessories', 'Apparel & Accessories', 'Apparel & Accessories'),
(1471, '1471', 'category', 'Autos & Vehicles', 'السيارات و المركبات', 'Autos & Vehicles', 'Autos & Vehicles', 'Autos & Vehicles', 'Autos & Vehicles', 'Autos & Vehicles', 'Autos & Vehicles', 'Autos & Vehicles', 'Autos & Vehicles'),
(1472, '1472', 'category', 'Baby & Children\'s Products', 'منتجات الأطفال', 'Baby & Children\'s Products', 'Baby & Children&#39;s Products', 'Baby & Children\'s Products', 'Baby & Children\'s Products', 'Baby & Children\'s Products', 'Baby & Children\'s Products', 'Baby & Children\'s Products', 'Baby & Children\'s Products'),
(1473, '1473', 'category', 'Beauty Products & Services', 'منتجات الجمال \\ خدمات', 'Beauty Products & Services', 'Beauty Products & Services', 'Beauty Products & Services', 'Beauty Products & Services', 'Beauty Products & Services', 'Beauty Products & Services', 'Beauty Products & Services', 'Beauty Products & Services'),
(1474, '1474', 'category', 'Computers & Peripherals', 'أجهزة الكمبيوتر وملحقاته', 'Computers & Peripherals', 'Computers & Peripherals', 'Computers & Peripherals', 'Computers & Peripherals', 'Computers & Peripherals', 'Computers & Peripherals', 'Computers & Peripherals', 'Computers & Peripherals'),
(1475, '1475', 'category', 'Consumer Electronics', 'الالكترونيات', 'Consumer Electronics', 'Consumer Electronics', 'Consumer Electronics', 'Consumer Electronics', 'Consumer Electronics', 'Consumer Electronics', 'Consumer Electronics', 'Consumer Electronics'),
(1476, '1476', 'category', 'Dating Services', 'خدمات ', 'Dating Services', 'Dating Services', 'Dating Services', 'Dating Services', 'Dating Services', 'Dating Services', 'Dating Services', 'Dating Services'),
(1477, '1477', 'category', 'Financial Services', 'الخدمات المالية', 'Financial Services', 'Financial Services', 'Financial Services', 'Financial Services', 'Financial Services', 'Financial Services', 'Financial Services', 'Financial Services'),
(1478, '1478', 'category', 'Gifts & Occasions', 'هدايا ومناسبات', 'Gifts & Occasions', 'Gifts & Occasions', 'Gifts & Occasions', 'Gifts & Occasions', 'Gifts & Occasions', 'Gifts & Occasions', 'Gifts & Occasions', 'Gifts & Occasions'),
(1479, '1479', 'category', 'Home & Garden', 'العقارات', 'Home & Garden', 'Home & Garden', 'Home & Garden', 'Home & Garden', 'Home & Garden', 'Home & Garden', 'Home & Garden', 'Home & Garden'),
(1480, 'sort_by', 'Sort by', 'Sort by', 'ترتيب حسب', 'Sorteer op', 'Trier par', 'Sortiere nach', 'Ordina per', 'Ordenar por', 'Сортировать по', 'Ordenar por', 'Göre sırala'),
(1481, 'top', 'Top', 'Top', 'أعلى', 'Top', 'Haut', 'oben', 'Superiore', 'Topo', 'верхний', 'Parte superior', 'Üst'),
(1482, 'comment_on_post', 'Comment on post', 'Comment on post', 'التعليق على آخر', 'Reageer op post', 'Commentaire sur le post', 'Kommentar zum Beitrag', 'Commento sul post', 'Comente na postagem', 'Комментарий к сообщению', 'Comentar en la publicación', 'Yayına yorum yapın'),
(1483, 'email_provider_banned', 'The email provider is blacklisted and not allowed, please choose another email provider.', 'The email provider is blacklisted and not allowed, please choose another email provider.', 'مزود البريد الإلكتروني مدرج في القائمة السوداء وغير مسموح به ، يرجى اختيار مزود بريد إلكتروني آخر.', 'De e-mailprovider staat op de zwarte lijst en is niet toegestaan, kies een andere e-mailprovider.', 'Le fournisseur de messagerie est sur la liste noire et n&#039;est pas autorisé. Veuillez choisir un autre fournisseur de messagerie.', 'Der E-Mail-Anbieter ist auf der schwarzen Liste und nicht zulässig. Bitte wählen Sie einen anderen E-Mail-Anbieter.', 'Il provider di posta elettronica è nella lista nera e non è consentito, si prega di scegliere un altro provider di posta elettronica.', 'O provedor de e-mail está na lista negra e não é permitido, por favor, escolha outro provedor de e-mail.', 'Поставщик электронной почты находится в черном списке и не допускается, выберите другого поставщика электронной почты.', 'El proveedor de correo electrónico está en la lista negra y no está permitido, elija otro proveedor de correo electrónico.', 'E-posta sağlayıcı kara listeye alındı ​​ve izin verilmedi, lütfen başka bir e-posta sağlayıcı seçin.'),
(1484, 'sent_product_to_you', 'Sent product to you', 'Sent product to you', 'أرسلت المنتج لك', 'Verzonden product naar u', 'Produit envoyé à vous', 'Produkt an Sie gesendet', 'Prodotto inviato a voi', 'Enviado produto para você', 'Отправил вам товар', 'Producto enviado a usted', 'Size gönderilen ürün'),
(1485, 'color', 'Color', 'Color', 'اللون', 'Kleur', 'Couleur', 'Farbe', 'Colore', 'Cor', 'цвет', 'Color', 'Renk'),
(1486, '2checkout', '2Checkout', '2Checkout', '2Checkout', '2Checkout', '2Checkout', '2Kasse', '2Checkout', '2Checkout', '2Checkout', '2 Checkout', '2Checkout'),
(1487, 'card_number', 'Card Number', 'Card Number', 'رقم البطاقة', 'Kaartnummer', 'Numéro de carte', 'Kartennummer', 'Numero di carta', 'Número do cartão', 'Номер карты', 'Número de tarjeta', 'Kart numarası'),
(1488, 'address', 'Address', 'Address', 'عنوان', 'Adres', 'Adresse', 'Adresse', 'Indirizzo', 'Endereço', 'Адрес', 'Dirección', 'Adres'),
(1489, 'city', 'City', 'City', 'مدينة', 'stad', 'Ville', 'Stadt', 'Città', 'Cidade', 'город', 'Ciudad', 'Kent'),
(1490, 'state', 'State', 'State', 'حالة', 'Staat', 'Etat', 'Zustand', 'Stato', 'Estado', 'государственный', 'Estado', 'Belirtmek, bildirmek'),
(1491, 'zip', 'Zip Code', 'Zip Code', 'الرمز البريدي', 'Postcode', 'Code postal', 'Postleitzahl', 'Cap', 'Código postal', 'Почтовый Индекс', 'Código postal', 'Posta kodu'),
(1492, 'pay', 'Pay Now', 'Pay Now', 'ادفع الآن', 'Nu betalen', 'Payez maintenant', 'Zahl jetzt', 'Paga ora', 'Pague agora', 'Заплатить сейчас', 'Pague ahora', 'Şimdi öde'),
(1493, '2checkout_declined', 'Your payment was declined, please contact your bank or card issuer and make sure you have the requir', 'Your payment was declined, please contact your bank or card issuer and make sure you have the required funds.', 'تم رفض دفعتك ، يرجى الاتصال بالمصرف أو مصدر البطاقة والتأكد من أن لديك الأموال المطلوبة.', 'Uw betaling is geweigerd. Neem contact op met uw bank of creditcardmaatschappij en zorg dat u over het benodigde geld beschikt.', 'Votre paiement a été refusé, veuillez contacter votre banque ou votre émetteur de carte et assurez-vous de disposer des fonds nécessaires.', 'Ihre Zahlung wurde abgelehnt. Wenden Sie sich an Ihre Bank oder Ihren Kartenaussteller, und vergewissern Sie sich, dass Sie über das erforderliche Guthaben verfügen.', 'Il tuo pagamento è stato rifiutato, contatta la tua banca o l&#039;emittente della carta e assicurati di avere i fondi necessari.', 'Seu pagamento foi recusado, entre em contato com seu banco ou emissor do cartão e verifique se você tem os fundos necessários.', 'Ваш платеж был отклонен, пожалуйста, свяжитесь с банком или эмитентом карты и убедитесь, что у вас есть необходимые средства.', 'Su pago fue rechazado, póngase en contacto con su banco o con el emisor de la tarjeta y asegúrese de tener los fondos necesarios.', 'Ödemeniz reddedildi, lütfen bankanıza veya kart düzenleyicinize başvurun ve gerekli paraya sahip olduğunuzdan emin olun.'),
(1494, 'expire_date', 'Expire Date', 'Expire Date', 'تاريخ انتهاء الصلاحية', 'Vervaldatum', 'Date d&#039;expiration', 'Ablaufdatum', 'Data di scadenza', 'Data de validade', 'Годен до', 'Fecha de caducidad', 'Son kullanma tarihi'),
(1495, 'no_interested_people', 'There are no interested users.', 'There are no interested users.', 'لا يوجد مستخدمون مهتمون.', 'Er zijn geen geïnteresseerde gebruikers.', 'Il n&#039;y a pas d&#039;utilisateurs intéressés.', 'Es gibt keine interessierten Benutzer.', 'Non ci sono utenti interessati.', 'Não há usuários interessados.', 'Нет заинтересованных пользователей.', 'No hay usuarios interesados.', 'İlgilenen kullanıcı yok.'),
(1496, 'less', 'less', 'Less', 'Less', 'Less', 'Less', 'Less', 'Less', 'Less', 'Less', 'Less', 'Less'),
(1497, 'completed', 'Completed', 'Completed', 'منجز', 'Voltooid', 'Terminé', 'Abgeschlossen', 'Completato', 'Concluído', 'Завершенный', 'Terminado', 'Tamamlanan'),
(1498, 'studied_at', 'Studied at', 'Studied at', 'درس في', 'Gestudeerd aan', 'Étudié à', 'Studierte an', 'Studiato a', 'Estudou na', 'Учился в', 'Estudió en', 'Okudu'),
(1499, 'cant_share_own', 'You can&#039;t share a post on a page or a group that is your not own.', 'You can&#039;t share a post on a page or a group that is your not own.', 'لا يمكنك مشاركة منشور على صفحة أو مجموعة غير خاصة بك.', 'Je kunt een bericht op een pagina of een groep die niet van jezelf is, niet delen.', 'Vous ne pouvez pas partager un message sur une page ou un groupe qui n&#039;est pas le vôtre.', 'Sie können keinen Beitrag auf einer Seite oder einer Gruppe teilen, die nicht Ihrer eigenen gehört.', 'Non puoi condividere un post su una pagina o un gruppo che non sei proprietario.', 'Você não pode compartilhar uma postagem em uma página ou em um grupo que não é seu.', 'Вы не можете поделиться постом на странице или в группе, которая не принадлежит вам.', 'No puedes compartir una publicación en una página o un grupo que no sea tuyo.', 'Bir sayfada veya kendi olmayan bir gruptaki bir gönderiyi paylaşamazsınız.'),
(1500, 'accept_group_chat_request', 'Accepted your group chat invitation.', 'Accepted your group chat invitation.', 'تم قبول دعوة الدردشة الجماعية.', 'Uw uitnodiging voor groepschat geaccepteerd.', 'Accepté votre invitation à la discussion de groupe.', 'Hat Ihre Einladung zum Gruppenchat angenommen.', 'Ha accettato l&#039;invito alla chat di gruppo.', 'Aceitou seu convite para bate-papo em grupo.', 'Принято приглашение в групповой чат.', 'Aceptó su invitación de chat grupal.', 'Grup sohbeti davetinizi kabul ettiniz.'),
(1501, 'jobs', 'Jobs', 'Jobs', 'وظائف', 'Jobs', 'Emplois', 'Arbeitsplätze', 'Lavori', 'Empregos', 'работы', 'Trabajos', 'Meslekler'),
(1502, 'post_job_text', 'Post a job for {{page_name}} to reach the right applicants on', 'Post a job for {{page_name}} to reach the right applicants on', 'انشر وظيفة لـ {{page_name}} للوصول إلى المتقدمين المناسبين', 'Plaats een vacature voor {{page_name}} om de juiste sollicitanten te bereiken op', 'Déposez une offre pour {{nom_page}} afin d&#039;atteindre les bons candidats le', 'Veröffentlichen Sie einen Job für {{page_name}}, um die richtigen Bewerber am zu erreichen', 'Pubblica un lavoro per {{page_name}} per raggiungere i candidati giusti', 'Publique uma tarefa para {{page_name}} alcançar os candidatos certos em', 'Опубликуйте вакансию для {{page_name}}, чтобы найти нужных кандидатов на', 'Publique un trabajo para {{page_name}} para llegar a los solicitantes correctos en', 'Doğru başvuru sahiplerine ulaşmak için {{page_name}} için bir iş gönderin.'),
(1503, 'create_job', 'Create Job', 'Create Job', 'خلق وظيفة', 'Taak maken', 'Créer un emploi', 'Job erstellen', 'Crea lavoro', 'Criar trabalho', 'Создать работу', 'Crear trabajo', 'İş Oluştur'),
(1504, 'job_title', 'Job Title', 'Job titles', 'عناوين العمل', 'Titels', 'Titres d&#039;emploi', 'Berufsbezeichnungen', 'Titolo di lavoro', 'Títulos de trabalho', 'Название рабочих должностей', 'Títulos de trabajo', 'İş ünvanları'),
(1505, 'salary_range', 'Salary Range', 'Salary Range', 'نطاق الراتب', 'Salaris schaal', 'Échelle salariale', 'Gehaltsspanne', 'Fascia di reddito', 'Faixa salarial', 'Диапазон зарплаты', 'Rango salarial', 'Maaş aralığı'),
(1506, 'minimum', 'Minimum', 'Minimum', 'الحد الأدنى', 'Minimum', 'Le minimum', 'Minimum', 'Minimo', 'Mínimo', 'минимальный', 'Mínimo', 'minimum'),
(1507, 'maximum', 'Maximum', 'Maximum', 'أقصى', 'maximaal', 'Maximum', 'Maximal', 'Massimo', 'Máximo', 'максимальная', 'Máximo', 'Maksimum'),
(1508, 'per_hour', 'Per Hour', 'Per Hour', 'في الساعة', 'Per uur', 'Par heure', 'Pro Stunde', 'All&#039;ora', 'Por hora', 'В час', 'Por hora', 'Saat başı'),
(1509, 'per_day', 'Per Day', 'Per Day', 'في اليوم', 'Per dag', 'Par jour', 'Pro Tag', 'Al giorno', 'Por dia', 'В день', 'Por día', 'Günlük'),
(1513, 'job_type', 'Job Type', 'Job Type', 'نوع الوظيفة', 'Soort baan', 'Type d&#039;emploi', 'Auftragstyp', 'Tipo di lavoro', 'Tipo de emprego', 'Тип задания', 'Tipo de empleo', 'Meslek türü'),
(1514, 'full_time', 'Full Time', 'Full time', 'وقت كامل', 'Full time', 'À temps plein', 'Vollzeit', 'Tempo pieno', 'Tempo total', 'На постоянной основе', 'Tiempo completo', 'Tam zamanlı'),
(1515, 'part_time', 'Part Time', 'Part time', 'دوام جزئى', 'Deeltijd', 'À temps partiel', 'Teilzeit', 'Part time', 'Meio período', 'Неполная занятость', 'Medio tiempo', 'Yarı zamanlı'),
(1516, 'internship', 'Internship', 'Internship', 'التدريب الداخلي', 'Stage', 'Stage', 'Praktikum', 'tirocinio', 'Estágio', 'производственная практика', 'Internado', 'Staj'),
(1517, 'volunteer', 'Volunteer', 'Volunteer', 'تطوع', 'Vrijwilliger', 'Bénévole', 'Freiwillige', 'Volontario', 'Voluntário', 'доброволец', 'Voluntario', 'Gönüllü'),
(1518, 'contract', 'Contract', 'Contract', 'اتفافية', 'Contract', 'Contracter', 'Vertrag', 'Contrarre', 'Contrato', 'Договор', 'Contrato', 'Sözleşme'),
(1519, 'job_des_text', 'Describe the responsibilities and preferred skills for this job', 'Describe the responsibilities and preferred skills for this job', 'صف المسؤوليات والمهارات المفضلة لهذه الوظيفة', 'Beschrijf de verantwoordelijkheden en voorkeursvaardigheden voor deze functie', 'Décrivez les responsabilités et les compétences préférées pour cet emploi.', 'Beschreiben Sie die Verantwortlichkeiten und bevorzugten Fähigkeiten für diesen Job', 'Descrivi le responsabilità e le competenze preferite per questo lavoro', 'Descreva as responsabilidades e habilidades preferidas para este trabalho', 'Опишите обязанности и предпочтительные навыки для этой работы', 'Describa las responsabilidades y habilidades preferidas para este trabajo.', 'Bu iş için sorumlulukları ve tercih edilen becerileri tanımlayın'),
(1520, 'job_add_iamge', 'Add an image to help applicants see what it&#039;s like to work at this location.', 'Add an image to help applicants see what it&#039;s like to work at this location.', 'أضف صورة لمساعدة المتقدمين على معرفة كيفية العمل في هذا الموقع.', 'Voeg een afbeelding toe om aanvragers te helpen zien hoe het is om op deze locatie te werken.', 'Ajoutez une image pour aider les candidats à voir à quoi ça ressemble de travailler à cet endroit.', 'Fügen Sie ein Bild hinzu, damit Bewerber sehen, wie es ist, an diesem Standort zu arbeiten.', 'Aggiungi un&#039;immagine per aiutare i candidati a vedere com&#039;è lavorare in questa posizione.', 'Adicione uma imagem para ajudar os candidatos a ver como é trabalhar neste local.', 'Добавьте изображение, чтобы помочь кандидатам увидеть, каково это работать в этом месте.', 'Agregue una imagen para ayudar a los solicitantes a ver cómo es trabajar en esta ubicación.', 'Başvuru sahiplerinin bu konumda çalışmanın nasıl bir şey olduğunu görmelerine yardımcı olmak için bir resim ekleyin.'),
(1521, 'use_cover_photo', 'Use Cover Photo', 'Use Cover Photo', 'استخدام صورة الغلاف', 'Gebruik omslagfoto', 'Utiliser la photo de couverture', 'Titelbild verwenden', 'Usa foto di copertina', 'Usar Foto de Capa', 'Использовать обложку', 'Usar foto de portada', 'Kapak Fotoğrafını Kullan'),
(1522, 'questions', 'Questions', 'Questions', 'أسئلة', 'Vragen', 'Des questions', 'Fragen', 'Domande', 'Perguntas', 'Вопросы', 'Preguntas', 'Sorular'),
(1523, 'free_text_question', 'Free Text Question', 'Free Text Question', 'نص حر السؤال', 'Vrije tekst vraag', 'Question de texte libre', 'Freitext-Frage', 'Domanda a testo libero', 'Pergunta de texto livre', 'Свободный текстовый вопрос', 'Pregunta de texto libre', 'Serbest Metin Sorusu'),
(1524, 'yes_no_question', 'Yes/No Question', 'Yes/No Question', 'نعم / لا سؤال', 'Ja-nee-vraag', 'Question oui / non', 'Ja-nein Frage', 'Si nessuna domanda', 'Sim / Não Pergunta', 'Да / нет вопрос', 'Pregunta de sí o no', 'Evet soru yok'),
(1525, 'multiple_choice_question', 'Multiple Choice Question', 'Multiple Choice Question', 'سؤال متعدد الخيارات', 'Meerkeuze vraag', 'Question à choix multiples', 'Multiple-Choice-Frage', 'Domanda a scelta multipla', 'Pergunta de múltipla escolha', 'Вопрос с множественным выбором', 'Pregunta de opción múltiple', 'Çoktan seçmeli soru'),
(1526, 'add_question', 'Add Question', 'Add Question', 'أضف سؤال', 'Vraag toevoegen', 'Ajouter une question', 'Frage hinzufügen', 'Aggiungi domanda', 'Adicionar pergunta', 'Добавить вопрос', 'Añadir pregunta', 'Soru ekle'),
(1527, 'add_an_answers', 'Add answers', 'Add answers', 'أضف إجابات', 'Antwoorden toevoegen', 'Ajouter des réponses', 'Antworten hinzufügen', 'Aggiungi risposte', 'Adicionar respostas', 'Добавить ответы', 'Agregar respuestas', 'Cevap ekle'),
(1528, 'question_one', 'Question One', 'Question One', 'سؤال واحد', 'Vraag een', 'Question une', 'Frage eins', 'Domanda uno', 'Pergunta um', 'Вопрос первый', 'Pregunta uno', 'Birinci soru');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1529, 'question_two', 'Question Two', 'Question Two', 'السؤال الثاني', 'Vraag twee', 'Deuxième question', 'Frage zwei', 'Domanda due', 'Pergunta dois', 'Вопрос второй', 'Pregunta dos', 'Soru İki'),
(1530, 'question_three', 'Question Three', 'Question Three', 'السؤال الثالث', 'Vraag drie', 'Troisième question', 'Frage drei', 'Domanda tre', 'Pergunta três', 'Вопрос третий', 'Pregunta tres', 'Soru Üç'),
(1531, 'edit_job', 'Edit Job', 'Edit Job', 'تحرير الوظيفة', 'Job bewerken', 'Modifier le travail', 'Job bearbeiten', 'Modifica lavoro', 'Editar trabalho', 'Редактировать работу', 'Editar trabajo', 'İşi Düzenle'),
(1532, 'delete_job', 'Delete Job', 'Delete Job', 'حذف الوظيفة', 'Taak verwijderen', 'Supprimer le travail', 'Job löschen', 'Elimina lavoro', 'Excluir trabalho', 'Удалить работу', 'Eliminar trabajo', 'İşi Sil'),
(1533, 'apply_now', 'Apply Now', 'Apply Now', 'قدم الآن', 'Nu toepassen', 'Appliquer maintenant', 'Jetzt bewerben', 'Applica ora', 'Aplique agora', 'Применить сейчас', 'Aplica ya', 'Şimdi Uygula'),
(1534, 'experience', 'Experience', 'Experience', 'خبرة', 'Ervaring', 'De l&#039;expérience', 'Erfahrung', 'Esperienza', 'Experiência', 'Опыт', 'Experiencia', 'Tecrübe etmek'),
(1535, 'add_experience', 'Add Experience', 'Add Experience', 'إضافة الخبرة', 'Voeg ervaring toe', 'Ajouter une expérience', 'Erfahrung hinzufügen', 'Aggiungi esperienza', 'Adicionar Experiência', 'Добавить опыт', 'Añadir experiencia', 'Deneyim ekle'),
(1536, 'position', 'Position', 'Position', 'موضع', 'Positie', 'Position', 'Position', 'Posizione', 'Posição', 'Позиция', 'Posición', 'pozisyon'),
(1537, 'where_did_you_work', 'Where did you work?', 'Where did you work?', 'أين عملت؟', 'Waar heb je gewerkt?', 'Où avez-vous travaillé?', 'Wo hast du gearbeitet?', 'Dove lavori?', 'Onde você trabalhou?', 'Где ты работаешь?', '¿Donde trabajaste?', 'Nerede çalıştın?'),
(1538, 'i_currently_work', 'I currently work here', 'I currently work here', 'أنا حاليا أعمل هنا', 'Ik werk momenteel hier', 'Je travaille actuellement ici', 'Ich arbeite zurzeit hier', 'Attualmente lavoro qui', 'eu trabalho aqui atualmente', 'я сейчас работаю здесь', 'actualmente trabajo aquí', 'şuanda burada çalışıyorum'),
(1539, 'please_answer_questions', 'Please answer the questions', 'Please answer the questions', 'الرجاء الإجابة على الأسئلة', 'Beantwoord alstublieft de vragen', 'S&#039;il vous plaît répondre aux questions', 'Bitte beantworten Sie die Fragen', 'Per favore, rispondi alle domande', 'Por favor responda as perguntas', 'Пожалуйста, ответьте на вопросы', 'Por favor contesta las preguntas', 'Lütfen soruları cevaplayınız'),
(1540, 'you_apply_this_job', 'You have already applied for this job.', 'You have already applied for this job.', 'لقد تقدمت بالفعل لهذه الوظيفة.', 'Je hebt al gesolliciteerd voor deze functie.', 'Vous avez déjà postulé pour ce travail.', 'Sie haben sich bereits auf diese Stelle beworben.', 'Hai già fatto domanda per questo lavoro.', 'Você já se inscreveu para este trabalho.', 'Вы уже подали заявку на эту работу.', 'Ya has solicitado este trabajo.', 'Bu iş için zaten başvurdunuz.'),
(1541, 'search_for_jobs', 'Search for jobs', 'Search for jobs', 'البحث عن وظائف', 'Zoek voor banen', 'Chercher du travail', 'Nach Jobs suchen', 'Cerca lavoro', 'Procure por empregos', 'Поиск работы', 'Búsqueda de empleo', 'İş aramak'),
(1542, 'no_available_jobs', 'No available jobs to show.', 'No available jobs to show.', 'لا توجد وظائف متاحة للعرض.', 'Geen beschikbare taken om te tonen.', 'Aucun emploi disponible à afficher.', 'Keine verfügbaren Jobs zum Anzeigen.', 'Nessun lavoro disponibile da mostrare.', 'Não há trabalhos disponíveis para mostrar.', 'Нет доступных рабочих мест, чтобы показать.', 'No hay trabajos disponibles para mostrar.', 'Gösterilecek müsait iş yok.'),
(1543, 'load_more_jobs', 'Load more jobs', 'Load more jobs', 'تحميل المزيد من الوظائف', 'Laad meer taken', 'Charger plus de jobs', 'Weitere Jobs laden', 'Carica più lavori', 'Carregar mais trabalhos', 'Загрузить больше вакансий', 'Cargar más trabajos', 'Daha fazla iş yükle'),
(1544, 'show_apply', 'Show Applies', 'Show Applies', 'عرض تطبيق', 'Tonen Toepassen', 'Afficher appliquer', 'Show Übernehmen', 'Mostra Applica', 'Mostrar Aplicar', 'Показать Применить', 'Mostrar Aplicar', 'Göster Uygula'),
(1545, 'common_things', 'Common Things', 'Common Things', 'الأشياء المشتركة', 'Gewone dingen', 'Choses communes', 'Allgemeine Dinge', 'Cose comuni', 'Coisas comuns', 'Общие вещи', 'Cosas en común', 'Ortak şeyler'),
(1546, 'thing_in_common', 'Thing in common', 'Thing in common', 'شيء مشترك', 'Ding gemeen', 'Chose en commun', 'Gemeinsamkeiten', 'Cosa in comune', 'Coisa em comum', 'Вещь общая', 'Cosa en común', 'Ortak şey'),
(1547, 'things_in_common', 'Things in common', 'Things in common', 'أشياء مشتركة', 'Gemeenschappelijke dingen', 'Choses en commun', 'Gemeinsame Dinge', 'Cose in comune', 'Coisas em comum', 'Общие вещи', 'Cosas en comun', 'Ortak şeyler'),
(1548, 'weather_unit', 'Weather Unit', 'Weather Unit', 'وحدة الطقس', 'Weereenheid', 'Unité météorologique', 'Weather Unit', 'Unità meteorologica', 'Unidade Meteorológica', 'Погодная единица', 'Unidad de clima', 'Hava Durumu Birimi'),
(1549, 'job_applied', 'Already applied', 'Already applied', 'تطبق بالفعل', 'Al toegepast', 'Déjà appliqué', 'Bereits angewendet', 'Già applicato', 'Já aplicado', 'Уже применено', 'Ya aplicado', 'Zaten uygulandı'),
(1550, 'apply_your_job', 'applied to your job request.', 'applied to your job request.', 'تطبق على طلب عملك.', 'toegepast op uw sollicitatie.', 'appliqué à votre demande d&#039;emploi.', 'auf Ihre Stellenanfrage angewendet.', 'applicato alla tua richiesta di lavoro.', 'aplicada à sua solicitação de emprego.', 'применяется к вашей заявке на работу.', 'aplicado a su solicitud de trabajo.', 'iş isteğinize uygulanır.'),
(1551, 'apply_job_successfully', 'You have successfully applied to this job.', 'You have successfully applied to this job.', 'لقد تقدمت بنجاح إلى هذه الوظيفة.', 'Je hebt met succes gesolliciteerd op deze functie.', 'Vous avez postulé avec succès à ce travail.', 'Sie haben sich erfolgreich auf diese Stelle beworben.', 'Hai fatto domanda con successo a questo lavoro.', 'Você se inscreveu com sucesso neste trabalho.', 'Вы успешно подали заявку на эту работу.', 'Has aplicado con éxito a este trabajo.', 'Bu işe başarıyla başvurdunuz.'),
(1552, 'job_successfully_created', 'Job request successfully created.', 'Job request successfully created.', 'تم إنشاء طلب الوظيفة بنجاح.', 'Taakaanvraag succesvol aangemaakt.', 'Demande de travail créée avec succès.', 'Jobanfrage erfolgreich erstellt.', 'Richiesta di lavoro creata correttamente.', 'Solicitação de tarefa criada com sucesso.', 'Запрос на работу успешно создан.', 'Solicitud de trabajo creada con éxito.', 'İş isteği başarıyla oluşturuldu.'),
(1553, 'job_successfully_edited', 'Job request successfully updated.', 'Job request successfully updated.', 'تم تحديث طلب الوظيفة بنجاح.', 'Taakaanvraag succesvol bijgewerkt.', 'Demande de travail mise à jour avec succès.', 'Jobanfrage erfolgreich aktualisiert.', 'Richiesta di lavoro aggiornata correttamente.', 'Solicitação de tarefa atualizada com sucesso.', 'Запрос на работу успешно обновлен.', 'Solicitud de trabajo actualizada correctamente.', 'İş isteği başarıyla güncellendi.'),
(1554, 'invited_to_group', 'invited you to join the group chat.', 'invited you to join the group chat.', 'دعاك للانضمام إلى الدردشة الجماعية.', 'heeft u uitgenodigd om deel te nemen aan de groepschat.', 'vous invite à rejoindre le chat en groupe.', 'hat Sie zum Gruppenchat eingeladen.', 'ti ha invitato a unirti alla chat di gruppo.', 'convidou você para participar do chat em grupo.', 'пригласил вас присоединиться к групповому чату.', 'te invitó a unirte al chat grupal.', 'sizi grup sohbetine katılmaya davet etti.'),
(1555, 'declined_group_chat_request', 'declined your group chat invitation.', 'declined your group chat invitation.', 'رفض دعوة الدردشة الجماعية.', 'uw uitnodiging voor groepschat geweigerd.', 'a refusé votre invitation à la discussion de groupe.', 'hat Ihre Gruppenchat-Einladung abgelehnt.', 'rifiutato l&#039;invito alla chat di gruppo.', 'recusou seu convite para bate-papo em grupo.', 'отклонил приглашение в групповой чат.', 'rechazó su invitación de chat grupal.', 'grup sohbeti davetinizi reddetti.'),
(1556, 'offer_job', 'Offer a job', 'Offer a job', 'اعرض عمل', 'Bied een baan aan', 'Offrir un emploi', 'Biete einen Job an', 'Offri un lavoro', 'Oferecer um emprego', 'Предложить работу', 'Ofrecer un trabajo', 'Bir iş teklif'),
(1557, 'posted_job_offer', 'posted a job offer', 'posted a job offer', 'نشر عرض عمل.', 'een vacature geplaatst.', 'posté une offre d&#039;emploi.', 'hat ein Stellenangebot gepostet.', 'pubblicato un&#039;offerta di lavoro.', 'postou uma oferta de emprego.', 'опубликовал предложение о работе.', 'publicó una oferta de trabajo.', 'bir iş teklifi yayınladı.'),
(1558, 'verified_page', 'Verified Page', 'Verified Page', 'صفحة موثوقة', 'Geverifieerde pagina', 'Page vérifiée', 'Verifizierte Seite', 'Pagina verificata', 'Página verificada', 'Проверенная страница', 'Página verificada', 'Doğrulanmış sayfa'),
(1559, 'unfriend', 'Unfriend', 'Unfriend', 'الغاء الصداقه', 'Unfriend', 'Désamie', 'Unfreund', 'Unfriend', 'Anular', 'Unfriend', 'No amigo', 'Arkadaşlıktan Çıkar'),
(1560, 'funding', 'Fundings', 'Fundings', 'بالتمويل', 'financieringen', 'Des financements', 'Förderungen', 'finanziamenti', 'Financiamentos', 'сделкам финансирования', 'Financiaciones', 'Fonlar'),
(1561, 'my_funding', 'My Funding Requests', 'My Funding Requests', 'طلبات التمويل الخاصة بي', 'Mijn financieringsverzoeken', 'Mes demandes de financement', 'Meine Finanzierungsanfragen', 'Le mie richieste di finanziamento', 'Minhas solicitações de financiamento', 'Мои заявки на финансирование', 'Mis solicitudes de financiamiento', 'Finansman İsteklerim'),
(1562, 'create_new_funding', 'Create new funding request', 'Create new funding request', 'إنشاء طلب تمويل جديد', 'Maak een nieuw financieringsverzoek', 'Créer une nouvelle demande de financement', 'Erstellen Sie eine neue Finanzierungsanfrage', 'Crea una nuova richiesta di finanziamento', 'Criar nova solicitação de financiamento', 'Создать новый запрос на финансирование', 'Crear nueva solicitud de financiación', 'Yeni fon talebi yarat'),
(1563, 'funding_created', 'Funding request has been successfully created.', 'Funding request has been successfully created.', 'تم إنشاء طلب التمويل بنجاح.', 'Financieringsaanvraag is succesvol aangemaakt.', 'La demande de financement a été créée avec succès.', 'Finanzierungsantrag wurde erfolgreich erstellt.', 'La richiesta di finanziamento è stata creata correttamente.', 'A solicitação de financiamento foi criada com sucesso.', 'Запрос на финансирование был успешно создан.', 'La solicitud de financiación se ha creado con éxito.', 'Finansman isteği başarıyla oluşturuldu.'),
(1564, 'no_funding_found', 'No funding found', 'No funding to show', 'لم يتم العثور على تمويل', 'Geen financiering gevonden', 'Aucun financement trouvé', 'Keine Finanzierung gefunden', 'Nessun finanziamento trovato', 'Nenhum financiamento encontrado', 'Финансирование не найдено', 'No se encontraron fondos.', 'Fon bulunamadı'),
(1565, 'delete_fund', 'Delete', 'Delete', 'حذف', 'Verwijder', 'Effacer', 'Löschen', 'Elimina', 'Excluir', 'удалять', 'Borrar', 'silmek'),
(1566, 'confirm_delete_fund', 'Are you sure that you want to delete this funding request?', 'Are you sure that you want to delete this funding request?', 'هل أنت متأكد أنك تريد حذف طلب التمويل هذا؟', 'Weet u zeker dat u dit financieringsverzoek wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer cette demande de financement?', 'Möchten Sie diesen Finanzierungsantrag wirklich löschen?', 'Sei sicuro di voler eliminare questa richiesta di finanziamento?', 'Tem certeza de que deseja excluir esta solicitação de financiamento?', 'Вы уверены, что хотите удалить этот запрос на финансирование?', '¿Está seguro de que desea eliminar esta solicitud de financiación?', 'Bu fon talebini silmek istediğinize emin misiniz?'),
(1567, 'funding_edited', 'Funding request has been successfully updated.', 'Funding request has been successfully updated.', 'تم تحديث طلب التمويل بنجاح.', 'Financieringsaanvraag is succesvol bijgewerkt.', 'La demande de financement a été mise à jour avec succès.', 'Der Finanzierungsantrag wurde erfolgreich aktualisiert.', 'La richiesta di finanziamento è stata aggiornata correttamente.', 'A solicitação de financiamento foi atualizada com sucesso.', 'Запрос на финансирование был успешно обновлен.', 'La solicitud de financiación se ha actualizado correctamente.', 'Fon talebi başarıyla güncellendi.'),
(1568, 'most_recent_funding', 'Most recent funding', 'Most recent funding', 'أحدث تمويل', 'Meest recente financiering', 'Financement le plus récent', 'Letzte Finanzierung', 'Finanziamento più recente', 'Financiamento mais recente', 'Самое последнее финансирование', 'Financiamiento más reciente', 'En yeni finansman'),
(1569, 'raised_of', 'Raised of', 'Raised of', 'أثارت من', 'Opgeheven van', 'Élevé de', 'Erzogen von', 'Allevato di', 'Levantado de', 'Поднял из', 'Criado de', 'Yükseltilmiş'),
(1570, 'donate', 'Donate', 'Donate', 'تبرع', 'schenken', 'Faire un don', 'Spenden', 'Donare', 'Doar', 'жертвовать', 'Donar', 'bağışlamak'),
(1571, 'donated_to', 'donated to your funding request.', 'donated to your funding request.', 'تبرعت لطلب التمويل الخاص بك.', 'gedoneerd aan uw financieringsverzoek.', 'fait un don à votre demande de financement.', 'gespendet auf Ihre Finanzierungsanfrage.', 'donato alla tua richiesta di finanziamento.', 'doado para sua solicitação de financiamento.', 'пожертвовал на ваш запрос на финансирование.', 'donado a su solicitud de financiación.', 'fon talebinize bağışta bulunabilirsiniz.'),
(1572, 'total_donations', 'Total donations', 'Total donations', 'مجموع التبرعات', 'Totaal aantal donaties', 'Total des dons', 'Gesamtspenden', 'Donazioni totali', 'Total de doações', 'Всего пожертвований', 'Donaciones totales', 'Toplam bağış'),
(1573, 'recent_donations', 'Recent donations', 'Recent donations', 'التبرعات الأخيرة', 'Recente donaties', 'Dons récents', 'Aktuelle Spenden', 'Donazioni recenti', 'Doações recentes', 'Недавние пожертвования', 'Donaciones recientes', 'Son bağışlar'),
(1575, 'created_donation_request', 'created a donation request', 'created a donation request', 'خلق طلب التبرع', 'een donatieverzoek gemaakt', 'créé une demande de don', 'hat eine Spendenanfrage erstellt', 'ha creato una richiesta di donazione', 'criou uma solicitação de doação', 'создал запрос на пожертвование', 'creó una solicitud de donación', 'bağış isteği oluşturdu'),
(1576, 'people_with_common', 'Meet people with things in common', 'Meet people with things in common', 'التقي بأشخاص لديهم أشياء مشتركة', 'Ontmoet mensen met dingen gemeen', 'Rencontrer des gens avec des choses en commun', 'Treffen Sie Menschen mit Gemeinsamkeiten', 'Incontra persone con cose in comune', 'Conheça pessoas com coisas em comum', 'Встретить людей с общими вещами', 'Conoce gente con cosas en común', 'Ortak şeyleri olan insanlarla tanışın'),
(1577, 'donated_to_request', 'donated to a funding request', 'donated to a funding request', 'تبرعت لطلب التمويل', 'gedoneerd aan een financieringsverzoek', 'donné à une demande de financement', 'an einen Förderantrag gespendet', 'donato a una richiesta di finanziamento', 'doado a uma solicitação de financiamento', 'пожертвовал на запрос финансирования', 'donado a una solicitud de financiación', 'fon talebine bağışlandı'),
(1578, 'you_cant_pay', 'You can`t donate more than {{money}}', 'You can`t donate more than {{money}}', 'لا يمكنك الدفع أكثر من {{money}}', 'U kunt niet meer betalen dan {{money}}', 'Vous ne pouvez pas payer plus que {{money}}', 'Sie können nicht mehr als {{money}} bezahlen', 'Non puoi pagare più di {{money}}', 'Você não pode pagar mais do que {{money}}', 'Вы не можете заплатить больше, чем {{money}}', 'No puede pagar más de {{money}}', '{{Money}} &#039;dan daha fazla ödeyemezsiniz.'),
(1579, 'confirm_delete_job', 'Are you sure that you want to delete this job?', 'Are you sure that you want to delete this job?', 'هل أنت متأكد أنك تريد حذف هذه الوظيفة؟', 'Weet u zeker dat u deze taak wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ce travail?', 'Möchten Sie diesen Job wirklich löschen?', 'Sei sicuro di voler eliminare questo lavoro?', 'Tem certeza de que deseja excluir este trabalho?', 'Вы уверены, что хотите удалить эту работу?', '¿Estás seguro de que deseas eliminar este trabajo?', 'Bu işi silmek istediğinden emin misin?'),
(1580, '1580', 'category', 'Accounting & Finance', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1581, '1581', 'category', 'Admin & Office', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1582, '1582', 'category', 'Art & Design', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1583, '1583', 'category', 'Business Operations', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1584, '1584', 'category', 'Cleaning & Facilities', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1585, '1585', 'category', 'Community & Social Services', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1586, '1586', 'category', 'Computer & Data', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1587, '1587', 'category', 'Construction & Mining', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1588, '1588', 'category', 'Education', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1589, '1589', 'category', 'Farming & Forestry', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1590, '1590', 'category', 'Healthcare', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1591, '1591', 'category', 'Installation, Maintenance & Repair', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1592, '1592', 'category', 'Legal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1593, '1593', 'category', 'Management', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1594, '1594', 'category', 'Manufacturing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1595, '1595', 'category', 'Media & Communication', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1596, '1596', 'category', 'Personal Care', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1597, '1597', 'category', 'Protective Services', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1598, '1598', 'category', 'Restaurant & Hospitality', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1599, '1599', 'category', 'Retail & Sales', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1600, '1600', 'category', 'Science & Engineering', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1601, '1601', 'category', 'Sports & Entertainment', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1602, '1602', 'category', 'Transportation', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1603, 'lost_in_space', '', 'Looks like you&#039;re lost in space!', 'يبدو أنك فقدت في الفضاء!', 'Het lijkt erop dat je verdwaald bent in de ruimte!', 'On dirait que tu es perdu dans lespace!', 'Sieht aus wie Sie im Weltraum verloren sind!', 'Sembra che ti sei perso nello spazio!', 'Parece que você está perdido no espaço!', 'Похоже, вы потерялись в космосе!', '¡Parece que estás perdido en el espacio!', 'Uzayda kaybolmuş gibisin!'),
(1604, 'add_funds', '', 'Add Funds', 'إضافة الأموال', 'Fondsen toevoegen', 'Ajouter des fonds', 'Geld hinzufügen', 'Aggiungere fondi', 'Adicionar fundos', 'Добавить средства', 'Añadir fondos', 'Fon ekle'),
(1605, 'send_money_friends', '', 'Send money to friends', 'إرسال الأموال إلى الأصدقاء', 'Stuur geld naar vrienden', 'Envoyer de largent à des amis', 'Geld an Freunde senden', 'Invia denaro agli amici', 'Envie dinheiro para amigos', 'Отправить деньги друзьям', 'Envía dinero a amigos', 'Arkadaşlarına para gönder'),
(1606, 'view_analytics', '', 'View Analytics', 'عرض التحليلات', 'Bekijk Analytics', 'Afficher les analyses', 'Analytics anzeigen', 'Visualizza Analytics', 'Ver análise', 'Просмотр аналитики', 'Ver análisis', 'Analytics’i Görüntüle'),
(1607, 'next', '', 'Next', 'التالى', 'volgende', 'Prochain', 'Nächster', 'Il prossimo', 'Próximo', 'следующий', 'próximo', 'Sonraki'),
(1608, 'ad_media', '', 'Media', 'وسائل الإعلام', 'Media', 'Médias', 'Medien', 'Media', 'meios de comunicação', 'СМИ', 'Media', 'medya'),
(1609, 'targeting', '', 'Targeting', 'استهداف', 'Gericht op', 'Ciblage', 'Targeting', 'Targeting', 'Alvejando', 'нацеливание', 'Orientación', 'Hedefleme'),
(1610, 'comp_name', '', 'Company name', 'اسم الشركة', 'Bedrijfsnaam', 'Nom de la compagnie', 'Name der Firma', 'Nome della ditta', 'Nome da empresa', 'Название компании', 'Nombre de empresa', 'Şirket Adı'),
(1611, 'camp_title', '', 'Campaign title', 'عنوان الحملة', 'Campagnetitel', 'Titre de la campagne', 'Kampagnentitel', 'Titolo della campagna', 'Título da campanha', 'Название кампании', 'Título de la campaña', 'Kampanya başlığı'),
(1612, 'website_url', '', 'Website URL', 'عنوان موقع الويب', 'Website URL', 'Website URL', 'Website URL', 'URL del sito Web', 'URL do site', 'URL сайта', 'URL del sitio web', 'Web sitesi URLsi'),
(1613, 'camp_desc', '', 'Campaign description', 'وصف الحملة', 'Campagnebeschrijving', 'Description de la campagne', 'Kampagnenbeschreibung', 'Descrizione della campagna', 'Descrição da campanha', 'Описание кампании', 'Descripción de la campaña.', 'Kampanya açıklaması'),
(1614, 'ad_img_help', '', 'Select a image for your campaign', 'اختر صورة لحملتك', 'Selecteer een afbeelding voor uw campagne', 'Sélectionnez une image pour votre campagne', 'Wählen Sie ein Bild für Ihre Kampagne aus', 'Seleziona unimmagine per la tua campagna', 'Selecione uma imagem para sua campanha', 'Выберите изображение для вашей кампании', 'Seleccione una imagen para su campaña', 'Kampanyanız için bir resim seçin'),
(1615, 'ad_start_date_help', '', 'Select campaign starting date, UTC', 'حدد تاريخ بدء الحملة ، UTC', 'Selecteer campagne startdatum, UTC', 'Sélectionnez la date de début de la campagne, UTC', 'Wählen Sie das Startdatum der Kampagne (UTC)', 'Seleziona la data di inizio della campagna, UTC', 'Selecionar data de início da campanha, UTC', 'Выберите дату начала кампании, UTC', 'Seleccione la fecha de inicio de la campaña, UTC', 'Kampanya başlangıç ​​tarihini seçin, UTC'),
(1616, 'ad_end_date_help', '', 'Select campaign ending date, UTC', 'حدد تاريخ انتهاء الحملة ، UTC', 'Selecteer einddatum campagne, UTC', 'Sélectionnez la date de fin de la campagne, UTC', 'Wählen Sie das Enddatum der Kampagne (UTC)', 'Seleziona la data di fine della campagna, UTC', 'Selecionar data de término da campanha, UTC', 'Выберите дату окончания кампании, UTC', 'Seleccione la fecha de finalización de la campaña, UTC', 'Kampanya bitiş tarihini seçin, UTC'),
(1617, 'ad_desc_help', '', 'Tell users what your campaign is about', 'أخبر المستخدمين بماهية حملتك', 'Vertel gebruikers waar uw campagne over gaat', 'Expliquez aux utilisateurs en quoi consiste votre campagne', 'Teilen Sie den Nutzern mit, worum es in Ihrer Kampagne geht', 'Dì agli utenti di cosa tratta la tua campagna', 'Informe aos usuários o que é sua campanha', 'Расскажите пользователям о вашей кампании', 'Informe a los usuarios de qué trata su campaña', 'Kullanıcılara kampanyanızın ne hakkında olduğunu söyleyin'),
(1618, 'camp_budget', '', 'Campaign Budget', 'ميزانية الحملة', 'Campagne Budget', 'budget de campagne', 'Kampagnenbudget', 'Budget della campagna', 'Orçamento de Campanha', 'Бюджет кампании', 'Presupuesto Campaña', 'Kampanya Bütçesi'),
(1619, 'camp_budget_help', '', 'Enter the amount you want to spend on this campaign', 'أدخل المبلغ الذي تريد إنفاقه على هذه الحملة', 'Voer het bedrag in dat u aan deze campagne wilt besteden', 'Saisissez le montant que vous souhaitez dépenser pour cette campagne', 'Geben Sie den Betrag ein, den Sie für diese Kampagne ausgeben möchten', 'Inserisci limporto che desideri spendere per questa campagna', 'Digite o valor que você deseja gastar nesta campanha', 'Введите сумму, которую вы хотите потратить на эту кампанию', 'Ingrese el monto que desea gastar en esta campaña', 'Bu kampanyada harcamak istediğiniz tutarı girin'),
(1620, 'ad_preview', '', 'Ad preview', 'معاينة الإعلان', 'Advertentievoorbeeld', 'Aperçu de lannonce', 'Anzeigenvorschau', 'Ad preview', 'Visualização do anúncio', 'Предварительный просмотр рекламы', 'Vista previa del anuncio', 'Reklam önizlemesi'),
(1621, 'album_name_help', '', 'Choose your album name', 'اختر اسم الألبوم الخاص بك', 'Kies je albumnaam', 'Choisissez le nom de votre album', 'Wählen Sie Ihren Albumnamen', 'Scegli il nome del tuo album', 'Escolha o nome do seu álbum', 'Выберите название вашего альбома', 'Elige el nombre de tu álbum', 'Albüm adınızı seçin'),
(1622, 'browse_articles', '', 'Browse articles', 'تصفح المقالات', 'Blader door artikelen', 'Browse articles', 'Artikel durchsuchen', 'Sfoglia gli articoli', 'Procurar artigos', 'Просмотр статей', 'Examinar artículos', 'Makalelere göz at'),
(1623, 'no_blogs_created', '', 'You haven&#039;t created any articles yet.', 'لم تنشئ أي مقالات حتى الآن.', 'U heeft nog geen artikelen gemaakt.', 'Vous navez pas encore créé darticles.', 'Sie haben noch keine Artikel erstellt.', 'Non hai ancora creato alcun articolo.', 'Você ainda não criou nenhum artigo.', 'Вы еще не создали ни одной статьи.', 'Aún no has creado ningún artículo.', 'Henüz herhangi bir makale yazmadınız.'),
(1624, 'create_group_chat', '', 'Create a group chat', 'إنشاء دردشة جماعية', 'Maak een groepschat', 'Créer un chat en groupe', 'Erstelle einen Gruppenchat', 'Crea una chat di gruppo', 'Crie um chat em grupo', 'Создать групповой чат', 'Crea un chat grupal', 'Grup sohbeti oluştur'),
(1625, 'turn_on', '', 'Turn On', 'شغله', 'Aanzetten', 'Allumer', 'Anschalten', 'Accendere', 'Ligar', 'Включать', 'Encender', 'Aç'),
(1626, 'type_message', '', 'Type a message', 'اكتب رسالة', 'Type een bericht', 'Type a message', 'Geben Sie eine Nachricht ein', 'Scrivi un messaggio', 'Digite uma mensagem', 'Введите сообщение', 'Escribe un mensaje', 'Bir mesaj yazın'),
(1627, 'edit_funding', '', 'Edit funding request', 'تحرير طلب التمويل', 'Financieringsaanvraag bewerken', 'Modifier la demande de financement', 'Förderantrag bearbeiten', 'Modifica richiesta di finanziamento', 'Editar solicitação de financiamento', 'Изменить заявку на финансирование', 'Editar solicitud de financiación', 'Finansman talebini düzenle'),
(1628, 'fund_amount', '', 'How much money you would like to receive?', 'كم من المال تريد الحصول عليه؟', 'Hoeveel geld wilt u ontvangen?', 'Combien dargent aimeriez-vous recevoir?', 'Wie viel Geld möchten Sie erhalten?', 'Quanti soldi vorresti ricevere?', 'Quanto dinheiro você gostaria de receber?', 'Сколько денег вы хотели бы получить?', '¿Cuánto dinero te gustaría recibir?', 'Ne kadar para almak istersin?'),
(1629, 'browse_events', '', 'Browse Events', 'تصفح الأحداث', 'Bladeren door evenementen', 'Parcourir les événements', 'Events durchsuchen', 'Sfoglia gli eventi', 'Procurar Eventos', 'Просмотр событий', 'Examinar eventos', 'Etkinliklere Göz At'),
(1630, 'start_time', '', 'Start time', 'وقت البدء', 'Starttijd', 'Heure de début', 'Startzeit', 'Orario di inizio', 'Hora de início', 'Время начала', 'Hora de inicio', 'Başlama zamanı'),
(1631, 'end_time', '', 'End time', 'وقت النهاية', 'Eindtijd', 'Heure de fin', 'Endzeit', 'Fine del tempo', 'Fim do tempo', 'Время окончания', 'Hora de finalización', 'Bitiş zamanı'),
(1632, 'no_one_created_event', '', 'It seems like no one created an event yet!', 'يبدو أن لا أحد أنشأ حدثًا حتى الآن!', 'Het lijkt erop dat nog niemand een evenement heeft gemaakt!', 'Il semble que personne na encore créé dévénement!', 'Es scheint, dass noch niemand ein Event erstellt hat!', 'Sembra che nessuno abbia ancora creato un evento!', 'Parece que ninguém criou um evento ainda!', 'Кажется, что никто еще не создал событие!', '¡Parece que nadie creó un evento todavía!', 'Henüz kimse bir etkinlik oluşturmadı!'),
(1633, 'event_start', '', 'When this event will start?', 'متى سيبدأ هذا الحدث؟', 'Wanneer begint dit evenement?', 'Quand cet événement va-t-il commencer?', 'Wann beginnt diese Veranstaltung?', 'Quando inizierà questo evento?', 'Quando este evento começará?', 'Когда это событие начнется?', '¿Cuándo comenzará este evento?', 'Bu etkinlik ne zaman başlayacak?'),
(1634, 'event_end', '', 'When this event will end?', 'متى سينتهي هذا الحدث؟', 'Wanneer eindigt dit evenement?', 'Quand cet événement se terminera-t-il?', 'Wann endet diese Veranstaltung?', 'Quando finirà questo evento?', 'Quando este evento terminará?', 'Когда это событие закончится?', '¿Cuándo terminará este evento?', 'Bu etkinlik ne zaman bitecek?'),
(1635, 'browse_forum', '', 'Browse Forum', 'تصفح المنتدى', 'Browse forum', 'Parcourir le forum', 'Forum durchsuchen', 'Sfoglia il forum', 'Navegar no Fórum', 'Обзор форума', 'Examinar el foro', 'Foruma Göz At'),
(1636, 'browse_funding', '', 'Browse Funding', 'تصفح التمويل', 'Browse financiering', 'Parcourir le financement', 'Durchsuchen Sie die Finanzierung', 'Sfoglia finanziamenti', 'Procurar financiamento', 'Просмотр финансирования', 'Examinar Financiamiento', 'Finansmana Göz Atın'),
(1637, 'filter', '', 'Filter', 'منقي', 'Filter', 'Filtre', 'Filter', 'Filtro', 'Filtro', 'Фильтр', 'Filtrar', 'filtre'),
(1638, 'personal_pic', '', 'Your personal picture', 'صورتك الشخصية', 'Je persoonlijke foto', 'Votre photo personnelle', 'Dein persönliches Bild', 'La tua foto personale', 'Sua foto pessoal', 'Ваша личная фотография', 'Tu foto personal', 'Kişisel resmin'),
(1639, 'dont_have_account', '', 'Don&#039;t have an account?', 'ليس لديك حساب؟', 'Heb je nog geen account?', 'Vous navez pas de compte?', 'Sie haben noch keinen Account?', 'Non hai un account?', 'Não possui uma conta?', 'У вас нет аккаунта?', '¿No tienes una cuenta?', 'Hesabınız yok mu?'),
(1640, 'already_have_account', '', 'Already have an account?', 'هل لديك حساب؟', 'Heb je al een account?', 'Vous avez déjà un compte?', 'Hast du schon ein Konto?', 'Hai già un account?', 'já tem uma conta?', 'Уже есть аккаунт?', '¿Ya tienes una cuenta?', 'Zaten hesabınız var mı?'),
(1641, 'approve_post_text', '', 'Your post was submitted, we will review your content soon.', 'تم إرسال المنشور الخاص بك ، سنراجع المحتوى الخاص بك قريبًا.', 'Je bericht is verzonden. We zullen je inhoud binnenkort beoordelen.', 'Votre message a été envoyé, nous examinerons bientôt votre contenu.', 'Ihr Beitrag wurde übermittelt. Wir werden Ihren Inhalt in Kürze überprüfen.', 'Il tuo post è stato inviato, esamineremo presto i tuoi contenuti.', 'Sua postagem foi enviada. Analisaremos seu conteúdo em breve.', 'Ваше сообщение отправлено, мы скоро рассмотрим ваш контент.', 'Su publicación fue enviada, revisaremos su contenido pronto.', 'Gönderiniz gönderildi, içeriğinizi yakında inceleyeceğiz.'),
(1642, 'remove_all_sessions', '', 'Logout From All Sessions', 'تسجيل الخروج من جميع الدورات', 'Uitloggen bij alle sessies', 'Déconnexion de toutes les sessions', 'Von allen Sitzungen abmelden', 'Esci da tutte le sessioni', 'Sair de todas as sessões', 'Выйти из всех сессий', 'Cerrar sesión de todas las sesiones', 'Tüm Oturumlardan Çıkış Yap'),
(1643, 'approve_post', '', 'Your post was approved and published!', 'تمت الموافقة على مشاركتك ونشرها!', 'Je bericht is goedgekeurd en gepubliceerd!', 'Votre message a été approuvé et publié!', 'Ihr Beitrag wurde genehmigt und veröffentlicht!', 'Il tuo post è stato approvato e pubblicato!', 'Sua postagem foi aprovada e publicada!', 'Ваш пост был одобрен и опубликован!', '¡Tu publicación fue aprobada y publicada!', 'Gönderiniz onaylandı ve yayınlandı!'),
(1645, 'no_going_people', '', 'There are no going users.', 'لا يوجد مستخدمون ذاهبون.', 'Er zijn geen vertrekkende gebruikers.', 'Il ny a aucun utilisateur actif.', 'Es gibt keine gehenden Benutzer.', 'Non ci sono utenti attivi.', 'Não há usuários ativos.', 'Там нет идущих пользователей.', 'No hay usuarios que vayan.', 'Giden kullanıcı yok.'),
(1646, 'liked_pages', '', 'Liked Pages', 'صفحات أعجبتني', 'Liked Pages', 'Pages aimées', 'Gefallene Seiten', 'Pagine piaciute', 'Páginas curtidas', 'Понравившиеся страницы', 'Páginas Me gusta', 'Beğenilen Sayfalar'),
(1647, 'joined_groups', '', 'Joined Groups', 'انضم إلى المجموعات', 'Aangesloten groepen', 'Groupes joints', 'Verbundene Gruppen', 'Gruppi uniti', 'Grupos Associados', 'Объединенные группы', 'Grupos unidos', 'Katılan Gruplar'),
(1648, 'earn_text_create_blog', '', 'Earn %d points by creating a new blog', 'كسب٪ d نقاط عن طريق إنشاء مدونة جديدة', 'Verdien %d punten door een nieuw blog te maken', 'Gagnez %d points en créant un nouveau blog', 'Verdiene %d Punkte, indem du ein neues Blog erstellst', 'Guadagna %d punti creando un nuovo blog', 'Ganhe %d pontos criando um novo blog', 'Заработайте %d баллов, создав новый блог', 'Gane %d puntos creando un nuevo blog', 'Yeni bir blog oluşturarak %d puan kazanın'),
(1649, 'view_interested_Candidates', '', 'View Interested Candidates', 'عرض المرشحين المهتمين', 'Bekijk geïnteresseerde kandidaten', 'Voir les candidats intéressés', 'Interessierte Kandidaten anzeigen', 'Visualizza i candidati interessati', 'Exibir candidatos interessados', 'Посмотреть заинтересованных кандидатов', 'Ver candidatos interesados', 'İlgilenen Adayları Göster'),
(1650, 'memories', '', 'Memories', 'ذكريات', 'Herinneringen', 'Souvenirs', 'Erinnerungen', 'Ricordi', 'Recordações', 'Воспоминания', 'Recuerdos', 'hatıralar'),
(1651, 'on_this_day', '', 'On this day', 'في هذا اليوم', 'Op deze dag', 'Ce jour-là', 'An diesem Tage', 'In questo giorno', 'Neste dia', 'В этот день', 'En este día', 'Bugün'),
(1652, 'there_are_no_memories_this_day', '', 'You don&#039;t have any memories on this day.', 'ليس لديك أي ذكريات في هذا اليوم.', 'Je hebt op deze dag geen herinneringen.', 'Vous navez aucun souvenir ce jour-là.', 'Sie haben an diesem Tag keine Erinnerungen.', 'Non hai ricordi in questo giorno.', 'Você não tem lembranças neste dia.', 'У тебя нет воспоминаний в этот день.', 'No tienes ningún recuerdo en este día.', 'Bu günle ilgili hatıralarınız yok.'),
(1653, 'friendversaries', '', 'Friendaversary', 'Friendaversary', 'Vriendschap', 'Friendaversary', 'Friendaversary', 'Friendaversary', 'Friendaversary', 'Friendaversary', 'Friendaversary', 'Friendaversary'),
(1654, 'memory_this_day', '', 'You have remembrance on this day', 'لديك ذكرى في هذا اليوم', 'Je hebt op deze dag een herinnering', 'Vous vous souvenez de ce jour', 'Sie haben Erinnerung an diesen Tag', 'Hai un ricordo in questo giorno', 'Você tem lembrança neste dia', 'У вас есть память в этот день', 'Recuerdas este día', 'Bu gün hatırlıyorsun'),
(1655, 'page_analytics', '', 'Page Analytics', 'تحليلات الصفحة', 'Pagina-analyse', 'Page Analytics', 'Seitenanalyse', 'Analisi della pagina', 'Page Analytics', 'Аналитика страниц', 'Analítica de página', 'Sayfa Analizi'),
(1656, 'total_likes', '', 'Total Likes', 'إجمالي الإعجابات', 'Totaal aantal likes', 'Total Jaime', 'Total Likes', 'Mi Piace totali', 'Total de curtidas', 'Всего лайков', 'Me gusta total', 'Toplam Beğenme'),
(1657, 'today', '', 'Today', 'اليوم', 'Vandaag', 'Aujourdhui', 'Heute', 'Oggi', 'Hoje', 'Cегодня', 'Hoy', 'Bugün'),
(1658, 'this_month', '', 'This Month', 'هذا الشهر', 'Deze maand', 'Ce mois-ci', 'Diesen Monat', 'Questo mese', 'Este mês', 'Этот месяц', 'Este mes', 'Bu ay'),
(1659, 'this_year', '', 'This Year', 'هذا العام', 'Dit jaar', 'Cette année', 'Dieses Jahr', 'Questanno', 'Este ano', 'Этот год', 'Este año', 'Bu yıl'),
(1660, 'group_analytics', '', 'Group Analytics', 'تحليلات المجموعة', 'Groepsanalyse', 'Analytique de groupe', 'Gruppenanalyse', 'Analisi di gruppo', 'Análise de grupo', 'Групповая аналитика', 'Analítica de grupo', 'Grup Analizi'),
(1661, 'total_member', '', 'Total Members', 'مجموع الأعضاء', 'Totaal aantal leden', 'Total des membres', 'Mitglieder insgesamt', 'Membri totali', 'Total de membros', 'Всего участников', 'Miembros totales', 'Toplam Üye'),
(1662, 'thread_reply', '', 'replied to your thread', 'رد على موضوعك', 'antwoordde op uw thread', 'répondu à votre fil', 'hat auf deinen Thread geantwortet', 'rispose alla tua discussione', 'respondeu ao seu tópico', 'ответил в вашу ветку', 'respondió a tu hilo', 'iş parçacığına cevap verdi'),
(1663, 'share_on_timeline', '', 'Share on my timeline', 'شارك على الجدول الزمني الخاص بي', 'Deel op mijn tijdlijn', 'Partager sur ma chronologie', 'Teile auf meiner Timeline', 'Condividi sulla mia cronologia', 'Compartilhar na minha linha do tempo', 'Поделиться на моем графике', 'Comparte en mi línea de tiempo', 'Zaman çizelgemde paylaş'),
(1664, 'shared_forum', '', 'shared a forum', 'شارك منتدى', 'heeft een forum gedeeld', 'shared a forum', 'hat ein Forum geteilt', 'ha condiviso un forum', 'compartilhou um fórum', 'поделился форумом', 'compartió un foro', 'bir forum paylaştı'),
(1665, 'forum_shared', '', 'Forum posts were successfully added to your timeline!', 'تمت إضافة مشاركات المنتدى إلى الجدول الزمني الخاص بك بنجاح!', 'Forumberichten zijn met succes toegevoegd aan uw tijdlijn!', 'Les messages du forum ont été ajoutés avec succès à votre chronologie!', 'Forenbeiträge wurden erfolgreich zu Ihrer Timeline hinzugefügt!', 'I post del forum sono stati aggiunti correttamente alla tua sequenza temporale!', 'As postagens do fórum foram adicionadas com sucesso à sua linha do tempo!', 'Сообщения на форуме были успешно добавлены в ваш график!', '¡Las publicaciones del foro se agregaron con éxito a su línea de tiempo!', 'Forum gönderileri zaman çizelgenize başarıyla eklendi!'),
(1666, 'thread_shared', '', 'Thread was successfully added to your timeline!', 'تمت إضافة الموضوع بنجاح إلى مخططك الزمني!', 'Discussie is met succes toegevoegd aan je tijdlijn!', 'Le fil a été ajouté avec succès à votre chronologie!', 'Thread wurde erfolgreich zu Ihrer Timeline hinzugefügt!', 'La discussione è stata aggiunta correttamente alla tua cronologia!', 'O tópico foi adicionado com sucesso à sua linha do tempo!', 'Тема была успешно добавлена ​​в ваш график!', '¡El hilo se agregó con éxito a su línea de tiempo!', 'Konu zaman çizelgenize başarıyla eklendi!'),
(1667, 'shared_thread', '', 'shared a thread', 'شارك موضوع', 'deelde een thread', 'a partagé un fil de discussion', 'hat einen Thread geteilt', 'ha condiviso una discussione', 'compartilhou um tópico', 'поделился темой', 'ha compartido un hilo', 'bir konu paylaştı'),
(1668, 'sub_category', '', 'Sub Category', 'تصنيف فرعي', 'Subcategorie', 'Sous-catégorie', 'Unterkategorie', 'Sottocategoria', 'Subcategoria', 'Подкатегория', 'Subcategoría', 'Alt Kategori'),
(1669, 'remaining_text', '', 'Remaining {{time}} for your membership', '{{time}} المتبقية لعضويتك', 'Resterende {{tijd}} voor uw lidmaatschap', 'Reste {{time}} pour votre adhésion', 'Verbleibende {{Zeit}} für Ihre Mitgliedschaft', 'Restante {{time}} per la tua iscrizione', 'Restante {{time}} para sua associação', 'Осталось {{time}} для вашего членства', 'Restante {{time}} para su membresía', 'Üyeliğiniz için {{time}} kaldı'),
(1670, 'free_plan_upload', '', 'To upload images, videos, and audio files, you have to upgrade to pro member.', 'لتحميل الصور ومقاطع الفيديو والملفات الصوتية ، يجب الترقية إلى عضو محترف.', 'Om afbeeldingen, videos en audiobestanden te uploaden, moet je upgraden naar pro-lid.', 'Pour télécharger des images, des vidéos et des fichiers audio, vous devez passer à un membre pro.', 'Um Bilder, Videos und Audiodateien hochzuladen, müssen Sie ein Upgrade auf Pro Member durchführen.', 'Per caricare immagini, video e file audio, devi effettuare lupgrade a un membro professionista.', 'Para fazer upload de imagens, vídeos e arquivos de áudio, é necessário atualizar para o membro profissional.', 'Чтобы загрузить изображения, видео и аудио файлы, вы должны перейти на профессиональный член.', 'Para cargar imágenes, videos y archivos de audio, debe actualizar a miembro profesional.', 'Resim, video ve ses dosyası yüklemek için profesyonel üyeye yükseltmelisiniz.'),
(1671, 'free_plan_upload_pro', '', 'To upload images, videos, and audio files, you have to upgrade to pro member.', 'لتحميل الصور ومقاطع الفيديو والملفات الصوتية ، يجب الترقية إلى عضو محترف.', 'Om afbeeldingen, videos en audiobestanden te uploaden, moet je upgraden naar pro-lid.', 'Pour télécharger des images, des vidéos et des fichiers audio, vous devez passer à un membre pro.', 'Um Bilder, Videos und Audiodateien hochzuladen, müssen Sie ein Upgrade auf Pro Member durchführen.', 'Per caricare immagini, video e file audio, devi effettuare lupgrade a un membro professionista.', 'Para fazer upload de imagens, vídeos e arquivos de áudio, é necessário atualizar para o membro profissional.', 'Чтобы загрузить изображения, видео и аудио файлы, вы должны перейти на профессиональный член.', 'Para cargar imágenes, videos y archivos de audio, debe actualizar a miembro profesional.', 'Resim, video ve ses dosyası yüklemek için profesyonel üyeye yükseltmelisiniz.'),
(1672, 'approve_blog', '', 'Your blog was approved and published!', 'تمت الموافقة على مدونتك ونشرها!', 'Je blog is goedgekeurd en gepubliceerd!', 'Votre blog a été approuvé et publié!', 'Ihr Blog wurde genehmigt und veröffentlicht!', 'Il tuo blog è stato approvato e pubblicato!', 'Seu blog foi aprovado e publicado!', 'Ваш блог был одобрен и опубликован!', 'Su blog fue aprobado y publicado!', 'Blogunuz onaylandı ve yayınlandı!'),
(1673, 'refund', '', 'Refund', 'إعادة مال', 'Terugbetaling', 'Rembourser', 'Rückerstattung', 'Rimborso', 'Reembolso', 'Возврат денег', 'Reembolso', 'Geri ödeme'),
(1674, 'refund_page', '', 'Refund page', 'صفحة استرداد الأموال', 'Pagina terugbetalen', 'Page de remboursement', 'Rückerstattungsseite', 'Pagina di rimborso', 'Página de reembolso', 'Страница возврата', 'Página de reembolso', 'Geri ödeme sayfası'),
(1675, 'reason', '', 'Reason', 'السبب', 'Reden', 'Raison', 'Grund', 'Motivo', 'Razão', 'причина', 'Razón', 'neden'),
(1676, 'business_days', '', 'We will review your request within 2 - 3 business days.', 'سنراجع طلبك خلال 2 - 3 أيام عمل.', 'We beoordelen uw verzoek binnen twee tot drie werkdagen.', 'Nous examinerons votre demande dans un délai de 2 à 3 jours ouvrables.', 'Wir werden Ihre Anfrage innerhalb von 2 - 3 Werktagen prüfen.', 'Esamineremo la tua richiesta entro 2-3 giorni lavorativi.', 'Analisaremos sua solicitação dentro de 2 a 3 dias úteis.', 'Мы рассмотрим ваш запрос в течение 2–3 рабочих дней.', 'Revisaremos su solicitud dentro de 2 a 3 días hábiles.', 'İsteğinizi 2-3 iş günü içinde inceleyeceğiz.'),
(1677, 'you_not_membership', '', 'Oops, You are not a subscriber, you can&#039;t request refund.', 'عفوًا ، أنت لست مشتركًا ، لا يمكنك طلب استرداد الأموال.', 'Oeps, u bent geen abonnee, u kunt geen restitutie aanvragen.', 'Oups, vous nêtes pas abonné, vous ne pouvez pas demander de remboursement.', 'Hoppla, Sie sind kein Abonnent, Sie können keine Rückerstattung beantragen.', 'Spiacenti, non sei un abbonato, non puoi richiedere il rimborso.', 'Ops, você não é assinante, não pode solicitar reembolso.', 'К сожалению, вы не являетесь подписчиком, вы не можете запросить возврат.', 'Vaya, no eres un suscriptor, no puedes solicitar un reembolso.', 'Hata! Abone değilsiniz, geri ödeme isteğinde bulunamazsınız.'),
(1678, 'select_your_membership', '', 'Please select your correct membership', 'يرجى تحديد عضويتك الصحيحة', 'Selecteer uw juiste lidmaatschap', 'Veuillez sélectionner votre adhésion correcte', 'Bitte wählen Sie Ihre korrekte Mitgliedschaft', 'Seleziona la tua iscrizione corretta', 'Selecione sua associação correta', 'Пожалуйста, выберите правильное членство', 'Por favor seleccione su membresía correcta', 'Lütfen doğru üyeliğinizi seçin'),
(1679, 'request_review_text', '', 'Your request is under review, we will notify you once its approved', 'طلبك قيد المراجعة ، وسوف نخطرك بمجرد ذلك', 'Uw verzoek wordt beoordeeld, we zullen u hiervan op de hoogte stellen', 'Votre demande est en cours dexamen, nous vous en informerons une fois', 'Ihre Anfrage wird geprüft, wir werden Sie benachrichtigen, sobald sie vorliegt', 'La tua richiesta è in fase di revisione, ti informeremo una volta', 'O seu pedido está em revisão, iremos notificá-lo assim que', 'Ваш запрос находится на рассмотрении, мы сообщим вам, как только', 'Su solicitud está bajo revisión, se lo notificaremos una vez', 'İsteğiniz inceleniyor, size bir kez bildireceğiz'),
(1680, 'refund_decline', '', 'Your refund request has been declined!', 'تم رفض طلب استرداد الأموال الخاص بك!', 'Uw teruggaveverzoek is afgewezen!', 'Votre demande de remboursement a été refusée!', 'Ihr Rückerstattungsantrag wurde abgelehnt!', 'La tua richiesta di rimborso è stata rifiutata!', 'O seu pedido de reembolso foi recusado!', 'Ваш запрос на возврат был отклонен!', '¡Su solicitud de reembolso ha sido rechazada!', 'Geri ödeme isteğiniz reddedildi!'),
(1681, 'refund_approve', '', 'Your refund request has been approved! please check your balance.', 'تمت الموافقة على طلب استرداد الأموال الخاص بك! يرجى التحقق من رصيدك.', 'Uw teruggaveverzoek is goedgekeurd! controleer uw saldo.', 'Votre demande de remboursement a été approuvée! veuillez vérifier votre solde.', 'Ihr Rückerstattungsantrag wurde genehmigt! Bitte überprüfen Sie Ihr Guthaben.', 'La tua richiesta di rimborso è stata approvata! controlla il tuo saldo.', 'O seu pedido de reembolso foi aprovado! por favor, verifique seu saldo.', 'Ваш запрос на возврат был одобрен! пожалуйста, проверьте свой баланс.', '¡Su solicitud de reembolso ha sido aprobada! por favor revise su saldo.', 'Geri ödeme isteğiniz onaylandı! lütfen bakiyenizi kontrol edin.'),
(1682, 'paystack', '', 'Paystack', 'Paystack', 'Paystack', 'Paystack', 'Paystack', 'Paystack', 'Paystack', 'Paystack', 'Paystack', 'Paystack'),
(1683, 'cashfree', '', 'Cashfree', 'نقدي', 'Geldvrij', 'Cashfree', 'Bargeldlos', 'Cashfree', 'Cashfree', 'Cashfree', 'Libre de efectivo', 'Cashfree'),
(1684, 'offer', '', 'Offer', 'عرض', 'Aanbod', 'Offre', 'Angebot', 'Offrire', 'Oferta', 'Предложение', 'Oferta', 'Teklif'),
(1685, 'create_offer', '', 'Create New Offer', 'إنشاء عرض جديد', 'Maak een nieuwe aanbieding', 'Créer une nouvelle offre', 'Neues Angebot erstellen', 'Crea nuova offerta', 'Criar nova oferta', 'Создать новое предложение', 'Crear nueva oferta', 'Yeni Teklif Oluştur'),
(1686, 'post_offer_text', '', 'Post a offer for {{page_name}} on', 'انشر عرضًا لـ {{page_name}} في', 'Plaats een aanbieding voor {{page_name}} op', 'Publiez une offre pour {{page_name}} sur', 'Veröffentlichen Sie ein Angebot für {{Seitenname}} am', 'Pubblica unofferta per {{page_name}} su', 'Poste uma oferta para {{page_name}} no', 'Разместите предложение для {{page_name}} в', 'Publique una oferta para {{page_name}} en', '{{Page_name}} için bir teklif gönderin'),
(1688, 'offer_type', '', 'Offer Type', 'نوع العرض', 'Aanbiedingstype', 'Type doffre', 'Angebotsart', 'Tipo di offerta', 'Tipo de oferta', 'Тип предложения', 'Tipo de oferta', 'Teklif Türü'),
(1689, 'discount_percent', '', 'Discount Percent', 'نسبة الخصم', 'Kortingspercentage', 'Pourcentage de remise', 'Rabatt Prozent', 'Percentuale di sconto', 'Porcentagem de desconto', 'Процент скидки', 'Porcentaje de descuento', 'İndirim Yüzdesi'),
(1690, 'discount_amount', '', 'Discount Amount', 'مقدار الخصم', 'Korting hoeveelheid', 'Montant de la remise', 'Rabattbetrag', 'Totale sconto', 'Valor do desconto', 'Сумма скидки', 'Importe de descuento', 'İndirim tutarı'),
(1691, 'buy_get_discount', '', 'Buy X Get Y Discount', 'اشترِ X احصل على خصم Y', 'Koop X krijg Y korting', 'Acheter X Get Y Discount', 'Kaufen Sie X Get Y Discount', 'Acquista X Ottieni Y Sconto', 'Compre o desconto X Get Y', 'Купить X Получить Y Скидка', 'Compre X Obtenga Y Descuento', 'X Get Y İndirimi Satın Al'),
(1692, 'spend_get_off', '', 'Spend X Get Y Off', 'أنفق X احصل على Y Off', 'Besteed X Krijg Y Off', 'Passer X descendre Y', 'Verbringen Sie X Get Y Off', 'Spendi X Ottieni Y Off', 'Gaste X e tire Y', 'Потрать X Получи Y Off', 'Gastar X Obtener Y Off', 'X Harcama Y Kazanın'),
(1693, 'free_shipping', '', 'Free Shipping', 'الشحن مجانا', 'Gratis verzending', 'Livraison gratuite', 'Kostenloser Versand', 'Spedizione gratuita', 'Envio Grátis', 'Бесплатная доставка', 'Envío gratis', 'Ücretsiz kargo'),
(1694, 'get', '', 'Get', 'احصل على', 'Krijgen', 'Avoir', 'Bekommen', 'Ottenere', 'Obter', 'Получить', 'Obtener', 'Almak'),
(1695, 'spend', '', 'Spend', 'أنفق', 'Besteden', 'Dépenser', 'Verbringen', 'Trascorrere', 'Gastar', 'Проводить', 'Gastar', 'Harcama'),
(1696, 'amount_off', '', 'Amount Off', 'المبلغ خارج', 'Bedrag uit', 'Montant hors', 'Betrag aus', 'Importo Off', 'Valor desativado', 'Сумма выключена', 'Cantidad de descuento', 'Tutar Kapalı'),
(1697, 'offer_successfully_created', '', 'Offer successfully created.', 'تم إنشاء العرض بنجاح.', 'Aanbieding succesvol gemaakt.', 'Offre créée avec succès.', 'Angebot erfolgreich erstellt.', 'Offerta creata con successo.', 'Oferta criada com sucesso.', 'Предложение успешно создано.', 'Oferta creada con éxito.', 'Teklif başarıyla oluşturuldu.'),
(1698, 'created_offer', '', 'Created new offer', 'تم إنشاء عرض جديد', 'Nieuwe aanbieding gemaakt', 'Création dune nouvelle offre', 'Neues Angebot erstellt', 'Nuova offerta creata', 'Nova oferta criada', 'Создано новое предложение', 'Nueva oferta creada', 'Yeni teklif oluşturuldu'),
(1699, 'discounted_items', '', 'Discounted Items and/or Services', 'عناصر و / أو خدمات مخفضة', 'Afgeprijsde artikelen en / of services', 'Articles et / ou services à prix réduit', 'Ermäßigte Artikel und / oder Dienstleistungen', 'Articoli e / o servizi scontati', 'Itens com desconto e / ou serviços', 'Уцененные товары и / или услуги', 'Artículos y / o servicios con descuento', 'İndirimli Ürünler ve / veya Hizmetler');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1700, 'items_services', '', 'Add items or services to this offer Max 100 character', 'أضف عناصر أو خدمات لهذا العرض بحد أقصى 100 حرف', 'Voeg items of services toe aan deze aanbieding Max. 100 tekens', 'Ajouter des articles ou des services à cette offre 100 caractères max.', 'Fügen Sie diesem Angebot Artikel oder Dienstleistungen hinzu. Maximal 100 Zeichen', 'Aggiungi articoli o servizi a questa offerta Max 100 caratteri', 'Adicione itens ou serviços a esta oferta Máximo de 100 caracteres', 'Добавить товары или услуги к этому предложению Макс 100 символов', 'Agregue elementos o servicios a esta oferta Máximo 100 caracteres', 'Bu teklife ürün veya hizmet ekleyin Maks. 100 karakter'),
(1701, 'discounted_items_less', '', 'Discounted items must be less than 100 character', 'يجب أن تكون العناصر المخصومة أقل من 100 حرف', 'Items met korting moeten minder dan 100 tekens bevatten', 'Les articles à prix réduits doivent contenir moins de 100 caractères', 'Ermäßigte Artikel müssen weniger als 100 Zeichen enthalten', 'Gli articoli scontati devono contenere meno di 100 caratteri', 'Itens com desconto devem ter menos de 100 caracteres', 'Уцененные предметы должны быть менее 100 символов', 'Los artículos con descuento deben tener menos de 100 caracteres.', 'İndirimli ürünler 100 karakterden az olmalıdır'),
(1702, 'offers', '', 'Offers', 'عروض', 'Aanbiedingen', 'Des offres', 'Bietet an', 'offerte', 'Ofertas', 'Предложения', 'Ofertas', 'Teklifler'),
(1703, 'load_more_offers', '', 'Load more offers', 'تحميل المزيد من العروض', 'Laad meer aanbiedingen', 'Charger plus doffres', 'Laden Sie weitere Angebote', 'Carica più offerte', 'Carregar mais ofertas', 'Загрузить больше предложений', 'Cargue más ofertas', 'Daha fazla teklif yükle'),
(1704, 'no_available_offers', '', 'No available offers to show.', 'لا توجد عروض متاحة للعرض.', 'Geen beschikbare aanbiedingen om weer te geven.', 'Aucune offre disponible à afficher.', 'Keine verfügbaren Angebote zu zeigen.', 'Nessuna offerta disponibile da mostrare.', 'Não há ofertas disponíveis para mostrar.', 'Нет доступных предложений для показа.', 'No hay ofertas disponibles para mostrar.', 'Gösterilecek mevcut teklif yok.'),
(1705, 'delete_offer', '', 'Delete Offer', 'حذف العرض', 'Aanbieding verwijderen', 'Supprimer loffre', 'Angebot löschen', 'Elimina offerta', 'Excluir oferta', 'Удалить предложение', 'Eliminar oferta', 'Teklifi Sil'),
(1706, 'confirm_delete_offer', '', 'Are you sure that you want to delete this offer?', 'هل أنت متأكد أنك تريد حذف هذا العرض؟', 'Weet u zeker dat u deze aanbieding wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer cette offre?', 'Sind Sie sicher, dass Sie dieses Angebot löschen möchten?', 'Sei sicuro di voler eliminare questa offerta?', 'Tem certeza de que deseja excluir esta oferta?', 'Вы уверены, что хотите удалить это предложение?', '¿Estás seguro de que deseas eliminar esta oferta?', 'Bu teklifi silmek istediğinizden emin misiniz?'),
(1707, 'edit_offer', '', 'Edit Offer', 'تعديل العرض', 'Aanbieding bewerken', 'Modifier loffre', 'Angebot bearbeiten', 'Modifica offerta', 'Editar oferta', 'Изменить предложение', 'Editar oferta', 'Teklifi Düzenle'),
(1708, 'offer_successfully_edited', '', 'Offer successfully updated.', 'تم تحديث العرض بنجاح.', 'Aanbieding succesvol bijgewerkt.', 'Offre mise à jour avec succès.', 'Angebot erfolgreich aktualisiert.', 'Offerta aggiornata con successo.', 'Oferta atualizada com sucesso.', 'Предложение успешно обновлено.', 'Oferta actualizada con éxito.', 'Teklif başarıyla güncellendi.'),
(1709, 'nearby_shops', '', 'Nearby Shops', 'المتاجر القريبة', 'Nabijgelegen winkels', 'Commerces à proximité', 'In der Nähe Geschäfte', 'Negozi nelle vicinanze', 'Lojas próximas', 'Магазины поблизости', 'Tiendas cercanas', 'Yakındaki Mağazalar'),
(1710, 'shops_found', '', 'Shops found', 'وجدت المتاجر', 'Winkels gevonden', 'Magasins trouvés', 'Geschäfte gefunden', 'Negozi trovati', 'Lojas encontradas', 'Магазины найдены', 'Tiendas encontradas', 'Bulunan dükkanlar'),
(1711, 'no_shops_found', '', 'No shops found', 'لم يتم العثور على متاجر', 'Geen winkels gevonden', 'Aucun magasin trouvé', 'Keine Geschäfte gefunden', 'Nessun negozio trovato', 'Nenhuma loja encontrada', 'Магазины не найдены', 'No se encontraron tiendas.', 'Dükkan bulunamadı'),
(1712, 'nearby_business', '', 'Nearby Business', 'الأعمال القريبة', 'Nabijgelegen bedrijf', 'Entreprise à proximité', 'In der Nähe Geschäft', 'Attività nelle vicinanze', 'Negócios nas proximidades', 'Бизнес поблизости', 'Negocios cercanos', 'Yakındaki İşletmeler'),
(1713, 'business_found', '', 'Business found', 'تم العثور على الأعمال', 'Bedrijf gevonden', 'Entreprise trouvée', 'Geschäft gefunden', 'Attività trovate', 'Negócio encontrado', 'Бизнес найден', 'Negocio encontrado', 'İşletme bulundu'),
(1714, 'no_business_found', '', 'No business found', 'لم يتم العثور على عمل', 'Geen bedrijf gevonden', 'Aucune entreprise trouvée', 'Kein Geschäft gefunden', 'Nessuna attività trovata', 'Nenhuma empresa encontrada', 'Бизнес не найден', 'No se ha encontrado ningún negocio.', 'İşletme bulunamadı'),
(1715, 'login_attempts', '', 'Too many login attempts please try again later', 'الكثير من محاولات تسجيل الدخول يرجى المحاولة مرة أخرى في وقت لاحق', 'Te veel inlogpogingen, probeer het later opnieuw', 'Trop de tentatives de connexion, veuillez réessayer plus tard', 'Zu viele Anmeldeversuche versuchen Sie es später erneut', 'Troppi tentativi di accesso, riprovare più tardi', 'Muitas tentativas de login, tente novamente mais tarde', 'Слишком много попыток входа, попробуйте позже', 'Demasiados intentos de inicio de sesión, intente nuevamente más tarde', 'Çok fazla giriş denemesi lütfen daha sonra tekrar deneyin'),
(1716, 'complexity_requirements', '', 'The password supplied does not meet the minimum complexity requirements', 'لا تفي كلمة المرور المقدمة بالحد الأدنى من متطلبات التعقيد', 'Het opgegeven wachtwoord voldoet niet aan de minimale complexiteitsvereisten', 'Le mot de passe fourni ne répond pas aux exigences minimales de complexité', 'Das angegebene Passwort entspricht nicht den Mindestanforderungen an die Komplexität', 'La password fornita non soddisfa i requisiti minimi di complessità', 'A senha fornecida não atende aos requisitos mínimos de complexidade', 'Предоставленный пароль не соответствует требованиям минимальной сложности', 'La contraseña suministrada no cumple los requisitos mínimos de complejidad.', 'Verilen parola minimum karmaşıklık gereksinimlerini karşılamıyor'),
(1717, 'least_characters', '', 'Must be at least 6 characters long.', 'يجب ألا يقل طول الأحرف عن 6 أحرف.', 'Moet minimaal 6 tekens lang zijn.', 'Doit contenir au moins 6 caractères.', 'Muss mindestens 6 Zeichen lang sein.', 'Deve contenere almeno 6 caratteri.', 'Deve ter pelo menos 6 caracteres.', 'Должно быть длиной не менее 6 символов.', 'Debe tener al menos 6 caracteres de longitud.', 'En az 6 karakter uzunluğunda olmalı.'),
(1718, 'contain_lowercase', '', 'Must contain a lowercase letter.', 'يجب أن يحتوي على حرف صغير.', 'Moet een kleine letter bevatten.', 'Doit contenir une lettre minuscule.', 'Muss einen Kleinbuchstaben enthalten.', 'Deve contenere una lettera minuscola.', 'Deve conter uma letra minúscula.', 'Должен содержать строчную букву.', 'Debe contener una letra minúscula.', 'Küçük harf içermelidir.'),
(1719, 'contain_uppercase', '', 'Must contain an uppercase letter.', 'يجب أن يحتوي على حرف كبير.', 'Moet een hoofdletter bevatten.', 'Doit contenir une lettre majuscule.', 'Muss einen Großbuchstaben enthalten.', 'Deve contenere una lettera maiuscola.', 'Deve conter uma letra maiúscula.', 'Должен содержать заглавную букву.', 'Debe contener una letra mayúscula.', 'Bir büyük harf içermeli.'),
(1720, 'number_special', '', 'Must contain a number or special character.', 'يجب أن يحتوي على رقم أو حرف خاص.', 'Moet een cijfer of een speciaal teken bevatten.', 'Doit contenir un chiffre ou un caractère spécial.', 'Muss eine Zahl oder ein Sonderzeichen enthalten.', 'Deve contenere un numero o un carattere speciale.', 'Deve conter um número ou caractere especial.', 'Должен содержать номер или специальный символ.', 'Debe contener un número o carácter especial.', 'Bir sayı veya özel karakter içermelidir.'),
(1721, 'users_can_post', '', 'Users can post on my page', 'يمكن للمستخدمين النشر على صفحتي', 'Gebruikers kunnen op mijn pagina posten', 'Les utilisateurs peuvent poster sur ma page', 'Benutzer können auf meiner Seite posten', 'Gli utenti possono pubblicare sulla mia pagina', 'Os usuários podem postar na minha página', 'Пользователи могут публиковать на моей странице', 'Los usuarios pueden publicar en mi página', 'Kullanıcılar sayfama mesaj gönderebilir'),
(1722, 'privileges', '', 'Privileges', 'امتيازات', 'Voorrechten', 'Privilèges', 'Privilegien', 'privilegi', 'Privilégios', 'привилегии', 'Privilegios', 'Ayrıcalıklar'),
(1723, 'access_to_general_settings', '', 'Access to general settings', 'الوصول إلى الإعدادات العامة', 'Toegang tot algemene instellingen', 'Accès aux paramètres généraux', 'Zugriff auf allgemeine Einstellungen', 'Accesso alle impostazioni generali', 'Acesso a configurações gerais', 'Доступ к общим настройкам', 'Acceso a configuraciones generales', 'Genel ayarlara erişim'),
(1724, 'access_to_info_settings', '', 'Access to page information settings', 'الوصول إلى إعدادات معلومات الصفحة', 'Toegang tot instellingen voor pagina-informatie', 'Accès aux paramètres des informations de la page', 'Zugriff auf Einstellungen für Seiteninformationen', 'Accesso alle impostazioni delle informazioni sulla pagina', 'Acesso às configurações de informações da página', 'Доступ к настройкам информации о странице', 'Acceso a la configuración de información de la página', 'Sayfa bilgisi ayarlarına erişim'),
(1725, 'access_to_social_settings', '', 'Access to social links settings', 'الوصول إلى إعدادات الروابط الاجتماعية', 'Toegang tot instellingen voor sociale links', 'Accès aux paramètres des liens sociaux', 'Zugriff auf Einstellungen für soziale Links', 'Accesso alle impostazioni dei social network', 'Acesso às configurações de links sociais', 'Доступ к настройкам социальных ссылок', 'Acceso a la configuración de enlaces sociales', 'Sosyal bağlantılar ayarlarına erişim'),
(1726, 'access_to_avatar_settings', '', 'Access to avatar &amp; cover settings', 'الوصول إلى الصورة الرمزية', 'Toegang tot avatar', 'Accès à lavatar', 'Zugang zum Avatar', 'Access to avatar', 'Acesso ao avatar', 'Доступ к аватару', 'Acceso al avatar', 'Avatara erişim'),
(1727, 'access_to_design_settings', '', 'Access to design settings', 'الوصول إلى إعدادات التصميم', 'Toegang tot ontwerpinstellingen', 'Accès aux paramètres de conception', 'Zugriff auf Designeinstellungen', 'Accesso alle impostazioni di progettazione', 'Acesso às configurações de design', 'Доступ к настройкам дизайна', 'Acceso a configuraciones de diseño', 'Tasarım ayarlarına erişim'),
(1728, 'access_to_admins_settings', '', 'Access to admins settings', 'الوصول إلى إعدادات المسؤولين', 'Toegang tot beheerdersinstellingen', 'Accès aux paramètres des administrateurs', 'Zugriff auf Administratoreinstellungen', 'Accesso alle impostazioni degli amministratori', 'Acesso às configurações de administrador', 'Доступ к настройкам админов', 'Acceso a la configuración de administradores', 'Yönetici ayarlarına erişim'),
(1729, 'access_to_analytics_settings', '', 'Access to analytics settings', 'الوصول إلى إعدادات التحليلات', 'Toegang tot analyse-instellingen', 'Accès aux paramètres danalyse', 'Zugriff auf Analyseeinstellungen', 'Accesso alle impostazioni di analisi', 'Acesso às configurações de análise', 'Доступ к настройкам аналитики', 'Acceso a la configuración de análisis', 'Analiz ayarlarına erişim'),
(1730, 'access_to_delete_page_settings', '', 'Access to delete page settings', 'الوصول لحذف إعدادات الصفحة', 'Toegang om pagina-instellingen te verwijderen', 'Accès pour supprimer les paramètres de page', 'Zugriff zum Löschen von Seiteneinstellungen', 'Accesso per eliminare le impostazioni della pagina', 'Acesso para excluir configurações da página', 'Доступ к удалению настроек страницы', 'Acceso para eliminar la configuración de la página', 'Sayfa ayarlarını silme erişimi'),
(1731, 'access_to_privacy_settings', '', 'Access to privacy settings', 'الوصول إلى إعدادات الخصوصية', 'Toegang tot privacy-instellingen', 'Accès aux paramètres de confidentialité', 'Zugriff auf Datenschutzeinstellungen', 'Accesso alle impostazioni sulla privacy', 'Acesso a configurações de privacidade', 'Доступ к настройкам конфиденциальности', 'Acceso a la configuración de privacidad', 'Gizlilik ayarlarına erişim'),
(1732, 'access_to_members_settings', '', 'Access to members settings', 'الوصول إلى إعدادات الأعضاء', 'Toegang tot ledeninstellingen', 'Accès aux paramètres des membres', 'Zugriff auf Mitgliedereinstellungen', 'Accesso alle impostazioni dei membri', 'Acesso às configurações de membros', 'Доступ к настройкам участников', 'Acceso a la configuración de miembros', 'Üye ayarlarına erişim'),
(1733, 'access_to_delete_group_settings', '', 'Access to delete group settings', 'الوصول إلى حذف إعدادات المجموعة', 'Toegang om groepsinstellingen te verwijderen', 'Accès pour supprimer les paramètres du groupe', 'Zugriff zum Löschen von Gruppeneinstellungen', 'Accesso per eliminare le impostazioni del gruppo', 'Acesso para excluir configurações de grupo', 'Доступ к удалению настроек группы', 'Acceso para eliminar la configuración del grupo', 'Grup ayarlarını silme erişimi'),
(1734, 'invitation_links', '', 'Invitation Links', 'روابط الدعوة', 'Invitation Links', 'Invitation Links', 'Invitation Links', 'Link allinvito', 'Links para convites', 'Пригласительные ссылки', 'Enlaces de invitación', 'Davetiye Bağlantıları'),
(1735, 'available_links', '', 'Available Links', 'الروابط المتاحة', 'Beschikbare links', 'Liens disponibles', 'Verfügbare Links', 'Link disponibili', 'Links Disponíveis', 'Доступные ссылки', 'Enlaces Disponibles', 'Kullanılabilir Bağlantılar'),
(1736, 'generated_links', '', 'Generated Links', 'الروابط المولدة', 'Gegenereerde links', 'Liens générés', 'Generierte Links', 'Link generati', 'Links gerados', 'Сгенерированные ссылки', 'Enlaces generados', 'Oluşturulan Bağlantılar'),
(1737, 'used_links', '', 'Used Links', 'روابط مستعملة', 'Gebruikte links', 'Liens utilisés', 'Verwendete Links', 'Link usati', 'Links Usados', 'Использованные ссылки', 'Enlaces Usados', 'Kullanılan Bağlantılar'),
(1738, 'generate_link', '', 'Generate links', 'إنشاء روابط', 'Generate links', 'Générer des liens', 'Links generieren', 'Genera collegamenti', 'Gere links', 'Генерировать ссылки', 'Generar enlaces', 'Bağlantı oluştur'),
(1739, 'code_successfully', '', 'Code successfully generated', 'تم إنشاء الرمز بنجاح', 'Code succesvol gegenereerd', 'Code généré avec succès', 'Code erfolgreich generiert', 'Codice generato correttamente', 'Código gerado com sucesso', 'Код успешно сгенерирован', 'Código generado con éxito', 'Kod başarıyla oluşturuldu'),
(1740, 'copied', '', 'Copied', 'نسخ', 'Gekopieerd', 'Copié', 'Kopiert', 'Copiato', 'Copiado', 'скопированный', 'Copiado', 'Kopyalanan'),
(1741, 'copy', '', 'Copy', 'نسخ', 'Kopiëren', 'Copie', 'Kopieren', 'copia', 'cópia de', 'копия', 'Copiar', 'kopya'),
(1742, 'invited_user', '', 'Invited User', 'المستخدم المدعو', 'Uitgenodigde gebruiker', 'Utilisateur invité', 'Eingeladener Benutzer', 'Utente invitato', 'Usuário Convidado', 'Приглашенный пользователь', 'Usuario invitado', 'Davet Edilen Kullanıcı'),
(1743, 'unlimited', '', 'Unlimited', 'غير محدود', 'Onbeperkt', 'Illimité', 'Unbegrenzt', 'Illimitato', 'Ilimitado', 'неограниченный', 'Ilimitado', 'Sınırsız'),
(1744, 'anonymous', '', 'Anonymous', 'مجهول', 'Anoniem', 'Anonyme', 'Anonym', 'Anonimo', 'Anônimo', 'анонимное', 'Anónimo', 'Anonim'),
(1745, 'iban', '', 'IBAN', 'رقم الحساب بصيغة IBAN', 'IBAN', 'IBAN', 'IBAN', 'IBAN', 'IBAN', 'IBAN', 'IBAN', 'IBAN'),
(1746, 'full_name', '', 'Full name', 'الاسم الكامل', 'Voor-en achternaam', 'Nom complet', 'Vollständiger Name', 'Nome e cognome', 'Nome completo', 'ФИО', 'Nombre completo', 'Ad Soyad'),
(1747, 'swift_code', '', 'Swift code', 'رمز السرعة', 'Swift code', 'Code rapide', 'SWIFT-Code', 'Codice SWIFT', 'Código Swift', 'Свифт код', 'Código SWIFT', 'Swift kodu'),
(1748, 'withdraw_approve', '', 'Your withdraw request has been approved!', 'تمت الموافقة على طلب السحب الخاص بك!', 'Uw intrekkingsverzoek is goedgekeurd!', 'Votre demande de retrait a été approuvée!', 'Ihre Rücktrittsanfrage wurde genehmigt!', 'La tua richiesta di prelievo è stata approvata!', 'Sua solicitação de retirada foi aprovada!', 'Ваш запрос на вывод средств был одобрен!', '¡Su solicitud de retiro ha sido aprobada!', 'Para çekme talebiniz onaylandı!'),
(1749, 'withdraw_declined', '', 'Your withdraw request has been declined!', 'تم رفض طلب السحب الخاص بك!', 'Uw verzoek tot intrekking is afgewezen!', 'Votre demande de retrait a été refusée!', 'Ihre Auszahlungsanfrage wurde abgelehnt!', 'La tua richiesta di prelievo è stata rifiutata!', 'Sua solicitação de retirada foi recusada!', 'Ваш запрос на снятие был отклонен!', '¡Su solicitud de retiro ha sido rechazada!', 'Para çekme talebiniz reddedildi!'),
(1750, 'register_and_pay', '', 'Register and pay using', 'سجل وادفع باستخدام', 'Registreer en betaal met', 'Inscrivez-vous et payez en utilisant', 'Registrieren und bezahlen mit', 'Registrati e paga usando', 'Registre-se e pague usando', 'Зарегистрируйтесь и оплатите, используя', 'Regístrese y pague usando', 'Kayıt ve kullanarak ödeme'),
(1751, 'live', '', 'Live', 'حي', 'Leven', 'Vivre', 'Wohnen', 'Vivere', 'Viver', 'Прямой эфир', 'En Vivo', 'Canlı'),
(1752, 'go_live', '', 'Go Live', 'انطلق', 'Ga leven', 'Go Live', 'Geh Leben', 'Andare in diretta', 'Go Live', 'Go Live', 'Ir a vivir', 'Canlı Yayına Başla'),
(1753, 'started_live_video', '', 'started a live video.', 'بدأ فيديو مباشر.', 'begon een live video.', 'a commencé une vidéo en direct.', 'startete ein Live-Video.', 'ha iniziato un video dal vivo.', 'iniciou um vídeo ao vivo.', 'начал живое видео.', 'comenzó un video en vivo.', 'canlı bir video başlattı.'),
(1754, 'razorpay', '', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay', 'Razorpay'),
(1755, 'paysera', '', 'Paysera', 'مسح', 'Scannen', 'Numériser', 'Scannen', 'Paysera', 'Digitalizar', 'Paysera', 'Escanear', 'Paysera'),
(1756, 'unfollow', '', 'unfollow', 'غير متابع', 'ontvolgen', 'ne pas suivre', 'nicht mehr folgen', 'Smetti', 'deixar de seguir', 'Отсоединиться', 'dejar de seguir', 'vazgeçebilirim'),
(1757, 'withdraw_method', '', 'Withdraw Method', 'طريقة السحب', 'Intrekkingsmethode', 'Méthode de retrait', 'Methode zurückziehen', 'Metodo di prelievo', 'Retirar Método', 'Метод вывода', 'Método de retirada', 'Para Çekme Yöntemi'),
(1758, 'bank', '', 'Bank', 'بنك', 'Bank', 'Banque', 'Bank', 'Banca', 'Banco', 'Банка', 'Banco', 'Banka'),
(1759, 'end_live', '', 'End live', 'نهاية العيش', 'Live beëindigen', 'Fin en direct', 'Live beenden', 'Termina dal vivo', 'Terminar ao vivo', 'Конец жить', 'Fin en vivo', 'Canlı sona erdir'),
(1760, 'get_notification_posts', '', 'Get a notification when {USER} create a new post.', 'احصل على إشعار عندما ينشئ {USER} مشاركة جديدة.', 'Ontvang een melding wanneer {USER} een nieuw bericht maakt.', 'Recevez une notification lorsque {USER} crée un nouveau message.', 'Erhalten Sie eine Benachrichtigung, wenn {USER} einen neuen Beitrag erstellt.', 'Ricevi una notifica quando {USER} crea un nuovo post.', 'Receba uma notificação quando {USER} criar uma nova postagem.', 'Получите уведомление, когда {USER} создаст новое сообщение.', 'Reciba una notificación cuando {USUARIO} cree una nueva publicación.', '{USER} yeni bir yayın oluştururken bildirim alın.'),
(1761, 'stop_notification_posts', '', 'Stop getting a notifications from {USER}', 'التوقف عن تلقي إشعارات من {USER}', 'Geen meldingen meer ontvangen van {USER}', 'Ne plus recevoir de notifications de {USER}', 'Keine Benachrichtigungen mehr von {USER} erhalten', 'Non ricevere più notifiche da {USER}', 'Pare de receber notificações de {USER}', 'Прекратить получать уведомления от {USER}', 'Dejar de recibir notificaciones de {USER}', '{USER} adlı kullanıcıdan bildirim almayı durdur'),
(1762, 'created_new_post', '', 'created a new post.', 'أنشأ مشاركة جديدة.', 'heeft een nieuw bericht gemaakt.', 'a créé une nouvelle publication.', 'hat einen neuen Beitrag erstellt.', 'creato un nuovo post.', 'criou uma nova postagem.', 'создал новый пост.', 'creó una nueva publicación.', 'yeni bir yayın oluşturdu.'),
(1763, 'time_friends', '', 'It&#039;s been {TIME} since you both are friends! Send them a message to celebrate.', 'لقد مر {TIME} لأنكما صديقان! أرسل لهم رسالة للاحتفال.', 'Het is {TIME} sinds jullie allebei vrienden zijn! Stuur ze een bericht om het te vieren.', 'Ça fait {TIME} puisque vous êtes tous les deux amis! Envoyez-leur un message pour célébrer.', 'Es ist {ZEIT} her, seit ihr beide Freunde seid! Senden Sie ihnen eine Nachricht zum Feiern.', 'È stato {TIME} da quando entrambi siete amici! Invia loro un messaggio per festeggiare.', 'Faz {TIME} desde que vocês dois são amigos! Envie uma mensagem para comemorar.', 'Это было {ВРЕМЯ}, так как вы оба друзья! Отправьте им сообщение, чтобы отпраздновать.', '¡Ha pasado {TIME} desde que ambos son amigos! Envíales un mensaje para celebrar.', 'İkiniz de arkadaş olduğunuz için {TIME} oldu! Kutlamak için onlara bir mesaj gönderin.'),
(1764, 'request_refund', '', 'Request a Refund', 'طلب استرداد', 'Vraag een terugbetaling', 'Demande à être remboursé', 'Eine Rückerstattung anfordern', 'Richiedere un rimborso', 'Peça um reembolso', 'Запросить возврат', 'Solicitar un reembolso', 'Geri ödeme istemek'),
(1765, 'is_live', '', 'is live now.', 'يعيش الآن.', 'is nu live.', 'est en direct maintenant.', 'ist jetzt live.', 'è in diretta ora.', 'está ao vivo agora.', 'сейчас жив.', 'es en vivo ahora.', 'şimdi canlı.'),
(1766, 'was_live', '', 'was live.', 'كان يعيش.', 'was live.', 'était en direct.', 'war live.', 'era vivo.', 'estava vivo.', 'был живой.', 'Fue en vivo.', 'canlıydı.'),
(1767, 'january', '', 'January', 'كانون الثاني', 'januari', 'janvier', 'Januar', 'gennaio', 'janeiro', 'январь', 'enero', 'Ocak'),
(1768, 'february', '', 'February', 'شهر فبراير', 'februari', 'février', 'Februar', 'febbraio', 'fevereiro', 'февраль', 'febrero', 'Şubat'),
(1769, 'march', '', 'March', 'مارس', 'maart', 'Mars', 'März', 'marzo', 'marcha', 'марш', 'marzo', 'Mart'),
(1770, 'april', '', 'April', 'أبريل', 'april', 'avril', 'April', 'aprile', 'abril', 'апреля', 'abril', 'Nisan'),
(1771, 'may', '', 'May', 'مايو', 'mei', 'Mai', 'Kann', 'Maggio', 'Maio', 'май', 'Mayo', 'Mayıs'),
(1772, 'june', '', 'June', 'يونيو', 'juni', 'juin', 'Juni', 'giugno', 'Junho', 'июнь', 'junio', 'Haziran'),
(1773, 'july', '', 'July', 'يوليو', 'juli', 'juillet', 'Juli', 'luglio', 'Julho', 'июль', 'julio', 'Temmuz'),
(1774, 'august', '', 'August', 'أغسطس', 'augustus', 'août', 'August', 'agosto', 'agosto', 'августейший', 'agosto', 'Ağustos'),
(1775, 'september', '', 'September', 'سبتمبر', 'september', 'septembre', 'September', 'settembre', 'setembro', 'сентябрь', 'septiembre', 'Eylül'),
(1776, 'october', '', 'October', 'اكتوبر', 'oktober', 'octobre', 'Oktober', 'ottobre', 'Outubro', 'октября', 'octubre', 'Ekim'),
(1777, 'november', '', 'November', 'شهر نوفمبر', 'november', 'novembre', 'November', 'novembre', 'novembro', 'ноябрь', 'noviembre', 'Kasım'),
(1778, 'december', '', 'December', 'ديسمبر', 'december', 'décembre', 'Dezember', 'dicembre', 'dezembro', 'Декабрь', 'diciembre', 'Aralık'),
(1779, 'notifications_single', '', 'Notifications', 'إشعارات', 'meldingen', 'notifications', 'Benachrichtigungen', 'notifiche', 'notificações', 'Уведомления', 'Notificaciones', 'Bildirimler'),
(1780, 'get_started', '', 'Get Started', 'البدء', 'Begin', 'Commencer', 'Loslegen', 'Iniziare', 'Iniciar', 'Начать', 'Empezar', 'Başlamak'),
(1781, 'enable_weather_loc', '', 'Please enable location on your browser to view current weather.', 'يرجى تمكين الموقع في المتصفح لعرض الطقس الحالي.', 'Activeer locatie op uw browser om de actuele weergegevens te bekijken.', 'S&#039;il vous plaît activer adresse de votre navigateur pour afficher la météo actuelle.', 'Bitte aktivieren Sie diese Position auf Ihrem Browser aktuelles Wetter anzuzeigen.', 'Si prega di abilitare posizione sul tuo browser per visualizzare meteo.', 'Ative o local em seu navegador para ver o tempo atual.', 'Пожалуйста, включите местоположение в вашем браузере для просмотра текущей погоды.', 'Por favor, activa ubicación en su navegador para ver tiempo actual.', 'Şu anki hava durumunu görüntülemek için tarayıcınızda konum özelliğini etkinleştirmek edin.'),
(1782, 'enable_friend_loc', '', 'Access to your location is Disabled. Enable it on your browser if you want to see people around you.', 'الوصول إلى الموقع الخاص بك هو معطل. تمكينه على المتصفح الخاص بك إذا كنت تريد أن ترى الناس من حولك.', 'De toegang tot uw locatie is uitgeschakeld. Schakel het op uw browser als u wilt mensen om je heen te zien.', 'L&#039;accès à votre emplacement est désactivé. Activez-le sur votre navigateur si vous voulez voir les gens autour de vous.', 'Zugriff auf Ihren Standort ist deaktiviert. Aktivieren Sie es auf Ihrem Browser, wenn du um dich herum zu sehen, die Leute wollen.', 'L&#039;accesso alla tua posizione è Disabilitato. Attiva sul vostro browser, se volete vedere persone intorno a voi.', 'Acesso à sua localização está desativada. Ativá-lo no seu navegador se você quiser ver as pessoas ao seu redor.', 'Доступ к вашему местоположению отключен. Включите его в вашем браузере, если вы хотите, чтобы видеть, что люди вокруг вас.', 'El acceso a su ubicación es Desactivado. Activarlo en su navegador si desea ver a las personas que le rodean.', 'Bulunduğunuz yere erişim Devre Dışı. çevrenizdeki insanları görmek istiyorsanız tarayıcınızda etkinleştirin.'),
(1783, 'sunday', '', 'Sunday', 'الأحد', 'zondag', 'dimanche', 'Sonntag', 'Domenica', 'domingo', 'Воскресенье', 'domingo', 'Pazar'),
(1784, 'monday', '', 'Monday', 'الإثنين', 'maandag', 'Lundi', 'Montag', 'Lunedi', 'Segunda-feira', 'понедельник', 'lunes', 'Pazartesi'),
(1785, 'tuesday', '', 'Tuesday', 'الثلاثاء', 'dinsdag', 'Mardi', 'Dienstag', 'martedì', 'terça', 'вторник', 'martes', 'Salı'),
(1786, 'wednesday', '', 'Wednesday', 'الأربعاء', 'woensdag', 'Mercredi', 'Mittwoch', 'mercoledì', 'quarta-feira', 'среда', 'miércoles', 'Çarşamba'),
(1787, 'thursday', '', 'Thursday', 'الخميس', 'donderdag', 'Jeudi', 'Donnerstag', 'giovedi', 'quinta-feira', 'Четверг', 'jueves', 'Perşembe'),
(1788, 'friday', '', 'Friday', 'يوم الجمعة', 'vrijdag', 'Vendredi', 'Freitag', 'Venerdì', 'Sexta-feira', 'пятница', 'viernes', 'Cuma'),
(1789, 'saturday', '', 'Saturday', 'يوم السبت', 'zaterdag', 'samedi', 'Samstag', 'Sabato', 'sábado', 'суббота', 'sábado', 'Cumartesi'),
(1790, 'stream_has_ended', '', '{{user}} stream has ended.', 'انتهى دفق {{user}}.', '{{user}} stream is beëindigd.', 'Le flux {{user}} est terminé.', 'Der {{user}} Stream wurde beendet.', 'Lo stream {{user}} è terminato.', 'O fluxo do {{user}} foi encerrado.', 'Поток {{user}} завершен.', 'La transmisión de {{usuario}} ha finalizado.', '{{user}} akışı sona erdi.'),
(1791, 'mic_source', '', 'Change Mic Source', 'تغيير مصدر الميكروفون', 'Wijzig microfoonbron', 'Changer la source du micro', 'Mikrofonquelle wechseln', 'Cambia sorgente microfono', 'Alterar fonte do microfone', 'Изменить источник микрофона', 'Cambiar fuente de micrófono', 'Mikrofon Kaynağını Değiştir'),
(1792, 'cam_source', '', 'Change Video Source', 'تغيير مصدر الفيديو', 'Wijzig videobron', 'Changer la source vidéo', 'Videoquelle ändern', 'Cambia sorgente video', 'Alterar fonte de vídeo', 'Изменить источник видео', 'Cambiar fuente de video', 'Video Kaynağını Değiştir'),
(1793, 'event_remaining', '', 'remaining', 'المتبقي', 'resterend', 'restant', 'verbleibend', 'residuo', 'remanescente', 'осталось', 'restante', 'kalan'),
(1794, 'home_weather', '', 'Weather', 'طقس', 'Weer', 'Temps', 'Wetter', 'Tempo metereologico', 'Clima', 'Погода', 'Clima', 'Hava'),
(1795, 'weather_wind', '', 'Wind', 'ريح', 'Wind', 'Vent', 'Wind', 'Vento', 'Vento', 'ветер', 'Viento', 'rüzgar'),
(1796, 'weather_humidity', '', 'Humidity', 'رطوبة', 'Vochtigheid', 'Humidité', 'Feuchtigkeit', 'Umidità', 'Umidade', 'влажность', 'Humedad', 'Nem'),
(1797, 'weather_visibility', '', 'Visibility', 'الرؤية', 'Zichtbaarheid', 'Visibilité', 'Sichtweite', 'Visibilità', 'Visibilidade', 'видимость', 'Visibilidad', 'görünürlük'),
(1798, 'weather_sunrise', '', 'Sunrise', 'شروق الشمس', 'zonsopkomst', 'lever du soleil', 'Sonnenaufgang', 'Alba', 'Nascer do sol', 'Восход', 'amanecer', 'gündoğumu'),
(1799, 'weather_sunset', '', 'Sunset', 'غروب الشمس', 'Zonsondergang', 'Le coucher du soleil', 'Sonnenuntergang', 'Tramonto', 'Pôr do sol', 'Заход солнца', 'Puesta de sol', 'Gün batımı'),
(1800, 'find_nearby_business', '', 'Find businesses near to you based on your location and connect with them directly.', 'ابحث عن الشركات القريبة منك بناءً على موقعك وتواصل معها مباشرة.', 'Vind bedrijven bij u in de buurt op basis van uw locatie en maak direct contact met hen.', 'Trouvez des entreprises près de chez vous en fonction de votre emplacement et connectez-vous directement avec elles.', 'Finden Sie Unternehmen in Ihrer Nähe basierend auf Ihrem Standort und verbinden Sie sich direkt mit ihnen.', 'Trova le attività vicino a te in base alla tua posizione e connettiti direttamente con loro.', 'Encontre empresas próximas a você com base em sua localização e conecte-se diretamente a elas.', 'Найти предприятия рядом с вами на основе вашего местоположения и связаться с ними напрямую.', 'Encuentre negocios cerca de usted según su ubicación y conéctese con ellos directamente.', 'Bulunduğunuz yere göre yakınınızdaki işletmeleri bulun ve onlarla doğrudan bağlantı kurun.'),
(1801, 'export', '', 'Export', 'تصدير', 'Exporteren', 'Exportation', 'Export', 'Esportare', 'Exportar', 'экспорт', 'Exportar', 'İhracat'),
(1802, 'add_google_calendar', '', 'Add to Google Calendar', 'أضف إلى تقويم Google', 'Toevoegen aan Google Agenda', 'Ajouter à Google Agenda', 'Zum Google Kalender hinzufügen', 'Aggiungi a Google Calendar', 'Adicionar ao Google Agenda', 'Добавить в Календарь Google', 'Agregar a Google Calendar', 'Google Takvim’e ekle'),
(1803, 'home_refresh', '', 'Refresh', 'ينعش', 'Vernieuwen', 'Rafraîchir', 'Aktualisierung', 'ricaricare', 'Atualizar', 'Обновить', 'Actualizar', 'Yenile'),
(1804, 'chat_emoji', '', 'Emoji', 'تعبيري', 'Emoji', 'Emoji', 'Emoji', 'Emoji', 'Emoji', 'Эмодзи', 'Emoji', 'Emoji'),
(1805, 'find_nearby_shops', '', 'Find shops near to you based on your location and connect with them directly.', 'ابحث عن المتاجر القريبة منك بناءً على موقعك وتواصل معها مباشرةً.', 'Vind winkels bij u in de buurt op basis van uw locatie en maak rechtstreeks contact met hen.', 'Trouvez des magasins près de chez vous en fonction de votre emplacement et connectez-vous directement avec eux.', 'Finden Sie anhand Ihres Standorts Geschäfte in Ihrer Nähe und verbinden Sie sich direkt mit ihnen.', 'Trova negozi vicino a te in base alla tua posizione e connettiti direttamente con loro.', 'Encontre lojas perto de você com base em sua localização e conecte-se com elas diretamente.', 'Находите магазины рядом с вами в зависимости от вашего местоположения и связывайтесь с ними напрямую.', 'Encuentre tiendas cercanas a usted según su ubicación y conéctese con ellas directamente.', 'Bulunduğunuz yere göre yakınınızdaki mağazaları bulun ve onlarla doğrudan bağlantı kurun.'),
(1806, 'main_products', '', 'Products', 'منتجات', 'Producten', 'Des produits', 'Produkte', 'Prodotti', 'Produtos', 'Товары', 'Productos', 'Ürün:% s'),
(1807, 'get_credits', '', 'Get Credits.', 'احصل على قروض.', 'Krijg credits.', 'Obtenez des crédits.', 'Holen Sie sich Credits.', 'Ottieni crediti.', 'Obtenha créditos.', 'Получите кредиты.', 'Obtener créditos.', 'Kredi Alın.'),
(1808, 'no_recent_donation', '', 'No recent donations found', 'لم يتم العثور على تبرعات حديثة', 'Geen recente donaties gevonden', 'Aucun don récent trouvé', 'Keine aktuellen Spenden gefunden', 'Nessuna donazione recente trovata', 'Nenhuma doação recente encontrada', 'Недавних пожертвований не найдено', 'No se encontraron donaciones recientes', 'Yakın zamanda bağış bulunamadı'),
(1809, 'welcome_privacy_text', '', 'You have full control over your personal information that you share.', 'لديك سيطرة كاملة على معلوماتك الشخصية التي تشاركها.', 'U heeft volledige controle over uw persoonlijke informatie die u deelt.', 'Vous avez un contrôle total sur vos informations personnelles que vous partagez.', 'Sie haben die volle Kontrolle über Ihre persönlichen Daten, die Sie teilen.', 'Hai il pieno controllo sulle tue informazioni personali che condividi.', 'Você tem controle total sobre as informações pessoais que compartilha.', 'Вы полностью контролируете свою личную информацию, которой вы делитесь.', 'Tienes control total sobre la información personal que compartes.', 'Paylaştığınız kişisel bilgileriniz üzerinde tam kontrole sahipsiniz.'),
(1810, 'welcome_security_text', '', 'Your account is fully secure. We never share your data with third party.', 'حسابك آمن تمامًا.', 'Uw account is volledig beveiligd.', 'Votre compte est entièrement sécurisé.', 'Ihr Konto ist vollständig sicher.', 'Il tuo account è completamente sicuro.', 'Sua conta está totalmente segura.', 'Ваша учетная запись полностью защищена.', 'Tu cuenta está completamente segura.', 'Hesabınız tamamen güvende.'),
(1811, '_time_m', '', 'm', 'م', 'm', 'm', 'm', 'm', 'm', 'м', 'metro', 'm'),
(1812, '_time_h', '', 'h', 'ح', 'h', 'h', 'h', 'h', 'h', 'час', 'h', 'h'),
(1813, 'now', '', 'now', 'حاليا', 'nu', 'à présent', 'jetzt', 'adesso', 'agora', 'сейчас же', 'ahora', 'şimdi'),
(1814, '_time_hrs', '', 'hrs', 'ساعة', 'uur', 'heures', 'Std', 'ore', 'horas', 'часы', 'horas', 'saat'),
(1815, '_time_d', '', 'd', 'د', 'd', 'ré', 'd', 'd', 'd', 'd', 'D', 'd'),
(1816, '_time_w', '', 'w', 'ث', 'w', 'w', 'w', 'w', 'C', 'ш', 'w', 'w'),
(1817, '_time_y', '', 'y', 'ذ', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y'),
(1818, '_time_yrs', '', 'yrs', 'سنوات', 'jr', 'ans', 'Jahre', 'anni', 'anos', 'лет', 'años', 'yıl'),
(1819, 'terms_contact', '', 'agree with {privacy} to receive communications.', 'أتفق مع {الخصوصية} لتلقي الاتصالات.', 'Mee eens met {privacy} om communicatie te ontvangen.', 'd&#039;accord avec {Confidentialité} pour recevoir des communications.', 'stimmen Sie mit {Privacy} zu, um die Kommunikation zu erhalten.', 'concordare con {privacy} per ricevere le comunicazioni.', 'Concordo com {privacy} para receber comunicações.', 'согласен с {конфиденциальность} для получения коммуникаций.', 'De acuerdo con {Privacidad} para recibir comunicaciones.', 'iletişim almak için {gizlilik} ile katılıyorum.'),
(1820, 'first_name_last_name_empty', '', 'Your First Name and Last Name can not be empty.', 'اسمك الأول واسم الأخير لا يمكن أن يكون فارغا.', 'Uw voornaam en achternaam kunnen niet leeg zijn.', 'Votre prénom et votre nom de famille ne peuvent pas être vides.', 'Ihr Vorname und der Nachname können nicht leer sein.', 'Il tuo nome e cognome non possono essere vuoti.', 'Seu primeiro nome e sobrenome não podem estar vazios.', 'Ваше имя и фамилия не могут быть пустыми.', 'Su nombre y apellido no pueden estar vacíos.', 'İlk adınız ve soyadınız boş olamaz.'),
(1821, 'reply_message', '', 'Reply To Message', 'الرد على الرسالة', 'Antwoord op bericht', 'Répondre au message', 'Antwort auf Nachricht.', 'Rispondi al messaggio', 'Responder à mensagem.', 'Ответить на сообщение', 'Responder al mensaje', 'Mesajı Yanıtla'),
(1822, 'reacted_to_your_story', '', 'reacted to your story.', 'كان رد فعل قصتك.', 'reageerde op je verhaal.', 'réagi à votre histoire.', 'reagierte auf deine Geschichte.', 'reagito alla tua storia.', 'reagiu à sua história.', 'отреагировал на вашу историю.', 'Reaccionó a tu historia.', 'hikayenize tepki gösterdi.'),
(1823, 'reply_story', '', 'Reply To Story', 'الرد على القصة', 'Antwoord op verhaal', 'Répondre à l&#039;histoire', 'Antwort auf die Geschichte', 'Rispondi alla storia', 'Responder à história', 'Ответить на историю', 'Responder a la historia', 'Hikaye Cevapla'),
(1824, 'reacted_to_your_message', '', 'reacted to your message.', 'كان رد فعل على رسالتك.', 'reageerde op uw bericht.', 'réagi à votre message.', 'reagierte auf Ihre Nachricht.', 'reagito al tuo messaggio.', 'reagiu à sua mensagem.', 'отреагировал на ваше сообщение.', 'reaccionó a tu mensaje.', 'mesajınıza tepki gösterdi.'),
(1825, 'replying_story', '', 'Replying to story', 'الرد على القصة', 'Antwoorden op verhaal', 'Répondre à l&#039;histoire', 'Antwort auf die Geschichte', 'Rispondendo alla storia', 'Respondendo à história', 'Отвечая на историю', 'Respondiendo a la historia', 'Hikayeye cevap vermek'),
(1826, 'ffmpeg_file_text', '', 'Your video is being processed, We’ll let you know when it&#039;s ready to view.', 'يتم معالجة الفيديو الخاص بك، وسوف نعلمك عندما تكون جاهزة للعرض.', 'Je video wordt verwerkt, we laten je weten wanneer het klaar is om te bekijken.', 'Votre vidéo est en cours de traitement, nous vous ferons savoir quand il est prêt à voir.', 'Ihr Video wird verarbeitet, wir informieren Sie, wann es zum Anzeigen bereit ist.', 'Il tuo video viene elaborato, ti faremo sapere quando è pronto per la visualizzazione.', 'Seu vídeo está sendo processado, informaremos você quando estiver pronto para ver.', 'Ваше видео обрабатывается, мы сообщим вам, когда он будет готов к просмотру.', 'Se está procesando su video, le informaremos cuando esté listo para ver.', 'Videonuz işleniyor, ne zaman görüntülenmeye hazır olduğunda size haber vereceğiz.'),
(1827, 'video_ready_to_view', '', 'Your video is ready to view. You can now watch it.', 'الفيديو الخاص بك جاهز للعرض.', 'Je video is klaar om te bekijken.', 'Votre vidéo est prête à voir.', 'Ihr Video ist bereit zu sehen.', 'Il tuo video è pronto per visualizzare.', 'Seu vídeo está pronto para visualizar.', 'Ваше видео готово к просмотру.', 'Tu video está listo para ver.', 'Videonuz görüntülenmeye hazır.'),
(1828, 'processing_video', '', 'The video is still being converted to other resolutions, please wait a bit more for HD content.', 'لا يزال يتم تحويل الفيديو إلى قرارات أخرى، يرجى الانتظار أكثر قليلا لمحتوى HD.', 'De video wordt nog steeds geconverteerd naar andere resoluties, wacht een beetje meer voor HD-inhoud.', 'La vidéo est toujours en cours de convertie en d&#039;autres résolutions, veuillez patienter un peu plus pour le contenu HD.', 'Das Video wird immer noch in andere Auflösungen umgewandelt, warten Sie bitte ein bisschen mehr für HD-Inhalte.', 'Il video è ancora convertito in altre risoluzioni, attendere un po &#039;di più per il contenuto HD.', 'O vídeo ainda está sendo convertido em outras resoluções, aguarde um pouco mais para conteúdo HD.', 'Видео все еще преобразуется в другие резолюции, пожалуйста, подождите немного больше для HD Content.', 'El video aún se está convirtiendo a otras resoluciones, espere un poco más para el contenido de HD.', 'Video hala diğer kararlara dönüştürülüyor, lütfen HD içerik için biraz daha bekleyin.'),
(1829, 'view_story', '', 'View Story', 'عرض القصة', 'Beeldverhaal', 'Histoire', 'Geschichte anzeigen.', 'Visualizza la storia', 'Ver a história', 'Вид истории', 'Ver historia', 'Hikayeyi görüntüle'),
(1830, 'replying_to', '', 'Replying to', 'الرد على', 'Antwoorden op', 'Répondre à', 'Antwort auf', 'Rispondendo a.', 'Respondendo a', 'Отвечать', 'Respondiendo a', 'Cevap vermek'),
(1831, 'see_trending_people', '', 'See what people are talking about.', 'نرى ما يتحدث الناس عنه.', 'Kijk waar mensen het over hebben.', 'Voir ce que les gens parlent de.', 'Sehen Sie, worüber Menschen sprechen.', 'Guarda di cosa parlano le persone.', 'Veja o que as pessoas estão falando.', 'Посмотрите, о чем говорят люди.', 'Mira de qué están hablando la gente.', 'İnsanların neden bahsettiğini görün.'),
(1832, 'feels_like_temp', '', 'Feels like', 'أحس كأنني', 'Voelt als', 'Se sent comme', 'Fühlt sich an wie', 'Si sente come', 'Parece', 'Как будто', 'Se siente como', 'Gibi hissettiriyor'),
(1833, 'pressure_temp', '', 'Pressure', 'ضغط', 'Druk', 'Pression', 'Druck', 'Pressione', 'Pressão', 'Давление', 'Presión', 'Basınç'),
(1834, 'uvi_temp', '', 'UV', 'الأشعة فوق البنفسجية', 'Uv', 'Uv', 'Uv.', 'UV.', 'UV.', 'УФ', 'UV', 'Uv'),
(1835, 'qr_dash', '', 'QR', 'qr.', 'Qr', 'Qr', 'Qr.', 'QR.', 'Qr.', 'QR.', 'QR', 'Qr'),
(1836, 'hourly_forecast', '', 'Hourly forecast', 'توقعات ساعة', 'Uurlijkse voorspeling', 'Prévision horaire', 'Stündliche Vorhersage', 'Previsione oraria', 'Previsão horária', 'Почасовой прогноз', 'Pronóstico por hora', 'Saatlik tahmin'),
(1837, 'daily_forecast', '', 'Daily forecast', 'توقعات يومية', 'Dagelijkse voorspelling', 'Prévision quotidienne', 'Tägliche Prognose', 'Previsioni giornaliere', 'Previsão diária', 'Суточный прогноз', 'Pronóstico diario', 'Günlük tahmin'),
(1838, 'posts_created', '', 'Total Posts created', 'إجمالي المشاركات التي تم إنشاؤها', 'Totale berichten gemaakt', 'Total des messages créés', 'Gesamte Beiträge erstellt.', 'Posti totali creati.', 'Postagens totais criadas', 'Общие посты созданы', 'Publicaciones totales creadas', 'Oluşturulan toplam mesajlar'),
(1839, 'posts_created_month', '', 'Total Posts Created this Month', 'إجمالي المشاركات التي تم إنشاؤها هذا الشهر', 'Totale berichten gemaakt deze maand', 'Total des messages créés ce mois-ci', 'Gesamtpflege, die diesen Monat erstellt wurden', 'Posti totali creati questo mese', 'Postagens totais criadas este mês', 'Общие посты созданы в этом месяце', 'Publicaciones totales creadas este mes.', 'Bu ay oluşturulan toplam mesajlar'),
(1840, 'reaction_dash', '', 'Reaction', 'تفاعل', 'Reactie', 'Réaction', 'Reaktion', 'Reazione', 'Reação', 'Реакция', 'Reacción', 'Reaksiyon'),
(1841, 'reacted_dash', '', 'Reacted', 'كان رد فعل', 'Reageerde', 'Réagi', 'Reagiert', 'Reagito', 'Reagiu', 'Отреагировал', 'Reaccionado', 'Reaksiyona girmiş'),
(1842, 'reacted_by', '', 'Reactions By', 'ردود الفعل من قبل', 'Reacties door', 'Réactions par', 'Reaktionen von', 'Reazioni di', 'Reações de.', 'Реакции', 'Reacciones por', 'Tarafından reaksiyonlar'),
(1843, 'i_reacted', '', 'This shows how many times you reacted to other users posts', 'هذا يدل على عدد المرات التي تتفاعل بها مشاركات المستخدمين الآخرين', 'Dit laat zien hoe vaak u reageerde op andere gebruikers', 'Cela montre combien de fois vous avez réagi aux autres postes d&#039;utilisateurs', 'Dies zeigt, wie oft Sie auf andere Benutzer-Beiträge reagiert haben', 'Questo mostra quante volte hai reagito ad altri post degli utenti', 'Isso mostra quantas vezes você reagiu a outros posts de usuários', 'Это показывает, сколько раз вы отреагировали на другие посты пользователей', 'Esto muestra cuántas veces reaccionó a otras publicaciones de usuarios', 'Bu, diğer kullanıcıların yayınlarına kaç kez reaksiyona girdiğinizi gösterir.'),
(1844, 'user_reacted', '', 'This shows how many times users reacted to your posts', 'هذا يدل على عدد مرات رد فعل المستخدمين على مشاركاتك', 'Dit laat zien hoe vaak gebruikers reageerden op uw berichten', 'Cela montre le nombre de fois que les utilisateurs ont réagi à vos messages', 'Dies zeigt, wie oft Benutzer auf Ihre Beiträge reagiert wurden', 'Questo mostra quante volte gli utenti hanno reagito ai tuoi post', 'Isso mostra quantas vezes os usuários reagiram aos seus posts', 'Это показывает, сколько раз пользователи отреагировали на ваши сообщения', 'Esto muestra cuántas veces los usuarios reaccionaron a sus publicaciones.', 'Bu, kullanıcıların yayınlarınıza kaç kez tepki verdiğini gösterir.'),
(1845, 'i_liked', '', 'This shows how many times you liked other users posts', 'هذا يدل على عدد المرات التي أعجبتها المشاركات المستخدمين الآخرين', 'Dit laat zien hoe vaak je andere gebruikersposten leuk vond', 'Cela montre combien de fois vous avez aimé les autres postes d&#039;utilisateurs', 'Dies zeigt, wie oft Ihnen andere Benutzer-Beiträge gefallen hat', 'Questo mostra quante volte ti sono piaciuti altri post degli utenti', 'Isso mostra quantas vezes você gostou de outros usuários', 'Это показывает, сколько раз вам понравились другие сообщения пользователя', 'Esto muestra cuántas veces te gustó otros usuarios de usuarios', 'Bu, diğer kullanıcıların gönderilerini kaç kez sevdiğini gösterir.'),
(1846, 'user_liked', '', 'This shows how many times users liked your posts', 'هذا يوضح كم مرة يحب المستخدمون مشاركاتك', 'Dit laat zien hoe vaak gebruikers van je berichten leuk vonden', 'Cela montre le nombre de fois que les utilisateurs ont aimé vos messages', 'Dies zeigt, wie oft Benutzer Ihre Beiträge mochten', 'Questo mostra quante volte gli utenti sono piaciuti i tuoi post', 'Isso mostra quantas vezes os usuários gostaram de suas postagens', 'Это показывает, сколько раз пользователи понравились ваши сообщения', 'Esto muestra cuántas veces a los usuarios les gustó tus publicaciones.', 'Bu, kullanıcıların yayınlarınızı kaç kez sevdiğini gösterir.'),
(1847, 'i_commented', '', 'How many times have you commented on other users posts', 'كم مرة علقت على مشاركات المستخدمين الآخرين', 'Hoe vaak heb je gereageerd op andere gebruikersposten', 'Combien de fois avez-vous commenté les postes d&#039;autres utilisateurs?', 'Wie oft haben Sie mit anderen Nutzer Beiträgen kommentiert?', 'Quante volte hai commentato i post degli altri utenti', 'Quantas vezes você já comentou sobre outros posts de usuários?', 'Сколько раз вы прокомментировали другие сообщения пользователя', '¿Cuántas veces ha comentado en otras publicaciones de usuarios?', 'Kaç kez diğer kullanıcılar mesajlarına yorum yaptınız?'),
(1848, 'user_commented', '', 'How many times have users commented on your posts', 'كم مرة علق المستخدمين على مشاركاتك', 'Hoe vaak hebben gebruikers gereageerd op uw berichten', 'Combien de fois ont commenté les utilisateurs sur vos messages', 'Wie oft haben Benutzer Ihre Beiträge kommentiert?', 'Quante volte gli utenti hanno commentato i tuoi post', 'Quantas vezes os usuários comentaram em suas postagens', 'Сколько раз пользователи прокомментировали свои сообщения', '¿Cuántas veces ha comentado los usuarios en sus publicaciones?', 'Kullanıcıların yayınlarınızda kaç kez yorum yaptılar?'),
(1849, 'i_shared', '', 'Total number of posts that you shared', 'إجمالي عدد المشاركات التي شاركتها', 'Totaal aantal berichten dat u hebt gedeeld', 'Nombre total de messages que vous avez partagés', 'Gesamtzahl der von Ihnen geteilten Beiträge', 'Numero totale di post che hai condiviso', 'Número total de postagens que você compartilhou', 'Общее количество постов, которые вы поделились', 'Número total de publicaciones que compartiste', 'Paylaştığınız toplam yayın sayısı'),
(1850, 'user_shared', '', 'Total number of users who shared your posts', 'إجمالي عدد المستخدمين الذين شاركون مشاركاتك', 'Totaal aantal gebruikers dat uw berichten deelden', 'Nombre total d&#039;utilisateurs ayant partagé vos messages', 'Gesamtzahl der Benutzer, die Ihre Beiträge geteilt haben', 'Numero totale di utenti che hanno condiviso i tuoi post', 'Número total de usuários que compartilharam suas postagens', 'Общее количество пользователей, которые поделились вашими сообщениями', 'Número total de usuarios que compartieron tus publicaciones.', 'Mesajlarınızı paylaşan toplam kullanıcı sayısı'),
(1851, 'you_must_add_text_or_image_first', '', 'You must add a text or image', 'يجب عليك إضافة نص أو صورة', 'U moet een tekst of afbeelding toevoegen', 'Vous devez ajouter un texte ou une image', 'Sie müssen einen Text oder ein Bild hinzufügen', 'Devi aggiungere un testo o un&#039;immagine', 'Você deve adicionar um texto ou imagem', 'Вы должны добавить текст или изображение', 'Debes agregar un texto o imagen.', 'Bir metin veya resim eklemelisiniz'),
(1852, 'add_to_cart', '', 'Add To Cart', 'أضف إلى السلة', 'Voeg toe aan winkelmandje', 'Ajouter au panier', 'In den Warenkorb legen', 'Aggiungi al carrello', 'Adicionar ao carrinho', 'Добавить в корзину', 'Añadir al carrito', 'Sepete ekle'),
(1853, 'remove_from_cart', '', 'Remove From Cart', 'إزالة من العربة', 'Verwijderen van winkelwagen', 'Supprimer du panier', 'Aus dem Warenkorb entfernen', 'Rimuovi dal carrello', 'Retire do carrinho', 'Удалить из корзины', 'Quitar del carrito', 'Arabadan çıkar'),
(1854, 'pay_from_wallet', '', 'Pay By Wallet', 'الدفع عن طريق المحفظة', 'Betaal per portemonnee', 'Payer par portefeuille', 'Bezahlen von Brieftasche', 'Pagare con il portafoglio', 'Pague pela Wallet.', 'Оплатить с помощью кошелька', 'Pagar por billetera', 'Cüzdan tarafından ödeme'),
(1855, 'please_top_up_wallet', '', 'You don&#039;t have enough balance to purchase, please top up your wallet.', 'ليس لديك ما يكفي من التوازن للشراء، يرجى تباريز محفظتك.', 'Je hebt niet genoeg balans om te kopen, vul je portemonnee bij.', 'Vous n&#039;avez pas assez d&#039;équilibre pour acheter, veuillez recharger votre portefeuille.', 'Sie haben nicht genug Gleichgewicht zum Kauf, bitte tippen Sie bitte Ihre Brieftasche auf.', 'Non hai abbastanza equilibrio da acquistare, per favore rabboccare il tuo portafoglio.', 'Você não tem equilíbrio suficiente para comprar, por favor suba sua carteira.', 'Вам не хватает баланса для покупки, пожалуйста, пополните свой кошелек.', 'No tiene suficiente saldo para comprar, por favor, recargue su billetera.', 'Satın almak için yeterli dengeniz yok, lütfen cüzdanınızı doldurun.'),
(1856, 'pay_to_upgrade', '', 'You are about to upgrade to a PRO memeber.', 'أنت على وشك الترقية إلى عضو برو.', 'U staat op het punt om een ​​pro-lid te upgraden.', 'Vous êtes sur le point de passer à un membre professionnel.', 'Sie dürfen gerade auf ein Pro-Mitglied ein Upgrade eingehen.', 'Stai per eseguire l&#039;aggiornamento a un membro professionale.', 'Você está prestes a atualizar para um membro Pro.', 'Вы собираетесь обновить до участника Pro.', 'Está a punto de actualizar a un miembro profesional.', 'Bir Pro Üyesine yükseltmek üzeresiniz.');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(1857, 'pay_to_fund', '', 'You are about to donate.', 'أنت على وشك التبرع.', 'Je staat op het punt te doneren.', 'Vous êtes sur le point de faire un don.', 'Du bist dabei, zu spenden.', 'Stai per donare.', 'Você está prestes a doar.', 'Вы собираетесь пожертвовать.', 'Estás a punto de donar.', 'Bağış yapmak üzeresin.'),
(1858, 'amount_can_not_empty', '', 'Amount is required', 'المبلغ مطلوب', 'Bedrag is vereist', 'Montant est requis', 'Betrag ist erforderlich', 'L&#039;importo è richiesto', 'Quantidade é necessária', 'Сумма требуется', 'Se requiere la cantidad', 'Tutar gereklidir'),
(1859, 'fund_not_found', '', 'Funding is not found', 'لم يتم العثور على التمويل', 'Financiering wordt niet gevonden', 'Le financement n&#039;est pas trouvé', 'Die Finanzierung wird nicht gefunden', 'Il finanziamento non è stato trovato', 'Financiamento não é encontrado', 'Финансирование не найдено', 'La financiación no se encuentra', 'Finansman bulunamadı'),
(1860, 'payment_successfully_done', '', 'Payment successfully done, thank you!', 'تم الدفع بنجاح، شكرا لك!', 'Betaling succesvol gedaan, dank u!', 'Paiement effectué avec succès, merci!', 'Zahlung erfolgreich gemacht, danke!', 'Pagamento fatto con successo, grazie!', 'Pagamento feito com sucesso, obrigado!', 'Оплата успешно сделана, спасибо!', 'Pago hecho con éxito, ¡Gracias!', 'Ödeme başarıyla yapıldı, teşekkür ederim!'),
(1861, 'buy_now', '', 'Buy Now', 'اشتري الآن', 'Koop nu', 'Acheter maintenant', 'Kaufe jetzt', 'Acquista ora', 'Compre', 'купить сейчас', 'Compra ahora', 'Şimdi satın al'),
(1862, 'total_item', '', 'Total Item Units', 'وحدات البند الإجمالية', 'Totale itemeenheden', 'Total des unités d&#039;article', 'Gesamtstückeinheiten', 'Unità di articoli totali', 'Unidades totais de itens', 'Всего единиц товара', 'Unidades de elementos totales', 'Toplam Ürün Birimleri'),
(1863, 'total_item_not_empty', '', 'Item units is required', 'مطلوب وحدات البند', 'Artikeleenheden zijn vereist', 'Les unités d&#039;article sont nécessaires', 'Artikeleinheiten sind erforderlich', 'Le unità degli articoli sono richieste', 'Unidades de item são necessárias', 'Устройства предмета необходимы', 'Se requiere unidades de elementos', 'Öğe Birimleri Gerekli'),
(1864, 'currently_unavailable', '', 'Currently unavailable.', 'غير متاح حاليا.', 'Momenteel niet beschikbaar.', 'Actuellement indisponible.', 'Momentan nicht verfügbar.', 'Attualmente non disponibile.', 'Atualmente indisponivel.', 'В настоящее время недоступен.', 'Actualmente no disponible.', 'Şu anda kullanılamıyor.'),
(1865, 'checkout', '', 'Checkout', 'الدفع', 'Uitchecken', 'Vérifier', 'Kasse', 'Guardare', 'Confira', 'Проверить', 'Verificar', 'Ödeme'),
(1866, 'no_items_found', '', 'No items found', 'لم يتم العثور على العناصر', 'Geen items gevonden', 'Aucun élément trouvé', 'Keine Elemente gefunden', 'Nessun articolo trovato', 'Nenhum item encontrado', 'ничего не найдено', 'No se encontraron artículos', 'hiç bir öğe bulunamadı'),
(1867, 'total', '', 'Total', 'مجموع', 'Totaal', 'Le total', 'Gesamt', 'Totale', 'Total', 'Всего', 'Total', 'Toplam'),
(1868, 'my_addresses', '', 'My Addresses', 'عناويني', 'Mijn adressen', 'Mes adresses', 'Meine Adressen', 'I miei indirizzi', 'Meus endereços', 'Мои адреса', 'Mis direcciones', 'Adresim'),
(1869, 'add_new', '', 'Add New', 'اضف جديد', 'Voeg nieuw toe', 'Ajouter de nouveau', 'Neue hinzufügen', 'Aggiungere nuova', 'Adicionar novo', 'Добавить новое', 'Añadir nuevo', 'Yeni ekle'),
(1870, 'add_new_address', '', 'Add New Address', 'إضافة عنوان جديد', 'Nieuw adres toevoegen', 'Ajouter une nouvelle adresse', 'Neue Adresse hinzufügen', 'Aggiungi un nuovo indirizzo', 'Adicionar novo endereço', 'Добавьте новый адрес', 'Agregar nueva dirección', 'Yeni adres ekleyin'),
(1871, 'address_added', '', 'Your address has been added successfully', 'تمت إضافة عنوانك بنجاح', 'Uw adres is succesvol toegevoegd', 'Votre adresse a été ajoutée avec succès', 'Ihre Adresse wurde erfolgreich hinzugefügt', 'Il tuo indirizzo è stato aggiunto con successo', 'Seu endereço foi adicionado com sucesso', 'Ваш адрес был успешно добавлен', 'Su dirección ha sido añadida con éxito', 'Adresiniz başarıyla eklendi'),
(1872, 'delete_your_address', '', 'Delete your address', 'حذف عنوانك', 'Verwijder uw adres', 'Supprimer votre adresse', 'Löschen Sie Ihre Adresse', 'Elimina il tuo indirizzo', 'Exclua seu endereço', 'Удалить свой адрес', 'Elimina tu dirección', 'Adresinizi Sil'),
(1873, 'are_you_delete_your_address', '', 'Are you sure you want to delete this address?', 'هل أنت متأكد من أنك تريد حذف هذا العنوان؟', 'Weet je zeker dat je dit adres wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer cette adresse?', 'Möchten Sie diese Adresse sicher, dass Sie diese Adresse löschen möchten?', 'Sei sicuro di voler eliminare questo indirizzo?', 'Tem certeza de que deseja excluir este endereço?', 'Вы уверены, что хотите удалить этот адрес?', '¿Está seguro de que desea eliminar esta dirección?', 'Bu adresi silmek istediğinize emin misiniz?'),
(1874, 'edit_address', '', 'Edit Address', 'تعديل العنوان', 'verander adres', 'Modifier l&#039;adresse', 'Adresse bearbeiten', 'Modifica indirizzo', 'Editar Endereço', 'Редактировать адрес', 'Editar dirección', 'Adresi düzelt'),
(1875, 'address_edited', '', 'Your address has been edited successfully', 'تم تحرير عنوانك بنجاح', 'Uw adres is succesvol bewerkt', 'Votre adresse a été modifiée avec succès', 'Ihre Adresse wurde erfolgreich bearbeitet', 'Il tuo indirizzo è stato modificato con successo', 'Seu endereço foi editado com sucesso', 'Ваш адрес успешно отредактирован', 'Su dirección ha sido editada con éxito', 'Adresiniz başarıyla düzenlendi'),
(1876, 'please_add_address', '', 'Please add a new address', 'يرجى إضافة عنوان جديد', 'Voeg alstublieft een nieuw adres toe', 'S&#039;il vous plaît ajouter une nouvelle adresse', 'Bitte fügen Sie eine neue Adresse hinzu', 'Si prega di aggiungere un nuovo indirizzo', 'Por favor, adicione um novo endereço', 'Пожалуйста, добавьте новый адрес', 'Por favor agregue una nueva dirección', 'Lütfen yeni bir adres ekle'),
(1877, 'please_select_address', '', 'Please select an address', 'يرجى اختيار عنوان', 'Selecteer een adres', 'Veuillez sélectionner une adresse', 'Bitte wählen Sie eine Adresse aus', 'Si prega di selezionare un indirizzo', 'Por favor, selecione um endereço', 'Пожалуйста, выберите адрес', 'Por favor seleccione una dirección', 'Lütfen bir adres seçin'),
(1878, 'payment_alert', '', 'Payment Alert', 'تنبيه الدفع', 'Betalingswaarschuwing', 'Alerte de paiement', 'Zahlungsalarm', 'Avviso di pagamento', 'Alerta de pagamento', 'Оплата', 'Alerta de pago', 'Ödeme uyarısı'),
(1879, 'purchase_the_items', '', 'You are about to purchase the items, do you want to proceed?', 'أنت على وشك شراء العناصر، هل تريد المتابعة؟', 'Je staat op het punt om de items te kopen, wil je doorgaan?', 'Vous êtes sur le point d&#039;acheter les articles, voulez-vous continuer?', 'Sie können die Artikel kaufen, möchten Sie fortfahren?', 'Stai per acquistare gli articoli, vuoi procedere?', 'Você está prestes a comprar os itens, deseja prosseguir?', 'Вы собираетесь приобрести предметы, вы хотите продолжить?', 'Está a punto de comprar los artículos, ¿desea continuar?', 'Öğeleri satın almak üzeresiniz, devam etmek ister misiniz?'),
(1880, 'shopping_cart', '', 'Shopping Cart', 'عربة التسوق', 'Winkelwagen', 'Panier', 'Einkaufswagen', 'Carrello della spesa', 'Carrinho de compras', 'Корзина', 'Carro de compras', 'Alışveriş Sepeti'),
(1881, 'items', '', 'Items', 'أغراض', 'Items', 'Articles', 'Produkte', 'Elementi', 'Itens', 'Предметы', 'Elementos', 'Öğeler'),
(1882, 'back_to_shop', '', 'Back to shop', 'العودة إلى المتجر', 'Terug naar winkel', 'Retour au magasin', 'Zurück zum Laden', 'Torna a Shop.', 'De volta à loja', 'Вернуться к магазину', 'Volver a la tienda', 'Dükkana geri dön'),
(1883, 'some_products_units', '', 'Some products are out of stock.', 'بعض المنتجات خارج المخزون.', 'Sommige producten zijn niet op voorraad.', 'Certains produits sont en rupture de stock.', 'Einige Produkte sind nicht auf Lager.', 'Alcuni prodotti sono esauriti.', 'Alguns produtos estão fora de estoque.', 'Некоторые продукты отсутствуют на складе.', 'Algunos productos están agotados.', 'Bazı ürünler stokta yok.'),
(1884, 'address_can_not_be_empty', '', 'Address can not be empty', 'العنوان لا يمكن أن يكون فارغا', 'Adres kan niet leeg zijn', 'L&#039;adresse ne peut pas être vide', 'Adresse kann nicht leer sein', 'L&#039;indirizzo non può essere vuoto', 'Endereço não pode estar vazio', 'Адрес не может быть пустым', 'La dirección no puede estar vacía', 'Adres boş olamaz'),
(1885, 'address_not_found', '', 'Address not found', 'لم يتم العثور على العنوان', 'Adres niet gevonden', 'Adresse introuvable', 'Adresse nicht gefunden', 'Indirizzo non trovato.', 'Endereço não encontrado', 'Адрес не найден', 'Dirección no encontrada', 'Adres bulunamadı'),
(1886, 'card_is_empty', '', 'Cart is empty', 'البطاقه خاليه', 'Winkelwagen is leeg', 'Le panier est vide', 'Einkaufswagen ist leer', 'Il carrello è vuoto', 'carrinho esta vazio', 'Корзина пуста', 'El carrito esta vacío', 'Kart boş'),
(1887, 'your_order_has_been_placed_successfully', '', 'Your order has been placed successfully', 'تم وضع طلبك بنجاح', 'Uw bestelling is succesvol geplaatst', 'Votre commande a été placée avec succès', 'Ihre Bestellung wurde erfolgreich platziert', 'Il tuo ordine è stato posizionato con successo', 'Seu pedido foi feito com sucesso', 'Ваш заказ был успешно размещен', 'Su pedido ha sido realizado con éxito.', 'Siparişiniz başarıyla verildi'),
(1888, 'purchased', '', 'Purchased', 'تم شراؤها', 'Gekocht', 'Acheté', 'Gekauft', 'Acquistato', 'Comprado', 'Купленный', 'Comprado', 'satın alındı'),
(1889, 'no_purchased_found', '', 'No purchased items found', 'لم يتم العثور على عناصر تم شراؤها', 'Geen aangekochte items gevonden', 'Aucun article acheté trouvé', 'Es wurden keine gekauften Elemente gefunden', 'Nessun articolo acquistato trovato', 'Nenhum item comprado encontrado', 'Не найденные предметы не найдены', 'No se han encontrado artículos comprados', 'Satın alınan ürün bulunamadı'),
(1890, 'order', '', 'Order', 'طلب', 'Volgorde', 'Commander', 'Befehl', 'Ordine', 'Pedido', 'Заказ', 'Pedido', 'Emir'),
(1891, 'download_invoice', '', 'Download Invoice', 'تحميل فاتورة', 'Factuur downloaden', 'Télécharger la facture', 'Download Rechnung', 'Scarica Fattura', 'Baixe o Invoice', 'Скачать счет', 'Descargar factura', 'Faturayı indirin'),
(1892, 'id_can_not_empty', '', 'ID is required', 'معرف مطلوب', 'ID is vereist', 'ID est requis', 'ID ist erforderlich', 'L&#039;ID è richiesto', 'ID é obrigatório', 'ID требуется', 'Se requiere identificación', 'Kimlik gereklidir'),
(1893, 'you_are_not_purchased', '', 'You haven&#039;t purchased yet.', 'أنت لم تشتري بعد.', 'Je hebt nog niet gekocht.', 'Vous n&#039;avez pas encore acheté.', 'Sie haben noch nicht gekauft.', 'Non hai ancora acquistato.', 'Você ainda não comprou.', 'Вы еще не купили.', 'Aún no has comprado.', 'Henüz satın almadınız.'),
(1894, 'order_not_found', '', 'Order not found', 'غير موجود', 'Bestellen niet gevonden', 'Commande introuvable', 'Bestellen nicht gefunden', 'Ordine non trovato', 'Ordem não encontrada', 'Не найден', 'Orden no encontrado', 'Sipariş bulunamadı'),
(1895, 'order_details', '', 'Order details', 'تفاصيل الطلب', 'Bestel Details', 'Détails de la commande', 'Bestelldetails', 'Dettagli ordine', 'Detalhes do pedido', 'Информация для заказа', 'Detalles de pedido', 'Sipariş detayları'),
(1896, 'write_review', '', 'Write Review', 'أكتب مراجعة', 'Schrijf recensie', 'Ecrire une critique', 'Bewertung schreiben', 'Scrivere una recensione', 'Escrever análise', 'Написать обзор', 'Escribir un comentario', 'Yorum yaz'),
(1897, 'tracking_details', '', 'Tracking Details', 'تتبع التفاصيل', 'Tracking details', 'Détails de suivi', 'Verfolgungsdetails', 'Tracciamento dei dettagli', 'Detalhes de rastreamento', 'Отслеживание деталей', 'Detalles de seguimiento', 'Yürüyüş detayları'),
(1898, 'delivery_address', '', 'Delivery Address', 'عنوان التسليم', 'Bezorgadres', 'Adresse de livraison', 'Lieferadresse', 'Indirizzo di consegna', 'Endereço de entrega', 'Адресс доставки', 'Dirección de entrega', 'Teslimat adresi'),
(1899, 'if_the_order_status', '', 'If the order status wasn&#039;t set to delivered within 60 days from the order date, it will be automatically be sent to &quot;Delivered&quot;.', 'إذا لم يتم تعيين حالة الطلب لتسليمها في غضون 60 يوما من تاريخ الطلب، فسيتم إرسالها تلقائيا إلى &quot;تسليمها&quot;.', 'Als de bestelstatus niet is ingesteld op afgeleverd binnen 60 dagen na de besteldatum, wordt deze automatisch verzonden naar &quot;geleverd&quot;.', 'Si l&#039;état de la commande n&#039;était pas défini sur livré dans les 60 jours à compter de la date de la commande, il sera automatiquement envoyé à \\&quot;livré\\&quot;.', 'Wenn der Bestellstatus nicht innerhalb von 60 Tagen ab dem Bestelldatum angeliefert wurde, wird es automatisch an \\&quot;geliefert\\&quot; gesendet.', 'Se lo stato dell&#039;ordine non è stato impostato su Fornito entro 60 giorni dalla data dell&#039;ordine, verrà automaticamente inviato a \\&quot;consegnato\\&quot;.', 'Se o status do pedido não foi definido como entregue no prazo de 60 dias a partir da data do pedido, ele será automaticamente enviado para \\&quot;entregue\\&quot;.', 'Если статус заказа не был установлен для доставки в течение 60 дней с даты заказа, он будет автоматически отправлен на «доставленные».', 'Si el estado del pedido no se configuró para entregar dentro de 60 días a partir de la fecha del pedido, se enviará automáticamente a \\&quot;entregado\\&quot;.', 'Sipariş durumu, sipariş tarihinden itibaren 60 gün içinde teslim edilmemişse, otomatik olarak \\&quot;teslim\\&quot; için gönderilir.'),
(1900, 'if_the_order_delivered', '', 'If the order wasn&#039;t actually delivered, the buyer can request a refund.', 'إذا لم يتم تسليم الطلب بالفعل، فيمكن للمشتري طلب استرداد.', 'Als de bestelling niet daadwerkelijk is afgeleverd, kan de koper een terugbetaling aanvragen.', 'Si la commande n&#039;était pas réellement livrée, l&#039;acheteur peut demander un remboursement.', 'Wenn die Bestellung nicht tatsächlich geliefert wurde, kann der Käufer eine Rückerstattung anfordern.', 'Se l&#039;ordine non è stato effettivamente consegnato, l&#039;acquirente può richiedere un rimborso.', 'Se o pedido não foi realmente entregue, o comprador pode solicitar um reembolso.', 'Если заказ на самом деле не был доставлен, покупатель может запросить возмещение.', 'Si el pedido no fue realmente entregado, el comprador puede solicitar un reembolso.', 'Sipariş aslında teslim edilmediyse, alıcı bir geri ödeme talebinde bulunabilir.'),
(1901, 'placed', '', 'Placed', 'وضع', 'Geplaatst', 'Mis', 'Platziert', 'Posto', 'Colocada', 'Размещены', 'Metido', 'Yerleştirilmiş'),
(1902, 'payments', '', 'Payments', 'المدفوعات', 'Betalingen', 'Paiements', 'Zahlungen', 'Pagamenti', 'Pagamentos', 'Платежи', 'Pagos', 'Ödeme'),
(1903, 'subtotal', '', 'Subtotal', 'فرعي', 'Subtotaal', 'Total', 'Zwischensumme', 'totale parziale', 'Subtotal', 'Промежуточный итог', 'Total parcial', 'ara toplam'),
(1904, 'sale_invoice', '', 'Sale invoice', 'الفاتورة بيع', 'Verkoopfactuur', 'Facture de vente', 'Verkauf Rechnung.', 'Fattura di vendita', 'Fatura de venda', 'Продажа счет', 'Factura de venta', 'Satış faturası'),
(1905, 'seller_name', '', 'Seller Name', 'البائع اسم', 'Naam van de verkoper', 'Nom du Vendeur', 'Name des Verkäufers', 'Nome del venditore', 'Nome do Vendedor', 'Название продавца', 'Nombre del vendedor', 'Satıcı Adı'),
(1906, 'seller_email', '', 'Seller Email', 'البريد الإلكتروني للبائع', 'Verkoper e-mail', 'Vendeur e-mail', 'Verkäufer-E-Mail.', 'Email del venditore', 'Email do vendedor', 'По электронной почте продавца', 'Email del vendedor', 'Satıcı e-postası'),
(1907, 'invoice_to', '', 'Invoice To', 'فاتورة إلى', 'Factuur aan', 'Facture à', 'Rechnung an', 'Fattura', 'Fatura para', 'Счет-фактуру', 'Factura a', 'Fatura'),
(1908, 'payment_details', '', 'Payment Details', 'بيانات الدفع', 'Betalingsdetails', 'Détails de paiement', 'Zahlungsdetails', 'Dettagli di pagamento', 'Detalhes do pagamento', 'Детали оплаты', 'Detalles del pago', 'Ödeme detayları'),
(1909, 'total_due', '', 'Total Due', 'الاجمالي المستحق', 'Totaal verschuldigd', 'Total dû', 'Insgesamt fällig.', 'Totale dovuto', 'Total devido', 'Всего должное', 'Total de vencimiento', 'Tam olarak'),
(1910, 'bank_name', '', 'Bank name', 'اسم البنك', 'banknaam', 'Nom de banque', 'Bank Name', 'nome della banca', 'nome do banco', 'название банка', 'Nombre del banco', 'banka adı'),
(1911, 'invoice', '', 'Invoice', 'فاتورة', 'Factuur', 'Facture d&#039;achat', 'Rechnung', 'Fattura', 'Fatura', 'Счет', 'Factura', 'Fatura'),
(1912, 'item', '', 'Item', 'العنصر', 'Item', 'Article', 'Artikel', 'Elemento', 'Item', 'Пункт', 'Articulo', 'Kalem'),
(1913, 'orders', '', 'Orders', 'الطلب #٪ s', 'Bestellingen', 'Ordres', 'Aufträge', 'Ordini', 'Pedidos', 'Заказывает', 'Pedidos', 'Emirler'),
(1914, 'no_orders_found', '', 'No orders found', 'لم يتم العثور على أية طلبات', 'Geen bestellingen gevonden', 'Aucune commande trouvée', 'Keine Bestellungen gefunden', 'Nessun ordine trovato', 'Nenhuma encomenda encontrada', 'Заказы не найдены', 'No se han encontrado pedidos', 'sipariş bulunamadı'),
(1915, 'products', '', 'Products', 'منتجات', 'Producten', 'Des produits', 'Produkte', 'Prodotti', 'Produtos', 'Продукты', 'Productos', 'Ürün:% s'),
(1916, 'qty', '', 'Qty', 'الكمية', 'Titel', 'Quantité', 'Attiert', 'Qty.', 'Qty.', 'Qty.', 'Cantidad', 'Qty'),
(1917, 'canceled', '', 'Canceled', 'ألغيت', 'Geannuleerd', 'Annulé', 'Abgesagt', 'Annullato', 'Cancelado', 'Отменил', 'Cancelado', 'İptal edildi'),
(1918, 'accepted', '', 'Accepted', 'قبلت', 'Geaccepteerd', 'Accepté', 'Akzeptiert', 'Accettato', 'Aceitaram', 'Принятый', 'Aceptado', 'Kabul edilmiş'),
(1919, 'packed', '', 'Packed', 'معباه', 'Ingepakt', 'Emballé', 'Verpackt', 'Confezionato', 'Embalado', 'Упакованный', 'Lleno', 'Paketlenmiş'),
(1920, 'shipped', '', 'Shipped', 'شحنها', 'Verzenden', 'Expédié', 'Geliefert', 'Spedito', 'Enviado', 'Отправленный', 'Enviado', 'Sevk edilen'),
(1921, 'commission', '', 'Commission', 'لجنة', 'Commissie', 'Commission', 'Kommission', 'Commissione', 'Comissão', 'Комиссия', 'Comisión', 'komisyon'),
(1922, 'final_price', '', 'Final Price', 'السعر النهائي', 'Uiteindelijke prijs', 'Prix ​​final', 'Endgültiger Preis', 'Prezzo finale', 'Preço final', 'Окончательная цена', 'Precio final', 'Son fiyat'),
(1923, 'tracking_number', '', 'Tracking Number', 'أرقام التتبع', 'Volg nummer', 'Numéro de suivi', 'Auftragsnummer, Frachtnummer, Sendungscode', 'Numero di identificazione', 'Numero de rastreio', 'Идентификационный номер', 'El número de rastreo', 'Takip numarası'),
(1924, 'link', '', 'Link', 'وصلة', 'Koppeling', 'Lien', 'Verknüpfung', 'Collegamento', 'Link', 'Ссылка на сайт', 'Enlace', 'Bağlantı'),
(1925, 'tracking_info_has_been_saved_successfully', '', 'Tracking info has been saved successfully', 'تم حفظ معلومات التتبع بنجاح', 'Tracking-informatie is succesvol opgeslagen', 'Les informations de suivi ont été sauvegardées avec succès', 'Tracking-Info wurde erfolgreich gespeichert', 'Le informazioni di tracciamento sono state salvate con successo', 'As informações de rastreamento foram salvas com sucesso', 'Информация о отслеживании была успешно сохранена', 'La información de seguimiento se ha guardado correctamente', 'İzleme bilgisi başarıyla kaydedildi'),
(1926, 'tracking_url_can_not_be_empty', '', 'Tracking url can not be empty', 'لا يمكن أن يكون تتبع عنوان URL فارغا', 'Tracking-URL kan niet leeg zijn', 'L&#039;URL de suivi ne peut pas être vide', 'Tracking-URL kann nicht leer sein', 'L&#039;URL di tracciamento non può essere vuoto', 'O URL de rastreamento não pode estar vazio', 'УРЛ отслеживания не может быть пустым', 'La URL de seguimiento no puede estar vacía', 'İzleme URL&#039;si boş olamaz'),
(1927, 'tracking_number_can_not_be_empty', '', 'Tracking number can not be empty', 'عدد تتبع لا يمكن أن يكون فارغا', 'Tracking-nummer kan niet leeg zijn', 'Le numéro de suivi ne peut pas être vide', 'Die Tracking-Nummer kann nicht leer sein', 'Il numero di tracciamento non può essere vuoto', 'Número de rastreamento não pode estar vazio', 'Номер отслеживания не может быть пустым', 'El número de seguimiento no puede estar vacío', 'İzleme numarası boş olamaz'),
(1928, 'please_enter_valid_url', '', 'Please enter a valid url', 'أدخل رابط صحيح من فضلك', 'Voer een geldige URL in', 'S&#039;il vous plaît entrer une URL valide', 'Bitte geben Sie eine gültige URL ein', 'Per favore, inserisci un URL valido', 'Por favor, insira um URL válido', 'Пожалуйста, введите корректный адрес', 'Por favor introduzca un URL válido', 'Lütfen geçerli bir adres girin'),
(1929, 'site_url', '', 'Site Url', 'URL الموقع', 'Site URL', 'URL du site', 'Seiten-URL', 'Indirizzo del sito', 'URL do site', 'Адрес сайта', 'Sitio URL', 'Site URL&#039;si'),
(1930, 'delivered', '', 'Delivered', 'تم التوصيل', 'Afgeleverd', 'Livré', 'Geliefert', 'Consegnato', 'Entregue', 'Доставленный', 'Entregado', 'Teslim edilmiş'),
(1931, 'please_explain_the_reason', '', 'Please explain the reason', 'يرجى توضيح السبب', 'Leg de reden uit', 'S&#039;il vous plaît expliquer la raison', 'Bitte erkläre den Grund', 'Si prega di spiegare la ragione', 'Por favor, explique o motivo', 'Пожалуйста, объясните причину', 'Por favor explique la razón', 'Lütfen nedeni açıklayın'),
(1932, 'your_request_is_under_review', '', 'Your request is under review, we contact you once done.', 'طلبك قيد المراجعة، نتواصل معك مرة واحدة.', 'Uw verzoek wordt beoordeeld, we nemen eenmaal contact op met u.', 'Votre demande est à l&#039;étude, nous vous contacterons une fois terminé.', 'Ihre Anfrage ist überprüft, wir kontaktieren Sie einmal mit Ihnen.', 'La tua richiesta è in fase di revisione, ti contattiamo una volta.', 'Sua solicitação está em revisão, entramos em contato com você uma vez.', 'Ваш запрос находится под рассмотрением, мы свяжемся с вами после выполнения.', 'Su solicitud está bajo revisión, nos ponemos en contacto con usted una vez hecho.', 'İsteğiniz inceleme altında, bir kez yaptıktan sonra sizinle iletişim kuruyoruz.'),
(1933, 'review', '', 'Review', 'إعادة النظر', 'Beoordeling', 'Passer en revue', 'Rezension', 'Revisione', 'Análise', 'Обзор', 'Revisar', 'Gözden geçirmek'),
(1934, 'submit', '', 'Submit', 'إرسال', 'Indienen', 'Soumettre', 'einreichen', 'Invia', 'Enviar', 'Представлять на рассмотрение', 'Entregar', 'Göndermek'),
(1935, 'review_can_not_be_empty', '', 'Review content is required.', 'محتوى المراجعة مطلوب.', 'Review Content is vereist.', 'Examiner le contenu est requis.', 'Der Überprüfen des Inhalts ist erforderlich.', 'Il contenuto della revisione è richiesto.', 'O conteúdo de revisão é necessário.', 'Обзор содержимого требуется.', 'Se requiere el contenido de revisión.', 'İnceleme içeriği gereklidir.'),
(1936, 'rating_can_not_be_empty', '', 'rating can not be empty', 'التصنيف لا يمكن أن يكون فارغا', 'beoordeling kan niet leeg zijn', 'la note ne peut pas être vide', 'Bewertung kann nicht leer sein', 'La valutazione non può essere vuota', 'classificação não pode estar vazia', 'Рейтинг не может быть пустым', 'la calificación no puede estar vacía', 'derecelendirme boş olamaz'),
(1937, 'review_has_been_sent_successfully', '', 'Your review has been submitted.', 'تم تقديم مراجعتك.', 'Uw beoordeling is ingediend.', 'Votre avis a été soumis.', 'Ihre Überprüfung wurde eingereicht.', 'La tua recensione è stata presentata.', 'Sua avaliação foi enviada.', 'Ваш обзор был представлен.', 'Su revisión ha sido enviada.', 'İncelemeniz gönderildi.'),
(1938, 'admin_status_changed', '', 'order status has been changed', 'تم تغيير حالة الطلب', 'Bestelstatus is gewijzigd', 'Le statut de commande a été changé', 'Der Bestellstatus wurde geändert', 'Lo stato dell&#039;ordine è stato modificato', 'O status do pedido foi alterado', 'Статус заказа был изменен', 'El estado del pedido ha sido cambiado', 'Sipariş durumu değiştirildi'),
(1939, 'new_orders_has_been_placed', '', 'new orders has been placed', 'وقد وضعت أوامر جديدة', 'Nieuwe bestellingen zijn geplaatst', 'Les nouvelles commandes ont été placées', 'Neue Bestellungen wurden platziert', 'I nuovi ordini sono stati collocati', 'Novas ordens foram colocadas', 'Новые заказы были размещены', 'Se han colocado nuevos pedidos.', 'Yeni siparişler yerleştirildi'),
(1940, 'added_tracking_info', '', 'added tracking info', 'وأضاف معلومات التتبع', 'Tracking-info toegevoegd', 'Info de suivi ajouté', 'Tracking-Info hinzugefügt.', 'Aggiunto informazioni di monitoraggio', 'Acrescentou informações de rastreamento', 'Добавлена ​​информация отслеживания', 'Información de seguimiento añadido', 'Eklenen İzleme Bilgisi'),
(1941, 'product_approved', '', 'your product has been approved', 'تمت الموافقة على منتجك', 'Uw product is goedgekeurd', 'Votre produit a été approuvé', 'Ihr Produkt wurde genehmigt', 'Il tuo prodotto è stato approvato', 'Seu produto foi aprovado', 'Ваш продукт был одобрен', 'Su producto ha sido aprobado.', 'Ürününüz onaylandı'),
(1942, 'your_product_is_under_review', '', 'Your product is currently under review.', 'المنتج الخاص بك قيد المراجعة حاليا.', 'Uw product wordt momenteel beoordeeld.', 'Votre produit est actuellement à l&#039;étude.', 'Ihr Produkt wird derzeit überprüft.', 'Il tuo prodotto è attualmente in esame.', 'Seu produto está atualmente em revisão.', 'Ваш продукт в настоящее время находится под контролем.', 'Su producto está actualmente bajo revisión.', 'Ürününüz şu anda incelenmektedir.'),
(1943, 'tweet', '', 'Tweet', 'سقسقة', 'Tweet', 'Tweet', 'Tweet', 'Tweet.', 'Tweet', 'Чирикать', 'Pío', 'Cıvıldamak'),
(1944, 'ask', '', 'Ask', 'طلب', 'Vragen', 'Interroger', 'Fragen', 'Chiedere', 'Perguntar', 'Просить', 'Preguntar', 'Sor'),
(1945, 'write_answer', '', 'Write an answer and press enter', 'اكتب إجابة واضغط على Enter', 'Schrijf een antwoord en druk op ENTER', 'Écrivez une réponse et appuyez sur Entrée', 'Schreiben Sie eine Antwort und drücken Sie die Eingabetaste', 'Scrivi una risposta e premi Invio', 'Escreva uma resposta e pressione ENTER', 'Напишите ответ и нажмите Enter', 'Escribe una respuesta y presiona ENTER', 'Bir cevap yazın ve Enter tuşuna basın.'),
(1946, 'reply_to_answer', '', 'Reply to answer', 'الرد على الإجابة', 'Antwoord om te antwoorden', 'Répondre à répondre', 'Antwort auf Antwort', 'Rispondi a Risposta', 'Responder à resposta', 'Ответить на ответ', 'Responder a la respuesta', 'Cevapla cevap'),
(1947, 'answered_your_question', '', 'answered your question', 'أجاب سؤالك', 'beantwoordde je vraag', 'répondu à votre question', 'Antwortete deine Frage.', 'ha risposto alla tua domanda', 'Respondeu sua pergunta', 'ответил на ваш вопрос', 'respondió tu pregunta', 'Sorunuzu cevapladı'),
(1948, 'replied_to_answer', '', 'replied to your answer', 'أجاب عن إجابتك', 'antwoordde op je antwoord', 'répondit à votre réponse', 'antwortete auf deine Antwort', 'ha risposto alla tua risposta', 'respondeu à sua resposta', 'ответил на ваш ответ', 'respondió a tu respuesta', 'cevabınıza cevap verdi'),
(1949, 'liked_question', '', 'liked your question', 'أعجبك سؤالك', 'vond je vraag leuk', 'aimé votre question', 'Mochte deine Frage.', 'è piaciuta la tua domanda', 'gostei da sua pergunta', 'понравился ваш вопрос', 'Me gustó tu pregunta', 'Sorunu beğendi'),
(1950, 'liked_answer', '', 'liked your answer', 'أحببت إجابتك', 'vond je antwoord leuk', 'aimé votre réponse', 'mochte deine Antwort', 'è piaciuta la tua risposta', 'gostei da sua resposta', 'понравился ваш ответ', 'Me gustó tu respuesta', 'Cevabını beğendim'),
(1951, 'answer_mention', '', 'mentioned you on an answer', 'ذكرت لك على إجابة', 'Genoemde je op een antwoord', 'vous a mentionné sur une réponse', 'erwähnte Sie auf einer Antwort', 'ti ho detto su una risposta', 'mencionou você em uma resposta', 'упомянул вас на ответе', 'te mencionó en una respuesta', 'bir cevaptan bahsetti'),
(1952, 'question_mention', '', 'mentioned you on a question', 'ذكرت لك على سؤال', 'Ik heb je op een vraag genoemd', 'vous a mentionné sur une question', 'erwähnte Sie eine Frage', 'ti ha detto su una domanda', 'mencionou você em uma pergunta', 'упомянул вас на вопрос', 'te mencionó en una pregunta', 'bir sorudan bahsetti'),
(1953, 'verified_purchase', '', 'Verified Purchase', 'التحقق من الشراء', 'Geverifieerde aankoop', 'Achat vérifié', 'Geprüfter Kauf.', 'Acquisto verificato', 'Compra verificada.', 'Проверенная покупка', 'Compra verificada', 'Doğrulanmış Satınalma'),
(1954, 'no_reviews_found', '', 'No reviews found', 'لم يتم العثور على مراجعات', 'Geen reviews gevonden', 'Aucun commentaire trouvé', 'Keine Bewertungen gefunden', 'Nessuna recensione trovata', 'Nenhum comentário encontrado', 'Отзывов не найдено', 'No se encontraron opiniones', 'Yorum bulunamadı'),
(1955, 'ask_anonymously', '', 'Ask anonymously', 'اسأل متخفيا', 'vraag anoniem', 'demander anonymement', 'Anonym Fragen', 'Chiedere anonimamente', 'Pergunte anonimamente', 'спросить анонимно', 'Pregunta anónimamente', 'Anonim olarak sor'),
(1956, 'ask_friend', '', 'Ask friend', 'أسأل صديق', 'Vraag een vriend', 'Demander à un ami', 'Frag einen Freund', 'Chiedi a un amico', 'Pergunte a um amigo', 'Спросить друга', 'Preguntar a un amigo', 'Arkadaşına sor'),
(1957, 'search_for_friends', '', 'Search for friends', 'البحث عن أصدقاء', 'Zoek naar vrienden', 'Rechercher des amis', 'Suche nach Freunden', 'Cerca amici.', 'Procure por amigos', 'Поиск друзей', 'Buscar amigos', 'Arkadaşlarını ara'),
(1958, 'askfm_box_placeholder', '', 'What, when, why… ask', 'ماذا، متى، لماذا ... اسأل', 'Wat, wanneer, waarom ... vraag', 'Quoi, quand, pourquoi ... demander', 'Was, wann, warum ... fragen', 'Cosa, quando, perché ... chiedi', 'O que, quando, por que ... pergunte', 'Что, когда, почему ... спросить', 'Qué, cuándo, por qué ... pregunte', 'Ne, ne zaman, neden ... sor'),
(1959, 'question_can_not_empty', '', 'Question is required.', 'السؤال مطلوب.', 'Vraag is vereist.', 'Question est requise.', 'Frage ist erforderlich.', 'La domanda è richiesta.', 'Pergunta é necessária.', 'Вопрос требуется.', 'Se requiere la pregunta.', 'Soru gereklidir.'),
(1960, 'please_select_who_you_want_ask', '', 'Please select who you want to ask', 'يرجى تحديد من تريد أن تسأل', 'Selecteer alstublieft wie u wilt vragen', 'S&#039;il vous plaît sélectionner qui vous voulez demander', 'Bitte wählen Sie aus, wer Sie fragen möchten', 'Si prega di selezionare chi vuoi chiedere', 'Por favor, selecione quem você quer perguntar', 'Пожалуйста, выберите, кто вы хотите спросить', 'Por favor, seleccione a quien desea preguntar', 'Lütfen kimi sormak istediğinizi seçin'),
(1961, 'asked_you_a_question', '', 'asked you a question', 'طلب منك سؤال', 'vroeg je een vraag', 'vous a posé une question', 'fragte dir eine Frage', 'ti ha fatto una domanda', 'Perguntou uma pergunta', 'задал вам вопрос', 'te hizo una pregunta', 'Sana bir soru sordu'),
(1962, 'trending_questions', '', 'Trending Questions', 'أسئلة تتجه', 'Vragen', 'Questions de tendance', 'Fragen zum Trend', 'Domande di tendenza', 'Perguntas de tendência', 'Тенденция вопросов', 'Preguntas de tendencia', 'Trending soruları'),
(1963, 'people_liked_question', '', 'People liked this question', 'الناس يحبون هذا السؤال', 'Mensen vonden deze vraag leuk', 'Les gens ont aimé cette question', 'Die Leute haben diese Frage gefallen', 'Alla gente è piaciuta questa domanda', 'As pessoas achou desta pergunta', 'Людям понравился этот вопрос', 'A la gente le gustó esta pregunta', 'İnsanlar bu soruyu sevdim'),
(1964, 'users_liked_answer', '', 'People liked this answer', 'الناس يحبون هذه الإجابة', 'Mensen vonden dit antwoord leuk', 'Les gens ont aimé cette réponse', 'Die Leute haben diese Antwort mochten', 'Alla gente è piaciuta questa risposta', 'As pessoas gostavam dessa resposta', 'Людям понравился этот ответ', 'A la gente le gusta esta respuesta', 'İnsanlar bu cevabı beğendi'),
(1965, 'no_answers_found', '', 'No answers to show', 'لا إجابات لإظهار', 'Geen antwoorden om te laten zien', 'Aucune réponse à montrer', 'Keine Antworten zu zeigen', 'Nessuna risposta da mostrare', 'Sem respostas para mostrar', 'Нет ответов на показать', 'No hay respuestas para mostrar', 'Göstermede cevap yok'),
(1966, 'search_header_people', '', 'Search for people and #hashtags', 'البحث عن الناس و #hashtags', 'Zoek naar mensen en #hashtags', 'Rechercher des personnes et #hashtags', 'Suche nach Personen und #hashtags', 'Cerca persone e #hashtags', 'Procurar pessoas e #hashtags', 'Поиск людей и #hashtags', 'Búsqueda de personas y #hashtags', 'İnsanları arayın ve #hashtags'),
(1967, 'tweets', '', 'Tweets', 'التغريدات', 'Tweets', 'Tweet', 'Tweets', 'Tweets.', 'Tweets.', 'Твиты', 'Tweets', 'Tweet'),
(1968, 'trending_tweets', '', 'Trending Tweets', 'تتجه تغريدات', 'Trending tweets', 'Tweets de tendance', 'Trending-Tweets.', 'Trending Tweet.', 'Tendências Tweets.', 'Трендовые твиты', 'Tweets de tendencia', 'Trend Tweetler'),
(1969, 'people_liked_tweet', '', 'People liked this tweet', 'الناس يحبون هذه التغريدة', 'Mensen vonden deze tweet leuk', 'Les gens ont aimé ce tweet', 'Die Leute haben diesen Tweet', 'A gente è piaciuto questo tweet', 'As pessoas gostavam desse tweet', 'Люди понравилось этот твит', 'A la gente le gustó este tweet', 'İnsanlar bu tweet&#039;i sevdim'),
(1970, 'liked_tweet', '', 'liked your tweet', 'أحب تغريدك', 'vond je tweet leuk', 'aimé ton tweet', 'mochte deinen Tweet', 'Mi è piaciuto il tuo Tweet.', 'gostou do seu tweet', 'понравился твой твит', 'Me gustó su Tweet', 'Tweet&#039;ini beğendim'),
(1971, 'please_select_a_file_to_upload', '', 'Please select a file to upload', 'يرجى تحديد ملف لتحميل', 'Selecteer een bestand om te uploaden', 'Veuillez sélectionner un fichier à télécharger', 'Bitte wählen Sie eine Datei zum Hochladen aus', 'Si prega di selezionare un file da caricare', 'Por favor, selecione um arquivo para carregar', 'Пожалуйста, выберите файл для загрузки', 'Por favor seleccione un archivo para cargar', 'Lütfen yüklenecek bir dosya seçin'),
(1972, 'unlock_content_post_text', '', 'Unlock this content by becoming a patron', 'فتح هذا المحتوى من خلال أن تصبح راعي', 'Ontgrendel deze inhoud door een patroon te worden', 'Déverrouillez ce contenu en devenant un client', 'Entsperren Sie diesen Inhalt, indem Sie ein Patron werden', 'Sblocca questo contenuto diventando un patrono', 'Desbloquear este conteúdo tornando-se um patrono', 'Разблокировать этот контент, становясь покровителем', 'Desbloquee este contenido convirtiéndose en un patrón', 'Patron olarak bu içeriğin kilidini aç'),
(1973, 'join_now', '', 'Join now', 'نضم الان', 'Lid worden', 'Adhérer maintenant', 'Jetzt beitreten', 'Iscriviti adesso', 'Entrar', 'Присоединяйся сейчас', 'Únete ahora', 'Şimdi Katıl'),
(1974, 'patreon_membership_price', '', 'Patreon membership price', 'باتريون عضوية السعر', 'Patrum-lidmaatschap Prijs', 'Prix ​​d&#039;adhésion de Patreon', 'Patreon-Mitgliedschaftspreis.', 'Prezzo di appartenenza Patreon.', 'Preço de associação de Patreon', 'PATREON Членство Цена', 'Membresía patreon Price', 'Patreon üyelik Fiyat'),
(1975, 'add_new_experience', '', 'Add New Experience', 'إضافة تجربة جديدة', 'Voeg nieuwe ervaring toe', 'Ajouter une nouvelle expérience', 'Neue Erfahrung hinzufügen', 'Aggiungi una nuova esperienza', 'Adicionar nova experiência', 'Добавить новый опыт', 'Añadir nueva experiencia', 'Yeni Deneyim Ekle'),
(1976, 'company_name', '', 'Company name', 'اسم الشركة', 'Bedrijfsnaam', 'Nom de la compagnie', 'Name der Firma', 'Nome della ditta', 'Nome da empresa', 'Название компании', 'Nombre de empresa', 'Şirket Adı'),
(1977, 'employment_type', '', 'Employment type', 'نوع الوظيفة', 'Type werkgelegenheid', 'Type d&#039;emploi', 'Beschäftigungsverhältnis', 'Tipo di impiego', 'Tipo de Emprego', 'Вид трудоустройства', 'Tipo de empleo', 'İstihdam Tipi'),
(1978, 'self_employed', '', 'Self employed', 'العاملون لحسابهم الخاص', 'Eigen baas', 'Travailleur indépendant', 'Selbstständiger', 'Lavoratore autonomo', 'Trabalhadores por conta própria', 'Частный предприниматель', 'Trabajadores por cuenta propia', 'Kendi işinde çalışan'),
(1979, 'freelance', '', 'Freelance', 'حسابهم الخاص', 'Freelance', 'Free-lance', 'Freiberuflich', 'Libero professionista', 'Freelance', 'Внештатный', 'Lanza libre', 'Serbest'),
(1980, 'apprenticeship', '', 'Apprenticeship', 'فترة التدريب في المهنة', 'Stage', 'Apprentissage', 'Ausbildung', 'Apprendistato', 'Aprendizagem', 'Ученичество', 'Aprendizaje', 'Çıraklık'),
(1981, 'seasonal', '', 'Seasonal', 'موسمي', 'Seizoensgebonden', 'Saisonnier', 'Saisonal', 'di stagione', 'Sazonal', 'Сезонный', 'Estacional', 'Mevsimlik'),
(1982, 'industry', '', 'Industry', 'صناعة', 'Industrie', 'Industrie', 'Industrie', 'Industria', 'Indústria', 'Промышленность', 'Industria', 'Sanayi'),
(1983, 'title_empty', '', 'Please enter a title', 'الرجاء إدخال عنوان', 'Voer een titel in', 'S&#039;il vous plaît entrer un titre', 'Bitte geben Sie einen Titel ein', 'Si prega di inserire un titolo', 'Por favor, insira um título', 'Пожалуйста, введите название', 'Por favor ingrese un título', 'Lütfen bir başlık girin'),
(1984, 'company_name_empty', '', 'Please enter a company name', 'الرجاء إدخال اسم الشركة', 'Voer een bedrijfsnaam in', 'S&#039;il vous plaît entrer un nom d&#039;entreprise', 'Bitte geben Sie einen Firmennamen ein', 'Si prega di inserire un nome aziendale', 'Por favor, insira um nome da empresa', 'Пожалуйста, введите название компании', 'Por favor ingrese un nombre de la empresa', 'Lütfen bir şirket adını girin'),
(1985, 'employment_type_empty', '', 'Please enter a employment type', 'الرجاء إدخال نوع العمالة', 'Voer een werkgelegenheidstype in', 'S&#039;il vous plaît entrer un type d&#039;emploi', 'Bitte geben Sie einen Beschäftigungsart ein', 'Si prega di inserire un tipo di occupazione', 'Por favor, insira um tipo de emprego', 'Пожалуйста, введите тип занятости', 'Por favor ingrese un tipo de empleo', 'Lütfen bir iş türü girin'),
(1986, 'location_empty', '', 'Please enter a location', 'الرجاء إدخال الموقع', 'Voer een locatie in', 'S&#039;il vous plaît entrer un emplacement', 'Bitte geben Sie einen Ort ein', 'Si prega di inserire una posizione', 'Por favor, digite um local', 'Пожалуйста, введите место', 'Por favor ingrese una ubicación', 'Lütfen bir yer girin'),
(1987, 'start_date_empty', '', 'Please enter a start date', 'الرجاء إدخال تاريخ البدء', 'Voer een startdatum in', 'S&#039;il vous plaît entrer une date de début', 'Bitte geben Sie ein Startdatum ein', 'Si prega di inserire una data di inizio', 'Por favor insira uma data de início', 'Пожалуйста, введите дату начала', 'Por favor ingrese una fecha de inicio', 'Lütfen bir başlangıç ​​tarihi girin'),
(1988, 'industry_empty', '', 'Please enter an industry', 'الرجاء إدخال صناعة', 'Voer een industrie in', 'S&#039;il vous plaît entrer dans une industrie', 'Bitte geben Sie eine Branche ein', 'Per favore inserisci un settore', 'Por favor, insira uma indústria', 'Пожалуйста, введите отрасль', 'Por favor ingrese una industria', 'Lütfen bir endüstri girin'),
(1989, 'description_empty', '', 'Please enter a description', 'الرجاء إدخال وصف', 'Voer een beschrijving in', 'S&#039;il vous plaît entrer une description', 'Bitte geben Sie eine Beschreibung ein', 'Si prega di inserire una descrizione', 'Por favor, insira uma descrição', 'Пожалуйста, введите описание', 'Por favor ingrese una descripción', 'Lütfen bir açıklama girin'),
(1990, 'please_choose_correct_experience_date', '', 'Please choose a correct date.', 'يرجى اختيار تاريخ الصحيح.', 'Kies een juiste datum.', 'Veuillez choisir une date correcte.', 'Bitte wählen Sie ein korrektes Datum.', 'Si prega di scegliere una data corretta.', 'Por favor, escolha uma data correta.', 'Пожалуйста, выберите правильную дату.', 'Por favor, elija una fecha correcta.', 'Lütfen doğru bir tarih seçiniz.'),
(1991, 'experience_successfully_created', '', 'Experience successfully created.', 'تجربة تم إنشاؤها بنجاح.', 'Ervaring met succes gemaakt.', 'Expérience créée avec succès.', 'Erfahrung erfolgreich erstellt.', 'Esperienza creata con successo.', 'Experiência criada com sucesso.', 'Опыт успешно создан.', 'Experiencia creada con éxito.', 'Başarıyla yaratılmış deneyim.'),
(1992, 'valid_link', '', 'Please enter a valid link', 'الرجاء إدخال رابط صالح', 'Voer een geldige link in', 'Veuillez entrer un lien valide', 'Bitte geben Sie einen gültigen Link ein', 'Si prega di inserire un link valido', 'Por favor, insira um link válido', 'Пожалуйста, введите правильную ссылку', 'Por favor ingrese un enlace válido', 'Lütfen geçerli bir bağlantı girin'),
(1993, 'delete_your_experience', '', 'Delete your experience', 'حذف تجربتك', 'Verwijder je ervaring', 'Supprimer votre expérience', 'Löschen Sie Ihre Erfahrungen', 'Elimina la tua esperienza', 'Exclua sua experiência', 'Удалить свой опыт', 'Elimina tu experiencia', 'Deneyiminizi Sil'),
(1994, 'are_you_delete_your_experience', '', 'Are you sure you want to delete this experience?', 'هل أنت متأكد أنك تريد حذف هذه التجربة؟', 'Weet je zeker dat je deze ervaring wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer cette expérience?', 'Möchten Sie diese Erfahrung sicher, dass Sie diese Erfahrung löschen möchten?', 'Sei sicuro di voler cancellare questa esperienza?', 'Tem certeza de que deseja excluir essa experiência?', 'Вы уверены, что хотите удалить этот опыт?', '¿Estás seguro de que quieres eliminar esta experiencia?', 'Bu deneyimi silmek istediğinize emin misiniz?'),
(1995, 'edit_experience', '', 'Edit experience', 'تحرير الخبرة', 'Bewerk ervaring', 'Modifier l&#039;expérience', 'Erfahrung bearbeiten.', 'Edit Experience.', 'Editar experiência', 'Опыт редактирования', 'EDITAR EXPERIENCIA', 'Deneyimi düzenle'),
(1996, 'you_not_owner', '', 'You are not the owner, you can apply this action.', 'أنت لست المالك، يمكنك تطبيق هذا الإجراء.', 'U bent niet de eigenaar, u kunt deze actie toepassen.', 'Vous n&#039;êtes pas le propriétaire, vous pouvez appliquer cette action.', 'Sie sind nicht der Besitzer, Sie können diese Aktion anwenden.', 'Non sei il proprietario, puoi applicare questa azione.', 'Você não é o proprietário, você pode aplicar esta ação.', 'Вы не являетесь владельцем, вы можете применить это действие.', 'Usted no es el propietario, puede aplicar esta acción.', 'Sen sahibi değilsin, bu işlemi uygulayabilirsiniz.'),
(1997, 'experience_successfully_updated', '', 'Experience successfully updated.', 'تجربة تم تحديثها بنجاح.', 'Ervaring met succes bijgewerkt.', 'Expérience mise à jour avec succès.', 'Erfahrung erfolgreich aktualisiert.', 'Esperienza aggiornata con successo.', 'Experiência atualizada com sucesso.', 'Опыт успешно обновлен.', 'Experimente con éxito actualizado.', 'Deneyim başarıyla güncellendi.'),
(1998, 'certifications', '', 'Certifications', 'الشهادات', 'Certificeringen', 'Certifications', 'Zertifizierungen', 'Certificazioni', 'Certificações.', 'Сертификация', 'Certificaciones', 'Sertifikalar'),
(1999, 'licenses_certifications', '', 'Licenses &amp; Certificates', 'التراخيص والشهادات', 'Licenties en certificaten', 'Licences et certificats', 'Lizenzen &amp; Zertifikate.', 'Licenze e certificati.', 'Licenças e certificados', 'Лицензии и сертификаты', 'Licencias y Certificados', 'Lisanslar ve Sertifikalar'),
(2000, 'add_new_certification', '', 'Add New Certificate', 'إضافة شهادة جديدة', 'Voeg nieuw certificaat toe', 'Ajouter un nouveau certificat', 'Neues Zertifikat hinzufügen.', 'Aggiungi un nuovo certificato', 'Adicionar novo certificado', 'Добавить новый сертификат', 'Añadir nuevo certificado', 'Yeni sertifika ekle'),
(2001, 'issuing_organization', '', 'Issuing organization', 'مؤسسة إصدار', 'Uitgevende organisatie', 'Organisation émettrice', 'Ausstellende Organisation', 'Organizzazione di emissione', 'Organização emissora', 'Организация выдачи', 'Organización emisora', 'Organizasyon Düzenleyen'),
(2002, 'credential_id', '', 'Credential ID', 'معرف الاعتماد', 'Referent-ID', 'ID de créditif', 'Anmeldeinformations-ID.', 'ID Credenziali', 'ID de credencial', 'Учетные данные ID.', 'ID de credencial', 'Kimlik bilgisi kimliği'),
(2003, 'credential_url', '', 'Credential URL', 'عنوان الاعتماد URL.', 'Referent-url', 'URL de Credential', 'Anmeldeinformations-URL.', 'URL delle credenziali', 'URL de credenciais.', 'УРЛЕЧЕННЫЙ УР', 'URL CREDENCIAL', 'Kimlik bilgisi URL&#039;si'),
(2004, 'issuing_organization_empty', '', 'Please enter an issuing organization', 'الرجاء إدخال مؤسسة إصدار', 'Voer een uitgevende organisatie in', 'S&#039;il vous plaît entrer une organisation émettrice', 'Bitte geben Sie eine ausstellende Organisation ein', 'Si prega di inserire un&#039;organizzazione di emissione', 'Por favor, insira uma organização emissora', 'Пожалуйста, введите организацию выдачи', 'Por favor ingrese una organización emisora', 'Lütfen veren bir organizasyon girin'),
(2005, 'issue_date', '', 'Issue date', 'تاريخ الإصدار', 'Datum van publicatie', 'Date d&#039;émission', 'Ausgabedatum', 'Data di rilascio', 'Data de emissão', 'Дата выпуска', 'Fecha de asunto', 'Düzenleme tarihi'),
(2006, 'expiration_date', '', 'Expiration date', 'تاريخ انتهاء الصلاحية', 'Uiterste houdbaarheidsdatum', 'Date d&#039;expiration', 'Ablaufdatum', 'Data di scadenza', 'Data de validade', 'Дата окончания срока', 'Fecha de caducidad', 'Son kullanma tarihi'),
(2007, 'issue_date_empty', '', 'Please enter the issuing date.', 'الرجاء إدخال تاريخ الإصدار.', 'Voer de uitgifte-datum in.', 'Veuillez entrer la date d&#039;émission.', 'Bitte geben Sie das ausstellende Datum ein.', 'Si prega di inserire la data di emissione.', 'Por favor, insira a data emissora.', 'Пожалуйста, введите дату выдачи.', 'Por favor ingrese la fecha de emisión.', 'Lütfen ihraç tarihini girin.'),
(2008, 'name_empty', '', 'Please enter a name', 'الرجاء إدخال اسم', 'Voer een naam in', 'S&#039;il vous plaît entrer un nom', 'Bitte geben Sie einen Namen ein', 'Si prega di inserire un nome', 'Por favor insira um nome', 'Пожалуйста, введите имя', 'Por favor ingrese un nombre', 'Lütfen bir isim girin'),
(2009, 'certification_successfully_created', '', 'Your certificate has been created.', 'تم إنشاء شهادتك.', 'Uw certificaat is gemaakt.', 'Votre certificat a été créé.', 'Ihr Zertifikat wurde erstellt.', 'Il tuo certificato è stato creato.', 'Seu certificado foi criado.', 'Ваш сертификат был создан.', 'Su certificado ha sido creado.', 'Sertifikanız oluşturuldu.'),
(2010, 'delete_your_certification', '', 'Delete your certificate', 'حذف شهاداتك', 'Verwijder uw certificaat', 'Supprimer votre certificat', 'Löschen Sie Ihr Zertifikat', 'Elimina il tuo certificato', 'Exclua seu certificado', 'Удалить свой сертификат', 'Elimina tu certificado', 'Sertifikanızı Sil'),
(2011, 'are_you_delete_your_certification', '', 'Are you sure you want to delete this certificate?', 'هل أنت متأكد أنك تريد حذف هذه الشهادة؟', 'Weet u zeker dat u dit certificaat wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ce certificat?', 'Möchten Sie dieses Zertifikat sicher löschen?', 'Sei sicuro di voler cancellare questo certificato?', 'Tem certeza de que deseja excluir este certificado?', 'Вы уверены, что хотите удалить этот сертификат?', '¿Está seguro de que desea eliminar este certificado?', 'Bu sertifikayı silmek istediğinize emin misiniz?'),
(2012, 'edit_certification', '', 'Edit Certificate', 'تحرير الشهادة', 'Bewerk certificaat', 'Édition de certificat', 'Zertifikat bearbeiten.', 'Modifica certificato', 'Editar certificado', 'Редактировать сертификат', 'Editar certificado', 'Sertifika Düzenle'),
(2013, 'certification_successfully_updated', '', 'Your certificate has been updated.', 'تم تحديث شهادتك.', 'Uw certificaat is bijgewerkt.', 'Votre certificat a été mis à jour.', 'Ihr Zertifikat wurde aktualisiert.', 'Il tuo certificato è stato aggiornato.', 'Seu certificado foi atualizado.', 'Ваш сертификат был обновлен.', 'Su certificado ha sido actualizado.', 'Sertifikanız güncellendi.'),
(2014, 'projects', '', 'Projects', 'مشاريع', 'Projecten', 'Projets', 'Projekte', 'Progetti', 'Projetos', 'Проекты', 'Proyectos', 'Projeler'),
(2015, 'add_new_project', '', 'Add new project', 'إضافة مشروع جديد', 'Voeg nieuw project toe', 'Ajouter un nouveau projet', 'Neues Projekt hinzufügen', 'Aggiungi un nuovo progetto', 'Adicionar novo projeto', 'Добавить новый проект', 'Añadir nuevo proyecto', 'Yeni Proje Ekle'),
(2016, 'project_name', '', 'Project name', 'اسم المشروع', 'Naam van het project', 'Nom du projet', 'Projektname', 'Nome del progetto', 'Nome do Projeto', 'Название проекта', 'Nombre del proyecto', 'Proje Adı'),
(2017, 'associated_with', '', 'Associated with', 'مرتبط ب', 'Geassocieerd met', 'Associé à', 'Verknüpft mit', 'Associato a', 'Associado com', 'Связан с', 'Asociado con', 'İle ilişkili'),
(2018, 'project_url', '', 'Project URL', 'عنوان المشروع', 'Project URL', 'URL du projet', 'Projekt-URL', 'URL del progetto', 'URL do projeto', 'URL-адрес проекта', 'URL del proyecto', 'Proje URLsi'),
(2019, 'project_successfully_added', '', 'Your project has been added.', 'تمت إضافة مشروعك.', 'Uw project is toegevoegd.', 'Votre projet a été ajouté.', 'Ihr Projekt wurde hinzugefügt.', 'Il tuo progetto è stato aggiunto.', 'Seu projeto foi adicionado.', 'Ваш проект был добавлен.', 'Su proyecto ha sido añadido.', 'Projeniz eklendi.'),
(2020, 'delete_your_project', '', 'Delete your project', 'حذف مشروعك', 'Verwijder uw project', 'Supprimer votre projet', 'Löschen Sie Ihr Projekt', 'Elimina il tuo progetto', 'Exclua seu projeto', 'Удалить свой проект', 'Elimina tu proyecto', 'Projenizi silin'),
(2021, 'are_you_delete_your_project', '', 'Are you sure you want to delete this project?', 'هل أنت متأكد أنك تريد حذف هذا المشروع؟', 'Weet je zeker dat je dit project wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ce projet?', 'Möchten Sie dieses Projekt sicher löschen?', 'Sei sicuro di voler cancellare questo progetto?', 'Tem certeza de que deseja excluir este projeto?', 'Вы уверены, что хотите удалить этот проект?', '¿Está seguro de que desea eliminar este proyecto?', 'Bu projeyi silmek istediğinize emin misiniz?');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(2022, 'edit_project', '', 'Edit Project', 'تحرير المشروع', 'Project bewerken', 'Modifier le projet', 'Projekt bearbeiten.', 'Modifica progetto', 'Editar projeto', 'Редактировать проект', 'Editar proyecto', 'Projeyi Düzenle'),
(2023, 'project_successfully_updated', '', 'Your project has been updated.', 'تم تحديث مشروعك.', 'Uw project is bijgewerkt.', 'Votre projet a été mis à jour.', 'Ihr Projekt wurde aktualisiert.', 'Il tuo progetto è stato aggiornato.', 'Seu projeto foi atualizado.', 'Ваш проект был обновлен.', 'Su proyecto ha sido actualizado.', 'Projeniz güncellendi.'),
(2024, 'skills', '', 'Skills', 'مهارات', 'Vaardigheden', 'Compétences', 'Fähigkeiten', 'Abilità', 'Habilidades', 'Навыки и умения', 'Habilidades', 'Yetenekler'),
(2025, 'languages', '', 'Languages', 'اللغات', 'Talen', 'Langues', 'Sprachen', 'Le lingue', 'línguas', 'Языки', 'Idiomas', 'Diller'),
(2026, 'open_to', '', 'Open To', 'مفتوح ل', 'Open voor', 'Ouvert à', 'Geöffnet für', 'Aperto a', 'Aberto para', 'Открыт кому-либо', 'Abierto a', 'Açmak'),
(2027, 'finding_a_job', '', 'Finding a new job', 'العثور على وظيفة جديدة', 'Een nieuwe baan vinden', 'Trouver un nouvel emploi', 'Einen neuen Job finden', 'Trovare un nuovo lavoro', 'Encontrando um novo emprego', 'Нахождение новой работы', 'Encontrar un nuevo trabajo', 'Yeni bir iş bulmak'),
(2028, 'providing_services', '', 'Providing services', 'تقديم خدمات', 'Het verlenen van diensten', 'Fournissant des services', 'Erbringung von Dienstleistungen', 'Fornitura di servizi', 'Prestação de serviços', 'Предоставление услуг', 'Prestación de servicios', 'Servis sağlama'),
(2029, 'hiring', '', 'Hiring', 'توظيف', 'In dienst nemen', 'Embauche', 'Einstellung', 'Assumere', 'Contratando', 'Нанимать', 'Contratación', 'İşe alıyor'),
(2030, 'add_job_preferences', '', 'Add job preferences', 'إضافة تفضيلات الوظيفة', 'Voeg taakvoorkeuren toe', 'Ajouter des préférences d&#039;emploi', 'Jobeinstellungen hinzufügen', 'Aggiungi preferenze di lavoro', 'Adicionar preferências de emprego', 'Добавить настройки работы', 'Añadir preferencias de trabajo', 'İş Tercihleri ​​Ekleme'),
(2031, 'tell_us_kind_work', '', 'Tell us what kind of work you’re open to', 'أخبرنا أي نوع من العمل المفتوح', 'Vertel ons wat voor soort werk je open bent', 'Dites-nous quel genre de travail vous êtes ouvert à', 'Sagen Sie uns, welche Art von Arbeit Sie offen sind', 'Dicci che tipo di lavoro sei aperto a', 'Diga-nos que tipo de trabalho você está aberto para', 'Расскажите нам, какую работу вы открыты для', 'Dinos qué tipo de trabajo estás abierto a', 'Bize ne tür bir işin açıldığını söyle'),
(2032, 'workplaces', '', 'Workplaces', 'أماكن العمل', 'Werkplekken', 'Lieux de travail', 'Arbeitsplätze.', 'Ambienti di lavoro', 'Locais de trabalho', 'Рабочие места', 'Lugar de trabajo', 'İşyerleri'),
(2034, 'on_site', '', 'On site', 'بالموقع', 'Ter plekke', 'Sur site', 'Vor Ort', 'Sul posto', 'No local', 'На месте', 'En el sitio', 'Yerinde'),
(2035, 'hybrid', '', 'Hybrid', 'هجين', 'Hybride', 'Hybride', 'Hybride', 'Ibrido', 'Híbrido', 'Гибридный', 'Híbrido', 'Hibrit'),
(2036, 'remote', '', 'Remote', 'بعيد', 'Op afstand', 'À distance', 'Fernbedienung', 'A distanza', 'Controlo remoto', 'Дистанционный пульт', 'Remoto', 'Uzak'),
(2037, 'job_types', '', 'Job types', 'أنواع الوظائف', 'Typen', 'Types d&#039;emplois', 'Arbeitstypen', 'Tipi di lavoro', 'Tipos de trabalho.', 'Типы работы', 'Tipos de trabajo', 'İş türleri'),
(2038, 'temporary', '', 'Temporary', 'مؤقت', 'Tijdelijk', 'Temporaire', 'Vorübergehend', 'Temporaneo', 'Temporário', 'Временный', 'Temporal', 'Geçici'),
(2039, 'job_location', '', 'Job location', 'مكان العمل', 'Werklocatie', 'Lieu de travail', 'Arbeitsplatz', 'Luogo di lavoro', 'Local de trabalho', 'Место работы', 'Locación de trabajo', 'İş konumu'),
(2040, 'Job_title_empty', '', 'Job title can not be empty', 'المسمى الوظيفي لا يمكن أن يكون فارغا', 'Functie kan niet leeg zijn', 'Le titre du poste ne peut pas être vide', 'Die Arbeitstitel kann nicht leer sein', 'Il titolo del lavoro non può essere vuoto', 'O cargo não pode estar vazio', 'Название работы не может быть пустым', 'El título del trabajo no puede estar vacío', 'İş unvanı boş olamaz'),
(2041, 'job_location_empty', '', 'Job location can not be empty', 'موقع الوظيفة لا يمكن أن يكون فارغا', 'Werklocatie kan niet leeg zijn', 'L&#039;emplacement du travail ne peut pas être vide', 'Der Jobstandort kann nicht leer sein', 'La posizione del lavoro non può essere vuota', 'Localização do trabalho não pode estar vazia', 'Работа расположение не может быть пустым', 'La ubicación del trabajo no puede estar vacía', 'İş yeri boş olamaz'),
(2042, 'workplaces_empty', '', 'Please select a workplace', 'يرجى اختيار مكان العمل', 'Selecteer een werkplek', 'Veuillez sélectionner un lieu de travail', 'Bitte wählen Sie einen Arbeitsplatz aus', 'Si prega di selezionare un luogo di lavoro', 'Por favor, selecione um local de trabalho', 'Пожалуйста, выберите рабочее место', 'Por favor seleccione un lugar de trabajo', 'Lütfen bir iş yeri seçiniz'),
(2043, 'job_type_empty', '', 'Please select a job type', 'يرجى اختيار نوع الوظيفة', 'Selecteer een taaktype', 'Veuillez sélectionner un type d&#039;emploi', 'Bitte wählen Sie einen Jobtyp aus', 'Si prega di selezionare un tipo di lavoro', 'Por favor, selecione um tipo de trabalho', 'Пожалуйста, выберите тип работы', 'Por favor seleccione un tipo de trabajo', 'Lütfen bir iş türünü seçin'),
(2044, 'job_preferences_saved_successfully', '', 'Job preferences have been updated.', 'تم تحديث تفضيلات الوظيفة.', 'Jobvoorkeuren zijn bijgewerkt.', 'Les préférences d&#039;emploi ont été mises à jour.', 'Die Jobeinstellungen wurden aktualisiert.', 'Le preferenze del lavoro sono state aggiornate.', 'Preferências de emprego foram atualizadas.', 'Настройки работы были обновлены.', 'Las preferencias de trabajo se han actualizado.', 'İş tercihleri ​​güncellendi.'),
(2045, 'open_to_work', '', 'Open to work', 'مفتوحة للعمل', 'Open voor het werk', 'Ouvert au travail', 'Offen für die Arbeit.', 'Aperto al lavoro', 'Aberto para o trabalho', 'Открыт для работы', 'Abierto al trabajo', 'İşe açık'),
(2046, 'see_all_details', '', 'See all details', 'انظر كل التفاصيل', 'Zie alle details', 'Voir tous les détails', 'Alle Details anzeigen.', 'Vedi tutti i dettagli', 'Veja todos os detalhes', 'Смотрите все детали', 'Ver todos los detalles', 'Tüm detayları gör'),
(2047, 'job_preferences', '', 'Job preferences', 'تفضيلات الوظيفة', 'Baan voorkeur', 'Préférences d&#039;emploi', 'Stellenpräferenzen', 'Preferenze di lavoro', 'Preferências de trabalho', 'Предпочтения по работе', 'Preferencias de trabajo', 'İş tercihleri'),
(2048, 'set_up_services_page', '', 'Let’s set up your services page', 'دعونا إعداد صفحة الخدمات الخاصة بك', 'Laten we uw servicepagina instellen', 'Configurons votre page Services', 'Lassen Sie uns Ihre Service-Seite einrichten', 'Configura la pagina dei servizi', 'Vamos configurar sua página de serviços', 'Давайте настроим страницу своих услуг', 'Configuremos su página de servicios', 'Hizmetlerinizi ayarlayalım'),
(2049, 'services', '', 'Services', 'خدمات', 'Diensten', 'Prestations de service', 'Dienstleistungen', 'Servizi', 'Serviços', 'Услуги', 'Servicios', 'Hizmetler'),
(2050, 'services_empty', '', 'Services can not be empty', 'الخدمات لا يمكن أن تكون فارغة', 'Services kunnen niet leeg zijn', 'Les services ne peuvent pas être vides', 'Dienste können nicht leer sein', 'I servizi non possono essere vuoti', 'Os serviços não podem ser vazios', 'Услуги не могут быть пустыми', 'Los servicios no pueden estar vacíos.', 'Hizmetler boş olamaz'),
(2051, 'services_saved_successfully', '', 'Services have been saved.', 'تم حفظ الخدمات.', 'Services zijn opgeslagen.', 'Les services ont été enregistrés.', 'Dienstleistungen wurden gespeichert.', 'I servizi sono stati salvati.', 'Serviços foram salvos.', 'Услуги были сохранены.', 'Se han guardado los servicios.', 'Hizmetler kaydedildi.'),
(2052, 'services_provided', '', 'Services provided', 'تقديم خدمات', 'Aangeboden diensten', 'Services fournis', 'Dienstleistungen zur Verfügung gestellt', 'Servizio fornito', 'Serviços prestados', 'Услуги, предоставляемые', 'Servicios prestados', 'Sağlanan Hizmetler'),
(2053, 'invalid_id', '', 'Invalid id', 'بطاقة التعريف غير صالحة', 'Ongeldig identiteitsbewijs', 'ID invalide', 'Ungültige ID', 'ID non valido', 'ID Inválido', 'Неверный ID', 'Identificación invalida', 'Geçersiz kimlik'),
(2054, 'services_edited_successfully', '', 'Services have been updated.', 'تم تحديث الخدمات.', 'Diensten zijn bijgewerkt.', 'Les services ont été mis à jour.', 'Dienstleistungen wurden aktualisiert.', 'I servizi sono stati aggiornati.', 'Serviços foram atualizados.', 'Услуги были обновлены.', 'Se han actualizado los servicios.', 'Hizmetler güncellendi.'),
(2055, 'edit_job_preferences', '', 'Edit job preferences', 'تحرير تفضيلات الوظيفة', 'Bewerk jobvoorkeuren', 'Modifier les préférences d&#039;emploi', 'Jobeinstellungen bearbeiten.', 'Modifica le preferenze del lavoro', 'Editar preferências de emprego', 'Редактировать настройки задания', 'Editar Preferencias de trabajo', 'İş Tercihlerini Düzenle'),
(2056, 'job_preferences_edited_successfully', '', 'Job preferences have been edited.', 'تم تحرير تفضيلات الوظيفة.', 'Werkvoorkeuren zijn bewerkt.', 'Les préférences d&#039;emploi ont été modifiées.', 'Stellenvoreinstellungen wurden bearbeitet.', 'Le preferenze di lavoro sono state modificate.', 'Preferências de emprego foram editadas.', 'Предпочтения рабочих мест были отредактированы.', 'Se han editado las preferencias de trabajo.', 'İş tercihleri ​​düzenlendi.'),
(2057, 'load_more_services', '', 'Load more services', 'تحميل المزيد من الخدمات', 'Laad meer diensten', 'Charger plus de services', 'Mehr Dienstleistungen laden.', 'Carica più servizi', 'Carregue mais serviços', 'Загрузить больше услуг', 'Cargar más servicios', 'Daha fazla hizmet yükleyin'),
(2058, 'tiers', '', 'Tiers', 'tiers.', 'Tijper', 'Niveaux', 'Reihen', 'Livelli', 'Camadas', 'Ящики', 'Gráficos', 'Katmanlar'),
(2059, 'choose_offer_patrons', '', 'Choose what to offer your patrons', 'اختر ما يقدمه رعاةك', 'Kies wat je mecenassen aanbiedt', 'Choisissez quoi offrir vos clients', 'Wählen Sie aus, was Sie Ihren Gästen anbieten sollen', 'Scegli cosa offrire ai tuoi clienti', 'Escolha o que oferecer seus patronos', 'Выберите, что предложить своим покровителям', 'Elige qué ofrecer a tus clientes.', 'Müşterilerinize ne sunacağınızı seçin'),
(2060, 'add_tier', '', 'Add tier', 'إضافة المستوى', 'Voeg tier toe', 'Ajouter un niveau', 'Tier hinzufügen', 'Aggiungi Tier.', 'Adicionar camada', 'Add Tier.', 'Agregar un nivel', 'Katman eklemek'),
(2061, 'tier_title', '', 'Tier title', 'عنوان المستوى', 'Titel titel', 'Titre de niveau', 'Titel Titel', 'Titolo di livello', 'Título do nível', 'Титул уровня', 'Título del nivel', 'Tier başlığı'),
(2062, 'tier_price', '', 'Tier price', 'السعر المستوى', 'Tierprijs', 'Prix ​​de palier', 'Tierpreis', 'Prezzo di livello', 'Preço de camada', 'Уровень цены', 'Precio de nivel', 'Katmanlı Fiyat'),
(2063, 'tier_image', '', 'Tier image', 'صورة المستوى', 'Tier afbeelding', 'Image de niveau', 'Tier-Image', 'Immagine di livello', 'Imagem de camada', 'Образ уровня', 'Imagen de nivel', 'Katmanlı görüntü'),
(2064, 'tier_description', '', 'Tier description', 'وصف الطبقة', 'Tierbeschrijving', 'Description de niveau', 'Tierbeschreibung.', 'Descrizione di livello', 'Descrição da camada', 'Описание уровня', 'Descripción del nivel', 'Tier Açıklama'),
(2065, 'benefits', '', 'Benefits', 'فوائد', 'Voordelen', 'Avantages', 'Leistungen', 'Benefici', 'Benefícios', 'Преимущества', 'Beneficios', 'Faydalar'),
(2066, 'chat_without_audio_video', '', 'Chat without audio and video call', 'دردشة بدون مكالمة صوتية وفيديو', 'Chat zonder audio- en videogesprek', 'Chatter sans appel audio et vidéo', 'Chatten Sie ohne Audio- und Videoanruf', 'Chat senza audio e videochiamata', 'Bate-papo sem chamada de áudio e vídeo', 'Чат без аудио и видео звонка', 'Chat sin audio y videollamada.', 'Ses ve görüntülü arama olmadan sohbet'),
(2067, 'chat_with_audio_without_video', '', 'Chat with audio call and without video call', 'الدردشة مع مكالمة صوتية ودون مكالمة فيديو', 'Chatten met audio-oproep en zonder videogesprek', 'Chattez avec appel audio et sans appel vidéo', 'Chatten Sie mit Audio-Anruf und ohne Videoanruf', 'Chat con audio chiamata e senza videochiamata', 'Bate-papo com chamada de áudio e sem chamada de vídeo', 'Чат со звуковым вызовом и без видеозвонков', 'Chatea con llamada de audio y sin videollamada.', 'Ses araması ile sohbet edin ve görüntülü arama yapmadan'),
(2068, 'chat_without_audio_with_video', '', 'Chat without audio call and with video call', 'الدردشة دون مكالمة صوتية ومع مكالمة الفيديو', 'Chatten zonder audio-oproep en met videogesprek', 'Chattez sans appel audio et avec appel vidéo', 'Chat ohne Audioanruf und mit Videoanruf', 'Chat senza chiamata audio e con videochiamata', 'Bate-papo sem chamada de áudio e com chamada de vídeo', 'Чат без звукового вызова и с видеозвонком', 'Chat sin llamada de audio y con videollamada.', 'Sesli arama olmadan sohbet edin ve görüntülü görüşme'),
(2069, 'chat_with_audio_video', '', 'Chat with audio and video call', 'الدردشة مع مكالمة الصوت والفيديو', 'Chat met audio- en videogesprek', 'Discutez avec un appel audio et vidéo', 'Chat mit Audio- und Videoanruf', 'Chat con audio e videochiamata', 'Bate-papo com chamada de áudio e vídeo', 'Чат с аудио и видеозвонком', 'Chatea con audio y videollamada.', 'Ses ve görüntülü görüşme ile sohbet et'),
(2070, 'chat', '', 'Chat', 'محادثة', 'Chatten', 'Discuter', 'Plaudern', 'Chiacchierata', 'Bate-papo', 'Чат', 'Chat', 'Sohbet etmek'),
(2071, 'live_stream', '', 'Live Stream', 'البث المباشر', 'Livestream', 'Direct', 'Liveübertragung', 'Trasmissione in diretta', 'Transmissão ao vivo', 'Живой поток', 'Corriente', 'Canlı yayın'),
(2072, 'price_empty', '', 'Price can not be empty', 'السعر لا يمكن أن يكون فارغا', 'Prijs kan niet leeg zijn', 'Le prix ne peut pas être vide', 'Der Preis kann nicht leer sein', 'Il prezzo non può essere vuoto', 'O preço não pode estar vazio', 'Цена не может быть пустой', 'El precio no puede estar vacío', 'Fiyat boş olamaz'),
(2073, 'benefits_empty', '', 'Benefits can not be empty', 'الفوائد لا يمكن أن تكون فارغة', 'Voordelen kunnen niet leeg zijn', 'Les avantages ne peuvent pas être vides', 'Vorteile können nicht leer sein', 'I vantaggi non possono essere vuoti', 'Benefícios não podem ser vazios', 'Преимущества не могут быть пустыми', 'Los beneficios no pueden estar vacíos', 'Faydaları boş olamaz'),
(2074, 'please_select_chat_type', '', 'Please select the chat type', 'يرجى اختيار نوع الدردشة', 'Selecteer het chattype', 'Veuillez sélectionner le type de discussion', 'Bitte wählen Sie den Chat-Typ aus', 'Si prega di selezionare il tipo di chat', 'Por favor, selecione o tipo de bate-papo', 'Пожалуйста, выберите тип чата', 'Por favor seleccione el tipo de chat', 'Lütfen sohbet türünü seçin'),
(2075, 'tier_added_successfully', '', 'Tier successfully added', 'تمت إضافة المستوى بنجاح', 'Tier is succesvol toegevoegd', 'Niveau ajouté avec succès', 'Tier erfolgreich hinzugefügt', 'Tier ha aggiunto con successo', 'Camada adicionada com sucesso', 'Успешно добавил уровень', 'Nivel agregado con éxito', 'Tier başarıyla eklendi'),
(2076, 'edit_tier', '', 'Edit tier', 'تحرير المستوى', 'Bewerk tier', 'Modifier le niveau', 'Tier bearbeiten', 'Modifica il livello', 'Editar camada', 'Редактировать уровень', 'Editar nivel', 'Tier Düzenle'),
(2077, 'tier_updated_successfully', '', 'Tier successfully updated', 'tier تم تحديثها بنجاح', 'Tier succesvol bijgewerkt', 'Niveau mis à jour avec succès', 'Tier erfolgreich aktualisiert.', 'Tier aggiornato con successo', 'Camada atualizada com sucesso', 'Успех Успешно обновлен', 'Nivel actualizado con éxito', 'Tier başarıyla güncellendi'),
(2078, 'delete_your_tier', '', 'Delete your tier', 'حذف المستوى الخاص بك', 'Verwijder je tier', 'Supprimer votre niveau', 'Löschen Sie Ihren Tier', 'Elimina il tuo livello', 'Exclua sua camada', 'Удалить свой уровень', 'Elimina tu nivel', 'Seviyeni sil'),
(2079, 'are_you_delete_your_tier', '', 'Are you sure you want to delete this tier?', 'هل أنت متأكد من أنك تريد حذف هذا المستوى؟', 'Weet je zeker dat je deze tier wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ce niveau?', 'Bist du sicher, dass du diesen Tier löschen willst?', 'Sei sicuro di voler cancellare questo livello?', 'Tem certeza de que deseja excluir esta camada?', 'Вы уверены, что хотите удалить этот уровень?', '¿Estás seguro de que quieres eliminar este nivel?', 'Bu kademeyi silmek istediğinize emin misiniz?'),
(2080, 'patron', '', 'Patron', 'كفيل', 'Patroon', 'mécène', 'Patron', 'Patrono', 'Patrono', 'Покровитель', 'Patrón', 'Patron'),
(2081, 'patrons', '', 'Patrons', 'رعاة', 'Patronen', 'Patrons', 'Gönner', 'Patroni', 'Clientes', 'Покровители', 'Patrones', 'Patronlar'),
(2082, 'services_you_may_know', '', 'Services you may like', 'الخدمات التي قد ترغب', 'Diensten die je misschien leuk vindt', 'Services que vous pouvez aimer', 'Dienstleistungen, die Sie mögen', 'Servizi che potrebbero piacere', 'Serviços que você pode gostar', 'Услуги, которые вы можете понравиться', 'Servicios que te guste', 'Beğenebileceğiniz hizmetler'),
(2083, 'open_to_work_posts', '', 'Open to work posts', 'مفتوحة لمشاركات العمل', 'Open voor werkpalen', 'Ouvert aux postes de travail', 'Offen für Arbeitsbeiträge', 'Aperto ai posti di lavoro', 'Aberto para postos de trabalho', 'Открыть для работы посты', 'Abierto a publicaciones de trabajo', 'İş gönderilerine açık'),
(2084, 'Afrikaans_af', '', 'Afrikaans', 'الأفريكان', 'Afrikaans', 'afrikaans', 'Afrikaans', 'afrikaans', 'afrikaans', 'африкаанс', 'africaans', 'AfrikaAlılar'),
(2085, 'Albanian_sq', '', 'Albanian', 'الألبانية', 'Albanees', 'albanais', 'albanisch', 'albanese', 'albanês', 'албанский', 'albanés', 'Arnavut'),
(2086, 'Amharic_am', '', 'Amharic', 'الأمهرية', 'Amharisch', 'Amharique', 'Amharisch', 'Amharic.', 'Amharic.', 'Amharic', 'Amárico', 'Amhar'),
(2087, 'Arabic_ar', '', 'Arabic', 'عربى', 'Arabisch', 'arabe', 'Arabisch', 'Arabo', 'árabe', 'арабский', 'Arábica', 'Arapça'),
(2088, 'Aragonese_an', '', 'Aragonese', 'aragonese.', 'Aragonese', 'Aragonais', 'Aragonesen', 'aragonese', 'Aragonês', 'Арагонский', 'aragonés', 'Aragonca'),
(2089, 'Armenian_hy', '', 'Armenian', 'الأرمن', 'Armeens', 'arménien', 'Armenisch', 'armeno', 'Armênio', 'Армянский язык', 'armenio', 'Ermeni'),
(2090, 'Asturian_ast', '', 'Asturian', 'الأسترية', 'Asturisch', 'Asturian', 'Asturianisch', 'Asturiano', 'Astúria', 'Астурский', 'asturiano', 'Asturyalı'),
(2091, 'Azerbaijani_az', '', 'Azerbaijani', 'أذربيجاني', 'Azerbeidzjani', 'azerbaïdjanais', 'Aserbaidschani.', 'Azerbaijani.', 'Azerbaijani.', 'Азербайджан', 'Azerbaiyano', 'Azerbaycan'),
(2092, 'Basque_eu', '', 'Basque', 'الباسك', 'baskisch', 'basque', 'baskisch', 'Basco', 'Basque.', 'Баскский', 'vasco', 'Baskın'),
(2093, 'Belarusian_be', '', 'Belarusian', 'البيلاروسية', 'Wit-Russisch', 'Biélorusse', 'Belarussisch', 'Bielorusso', 'Bielorrusso', 'Белорусский', 'Bielorruso', 'Belarusça'),
(2094, 'Bengali_bn', '', 'Bengali', 'البنغالية', 'Bengaals', 'bengali', 'Bengali', 'bengalese', 'bengali', 'Бенгальский', 'bengalí', 'Bengal'),
(2095, 'Bosnian_bs', '', 'Bosnian', 'البوسنة', 'Bosnisch', 'Bosniaque', 'bosnisch', 'Bosniaco', 'Bósnio', 'Боснийский', 'bosnio', 'Boşnakça'),
(2096, 'Breton_br', '', 'Breton', 'بريتون', 'Breton', 'Breton', 'Bretonisch', 'bretone', 'Bretão', 'Бретон', 'Bretón', 'Breton'),
(2097, 'Bulgarian_bg', '', 'Bulgarian', 'البلغارية', 'Bulgaars', 'bulgare', 'bulgarisch', 'bulgaro', 'búlgaro', 'болгарский', 'búlgaro', 'Bulgarca'),
(2098, 'Catalan_ca', '', 'Catalan', 'الكاتالونية', 'Catalaans', 'catalan', 'katalanisch', 'catalano', 'catalão', 'Каталон', 'catalán', 'Katalanca'),
(2099, 'Central Kurdish_ckb', '', 'Central Kurdish', 'كردي المركزي', 'Centraal koerdisch', 'Kurde central', 'Zentralkurdish.', 'Kurdish centrale.', 'Curdo central', 'Центральный курдский', 'Kurdo central', 'Orta Kürtçe'),
(2100, 'Chinese_zh', '', 'Chinese', 'صينى', 'Chinese', 'chinois', 'Chinesisch', 'Cinese', 'chinês', 'китайский язык', 'chino', 'Çince'),
(2101, 'Corsican_co', '', 'Corsican', 'كورسيكان', 'Corsicaans', 'Corse', 'Korsikan', 'Corsican.', 'Corsicana', 'Corsican.', 'corso', 'Korsikalı'),
(2102, 'Croatian_hr', '', 'Croatian', 'الكرواتية', 'Kroatisch', 'croate', 'kroatisch', 'croato', 'croata', 'хорватский', 'croata', 'Hırvat'),
(2103, 'Czech_cs', '', 'Czech', 'جمهورية التشيك', 'Tsjechisch', 'tchèque', 'Tschechisch', 'ceco', 'Checo', 'чешский язык', 'checo', 'Çek'),
(2104, 'Danish_da', '', 'Danish', 'دانماركي', 'Deens', 'danois', 'dänisch', 'danese', 'dinamarquês', 'Датский', 'danés', 'Danimarkalı'),
(2105, 'Dutch_nl', '', 'Dutch', 'هولندي', 'Nederlands', 'néerlandais', 'Niederländisch', 'olandese', 'holandês', 'нидерландский язык', 'holandés', 'Flemenkçe'),
(2106, 'English_en', '', 'English', 'إنجليزي', 'Engels', 'Anglais', 'Englisch', 'inglese', 'inglês', 'английский', 'inglés', 'ingilizce'),
(2107, 'Esperanto_eo', '', 'Esperanto', 'الإسبرانتو', 'Esperanto', 'espéranto', 'Esperanto', 'esperanto', 'esperanto', 'эсперанто', 'esperanto', 'Esperanto'),
(2108, 'Estonian_et', '', 'Estonian', 'إستونيا', 'Estlands', 'estonien', 'estnisch', 'Estone', 'estoniano', 'эстонский', 'Estonio', 'Estonyalı'),
(2109, 'Faroese_fo', '', 'Faroese', 'الفارويز', 'Farroom', 'Farsee', 'Faroese', 'Faroese', 'Faroese.', 'Faroese.', 'Feroz', 'Faroese'),
(2110, 'Filipino_fil', '', 'Filipino', 'الفلبينية', 'Filipijns', 'Philippin', 'Philippinisch', 'Filippino', 'Filipino.', 'Филиппинс', 'Filipino', 'Filipo'),
(2111, 'Finnish_fi', '', 'Finnish', 'الفنلندية', 'Fins', 'finlandais', 'finnisch', 'finlandese', 'finlandês', 'Финский', 'finlandés', 'Fince'),
(2112, 'French_fr', '', 'French', 'فرنسي', 'Frans', 'français', 'Französisch', 'francese', 'francês', 'Французский', 'francés', 'Fransızca'),
(2113, 'Galician_gl', '', 'Galician', 'الجاليكية', 'Galicisch', 'Galicien', 'galizisch', 'galiziano', 'Galego', 'Галицкий', 'gallego', 'Galerici'),
(2114, 'Georgian_ka', '', 'Georgian', 'جورجيا', 'Georgisch', 'géorgien', 'georgisch', 'georgiano', 'Georgiano', 'Грузин', 'georgiano', 'Gürcüce'),
(2115, 'German_de', '', 'German', 'ألمانية', 'Duits', 'allemand', 'Deutsch', 'Tedesco', 'alemão', 'Немецкий', 'alemán', 'Almanca'),
(2116, 'Greek_el', '', 'Greek', 'اليونانية', 'Grieks', 'grec', 'griechisch', 'greco', 'grego', 'Греческий', 'griego', 'Yunan'),
(2117, 'Guarani_gn', '', 'Guarani', 'غواراني', 'Guarani', 'Guarani', 'Guarani.', 'Guarani', 'Guarani.', 'Гуарани', 'Guaraní', 'Guarani'),
(2118, 'Gujarati_gu', '', 'Gujarati', 'الغوجاراتاتي', 'Gujarati', 'Gujarati', 'Gujarati', 'Gujarati.', 'Gujarati.', 'Гуджарати', 'Gujarati', 'Gujarati'),
(2119, 'Hausa_ha', '', 'Hausa', 'هوسا', 'Hausa', 'Hausa', 'Hausa.', 'Hausa.', 'Hausa.', 'Hausa', 'Hausa', 'Hausa'),
(2120, 'Hawaiian_haw', '', 'Hawaiian', 'هاواي', 'Hawaiiaans', 'hawaïen', 'hawaiisch', 'hawaiano', 'havaiano', 'Гавайский язык', 'hawaiano', 'Hawaii'),
(2121, 'Hebrew_he', '', 'Hebrew', 'اللغة العبرية', 'Hebreeuws', 'hébreu', 'hebräisch', 'ebraico', 'hebraico', 'иврит', 'hebreo', 'İbranice'),
(2122, 'Hindi_hi', '', 'Hindi', 'اللغة الهندية', 'Hindi', 'hindi', 'Hindi', 'hindi', 'hindi', 'хинди', 'hindi', 'Hintçe'),
(2123, 'Hungarian_hu', '', 'Hungarian', 'المجر', 'Hongaars', 'hongrois', 'ungarisch', 'ungherese', 'húngaro', 'Венгерский', 'húngaro', 'Macarca'),
(2124, 'Icelandic_is', '', 'Icelandic', 'الأيسلاندية', 'IJslands', 'islandais', 'isländisch', 'islandese', 'islandês', 'исландский', 'islandés', 'İzlandaca'),
(2125, 'Indonesian_id', '', 'Indonesian', 'إندونيسي', 'Indonesisch', 'indonésien', 'Indonesisch', 'indonesiano', 'indonésio', 'индонезийский', 'indonesio', 'Endonezyacı'),
(2126, 'Interlingua_ia', '', 'Interlingua', 'Interlingua.', 'Interlingua', 'Interlingua', 'Interlingua', 'Interlingua.', 'Interlíngua', 'Interlingua', 'Interlingua', 'İnterlingua'),
(2127, 'Irish_ga', '', 'Irish', 'الأيرلندية', 'Iers', 'irlandais', 'irisch', 'irlandesi', 'irlandês', 'Ирландский', 'irlandesa', 'İrlandalı'),
(2128, 'Italian_it', '', 'Italian', 'الإيطالية', 'Italiaans', 'italien', 'Italienisch', 'italiano', 'italiano', 'Итальянский', 'italiano', 'İtalyan'),
(2129, 'Japanese_ja', '', 'Japanese', 'اليابانية', 'Japans', 'Japonais', 'japanisch', 'giapponese', 'japonês', 'японский язык', 'japonés', 'Japonca'),
(2130, 'Kannada_kn', '', 'Kannada', 'كانادا', 'Kannada', 'Kannada', 'Kannada.', 'Kannada.', 'Kannada', 'Канада', 'Kannada', 'Kannada'),
(2131, 'Kazakh_kk', '', 'Kazakh', 'كازاخستان', 'Kazachs', 'Kazakh', 'Kasakh.', 'Kazako.', 'Cazaque', 'Казахский', 'Kazakh', 'Kazak'),
(2132, 'Khmer_km', '', 'Khmer', 'الخمير', 'Khmer', 'Khmer', 'Khmer', 'Khmer.', 'Khmer.', 'К кхмерам', 'Khmer', 'Khmer'),
(2133, 'Korean_ko', '', 'Korean', 'الكورية', 'Koreaans', 'coréen', 'Koreanisch', 'coreano', 'coreano', 'корейский язык', 'coreano', 'Koreli'),
(2134, 'Kurdish_ku', '', 'Kurdish', 'كردي', 'Koerdisch', 'kurde', 'kurdisch', 'Kurdo', 'curdo', 'Курдский', 'kurdo', 'Kürt'),
(2135, 'Kyrgyz_ky', '', 'Kyrgyz', 'قيرغيزستان', 'Kirgizië', 'Kirghize', 'Kirgisisch', 'Kirghiz', 'Quirguistão', 'Кыргыз', 'Kirguisa', 'Kırgız'),
(2136, 'Lao_lo', '', 'Lao', 'لاو', 'Lao', 'Lao', 'Lao.', 'Lao.', 'Lao.', 'Лаос', 'Lao', 'Lao'),
(2137, 'Latin_la', '', 'Latin', 'اللاتينية', 'Latijns', 'Latin', 'Latein', 'latino', 'Latino', 'латинский', 'latín', 'Latince'),
(2138, 'Latvian_lv', '', 'Latvian', 'اللاتفية', 'Letland', 'letton', 'lettisch', 'lettone', 'letão', 'латышский язык', 'letón', 'Letonyalı'),
(2139, 'Lingala_ln', '', 'Lingala', 'لينغالا', 'Lingala', 'Lingala', 'Lingala', 'Lingala.', 'Lingala.', 'Лингла', 'Lingala', 'Lingala'),
(2140, 'Lithuanian_lt', '', 'Lithuanian', 'اللتوانية', 'Litouws', 'lituanien', 'litauisch', 'Lituano', 'lituano', 'Литовский', 'lituano', 'Litvanyalı'),
(2141, 'Macedonian_mk', '', 'Macedonian', 'مقدونيان', 'Macedonisch', 'Macédonien', 'mazedonisch', 'macedone', 'Macedônio', 'македонский', 'macedónio', 'Makedonyalı'),
(2142, 'Malay_ms', '', 'Malay', 'لغة الملايو', 'Maleis-', 'malais', 'malaiisch', 'malese', 'malaio', 'малайский', 'malayo', 'Malay'),
(2143, 'Malayalam_ml', '', 'Malayalam', 'المالايالام', 'Malayalam', 'Malayalam', 'Malayalam', 'Malayalam.', 'Malayalam.', 'Малаялам', 'Malayalam', 'Malayalam'),
(2144, 'Maltese_mt', '', 'Maltese', 'المالطية', 'Maltees', 'maltais', 'maltesisch', 'maltese', 'maltês', 'Мальтий', 'maltés', 'Maltaca'),
(2145, 'Marathi_mr', '', 'Marathi', 'ماراثي', 'Marathi', 'Marathi', 'Marathi', 'Marathi', 'Marathi.', 'Маратхи', 'Marathi', 'Marathi'),
(2146, 'Mongolian_mn', '', 'Mongolian', 'المنغولية', 'Mongools', 'mongol', 'mongolisch', 'mongolo', 'mongol', 'Монгольский язык', 'mongol', 'Moğolca'),
(2147, 'Nepali_ne', '', 'Nepali', 'النيبالي', 'Nepali', 'népalais', 'Nepali.', 'Nepalese', 'Nepali.', 'Непальский', 'Nepalí', 'Nepal'),
(2148, 'Norwegian_no', '', 'Norwegian', 'النرويجية', 'Noors', 'norvégien', 'norwegisch', 'norvegese', 'norueguês', 'Норвежский', 'noruego', 'Norveççe'),
(2149, 'Norwegian Bokmål_nb', '', 'Norwegian Bokmål', 'bokmål النرويجية', 'Norwegian Bokmål', 'Norvégien bokmål', 'Norwegisch Bokmål.', 'Norwegian Bokmål.', 'Bokmål norueguês', 'Норвежский Бокмоль', 'Bokmål noruego', 'Norveç Bokmål'),
(2150, 'Norwegian Nynorsk_nn', '', 'Norwegian Nynorsk', 'Norwegian Nynorsk.', 'Noors Nynorsk', 'Norvégien Nynorsk', 'Norwegisches Nynorsk.', 'Norvegese Nynorsk.', 'Nynorsk norueguês', 'Норвежский Nynorsk.', 'Noruego Nynorsk', 'Norveç Nynorsk'),
(2151, 'Occitan_oc', '', 'Occitan', 'Occitan.', 'Occitaan', 'Occitan', 'Okzitanisch', 'Occitano', 'Occitano', 'Заклинание', 'Occitano', 'Occitan'),
(2152, 'Oriya_or', '', 'Oriya', 'oriya.', 'ORIYA', 'Oriya', 'Oriya.', 'Oriya.', 'Oriya.', 'Ория', 'Oriya', 'Oriya'),
(2153, 'Oromo_om', '', 'Oromo', 'oromo.', 'Oromo', 'Oromo', 'Oromo.', 'Oromo.', 'Oromo', 'Oromo', 'Oromo', 'Orom'),
(2154, 'Pashto_ps', '', 'Pashto', 'البشتونية', 'Pashto', 'Pashto', 'Pashto.', 'Pashto.', 'Pashto.', 'Пашто', 'Pashto', 'Pölye'),
(2155, 'Persian_fa', '', 'Persian', 'اللغة الفارسية', 'Perzisch', 'persan', 'persisch', 'persiano', 'persa', 'Персидский', 'persa', 'Farsça'),
(2156, 'Polish_pl', '', 'Polish', 'تلميع', 'Pools', 'polonais', 'Polieren', 'polacco', 'polonês', 'Польский', 'polaco', 'Lehçe'),
(2157, 'Portuguese_pt', '', 'Portuguese', 'البرتغالية', 'Portugees', 'Portugais', 'Portugiesisch', 'portoghese', 'Português', 'португальский', 'portugués', 'Portekizce'),
(2158, 'Punjabi_pa', '', 'Punjabi', 'بونجابي', 'Punjabi', 'Punjabi', 'Punjabi', 'Punjabi.', 'Punjabi.', 'Пенджаби', 'punjabi', 'Punjabi'),
(2159, 'Quechua_qu', '', 'Quechua', 'quechua.', 'Quechua', 'Quechua', 'Quechua', 'Quechua.', 'Quechua', 'кечуа', 'quechua', 'Quechua'),
(2160, 'Romanian_ro', '', 'Romanian', 'روماني', 'Roemeense', 'roumain', 'rumänisch', 'rumeno', 'romena', 'румынский', 'rumano', 'Romence'),
(2161, 'Romansh_rm', '', 'Romansh', 'الرومانش', 'Romansh', 'Romansh', 'Romansh', 'Romancio', 'Romanês', 'Romansh', 'Romansh', 'Romansh'),
(2162, 'Russian_ru', '', 'Russian', 'الروسية', 'Russisch', 'russe', 'Russisch', 'russo', 'russo', 'русский', 'ruso', 'Rusça'),
(2163, 'Scottish Gaelic_gd', '', 'Scottish Gaelic', 'الغيلية الاسكتلندية', 'Schotse Gaelic', 'Gaélique écossais', 'schottisch Gälisch', 'Gaelico Scozzese', 'gaélico escocês', 'Шотландский гэльс', 'gaélico escocés', 'İskoç gaeli'),
(2164, 'Serbian_sr', '', 'Serbian', 'الصربية', 'Servisch', 'serbe', 'serbisch', 'serbo', 'sérvio', 'сербский', 'serbio', 'Sırpça'),
(2165, 'Serbo_sh', '', 'Serbo', 'صرف', 'Serbo', 'Serbo', 'Serbo.', 'Serbo.', 'Serbo', 'Сердона', 'Serbo', 'Sırp'),
(2166, 'Shona_sn', '', 'Shona', 'شونا', 'Shona', 'Shona', 'Shona.', 'Shona.', 'Shona.', 'Сюжета', 'Shona', 'Shon'),
(2167, 'Sindhi_sd', '', 'Sindhi', 'السندهي', 'Sindhi', 'Sindhi', 'Sindhi.', 'Sindhi.', 'Sindi.', 'Sindhi.', 'Sindhi', 'Sindhi'),
(2168, 'Sinhala_si', '', 'Sinhala', 'السنهالية', 'Sinhala', 'Sinhala', 'Sinhala', 'Singala', 'SINHALA.', 'Синала', 'Sinhala', 'Sinhala'),
(2169, 'Slovak_sk', '', 'Slovak', 'سلوفاكي', 'Slowaaks', 'slovaque', 'slowakisch', 'Slovacco', 'Eslovaco', 'словацкий', 'eslovaco', 'Slovak'),
(2170, 'Slovenian_sl', '', 'Slovenian', 'السلوفينية', 'Sloveens', 'slovène', 'Slowenisch', 'sloveno', 'esloveno', 'словенский', 'esloveno', 'Slovence'),
(2171, 'Somali_so', '', 'Somali', 'الصومالي', 'Somalisch', 'somali', 'somali', 'Somalo', 'Somali.', 'Сомалийский', 'somalí', 'Somali'),
(2172, 'Southern Sotho_st', '', 'Southern Sotho', 'جنوب سوثو', 'Zuidelijke sotho', 'Sotho du sud', 'Südlich sotho.', 'Sothern Sotho.', 'Southern Sotho.', 'Южный Сото', 'Southern Sotho', 'Güney Sotho'),
(2173, 'Spanish_es', '', 'Spanish', 'الأسبانية', 'Spaans', 'Espagnol', 'Spanisch', 'spagnolo', 'espanhol', 'испанский язык', 'español', 'İspanyol'),
(2174, 'Sundanese_su', '', 'Sundanese', 'Sundanese.', 'Sundanese', 'Sundanais', 'Sonnendanese', 'Sundanese.', 'Sundanese', 'Sundanese', 'Sundana', 'Sundanese'),
(2175, 'Swahili_sw', '', 'Swahili', 'السواحيلية', 'Swahili', 'Swahili', 'Swahili', 'Swahili.', 'Swahili.', 'суахили', 'swahili', 'Svahili'),
(2176, 'Swedish_sv', '', 'Swedish', 'السويدية', 'Zweeds', 'suédois', 'Schwedisch', 'svedese', 'sueco', 'Шведский язык', 'sueco', 'İsveççe'),
(2177, 'Tajik_tg', '', 'Tajik', 'طاجيك', 'Tadjik', 'Tajik', 'Tadschik', 'Tajik.', 'Tajik.', 'Таджикский', 'Tajik', 'Tacik'),
(2178, 'Tamil_ta', '', 'Tamil', 'التاميل', 'Tamil', 'Tamil', 'Tamilisch', 'Tamil', 'tâmil', 'Тамил', 'Tamil', 'Tamil'),
(2179, 'Tatar_tt', '', 'Tatar', 'التتار', 'Tatar', 'tatar', 'Tatar.', 'Tatar.', 'Tártaro', 'Татар', 'Tártaro', 'Tatar'),
(2180, 'Telugu_te', '', 'Telugu', 'التيلجو', 'Telugu', 'Telugu', 'Telugu', 'Telugu.', 'Telugu', 'телугу', 'Telugu', 'Telugu'),
(2181, 'Thai_th', '', 'Thai', 'التايلاندية', 'Thais', 'thaïlandais', 'Thailändisch', 'tailandese', 'tailandês', 'Тайский', 'tailandés', 'Tayland'),
(2182, 'Tigrinya_ti', '', 'Tigrinya', 'تيغرينيا', 'Tigrinya', 'Tigrinya', 'Tigrinya.', 'Tigrenya.', 'Tigrya.', 'Тигранья', 'Tigrinosa', 'Tigrinya'),
(2183, 'Tongan_to', '', 'Tongan', 'تونجي', 'Tongan', 'Tongan', 'Tanganer', 'Tongan.', 'Tongania', 'Тонган', 'Tongan', 'Tongan'),
(2184, 'Turkish_tr', '', 'Turkish', 'اللغة التركية', 'Turks', 'turc', 'Türkisch', 'Turco', 'turco', 'турецкий', 'turco', 'Türkçe'),
(2185, 'Turkmen_tk', '', 'Turkmen', 'التركمان', 'Turkmen', 'Turkmène', 'Turkmen', 'Turkmen.', 'Turkmen.', 'туркменский', 'Turkmen', 'Türkmen'),
(2186, 'Twi_tw', '', 'Twi', 'TWI.', 'Twi', 'Twi', 'Twi.', 'Twi.', 'Twi.', 'TWI', 'Twi', 'Twi'),
(2187, 'Ukrainian_uk', '', 'Ukrainian', 'الأوكرانية', 'Oekraïens', 'ukrainien', 'ukrainisch', 'ucraino', 'ucraniano', 'украинец', 'ucranio', 'Ukrayna'),
(2188, 'Urdu_ur', '', 'Urdu', 'الأردية', 'Urdu', 'Ourdou', 'Urdu', 'Urdu', 'urdu', 'Урду', 'Urdu', 'Urdu'),
(2189, 'Uyghur_ug', '', 'Uyghur', 'uyghur.', 'Uyghur', 'Uyghur', 'Uyghur.', 'Uyghur.', 'Uyghur.', 'Уйгур', 'Uyghur', 'Uygur'),
(2190, 'Uzbek_uz', '', 'Uzbek', 'الأوزبكية', 'Oezbeek', 'Uzbek', 'Usbekisch', 'Uzbeko.', 'Uzbeque', 'Узбек', 'Uzbeko', 'Özbekçe'),
(2191, 'Vietnamese_vi', '', 'Vietnamese', 'الفيتنامية', 'Vietnamees', 'vietnamien', 'Vietnamesisch', 'vietnamita', 'vietnamita', 'вьетнамский', 'vietnamita', 'Vietnam'),
(2192, 'Walloon_wa', '', 'Walloon', 'والون', 'Waals', 'Wallon', 'wallonisch', 'Walloon.', 'valão', 'валлонский', 'Valón', 'Valon'),
(2193, 'Welsh_cy', '', 'Welsh', 'تهرب من دفع الرهان', 'Welsh', 'gallois', 'Walisisch', 'gallese', 'galês', 'валлийский', 'galés', 'Gasp'),
(2194, 'Western Frisian_fy', '', 'Western Frisian', 'الغربية فريسيان', 'Westerse Fries', 'Frison occidental', 'Westernfriesian', 'Frisiano occidentale', 'Frísia ocidental', 'Западный фриз', 'Frise occidental', 'Batı friziği'),
(2195, 'Xhosa_xh', '', 'Xhosa', 'Xhosa.', 'Xhosa', 'Xhosa', 'Xhosa.', 'Xhosa.', 'Xhosa.', 'XHOSA', 'Xhosa', 'Xhosa'),
(2196, 'Yiddish_yi', '', 'Yiddish', 'اليديشية', 'Jiddisch', 'yiddish', 'Jiddisch', 'yiddish', 'Iídiche', 'идиш', 'yídish', 'Yidiş'),
(2197, 'Yoruba_yo', '', 'Yoruba', 'يوروبا', 'Yoruba', 'Yoruba', 'Yoruba.', 'Yoruba.', 'Yoruba.', 'Йоруба', 'Yoruba', 'Yoruba'),
(2198, 'Zulu_zu', '', 'Zulu', 'الزولو', 'Zulu', 'zoulou', 'Zulu-', 'Zuli.', 'zulu', 'Zulu', 'zulú', 'Zulu'),
(2199, 'no_available_data', '', 'No available data to show.', 'لا توجد بيانات متاحة لإظهارها.', 'Geen beschikbare gegevens om te laten zien.', 'Aucune donnée disponible à afficher.', 'Keine verfügbaren Daten zum Anzeigen.', 'Nessun dato disponibile da mostrare.', 'Não há dados disponíveis para mostrar.', 'Нет доступных данных для отображения.', 'No hay datos disponibles para mostrar.', 'Gösterilecek mevcut veri yok.'),
(2200, 'my_wallet_', '', 'My Wallet', 'محفظتي', 'Mijn portemonnee', 'Mon portefeuille', 'Mein Geldbeutel', 'Il mio portafoglio', 'Minha carteira', 'Мой бумажник', 'Mi billetera', 'Cüzdanım'),
(2201, 'you_have_bought_products', '', 'You have bought a product', 'لقد اشتريت منتج', 'Je hebt een product gekocht', 'Vous avez acheté un produit', 'Sie haben ein Produkt gekauft', 'Hai comprato un prodotto', 'Você comprou um produto', 'Вы купили продукт', 'Has comprado un producto', 'Bir ürün aldın'),
(2202, 'sale_products', '', 'Sale products', 'بيع المنتجات', 'Verkoop Producten', 'Vente produits', 'Verkaufsprodukte', 'Prodotti di vendita', 'Produtos de venda', 'Продажа продуктов', 'Venta Products', 'Satış Ürünler'),
(2203, 'entire_site', '', 'Entire Site', 'الموقع بأكمله', 'Gehele site', 'Site entier', 'Ganze Seite', 'Intero sito', 'Site inteiro', 'Весь сайт', 'Todo el sitio', 'Tüm site'),
(2204, 'banned_for_violating', '', 'You were banned for violating our terms of use. Please {contact_us} for more details.', 'لقد حظرت لانتهاك شروط استخدامنا.', 'Je was verbannen voor het schenden van onze gebruiksvoorwaarden.', 'Vous avez été interdit de violer nos conditions d&#039;utilisation.', 'Sie wurden verboten, um unsere Nutzungsbedingungen zu verletzen.', 'Sei stato bannato per aver violato i nostri termini di utilizzo.', 'Você foi banido por violar nossos termos de uso.', 'Вы были запрещены на нарушение наших условий использования.', 'Fuiste prohibido por violar nuestros Términos de uso.', 'Kullanım şartlarımızı ihlal ettiğiniz için yasaklandınız.'),
(2205, 'were_banned_from', '', 'Oops, You were banned from {site_name}', 'عفوا، تم حظرك من {site_name}', 'Oeps, je bent verbannen van {site_name}', 'Oups, vous avez été banni de {Nom de site}', 'Oops, du wurdest von {site_name} gesperrt', 'Oops, sei stato bannato da {sito_name}', 'Oops, você foi banido de {site_name}', 'Упс, вы были запрещены с {site_name}', 'Uy, fuiste prohibido desde {Site_Name}', 'Oops, {sitesi_name} &#039;dan yasaklandınız.'),
(2206, 'contact_us_more_details', '', 'Please {contact_us} for more details.', 'يرجى الاتصال بنا للحصول على مزيد من التفاصيل.', 'Gelieve {CONTACT_US} voor meer informatie.', 'S&#039;il vous plaît {contact_us} pour plus de détails.', 'Bitte {contact_us} für weitere Details.', 'Vi preghiamo di contattarci per maggiori dettagli.', 'Por favor, entre em contato conosco para mais detalhes.', 'Пожалуйста, свяжитесь с нами, для более подробной информации.', 'Por favor, póngase en contacto con nosotros para más detalles.', 'Daha fazla ayrıntı için lütfen {Contact_US}.'),
(2207, 'pdf_file', '', 'Attach PDF File', 'إرفاق ملف pdf', 'Bevestig PDF-bestand', 'Joindre un fichier PDF', 'PDF-Datei anhängen', 'Allega il file PDF.', 'Anexar arquivo PDF.', 'Прикрепите PDF-файл', 'Adjuntar archivo PDF', 'PDF dosyasını ekle'),
(2208, 'certification_file', '', 'Certificate', 'شهادة', 'Certificaat', 'Certificat', 'Zertifikat', 'Certificato', 'Certificado', 'Сертификат', 'Certificado', 'Sertifika'),
(2209, 'are_you_currently_working', '', 'Are you currently working?', 'هل تعمل حاليا؟', 'Werk je momenteel?', 'Travaillez-vous actuellement?', 'arbeitest du gerade?', 'Stai lavorando attualmente?', 'Você está trabalhando atualmente?', 'Вы сейчас работаете?', 'Estas trabajando?', 'Şu anda çalışıyor musun?'),
(2210, 'am_looking_to_work', '', 'No I am looking to work', 'لا أنا أتطلع إلى العمل', 'Nee, ik ben op zoek om te werken', 'Non je cherche à travailler', 'Nein, ich suche ich', 'No, sto cercando di lavorare', 'Não, eu estou olhando para trabalhar', 'Нет, я хочу работать', 'No, estoy buscando trabajar', 'Hayır çalışmak istiyorum'),
(2211, 'am_looking_for_employees', '', 'Yes I am looking for employees', 'نعم أنا أبحث عن الموظفين', 'Ja, ik ben op zoek naar werknemers', 'Oui je cherche des employés', 'Ja, ich suche Mitarbeiter', 'Sì, sto cercando dipendenti', 'Sim estou procurando funcionários', 'Да, я ищу сотрудников', 'Si estoy buscando empleados', 'Evet çalışanları arıyorum'),
(2212, 'products_for_sale', '', 'Products for sale', 'منتجات للبيع', 'Producten te koop', 'Produits à vendre', 'Produkte zum Verkauf.', 'Prodotti in vendita.', 'Produtos para venda', 'Продается продукты', 'Productos en venta', 'Satılık ürünler'),
(2213, 'your_notifications_because_you_were_banned', '', 'You can&#039;t view your notifications because you were banned', 'لا يمكنك عرض الإخطارات الخاصة بك لأنك تم حظرك', 'Je kunt je meldingen niet bekijken omdat je bent verbannen', 'Vous ne pouvez pas voir vos notifications parce que vous avez été banni', 'Sie können Ihre Benachrichtigungen nicht anzeigen, weil Sie gesperrt wurden', 'Non puoi vedere le tue notifiche perché sei stato bannato', 'Você não pode ver suas notificações porque você foi banido', 'Вы не можете просматривать ваши уведомления, потому что вы были запрещены', 'No puedes ver tus notificaciones porque estabas prohibido', 'Bildirimlerinizi göremezsiniz çünkü yasaklandınız'),
(2214, 'your_messages_because_you_were_banned', '', 'You can&#039;t view your messages because you were banned', 'لا يمكنك عرض رسائلك لأنك تم حظرك', 'Je kunt je berichten niet bekijken omdat je bent verbannen', 'Vous ne pouvez pas voir vos messages parce que vous avez été interdit', 'Sie können Ihre Nachrichten nicht anzeigen, da Sie gesperrt wurden', 'Non puoi visualizzare i tuoi messaggi perché sei stato bannato', 'Você não pode ver suas mensagens porque foi banido', 'Вы не можете просматривать ваши сообщения, потому что вы были запрещены', 'No puedes ver tus mensajes porque estabas prohibido', 'Mesajlarınızı görüntüleyemezsiniz çünkü sen yasaklandın'),
(2215, 'your_requests_because_you_were_banned', '', 'You can&#039;t view your requests because you were banned', 'لا يمكنك عرض طلباتك لأنك تم حظرك', 'Je kunt je verzoeken niet bekijken omdat je bent verbannen', 'Vous ne pouvez pas voir vos demandes parce que vous avez été interdit', 'Sie können Ihre Anfragen nicht anzeigen, weil Sie gesperrt wurden', 'Non puoi visualizzare le tue richieste perché sei stato bannato', 'Você não pode ver seus pedidos porque você foi banido', 'Вы не можете просматривать ваши запросы, потому что вы были запрещены', 'No puedes ver tus peticiones porque estabas prohibido', 'İsteklerinizi göremezsiniz, çünkü sen yasaklandın'),
(2216, 'withdrawal', '', 'Withdrawal', 'انسحاب', 'Opname', 'Retrait', 'Rückzug', 'Ritiro', 'Cancelamento', 'Снятие', 'Retiro', 'Para çekme'),
(2217, 'successfully_received_from', '', 'Money was successfully received from', 'تم استلام الأموال بنجاح من', 'Geld is succesvol ontvangen van', 'L&#039;argent a été reçu avec succès de', 'Geld wurde erfolgreich von erhalten', 'Il denaro è stato ricevuto con successo da', 'Dinheiro foi recebido com sucesso de', 'Деньги были успешно получены от', 'El dinero fue recibido con éxito de', 'Para başarıyla alındı'),
(2218, 'terms_of_use_page', '', '&lt;h4&gt;1- Write your Terms Of Use here.&lt;/h4&gt; <br>      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.          &lt;br&gt;&lt;br&gt;          &lt;h4&gt;2- Random title&lt;/h4&gt;          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '&lt;H4&gt; 1- اكتب شروط الاستخدام الخاصة بك هنا. &lt;/ H4&gt;', '&lt;H4&gt; 1 - Schrijf hier uw gebruiksvoorwaarden. &lt;/ H4&gt;', '&lt;H4&gt; 1- Écrivez vos conditions d&#039;utilisation ici. &lt;/ H4&gt;', '&lt;H4&gt; 1- Schreiben Sie hier Ihre Nutzungsbedingungen. &lt;/ H4&gt;', '&lt;h4&gt; 1- Scrivi i tuoi termini di utilizzo qui. &lt;/ h4&gt;', '&lt;H4&gt; 1- Escreva seus Termos de Uso aqui. &lt;/ H4&gt;', '&lt;H4&gt; 1- Напишите свои условия использования здесь. &lt;/ H4&gt;', '&lt;H4&gt; 1- Escribe tus Términos de uso aquí. &lt;/ H4&gt;', '&lt;H4&gt; 1- Burada kullanım şartlarınızı yazın. &lt;/ h4&gt;');
INSERT INTO `Wo_Langs` (`id`, `lang_key`, `type`, `english`, `arabic`, `dutch`, `french`, `german`, `italian`, `portuguese`, `russian`, `spanish`, `turkish`) VALUES
(2219, 'privacy_policy_page', '', '&lt;h2&gt;Who we are?&lt;/h2&gt; <br>      Provide name and contact details of the data controller. This will typically be your business or you, if you are a sole trader. Where applicable, you should include the identity and contact details of the controller’s representative and/or the data protection officer. <br> <br>      &lt;h2&gt;What information do we collect?&lt;/h2&gt; <br>      Specify the types of personal information you collect, eg names, addresses, user names, etc. You should include specific details on: <br>      how you collect data (eg when a user registers, purchases or uses your services, completes a contact form, signs up to a newsletter, etc) <br>      what specific data you collect through each of the data collection method <br>      if you collect data from third parties, you must specify categories of data and source <br>      if you process sensitive personal data or financial information, and how you handle this <br>      &lt;br&gt;&lt;br&gt; <br>      You may want to provide the user with relevant definitions in relation to personal data and sensitive personal data. <br>      &lt;br&gt;&lt;br&gt; <br>      &lt;h2&gt;How do we use personal information?&lt;/h2&gt; <br>      Describe in detail all the service- and business-related purposes for which you will process data. For example, this may include things like: <br>      personalisation of content, business information or user experience <br>      account set up and administration <br>      delivering marketing and events communication <br>      carrying out polls and surveys <br>      internal research and development purposes <br>      providing goods and services <br>      legal obligations (eg prevention of fraud) <br>      meeting internal audit requirements <br>      &lt;br&gt;&lt;br&gt; <br>      Please note this list is not exhaustive. You will need to record all purposes for which you process personal data. <br>      &lt;br&gt;&lt;br&gt; <br>      &lt;h2&gt;What legal basis do we have for processing your personal data?&lt;/h2&gt; <br>      Describe the relevant processing conditions contained within the GDPR. There are six possible legal grounds: <br>      consent <br>      contract <br>      legitimate interests <br>      vital interests <br>      public task <br>      legal obligation <br>      &lt;br&gt;&lt;br&gt; <br>      Provide detailed information on all grounds that apply to your processing, and why. If you rely on consent, explain how individuals can withdraw and manage their consent. If you rely on legitimate interests, explain clearly what these are. <br>      &lt;br&gt;&lt;br&gt; <br>      If you’re processing special category personal data, you will have to satisfy at least one of the six processing conditions, as well as additional requirements for processing under the GDPR. Provide information on all additional grounds that apply. <br>      &lt;br&gt;&lt;br&gt; <br>      &lt;h2&gt;When do we share personal data?&lt;/h2&gt; <br>      Explain that you will treat personal data confidentially and describe the circumstances when you might disclose or share it. Eg, when necessary to provide your services or conduct your business operations, as outlined in your purposes for processing. You should provide information on: <br>      how you will share the data <br>      what safeguards you will have in place <br>      what parties you may share the data with and why <br> <br>      &lt;h2&gt;Where do we store and process personal data?&lt;/h2&gt; <br>      If applicable, explain if you intend to store and process data outside of the data subject’s home country. Outline the steps you will take to ensure the data is processed according to your privacy policy and the applicable law of the country where data is located. <br> <br>      If you transfer data outside the European Economic Area, outline the measures you will put in place to provide an appropriate level of data privacy protection. Eg contractual clauses, data transfer agreements, etc. <br> <br>      &lt;h2&gt;How do we secure personal data?&lt;/h2&gt; <br>      Describe your approach to data security and the technologies and procedures you use to protect personal information. For example, these may be measures: <br>      to protect data against accidental loss <br>      to prevent unauthorised access, use, destruction or disclosure <br>      to ensure business continuity and disaster recovery <br>      to restrict access to personal information <br>      to conduct privacy impact assessments in accordance with the law and your business policies <br>      to train staff and contractors on data security <br>      to manage third party risks, through use of contracts and security reviews <br>      &lt;br&gt;&lt;br&gt; <br>      Please note this list is not exhaustive. You should record all mechanisms you rely on to protect personal data. You should also state if your organisation adheres to certain accepted standards or regulatory requirements. <br>      &lt;br&gt;&lt;br&gt; <br>      &lt;h2&gt;How long do we keep your personal data for?&lt;/h2&gt; <br>      Provide specific information on the length of time you will keep the information for in relation to each processing purpose. The GDPR requires you to retain data for no longer than reasonably necessary. Include details of your data or records retention schedules, or link to additional resources where these are published. <br>      &lt;br&gt;&lt;br&gt; <br>      If you cannot state a specific period, you need to set out the criteria you will apply to determine how long to keep the data for (eg local laws, contractual obligations, etc) <br>      &lt;br&gt;&lt;br&gt; <br>      You should also outline how you securely dispose of data after you no longer need it. <br>      &lt;br&gt;&lt;br&gt; <br>      &lt;h2&gt;Your rights in relation to personal data&lt;/h2&gt; <br>      Under the GDPR, you must respect the right of data subjects to access and control their personal data. In your privacy notice, you must outline their rights in respect of: <br>      access to personal information <br>      correction and deletion <br>      withdrawal of consent (if processing data on condition of consent) <br>      data portability <br>      restriction of processing and objection <br>      lodging a complaint with the Information Commissioner’s Office <br> <br>      You should explain how individuals can exercise their rights, and how you plan to respond to subject data requests. State if any relevant exemptions may apply and set out any identity verifications procedures you may rely on. <br> <br>      Include details of the circumstances where data subject rights may be limited, eg if fulfilling the data subject request may expose personal data about another person, or if you’re asked to delete data which you are required to keep by law. <br> <br>      &lt;h2&gt;Use of automated decision-making and profiling&lt;/h2&gt; <br>      Where you use profiling or other automated decision-making, you must disclose this in your privacy policy. In such cases, you must provide details on existence of any automated decision-making, together with information about the logic involved, and the likely significance and consequences of the processing of the individual. <br> <br>      &lt;h2&gt;How to contact us?&lt;/h2&gt; <br>      Explain how data subject can get in touch if they have questions or concerns about your privacy practices, their personal information, or if they wish to file a complaint. Describe all ways in which they can contact you – eg online, by email or postal mail. <br>      &lt;br&gt;&lt;br&gt; <br>      If applicable, you may also include information on: <br>      &lt;br&gt;&lt;br&gt; <br>      &lt;h2&gt;Use of cookies and other technologies&lt;/h2&gt; <br>      You may include a link to further information, or describe within the policy if you intend to set and use cookies, tracking and similar technologies to store and manage user preferences on your website, advertise, enable content or otherwise analyse user and usage data. Provide information on what types of cookies and technologies you use, why you use them and how an individual can control and manage them. <br>      &lt;br&gt;&lt;br&gt; <br>      Linking to other websites / third party content <br>      If you link to external sites and resources from your website, be specific on whether this constitutes endorsement, and if you take any responsibility for the content (or information contained within) any linked website. <br>      &lt;br&gt;&lt;br&gt; <br>      You may wish to consider adding other optional clauses to your privacy policy, depending on your business’ circumstances.', '', '', '', '', '', '', '', '', ''),
(2220, 'about_page', '', '&lt;h4&gt;1- Write about your website here.&lt;/h4&gt;          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.          &lt;br&gt;&lt;br&gt;          &lt;h4&gt;2- Random title&lt;/h4&gt;          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dxzcolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '&lt;h4&gt; 1- اكتب عن موقع الويب الخاص بك هنا. &lt;/ h4&gt; Lorem Ipsum Dolor Sit Amet، Consectedur ALIT ELIT، SED Do Eiusmod Incididund Incididunt UT Labore Et Dolore Magna Aliqua.', '&lt;H4&gt; 1 1 1 Schrijf over uw website hier. &lt;/ H4&gt; Lorem Ipsum Dolor Sit amet, CONTECTOTURE ADIPISICING ELIT, SED DO EIANMOD TRORT INCIDIDUNT UT LABORE et Dolore Magna Aliqua.', '&lt;H4&gt; 1- Écrivez sur votre site web ici. &lt;/ H4&gt; Lorem Ipsum Dolor Sit Amet, Consectetur Adipisuring Elit, SED Do Eiusmod Tempor Incididunt UT Labore et Dolore Magna Aliqua.', '&lt;H4&gt; 1- Schreiben Sie hier über Ihre Website. &lt;/ H4&gt; Lorem Ipsum Dolor Sit AMET, Konsektor-Adipialisierung Elit, SED do EiusMod Tencipe Incididunts Ut Labore et dolore Magna Aliqua.', '&lt;H4&gt; 1- Scrivi del tuo sito web qui. &lt;/ h4&gt; Lorem Ipsum dolor sit Amet, Consectotur addipisicicing Elit, Sed do Eiusmod Timpor Incididunt Ut Labore et dolore Magna Aliqua.', '&lt;H4&gt; 1- Escreva sobre o seu site aqui. &lt;/ H4&gt; Lorem Ipsum Dolor Sente-se Amet, Consectetur Adipisicing Elit, SED DO EUIUSMOD TEMPORAM INCIDURAT UT Labore et Dolore Magna Aliqua.', '&lt;H4&gt; 1- Напишите о своем сайте здесь. &lt;/ H4&gt; Лорема Ipsum Dolor Sit Amet, Consenttur Adipisicing Elit, SED DO EUIUSMOD DEMORE INCIDIDUTTUTT UT LABORE ET DOLORE MAGNA ALIQUA.', '&lt;H4&gt; 1- Escriba sobre su sitio web aquí. &lt;/ h4&gt; lorem ipsum dolors sitt amet, consectetur adipizing elit, sed do eiusmod temporal incididunt UT Labore et Dolore Magna Aliqua.', '&lt;H4&gt; 1- Burada web sitenizi yazın. &lt;/ h4&gt; Lorem Ipsum Dolor Sit Amet, Konsestan Adipising Elit, SED, EIUSMOD TABLOSYONU TÜRKİYETUTT UT Labore et Dolore Magna Aliqua.'),
(2221, 'refund_terms_page', '', '&lt;h4&gt;1- Write your Terms Of Use here.&lt;/h4&gt; <br>      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.          &lt;br&gt;&lt;br&gt;          &lt;h4&gt;2- Random title&lt;/h4&gt;          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '&lt;H4&gt; 1- اكتب شروط الاستخدام الخاصة بك هنا. &lt;/ H4&gt;', '&lt;H4&gt; 1 - Schrijf hier uw gebruiksvoorwaarden. &lt;/ H4&gt;', '&lt;H4&gt; 1- Écrivez vos conditions d&#039;utilisation ici. &lt;/ H4&gt;', '&lt;H4&gt; 1- Schreiben Sie hier Ihre Nutzungsbedingungen. &lt;/ H4&gt;', '&lt;h4&gt; 1- Scrivi i tuoi termini di utilizzo qui. &lt;/ h4&gt;', '&lt;H4&gt; 1- Escreva seus Termos de Uso aqui. &lt;/ H4&gt;', '&lt;H4&gt; 1- Напишите свои условия использования здесь. &lt;/ H4&gt;', '&lt;H4&gt; 1- Escribe tus Términos de uso aquí. &lt;/ H4&gt;', '&lt;H4&gt; 1- Burada kullanım şartlarınızı yazın. &lt;/ h4&gt;'),
(2222, 'added_review_to_your_product', '', 'reviewed your product', 'استعرض المنتج الخاص بك', 'Beoordeeld op uw product', 'examiné votre produit', 'Überprüfte dein Produkt.', 'Recensito il tuo prodotto', 'Avaliou seu produto', 'Пересмотрел ваш продукт', 'revisado su producto', 'Ürününüzü gözden geçirdi'),
(2223, 'coinbase', '', 'Coinbase', 'coinbase.', 'Coinbase', 'Coinbase', 'Coinbase', 'Coinbase', 'Coinbase.', 'Coinbase', 'Coinbase', 'Sikke'),
(2224, 'product_purchase', '', 'Product Purchase', 'شراء المنتج', 'Productaankoop', 'Achat de produit', 'Produktkauf.', 'Acquisto del prodotto', 'Compra de produtos', 'Покупка продукта', 'Compra de productos', 'Ürün satın alma'),
(2225, 'sold_a_product', '', 'Product Sale', 'بيع المنتج', 'Productverkoop', 'Vente de produits', 'Produktverkauf.', 'Vendita del prodotto', 'Venda do produto', 'Продажа продукта', 'Venta de productos', 'Ürün satışı'),
(2226, 'describe_your_review', '', 'Describe your review here..', 'صف رأيك هنا ..', 'Beschrijf hier uw beoordeling ..', 'Décrivez votre avis ici ..', 'Beschreiben Sie Ihre Bewertung hier ..', 'Descrivi la tua recensione qui ..', 'Descreva sua revisão aqui ..', 'Опишите свой обзор здесь ..', 'Describe tu revisión aquí ..', 'Buradaki yorumunuzu açıklayın ..'),
(2227, 'related_prods', '', 'Related Products', 'منتجات ذات صله', 'gerelateerde producten', 'Produits connexes', 'Verwandte Produkte', 'prodotti correlati', 'produtos relacionados', 'сопутствующие товары', 'Productos relacionados', 'ilgili ürünler'),
(2228, 'are_you_delete_open_work', '', 'Are you sure you want to delete?', 'هل أنت متأكد أنك تريد حذف؟', 'Weet je zeker dat je wilt verwijderen?', 'Etes-vous sûr que vous voulez supprimer?', 'Sind Sie sicher, dass Sie löschen möchten?', 'Sei sicuro di voler eliminare?', 'Tem certeza de que deseja excluir?', 'Вы уверены, что хотите удалить?', '¿Estas seguro que quieres borrarlo?', 'Silmek istediğine emin misin?'),
(2229, 'are_you_delete_services', '', 'Are you sure you want to delete these services?', 'هل أنت متأكد أنك تريد حذف هذه الخدمات؟', 'Weet je zeker dat je deze services wilt verwijderen?', 'Êtes-vous sûr de vouloir supprimer ces services?', 'Sind Sie sicher, dass Sie diese Dienste löschen möchten?', 'Sei sicuro di voler cancellare questi servizi?', 'Tem certeza de que deseja excluir esses serviços?', 'Вы уверены, что хотите удалить эти услуги?', '¿Está seguro de que desea eliminar estos servicios?', 'Bu hizmetleri silmek istediğinize emin misiniz?'),
(2230, 'search_find_job_at', '', 'Search, find and apply to job opportunities at', 'البحث، البحث والتقدم بطلب للحصول على فرص العمل في', 'Zoeken, vinden en toepassen op vacatures bij', 'Rechercher, trouver et postuler aux opportunités d&#039;emploi à', 'Suchen, finden und anwenden Sie sich für Stellenangebote an', 'Cerca, trova e applica alle opportunità di lavoro a', 'Pesquisa, encontrar e aplicar às oportunidades de emprego em', 'Поиск, найти и применять к возможностям трудоустройства в', 'Buscar, encontrar y solicitar oportunidades de trabajo en', 'İş fırsatlarını arayın, bulun ve uygulayın'),
(2231, 'connect_with_friends', '', 'Connect with friends!', 'تواصل مع الأصدقاء!', 'Maak verbinding met vrienden!', 'Connectez-vous avec des amis!', 'Verbinden Sie sich mit Freunden!', 'Connettiti con gli amici!', 'Conecte-se com os amigos!', 'Связать с друзьями!', '¡Conecta con amigos!', 'Arkadaşlarla bağlantı kur!'),
(2232, 'login_connect_friends', '', 'Login into your {site_name} account and connect with your friends!', 'تسجيل الدخول إلى حساب {site_name} والاتصال بأصدقائك!', 'Log in op uw {site_name}-account en maak verbinding met je vrienden!', 'Connectez-vous à votre compte {Site_Name} et connectez-vous avec vos amis!', 'Melden Sie sich in Ihr {site_name} Konto an und verbinden Sie sich mit Ihren Freunden!', 'Accedi al tuo account {sito_name} e connettiti con i tuoi amici!', 'Faça o login na sua conta {Site_Name} e conecte-se com seus amigos!', 'Войдите в свою учетную запись {site_name} и подключитесь к друзьям!', 'Inicie sesión en su cuenta {Site_Name} y conecte con sus amigos!', '{Site_Name} hesabınıza giriş yapın ve arkadaşlarınızla iletişim kurun!'),
(2233, 'remember_device', '', 'Remember this device', 'تذكر هذا الجهاز', 'Onthoud dit apparaat', 'Rappelez-vous cet appareil', 'erinnern Sie sich an dieses Gerät', 'Ricorda questo dispositivo', 'Lembre-se deste dispositivo', 'Помните это устройство', 'recuerda este dispositivo', 'Bu cihazı hatırla'),
(2234, 'register_create_account', '', 'Create your {site_name} Account!', 'قم بإنشاء حساب {site_name}!', 'Maak uw {site_name}-account aan!', 'Créez votre compte {Site_Name}!', 'Erstellen Sie Ihr {site_name} Konto!', 'Crea il tuo account {sito_name}!', 'Crie sua conta {Site_Name}!', 'Создайте свою учетную запись {site_name}!', '¡Crea tu cuenta {Site_Name}!', '{Site_NAME} hesabınızı oluşturun!'),
(2235, 'please_upgrade_to_upload', '', 'Just Pro users can upload Please upgrade to pro', 'فقط المستخدمين للمحترفين يمكنهم تحميل الرجاء الترقية إلى الموالية', 'Just Pro-gebruikers kunnen uploaden upgrade naar Pro', 'Just Pro utilisateurs peuvent télécharger s&#039;il vous plaît mettre à niveau vers Pro', 'Nur Pro-Benutzer können hochladen, bitte aktualisieren auf pro', 'Solo gli utenti PRO possono caricare aggiornare a Pro', 'Apenas os usuários pro podem fazer upload, por favor, atualize para pro', 'Просто про пользователи могут загружать пожалуйста, обновите до Pro', 'Sólo los usuarios de PRO pueden subir por favor actualizar a PRO', 'Sadece Pro Kullanıcılar lütfen Pro&#039;ya yükseltebilir'),
(2236, 'type_something_to_post', '', 'Your post content can&#039;t be empty.', 'لا يمكن أن يكون محتوى المنشور فارغا.', 'Uw post-inhoud kan niet leeg zijn.', 'Votre contenu post ne peut pas être vide.', 'Ihr Postinhalt kann nicht leer sein.', 'Il tuo contenuto del post non può essere vuoto.', 'Seu conteúdo de postagem não pode estar vazio.', 'Ваш контент сообщения не может быть пустым.', 'Su contenido de publicación no puede estar vacío.', 'Gönderiniz boş olamaz.'),
(2237, 'yoomoney', '', 'Yoomoney', 'yoomoney.', 'Yoomoney', 'Maillot', 'Yoomoney.', 'Yoomone.', 'Yoomoney.', 'Юмини', 'Eoomoney', 'Yoomoney'),
(2238, 'iyzipay', '', 'Iyzipay', 'iyzipay.', 'Iyzipay', 'Iyzipay', 'IYZIPAY.', 'Iyzipay.', 'Iyzipay.', 'Iyzipay', 'IYZIPAY', 'İyzipay'),
(2239, 'securionpay', '', 'SecurionPay', 'securionpay.', 'Securionpay', 'SecurionPay', 'SecurionPay.', 'SecurionPay.', 'Securionpay.', 'Securionpay.', 'PAYO DE SECURION', 'Securionpay'),
(2240, 'authorize', '', 'Authorize.net', 'Authorize.net.', 'Autoriseer.net', 'Autoriser.net', 'Autorisieren.net.', 'Autorize.net.', 'Autorize.net.', 'Auralize.net.', 'Autorize.net', 'Authorize.net'),
(2241, 'product_sale', '', 'Product sale', 'بيع المنتج', 'Productverkoop', 'Vente de produits', 'Produktverkauf.', 'Vendita del prodotto', 'Venda do produto', 'Продажа продукта', 'Venta de productos', 'Ürün satışı'),
(2242, 'apps', '', 'Apps', 'تطبيقات', 'Apps', 'applications', 'Apps', 'Apps.', 'Aplicativos', 'Программы', 'Apps', 'Apps'),
(2243, 'read_more_text', '', 'Read More', 'اقرأ أكثر', 'Lees verder', 'Lire la suite', 'Weiterlesen', 'Per saperne di più', 'consulte Mais informação', 'Подробнее', 'Leer más', 'Daha fazla oku'),
(2244, 'read_less_text', '', 'Read Less', 'أقرأ أقل', 'Lees minder', 'Lire moins', 'Lese weniger', 'Leggi di meno', 'Leia menos', 'Читать меньше', 'Leer menos', 'Az oku'),
(2245, 'get_messenger_apps', '', 'Get Messenger', 'الحصول على رسول', 'Krijg Messenger', 'Faire des messagers', 'Get Messenger', 'Get Messenger.', 'Obter mensageiro', 'Получить мессенджер', 'Obtener mensajero', 'Haberci almak'),
(2246, 'get_mobile_apps', '', 'Get Mobile Apps', 'الحصول على تطبيقات الجوال', 'Krijg mobiele apps', 'Obtenez des applications mobiles', 'Holen Sie sich mobile Apps.', 'Ottieni app mobili', 'Obtenha aplicativos móveis', 'Получить мобильные приложения', 'Obtener aplicaciones móviles', 'MOBİL APPS GET'),
(2247, 'wow_remember', '', 'Remmember?', 'تذكر؟', 'Onthouden?', 'Rappelles toi?', 'Erinnere dich?', 'Ricordare?', 'Lembrar?', 'Запомнить?', '¿Recordar?', 'Unutma?'),
(2248, 'theme3_welcome_back', '', 'Welcome Back!', 'مرحبا بعودتك!', 'Welkom terug!', 'Content de te revoir!', 'Willkommen zurück!', 'Bentornato!', 'Bem vindo de volta!', 'Добро пожаловать!', '¡Bienvenido de nuevo!', 'Tekrar hoşgeldiniz!'),
(2249, 'theme3_remmember_subtitle', '', 'Let’s go back and try again.', 'دعنا نعود وحاول مرة أخرى.', 'Laten we teruggaan en het opnieuw proberen.', 'Revenons en arrière et réessayons.', 'Lass uns zurückgehen und es noch einmal versuchen.', 'Torniamo indietro e riproviamo.', 'Vamos voltar e tentar novamente.', 'Давайте вернемся и попробуем еще раз.', 'Volvamos e intentemos de nuevo.', 'Geri dönelim ve tekrar deneyin.'),
(2250, 'theme3_have_an_account', '', 'Have an account?', 'هل لديك حساب؟', 'Een account hebben?', 'Avoir un compte?', 'Ein Konto haben?', 'Avere un conto?', 'Ter uma conta?', 'Иметь аккаунт?', '¿Tener una cuenta?', 'Hesabın var mı?'),
(2251, 'theme3_register_sub_title', '', 'If you have an account.', 'إذا كان لديك حساب.', 'Als u een account hebt.', 'Si vous avez un compte.', 'Wenn Sie ein Konto haben.', 'Se hai un account.', 'Se você tem uma conta.', 'Если у вас есть аккаунт.', 'Si tienes una cuenta.', 'Eğer bir hesabınız varsa.'),
(2252, 'theme3_signup', '', 'Sign up', 'اشتراك', 'Aanmelden', 'S&#039;inscrire', 'Anmelden', 'Iscrizione', 'Inscrever-se', 'Зарегистрироваться', 'Inscribirse', 'Üye olmak'),
(2253, 'theme3_signin', '', 'Sign In', 'تسجيل الدخول', 'Aanmelden', 'S&#039;identifier', 'Anmelden', 'Registrazione', 'Entrar', 'Войти', 'Iniciar sesión', 'Kayıt olmak'),
(2254, 'theme3_feature_secured', '', 'Secured', 'مضمون', 'Beveiligd', 'Sécurisé', 'Gesichert', 'Assicurato', 'Protegido', 'Закреплен', 'Asegurado', 'Güvence altına almak'),
(2255, 'theme3_feature_fast', '', 'Fast', 'بسرعة', 'Snel', 'Vite', 'Schnell', 'Veloce', 'Rápido', 'Быстро', 'Rápido', 'Hızlı'),
(2256, 'theme3_feature_easy', '', 'Easy', 'سهل', 'Eenvoudig', 'Facile', 'Leicht', 'Facile', 'Fácil', 'Легкий', 'Fácil', 'Kolay'),
(2257, 'theme3_feature_discover', '', 'Discover', 'يكتشف', 'Ontdekken', 'Découvrir', 'Entdecken', 'Scoprire', 'Descobrir', 'Обнаружить', 'Descubrir', 'Keşfetmek'),
(2258, 'theme3_register_now', '', 'Register Now', 'سجل الان', 'Registreer nu', 'S&#039;inscrire maintenant', 'Jetzt registrieren', 'Iscriviti ora', 'Registrar agora', 'Зарегистрируйтесь сейчас', 'Regístrate ahora', 'Şimdi üye Ol'),
(2259, 'theme3_register_now_subtitle', '', 'While new friends are waiting for you.', 'في حين أن الأصدقاء الجدد ينتظرونك.', 'Terwijl nieuwe vrienden op je wachten.', 'Alors que de nouveaux amis vous attendent.', 'Während neue Freunde auf dich warten.', 'Mentre i nuovi amici ti stanno aspettando.', 'Enquanto novos amigos estão esperando por você.', 'Пока новых друзей ждут вас.', 'Mientras que los nuevos amigos te están esperando.', 'Yeni arkadaşlar seni beklerken.'),
(2260, 'theme4_register', '', 'Register', 'يسجل', 'Register', 'S&#039;inscrire', 'Registrieren', 'Registrati', 'Registro', 'регистр', 'Registrarse', 'Kayıt ol'),
(2261, 'theme4_remain_social_and_simple', '', 'Remain social and simple', 'تبقى الاجتماعية وبسيطة', 'Sociaal en eenvoudig blijven', 'Rester social et simple', 'Sozial und einfach bleiben', 'Rimanere sociale e semplice', 'Permaneça social e simples', 'Оставаться социальными и простыми', 'Permanecer social y simple', 'Sosyal ve basit kal'),
(2262, 'theme4_section2_first_title', '', 'Time to be Social, Go social', 'الوقت ليكون اجتماعيا، الذهاب الاجتماعية', 'Tijd om sociaal te zijn, ga sociaal', 'Il est temps d&#039;être social, aller social', 'Zeit, um sozial zu sein, gehen Sie sozial', 'È ora di essere sociale, vai sociale', 'Hora de ser social, ir social', 'Время быть социальным, иди социальным', 'Es hora de ser social, ir social.', 'Sosyal olma zamanı, sosyal değil'),
(2263, 'theme4_section2_first_subtitle', '', 'We can connect you to the world of million people. Let’s connect', 'يمكننا ربطك بالعالم من مليون شخص.', 'We kunnen u verbinden met de wereld van miljoen mensen.', 'Nous pouvons vous connecter au monde de millions de personnes.', 'Wir können Sie an die Welt der Millionen Menschen verbinden.', 'Possiamo collegarti al mondo di milioni di persone.', 'Podemos conectá-lo ao mundo de milhões de pessoas.', 'Мы можем подключить вас к миру миллиона человек.', 'Podemos conectarte al mundo de millones de personas.', 'Sizi milyonlarca insan dünyasına bağlayabiliriz.'),
(2264, 'theme4_section2_second_title', '', 'Find your true space', 'العثور على الفضاء الحقيقي الخاص بك', 'Vind je ware ruimte', 'Trouvez votre véritable espace', 'Finden Sie Ihren wahren Raum', 'Trova il tuo vero spazio', 'Encontre seu verdadeiro espaço', 'Найти свое настоящее пространство', 'Encuentra tu verdadero espacio', 'Gerçek alanınızı bulun'),
(2265, 'theme4_section2_second_subtitle', '', 'Feel the unmatchable experience we possess.', 'تشعر بالتجربة التي لا مثيل لها.', 'Voel de ongeëvenaarde ervaring die we bezitten.', 'Sentez l&#039;expérience inégalable que nous possédons.', 'Spüren Sie die unübertroffene Erfahrung, die wir besitzen.', 'Senti l&#039;esperienza ineguagliabile che possediamo.', 'Sinta a experiência inigualável que possuímos.', 'Почувствуйте непревзойденный опыт, который мы обладаем.', 'Siente la experiencia inigualable que poseemos.', 'Sahip olduğumuz eşsiz deneyimi hissedin.'),
(2266, 'theme4_section2_third_title', '', 'Sharing Your Vision', 'تقاسم رؤيتك', 'Uw visie delen', 'Partage de votre vision', 'Ihre Vision teilen', 'Condividere la tua visione', 'Compartilhando sua visão', 'Распределение вашего видения', 'Compartiendo tu visión', 'Vizyonunuzu paylaşma'),
(2267, 'theme4_section2_third_subtitle', '', 'Be Imagine, Be Artistic And Let’s Engage.', 'يكون تخيل، كن فني ودعونا نخريك.', 'Stel je voor, wees artistiek en laten we beginnen.', 'Soyez imaginez, soyez artistique et engagez-vous.', 'Stellen Sie sich vor, seien Sie künstlerisch und lasst uns eingehen.', 'Sii immaginare, essere artistico e ci impegniamo.', 'Seja imagino, seja artístico e vamos nos envolver.', 'Будьте представить, будьте хуже и давайте участвовать.', 'Se imagine, sea artístico y vamos a participar.', 'Hayal edin, sanatsal olun ve meşgul olun.'),
(2268, 'theme4_section2_fourth_title', '', 'Let’s Wow your online presence', 'دعونا نجاح باهر وجودك عبر الإنترنت', 'Laten we uw online aanwezigheid wow', 'Wow wow votre présence en ligne', 'Wow, wow deine Online-Präsenz', 'Wow wow la tua presenza online', 'Vamos wow sua presença online', 'Давайте вашим вашим онлайн присутствием', 'Vamos a wow tu presencia en línea', 'Çevrimiçi varlığını vayelim'),
(2269, 'theme4_section2_fourth_subtitle', '', 'Let us help you to enhance your social presence.', 'دعونا نساعدك على تعزيز الوجود الاجتماعي الخاص بك.', 'Laat ons u helpen om uw sociale aanwezigheid te verbeteren.', 'Laissez-nous vous aider à améliorer votre présence sociale.', 'Lassen Sie uns Ihnen helfen, Ihre soziale Präsenz zu verbessern.', 'Ti aiutiamo a migliorare la tua presenza sociale.', 'Vamos ajudá-lo a melhorar sua presença social.', 'Позвольте нам помочь вам улучшить ваше социальное присутствие.', 'Permítanos ayudarlo a mejorar su presencia social.', 'Sosyal varlığınızı arttırmanıza yardımcı olalım.');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Likes`
--

CREATE TABLE `Wo_Likes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Live_Sub_Users`
--

CREATE TABLE `Wo_Live_Sub_Users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `is_watching` int(11) NOT NULL DEFAULT 0,
  `time` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Manage_Pro`
--

CREATE TABLE `Wo_Manage_Pro` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT '',
  `price` varchar(11) NOT NULL DEFAULT '0',
  `featured_member` int(11) NOT NULL DEFAULT 0,
  `profile_visitors` int(11) NOT NULL DEFAULT 0,
  `last_seen` int(11) NOT NULL DEFAULT 0,
  `verified_badge` int(11) NOT NULL DEFAULT 0,
  `posts_promotion` int(11) NOT NULL DEFAULT 0,
  `pages_promotion` int(11) NOT NULL DEFAULT 0,
  `discount` text NOT NULL,
  `image` varchar(300) NOT NULL DEFAULT '',
  `night_image` varchar(300) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1,
  `time` varchar(20) NOT NULL DEFAULT 'week'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Manage_Pro`
--

INSERT INTO `Wo_Manage_Pro` (`id`, `type`, `price`, `featured_member`, `profile_visitors`, `last_seen`, `verified_badge`, `posts_promotion`, `pages_promotion`, `discount`, `image`, `night_image`, `status`, `time`) VALUES
(1, 'star', '3', 1, 1, 1, 1, 0, 0, '0', '', '', 1, 'week'),
(2, 'hot', '8', 1, 1, 1, 1, 5, 5, '10', '', '', 1, 'month'),
(3, 'ultima', '89', 1, 1, 1, 1, 20, 20, '20', '', '', 1, 'year'),
(4, 'vip', '259', 1, 1, 1, 1, 40, 40, '60', '', '', 1, 'unlimited');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Messages`
--

CREATE TABLE `Wo_Messages` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `to_id` int(11) NOT NULL DEFAULT 0,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media` varchar(255) NOT NULL DEFAULT '',
  `mediaFileName` varchar(200) NOT NULL DEFAULT '',
  `mediaFileNames` varchar(200) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `seen` int(11) NOT NULL DEFAULT 0,
  `deleted_one` enum('0','1') NOT NULL DEFAULT '0',
  `deleted_two` enum('0','1') NOT NULL DEFAULT '0',
  `sent_push` int(11) NOT NULL DEFAULT 0,
  `notification_id` varchar(50) NOT NULL DEFAULT '',
  `type_two` varchar(32) NOT NULL DEFAULT '',
  `stickers` text DEFAULT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `lat` varchar(200) NOT NULL DEFAULT '0',
  `lng` varchar(200) NOT NULL DEFAULT '0',
  `reply_id` int(11) NOT NULL DEFAULT 0,
  `story_id` int(11) NOT NULL DEFAULT 0,
  `broadcast_id` int(11) NOT NULL DEFAULT 0,
  `forward` int(2) NOT NULL DEFAULT 0,
  `listening` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_MovieCommentReplies`
--

CREATE TABLE `Wo_MovieCommentReplies` (
  `id` int(11) NOT NULL,
  `comm_id` int(11) NOT NULL DEFAULT 0,
  `movie_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `text` text DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `posted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_MovieComments`
--

CREATE TABLE `Wo_MovieComments` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Movies`
--

CREATE TABLE `Wo_Movies` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `genre` varchar(50) NOT NULL DEFAULT '',
  `stars` varchar(300) NOT NULL DEFAULT '',
  `producer` varchar(100) NOT NULL DEFAULT '',
  `country` varchar(50) NOT NULL DEFAULT '',
  `release` year(4) DEFAULT NULL,
  `quality` varchar(10) DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `cover` varchar(500) NOT NULL DEFAULT 'upload/photos/d-film.jpg',
  `source` varchar(1000) NOT NULL DEFAULT '',
  `iframe` varchar(1000) NOT NULL DEFAULT '',
  `video` varchar(3000) NOT NULL DEFAULT '',
  `views` int(11) NOT NULL DEFAULT 0,
  `rating` varchar(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Mute`
--

CREATE TABLE `Wo_Mute` (
  `id` int(11) NOT NULL,
  `chat_id` int(11) NOT NULL DEFAULT 0,
  `message_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `notify` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT 'yes',
  `call_chat` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT 'yes',
  `archive` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT 'no',
  `pin` varchar(5) CHARACTER SET utf8 NOT NULL DEFAULT 'no',
  `fav` varchar(11) CHARACTER SET utf8 NOT NULL DEFAULT 'no',
  `type` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Mute_Story`
--

CREATE TABLE `Wo_Mute_Story` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `story_user_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Notifications`
--

CREATE TABLE `Wo_Notifications` (
  `id` int(255) NOT NULL,
  `notifier_id` int(11) NOT NULL DEFAULT 0,
  `recipient_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `reply_id` int(11) UNSIGNED DEFAULT 0,
  `comment_id` int(11) UNSIGNED DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `group_chat_id` int(11) NOT NULL DEFAULT 0,
  `event_id` int(11) NOT NULL DEFAULT 0,
  `thread_id` int(11) NOT NULL DEFAULT 0,
  `blog_id` int(11) NOT NULL DEFAULT 0,
  `story_id` int(11) NOT NULL DEFAULT 0,
  `seen_pop` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL DEFAULT '',
  `type2` varchar(32) NOT NULL DEFAULT '',
  `text` text DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `full_link` varchar(1000) NOT NULL DEFAULT '',
  `seen` int(11) NOT NULL DEFAULT 0,
  `sent_push` int(11) NOT NULL DEFAULT 0,
  `admin` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Offers`
--

CREATE TABLE `Wo_Offers` (
  `id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `discount_type` varchar(200) NOT NULL DEFAULT '',
  `discount_percent` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `discounted_items` varchar(150) DEFAULT '',
  `buy` int(11) NOT NULL DEFAULT 0,
  `get_price` int(11) NOT NULL DEFAULT 0,
  `spend` int(11) NOT NULL DEFAULT 0,
  `amount_off` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `expire_date` date NOT NULL,
  `expire_time` time NOT NULL,
  `image` varchar(300) NOT NULL DEFAULT '',
  `currency` varchar(50) NOT NULL DEFAULT '',
  `time` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_PageAdmins`
--

CREATE TABLE `Wo_PageAdmins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `general` int(11) NOT NULL DEFAULT 1,
  `info` int(11) NOT NULL DEFAULT 1,
  `social` int(11) NOT NULL DEFAULT 1,
  `avatar` int(11) NOT NULL DEFAULT 1,
  `design` int(11) NOT NULL DEFAULT 1,
  `admins` int(11) NOT NULL DEFAULT 0,
  `analytics` int(11) NOT NULL DEFAULT 1,
  `delete_page` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_PageRating`
--

CREATE TABLE `Wo_PageRating` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `valuation` int(11) DEFAULT 0,
  `review` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Pages`
--

CREATE TABLE `Wo_Pages` (
  `page_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_name` varchar(32) NOT NULL DEFAULT '',
  `page_title` varchar(32) NOT NULL DEFAULT '',
  `page_description` varchar(1000) NOT NULL DEFAULT '',
  `avatar` varchar(255) NOT NULL DEFAULT 'upload/photos/d-page.jpg',
  `cover` varchar(255) NOT NULL DEFAULT 'upload/photos/d-cover.jpg',
  `users_post` int(11) NOT NULL DEFAULT 0,
  `page_category` int(11) NOT NULL DEFAULT 1,
  `sub_category` varchar(50) NOT NULL DEFAULT '',
  `website` varchar(255) NOT NULL DEFAULT '',
  `facebook` varchar(32) NOT NULL DEFAULT '',
  `google` varchar(32) NOT NULL DEFAULT '',
  `vk` varchar(32) NOT NULL DEFAULT '',
  `twitter` varchar(32) NOT NULL DEFAULT '',
  `linkedin` varchar(32) NOT NULL DEFAULT '',
  `company` varchar(32) NOT NULL DEFAULT '',
  `phone` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(100) NOT NULL DEFAULT '',
  `call_action_type` int(11) NOT NULL DEFAULT 0,
  `call_action_type_url` varchar(255) NOT NULL DEFAULT '',
  `background_image` varchar(200) NOT NULL DEFAULT '',
  `background_image_status` int(11) NOT NULL DEFAULT 0,
  `instgram` varchar(32) NOT NULL DEFAULT '',
  `youtube` varchar(100) NOT NULL DEFAULT '',
  `verified` enum('0','1') NOT NULL DEFAULT '0',
  `active` enum('0','1') NOT NULL DEFAULT '0',
  `registered` varchar(32) NOT NULL DEFAULT '0/0000',
  `boosted` enum('0','1') NOT NULL DEFAULT '0',
  `time` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Pages_Categories`
--

CREATE TABLE `Wo_Pages_Categories` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Pages_Categories`
--

INSERT INTO `Wo_Pages_Categories` (`id`, `lang_key`) VALUES
(2, '1419'),
(3, '1422'),
(4, '1425'),
(5, '1428'),
(6, '1431'),
(7, '1434'),
(8, '1437'),
(9, '1440'),
(10, '1443'),
(11, '1446'),
(12, '1449'),
(13, '1452'),
(14, '1455'),
(15, '1458'),
(16, '1461'),
(17, '1464'),
(18, '1467');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Pages_Invites`
--

CREATE TABLE `Wo_Pages_Invites` (
  `id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `inviter_id` int(11) NOT NULL DEFAULT 0,
  `invited_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Pages_Likes`
--

CREATE TABLE `Wo_Pages_Likes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_PatreonSubscribers`
--

CREATE TABLE `Wo_PatreonSubscribers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `subscriber_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Payments`
--

CREATE TABLE `Wo_Payments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 0,
  `type` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `date` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `time` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Payment_Transactions`
--

CREATE TABLE `Wo_Payment_Transactions` (
  `id` int(11) UNSIGNED NOT NULL,
  `userid` int(11) UNSIGNED NOT NULL,
  `kind` varchar(100) NOT NULL,
  `amount` decimal(11,0) UNSIGNED NOT NULL,
  `transaction_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_PinnedPosts`
--

CREATE TABLE `Wo_PinnedPosts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `event_id` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Pokes`
--

CREATE TABLE `Wo_Pokes` (
  `id` int(11) NOT NULL,
  `received_user_id` int(11) NOT NULL DEFAULT 0,
  `send_user_id` int(11) NOT NULL DEFAULT 0,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Polls`
--

CREATE TABLE `Wo_Polls` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `text` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Posts`
--

CREATE TABLE `Wo_Posts` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `recipient_id` int(11) NOT NULL DEFAULT 0,
  `postText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `event_id` int(11) NOT NULL DEFAULT 0,
  `page_event_id` int(11) NOT NULL DEFAULT 0,
  `postLink` varchar(1000) NOT NULL DEFAULT '',
  `postLinkTitle` text DEFAULT NULL,
  `postLinkImage` varchar(100) NOT NULL DEFAULT '',
  `postLinkContent` text DEFAULT NULL,
  `postVimeo` varchar(100) NOT NULL DEFAULT '',
  `postDailymotion` varchar(100) NOT NULL DEFAULT '',
  `postFacebook` varchar(100) NOT NULL DEFAULT '',
  `postFile` varchar(255) NOT NULL DEFAULT '',
  `postFileName` varchar(200) NOT NULL DEFAULT '',
  `postFileThumb` varchar(3000) NOT NULL DEFAULT '',
  `postYoutube` varchar(255) NOT NULL DEFAULT '',
  `postVine` varchar(32) NOT NULL DEFAULT '',
  `postSoundCloud` varchar(255) NOT NULL DEFAULT '',
  `postPlaytube` varchar(500) NOT NULL DEFAULT '',
  `postDeepsound` varchar(500) NOT NULL DEFAULT '',
  `postMap` varchar(255) NOT NULL DEFAULT '',
  `postShare` int(11) NOT NULL DEFAULT 0,
  `postPrivacy` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  `postType` varchar(30) NOT NULL DEFAULT '',
  `postFeeling` varchar(255) NOT NULL DEFAULT '',
  `postListening` varchar(255) NOT NULL DEFAULT '',
  `postTraveling` varchar(255) NOT NULL DEFAULT '',
  `postWatching` varchar(255) NOT NULL DEFAULT '',
  `postPlaying` varchar(255) NOT NULL DEFAULT '',
  `postPhoto` varchar(3000) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `registered` varchar(32) NOT NULL DEFAULT '0/0000',
  `album_name` varchar(52) NOT NULL DEFAULT '',
  `multi_image` enum('0','1') NOT NULL DEFAULT '0',
  `multi_image_post` int(11) NOT NULL DEFAULT 0,
  `boosted` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `poll_id` int(11) NOT NULL DEFAULT 0,
  `blog_id` int(11) NOT NULL DEFAULT 0,
  `forum_id` int(11) NOT NULL DEFAULT 0,
  `thread_id` int(11) NOT NULL DEFAULT 0,
  `videoViews` int(11) NOT NULL DEFAULT 0,
  `postRecord` varchar(3000) NOT NULL DEFAULT '',
  `postSticker` text DEFAULT NULL,
  `shared_from` int(15) NOT NULL DEFAULT 0,
  `post_url` text DEFAULT NULL,
  `parent_id` int(15) NOT NULL DEFAULT 0,
  `cache` int(11) NOT NULL DEFAULT 0,
  `comments_status` int(11) NOT NULL DEFAULT 1,
  `blur` int(11) NOT NULL DEFAULT 0,
  `color_id` int(11) NOT NULL DEFAULT 0,
  `job_id` int(11) NOT NULL DEFAULT 0,
  `offer_id` int(11) NOT NULL DEFAULT 0,
  `fund_raise_id` int(11) NOT NULL DEFAULT 0,
  `fund_id` int(11) NOT NULL DEFAULT 0,
  `active` int(11) NOT NULL DEFAULT 1,
  `stream_name` varchar(100) NOT NULL DEFAULT '',
  `agora_token` text DEFAULT NULL,
  `live_time` int(50) NOT NULL DEFAULT 0,
  `live_ended` int(11) NOT NULL DEFAULT 0,
  `agora_resource_id` text DEFAULT NULL,
  `agora_sid` varchar(500) NOT NULL DEFAULT '',
  `send_notify` varchar(11) NOT NULL DEFAULT '',
  `240p` int(2) NOT NULL DEFAULT 0,
  `360p` int(2) NOT NULL DEFAULT 0,
  `480p` int(2) NOT NULL DEFAULT 0,
  `720p` int(2) NOT NULL DEFAULT 0,
  `1080p` int(2) NOT NULL DEFAULT 0,
  `2048p` int(2) NOT NULL DEFAULT 0,
  `4096p` int(2) NOT NULL DEFAULT 0,
  `processing` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_ProductReview`
--

CREATE TABLE `Wo_ProductReview` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `review` text DEFAULT NULL,
  `star` int(11) NOT NULL DEFAULT 1,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Products`
--

CREATE TABLE `Wo_Products` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `category` int(11) NOT NULL DEFAULT 0,
  `sub_category` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `price` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.00',
  `location` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `type` enum('0','1') COLLATE utf8_unicode_ci NOT NULL,
  `currency` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USD',
  `lng` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `lat` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `units` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Products_Categories`
--

CREATE TABLE `Wo_Products_Categories` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(160) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Products_Categories`
--

INSERT INTO `Wo_Products_Categories` (`id`, `lang_key`) VALUES
(1, '1470'),
(2, '1471'),
(3, '1472'),
(4, '1473'),
(5, '1474'),
(6, '1475'),
(7, '1476'),
(8, '1477'),
(9, '1478'),
(10, '1479');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Products_Media`
--

CREATE TABLE `Wo_Products_Media` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `image` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_ProfileFields`
--

CREATE TABLE `Wo_ProfileFields` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `length` int(11) NOT NULL DEFAULT 0,
  `placement` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'profile',
  `registration_page` int(11) NOT NULL DEFAULT 0,
  `profile_page` int(11) NOT NULL DEFAULT 0,
  `select_type` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none',
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Purchases`
--

CREATE TABLE `Wo_Purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `order_hash_id` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `owner_id` int(11) NOT NULL DEFAULT 0,
  `data` text CHARACTER SET utf8 DEFAULT NULL,
  `final_price` float NOT NULL DEFAULT 0,
  `commission` float NOT NULL DEFAULT 0,
  `price` float NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Reactions`
--

CREATE TABLE `Wo_Reactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `post_id` int(11) UNSIGNED DEFAULT 0,
  `comment_id` int(11) UNSIGNED DEFAULT 0,
  `replay_id` int(11) UNSIGNED DEFAULT 0,
  `message_id` int(11) NOT NULL DEFAULT 0,
  `story_id` int(11) NOT NULL DEFAULT 0,
  `reaction` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Reactions_Types`
--

CREATE TABLE `Wo_Reactions_Types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `wowonder_icon` varchar(300) NOT NULL DEFAULT '',
  `sunshine_icon` varchar(300) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Reactions_Types`
--

INSERT INTO `Wo_Reactions_Types` (`id`, `name`, `wowonder_icon`, `sunshine_icon`, `status`) VALUES
(1, 'like', '', '', 1),
(2, 'love', '', '', 1),
(3, 'haha', '', '', 1),
(4, 'wow', '', '', 1),
(5, 'sad', '', '', 1),
(6, 'angry', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Wo_RecentSearches`
--

CREATE TABLE `Wo_RecentSearches` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `search_id` int(11) NOT NULL DEFAULT 0,
  `search_type` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Refund`
--

CREATE TABLE `Wo_Refund` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `order_hash_id` varchar(100) NOT NULL DEFAULT '',
  `pro_type` varchar(50) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `time` int(50) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Relationship`
--

CREATE TABLE `Wo_Relationship` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL DEFAULT 0,
  `to_id` int(11) NOT NULL DEFAULT 0,
  `relationship` int(11) NOT NULL DEFAULT 0,
  `active` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Reports`
--

CREATE TABLE `Wo_Reports` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `comment_id` int(15) UNSIGNED NOT NULL DEFAULT 0,
  `profile_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(15) NOT NULL DEFAULT 0,
  `group_id` int(15) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `text` text DEFAULT NULL,
  `seen` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_SavedPosts`
--

CREATE TABLE `Wo_SavedPosts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Stickers`
--

CREATE TABLE `Wo_Stickers` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `media_file` varchar(250) NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Story_Seen`
--

CREATE TABLE `Wo_Story_Seen` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `story_id` int(11) NOT NULL DEFAULT 0,
  `time` varchar(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Sub_Categories`
--

CREATE TABLE `Wo_Sub_Categories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `lang_key` varchar(200) NOT NULL DEFAULT '',
  `type` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Terms`
--

CREATE TABLE `Wo_Terms` (
  `id` int(11) NOT NULL,
  `type` varchar(32) NOT NULL DEFAULT '',
  `text` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Wo_Terms`
--

INSERT INTO `Wo_Terms` (`id`, `type`, `text`) VALUES
(1, 'terms_of_use', '<h4>1- Write your Terms Of Use here.</h4>     \nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.          <br><br>          <h4>2- Random title</h4>          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(2, 'privacy_policy', '<h2>Who we are?</h2>\nProvide name and contact details of the data controller. This will typically be your business or you, if you are a sole trader. Where applicable, you should include the identity and contact details of the controller’s representative and/or the data protection officer. \n\n<h2>What information do we collect?</h2>\nSpecify the types of personal information you collect, eg names, addresses, user names, etc. You should include specific details on:\nhow you collect data (eg when a user registers, purchases or uses your services, completes a contact form, signs up to a newsletter, etc) \nwhat specific data you collect through each of the data collection method\nif you collect data from third parties, you must specify categories of data and source\nif you process sensitive personal data or financial information, and how you handle this \n<br><br>\nYou may want to provide the user with relevant definitions in relation to personal data and sensitive personal data. \n<br><br>\n<h2>How do we use personal information?</h2>\nDescribe in detail all the service- and business-related purposes for which you will process data. For example, this may include things like:\npersonalisation of content, business information or user experience\naccount set up and administration\ndelivering marketing and events communication\ncarrying out polls and surveys\ninternal research and development purposes\nproviding goods and services\nlegal obligations (eg prevention of fraud)\nmeeting internal audit requirements\n<br><br>\nPlease note this list is not exhaustive. You will need to record all purposes for which you process personal data. \n<br><br>\n<h2>What legal basis do we have for processing your personal data?</h2>\nDescribe the relevant processing conditions contained within the GDPR. There are six possible legal grounds: \nconsent\ncontract\nlegitimate interests\nvital interests\npublic task \nlegal obligation\n<br><br>\nProvide detailed information on all grounds that apply to your processing, and why. If you rely on consent, explain how individuals can withdraw and manage their consent. If you rely on legitimate interests, explain clearly what these are.\n<br><br>\nIf you’re processing special category personal data, you will have to satisfy at least one of the six processing conditions, as well as additional requirements for processing under the GDPR. Provide information on all additional grounds that apply. \n<br><br>\n<h2>When do we share personal data?</h2>\nExplain that you will treat personal data confidentially and describe the circumstances when you might disclose or share it. Eg, when necessary to provide your services or conduct your business operations, as outlined in your purposes for processing. You should provide information on:\nhow you will share the data\nwhat safeguards you will have in place\nwhat parties you may share the data with and why\n\n<h2>Where do we store and process personal data?</h2>\nIf applicable, explain if you intend to store and process data outside of the data subject’s home country. Outline the steps you will take to ensure the data is processed according to your privacy policy and the applicable law of the country where data is located.\n\nIf you transfer data outside the European Economic Area, outline the measures you will put in place to provide an appropriate level of data privacy protection. Eg contractual clauses, data transfer agreements, etc.\n\n<h2>How do we secure personal data?</h2>\nDescribe your approach to data security and the technologies and procedures you use to protect personal information. For example, these may be measures:\nto protect data against accidental loss\nto prevent unauthorised access, use, destruction or disclosure\nto ensure business continuity and disaster recovery\nto restrict access to personal information\nto conduct privacy impact assessments in accordance with the law and your business policies\nto train staff and contractors on data security\nto manage third party risks, through use of contracts and security reviews\n<br><br>\nPlease note this list is not exhaustive. You should record all mechanisms you rely on to protect personal data. You should also state if your organisation adheres to certain accepted standards or regulatory requirements.\n<br><br>\n<h2>How long do we keep your personal data for?</h2>\nProvide specific information on the length of time you will keep the information for in relation to each processing purpose. The GDPR requires you to retain data for no longer than reasonably necessary. Include details of your data or records retention schedules, or link to additional resources where these are published.\n<br><br>\nIf you cannot state a specific period, you need to set out the criteria you will apply to determine how long to keep the data for (eg local laws, contractual obligations, etc)\n<br><br>\nYou should also outline how you securely dispose of data after you no longer need it.\n<br><br>\n<h2>Your rights in relation to personal data</h2>\nUnder the GDPR, you must respect the right of data subjects to access and control their personal data. In your privacy notice, you must outline their rights in respect of:\naccess to personal information \ncorrection and deletion\nwithdrawal of consent (if processing data on condition of consent)\ndata portability\nrestriction of processing and objection\nlodging a complaint with the Information Commissioner’s Office\n\nYou should explain how individuals can exercise their rights, and how you plan to respond to subject data requests. State if any relevant exemptions may apply and set out any identity verifications procedures you may rely on.\n\nInclude details of the circumstances where data subject rights may be limited, eg if fulfilling the data subject request may expose personal data about another person, or if you’re asked to delete data which you are required to keep by law. \n\n<h2>Use of automated decision-making and profiling</h2>\nWhere you use profiling or other automated decision-making, you must disclose this in your privacy policy. In such cases, you must provide details on existence of any automated decision-making, together with information about the logic involved, and the likely significance and consequences of the processing of the individual.\n\n<h2>How to contact us?</h2>\nExplain how data subject can get in touch if they have questions or concerns about your privacy practices, their personal information, or if they wish to file a complaint. Describe all ways in which they can contact you – eg online, by email or postal mail.\n<br><br>\nIf applicable, you may also include information on:\n<br><br>\n<h2>Use of cookies and other technologies</h2>\nYou may include a link to further information, or describe within the policy if you intend to set and use cookies, tracking and similar technologies to store and manage user preferences on your website, advertise, enable content or otherwise analyse user and usage data. Provide information on what types of cookies and technologies you use, why you use them and how an individual can control and manage them.\n<br><br>\nLinking to other websites / third party content\nIf you link to external sites and resources from your website, be specific on whether this constitutes endorsement, and if you take any responsibility for the content (or information contained within) any linked website.\n<br><br>\nYou may wish to consider adding other optional clauses to your privacy policy, depending on your business’ circumstances. \n'),
(3, 'about', '<h4>1- Write about your website here.</h4>          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.          <br><br>          <h4>2- Random title</h4>          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dxzcolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(4, 'refund', '<h4>1- Write your Terms Of Use here.</h4>     \r\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis sdnostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.          <br><br>          <h4>2- Random title</h4>          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Tokens`
--

CREATE TABLE `Wo_Tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `app_id` int(11) NOT NULL DEFAULT 0,
  `token` varchar(200) NOT NULL DEFAULT '',
  `time` int(32) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserAddress`
--

CREATE TABLE `Wo_UserAddress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(50) NOT NULL DEFAULT '',
  `country` varchar(100) NOT NULL DEFAULT '',
  `city` varchar(100) NOT NULL DEFAULT '',
  `zip` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(500) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserAds`
--

CREATE TABLE `Wo_UserAds` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `url` varchar(3000) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `headline` varchar(200) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `location` varchar(1000) NOT NULL DEFAULT 'us',
  `audience` longtext DEFAULT NULL,
  `ad_media` varchar(3000) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `gender` varchar(15) CHARACTER SET utf8 COLLATE utf8_danish_ci NOT NULL DEFAULT 'all',
  `bidding` varchar(15) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `clicks` int(15) NOT NULL DEFAULT 0,
  `views` int(15) NOT NULL DEFAULT 0,
  `posted` varchar(15) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `appears` varchar(10) NOT NULL DEFAULT 'post',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` varchar(50) NOT NULL DEFAULT '',
  `start` date NOT NULL,
  `end` date NOT NULL,
  `budget` float UNSIGNED NOT NULL DEFAULT 0,
  `spent` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserAds_Data`
--

CREATE TABLE `Wo_UserAds_Data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `ad_id` int(11) NOT NULL DEFAULT 0,
  `clicks` int(15) NOT NULL DEFAULT 0,
  `views` int(15) NOT NULL DEFAULT 0,
  `spend` float UNSIGNED NOT NULL DEFAULT 0,
  `dt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserCard`
--

CREATE TABLE `Wo_UserCard` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `units` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserCertification`
--

CREATE TABLE `Wo_UserCertification` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `issuing_organization` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `credential_id` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `credential_url` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `certification_start` date NOT NULL,
  `certification_end` date NOT NULL,
  `pdf` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `filename` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserExperience`
--

CREATE TABLE `Wo_UserExperience` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `title` varchar(150) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `location` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `experience_start` date NOT NULL,
  `experience_end` date NOT NULL,
  `industry` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8 DEFAULT NULL,
  `image` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `link` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `headline` varchar(150) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `company_name` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `employment_type` varchar(11) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserFields`
--

CREATE TABLE `Wo_UserFields` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserLanguages`
--

CREATE TABLE `Wo_UserLanguages` (
  `id` int(11) NOT NULL,
  `lang_key` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Wo_UserLanguages`
--

INSERT INTO `Wo_UserLanguages` (`id`, `lang_key`) VALUES
(1, 'Afrikaans_af'),
(2, 'Albanian_sq'),
(3, 'Amharic_am'),
(4, 'Arabic_ar'),
(5, 'Aragonese_an'),
(6, 'Armenian_hy'),
(7, 'Asturian_ast'),
(8, 'Azerbaijani_az'),
(9, 'Basque_eu'),
(10, 'Belarusian_be'),
(11, 'Bengali_bn'),
(12, 'Bosnian_bs'),
(13, 'Breton_br'),
(14, 'Bulgarian_bg'),
(15, 'Catalan_ca'),
(16, 'Central Kurdish_ckb'),
(17, 'Chinese_zh'),
(18, 'Corsican_co'),
(19, 'Croatian_hr'),
(20, 'Czech_cs'),
(21, 'Danish_da'),
(22, 'Dutch_nl'),
(23, 'English_en'),
(24, 'Esperanto_eo'),
(25, 'Estonian_et'),
(26, 'Faroese_fo'),
(27, 'Filipino_fil'),
(28, 'Finnish_fi'),
(29, 'French_fr'),
(30, 'Galician_gl'),
(31, 'Georgian_ka'),
(32, 'German_de'),
(33, 'Greek_el'),
(34, 'Guarani_gn'),
(35, 'Gujarati_gu'),
(36, 'Hausa_ha'),
(37, 'Hawaiian_haw'),
(38, 'Hebrew_he'),
(39, 'Hindi_hi'),
(40, 'Hungarian_hu'),
(41, 'Icelandic_is'),
(42, 'Indonesian_id'),
(43, 'Interlingua_ia'),
(44, 'Irish_ga'),
(45, 'Italian_it'),
(46, 'Japanese_ja'),
(47, 'Kannada_kn'),
(48, 'Kazakh_kk'),
(49, 'Khmer_km'),
(50, 'Korean_ko'),
(51, 'Kurdish_ku'),
(52, 'Kyrgyz_ky'),
(53, 'Lao_lo'),
(54, 'Latin_la'),
(55, 'Latvian_lv'),
(56, 'Lingala_ln'),
(57, 'Lithuanian_lt'),
(58, 'Macedonian_mk'),
(60, 'Malayalam_ml'),
(59, 'Malay_ms'),
(61, 'Maltese_mt'),
(62, 'Marathi_mr'),
(63, 'Mongolian_mn'),
(64, 'Nepali_ne'),
(66, 'Norwegian Bokmål_nb'),
(67, 'Norwegian Nynorsk_nn'),
(65, 'Norwegian_no'),
(68, 'Occitan_oc'),
(69, 'Oriya_or'),
(70, 'Oromo_om'),
(71, 'Pashto_ps'),
(72, 'Persian_fa'),
(73, 'Polish_pl'),
(74, 'Portuguese_pt'),
(75, 'Punjabi_pa'),
(76, 'Quechua_qu'),
(77, 'Romanian_ro'),
(78, 'Romansh_rm'),
(79, 'Russian_ru'),
(80, 'Scottish Gaelic_gd'),
(81, 'Serbian_sr'),
(82, 'Serbo_sh'),
(83, 'Shona_sn'),
(84, 'Sindhi_sd'),
(85, 'Sinhala_si'),
(86, 'Slovak_sk'),
(87, 'Slovenian_sl'),
(88, 'Somali_so'),
(89, 'Southern Sotho_st'),
(90, 'Spanish_es'),
(91, 'Sundanese_su'),
(92, 'Swahili_sw'),
(93, 'Swedish_sv'),
(94, 'Tajik_tg'),
(95, 'Tamil_ta'),
(96, 'Tatar_tt'),
(97, 'Telugu_te'),
(98, 'Thai_th'),
(99, 'Tigrinya_ti'),
(100, 'Tongan_to'),
(101, 'Turkish_tr'),
(102, 'Turkmen_tk'),
(103, 'Twi_tw'),
(104, 'Ukrainian_uk'),
(105, 'Urdu_ur'),
(106, 'Uyghur_ug'),
(107, 'Uzbek_uz'),
(108, 'Vietnamese_vi'),
(109, 'Walloon_wa'),
(110, 'Welsh_cy'),
(111, 'Western Frisian_fy'),
(112, 'Xhosa_xh'),
(113, 'Yiddish_yi'),
(114, 'Yoruba_yo'),
(115, 'Zulu_zu');

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserOpenTo`
--

CREATE TABLE `Wo_UserOpenTo` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `job_title` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `job_location` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `workplaces` varchar(600) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `job_type` varchar(600) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `services` varchar(1000) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `description` varchar(1000) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `type` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserOrders`
--

CREATE TABLE `Wo_UserOrders` (
  `id` int(11) NOT NULL,
  `hash_id` varchar(100) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `product_owner_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `address_id` int(11) NOT NULL DEFAULT 0,
  `price` float NOT NULL DEFAULT 0,
  `commission` float NOT NULL DEFAULT 0,
  `final_price` float NOT NULL DEFAULT 0,
  `units` int(11) NOT NULL DEFAULT 0,
  `tracking_url` varchar(500) NOT NULL DEFAULT '',
  `tracking_id` varchar(50) NOT NULL DEFAULT '',
  `status` varchar(30) NOT NULL DEFAULT 'placed',
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserProjects`
--

CREATE TABLE `Wo_UserProjects` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `description` varchar(600) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `associated_with` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `project_url` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `project_start` date NOT NULL,
  `project_end` date NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Users`
--

CREATE TABLE `Wo_Users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(70) NOT NULL DEFAULT '',
  `first_name` varchar(60) NOT NULL DEFAULT '',
  `last_name` varchar(32) NOT NULL DEFAULT '',
  `avatar` varchar(100) NOT NULL DEFAULT 'upload/photos/d-avatar.jpg',
  `cover` varchar(100) NOT NULL DEFAULT 'upload/photos/d-cover.jpg',
  `background_image` varchar(100) NOT NULL DEFAULT '',
  `background_image_status` enum('0','1') NOT NULL DEFAULT '0',
  `relationship_id` int(11) NOT NULL DEFAULT 0,
  `address` varchar(100) NOT NULL DEFAULT '',
  `working` varchar(32) NOT NULL DEFAULT '',
  `working_link` varchar(32) NOT NULL DEFAULT '',
  `about` text DEFAULT NULL,
  `school` varchar(32) NOT NULL DEFAULT '',
  `gender` varchar(32) NOT NULL DEFAULT 'male',
  `birthday` varchar(50) NOT NULL DEFAULT '0000-00-00',
  `country_id` int(11) NOT NULL DEFAULT 0,
  `website` varchar(50) NOT NULL DEFAULT '',
  `facebook` varchar(50) NOT NULL DEFAULT '',
  `google` varchar(50) NOT NULL DEFAULT '',
  `twitter` varchar(50) NOT NULL DEFAULT '',
  `linkedin` varchar(32) NOT NULL DEFAULT '',
  `youtube` varchar(100) NOT NULL DEFAULT '',
  `vk` varchar(32) NOT NULL DEFAULT '',
  `instagram` varchar(32) NOT NULL DEFAULT '',
  `qq` text DEFAULT NULL,
  `wechat` text DEFAULT NULL,
  `discord` text DEFAULT NULL,
  `mailru` text DEFAULT NULL,
  `okru` varchar(30) NOT NULL DEFAULT '',
  `language` varchar(31) NOT NULL DEFAULT 'english',
  `email_code` varchar(32) NOT NULL DEFAULT '',
  `src` varchar(32) NOT NULL DEFAULT 'Undefined',
  `ip_address` varchar(32) DEFAULT '',
  `follow_privacy` enum('1','0') NOT NULL DEFAULT '0',
  `friend_privacy` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `post_privacy` varchar(255) NOT NULL DEFAULT 'ifollow',
  `message_privacy` enum('1','0','2') NOT NULL DEFAULT '0',
  `confirm_followers` enum('1','0') NOT NULL DEFAULT '0',
  `show_activities_privacy` enum('0','1') NOT NULL DEFAULT '1',
  `birth_privacy` enum('0','1','2') NOT NULL DEFAULT '0',
  `visit_privacy` enum('0','1') NOT NULL DEFAULT '0',
  `verified` enum('1','0') NOT NULL DEFAULT '0',
  `lastseen` int(32) NOT NULL DEFAULT 0,
  `showlastseen` enum('1','0') NOT NULL DEFAULT '1',
  `emailNotification` enum('1','0') NOT NULL DEFAULT '1',
  `e_liked` enum('0','1') NOT NULL DEFAULT '1',
  `e_wondered` enum('0','1') NOT NULL DEFAULT '1',
  `e_shared` enum('0','1') NOT NULL DEFAULT '1',
  `e_followed` enum('0','1') NOT NULL DEFAULT '1',
  `e_commented` enum('0','1') NOT NULL DEFAULT '1',
  `e_visited` enum('0','1') NOT NULL DEFAULT '1',
  `e_liked_page` enum('0','1') NOT NULL DEFAULT '1',
  `e_mentioned` enum('0','1') NOT NULL DEFAULT '1',
  `e_joined_group` enum('0','1') NOT NULL DEFAULT '1',
  `e_accepted` enum('0','1') NOT NULL DEFAULT '1',
  `e_profile_wall_post` enum('0','1') NOT NULL DEFAULT '1',
  `e_sentme_msg` enum('0','1') NOT NULL DEFAULT '0',
  `e_last_notif` varchar(50) NOT NULL DEFAULT '0',
  `notification_settings` varchar(400) NOT NULL DEFAULT '{"e_liked":1,"e_shared":1,"e_wondered":0,"e_commented":1,"e_followed":1,"e_accepted":1,"e_mentioned":1,"e_joined_group":1,"e_liked_page":1,"e_visited":1,"e_profile_wall_post":1,"e_memory":1}',
  `status` enum('1','0') NOT NULL DEFAULT '0',
  `active` enum('0','1','2') NOT NULL DEFAULT '0',
  `admin` enum('0','1','2') NOT NULL DEFAULT '0',
  `type` varchar(11) NOT NULL DEFAULT 'user',
  `registered` varchar(32) NOT NULL DEFAULT '0/0000',
  `start_up` enum('0','1') NOT NULL DEFAULT '0',
  `start_up_info` enum('0','1') NOT NULL DEFAULT '0',
  `startup_follow` enum('0','1') NOT NULL DEFAULT '0',
  `startup_image` enum('0','1') NOT NULL DEFAULT '0',
  `last_email_sent` int(32) NOT NULL DEFAULT 0,
  `phone_number` varchar(32) NOT NULL DEFAULT '',
  `sms_code` int(11) NOT NULL DEFAULT 0,
  `is_pro` enum('0','1') NOT NULL DEFAULT '0',
  `pro_time` int(11) NOT NULL DEFAULT 0,
  `pro_type` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `joined` int(11) NOT NULL DEFAULT 0,
  `css_file` varchar(100) NOT NULL DEFAULT '',
  `timezone` varchar(50) NOT NULL DEFAULT '',
  `referrer` int(11) NOT NULL DEFAULT 0,
  `ref_user_id` int(11) NOT NULL DEFAULT 0,
  `ref_level` text DEFAULT NULL,
  `balance` varchar(100) NOT NULL DEFAULT '0',
  `paypal_email` varchar(100) NOT NULL DEFAULT '',
  `notifications_sound` enum('0','1') NOT NULL DEFAULT '0',
  `order_posts_by` enum('0','1') NOT NULL DEFAULT '1',
  `social_login` enum('0','1') NOT NULL DEFAULT '0',
  `android_m_device_id` varchar(50) NOT NULL DEFAULT '',
  `ios_m_device_id` varchar(50) NOT NULL DEFAULT '',
  `android_n_device_id` varchar(50) NOT NULL DEFAULT '',
  `ios_n_device_id` varchar(50) NOT NULL DEFAULT '',
  `web_device_id` varchar(100) NOT NULL DEFAULT '',
  `wallet` varchar(20) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0.00',
  `lat` varchar(200) NOT NULL DEFAULT '0',
  `lng` varchar(200) NOT NULL DEFAULT '0',
  `last_location_update` varchar(30) NOT NULL DEFAULT '0',
  `share_my_location` int(11) NOT NULL DEFAULT 1,
  `last_data_update` int(11) NOT NULL DEFAULT 0,
  `details` varchar(300) NOT NULL DEFAULT '{"post_count":0,"album_count":0,"following_count":0,"followers_count":0,"groups_count":0,"likes_count":0}',
  `sidebar_data` text DEFAULT NULL,
  `last_avatar_mod` int(11) NOT NULL DEFAULT 0,
  `last_cover_mod` int(11) NOT NULL DEFAULT 0,
  `points` float UNSIGNED NOT NULL DEFAULT 0,
  `daily_points` int(11) NOT NULL DEFAULT 0,
  `point_day_expire` varchar(50) NOT NULL DEFAULT '',
  `last_follow_id` int(11) NOT NULL DEFAULT 0,
  `share_my_data` int(11) NOT NULL DEFAULT 1,
  `last_login_data` text DEFAULT NULL,
  `two_factor` int(11) NOT NULL DEFAULT 0,
  `new_email` varchar(255) NOT NULL DEFAULT '',
  `two_factor_verified` int(11) NOT NULL DEFAULT 0,
  `new_phone` varchar(32) NOT NULL DEFAULT '',
  `info_file` varchar(300) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `state` varchar(50) NOT NULL DEFAULT '',
  `zip` varchar(11) NOT NULL DEFAULT '',
  `school_completed` int(11) NOT NULL DEFAULT 0,
  `weather_unit` varchar(11) NOT NULL DEFAULT 'us',
  `paystack_ref` varchar(100) NOT NULL DEFAULT '',
  `code_sent` int(11) NOT NULL DEFAULT 0,
  `StripeSessionId` text DEFAULT NULL,
  `time_code_sent` int(11) NOT NULL DEFAULT 0,
  `permission` text DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `languages` text DEFAULT NULL,
  `currently_working` varchar(50) NOT NULL DEFAULT '',
  `banned` int(5) NOT NULL DEFAULT 0,
  `banned_reason` varchar(500) NOT NULL DEFAULT '',
  `coinbase_hash` varchar(20) NOT NULL DEFAULT '',
  `coinbase_code` varchar(20) NOT NULL DEFAULT '',
  `yoomoney_hash` varchar(20) NOT NULL DEFAULT '',
  `ConversationId` int(20) NOT NULL DEFAULT 0,
  `securionpay_key` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UsersChat`
--

CREATE TABLE `Wo_UsersChat` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `conversation_user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `color` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserSkills`
--

CREATE TABLE `Wo_UserSkills` (
  `id` int(11) NOT NULL,
  `name` varchar(300) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserStory`
--

CREATE TABLE `Wo_UserStory` (
  `id` int(11) NOT NULL,
  `user_id` int(50) NOT NULL DEFAULT 0,
  `title` varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `description` varchar(300) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `posted` varchar(50) NOT NULL DEFAULT '',
  `expire` varchar(100) DEFAULT '',
  `thumbnail` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserStoryMedia`
--

CREATE TABLE `Wo_UserStoryMedia` (
  `id` int(11) NOT NULL,
  `story_id` int(30) NOT NULL DEFAULT 0,
  `type` varchar(30) NOT NULL DEFAULT '',
  `filename` text DEFAULT NULL,
  `expire` varchar(100) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_UserTiers`
--

CREATE TABLE `Wo_UserTiers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `title` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `price` float NOT NULL DEFAULT 0,
  `image` varchar(400) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `description` varchar(1000) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `chat` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `live_stream` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_User_Gifts`
--

CREATE TABLE `Wo_User_Gifts` (
  `id` int(11) NOT NULL,
  `from` int(11) NOT NULL DEFAULT 0,
  `to` int(11) NOT NULL DEFAULT 0,
  `gift_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Verification_Requests`
--

CREATE TABLE `Wo_Verification_Requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page_id` int(11) NOT NULL DEFAULT 0,
  `message` text CHARACTER SET utf8 DEFAULT NULL,
  `user_name` varchar(150) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `passport` varchar(3000) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `photo` varchar(3000) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `seen` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_VideoCalles`
--

CREATE TABLE `Wo_VideoCalles` (
  `id` int(11) NOT NULL,
  `access_token` text DEFAULT NULL,
  `access_token_2` text DEFAULT NULL,
  `from_id` int(11) NOT NULL DEFAULT 0,
  `to_id` int(11) NOT NULL DEFAULT 0,
  `room_name` varchar(50) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT 0,
  `called` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `declined` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Votes`
--

CREATE TABLE `Wo_Votes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `option_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Wo_Wonders`
--

CREATE TABLE `Wo_Wonders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank_receipts`
--
ALTER TABLE `bank_receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fund_id` (`fund_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `approved_at` (`approved_at`),
  ADD KEY `approved` (`approved`),
  ADD KEY `mode` (`mode`);

--
-- Indexes for table `broadcast`
--
ALTER TABLE `broadcast`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `time_2` (`time`);

--
-- Indexes for table `broadcast_users`
--
ALTER TABLE `broadcast_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `broadcast_id` (`broadcast_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `wondertage_settings`
--
ALTER TABLE `wondertage_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `Wo_Activities`
--
ALTER TABLE `Wo_Activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `activity_type` (`activity_type`),
  ADD KEY `order1` (`user_id`,`id`),
  ADD KEY `order2` (`post_id`,`id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `reply_id` (`reply_id`),
  ADD KEY `follow_id` (`follow_id`);

--
-- Indexes for table `Wo_AdminInvitations`
--
ALTER TABLE `Wo_AdminInvitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`(255));

--
-- Indexes for table `Wo_Ads`
--
ALTER TABLE `Wo_Ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active` (`active`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `Wo_Affiliates_Requests`
--
ALTER TABLE `Wo_Affiliates_Requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `Wo_AgoraVideoCall`
--
ALTER TABLE `Wo_AgoraVideoCall`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `type` (`type`),
  ADD KEY `room_name` (`room_name`),
  ADD KEY `time` (`time`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `Wo_Albums_Media`
--
ALTER TABLE `Wo_Albums_Media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `order1` (`post_id`,`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `review_id` (`review_id`);

--
-- Indexes for table `Wo_Announcement`
--
ALTER TABLE `Wo_Announcement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_Announcement_Views`
--
ALTER TABLE `Wo_Announcement_Views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `announcement_id` (`announcement_id`);

--
-- Indexes for table `Wo_Apps`
--
ALTER TABLE `Wo_Apps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_user_id` (`app_user_id`),
  ADD KEY `app_id` (`app_id`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_AppsSessions`
--
ALTER TABLE `Wo_AppsSessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `platform` (`platform`);

--
-- Indexes for table `Wo_Apps_Hash`
--
ALTER TABLE `Wo_Apps_Hash`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hash_id` (`hash_id`),
  ADD KEY `active` (`active`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Apps_Permission`
--
ALTER TABLE `Wo_Apps_Permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`app_id`);

--
-- Indexes for table `Wo_AudioCalls`
--
ALTER TABLE `Wo_AudioCalls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `call_id` (`call_id`),
  ADD KEY `called` (`called`),
  ADD KEY `declined` (`declined`);

--
-- Indexes for table `Wo_Bad_Login`
--
ALTER TABLE `Wo_Bad_Login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `Wo_Banned_Ip`
--
ALTER TABLE `Wo_Banned_Ip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip_address` (`ip_address`);

--
-- Indexes for table `Wo_Blocks`
--
ALTER TABLE `Wo_Blocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blocker` (`blocker`),
  ADD KEY `blocked` (`blocked`);

--
-- Indexes for table `Wo_Blog`
--
ALTER TABLE `Wo_Blog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `title` (`title`),
  ADD KEY `category` (`category`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_BlogCommentReplies`
--
ALTER TABLE `Wo_BlogCommentReplies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comm_id` (`comm_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `order1` (`comm_id`,`id`),
  ADD KEY `order2` (`blog_id`,`id`),
  ADD KEY `order3` (`user_id`,`id`);

--
-- Indexes for table `Wo_BlogComments`
--
ALTER TABLE `Wo_BlogComments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_BlogMovieDisLikes`
--
ALTER TABLE `Wo_BlogMovieDisLikes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_comm_id` (`blog_comm_id`),
  ADD KEY `movie_comm_id` (`movie_comm_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `blog_commreply_id` (`blog_commreply_id`),
  ADD KEY `movie_commreply_id` (`movie_commreply_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Indexes for table `Wo_BlogMovieLikes`
--
ALTER TABLE `Wo_BlogMovieLikes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_comm_id`),
  ADD KEY `movie_id` (`movie_comm_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `blog_commreply_id` (`blog_commreply_id`),
  ADD KEY `movie_commreply_id` (`movie_commreply_id`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `movie_id_2` (`movie_id`);

--
-- Indexes for table `Wo_Blogs_Categories`
--
ALTER TABLE `Wo_Blogs_Categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lang_key` (`lang_key`);

--
-- Indexes for table `Wo_Blog_Reaction`
--
ALTER TABLE `Wo_Blog_Reaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `reply_id` (`reply_id`);

--
-- Indexes for table `Wo_Codes`
--
ALTER TABLE `Wo_Codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `app_id` (`app_id`);

--
-- Indexes for table `Wo_Colored_Posts`
--
ALTER TABLE `Wo_Colored_Posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `color_1` (`color_1`),
  ADD KEY `color_2` (`color_2`);

--
-- Indexes for table `Wo_CommentLikes`
--
ALTER TABLE `Wo_CommentLikes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `Wo_Comments`
--
ALTER TABLE `Wo_Comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `order1` (`user_id`,`id`),
  ADD KEY `order2` (`page_id`,`id`),
  ADD KEY `order3` (`post_id`,`id`),
  ADD KEY `order4` (`user_id`,`id`),
  ADD KEY `order5` (`post_id`,`id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_CommentWonders`
--
ALTER TABLE `Wo_CommentWonders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Comment_Replies`
--
ALTER TABLE `Wo_Comment_Replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `user_id` (`user_id`,`page_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_Comment_Replies_Likes`
--
ALTER TABLE `Wo_Comment_Replies_Likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reply_id` (`reply_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Comment_Replies_Wonders`
--
ALTER TABLE `Wo_Comment_Replies_Wonders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reply_id` (`reply_id`,`user_id`);

--
-- Indexes for table `Wo_Config`
--
ALTER TABLE `Wo_Config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_name` (`name`);

--
-- Indexes for table `Wo_CustomPages`
--
ALTER TABLE `Wo_CustomPages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_type` (`page_type`);

--
-- Indexes for table `Wo_Custom_Fields`
--
ALTER TABLE `Wo_Custom_Fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_Egoing`
--
ALTER TABLE `Wo_Egoing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Einterested`
--
ALTER TABLE `Wo_Einterested`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Einvited`
--
ALTER TABLE `Wo_Einvited`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `inviter_id` (`invited_id`),
  ADD KEY `inviter_id_2` (`inviter_id`);

--
-- Indexes for table `Wo_Emails`
--
ALTER TABLE `Wo_Emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email_to` (`email_to`);

--
-- Indexes for table `Wo_Events`
--
ALTER TABLE `Wo_Events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poster_id` (`poster_id`),
  ADD KEY `name` (`name`),
  ADD KEY `start_date` (`start_date`),
  ADD KEY `start_time` (`start_time`),
  ADD KEY `end_time` (`end_time`),
  ADD KEY `end_date` (`end_date`),
  ADD KEY `order1` (`poster_id`,`id`),
  ADD KEY `order2` (`id`);

--
-- Indexes for table `Wo_Family`
--
ALTER TABLE `Wo_Family`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `active` (`active`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `requesting` (`requesting`);

--
-- Indexes for table `Wo_Followers`
--
ALTER TABLE `Wo_Followers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `following_id` (`following_id`),
  ADD KEY `follower_id` (`follower_id`),
  ADD KEY `active` (`active`),
  ADD KEY `order1` (`following_id`,`id`),
  ADD KEY `order2` (`follower_id`,`id`),
  ADD KEY `is_typing` (`is_typing`),
  ADD KEY `notify` (`notify`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_Forums`
--
ALTER TABLE `Wo_Forums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `description` (`description`(255)),
  ADD KEY `posts` (`posts`);

--
-- Indexes for table `Wo_ForumThreadReplies`
--
ALTER TABLE `Wo_ForumThreadReplies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thread_id` (`thread_id`),
  ADD KEY `forum_id` (`forum_id`),
  ADD KEY `poster_id` (`poster_id`),
  ADD KEY `post_subject` (`post_subject`(255)),
  ADD KEY `post_quoted` (`post_quoted`),
  ADD KEY `posted_time` (`posted_time`);

--
-- Indexes for table `Wo_Forum_Sections`
--
ALTER TABLE `Wo_Forum_Sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section_name` (`section_name`),
  ADD KEY `description` (`description`(255));

--
-- Indexes for table `Wo_Forum_Threads`
--
ALTER TABLE `Wo_Forum_Threads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `views` (`views`),
  ADD KEY `posted` (`posted`),
  ADD KEY `headline` (`headline`(255)),
  ADD KEY `forum` (`forum`);

--
-- Indexes for table `Wo_Funding`
--
ALTER TABLE `Wo_Funding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hashed_id` (`hashed_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Funding_Raise`
--
ALTER TABLE `Wo_Funding_Raise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `funding_id` (`funding_id`);

--
-- Indexes for table `Wo_Games`
--
ALTER TABLE `Wo_Games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_Games_Players`
--
ALTER TABLE `Wo_Games_Players`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`game_id`,`active`);

--
-- Indexes for table `Wo_Gender`
--
ALTER TABLE `Wo_Gender`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gender_id` (`gender_id`);

--
-- Indexes for table `Wo_Gifts`
--
ALTER TABLE `Wo_Gifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_GroupAdmins`
--
ALTER TABLE `Wo_GroupAdmins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `members` (`members`);

--
-- Indexes for table `Wo_GroupChat`
--
ALTER TABLE `Wo_GroupChat`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_GroupChatUsers`
--
ALTER TABLE `Wo_GroupChatUsers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_Groups`
--
ALTER TABLE `Wo_Groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `time` (`time`),
  ADD KEY `active` (`active`),
  ADD KEY `group_title` (`group_title`),
  ADD KEY `group_name` (`group_name`),
  ADD KEY `registered` (`registered`);

--
-- Indexes for table `Wo_Groups_Categories`
--
ALTER TABLE `Wo_Groups_Categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Group_Members`
--
ALTER TABLE `Wo_Group_Members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`group_id`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `Wo_Hashtags`
--
ALTER TABLE `Wo_Hashtags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `last_trend_time` (`last_trend_time`),
  ADD KEY `trend_use_num` (`trend_use_num`),
  ADD KEY `tag` (`tag`),
  ADD KEY `expire` (`expire`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `Wo_HiddenPosts`
--
ALTER TABLE `Wo_HiddenPosts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_HTML_Emails`
--
ALTER TABLE `Wo_HTML_Emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Invitation_Links`
--
ALTER TABLE `Wo_Invitation_Links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`(255)),
  ADD KEY `invited_id` (`invited_id`),
  ADD KEY `time` (`time`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Job`
--
ALTER TABLE `Wo_Job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `title` (`title`),
  ADD KEY `category` (`category`),
  ADD KEY `lng` (`lng`),
  ADD KEY `lat` (`lat`),
  ADD KEY `status` (`status`),
  ADD KEY `job_type` (`job_type`),
  ADD KEY `minimum` (`minimum`),
  ADD KEY `maximum` (`maximum`);

--
-- Indexes for table `Wo_Job_Apply`
--
ALTER TABLE `Wo_Job_Apply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `user_name` (`user_name`);

--
-- Indexes for table `Wo_Job_Categories`
--
ALTER TABLE `Wo_Job_Categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Langs`
--
ALTER TABLE `Wo_Langs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_name` (`lang_key`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `Wo_Likes`
--
ALTER TABLE `Wo_Likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Live_Sub_Users`
--
ALTER TABLE `Wo_Live_Sub_Users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time` (`time`),
  ADD KEY `is_watching` (`is_watching`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Manage_Pro`
--
ALTER TABLE `Wo_Manage_Pro`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Messages`
--
ALTER TABLE `Wo_Messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `seen` (`seen`),
  ADD KEY `time` (`time`),
  ADD KEY `deleted_two` (`deleted_two`),
  ADD KEY `deleted_one` (`deleted_one`),
  ADD KEY `sent_push` (`sent_push`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `order1` (`from_id`,`id`),
  ADD KEY `order2` (`group_id`,`id`),
  ADD KEY `order3` (`to_id`,`id`),
  ADD KEY `order7` (`seen`,`id`),
  ADD KEY `order8` (`time`,`id`),
  ADD KEY `order4` (`from_id`,`id`),
  ADD KEY `order5` (`group_id`,`id`),
  ADD KEY `order6` (`to_id`,`id`),
  ADD KEY `reply_id` (`reply_id`),
  ADD KEY `broadcast_id` (`broadcast_id`),
  ADD KEY `story_id` (`story_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `notification_id` (`notification_id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `page_id_2` (`page_id`),
  ADD KEY `notification_id_2` (`notification_id`),
  ADD KEY `product_id_2` (`product_id`),
  ADD KEY `story_id_2` (`story_id`),
  ADD KEY `reply_id_2` (`reply_id`),
  ADD KEY `broadcast_id_2` (`broadcast_id`),
  ADD KEY `forward` (`forward`),
  ADD KEY `listening` (`listening`);

--
-- Indexes for table `Wo_MovieCommentReplies`
--
ALTER TABLE `Wo_MovieCommentReplies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comm_id` (`comm_id`),
  ADD KEY `movie_id` (`movie_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_MovieComments`
--
ALTER TABLE `Wo_MovieComments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movie_id` (`movie_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Movies`
--
ALTER TABLE `Wo_Movies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `genre` (`genre`),
  ADD KEY `country` (`country`),
  ADD KEY `release` (`release`);

--
-- Indexes for table `Wo_Mute`
--
ALTER TABLE `Wo_Mute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `chat_id_2` (`chat_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `notify` (`notify`),
  ADD KEY `type` (`type`),
  ADD KEY `fav` (`fav`);

--
-- Indexes for table `Wo_Mute_Story`
--
ALTER TABLE `Wo_Mute_Story`
  ADD PRIMARY KEY (`id`),
  ADD KEY `story_user_id` (`story_user_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `story_user_id_2` (`story_user_id`);

--
-- Indexes for table `Wo_Notifications`
--
ALTER TABLE `Wo_Notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifier_id` (`notifier_id`),
  ADD KEY `user_id` (`recipient_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `seen` (`seen`),
  ADD KEY `time` (`time`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `group_id` (`group_id`,`seen_pop`),
  ADD KEY `sent_push` (`sent_push`),
  ADD KEY `order1` (`seen`,`id`),
  ADD KEY `order2` (`notifier_id`,`id`),
  ADD KEY `order3` (`recipient_id`,`id`),
  ADD KEY `order4` (`post_id`,`id`),
  ADD KEY `order5` (`page_id`,`id`),
  ADD KEY `order6` (`group_id`,`id`),
  ADD KEY `order7` (`time`,`id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `reply_id` (`reply_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `story_id` (`story_id`),
  ADD KEY `admin` (`admin`),
  ADD KEY `group_chat_id` (`group_chat_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `thread_id` (`thread_id`);

--
-- Indexes for table `Wo_Offers`
--
ALTER TABLE `Wo_Offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `spend` (`spend`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_PageAdmins`
--
ALTER TABLE `Wo_PageAdmins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `Wo_PageRating`
--
ALTER TABLE `Wo_PageRating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `Wo_Pages`
--
ALTER TABLE `Wo_Pages`
  ADD PRIMARY KEY (`page_id`),
  ADD KEY `registered` (`registered`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_category` (`page_category`),
  ADD KEY `active` (`active`),
  ADD KEY `verified` (`verified`),
  ADD KEY `boosted` (`boosted`),
  ADD KEY `time` (`time`),
  ADD KEY `page_name` (`page_name`),
  ADD KEY `page_title` (`page_title`),
  ADD KEY `sub_category` (`sub_category`);

--
-- Indexes for table `Wo_Pages_Categories`
--
ALTER TABLE `Wo_Pages_Categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Pages_Invites`
--
ALTER TABLE `Wo_Pages_Invites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_id` (`page_id`,`inviter_id`,`invited_id`);

--
-- Indexes for table `Wo_Pages_Likes`
--
ALTER TABLE `Wo_Pages_Likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active` (`active`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `Wo_PatreonSubscribers`
--
ALTER TABLE `Wo_PatreonSubscribers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `subscriber_id` (`subscriber_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_Payments`
--
ALTER TABLE `Wo_Payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `Wo_Payment_Transactions`
--
ALTER TABLE `Wo_Payment_Transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `kind` (`kind`),
  ADD KEY `transaction_dt` (`transaction_dt`);

--
-- Indexes for table `Wo_PinnedPosts`
--
ALTER TABLE `Wo_PinnedPosts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `active` (`active`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `Wo_Pokes`
--
ALTER TABLE `Wo_Pokes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `received_user_id` (`received_user_id`),
  ADD KEY `user_id` (`send_user_id`);

--
-- Indexes for table `Wo_Polls`
--
ALTER TABLE `Wo_Polls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_Posts`
--
ALTER TABLE `Wo_Posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `recipient_id` (`recipient_id`),
  ADD KEY `postFile` (`postFile`),
  ADD KEY `postShare` (`postShare`),
  ADD KEY `postType` (`postType`),
  ADD KEY `postYoutube` (`postYoutube`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `registered` (`registered`),
  ADD KEY `time` (`time`),
  ADD KEY `boosted` (`boosted`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `videoViews` (`videoViews`),
  ADD KEY `shared_from` (`shared_from`),
  ADD KEY `order1` (`user_id`,`id`),
  ADD KEY `order2` (`page_id`,`id`),
  ADD KEY `order3` (`group_id`,`id`),
  ADD KEY `order4` (`recipient_id`,`id`),
  ADD KEY `order5` (`event_id`,`id`),
  ADD KEY `order6` (`parent_id`,`id`),
  ADD KEY `multi_image` (`multi_image`),
  ADD KEY `album_name` (`album_name`),
  ADD KEY `postFacebook` (`postFacebook`),
  ADD KEY `postVimeo` (`postVimeo`),
  ADD KEY `postDailymotion` (`postDailymotion`),
  ADD KEY `postSoundCloud` (`postSoundCloud`),
  ADD KEY `postYoutube_2` (`postYoutube`),
  ADD KEY `fund_raise_id` (`fund_raise_id`),
  ADD KEY `fund_id` (`fund_id`),
  ADD KEY `offer_id` (`offer_id`),
  ADD KEY `live_time` (`live_time`),
  ADD KEY `live_ended` (`live_ended`),
  ADD KEY `active` (`active`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `page_event_id` (`page_event_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `color_id` (`color_id`),
  ADD KEY `thread_id` (`thread_id`),
  ADD KEY `forum_id` (`forum_id`),
  ADD KEY `processing` (`processing`);

--
-- Indexes for table `Wo_ProductReview`
--
ALTER TABLE `Wo_ProductReview`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `star` (`star`);

--
-- Indexes for table `Wo_Products`
--
ALTER TABLE `Wo_Products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category` (`category`),
  ADD KEY `price` (`price`),
  ADD KEY `status` (`status`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `active` (`active`),
  ADD KEY `units` (`units`);

--
-- Indexes for table `Wo_Products_Categories`
--
ALTER TABLE `Wo_Products_Categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Products_Media`
--
ALTER TABLE `Wo_Products_Media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `Wo_ProfileFields`
--
ALTER TABLE `Wo_ProfileFields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registration_page` (`registration_page`),
  ADD KEY `active` (`active`),
  ADD KEY `profile_page` (`profile_page`);

--
-- Indexes for table `Wo_Purchases`
--
ALTER TABLE `Wo_Purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `time` (`time`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `final_price` (`final_price`),
  ADD KEY `order_hash_id` (`order_hash_id`),
  ADD KEY `data` (`data`(1024));

--
-- Indexes for table `Wo_Reactions`
--
ALTER TABLE `Wo_Reactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_reaction` (`reaction`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `replay_id` (`replay_id`),
  ADD KEY `story_id` (`story_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `comment_id_2` (`comment_id`),
  ADD KEY `replay_id_2` (`replay_id`),
  ADD KEY `message_id_3` (`message_id`),
  ADD KEY `story_id_2` (`story_id`);

--
-- Indexes for table `Wo_Reactions_Types`
--
ALTER TABLE `Wo_Reactions_Types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_RecentSearches`
--
ALTER TABLE `Wo_RecentSearches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`search_id`),
  ADD KEY `search_type` (`search_type`);

--
-- Indexes for table `Wo_Refund`
--
ALTER TABLE `Wo_Refund`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pro_type` (`pro_type`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `Wo_Relationship`
--
ALTER TABLE `Wo_Relationship`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `relationship` (`relationship`),
  ADD KEY `active` (`active`),
  ADD KEY `to_id` (`to_id`);

--
-- Indexes for table `Wo_Reports`
--
ALTER TABLE `Wo_Reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `seen` (`seen`),
  ADD KEY `profile_id` (`profile_id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `comment_id` (`comment_id`);

--
-- Indexes for table `Wo_SavedPosts`
--
ALTER TABLE `Wo_SavedPosts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_Stickers`
--
ALTER TABLE `Wo_Stickers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Story_Seen`
--
ALTER TABLE `Wo_Story_Seen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `story_id` (`story_id`);

--
-- Indexes for table `Wo_Sub_Categories`
--
ALTER TABLE `Wo_Sub_Categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `lang_key` (`lang_key`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `Wo_Terms`
--
ALTER TABLE `Wo_Terms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Wo_Tokens`
--
ALTER TABLE `Wo_Tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `app_id` (`app_id`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `Wo_UserAddress`
--
ALTER TABLE `Wo_UserAddress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_UserAds`
--
ALTER TABLE `Wo_UserAds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appears` (`appears`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `location` (`location`(255)),
  ADD KEY `gender` (`gender`),
  ADD KEY `status` (`status`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `Wo_UserAds_Data`
--
ALTER TABLE `Wo_UserAds_Data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ad_id` (`ad_id`);

--
-- Indexes for table `Wo_UserCard`
--
ALTER TABLE `Wo_UserCard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `units` (`units`);

--
-- Indexes for table `Wo_UserCertification`
--
ALTER TABLE `Wo_UserCertification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_UserExperience`
--
ALTER TABLE `Wo_UserExperience`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `Wo_UserFields`
--
ALTER TABLE `Wo_UserFields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Wo_UserLanguages`
--
ALTER TABLE `Wo_UserLanguages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lang_key` (`lang_key`);

--
-- Indexes for table `Wo_UserOpenTo`
--
ALTER TABLE `Wo_UserOpenTo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `job_title` (`job_title`),
  ADD KEY `job_location` (`job_location`),
  ADD KEY `workplaces` (`workplaces`),
  ADD KEY `job_type` (`job_type`),
  ADD KEY `type` (`type`),
  ADD KEY `time` (`time`),
  ADD KEY `services` (`services`),
  ADD KEY `description` (`description`);

--
-- Indexes for table `Wo_UserOrders`
--
ALTER TABLE `Wo_UserOrders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_owner_id` (`product_owner_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `final_price` (`final_price`),
  ADD KEY `status` (`status`),
  ADD KEY `time` (`time`),
  ADD KEY `hash_id` (`hash_id`),
  ADD KEY `units` (`units`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `Wo_UserProjects`
--
ALTER TABLE `Wo_UserProjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `Wo_Users`
--
ALTER TABLE `Wo_Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `active` (`active`),
  ADD KEY `admin` (`admin`),
  ADD KEY `src` (`src`),
  ADD KEY `gender` (`gender`),
  ADD KEY `avatar` (`avatar`),
  ADD KEY `first_name` (`first_name`),
  ADD KEY `last_name` (`last_name`),
  ADD KEY `registered` (`registered`),
  ADD KEY `joined` (`joined`),
  ADD KEY `phone_number` (`phone_number`) USING BTREE,
  ADD KEY `referrer` (`referrer`),
  ADD KEY `wallet` (`wallet`),
  ADD KEY `friend_privacy` (`friend_privacy`),
  ADD KEY `lat` (`lat`),
  ADD KEY `lng` (`lng`),
  ADD KEY `order1` (`username`,`user_id`),
  ADD KEY `order2` (`email`,`user_id`),
  ADD KEY `order3` (`lastseen`,`user_id`),
  ADD KEY `order4` (`active`,`user_id`),
  ADD KEY `last_data_update` (`last_data_update`),
  ADD KEY `points` (`points`),
  ADD KEY `paystack_ref` (`paystack_ref`),
  ADD KEY `relationship_id` (`relationship_id`),
  ADD KEY `post_privacy` (`post_privacy`),
  ADD KEY `email_code` (`email_code`),
  ADD KEY `password` (`password`),
  ADD KEY `status` (`status`),
  ADD KEY `type` (`type`),
  ADD KEY `is_pro` (`is_pro`),
  ADD KEY `ref_user_id` (`ref_user_id`),
  ADD KEY `currently_working` (`currently_working`),
  ADD KEY `banned` (`banned`),
  ADD KEY `coinbase_hash` (`coinbase_hash`),
  ADD KEY `coinbase_code` (`coinbase_code`),
  ADD KEY `yoomoney_hash` (`yoomoney_hash`),
  ADD KEY `ConversationId` (`ConversationId`),
  ADD KEY `securionpay_key` (`securionpay_key`);

--
-- Indexes for table `Wo_UsersChat`
--
ALTER TABLE `Wo_UsersChat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `conversation_user_id` (`conversation_user_id`),
  ADD KEY `time` (`time`),
  ADD KEY `order1` (`user_id`,`id`),
  ADD KEY `order2` (`user_id`,`id`),
  ADD KEY `order3` (`conversation_user_id`,`id`),
  ADD KEY `order4` (`conversation_user_id`,`id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `color` (`color`);

--
-- Indexes for table `Wo_UserSkills`
--
ALTER TABLE `Wo_UserSkills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `Wo_UserStory`
--
ALTER TABLE `Wo_UserStory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `expires` (`expire`);

--
-- Indexes for table `Wo_UserStoryMedia`
--
ALTER TABLE `Wo_UserStoryMedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expire` (`expire`),
  ADD KEY `story_id` (`story_id`);

--
-- Indexes for table `Wo_UserTiers`
--
ALTER TABLE `Wo_UserTiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `chat` (`chat`),
  ADD KEY `live_stream` (`live_stream`);

--
-- Indexes for table `Wo_User_Gifts`
--
ALTER TABLE `Wo_User_Gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from` (`from`),
  ADD KEY `to` (`to`),
  ADD KEY `gift_id` (`gift_id`);

--
-- Indexes for table `Wo_Verification_Requests`
--
ALTER TABLE `Wo_Verification_Requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `Wo_VideoCalles`
--
ALTER TABLE `Wo_VideoCalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `called` (`called`),
  ADD KEY `declined` (`declined`);

--
-- Indexes for table `Wo_Votes`
--
ALTER TABLE `Wo_Votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `option_id` (`option_id`);

--
-- Indexes for table `Wo_Wonders`
--
ALTER TABLE `Wo_Wonders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank_receipts`
--
ALTER TABLE `bank_receipts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `broadcast`
--
ALTER TABLE `broadcast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `broadcast_users`
--
ALTER TABLE `broadcast_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wondertage_settings`
--
ALTER TABLE `wondertage_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `Wo_Activities`
--
ALTER TABLE `Wo_Activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_AdminInvitations`
--
ALTER TABLE `Wo_AdminInvitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Ads`
--
ALTER TABLE `Wo_Ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Wo_Affiliates_Requests`
--
ALTER TABLE `Wo_Affiliates_Requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_AgoraVideoCall`
--
ALTER TABLE `Wo_AgoraVideoCall`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Albums_Media`
--
ALTER TABLE `Wo_Albums_Media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Announcement`
--
ALTER TABLE `Wo_Announcement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Announcement_Views`
--
ALTER TABLE `Wo_Announcement_Views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Apps`
--
ALTER TABLE `Wo_Apps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_AppsSessions`
--
ALTER TABLE `Wo_AppsSessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Apps_Hash`
--
ALTER TABLE `Wo_Apps_Hash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Apps_Permission`
--
ALTER TABLE `Wo_Apps_Permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_AudioCalls`
--
ALTER TABLE `Wo_AudioCalls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Bad_Login`
--
ALTER TABLE `Wo_Bad_Login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Banned_Ip`
--
ALTER TABLE `Wo_Banned_Ip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Blocks`
--
ALTER TABLE `Wo_Blocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Blog`
--
ALTER TABLE `Wo_Blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_BlogCommentReplies`
--
ALTER TABLE `Wo_BlogCommentReplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_BlogComments`
--
ALTER TABLE `Wo_BlogComments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_BlogMovieDisLikes`
--
ALTER TABLE `Wo_BlogMovieDisLikes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_BlogMovieLikes`
--
ALTER TABLE `Wo_BlogMovieLikes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Blogs_Categories`
--
ALTER TABLE `Wo_Blogs_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `Wo_Blog_Reaction`
--
ALTER TABLE `Wo_Blog_Reaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `Wo_Codes`
--
ALTER TABLE `Wo_Codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Colored_Posts`
--
ALTER TABLE `Wo_Colored_Posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_CommentLikes`
--
ALTER TABLE `Wo_CommentLikes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Comments`
--
ALTER TABLE `Wo_Comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_CommentWonders`
--
ALTER TABLE `Wo_CommentWonders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Comment_Replies`
--
ALTER TABLE `Wo_Comment_Replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Comment_Replies_Likes`
--
ALTER TABLE `Wo_Comment_Replies_Likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Comment_Replies_Wonders`
--
ALTER TABLE `Wo_Comment_Replies_Wonders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Config`
--
ALTER TABLE `Wo_Config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=432;

--
-- AUTO_INCREMENT for table `Wo_CustomPages`
--
ALTER TABLE `Wo_CustomPages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Custom_Fields`
--
ALTER TABLE `Wo_Custom_Fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Egoing`
--
ALTER TABLE `Wo_Egoing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Einterested`
--
ALTER TABLE `Wo_Einterested`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Einvited`
--
ALTER TABLE `Wo_Einvited`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Emails`
--
ALTER TABLE `Wo_Emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Events`
--
ALTER TABLE `Wo_Events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Family`
--
ALTER TABLE `Wo_Family`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Followers`
--
ALTER TABLE `Wo_Followers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Forums`
--
ALTER TABLE `Wo_Forums`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_ForumThreadReplies`
--
ALTER TABLE `Wo_ForumThreadReplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Forum_Sections`
--
ALTER TABLE `Wo_Forum_Sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Forum_Threads`
--
ALTER TABLE `Wo_Forum_Threads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Funding`
--
ALTER TABLE `Wo_Funding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Funding_Raise`
--
ALTER TABLE `Wo_Funding_Raise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Games`
--
ALTER TABLE `Wo_Games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Games_Players`
--
ALTER TABLE `Wo_Games_Players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Gender`
--
ALTER TABLE `Wo_Gender`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Gifts`
--
ALTER TABLE `Wo_Gifts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_GroupAdmins`
--
ALTER TABLE `Wo_GroupAdmins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_GroupChat`
--
ALTER TABLE `Wo_GroupChat`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_GroupChatUsers`
--
ALTER TABLE `Wo_GroupChatUsers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Groups`
--
ALTER TABLE `Wo_Groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Groups_Categories`
--
ALTER TABLE `Wo_Groups_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `Wo_Group_Members`
--
ALTER TABLE `Wo_Group_Members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Hashtags`
--
ALTER TABLE `Wo_Hashtags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_HiddenPosts`
--
ALTER TABLE `Wo_HiddenPosts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_HTML_Emails`
--
ALTER TABLE `Wo_HTML_Emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Wo_Invitation_Links`
--
ALTER TABLE `Wo_Invitation_Links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Job`
--
ALTER TABLE `Wo_Job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `Wo_Job_Apply`
--
ALTER TABLE `Wo_Job_Apply`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Wo_Job_Categories`
--
ALTER TABLE `Wo_Job_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `Wo_Langs`
--
ALTER TABLE `Wo_Langs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2270;

--
-- AUTO_INCREMENT for table `Wo_Likes`
--
ALTER TABLE `Wo_Likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Live_Sub_Users`
--
ALTER TABLE `Wo_Live_Sub_Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Manage_Pro`
--
ALTER TABLE `Wo_Manage_Pro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Wo_Messages`
--
ALTER TABLE `Wo_Messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_MovieCommentReplies`
--
ALTER TABLE `Wo_MovieCommentReplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_MovieComments`
--
ALTER TABLE `Wo_MovieComments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Movies`
--
ALTER TABLE `Wo_Movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Mute`
--
ALTER TABLE `Wo_Mute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Mute_Story`
--
ALTER TABLE `Wo_Mute_Story`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Notifications`
--
ALTER TABLE `Wo_Notifications`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Offers`
--
ALTER TABLE `Wo_Offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_PageAdmins`
--
ALTER TABLE `Wo_PageAdmins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_PageRating`
--
ALTER TABLE `Wo_PageRating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Pages`
--
ALTER TABLE `Wo_Pages`
  MODIFY `page_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Pages_Categories`
--
ALTER TABLE `Wo_Pages_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `Wo_Pages_Invites`
--
ALTER TABLE `Wo_Pages_Invites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Pages_Likes`
--
ALTER TABLE `Wo_Pages_Likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_PatreonSubscribers`
--
ALTER TABLE `Wo_PatreonSubscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Payments`
--
ALTER TABLE `Wo_Payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Payment_Transactions`
--
ALTER TABLE `Wo_Payment_Transactions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_PinnedPosts`
--
ALTER TABLE `Wo_PinnedPosts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Pokes`
--
ALTER TABLE `Wo_Pokes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Polls`
--
ALTER TABLE `Wo_Polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Posts`
--
ALTER TABLE `Wo_Posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_ProductReview`
--
ALTER TABLE `Wo_ProductReview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Products`
--
ALTER TABLE `Wo_Products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Products_Categories`
--
ALTER TABLE `Wo_Products_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Wo_Products_Media`
--
ALTER TABLE `Wo_Products_Media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_ProfileFields`
--
ALTER TABLE `Wo_ProfileFields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Purchases`
--
ALTER TABLE `Wo_Purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Reactions`
--
ALTER TABLE `Wo_Reactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Reactions_Types`
--
ALTER TABLE `Wo_Reactions_Types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Wo_RecentSearches`
--
ALTER TABLE `Wo_RecentSearches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Refund`
--
ALTER TABLE `Wo_Refund`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Relationship`
--
ALTER TABLE `Wo_Relationship`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Reports`
--
ALTER TABLE `Wo_Reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_SavedPosts`
--
ALTER TABLE `Wo_SavedPosts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Stickers`
--
ALTER TABLE `Wo_Stickers`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Story_Seen`
--
ALTER TABLE `Wo_Story_Seen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Sub_Categories`
--
ALTER TABLE `Wo_Sub_Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Terms`
--
ALTER TABLE `Wo_Terms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Wo_Tokens`
--
ALTER TABLE `Wo_Tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserAddress`
--
ALTER TABLE `Wo_UserAddress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserAds`
--
ALTER TABLE `Wo_UserAds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserAds_Data`
--
ALTER TABLE `Wo_UserAds_Data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserCard`
--
ALTER TABLE `Wo_UserCard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserCertification`
--
ALTER TABLE `Wo_UserCertification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserExperience`
--
ALTER TABLE `Wo_UserExperience`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserFields`
--
ALTER TABLE `Wo_UserFields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserLanguages`
--
ALTER TABLE `Wo_UserLanguages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `Wo_UserOpenTo`
--
ALTER TABLE `Wo_UserOpenTo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserOrders`
--
ALTER TABLE `Wo_UserOrders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserProjects`
--
ALTER TABLE `Wo_UserProjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Users`
--
ALTER TABLE `Wo_Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UsersChat`
--
ALTER TABLE `Wo_UsersChat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserSkills`
--
ALTER TABLE `Wo_UserSkills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserStory`
--
ALTER TABLE `Wo_UserStory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserStoryMedia`
--
ALTER TABLE `Wo_UserStoryMedia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_UserTiers`
--
ALTER TABLE `Wo_UserTiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_User_Gifts`
--
ALTER TABLE `Wo_User_Gifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Verification_Requests`
--
ALTER TABLE `Wo_Verification_Requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_VideoCalles`
--
ALTER TABLE `Wo_VideoCalles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Votes`
--
ALTER TABLE `Wo_Votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Wo_Wonders`
--
ALTER TABLE `Wo_Wonders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
