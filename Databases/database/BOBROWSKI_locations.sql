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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-27  2:39:56
