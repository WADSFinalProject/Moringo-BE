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
-- Table structure for table `centra_shipments`
--

DROP TABLE IF EXISTS `centra_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centra_shipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_shipped` date NOT NULL,
  `expedition` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `total_package` int NOT NULL,
  `package_weight` float NOT NULL,
  `is_Delivered` tinyint(1) NOT NULL,
  `powder_batch_id` int DEFAULT NULL,
  `sender_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `receiver_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `centra_sender` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `barcode` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centra_shipments`
--

LOCK TABLES `centra_shipments` WRITE;
/*!40000 ALTER TABLE `centra_shipments` DISABLE KEYS */;
INSERT INTO `centra_shipments` VALUES (8,'2024-05-18','SiCepat',7,5,1,NULL,NULL,NULL,NULL,'2024-06-20',NULL),(9,'2024-06-20','Sicepat',1,14,1,2,'somewhere in Jakarta','wherever xyz is','Jakarta','2024-06-20',NULL),(10,'2024-06-22','Sicepat',2,10,1,4,'somewhere in Jakarta','wherever xyz is13','Jakarta','2024-06-20',NULL),(21,'2024-06-20','qqqqqq',4,3,1,5,'adsf','sd','Jakarta','2024-06-22',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0\0\0G�*\"\0\0	IDATx�\�\�!Hkm���\�;\�\"n (*��Ȋ\�1�\�\���n2�b1�1Y\�\��uΨ\���a��/\�2.�zE>>ϑ=\�/��xx�\�\�{��b�z=\�?Q�h\��P��2<�\�ex(\�C�\�붎\�b\�\�\�Í��}N�\�Ϳm�\�n��u�\�\�\���G\��v�̜����\�\�ቇ2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P���\�\���gP<�P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��j��T*�i\�\�\�Q\��\��w�-\�\�322ryy�߅\'\��P��2<�\�\n_.����GGG{zz\�\�ۓ\�\�\�\�\�\�\�\���1𛣭�m\�T*u{{��3\�\�㛛�333\���N����\�\�\�\�\�Vԃ���O�������\�\�\���x\"�\�\�\�\�\�OOO���ooo�\'c�\���~.��v\�p�~��\�\�\�d�\�B�\�Xvuu�J�\�\�\�h�\n�U�N�ONN�\�dc��򲱱\�H᠇����}}��\�\�ۋp�\�\�_�\r\�j����V�5�\�\�\�\�t:ڑ��\'>����cbb��,�\�\�\���\�Ǐ\�u�\\�p�p\��?=>>6����\"�$�� �\�j\�e\��g�a����q=88844\�<!0|P�T\�\�֚˥���	M+�/�Jggg<���0??ww\�X&�\�\�\�P��X+�S,����s�\�\�\�\�\�\�h\"��\�\�J�P(noo???7�okk;::\�d2�ND�\�\�\�\�\�\�\�Y\\\\�ґ��V~\�^&�9??\�TZ�\�AP(NOO���\�\�\���}�\\�V��Z-�����\�\�\�\�\�l6;66��ak���_�P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P��2<�\�ex(\�C\��P�\\2��\�-�`\0\0\0\0IEND�B`�'),(22,'2024-06-19','aaa',11,11,0,12,'aaa','aaa','Jakarta',NULL,_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\�\0\0\0\0\0�Q��\0\0eIDATx�\�ܽKV�\���M膂H\Z���j)�n�Ƣ.\"�pj\nʡ-Zǈ��(�\�h$\�j\�\�j��R�\"��J�P\�\�O������|<�Ϲ�\�\�}O�\��fll\�?�g\�=\0�dD���2\"@FȈ\0 #dD�?3w蚚�ʺ�ȥ�\�\'0�8\�&�\�q~\�g\�\�&|���9n\�	��\�ӟ�<�>\���d��{�\�nD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD@\�\�\�X\�3�\�s7\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"\�����������<x�\�ٳg�^�\Z^�|�\�իw\�\�y\���]�v=c�͕?�\�\�\�\�\�\�}�\�My��\�\�\�\�\��R���\�_�������˗/��a�ݶl\�r\�ҥ�[�fF�+�\��_�R��;\�ٻw\�o^\�\\�zu�Ok�\�4\�ر����ɓ\'?~�����w\�nܸ�y�\��?�lnn\�\�\�.v\�\�)�\�j����+\�\�\�=\�\�\�~\�Ν\�ϟߺu�r�t7:x�\�\�Ǐ\'\�\�Ǐ��vժU߾}��\�,5\'2�Pgg\�T3:q\�ģG�&\�ghhh\�ڵ�#_�x11\�l\�\��;w\�_[�paKKKe�޽{3<Ԭ �����\��\�˗NR52ʫ����?}�T\�$U#�����\�z\�ҥNR52\�{��ue�f͚\'�\Z\���;\��={\n��jd\�\�\���\�\�\�\�#G\n�jd\�\�\�:22R^\�۷oӦM\�\�S2J�v\�Z\�Hmm\�ٳg���jd\�\�\�w���\�f[[\�ƍ���d���\�\�C�}��Y*�N�:U\�H\�$��\�\�Ѧ��/^�77l\�p�\�͚��b��&���V��\�\�\�uww/[��ؑ�LF\�\�ϟ/�-Z\�\�յnݺbG�>���w\�<y���?�\�۷�o\�^\�DŐ\�����455����7;::\Z\Z\Z��(2������������f[[[sss�#HF\�100���\�\'�;v��\�bG*���lhh��������\�\�\�X�{Β\�Ԍ��466����7w\�\�}���y�\��e�\�\�?U---��f۶m\�\�쬭�-v�\�@FSp\�̙+W��\�\�ׯ����%K�i�(��)U�\�5~\�ʕ+�� �/�\�~��i�Ϸ\�܍�s\�?�0�܍�2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���2\"@FȈ\0 #dD���/\�i)5�du\0\0\0\0IEND�B`�'),(24,'2024-06-22','exampleexpedition',3,21,0,11,'examplesender','examplereceiver','Jakarta',NULL,_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\�\0\0\0\0\0�Q��\0\0�IDATx�\�\���\�P@\�8�@\�A��\Z�AJa�\�9�Q�P�Q\�@\�,\�<}YW\�/�i�\�\��3�������\�=\����\'�\�ɫ/07O\�u�W~�\�\�˥O�vu�o�]����?_\�G�%\�FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@F�i���{v#2\" #2\" #2\" #2\" #2\" #2\" #2\" #2\" #2\"��\�\�\�8��\�\�p8\���\���x<�ϗ��\�j�\�\�\�\�x��N�\�b��\�F=/5/�\r\�0�Ͽ�l�ۭ\�\��z&/�\�l6\��\�\��x|\�g\�F@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@F�װ\�l>�X�\�\�F=\r��|\�FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@F�\�i�$j7\0\0\0\0IEND�B`�');
/*!40000 ALTER TABLE `centra_shipments` ENABLE KEYS */;
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

-- Dump completed on 2024-06-27 21:20:07
