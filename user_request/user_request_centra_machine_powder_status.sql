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
-- Table structure for table `centra_machine_powder_status`
--

DROP TABLE IF EXISTS `centra_machine_powder_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centra_machine_powder_status` (
  `machine_id` int NOT NULL AUTO_INCREMENT,
  `current_weight` float DEFAULT '0',
  `last_started` datetime DEFAULT NULL,
  `is_processing` tinyint(1) DEFAULT '0',
  `remaining_time` int DEFAULT '0',
  `centra_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `finished_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`machine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centra_machine_powder_status`
--

LOCK TABLES `centra_machine_powder_status` WRITE;
/*!40000 ALTER TABLE `centra_machine_powder_status` DISABLE KEYS */;
INSERT INTO `centra_machine_powder_status` VALUES (1,0,'2024-06-22 18:53:54',1,100000,'Jakarta','2024-06-22 11:54:13.075955'),(2,0,'2024-06-15 19:18:25',0,0,'Surabaya','2024-06-15 14:20:41.180341'),(3,0,'2024-06-15 19:20:30',0,0,'Bandung','2024-06-15 14:20:41.180341'),(4,0,'2024-06-15 19:21:38',0,0,'Medan','2024-06-15 14:20:41.180341'),(5,0,'2024-06-15 19:55:28',0,0,'Semarang','2024-06-15 14:20:41.180341'),(6,0,NULL,0,0,'Makassar','2024-06-15 14:20:41.180341'),(7,0,NULL,0,0,'Palembang','2024-06-15 14:20:41.180341'),(8,0,NULL,0,0,'Depok','2024-06-15 14:20:41.180341'),(9,0,NULL,0,0,'Tangerang','2024-06-15 14:20:41.180341'),(10,0,NULL,0,0,'Bekasi','2024-06-15 14:20:41.180341'),(11,0,NULL,0,0,'Bandar Lampung','2024-06-15 14:20:41.180341'),(12,0,NULL,0,0,'Padang','2024-06-15 14:20:41.180341'),(13,0,NULL,0,0,'Malang','2024-06-15 14:20:41.180341'),(14,0,NULL,0,0,'Bogor','2024-06-15 14:20:41.180341'),(15,0,NULL,0,0,'Yogyakarta','2024-06-15 14:20:41.180341'),(16,0,NULL,0,0,'Pontianak','2024-06-15 14:20:41.180341'),(17,0,NULL,0,0,'Banjarmasin','2024-06-15 14:20:41.180341'),(18,0,NULL,0,0,'Serang','2024-06-15 14:20:41.180341'),(19,0,NULL,0,0,'Denpasar','2024-06-15 14:20:41.180341'),(20,0,NULL,0,0,'Samarinda','2024-06-15 14:20:41.180341'),(21,0,NULL,0,0,'Cimahi','2024-06-15 14:20:41.180341'),(22,0,NULL,0,0,'Mataram','2024-06-15 14:20:41.180341'),(23,0,NULL,0,0,'Pekanbaru','2024-06-15 14:20:41.180341'),(24,0,NULL,0,0,'Balikpapan','2024-06-15 14:20:41.180341'),(25,0,NULL,0,0,'Jambi','2024-06-15 14:20:41.180341'),(26,0,NULL,0,0,'Sukabumi','2024-06-15 14:20:41.180341'),(27,0,NULL,0,0,'Banda Aceh','2024-06-15 14:20:41.180341'),(28,0,NULL,0,0,'Cilegon','2024-06-15 14:20:41.180341'),(29,0,NULL,0,0,'Padang Panjang','2024-06-15 14:20:41.180341'),(30,0,NULL,0,0,'Magelang','2024-06-15 14:20:41.180341'),(31,0,NULL,0,0,'Tegal','2024-06-15 14:20:41.180341'),(32,0,NULL,0,0,'Probolinggo','2024-06-15 14:20:41.180341'),(33,0,NULL,0,0,'Purwokerto','2024-06-15 14:20:41.180341'),(34,0,NULL,0,0,'Tarakan','2024-06-15 14:20:41.180341'),(35,0,NULL,0,0,'Pasuruan','2024-06-15 14:20:41.180341'),(36,0,NULL,0,0,'Bukittinggi','2024-06-15 14:20:41.180341');
/*!40000 ALTER TABLE `centra_machine_powder_status` ENABLE KEYS */;
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

-- Dump completed on 2024-06-27 21:20:02
