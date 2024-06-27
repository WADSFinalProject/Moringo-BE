-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: dsdbetter.cpqwe6mas9r9.ap-southeast-1.rds.amazonaws.com    Database: user_request
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `user_signups`
--

DROP TABLE IF EXISTS `user_signups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_signups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `user_role` enum('Centra','XYZ','Harbor') COLLATE utf8mb4_general_ci NOT NULL,
  `country_code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `branch` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_signups`
--

LOCK TABLES `user_signups` WRITE;
/*!40000 ALTER TABLE `user_signups` DISABLE KEYS */;
INSERT INTO `user_signups` VALUES (4,'string','string@gmail.com','somepassword','approved','Harbor',NULL,NULL,'string','string',''),(5,'c','ce@gmail.com','centra','approved','Harbor',NULL,'911','te','t',''),(6,'harbor2','harbor2@gmail.com','harbor2','approved','Harbor',NULL,NULL,'Christoffer','Larkin',''),(8,'centra55','centra55@gmail.com','centra','approved','Centra',NULL,'911','changed','name',''),(9,'centra5','centra5@gmail.com','centra','approved','Centra','+62','089616376969','centra','5',''),(11,'test2','test2@gmail.com','test2','approved','Centra','+62','1111111','test','2','Bandung'),(13,'string','sus@gmail.com','testingpassword','approved','XYZ','+62','80085','string','string',''),(19,'sdf','asdfasdf@gmail.com','sdf','approved','Centra','+1-268','2323','A12','- BRANDON SALIM','Bogor'),(20,'cen','cen@gmail.com','cen','approved','Centra','+62','0000','cen','diskok','Bandung'),(21,'testing','testing@gmail.com','test','approved','Centra','+62','123123','Testing','Full Name','Jakarta'),(23,'cen2','cen2@gmail.com','cen2','approved','Centra','+62','0000','cen2','diskok2','Bandung'),(24,'skibidi2','skibidi2@gmail.com','asdf','approved','Centra','+62','151511','skibidi','toilet2',''),(25,'skibidi','skibidi3@gmail.com','skibidi','approved','Centra','+62','80085','skibidi','toilet3','Jakarta'),(26,'yes','yes@gmail.com','yesyes','approved','XYZ','62','1989','dobdob','yesyes','Jakarta'),(27,'sussy','sussy@gmail.com','sus','approved','Centra','62','69420','sussy','sussy',''),(28,'admin','admin@gmail.com','admin','approved','','62','4242424','admin','admin',''),(31,'example_username','example@gmail.com','example_password','pending','Centra','+62','12312312','Example','Full Name','Jakarta'),(32,'Harbor','harbor@gmail.com','harbor','approved','Harbor','+62','4443333','Harbor','Full Name',NULL);
/*!40000 ALTER TABLE `user_signups` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-27 21:20:00
