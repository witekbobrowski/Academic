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

-- Dump completed on 2017-01-27  2:39:57
