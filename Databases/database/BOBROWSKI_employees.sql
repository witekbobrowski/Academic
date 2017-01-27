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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-27  2:39:56
