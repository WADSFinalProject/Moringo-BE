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
-- Table structure for table `centras`
--

DROP TABLE IF EXISTS `centras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centras` (
  `centra_id` int NOT NULL,
  `centra_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `centra_address` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`centra_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centras`
--

LOCK TABLES `centras` WRITE;
/*!40000 ALTER TABLE `centras` DISABLE KEYS */;
INSERT INTO `centras` VALUES (1,'Jakarta','Jl. Sudirman No. 1, Jakarta'),(2,'Surabaya','Jl. Gubernur Suryo No. 15, Surabaya'),(3,'Bandung','Jl. Asia Afrika No. 99, Bandung'),(4,'Medan','Jl. Diponegoro No. 21, Medan'),(5,'Semarang','Jl. Pahlawan No. 45, Semarang'),(6,'Makassar','Jl. Urip Sumoharjo No. 10, Makassar'),(7,'Palembang','Jl. Mayor Zen No. 30, Palembang'),(8,'Depok','Jl. Margonda Raya No. 28, Depok'),(9,'Tangerang','Jl. Jenderal Sudirman No. 50, Tangerang'),(10,'Bekasi','Jl. Ir. H. Juanda No. 80, Bekasi'),(11,'Bandar Lampung','Jl. Zainal Abidin Pagar Alam No. 5, Bandar Lampung'),(12,'Padang','Jl. Hayam Wuruk No. 70, Padang'),(13,'Malang','Jl. Soekarno-Hatta No. 35, Malang'),(14,'Bogor','Jl. Raya Pajajaran No. 25, Bogor'),(15,'Yogyakarta','Jl. Malioboro No. 15, Yogyakarta'),(16,'Pontianak','Jl. Ahmad Yani No. 18, Pontianak'),(17,'Banjarmasin','Jl. A. Yani No. 28, Banjarmasin'),(18,'Serang','Jl. Raya Serang No. 10, Serang'),(19,'Denpasar','Jl. Gatot Subroto No. 21, Denpasar'),(20,'Samarinda','Jl. Pahlawan No. 17, Samarinda'),(21,'Cimahi','Jl. Jendral Sudirman No. 42, Cimahi'),(22,'Mataram','Jl. Pejanggik No. 80, Mataram'),(23,'Pekanbaru','Jl. Sudirman No. 9, Pekanbaru'),(24,'Balikpapan','Jl. Jendral Sudirman No. 3, Balikpapan'),(25,'Jambi','Jl. Soekarno-Hatta No. 11, Jambi'),(26,'Sukabumi','Jl. Pahlawan No. 67, Sukabumi'),(27,'Banda Aceh','Jl. T. Iskandar No. 22, Banda Aceh'),(28,'Cilegon','Jl. Merdeka No. 40, Cilegon'),(29,'Padang Panjang','Jl. Hayam Wuruk No. 23, Padang Panjang'),(30,'Magelang','Jl. Pemuda No. 6, Magelang'),(31,'Tegal','Jl. Ahmad Yani No. 33, Tegal'),(32,'Probolinggo','Jl. Dr. Soetomo No. 19, Probolinggo'),(33,'Purwokerto','Jl. Suryakencana No. 14, Purwokerto'),(34,'Tarakan','Jl. A. Yani No. 8, Tarakan'),(35,'Pasuruan','Jl. Pahlawan No. 2, Pasuruan'),(36,'Bukittinggi','Jl. A. Yani No. 51, Bukittinggi');
/*!40000 ALTER TABLE `centras` ENABLE KEYS */;
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

-- Dump completed on 2024-06-27 21:19:59
