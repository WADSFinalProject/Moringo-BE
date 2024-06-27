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
-- Table structure for table `centra_moringa_batches`
--

DROP TABLE IF EXISTS `centra_moringa_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centra_moringa_batches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `centra_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `entryDate` date NOT NULL,
  `entryTime` time NOT NULL,
  `weight_received` float NOT NULL,
  `expiry_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centra_moringa_batches`
--

LOCK TABLES `centra_moringa_batches` WRITE;
/*!40000 ALTER TABLE `centra_moringa_batches` DISABLE KEYS */;
INSERT INTO `centra_moringa_batches` VALUES (11,'Purwokerto','2024-06-16','22:38:30',13,'2024-06-17 02:38:30'),(12,'Purwokerto','2024-06-16','22:38:38',6,'2024-06-17 02:38:38'),(13,'Purwokerto','2024-06-16','22:38:41',11,'2024-06-17 02:38:41'),(14,'Bandung','2024-06-17','00:02:57',12,'2024-06-17 04:02:57'),(16,'Bandung','2024-06-16','00:04:29',1,'2024-06-17 04:04:29'),(17,'Bandung','2024-06-17','00:08:10',2,'2024-06-17 04:08:10'),(19,'Bandung','2024-06-09','01:05:37',6.9,'2024-06-17 05:05:37'),(20,'Bandung','2024-06-17','01:06:05',4,'2024-06-17 05:06:05'),(21,'Bandung','2024-06-17','01:07:34',6,'2024-06-17 05:07:34'),(35,'Jakarta','2020-06-18','12:20:06',18,'2024-06-18 16:20:07'),(36,'Jakarta','2024-06-18','12:20:15',12,'2024-06-18 16:20:16');
/*!40000 ALTER TABLE `centra_moringa_batches` ENABLE KEYS */;
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

-- Dump completed on 2024-06-27 21:20:05
