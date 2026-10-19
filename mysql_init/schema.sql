-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS storypop;
CREATE USER IF NOT EXISTS 'gorse'@'%' IDENTIFIED WITH caching_sha2_password BY 'gorse_pass';
GRANT ALL PRIVILEGES ON storypop.* to 'gorse'@'%' WITH GRANT OPTION;
USE storypop;


--
-- Table structure for table `claim_transfer_request`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `claim_transfer_request` (
  `transfer_request_id` int unsigned NOT NULL AUTO_INCREMENT,
  `device_uuid` binary(16) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `wallet_address` varchar(50) NOT NULL,
  `fullfilled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transfer_request_id`),
  KEY `fullfilled_at_index` (`fullfilled_at`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `claim_transfer_request_item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `claim_transfer_request_item` (
  `transfer_request_item_id` int unsigned NOT NULL AUTO_INCREMENT,
  `transfer_request_id` int unsigned DEFAULT NULL,
  `claim_id` int unsigned NOT NULL,
  `reward_id` int unsigned NOT NULL,
  `reserved_at` timestamp NULL DEFAULT NULL,
  `destination_account_address` varchar(50) DEFAULT NULL,
  `blockhash` varchar(64) DEFAULT NULL,
  `signature` varchar(150) DEFAULT NULL,
  `fullfilled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transfer_request_item_id`),
  KEY `fullfilled_at_index` (`fullfilled_at`),
  KEY `transfer_request_id_index` (`transfer_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events_queued`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `events_queued` (
  `event_id` int unsigned NOT NULL AUTO_INCREMENT,
  `trigger_source_username` varchar(20) NOT NULL,
  `additional_data` varchar(255) NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `claimed` tinyint(1) NOT NULL DEFAULT '0',
  `available_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_id`),
  KEY `trigger_source_username_index` (`trigger_source_username`)
) ENGINE=InnoDB AUTO_INCREMENT=1959 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_box_rewards`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `gift_box_rewards` (
  `reward_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reward_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_queue`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `mail_queue` (
  `queue_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `additional_data` text DEFAULT NULL,
  `claimed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`queue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pubsub_messages`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `pubsub_messages` (
  `message_id` int unsigned NOT NULL AUTO_INCREMENT,
  `data` varchar(5000) NOT NULL,
  `message_id_received` varchar(50) NOT NULL,
  `subscription_topic` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewards`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `rewards` (
  `reward_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `rarity` tinyint unsigned NOT NULL,
  `metadata` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `available_until` timestamp NOT NULL,
  `available_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `available_amount` int unsigned NOT NULL DEFAULT '0',
  `mint_address` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reward_id`),
  KEY `available_until_index` (`available_until`),
  KEY `available_from_index` (`available_from`),
  KEY `available_amount_index` (`available_amount`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sent_links_users`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sent_links_users` (
  `request_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip_address` binary(16) NOT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token_hash` binary(32) DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `sent_links_token_hash_uq` (`token_hash`),
  KEY `sent_links_expiry_idx` (`expires_at`),
  KEY `sent_links_email_created_idx` (`email`,`created_at`),
  PRIMARY KEY (`request_id`),
  KEY `username_index` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `story_tags_rank`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `story_tags_rank` (
  `tag` varchar(15) NOT NULL,
  `tag_rank` int unsigned NOT NULL,
  PRIMARY KEY (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_claimed_rewards`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_claimed_rewards` (
  `claim_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `reward_id` int unsigned NOT NULL,
  `transferable` tinyint NOT NULL DEFAULT '0',
  `transfered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transfer_request_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`claim_id`),
  KEY `username_index` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_contact_approved`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_contact_approved` (
  `approval_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `target_username` varchar(20) NOT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `blocked` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`approval_id`),
  KEY `username_index` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_fcm_token`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_fcm_token` (
  `device_uuid` binary(16) NOT NULL,
  `username` varchar(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token`),
  KEY `username_index` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_following`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_following` (
  `username` varchar(20) NOT NULL,
  `following` varchar(20) NOT NULL,
  `started_follow_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`,`following`),
  KEY `following_index` (`following`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invite`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_invite` (
  `email` varchar(255) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `username_source` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`),
  KEY `username_source_index` (`username_source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invite_android`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_invite_android` (
  `invite_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `invite_code` varchar(12) NOT NULL,
  `invite_sent_at` timestamp NULL DEFAULT NULL,
  `invite_claimed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invite_id`),
  UNIQUE KEY `invite_code_index` (`invite_code`),
  KEY `email_index` (`email`),
  KEY `invite_sent_at_index` (`invite_sent_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invite_ios`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_invite_ios` (
  `invite_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `invite_code` varchar(12) NOT NULL,
  `invite_sent_at` timestamp NULL DEFAULT NULL,
  `invite_claimed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invite_id`),
  UNIQUE KEY `invite_code_index` (`invite_code`),
  KEY `email_index` (`email`),
  KEY `invite_sent_at_index` (`invite_sent_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_message`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_message` (
  `message_id` int unsigned NOT NULL AUTO_INCREMENT,
  `message_uuid` binary(16) NOT NULL,
  `target_username` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `content` varchar(500) NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `published_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `message_unread_idx` (`target_username`, `is_read`, `deleted`),
  PRIMARY KEY (`message_id`),
  KEY `username_index` (`username`),
  KEY `target_username_index` (`target_username`),
  KEY `message_uuid_index` (`message_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_notification`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_notification` (
  `notification_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `additional_data` varchar(255) NOT NULL,
  `transaction_description_type` smallint unsigned NOT NULL,
  `notification_read` tinyint(1) NOT NULL DEFAULT '0',
  `available_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `notification_unread_idx` (`username`, `notification_read`, `available_from`),
  PRIMARY KEY (`notification_id`),
  KEY `username_index` (`username`),
  KEY `available_from_index` (`available_from`)
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_stories`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_stories` (
  `story_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `published_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `slug_title` varchar(60) NOT NULL,
  PRIMARY KEY (`story_id`),
  UNIQUE KEY `slug_title_index` (`slug_title`),
  KEY `username_published_index` (`username`,`published_at`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_story_comment`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_story_comment` (
  `comment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `comment_uuid` binary(16) NOT NULL,
  `reply_to_comment_uuid` binary(16) DEFAULT NULL,
  `slug_title` varchar(60) NOT NULL,
  `username` varchar(20) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `lang_code` varchar(3) NOT NULL,
  `published_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reply_to_username` varchar(20) DEFAULT NULL,
  `original_reply_to_comment_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `slug_title_comment_uuid_index` (`slug_title`,`comment_uuid`),
  KEY `username_index` (`username`),
  KEY `reply_to_comment_uuid_index` (`reply_to_comment_uuid`),
  KEY `hidden_index` (`hidden`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_story_comment_like`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_story_comment_like` (
  `comment_uuid` binary(16) NOT NULL,
  `username` varchar(20) NOT NULL,
  `published_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_uuid`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_story_log`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_story_log` (
  `log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `slug_title` varchar(60) NOT NULL,
  `story_title` varchar(60) NOT NULL DEFAULT '',
  `empty_title` varchar(60) NOT NULL DEFAULT '',
  `story_compressed` varbinary(40000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `story_latest_snapshot_idx` (`slug_title`, `log_id`),
  PRIMARY KEY (`log_id`),
  KEY `slugtitle_index` (`slug_title`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_transactions`

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_transactions` (
  `transaction_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `amount` int NOT NULL,
  `transaction_type` tinyint unsigned DEFAULT NULL,
  `additional_data` varchar(255) NOT NULL,
  `description_type` smallint unsigned NOT NULL,
  `available_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `username_index` (`username`),
  KEY `available_from_index` (`available_from`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wallet_history`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_wallet_history` (
  `history_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `device_uuid` binary(16) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `wallet_address` varchar(50) NOT NULL,
  `is_removal` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `users` (
  `device_uuid` binary(16) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(20) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `google_subject` varchar(255) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `profile_icon` varchar(255) DEFAULT NULL,
  `profile_background_image` varchar(255) DEFAULT NULL,
  `profile_text` varchar(500) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `following_latest_check_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wallet_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `email_index` (`email`),
  UNIQUE KEY `users_google_subject_uq` (`google_subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `article_pending_review` (
  `review_id` int unsigned NOT NULL AUTO_INCREMENT,
  `slug_title` varchar(60) NOT NULL,
  `username` varchar(20) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rejection_reason` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `slug_title_index` (`slug_title`),
  KEY `username_index` (`username`),
  KEY `rejection_reason_index` (`rejection_reason`(10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `known_public_sources` (
  `source_id` int unsigned NOT NULL AUTO_INCREMENT,
  `host_name` varchar(255) NOT NULL,
  `source_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`source_id`),
  UNIQUE KEY `host_name_index` (`host_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `deleted_stories` (
  `slug_title` varchar(60) NOT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`slug_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `story_tags` (
  `tag_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug_title` VARCHAR(60) NOT NULL,
  `tag` VARCHAR(50) NOT NULL,
  `tag_type` ENUM('topic','entity','tag','meta') DEFAULT 'tag',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tag_id`),
  -- Fast filtering by tag
  INDEX `idx_tag` (`tag`),
  INDEX `idx_tag_tagtype_slug` (tag, tag_type, slug_title),
  INDEX idx_story_tags_created_type_tag (created_at, tag_type, tag),
  -- Optional FK for integrity
  CONSTRAINT `fk_story_tags_slug`
    FOREIGN KEY (`slug_title`)
    REFERENCES `user_stories` (`slug_title`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- Financial filing/report storage
--
-- Naming is intentionally domain-neutral: report, metric, fact and source-link
-- names do not mirror SEC/XBRL JSON property names or individual taxonomies.
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;

-- One row per listed stock ticker. country_code should use the ISO 3166-1
-- alpha-2 country code (for example US, SE, GB). A company may have multiple
-- listings, so ticker/exchange/country form the natural uniqueness boundary.
-- One row per listed stock ticker. country_code should use the ISO 3166-1
-- alpha-2 country code (for example US, SE, GB). A company may have multiple
-- listings, so ticker/exchange/country form the natural uniqueness boundary.
CREATE TABLE IF NOT EXISTS `stock_ticker` (
  `stock_ticker_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticker_symbol` varchar(32) NOT NULL,
  `exchange_code` varchar(32) NOT NULL,
  `country_code` char(2) NOT NULL,
  `entity_name` varchar(255) DEFAULT NULL,
  `has_sec_filings` tinyint(1) NOT NULL DEFAULT '1',
  `sec_sync_recent_fingerprint` char(64) DEFAULT NULL,
  `sec_sync_watermark_accession_number` varchar(32) DEFAULT NULL,
  `sec_sync_watermark_filed_date` date DEFAULT NULL,
  `sec_sync_checked_at` timestamp NULL DEFAULT NULL,
  `sec_sync_retry_after` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stock_ticker_id`),
  UNIQUE KEY `stock_ticker_listing_uq` (`ticker_symbol`,`exchange_code`,`country_code`),
  KEY `stock_ticker_symbol_idx` (`ticker_symbol`),
  KEY `stock_ticker_country_idx` (`country_code`),
  KEY `stock_ticker_sec_sync_retry_idx` (`sec_sync_retry_after`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `stock_weekly_gex` (
  `stock_weekly_gex_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stock_ticker_id` bigint unsigned NOT NULL,
  `expiration_date` date NOT NULL,
  `expiration_type` char(1) NOT NULL DEFAULT 'w',
  `net_exposure` decimal(30,6) DEFAULT NULL,
  `call_exposure` decimal(30,6) DEFAULT NULL,
  `put_exposure` decimal(30,6) DEFAULT NULL,
  `call_wall_price` decimal(20,8) DEFAULT NULL,
  `put_wall_price` decimal(20,8) DEFAULT NULL,
  `gamma_flip_price` decimal(20,8) DEFAULT NULL,
  `gamma_flip_method` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`stock_weekly_gex_id`),
  UNIQUE KEY `stock_weekly_gex_ticker_expiration_uq` (`stock_ticker_id`,`expiration_date`),
  KEY `stock_weekly_gex_expiration_idx` (`expiration_date`),
  CONSTRAINT `stock_weekly_gex_stock_ticker_fk`
    FOREIGN KEY (`stock_ticker_id`)
    REFERENCES `stock_ticker` (`stock_ticker_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Daily regular-session OHLCV candles sourced from IBKR.  The scanner/history
-- integration upserts by listing and trading date, so reruns and incremental
-- refreshes are idempotent.
CREATE TABLE IF NOT EXISTS `stock_daily_ohlc` (
  `stock_daily_ohlc_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stock_ticker_id` bigint unsigned NOT NULL,
  `trading_date` date NOT NULL,
  `open_price` decimal(20,8) NOT NULL,
  `high_price` decimal(20,8) NOT NULL,
  `low_price` decimal(20,8) NOT NULL,
  `close_price` decimal(20,8) NOT NULL,
  `volume` decimal(30,8) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`stock_daily_ohlc_id`),
  UNIQUE KEY `stock_daily_ohlc_ticker_date_uq` (`stock_ticker_id`,`trading_date`),
  KEY `stock_daily_ohlc_trading_date_idx` (`trading_date`),
  CONSTRAINT `stock_daily_ohlc_stock_ticker_fk`
    FOREIGN KEY (`stock_ticker_id`)
    REFERENCES `stock_ticker` (`stock_ticker_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- One row per filed report/form. SEC accession numbers are globally unique.
CREATE TABLE IF NOT EXISTS `financial_report` (
  `report_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stock_ticker_id` bigint unsigned NOT NULL,
  `accession_number` varchar(32) NOT NULL,
  `form_type` varchar(20) NOT NULL,
  `filed_date` date NOT NULL,
  `period_start_date` date DEFAULT NULL,
  `period_end_date` date NOT NULL,
  `fiscal_year` smallint unsigned NOT NULL,
  `period_type` varchar(16) NOT NULL,
  `fiscal_quarter` tinyint unsigned DEFAULT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `financial_report_listing_accession_uq` (`stock_ticker_id`,`accession_number`),
  KEY `financial_report_accession_number_idx` (`accession_number`),
  KEY `financial_report_period_end_date_idx` (`period_end_date`),
  KEY `financial_report_form_period_idx` (`form_type`,`period_end_date`),
  KEY `financial_report_stock_ticker_idx` (`stock_ticker_id`),
  KEY `financial_report_coverage_idx` (`stock_ticker_id`,`fiscal_year`,`period_type`,`fiscal_quarter`),
  CONSTRAINT `financial_report_stock_ticker_fk`
    FOREIGN KEY (`stock_ticker_id`)
    REFERENCES `stock_ticker` (`stock_ticker_id`)
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Reusable metric definitions. Keys and display names are stored once for all
-- issuers and reports. The persistence layer inserts a definition on first use
-- and reuses its metric_id thereafter.
-- SEC synchronization metadata is stored per entity on stock_ticker.
-- Successful report coverage remains in financial_report; no separate per-accession
-- Round110: sec_filing_sync_state is no longer required; SEC sync checkpoint state lives on stock_ticker.
CREATE TABLE IF NOT EXISTS `financial_metric` (
  `metric_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `metric_key` varchar(128) NOT NULL,
  `metric_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`metric_id`),
  UNIQUE KEY `financial_metric_key_uq` (`metric_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- One value per metric definition and filed report. metric_status preserves
-- the output status (for example Reported/Calculated), while derivation_type
-- preserves DirectCalculatedEstimated semantics (Direct/Calculated/Estimated).
-- verifiable means AlphaQuery reports the same metric, period and unit/currency;
-- verified additionally means the values are within the configured tolerance.
CREATE TABLE IF NOT EXISTS `financial_metric_value` (
  `metric_value_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint unsigned NOT NULL,
  `metric_id` bigint unsigned NOT NULL,
  `metric_value` decimal(65,30) NOT NULL,
  `unit_code` varchar(64) NOT NULL,
  `metric_status` varchar(32) NOT NULL,
  `derivation_type` varchar(32) NOT NULL,
  `is_gaap` tinyint(1) NOT NULL DEFAULT '0',
  `calculation_formula` varchar(1000) DEFAULT NULL,
  `reported_rounding_increment` decimal(65,30) DEFAULT NULL,
  `reported_zero_is_rounded` tinyint(1) NOT NULL DEFAULT '0',
  `verifiable` tinyint(1) NOT NULL DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`metric_value_id`),
  UNIQUE KEY `financial_metric_value_report_metric_uq` (`report_id`,`metric_id`),
  KEY `financial_metric_value_metric_idx` (`metric_id`),
  CONSTRAINT `financial_metric_value_report_fk`
    FOREIGN KEY (`report_id`)
    REFERENCES `financial_report` (`report_id`)
    ON DELETE CASCADE,
  CONSTRAINT `financial_metric_value_metric_fk`
    FOREIGN KEY (`metric_id`)
    REFERENCES `financial_metric` (`metric_id`)
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Atomic filing facts used as provenance/inputs for key metrics.
-- Context dates are retained because a single filing can contain current,
-- comparative, year-to-date and instant facts at the same time. Fact-level
-- rounding metadata is retained independently from metric-level rounding.
CREATE TABLE IF NOT EXISTS `financial_fact` (
  `fact_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint unsigned NOT NULL,
  `taxonomy_name` varchar(64) NOT NULL,
  `concept_name` varchar(255) NOT NULL,
  `unit_code` varchar(64) NOT NULL,
  `reported_value` decimal(65,30) NOT NULL,
  `fact_label` varchar(512) DEFAULT NULL,
  `context_start_date` date DEFAULT NULL,
  `context_end_date` date DEFAULT NULL,
  `reported_rounding_increment` decimal(65,30) DEFAULT NULL,
  `reported_zero_is_rounded` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fact_id`),
  KEY `financial_fact_report_idx` (`report_id`),
  KEY `financial_fact_concept_idx` (`taxonomy_name`,`concept_name`),
  KEY `financial_fact_context_idx` (`report_id`,`context_end_date`,`context_start_date`),
  CONSTRAINT `financial_fact_report_fk`
    FOREIGN KEY (`report_id`)
    REFERENCES `financial_report` (`report_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Many-to-many provenance link: a calculated metric can use multiple facts,
-- while the same fact can support multiple normalized metrics.
CREATE TABLE IF NOT EXISTS `financial_metric_source` (
  `metric_value_id` bigint unsigned NOT NULL,
  `fact_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`metric_value_id`,`fact_id`),
  KEY `financial_metric_source_fact_idx` (`fact_id`),
  CONSTRAINT `financial_metric_source_value_fk`
    FOREIGN KEY (`metric_value_id`)
    REFERENCES `financial_metric_value` (`metric_value_id`)
    ON DELETE CASCADE,
  CONSTRAINT `financial_metric_source_fact_fk`
    FOREIGN KEY (`fact_id`)
    REFERENCES `financial_fact` (`fact_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
