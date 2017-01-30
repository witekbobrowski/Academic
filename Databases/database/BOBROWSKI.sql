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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `attendance_ID` int(11) NOT NULL AUTO_INCREMENT,
  `student_ID` int(11) NOT NULL,
  `class_ID` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`attendance_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `attendance_after_insert` AFTER INSERT ON `attendance` FOR EACH ROW
BEGIN
INSERT INTO payments_due (students_ID, class_ID, amount) VALUES (attendance.students_ID, attendance.class_ID, attendance.price);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `class_ID` int(11) NOT NULL AUTO_INCREMENT,
  `group_ID` int(11) NOT NULL,
  `startTime` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `firstInstructor_ID` int(11) DEFAULT NULL,
  `secondInstructor_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`class_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,15,'2017-01-26 01:39:16',2,8,21),(2,3,'2017-01-23 05:09:48',1,10,19),(3,23,'2017-01-26 06:40:58',2,3,30),(4,16,'2017-01-23 06:38:25',2,15,17),(5,2,'2017-01-25 06:09:15',2,2,30),(6,18,'2017-01-26 17:02:57',2,12,17),(7,25,'2017-01-23 13:28:21',2,15,26),(8,12,'2017-01-25 12:44:51',2,12,30),(9,27,'2017-01-23 04:38:36',1,6,22),(10,22,'2017-01-25 07:13:49',1,12,25),(11,9,'2017-01-26 07:27:38',2,8,30),(12,3,'2017-01-27 04:46:58',1,1,20),(13,9,'2017-01-23 06:20:56',1,15,22),(14,24,'2017-01-23 17:49:36',2,6,18),(15,3,'2017-01-26 22:16:36',1,3,26),(16,15,'2017-01-23 16:02:27',2,14,23),(17,1,'2017-01-24 22:03:09',2,1,16),(18,28,'2017-01-25 19:40:58',2,12,30),(19,14,'2017-01-27 11:50:35',2,6,30),(20,21,'2017-01-26 03:41:01',1,10,18),(21,23,'2017-01-25 15:01:53',1,3,27),(22,19,'2017-01-27 14:53:32',2,11,25),(23,10,'2017-01-26 02:09:21',2,3,30),(24,30,'2017-01-27 19:52:23',1,13,21),(25,22,'2017-01-23 00:11:01',2,9,24),(26,19,'2017-01-26 07:15:36',2,8,16),(27,29,'2017-01-23 16:50:42',1,14,16),(28,26,'2017-01-24 03:51:12',2,15,20),(29,22,'2017-01-23 01:04:12',1,4,27),(30,7,'2017-01-27 20:37:53',1,5,18),(31,5,'2017-02-02 15:08:06',2,8,16),(32,4,'2017-01-31 18:04:21',1,12,27),(33,26,'2017-01-30 08:23:41',1,10,26),(34,22,'2017-02-01 23:55:42',1,13,19),(35,5,'2017-02-02 12:20:56',2,4,21),(36,12,'2017-02-02 09:38:05',1,4,28),(37,29,'2017-02-01 09:48:20',2,14,16),(38,24,'2017-02-02 16:11:54',1,12,16),(39,18,'2017-02-02 22:39:31',2,3,24),(40,18,'2017-01-30 09:04:09',1,13,27),(41,2,'2017-01-30 04:27:27',2,15,30),(42,23,'2017-02-02 20:30:49',2,8,18),(43,15,'2017-02-03 20:40:18',2,12,25),(44,25,'2017-02-03 04:18:55',1,10,27),(45,23,'2017-02-02 17:02:35',2,14,28),(46,13,'2017-02-02 01:57:31',2,5,21),(47,14,'2017-01-31 08:25:46',1,10,24),(48,8,'2017-02-03 15:24:14',2,7,28),(49,11,'2017-01-30 23:55:15',2,1,20),(50,20,'2017-01-30 21:50:07',2,14,21),(51,11,'2017-02-03 17:06:15',2,2,24),(52,24,'2017-02-02 21:18:41',2,14,19),(53,20,'2017-02-01 06:28:22',2,2,22),(54,29,'2017-01-30 18:39:07',1,5,30),(55,4,'2017-02-01 08:39:16',2,1,28),(56,28,'2017-01-31 08:45:32',2,13,24),(57,1,'2017-02-03 11:27:25',2,3,21),(58,9,'2017-01-31 06:26:41',1,5,28),(59,16,'2017-01-31 06:48:30',1,12,21),(60,18,'2017-01-31 19:25:43',1,2,17),(61,8,'2017-02-06 15:12:23',1,7,27),(62,19,'2017-02-07 19:48:23',1,1,29),(63,25,'2017-02-10 13:34:19',2,9,22),(64,7,'2017-02-08 03:06:36',2,6,28),(65,18,'2017-02-07 04:28:15',1,3,16),(66,5,'2017-02-06 04:07:28',2,8,23),(67,21,'2017-02-06 11:04:46',1,9,26),(68,7,'2017-02-07 08:59:22',1,5,25),(69,11,'2017-02-06 14:21:58',2,9,17),(70,14,'2017-02-10 11:04:15',2,6,19),(71,2,'2017-02-08 20:58:22',2,8,22),(72,27,'2017-02-10 21:31:30',2,15,25),(73,15,'2017-02-06 04:55:16',1,12,21),(74,2,'2017-02-08 16:56:11',2,15,25),(75,28,'2017-02-08 08:04:20',2,14,27),(76,27,'2017-02-06 13:20:56',1,4,24),(77,20,'2017-02-07 15:02:09',1,13,21),(78,22,'2017-02-06 06:47:27',2,3,21),(79,15,'2017-02-08 07:52:11',2,2,16),(80,24,'2017-02-09 02:48:00',2,8,30),(81,13,'2017-02-08 08:53:39',1,6,21),(82,2,'2017-02-07 15:15:30',2,1,16),(83,16,'2017-02-09 03:16:01',1,3,25),(84,2,'2017-02-10 13:30:04',1,2,29),(85,26,'2017-02-10 06:08:11',1,6,19),(86,9,'2017-02-08 07:38:01',2,12,19),(87,19,'2017-02-06 02:21:18',2,10,22),(88,28,'2017-02-09 18:58:37',2,11,22),(89,13,'2017-02-06 20:48:29',2,8,23),(90,26,'2017-02-08 01:47:23',1,7,19),(91,30,'2017-02-17 16:00:15',2,3,17),(92,12,'2017-02-14 19:33:24',2,13,19),(93,4,'2017-02-13 15:28:15',2,5,16),(94,28,'2017-02-17 21:10:48',2,10,24),(95,8,'2017-02-16 11:50:24',2,8,24),(96,19,'2017-02-16 22:30:39',2,13,27),(97,12,'2017-02-14 05:40:38',1,5,16),(98,16,'2017-02-13 11:38:24',1,10,23),(99,9,'2017-02-17 00:08:27',2,11,28),(100,6,'2017-02-16 11:03:23',2,11,16),(101,12,'2017-02-13 05:13:18',2,8,17),(102,25,'2017-02-15 07:23:27',1,7,23),(103,16,'2017-02-16 13:12:39',1,3,21),(104,28,'2017-02-17 13:55:54',1,3,16),(105,17,'2017-02-16 15:09:07',2,6,20),(106,27,'2017-02-14 19:46:07',1,11,19),(107,21,'2017-02-13 10:10:56',1,6,18),(108,19,'2017-02-17 19:19:10',2,8,24),(109,12,'2017-02-17 03:45:41',1,10,25),(110,5,'2017-02-15 05:44:05',2,2,19),(111,15,'2017-02-14 07:44:45',2,15,26),(112,9,'2017-02-17 21:31:32',1,14,27),(113,9,'2017-02-13 17:06:50',2,9,22),(114,12,'2017-02-14 07:51:18',1,3,16),(115,11,'2017-02-17 02:58:03',1,12,22),(116,23,'2017-02-15 05:08:52',2,12,16),(117,15,'2017-02-16 14:04:50',1,15,22),(118,11,'2017-02-17 17:13:12',2,6,25),(119,20,'2017-02-13 09:35:54',1,1,17),(120,4,'2017-02-13 01:03:44',2,9,24),(121,4,'2017-02-20 19:45:43',1,13,22),(122,20,'2017-02-24 17:53:13',1,13,29),(123,3,'2017-02-23 08:10:14',1,7,16),(124,10,'2017-02-22 22:53:34',2,7,18),(125,19,'2017-02-23 11:10:23',2,10,23),(126,13,'2017-02-24 18:47:54',1,14,29),(127,12,'2017-02-24 11:37:10',2,6,22),(128,5,'2017-02-20 01:30:53',2,8,16),(129,4,'2017-02-20 17:58:46',1,1,19),(130,24,'2017-02-23 06:56:23',1,7,27),(131,27,'2017-02-24 20:38:21',2,9,18),(132,3,'2017-02-22 03:44:45',1,6,30),(133,26,'2017-02-24 12:53:22',1,5,19),(134,21,'2017-02-24 05:17:22',2,4,28),(135,19,'2017-02-20 17:40:45',2,4,25),(136,24,'2017-02-24 00:48:51',2,5,20),(137,14,'2017-02-24 13:18:45',1,2,22),(138,19,'2017-02-22 21:04:54',1,13,19),(139,29,'2017-02-21 02:46:42',2,1,25),(140,3,'2017-02-23 20:44:34',1,15,17),(141,29,'2017-02-23 17:28:18',1,9,28),(142,7,'2017-02-23 01:07:28',1,2,23),(143,9,'2017-02-21 08:59:31',1,4,19),(144,18,'2017-02-23 20:39:19',2,15,29),(145,2,'2017-02-20 05:37:36',2,8,29),(146,5,'2017-02-24 10:16:24',1,4,17),(147,12,'2017-02-22 11:23:47',2,2,20),(148,25,'2017-02-23 01:49:46',1,7,28),(149,1,'2017-02-20 14:34:07',1,10,27),(150,1,'2017-02-23 14:59:59',1,9,26),(151,6,'2017-03-02 08:59:01',1,8,24),(152,29,'2017-03-03 04:02:06',1,14,23),(153,27,'2017-02-27 07:30:43',2,9,28),(154,13,'2017-02-28 06:13:50',1,9,21),(155,29,'2017-03-01 07:28:12',2,6,29),(156,19,'2017-03-02 07:06:03',2,2,20),(157,23,'2017-02-28 14:58:11',2,6,28),(158,14,'2017-02-27 14:06:02',2,11,23),(159,2,'2017-03-01 02:12:55',1,8,19),(160,11,'2017-02-27 18:08:23',2,2,24),(161,5,'2017-03-02 00:31:45',1,2,16),(162,27,'2017-03-01 10:18:15',2,12,24),(163,7,'2017-02-27 20:48:17',1,8,27),(164,22,'2017-03-03 00:45:31',1,10,18),(165,25,'2017-03-01 03:15:14',1,7,30),(166,25,'2017-02-28 13:02:53',1,3,17),(167,9,'2017-02-27 06:35:45',2,15,22),(168,7,'2017-03-01 08:11:18',2,4,19),(169,18,'2017-03-03 06:49:13',1,6,28),(170,8,'2017-02-27 03:30:14',2,8,21),(171,5,'2017-02-27 19:01:48',1,13,21),(172,29,'2017-03-01 05:28:14',1,14,24),(173,19,'2017-02-27 08:16:04',1,7,22),(174,15,'2017-03-03 01:59:25',1,10,22),(175,26,'2017-02-27 04:06:24',2,5,17),(176,30,'2017-02-27 17:17:15',1,4,17),(177,8,'2017-03-03 14:11:33',2,7,20),(178,14,'2017-02-28 05:37:33',2,14,19),(179,11,'2017-03-03 21:46:05',2,12,25),(180,7,'2017-03-01 11:03:33',2,11,29);
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `employee_ID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(35) COLLATE latin2_bin NOT NULL,
  `lastName` varchar(35) COLLATE latin2_bin NOT NULL,
  `email` varchar(255) COLLATE latin2_bin NOT NULL,
  `mobile` int(9) NOT NULL,
  `birthDate` date NOT NULL,
  `studentStatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`employee_ID`),
  UNIQUE KEY `mobile_unique` (`mobile`),
  UNIQUE KEY `email_unique` (`email`),
  FULLTEXT KEY `firstName` (`firstName`,`lastName`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin2 COLLATE=latin2_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Jerry','Collins','jcollins0@about.me',551201728,'2048-12-28',1),(2,'Frances','Cook','fcook1@reuters.com',772524609,'2022-05-27',0),(3,'Michael','Thomas','mthomas2@discuz.net',563671428,'2011-07-26',1),(4,'Patrick','Adams','padams3@w3.org',719976022,'2074-01-15',0),(5,'Joshua','Perez','jperez4@google.es',514411386,'2030-02-18',0),(6,'Maria','Williamson','mwilliamson5@xinhuanet.com',747200270,'2064-03-28',0),(7,'Dorothy','Wheeler','dwheeler6@deviantart.com',720944714,'2058-05-16',1),(8,'Anne','Williams','awilliams7@ning.com',736152950,'2016-08-31',0),(9,'Catherine','Peters','cpeters8@smugmug.com',524599349,'2038-06-08',0),(10,'Theresa','Murphy','tmurphy9@slate.com',704879180,'2013-01-21',1),(11,'Phyllis','Harrison','pharrisona@shareasale.com',717875308,'2059-09-03',0),(12,'Mary','Garrett','mgarrettb@yolasite.com',778232122,'2021-06-25',1),(13,'Pamela','Hanson','phansonc@google.es',783481703,'2029-09-06',1),(14,'Aaron','Myers','amyersd@google.cn',759287129,'2038-08-12',1),(15,'Terry','Morris','tmorrise@mail.ru',772829140,'2006-01-15',0),(16,'Richard','Johnson','rjohnsonf@indiegogo.com',618062340,'2083-09-27',0),(17,'Brian','Simpson','bsimpsong@cloudflare.com',585620765,'2002-05-11',0),(18,'Amanda','Elliott','aelliotth@nbcnews.com',787501304,'2075-07-09',1),(19,'Earl','Nichols','enicholsi@zimbio.com',780950188,'2088-03-07',1),(20,'Betty','Ward','bwardj@wsj.com',793089571,'2005-02-18',0),(21,'Roy','Green','rgreenk@whitehouse.gov',776827847,'2087-04-11',0),(22,'Teresa','Welch','twelchl@dell.com',593705971,'2076-05-14',1),(23,'Jacqueline','Sullivan','jsullivanm@tamu.edu',768341285,'2014-07-27',1),(24,'Carol','Patterson','cpattersonn@miibeian.gov.cn',760791719,'2034-02-16',1),(25,'George','Cole','gcoleo@sitemeter.com',550187214,'2034-01-23',1),(26,'Harold','Anderson','handersonp@google.co.uk',628605486,'2008-10-23',0),(27,'Rebecca','Daniels','rdanielsq@mit.edu',579284844,'2078-07-18',1),(28,'Marilyn','Wheeler','mwheelerr@oracle.com',695845084,'2013-10-02',1),(29,'Albert','Collins','acollinss@salon.com',648981726,'2068-06-24',0),(30,'Wayne','Ramos','wramost@barnesandnoble.com',514974962,'2015-11-15',1),(31,'Jose','Montgomery','jmontgomeryu@wired.com',629234493,'2039-05-09',0);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `equipment_booked`
--

DROP TABLE IF EXISTS `equipment_booked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment_booked` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_booked`
--

LOCK TABLES `equipment_booked` WRITE;
/*!40000 ALTER TABLE `equipment_booked` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_booked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `event_ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `location` varchar(45) DEFAULT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `firstInstructor_ID` int(11) DEFAULT NULL,
  `secondInstructor_ID` int(11) DEFAULT NULL,
  `thirdInstructor_ID` int(11) DEFAULT NULL,
  `fourthInstructor_ID` int(11) DEFAULT NULL,
  `fifthInstructor_ID` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`event_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Temporary view structure for view `instructions_plus`
--

DROP TABLE IF EXISTS `instructions_plus`;
/*!50001 DROP VIEW IF EXISTS `instructions_plus`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `instructions_plus` AS SELECT 
 1 AS `robot_ID`,
 1 AS `robotName`,
 1 AS `bricksType_ID`,
 1 AS `equipment_ID`,
 1 AS `name`,
 1 AS `quantity`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `location_ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `mobile` int(9) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `addressLine1` varchar(35) DEFAULT NULL,
  `postcode` varchar(35) DEFAULT NULL,
  `city` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`location_ID`),
  FULLTEXT KEY `name` (`name`,`email`,`addressLine1`,`postcode`,`city`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'China Foreign Affairs University',597440315,'rmiller0@gmpg.org','5 Jenifer Terrace','33297','Bazha'),(2,'Southwestern University School of Law',545907591,'scarroll1@qq.com','76907 American Drive','32869','Caieiras'),(3,'Universitat Pompeu Fabra',743297924,'hbennett2@europa.eu','1649 Sutteridge Road','31693','Zengjia'),(4,'Western Kentucky University',565564252,'dwatkins3@prlog.org','3176 Parkside Court','30438','Parengan'),(5,'Seigakuin University',536597376,'kramirez4@nifty.com','67173 Monica Pass','33528','Zea'),(6,'Academy of Economics in Poznan',608275527,'lharvey5@boston.com','363 Monica Hill','35091','Macau'),(7,'Pontifícia Universidade Católica do Rio de Janeiro',759760329,'dcarpenter6@networksolutions.com','7 Thierer Trail','39359','Berezanka'),(8,'Solapur University',526507110,'sburton7@geocities.com','20253 Ridgeway Terrace','35586','Nastola'),(9,'Sapporo International University',585091588,'caustin8@cmu.edu','024 Forest Dale Street','39727','Izumo'),(10,'Appalachian State University',769395812,'cdixon9@europa.eu','0373 Carpenter Hill','38649','Washington'),(11,'Vellore Institute of Technology',555290731,'mstewarta@hc360.com','41 Gale Pass','30729','Anren Chengguanzhen'),(12,'Gemological Institute of America',632211441,'rpattersonb@instagram.com','99 Sullivan Alley','37472','Tengjia'),(13,'Ecole Nationale d\'Architecture',606389157,'rwhitec@yahoo.co.jp','36 Fuller Plaza','36029','Mobile'),(14,'Universidad Francisco de Paula Santander',714776157,'fcastillod@apple.com','28 Eastwood Trail','32797','Xinyang'),(15,'Southwest University of Nationalities',730456349,'amartineze@sbwire.com','415 Rowland Center','35846','Huanghuai'),(16,'Tokyo University of Pharmacy and Life Science',635091818,'pgriffinf@uiuc.edu','54 Farwell Point','38513','Halat'),(17,'Slippery Rock University',581715089,'wgeorgeg@e-recht24.de','5 Sauthoff Park','37655','Apopa'),(18,'Kumamoto Institute of Technology',719837575,'gperezh@elpais.com','39 Mariners Cove Parkway','39460','Sanxi'),(19,'Perm State Medical Academy',704946909,'treedi@webeden.co.uk','80 Waywood Lane','31437','Loppi'),(20,'St. Leo College',683252867,'jcolemanj@seattletimes.com','846 Cherokee Street','38760','Jatisari'),(21,'Morris College',513793240,'cgeorgek@slate.com','4 Bonner Street','39299','Santa Cruz'),(22,'Mohi-ud-Din Islamic University',586426932,'alewisl@cloudflare.com','7218 Clyde Gallagher Street','38920','Sironko'),(23,'Technological Education Institute of Heraklion',770094378,'sallenm@w3.org','8 Hanson Circle','36732','Guadalupe'),(24,'Erskine College',554565934,'fholmesn@photobucket.com','8 Westport Point','30757','Casal da Anja'),(25,'Nile Valley University',754160129,'dmasono@time.com','2 Clyde Gallagher Way','30951','Socorro'),(26,'Akwa Ibom State University of Technology',559563912,'dholmesp@photobucket.com','0 Huxley Street','33305','Jarabacoa'),(27,'Evangelische Fachhochschule Darmstadt',755923225,'amurrayq@jalbum.net','605 Upham Terrace','37610','La Maná'),(28,'Northwest A&F University',615417990,'ccooperr@baidu.com','596 Paget Pass','37719','Lab'),(29,'Moldova State University of Medicine and Pharmacy \"N. Testemitsanu\"',629170952,'bbarness@sitemeter.com','27 Everett Crossing','33286','Tournai'),(30,'Trisakti Institute of Tourism ',608872222,'awilliamst@t.co','88534 Pankratz Terrace','37487','São Pedro de Muel'),(31,'Portland State University',706525409,'kriverau@digg.com','320 Spohn Center','38353','Chengdong'),(32,'Universidad de la Marina Mercante',602351612,'lnelsonv@dyndns.org','75 Kings Park','33897','Nanaimo'),(33,'University College of Technology & Innovation (UCTI)',754385523,'pgilbertw@dion.ne.jp','2 Bashford Center','32851','Kokoshkino'),(34,'Universitat Internacional de Catalunya',580721566,'alanex@theguardian.com','26656 Merrick Center','38216','Sabnie'),(35,'Lansbridge University',528215867,'dsandersy@eventbrite.com','62 Rowland Circle','38235','Camingawan'),(36,'Fred Hutchinson Cancer Research Center',587358112,'kphillipsz@360.cn','75270 Dennis Place','38054','Salcedo'),(37,'University of Texas Southwestern Medical Center at Dallas',621280522,'ckelley10@about.com','0 Ridge Oak Alley','33047','Rimouski'),(38,'Universitas Muhammadiyah Surakarta',634341634,'rmccoy11@github.com','6845 Rockefeller Street','31116','Gävle'),(39,'Kyunghee University',682126906,'mbowman1r@hud.gov','40 Rockefeller Crossing','31294','Zarów'),(40,'Higher School o Business in Tarnow',554822471,'mhunter1t@quantcast.com','414 Linden Crossing','31511','Banjar Taro Kelod'),(41,'Westwood College',531939471,'crobertson1u@google.cn','75821 Killdeer Terrace','31215','Iwamizawa'),(42,'Trinity International University',753969413,'cmiller1v@house.gov','929 Lien Trail','35827','Cap Malheureux'),(43,'International Budo University',578459889,'nowens1w@nba.com','17206 New Castle Place','36318','Nioro'),(44,'Universidad San Juan de la Cruz',711304095,'jcrawford1x@gravatar.com','04464 Loeprich Plaza','39777','Tomakomai'),(45,'Institución Universitaria Iberoamericana',665854352,'esmith0@upenn.edu','6384 Miller Trail','34183','Balbagay'),(46,'Beijing Petroleum University',619277152,'lsimmons1@discuz.net','0971 Everett Court','37954','Cabeças Verdes'),(47,'Suan Dusit Rajabhat University',717835639,'icollins2@stanford.edu','20 Sachtjen Road','31511','Jingning Chengguanzhen'),(48,'Universitas Jenderal Soedirman',615062075,'jowens3@bloomberg.com','63925 Stuart Terrace','35536','Kendari'),(49,'European University',604935472,'glewis4@lulu.com','74821 Talisman Road','39588','Jixi'),(50,'Open University Malaysia',658968226,'rlittle5@photobucket.com','3899 Mifflin Terrace','31313','Piraí do Sul'),(51,'Kanazawa University',636992315,'ameyer6@fastcompany.com','78043 Redwing Junction','39104','Skokovi'),(52,'Mangalore University',514886303,'bjones7@amazon.co.uk','6848 Helena Trail','36696','Dorotea'),(53,'Union College Kentucky',646198059,'emorales8@themeforest.net','9 Cambridge Park','32775','Kuala Lumpur'),(54,'Universidade São Judas Tadeu',782028476,'egarza9@wikispaces.com','53990 Charing Cross Avenue','35967','Artémida'),(55,'Universidad de Extremadura',734393531,'sknighta@studiopress.com','3 Jenna Plaza','34158','La Rioja'),(56,'Chongqing University of Post and Telecommunications',659401082,'jchapmanb@gov.uk','7 Randy Way','30577','Banjar'),(57,'Shah Abdul Latif University Khairpur',629224834,'jricec@furl.net','0 Declaration Court','32908','Despotovac'),(58,'California State Polytechnic University - Pomona',577156343,'lkelly0@state.tx.us','75 Glendale Center','35018','Bosanski Novi'),(59,'Universidad Autónoma de Querétaro',642854707,'amartinez1@stumbleupon.com','7328 Laurel Hill','35964','Auriflama'),(60,'Divine Word College',559206317,'nryan2@is.gd','170 Mallard Point','34874','Solingen'),(61,'Grantham University',617267394,'khill3@bluehost.com','9594 Farwell Hill','32577','Mboto'),(62,'Georgetown College',604376580,'lfields4@google.de','07925 Sage Terrace','33456','Saint-Félicien'),(63,'National Institute of Education',770595887,'jrichardson5@deviantart.com','99481 Dawn Street','37901','Santiago de los Caballeros'),(64,'St. Petersburg State Technological University of Plant Polymers',640600758,'abailey6@goodreads.com','5856 Erie Trail','30937','Cabinda'),(65,'Western State University College of Law',798477792,'jlawrence7@unc.edu','27 Elka Place','38147','Andaray'),(66,'Jilin Agricultural University',774559493,'cclark8@artisteer.com','259 Kenwood Parkway','31263','Napoli'),(67,'Osaka University of Pharmaceutical Sciences',637642188,'lgraham9@earthlink.net','8 Oxford Alley','35672','Tajike’abati'),(68,'Technological Education Institute of Thessaloniki',556441242,'bpaynea@stanford.edu','6782 Eliot Place','35374','Talayan'),(69,'Université Panthéon-Assas (Paris II)',758665832,'srobertsonb@webs.com','66 Everett Park','32035','Kankan'),(70,'Tzu Chi College of Medicine and Humanities',542991977,'lsimpsonc@opera.com','17 Oriole Park','36569','Jacksonville');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `payment_ID` int(11) NOT NULL AUTO_INCREMENT,
  `student_ID` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`payment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments_due`
--

DROP TABLE IF EXISTS `payments_due`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments_due` (
  `payments_ID` int(11) NOT NULL AUTO_INCREMENT,
  `student_ID` int(11) NOT NULL,
  `class_ID` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`payments_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_due`
--

LOCK TABLES `payments_due` WRITE;
/*!40000 ALTER TABLE `payments_due` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments_due` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `BOBROWSKI`.`payments_due_before_delete` BEFORE DELETE ON `payments_due` FOR EACH ROW
BEGIN
	INSERT INTO payments (student_ID, date, amount) VALUES (payments_due.student_ID, CURDATE() ,payments_due.amount);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `student_ID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(35) NOT NULL,
  `lastName` varchar(35) NOT NULL,
  `birthDate` date DEFAULT NULL,
  `homeTown` varchar(35) NOT NULL,
  `contactName` varchar(70) DEFAULT NULL,
  `contactEmail` varchar(255) DEFAULT NULL,
  `contactMobile` varchar(9) DEFAULT NULL,
  `mainGroup_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_ID`),
  UNIQUE KEY `contactsEmail_unique` (`contactEmail`),
  UNIQUE KEY `contactsMobile_unique` (`contactMobile`),
  FULLTEXT KEY `firstName` (`firstName`,`lastName`,`homeTown`,`contactName`,`contactEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Susan','Fisher','2005-05-10','Lizhuangzi','Susan Fisher','sfisher0@hugedomains.com','756688482',11),(2,'Gary','Shaw','2008-10-02','Priyutovo','Gary Shaw','gshaw1@census.gov','709549530',8),(3,'Timothy','Austin','2009-03-30','Itaberaí','Timothy Austin','taustin2@g.co','643265835',11),(4,'Cynthia','Collins','2011-12-21','Sujiazhuang','Cynthia Collins','ccollins3@simplemachines.org','783175217',19),(5,'Joshua','Kelley','2006-09-21','Vidovci','Joshua Kelley','jkelley4@cornell.edu','637750586',3),(6,'Jose','Chavez','2010-08-26','Taquaritinga','Jose Chavez','jchavez5@example.com','834996781',20),(7,'Amy','Taylor','2008-08-13','Sexiong','Amy Taylor','ataylor6@guardian.co.uk','660087672',15),(8,'Raymond','Rivera','2005-08-16','Šuto Orizare','Raymond Rivera','rrivera7@kickstarter.com','817828703',3),(9,'Kathy','Peters','2006-06-26','Anderstorp','Kathy Peters','kpeters8@rediff.com','626018056',3),(10,'Eric','Hicks','2009-12-15','Sukacai','Eric Hicks','ehicks9@ezinearticles.com','848269585',4),(11,'Frank','Morris','2010-12-13','Echarate','Frank Morris','fmorrisa@gravatar.com','724855645',27),(12,'Elizabeth','Cooper','2008-09-25','Barlinek','Elizabeth Cooper','ecooperb@qq.com','876160037',29),(13,'Wanda','Martinez','2009-08-17','Vilca','Wanda Martinez','wmartinezc@whitehouse.gov','892980356',4),(14,'Janet','Wagner','2007-11-16','Gemena','Janet Wagner','jwagnerd@hubpages.com','725000183',15),(15,'Christine','Martinez','2011-01-12','Lampa','Christine Martinez','cmartineze@state.tx.us','616603274',8),(16,'Wayne','Cruz','2008-08-14','Jambangan','Wayne Cruz','wcruzf@harvard.edu','750097842',5),(17,'Michelle','Bell','2010-06-17','Andarapa','Michelle Bell','mbellg@spotify.com','555903211',7),(18,'Billy','Martin','2011-07-12','Suisan','Billy Martin','bmartinh@cbsnews.com','850783640',27),(19,'Margaret','Larson','2006-01-27','Kota Kinabalu','Margaret Larson','mlarsoni@blogger.com','815577650',9),(20,'Timothy','Harper','2006-08-05','Tisno','Timothy Harper','tharperj@blogspot.com','757345503',4),(21,'Johnny','Ramos','2008-10-05','Mekarjaya Satu','Johnny Ramos','jramosk@google.ru','653037179',7),(22,'Ruth','Grant','2010-09-25','Sindong','Ruth Grant','rgrantl@techcrunch.com','516997600',30),(23,'Christina','Rice','2007-04-20','Gaobu','Christina Rice','cricem@stanford.edu','625636690',13),(24,'Ann','Alexander','2006-06-22','Firenze','Ann Alexander','aalexandern@yelp.com','746633196',10),(25,'Peter','Powell','2005-02-11','Jindong','Peter Powell','ppowello@tmall.com','819410808',4),(26,'Martin','Hall','2006-05-17','Örnsköldsvik','Martin Hall','mhallp@studiopress.com','633161109',9),(27,'Clarence','Scott','2010-01-03','Greenhills','Clarence Scott','cscottq@timesonline.co.uk','582258022',11),(28,'Charles','Hanson','2006-10-29','Labog','Charles Hanson','chansonr@time.com','620943866',15),(29,'Lois','Boyd','2011-03-10','La Calera','Lois Boyd','lboyds@mozilla.com','727546612',7),(30,'Adam','Burns','2010-06-16','Zalantun','Adam Burns','aburnst@quantcast.com','774124384',2),(31,'Marilyn','Gilbert','2006-04-13','Marystown','Marilyn Gilbert','mgilbertu@yolasite.com','845298910',20),(32,'Justin','Martin','2009-12-11','Dalai','Justin Martin','jmartinv@mozilla.org','774866086',26),(33,'Virginia','Wright','2009-07-14','Orlovskiy','Virginia Wright','vwrightw@diigo.com','682279973',11),(34,'Beverly','Hart','2010-03-15','Pueblo Viejo','Beverly Hart','bhartx@squidoo.com','702361070',12),(35,'Kelly','Lee','2010-09-06','Tiebukenwusan','Kelly Lee','kleey@msn.com','768432953',17),(36,'Julie','Riley','2005-09-29','Haurpanggung','Julie Riley','jrileyz@redcross.org','793694605',16),(37,'Doris','Hansen','2009-05-05','Shaheying','Doris Hansen','dhansen10@oaic.gov.au','561858067',6),(38,'Brandon','Shaw','2011-10-28','Orikum','Brandon Shaw','bshaw11@cargocollective.com','538882205',5),(39,'Sharon','Ray','2011-04-18','General Arenales','Sharon Ray','sray12@seesaa.net','535864180',28),(40,'Andrea','Cook','2006-10-25','Steinkjer','Andrea Cook','acook13@gov.uk','736225589',28),(41,'Michelle','Henderson','2009-11-22','Bulls','Michelle Henderson','mhenderson14@weibo.com','610156625',30),(42,'Johnny','Rodriguez','2011-12-24','Cái Nhum','Johnny Rodriguez','jrodriguez15@opensource.org','776263128',22),(43,'Paul','Carroll','2008-11-20','São Mateus','Paul Carroll','pcarroll16@wikispaces.com','867147458',16),(44,'Cynthia','Dixon','2006-04-24','Alcorriol','Cynthia Dixon','cdixon17@people.com.cn','572749765',31),(45,'Nancy','Campbell','2008-04-03','Cravinhos','Nancy Campbell','ncampbell18@admin.ch','824280967',31),(46,'Sarah','Butler','2005-06-11','Qingfa','Sarah Butler','sbutler19@examiner.com','549286090',19),(47,'Kevin','Pierce','2009-07-12','Gradishtë','Kevin Pierce','kpierce1a@drupal.org','584499806',26),(48,'Jesse','Mason','2005-02-04','Xiaochi','Jesse Mason','jmason1b@constantcontact.com','779586603',12),(49,'Brenda','Diaz','2011-06-24','Cilongkrangpusaka','Brenda Diaz','bdiaz1c@webmd.com','584178440',27),(50,'Julie','Rice','2011-01-12','Wright','Julie Rice','jrice1d@ovh.net','644724511',6),(51,'Norma','Lawrence','2010-08-19','Xiaolou','Norma Lawrence','nlawrence1e@behance.net','508173487',25),(52,'Kathleen','King','2009-11-22','Masebewa','Kathleen King','kking0@diigo.com','585453192',21),(53,'Brian','Robertson','2005-04-09','Cicurug','Brian Robertson','brobertson1@sohu.com','705289530',30),(54,'Annie','Greene','2011-06-23','Lamam','Annie Greene','agreene2@springer.com','603468956',29),(55,'Ryan','Myers','2008-08-15','Chenggan','Ryan Myers','rmyers3@123-reg.co.uk','622927890',6),(56,'Mark','Willis','2010-02-10','Providencia','Mark Willis','mwillis4@skype.com','717407205',3),(57,'Kathleen','Fox','2010-12-19','San Francisco','Kathleen Fox','kfox5@list-manage.com','896034679',15),(58,'Fred','Clark','2009-12-23','Shalazhi','Fred Clark','fclark6@weather.com','841888288',10),(59,'Jack','Hughes','2007-01-08','Shuidun','Jack Hughes','jhughes1h@yale.edu','718933856',7),(60,'Jason','West','2009-08-20','Salsipuedes','Jason West','jwest1i@eventbrite.com','764881000',7),(61,'James','Brown','2006-05-13','Belozërskoye','James Brown','jbrown1j@state.tx.us','680890018',31),(62,'Lawrence','White','2008-12-14','Tongda','Lawrence White','lwhite1k@ebay.com','661286987',11),(63,'Sean','Riley','2007-05-28','Wonorejo','Sean Riley','sriley1l@usnews.com','769749867',26),(64,'Mark','Jordan','2005-09-27','Carpina','Mark Jordan','mjordan1m@nymag.com','587500144',5),(65,'Cynthia','Henderson','2006-06-30','Kotel’niki','Cynthia Henderson','chenderson0@adobe.com','884876058',11),(66,'Jonathan','Hansen','2012-01-28','Huilong','Jonathan Hansen','jhansen1@apache.org','879149322',21),(67,'Theresa','Bowman','2005-09-04','Vrtojba','Theresa Bowman','tbowman4@elegantthemes.com','538914164',20),(68,'Eric','Scott','2008-06-25','Fuying','Eric Scott','escott5@nsw.gov.au','684152006',19),(69,'Carl','Cooper','2007-11-27','Dubna','Carl Cooper','ccooper6@livejournal.com','678527601',19),(70,'Justin','Foster','2006-03-09','Jamaica','Justin Foster','jfoster7@addtoany.com','864609269',30),(71,'Rose','Vasquez','2011-06-23','Eci','Rose Vasquez','rvasquez8@cnbc.com','625822425',13),(72,'Ernest','Greene','2006-10-16','Padova','Ernest Greene','egreene9@illinois.edu','564442715',8),(73,'Ruby','Stone','2005-10-20','Kananya','Ruby Stone','rstonea@wordpress.com','845831192',6),(74,'Stephen','Mills','2009-04-13','Smithers','Stephen Mills','smillsb@apache.org','530880394',1),(75,'Rachel','Williamson','2010-06-26','Bongued','Rachel Williamson','rwilliamsonc@tuttocitta.it','501331542',31),(76,'Robin','Little','2005-05-22','Angatel','Robin Little','rlittled@usatoday.com','628444778',12),(77,'Rebecca','Flores','2009-05-31','Jujur','Rebecca Flores','rfloresf@people.com.cn','789177278',12),(78,'Judy','Diaz','2011-11-10','Smarhon’','Judy Diaz','jdiazg@umich.edu','596850090',11),(79,'Eric','Fuller','2007-01-03','Bai’e','Eric Fuller','efullerh@fda.gov','606417804',24),(80,'Antonio','Mcdonald','2006-03-12','Selemadeg Kelod','Antonio Mcdonald','amcdonaldi@diigo.com','696155468',21),(81,'James','Ellis','2010-12-26','Kasimov','James Ellis','jellisj@wunderground.com','761167386',25),(82,'Jonathan','Mcdonald','2010-02-11','Seattle','Jonathan Mcdonald','jmcdonaldk@nymag.com','625267587',1),(83,'Roger','Davis','2006-12-04','Mourelos','Roger Davis','rdavisl@reverbnation.com','769286610',9),(84,'Kimberly','Howell','2006-10-22','Hechun','Kimberly Howell','khowellm@webnode.com','561231657',27),(85,'Todd','James','2008-01-04','Independencia','Todd James','tjamesn@hexun.com','590572634',23),(86,'Ann','Morales','2008-05-17','Catungawan Sur','Ann Morales','amoraleso@cloudflare.com','891049721',19),(87,'Matthew','Young','2009-10-31','Libon','Matthew Young','myoungp@cdbaby.com','735013220',11),(88,'Gregory','Scott','2011-11-15','Wutan','Gregory Scott','gscottq@latimes.com','814975321',30),(89,'Johnny','Stewart','2012-01-04','Astypálaia','Johnny Stewart','jstewartr@google.com','724755562',11),(90,'Laura','Hunter','2010-09-21','Namyangju','Laura Hunter','lhunters@psu.edu','530995348',14),(91,'Lillian','Wells','2011-05-27','Tawau','Lillian Wells','lwellst@biblegateway.com','558979990',3),(92,'Margaret','Jones','2011-04-25','Sheffield','Margaret Jones','mjonesu@nytimes.com','635548363',27),(93,'Mary','Bell','2010-09-28','Dzerzhinskiy','Mary Bell','mbellv@shop-pro.jp','683400787',13),(94,'Jonathan','Shaw','2009-06-20','Marne-la-Vallée','Jonathan Shaw','jshaww@deliciousdays.com','570267199',20),(95,'Julia','Taylor','2009-03-23','Bokhan','Julia Taylor','jtaylorx@washington.edu','734782771',6),(96,'Julie','Gray','2007-09-30','Çlirim','Julie Gray','jgrayy@xing.com','656181853',31),(97,'Richard','Elliott','2008-10-21','Cerklje na Gorenjskem','Richard Elliott','relliottz@tripadvisor.com','734682071',27),(98,'Kimberly','Hill','2005-10-10','Nong Muang Khai','Kimberly Hill','khill10@earthlink.net','618463671',22),(99,'Timothy','Boyd','2011-01-11','Wuyang','Timothy Boyd','tboyd11@nature.com','550869106',25),(100,'Clarence','Bishop','2010-06-19','Jombang','Clarence Bishop','cbishop12@reference.com','521523431',30),(101,'Lawrence','Edwards','2009-05-03','Esperanza','Lawrence Edwards','ledwards13@omniture.com','860607558',10),(102,'Ann','Morales','2007-10-13','Vydreno','Ann Morales','amorales14@baidu.com','805192743',31),(103,'John','Harris','2011-11-05','Swedru','John Harris','jharris15@delicious.com','750784567',14),(104,'Anthony','Elliott','2008-06-05','Eslöv','Anthony Elliott','aelliott16@army.mil','611456636',13),(105,'Raymond','Clark','2009-10-05','San Antonio','Raymond Clark','rclark17@odnoklassniki.ru','726447540',31),(106,'Angela','Payne','2008-11-11','Chang’an','Angela Payne','apayne18@altervista.org','507480509',7),(107,'Jeremy','Scott','2009-06-10','Chýnov','Jeremy Scott','jscott19@deviantart.com','817258710',19),(108,'Craig','Hernandez','2011-08-06','Xunzhong','Craig Hernandez','chernandez1a@discovery.com','804779073',22),(109,'Carlos','Wright','2009-06-06','Pokrovskoye','Carlos Wright','cwright1b@jiathis.com','793091105',28),(110,'Arthur','Lynch','2007-05-03','Proletarsk','Arthur Lynch','alynch1c@prweb.com','654764344',16),(111,'Brandon','Jackson','2010-10-29','Kebonkaret','Brandon Jackson','bjackson1d@virginia.edu','840022626',9),(112,'Jimmy','Dunn','2011-10-25','Bystrany','Jimmy Dunn','jdunn1e@europa.eu','592977342',6),(113,'Martin','Harris','2008-03-28','Nikolinci','Martin Harris','mharris1f@nsw.gov.au','548675420',19),(114,'Jesse','Rodriguez','2011-06-13','Los Frentones','Jesse Rodriguez','jrodriguez1g@bbb.org','751410050',11),(115,'Kelly','Bennett','2009-02-22','Norrköping','Kelly Bennett','kbennett1h@nytimes.com','676571499',29),(116,'Patricia','Greene','2009-09-09','Huating','Patricia Greene','pgreene1i@dedecms.com','803820034',18),(117,'Chris','Wood','2010-04-17','Skalbmierz','Chris Wood','cwood1j@lycos.com','809311649',12),(118,'Patricia','King','2008-04-03','Lazaro Cardenas','Patricia King','pking1k@techcrunch.com','768422370',24),(119,'Pamela','Fernandez','2008-03-13','Linshe','Pamela Fernandez','pfernandez1m@rakuten.co.jp','696095345',25),(120,'Theresa','Bryant','2006-09-27','Lohong','Theresa Bryant','tbryant1n@fda.gov','806232660',20),(121,'Ann','Banks','2011-03-22','San Miguel','Ann Banks','abanks1o@ed.gov','719764082',11),(122,'Joe','Roberts','2005-10-14','Pueblo Nuevo','Joe Roberts','jroberts1p@ehow.com','779462703',2),(123,'Jesse','Thompson','2010-08-29','Pasarkolot','Jesse Thompson','jthompson1q@trellian.com','567396246',12),(124,'Alice','Grant','2011-09-25','Concepción Tutuapa','Alice Grant','agrant1r@tiny.cc','655659556',5),(125,'Craig','Howard','2009-08-25','Wugui','Craig Howard','choward1s@parallels.com','537195810',2),(126,'Keith','Washington','2007-08-15','Kulautuva','Keith Washington','kwashington1t@spiegel.de','836156705',27),(127,'Elizabeth','Kelley','2009-06-08','Vreshtas','Elizabeth Kelley','ekelley1u@paginegialle.it','654355605',13),(128,'Denise','Williamson','2010-05-27','Tutut','Denise Williamson','dwilliamson1v@wired.com','625786780',16),(129,'Jane','Mills','2006-07-27','Kertosari','Jane Mills','jmills1w@google.it','799620991',23),(130,'Helen','Carpenter','2009-12-22','São Sebastião do Caí','Helen Carpenter','hcarpenter1x@berkeley.edu','606830751',2),(131,'Brian','Stanley','2006-03-08','Goulmima','Brian Stanley','bstanley1y@hexun.com','599164782',1),(132,'Carol','Richardson','2009-10-30','Fengqiao','Carol Richardson','crichardson20@cornell.edu','803239884',22),(133,'Denise','Simpson','2005-10-17','Saint-Louis du Sud','Denise Simpson','dsimpson21@slideshare.net','799426069',28),(134,'Anne','Harvey','2006-08-09','Taling Chan','Anne Harvey','aharvey22@a8.net','729783677',7),(135,'Philip','Mitchell','2011-03-23','Marseille','Philip Mitchell','pmitchell23@yandex.ru','509804182',17),(136,'Joe','Graham','2005-03-14','Kristiansand S','Joe Graham','jgraham24@surveymonkey.com','831695538',14),(137,'Rose','Dunn','2009-08-15','Margoyoso','Rose Dunn','rdunn25@yandex.ru','874869898',25),(138,'Jack','Edwards','2006-10-29','España','Jack Edwards','jedwards26@ycombinator.com','580756640',5),(139,'Cynthia','Foster','2009-02-07','Gagarawa','Cynthia Foster','cfoster27@weebly.com','685602532',14),(140,'Jeffrey','Fuller','2011-02-22','Arosbaya','Jeffrey Fuller','jfuller28@desdev.cn','607062007',5),(141,'Andrew','Hanson','2010-11-15','Kalmar','Andrew Hanson','ahanson29@4shared.com','841179357',29),(142,'Amanda','Crawford','2009-07-20','Vostochnyy','Amanda Crawford','acrawford2a@accuweather.com','581528413',15),(143,'Billy','Washington','2011-07-22','Hayang','Billy Washington','bwashington2b@dot.gov','600254676',24),(144,'Jessica','Peterson','2008-11-29','Valtelheiro','Jessica Peterson','jpeterson2c@twitter.com','656344838',23),(145,'Heather','James','2009-12-12','Airmadidi','Heather James','hjames2d@imdb.com','718703393',26),(146,'Carlos','Howard','2010-04-07','Longqiao','Carlos Howard','choward2e@tripadvisor.com','811438726',8),(147,'Ryan','Lawson','2010-03-06','Dulyapino','Ryan Lawson','rlawson2f@typepad.com','530256480',31),(148,'Carol','Ramos','2011-04-01','Yuelai','Carol Ramos','cramos2g@cyberchimps.com','598401273',24),(149,'Heather','Meyer','2011-03-19','Wang Hin','Heather Meyer','hmeyer2h@opera.com','822683901',4),(150,'Stephanie','Warren','2010-04-08','Huangtan','Stephanie Warren','swarren2i@seesaa.net','864686027',30),(151,'Patricia','Cook','2007-06-21','Paobulan','Patricia Cook','pcook2j@msu.edu','876689659',7),(152,'Marilyn','Mills','2011-08-04','Cimo de Vila','Marilyn Mills','mmills2k@statcounter.com','835337591',3),(153,'Willie','Sanders','2005-04-13','Ängelholm','Willie Sanders','wsanders2l@thetimes.co.uk','717333831',10),(154,'Fred','Hicks','2009-12-02','Cidahu','Fred Hicks','fhicks2m@e-recht24.de','650766371',2),(155,'Juan','Thompson','2005-04-04','Cangshi','Juan Thompson','jthompson2n@weibo.com','705014782',30),(156,'Larry','Morgan','2010-08-30','Minneapolis','Larry Morgan','lmorgan2o@wp.com','853779844',17),(157,'Laura','Butler','2011-04-06','Hetou','Laura Butler','lbutler2p@lulu.com','848352159',21),(158,'Jennifer','Coleman','2006-09-24','Karangnongko','Jennifer Coleman','jcoleman2q@irs.gov','742969151',26),(159,'Frank','Ramos','2008-10-29','Citeureup','Frank Ramos','framos2r@symantec.com','572523564',8),(160,'Janet','Hanson','2008-06-16','Ogod','Janet Hanson','jhanson0@tinyurl.com','844342140',2),(161,'Phillip','Morgan','2006-06-12','Grebnevo','Phillip Morgan','pmorgan1@gizmodo.com','804515886',25),(162,'Johnny','Reynolds','2007-04-30','Orël','Johnny Reynolds','jreynolds2@alexa.com','826282742',6),(163,'Lois','Morris','2011-11-07','Shunyi','Lois Morris','lmorris3@soup.io','869960423',6),(164,'John','Evans','2009-12-02','Gal’bshtadt','John Evans','jevans4@oracle.com','870048912',19),(165,'Jane','Diaz','2007-12-04','Živinice','Jane Diaz','jdiaz5@dedecms.com','883446661',21),(166,'Julia','Martin','2007-09-10','Daxi','Julia Martin','jmartin6@clickbank.net','752888050',10),(167,'Wayne','Ramirez','2008-09-15','Ad Dimnah','Wayne Ramirez','wramirez7@buzzfeed.com','893552063',12),(168,'Frank','Price','2010-02-07','Yorii','Frank Price','fprice8@samsung.com','789540795',15),(169,'Joyce','James','2006-05-21','Dongqinggou','Joyce James','jjames9@ft.com','777768833',6),(170,'Anthony','Thompson','2006-05-28','Porto Ferreira','Anthony Thompson','athompsona@cafepress.com','795827204',27),(171,'Timothy','Weaver','2009-07-31','Düsseldorf','Timothy Weaver','tweaverb@yahoo.com','515415066',25),(172,'Diana','Grant','2007-07-08','Tayturka','Diana Grant','dgrantc@t-online.de','615248420',15),(173,'Patrick','Brooks','2009-08-25','Darwin','Patrick Brooks','pbrooksd@free.fr','540279674',16),(174,'Samuel','Gonzalez','2005-08-08','Jincheng','Samuel Gonzalez','sgonzaleze@soup.io','648194637',24),(175,'Christine','Fernandez','2011-01-06','Yancheng','Christine Fernandez','cfernandezf@reddit.com','582549555',29),(176,'Bobby','Nichols','2009-05-01','Fiditi','Bobby Nichols','bnicholsg@mac.com','630767930',2),(177,'Beverly','Price','2011-04-22','Segong','Beverly Price','bpriceh@howstuffworks.com','539282439',18),(178,'Donald','Robinson','2006-12-26','Liufang','Donald Robinson','drobinsoni@virginia.edu','786006748',15),(179,'Donna','Johnson','2008-10-08','Tangkil','Donna Johnson','djohnsonj@flavors.me','672768122',30),(180,'William','Spencer','2005-03-08','Jajaway','William Spencer','wspencerk@japanpost.jp','521461255',16),(181,'Gregory','Ortiz','2009-09-20','Kamensk-Shakhtinskiy','Gregory Ortiz','gortizl@mysql.com','575442153',16),(182,'Paula','Lynch','2010-08-31','Kalasin','Paula Lynch','plynchm@mediafire.com','501977676',6),(183,'Ernest','Lawrence','2005-03-28','Gvardeysk','Ernest Lawrence','elawrencen@theatlantic.com','787368149',30),(184,'Dorothy','Reynolds','2008-03-04','Qijiaxi','Dorothy Reynolds','dreynoldso@blogtalkradio.com','854907042',12),(185,'Gerald','Morris','2006-01-02','Limoges','Gerald Morris','gmorriss@hexun.com','665436929',10),(186,'Evelyn','Rodriguez','2005-09-19','Lens','Evelyn Rodriguez','erodriguezt@dot.gov','502387388',26),(187,'Daniel','Stanley','2010-10-06','Changlong','Daniel Stanley','dstanleyu@umich.edu','711067295',10),(188,'Anne','Tucker','2006-03-12','Nyíregyháza','Anne Tucker','atuckerv@businesswire.com','652113033',20),(189,'Pamela','Boyd','2009-08-15','Mingoyo','Pamela Boyd','pboydw@drupal.org','850454517',11),(190,'Wayne','Hernandez','2010-03-22','Tabonok','Wayne Hernandez','whernandezx@tuttocitta.it','730184980',11),(191,'Frank','Morgan','2008-01-21','Sishui','Frank Morgan','fmorgany@eventbrite.com','871487042',31),(192,'Jose','Mendoza','2008-12-17','Madrid','Jose Mendoza','jmendoza12@ebay.com','693624863',4),(193,'Doris','Jones','2010-12-23','Sambir','Doris Jones','djones13@twitpic.com','603597062',29),(194,'Clarence','Oliver','2005-10-01','Xidianzi','Clarence Oliver','coliver14@cdc.gov','683324359',25),(195,'Eric','Lawson','2008-05-04','Boshan','Eric Lawson','elawson15@taobao.com','884569985',7),(196,'Victor','Williamson','2008-12-17','Jorowaru Daya','Victor Williamson','vwilliamson16@cbc.ca','604071588',18),(197,'James','Martin','2011-01-15','Privas','James Martin','jmartin17@sciencedirect.com','573532788',12),(198,'Wayne','Walker','2009-11-29','Jiukou','Wayne Walker','wwalker1a@mayoclinic.com','840578551',29),(199,'Jack','Davis','2009-09-04','Hövsan','Jack Davis','jdavis1b@xrea.com','869784248',4),(200,'Stephen','Moreno','2006-11-09','Runjin','Stephen Moreno','smoreno1c@ebay.co.uk','703843811',26),(201,'Judy','Sullivan','2011-03-24','Jatiwangi','Judy Sullivan','jsullivan1d@mapquest.com','703744212',17),(202,'Christina','Sullivan','2007-11-18','Hronov','Christina Sullivan','csullivan1e@facebook.com','544113369',7),(203,'Steven','Gordon','2006-08-31','Laweueng','Steven Gordon','sgordon1f@netscape.com','839864062',9),(204,'Beverly','Clark','2005-09-18','Lipov','Beverly Clark','bclark1g@nifty.com','673904211',19),(205,'Julia','George','2006-11-01','Springfield','Julia George','jgeorge1h@linkedin.com','763019318',15),(206,'Irene','Weaver','2009-07-28','Karangsuko','Irene Weaver','iweaver1i@facebook.com','670146758',18),(207,'Willie','Washington','2010-08-31','Ituiutaba','Willie Washington','wwashington1k@berkeley.edu','878760307',11),(208,'Christina','Reid','2007-10-27','Songhe','Christina Reid','creid1l@reddit.com','562360511',25),(209,'Juan','Lane','2009-10-29','Lanjaghbyur','Juan Lane','jlane1m@theguardian.com','684071792',4),(210,'Jeffrey','Reed','2009-03-30','Duobaoshan','Jeffrey Reed','jreed1n@digg.com','535962971',4),(211,'Lori','Powell','2009-09-27','Santa Catalina','Lori Powell','lpowell1o@squidoo.com','860747662',21),(212,'Tammy','Cooper','2007-05-19','Xiakou','Tammy Cooper','tcooper1p@timesonline.co.uk','711984094',11),(213,'Thomas','Payne','2007-06-28','Narathiwat','Thomas Payne','tpayne1q@wikispaces.com','792766638',5),(214,'Pamela','Carroll','2005-09-12','Sumberan','Pamela Carroll','pcarroll1r@apple.com','542994088',11),(215,'Steven','Boyd','2010-06-16','La Cañada','Steven Boyd','sboyd1s@businessinsider.com','544726972',13),(216,'Martha','Gordon','2011-05-28','Charlton','Martha Gordon','mgordon1t@engadget.com','678564615',7),(217,'Elizabeth','James','2006-03-03','Banyo','Elizabeth James','ejames1u@biglobe.ne.jp','503476676',19),(218,'Shawn','Wright','2010-01-14','Oslo','Shawn Wright','swright1v@wiley.com','826297725',9),(219,'Eric','Myers','2005-07-12','Piasek','Eric Myers','emyers1w@parallels.com','540462957',29),(220,'Sean','Campbell','2006-03-22','San Juan Ermita','Sean Campbell','scampbell1x@linkedin.com','571252957',15),(221,'Clarence','Gonzales','2008-07-24','Ban Huai Thalaeng','Clarence Gonzales','cgonzales1y@eepurl.com','830554676',18),(222,'Douglas','Lee','2010-07-07','Itaporanga','Douglas Lee','dlee1z@wix.com','688934943',18),(223,'Benjamin','Palmer','2008-07-23','La Rioja','Benjamin Palmer','bpalmer20@dropbox.com','851714606',23),(224,'Martin','Pierce','2006-12-28','Paoua','Martin Pierce','mpierce21@patch.com','729537881',9),(225,'Andrew','Mcdonald','2007-11-04','Watoona','Andrew Mcdonald','amcdonald22@google.nl','816354808',17),(226,'Lori','Morales','2009-12-13','Vsevolozhsk','Lori Morales','lmorales23@timesonline.co.uk','521279001',18),(227,'Ann','Johnston','2005-08-10','Dome','Ann Johnston','ajohnston24@google.com.au','744724410',6),(228,'Raymond','Williamson','2010-09-09','Talambung Laok','Raymond Williamson','rwilliamson25@studiopress.com','579357403',5),(229,'Irene','Sanchez','2006-09-28','Piškorevci','Irene Sanchez','isanchez26@webeden.co.uk','730139303',21),(230,'Harold','Garrett','2008-11-13','Jaunpils','Harold Garrett','hgarrett27@w3.org','504345264',17),(231,'Joan','Dunn','2006-04-27','Singkir','Joan Dunn','jdunn28@amazon.com','783492817',17),(232,'Harold','Fields','2008-09-20','Jin’an','Harold Fields','hfields29@microsoft.com','810830502',10),(233,'Phyllis','Moore','2009-01-14','Zelenodolsk','Phyllis Moore','pmoore2a@de.vu','738806580',4),(234,'Brenda','Lawson','2006-07-11','To’rtko’l Shahri','Brenda Lawson','blawson2b@oracle.com','581922423',21),(235,'Jonathan','Sanders','2010-12-06','Dolati','Jonathan Sanders','jsanders2c@nps.gov','721476863',11),(236,'Kelly','Schmidt','2011-07-14','Pohonsirih','Kelly Schmidt','kschmidt2d@cbc.ca','708813984',6),(237,'Phyllis','Foster','2006-11-23','Seixas do Douro','Phyllis Foster','pfoster2e@simplemachines.org','557498693',28),(238,'Frank','Stanley','2005-12-21','Salgado','Frank Stanley','fstanley2g@youtu.be','620051417',9),(239,'Donald','Burke','2009-07-16','Nanaimo','Donald Burke','dburke2h@ifeng.com','794850995',3),(240,'Louis','Peters','2008-04-25','Dosso','Louis Peters','lpeters2i@moonfruit.com','704895713',22),(241,'Tina','Lane','2008-11-28','Magang','Tina Lane','tlane2j@wikipedia.org','515525649',22),(242,'Virginia','Cole','2007-03-26','Kayasula','Virginia Cole','vcole2k@yahoo.com','574825584',29),(243,'Gerald','Montgomery','2011-07-05','Kokologo','Gerald Montgomery','gmontgomery2l@ocn.ne.jp','611533606',3),(244,'Patricia','West','2006-10-13','Karang','Patricia West','pwest2m@amazon.co.uk','541789047',13),(245,'Virginia','Russell','2006-04-08','Iganga','Virginia Russell','vrussell2n@microsoft.com','849690892',12),(246,'Anthony','Owens','2006-08-27','Siteía','Anthony Owens','aowens2o@plala.or.jp','636753115',8);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `todays_classes`
--

DROP TABLE IF EXISTS `todays_classes`;
/*!50001 DROP VIEW IF EXISTS `todays_classes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `todays_classes` AS SELECT 
 1 AS `class_ID`,
 1 AS `group_ID`,
 1 AS `startTime`,
 1 AS `duration`,
 1 AS `firstInstructor_ID`,
 1 AS `secondInstructor_ID`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'BOBROWSKI'
--

--
-- Final view structure for view `instructions_plus`
--

/*!50001 DROP VIEW IF EXISTS `instructions_plus`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructions_plus` AS select `instructions`.`robot_ID` AS `robot_ID`,`instructions`.`robotName` AS `robotName`,`instructions`.`bricksType_ID` AS `bricksType_ID`,`equipment`.`equipment_ID` AS `equipment_ID`,`equipment`.`name` AS `name`,`equipment`.`quantity` AS `quantity`,`equipment`.`description` AS `description` from (`instructions` join `equipment` on((`instructions`.`bricksType_ID` = `equipment`.`equipment_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `todays_classes`
--

/*!50001 DROP VIEW IF EXISTS `todays_classes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `todays_classes` AS select `classes`.`class_ID` AS `class_ID`,`classes`.`group_ID` AS `group_ID`,`classes`.`startTime` AS `startTime`,`classes`.`duration` AS `duration`,`classes`.`firstInstructor_ID` AS `firstInstructor_ID`,`classes`.`secondInstructor_ID` AS `secondInstructor_ID` from `classes` where (cast(`classes`.`startTime` as date) = curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-30  9:12:25
