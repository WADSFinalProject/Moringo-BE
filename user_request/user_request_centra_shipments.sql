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
INSERT INTO `centra_shipments` VALUES (8,'2024-05-18','SiCepat',7,5,1,NULL,NULL,NULL,NULL,'2024-06-20',NULL),(9,'2024-06-20','Sicepat',1,14,1,2,'somewhere in Jakarta','wherever xyz is','Jakarta','2024-06-20',NULL),(10,'2024-06-22','Sicepat',2,10,1,4,'somewhere in Jakarta','wherever xyz is13','Jakarta','2024-06-20',NULL),(21,'2024-06-20','qqqqqq',4,3,1,5,'adsf','sd','Jakarta','2024-06-22',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0¨\0\0\0\0\0G”*\"\0\0	IDATxœ\í\Û!Hkm€ñ³œ\â”;\Ä\"n (*“‚ÈŠ\É1°\Ù\Ì»Án2Áb1˜1Y\Å\âÀuÎ¨\à¡aº²/\ì2.÷zE>>Ï‘=\Ï/÷xxù\Ë\Ã{”Ábõz=\Ï?Q h\ÊðP†‡2<”\á¡ex(\ÃCª\íë¶Ž\Åb\Í\ë\æÃ›¿}Nü\îÍ¿mõ\çn¿ùuŸ\æ\ï\ÞüóG\ïùvûÌœ¿þúŸ\Ù\íá‰‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡Š\Õ\ëõ¨gP<ñP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡jýð©T*öi\Ç\Ç\ÇQ\Ï’\Ö¯wª-\ê\Â322ryyõß…\'\ÊðP†‡2<”\á¡\n_.————GGG{zz\Ú\ÛÛ“\É\ä\ä\ä\ä\Ê\Ê\Êññ1ð›£­ÿm\ÙT*u{{ûñ3\ã\ãã›››333\áŒô€Nüòùü\Ü\Ü\Ü\Ö\ÖVÔƒ„§õOüôôôÀÀÀ\ì\ì\ìøøx\"‘\è\í\í\Ç\ãOOO»»»ooo\'c±\Øþþ~.—‹v\àp´~ø\Ý\Ü\Üd³\ÙB¡\ÐXvuu•J¥\Þ\Þ\Þh§\nýUŸN§ONN’\Édcùòò²±±\íHá ‡‚ ¿¿}}½¹\Ü\ÛÛ‹p˜\Ð\Ð_õ\r\Õjµ»»»V«5–\×\×\×\ét:Ú‘¾š\'>‚ ££cbb¢¹,‹\Ñ\Í\Ãÿô\ãÇ\æu¹\\Žp’p\Êð?=>>6¯ûúú\"œ$†‚ ¨\Õj\Íe\Ëÿg¾aÿõõµq=88844\í<!0|P©T\Ö\ÖÖšË¥¥¥‡	M+‡/•Jggg<óðð0??ww\×X&‰\Õ\Õ\ÕP¦‹X+€S,­‡‡‡s¹\Ü\Ô\Ô\Ô\è\èh\"‘ˆ\Ç\ã•J¥P(noo???7žokk;::\Êd2‘NDø\Ï\è\ì\ì\Ü\Ù\ÙY\\\\üÒ‘¾V~\Õ^&“9??\çTZû\ÄAP(NOOóùü\Õ\Õ\Õýý}¹\\®V«µZ-÷ôô¤\Ó\é\é\é\él6;66õ¤akñðú_õP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðP†‡2<”\á¡ex(\ÃC\ÊðPÿ\\2ñõ\Û-ð`\0\0\0\0IEND®B`‚'),(22,'2024-06-19','aaa',11,11,0,12,'aaa','aaa','Jakarta',NULL,_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\Â\0\0\0\0\0Q¾›\0\0eIDATxœ\íÜ½KVÿ\ÇñŸõMè†‚H\ZŠˆ–j)‚nÀÆ¢.\"°pj\nÊ¡-ZÇˆ‚(‚\îh$\Òj\è\ÈjªˆR›\"¨—J¬P\Ã\áOü¦½¼Žý|<¦Ï¹®\ã\á}OŽ\Êñ²fll\ì?ðg\æ=\0ÿdD€Œ2\"@FÈˆ\0 #dDÀ?3wèšššÊºòÈ¥ü\â¸\'0¾8\á¡&ü\Âq~\Ýg\Ü\å·&|ñ÷9n\à	÷÷\î¸ÓŸð˜“<ù>\ãöœd¶™{ð\ånD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD@\Í\Ø\ØX\Ñ3ð\×s7\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"\àŸ¢øûŒŽŽöôô<xð\àÙ³g¯^½\Z^¾|ù\êÕ«w\î\Üy\àÀ]»v=cµÍ•?¢\è\í\í\í\í\í}ó\æMyñö\í\Û\á\á\áò»¥R©««\ë_òþýûŽŽŽË—/øða’Ý¶l\Ùr\éÒ¥­[·fFÿ+Œ\Í“_„R©ô;\ÇÙ»w\ïo^\Õ\\½zu†Okñ³\Ñ4\íØ±£½½ýÉ“\'?~üþýû»w\ïnÜ¸±yó\æò»?þlnn\î\î\î.v\È\ê)º\ãjøüùóŠ+\ê\ë\ë=\Ú\Þ\Þ~\çÎ\çÏŸßºu«r¦t7:xð\à\ãÇ\'\Ü\áÇ‡®vÕªUß¾}‹ž\Ê,5\'2šPgg\çT3:q\âÄ£G&\ßghhh\íÚµ•#_¼x11\ìl\ç›\Úœ;w\î_[¸paKKKeóÞ½{3<Ô¬ £¼úúú\Êú\åË—NR52Ê««««¬?}úT\à$U#£¼ÁÁÁ\Êz\éÒ¥NR52\Ê{ýúue½fÍš\'©\Z\åýú;\àž={\nœ¤jd\Ö\×\×÷ð\á\Ã\Ê\æ‘#G\n¦jd\Ö\Ú\Ú:22R^\ïÛ·oÓ¦M\Å\ÎS2Jºv\íZ\åHmm\íÙ³g‹§jd\Ó\×\×wüøñ\Êf[[\ÛÆœ§šd”ñõ\ë\×C‡}ùò¥¼Y*•N:U\ìH\Õ$£€\Ñ\ÑÑ¦¦¦/^”77l\Øpó\æÍšššb§ª&´¶¶Vž\Õ\Õ\Õuww/[¶¬Ø‘ªLF\êÂ…\çÏŸ/¯-Z\Ô\ÕÕµnÝºbGª>ý‘»w\ïž<y²¼ž?þ\íÛ··o\ß^\èDÅ\Ñôõôô455ŽŽ–7;::\Z\Z\ZŠ©(2š¦þþþ†††¡¡¡òf[[[sss±#HF\Ó100°ÿþ\Ê\'Ž;vúô\ébG*–Œ¦lhh¨¡¡¡¿¿¿¼\Ù\Ø\ØXù{Î’\ÑÔŒŒŒ466öôô”7w\ï\Þ}ýúõyó\æúeœ\ë\ç?U---•§fÛ¶m\ë\ìì¬­­-v¤\Ù@FSp\æÌ™+W®”\×\ë×¯¿ÿþ’%KŠi¶(ú£)Uò\ë§5~\ÇÊ•+ÿ÷ ‹/ž\Æ~úôiõÏ·\ÊÜs\å?Š0£Ü2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œ2\"@FÈˆ\0 #dD€Œø/\ài)5†du\0\0\0\0IEND®B`‚'),(24,'2024-06-22','exampleexpedition',3,21,0,11,'examplesender','examplereceiver','Jakarta',NULL,_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\Â\0\0\0\0\0Q¾›\0\0ŒIDATxœ\í\ÝÁ\ÚP@\Ñ8š@\ÐAš¡\Z AJa˜\Ø9¤Q‚P’Q\î@\ç¬,\Û<}YW\ß/¦iú\ç\ë£À3·\Ï=\Ãûñû\'—\ËÉ«/07O\Þuó‡W~¼\ç\ê†Ë¥Ošvuÿo§]ýõ´?_\çG§%\ìFdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@F†iš½þ{v#2\" #2\" #2\" #2\" #2\" #2\" #2\" #2\" #2\"ðö\è\Ü\É8Ž‡\Ã\áp8\ì÷û\ËÁñx<ŸÏ—««\Õj»\Ý\Þ\Ô\Óx‰ŒN§\Ób±ø\×F=/5/±\r\Ã0ŸÏ¿ýl·Û­\×\ëŽz&/‘\Ñl6\Çñ\ê\äñx|\ì¨g\â¥F@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@F¦×°\Ùl>ôX–\Ë\åF=\r»ð·|\ìFdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@FdD@F¾\Üi“$j7\0\0\0\0IEND®B`‚');
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
