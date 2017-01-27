-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: localhost    Database: BOBROWSKI
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructions` (
  `robot_ID` int(11) NOT NULL AUTO_INCREMENT,
  `robotName` varchar(35) NOT NULL,
  `bricksType_ID` int(11) NOT NULL,
  PRIMARY KEY (`robot_ID`),
  FULLTEXT KEY `robotName` (`robotName`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
INSERT INTO `instructions` VALUES (1,'Holdlamis',7),(2,'Zontrax',6),(3,'Asoka',7),(4,'Sonair',7),(5,'Voltsillam',7),(6,'Sonair',7),(7,'Kanlam',2),(8,'Stronghold',3),(9,'Redhold',4),(10,'Tres-Zap',2),(11,'Alphazap',2),(12,'Zaam-Dox',4),(13,'Tresom',1),(14,'Alphazap',3),(15,'Mat Lam Tam',6),(16,'Latlux',3),(17,'Viva',1),(18,'Sonsing',1),(19,'Matsoft',5),(20,'Bitwolf',4),(21,'Bitchip',1),(22,'Temp',6),(23,'Matsoft',1),(24,'Bitchip',7),(25,'Biodex',7),(26,'Viva',7),(27,'Bytecard',7),(28,'Domainer',3),(29,'Viva',5),(30,'Tempsoft',5),(31,'Lotlux',7),(32,'Opela',3),(33,'Sub-Ex',2),(34,'Tresom',2),(35,'Aerified',2),(36,'Overhold',5),(37,'Sonsing',7),(38,'Bigtax',6),(39,'Prodder',1),(40,'Flowdesk',6),(41,'Tresom',4),(42,'Vagram',1),(43,'Home Ing',5),(44,'Keylex',5),(45,'Gembucket',2),(46,'Sub-Ex',6),(47,'Lotlux',5),(48,'Trippledex',2),(49,'Mat Lam Tam',4),(50,'Bitwolf',2),(51,'Sonair',7),(52,'Tresom',1),(53,'Asoka',6),(54,'Latlux',1),(55,'Quo Lux',4),(56,'Stim',4),(57,'Rank',6),(58,'Cardify',7),(59,'Cardguard',3),(60,'Zathin',4),(61,'Cookley',2),(62,'Sonair',2),(63,'Lotstring',5),(64,'Stringtough',1),(65,'Keylex',7),(66,'Y-Solowarm',6),(67,'Tin',1),(68,'Latlux',5),(69,'Stim',2),(70,'Viva',5),(71,'Pannier',5),(72,'Sonsing',2),(73,'Treeflex',6),(74,'Flowdesk',3),(75,'Namfix',2),(76,'Greenlam',5),(77,'Regrant',6),(78,'Job',1),(79,'Bitchip',4),(80,'Y-Solowarm',4),(81,'Bigtax',5),(82,'Lotlux',1),(83,'Keylex',1),(84,'Tampflex',4),(85,'Fintone',5),(86,'Toughjoyfax',3),(87,'Zontrax',7),(88,'Overhold',1),(89,'Holdlamis',3),(90,'Latlux',6),(91,'Treeflex',3),(92,'Job',7),(93,'Vagram',6),(94,'Voltsillam',6),(95,'It',3),(96,'Sub-Ex',5),(97,'Kanlam',2),(98,'Job',2),(99,'Bigtax',4),(100,'Keylex',2);
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-27  2:39:57
