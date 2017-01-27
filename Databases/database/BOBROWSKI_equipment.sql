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
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `equipment_ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(35) NOT NULL,
  `quantity` int(35) NOT NULL,
  `description` text,
  PRIMARY KEY (`equipment_ID`),
  FULLTEXT KEY `name` (`name`,`description`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'LEGO WeDo',32,'Regular LEGO WEDO'),(2,'LEGO WeDo EXTENSION',6,'Extension to LEGO WEDO'),(3,'LEGO WeDo 2',8,'Regular LEGO WEDO 2'),(4,'LEGO NXT 2.0',16,'Regular LEGO NXT'),(5,'LEGO NXT 2.0 EXTENSION',4,'Extension to LEGO WEDO'),(6,'LEGO EV3',10,'Regular LEGO EV3'),(7,'LEGO EV3 EXTENSION',4,'Extension to LEGO EV3'),(8,'Samsung Laptop',8,'Old samsung laptops'),(9,'ASUS Laptop Blue',10,'Bigger ASUS with blue chasis'),(10,'ASUS Laptop White',10,'Bigger ASUS with white chasis'),(11,'ASUS Laptop Gray',10,'Bigger ASUS with gray chasis'),(12,'HP Laptop',5,'Small HP Laptop'),(13,'ASUS Small Laptop',4,'Small ASUS Laptop with touch screen'),(14,'NAO robot',1,'NAO robot, mainly used in events'),(15,'Projector',1,'Projector for classes'),(16,'PEUGEOT Partner',1,'To help transport stuff for classes'),(17,'FORD Focus',1,'To help transport stuff for classes'),(18,'KIA Carens',1,'To help transport stuff for classes');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-27  2:39:56
