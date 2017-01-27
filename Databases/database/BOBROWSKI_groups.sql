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
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_ID` int(11) NOT NULL AUTO_INCREMENT,
  `location_ID` int(11) NOT NULL,
  `description` varchar(35) CHARACTER SET latin2 NOT NULL,
  PRIMARY KEY (`group_ID`),
  FULLTEXT KEY `description` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin2 COLLATE=latin2_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,1,'WFAIS Computer Science'),(2,42,'interdum mauris ullamcorper'),(3,47,'sit amet consectetuer adipiscing'),(4,53,'nibh in'),(5,67,'ultrices posuere'),(6,53,'rhoncus aliquet'),(7,27,'curabitur at ipsum ac'),(8,49,'luctus et ultrices posuere'),(9,37,'luctus rutrum nulla tellus'),(10,15,'suscipit'),(11,49,'nisi volutpat eleifend donec'),(12,32,'suspendisse potenti cras in'),(13,39,'in sagittis'),(14,20,'porta volutpat quam'),(15,12,'vitae nisi'),(16,33,'ante vivamus tortor'),(17,16,'aenean'),(18,31,'rutrum'),(19,26,'lorem quisque ut erat'),(20,60,'fringilla rhoncus mauris'),(21,45,'sem sed sagittis nam'),(22,30,'in blandit ultrices'),(23,13,'nulla facilisi cras'),(24,33,'sagittis sapien cum sociis'),(25,66,'ac tellus semper interdum'),(26,58,'consequat in'),(27,16,'odio'),(28,46,'odio in hac habitasse'),(29,55,'elementum'),(30,57,'rhoncus'),(31,18,'sed augue aliquam erat');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
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
