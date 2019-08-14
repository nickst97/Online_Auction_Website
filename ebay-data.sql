-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: login
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

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
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bid` (
  `bid_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  `location` tinytext,
  `country` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  UNIQUE KEY `bid_id_UNIQUE` (`bid_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES (1,17,'petros','g','g',NULL,'7.5'),(2,17,'peetros','g','g',NULL,'7.5');
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `category_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_id_UNIQUE` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,13,'Collectibles'),(2,13,'Movies'),(3,14,'Collectibles'),(4,14,'Movies'),(5,15,'Collectibles'),(6,15,'Movies'),(7,16,'Movies'),(8,16,'DVD'),(9,17,'Movies'),(10,17,'DVD'),(82,21,'Collectibles'),(83,21,'Movies'),(84,21,'Posters'),(85,21,'Music'),(86,24,'Movies'),(87,24,'DVD'),(97,26,'Posters'),(98,26,'Shoes'),(99,26,'Jeans'),(100,26,'T-shirts'),(101,26,'Sweaters'),(102,26,'Accessories');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  `currently` decimal(20,2) DEFAULT NULL,
  `buy_price` decimal(20,2) DEFAULT NULL,
  `first_bid` decimal(20,2) DEFAULT NULL,
  `number_of_bids` int(11) DEFAULT NULL,
  `location` tinytext,
  `country` varchar(45) DEFAULT NULL,
  `started` datetime(6) DEFAULT NULL,
  `ends` datetime(6) DEFAULT NULL,
  `seller_id` varchar(45) DEFAULT NULL,
  `description` text,
  `hasstarted` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'nam',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:39:06.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(2,'name',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:41:01.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(3,'nameee',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:41:07.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(4,'nameee',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:45:40.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(5,'nameees',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:46:28.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(6,'nameees',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:46:49.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(7,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:47:29.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(8,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:48:18.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(9,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:48:35.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(10,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:50:42.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(11,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:50:59.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(12,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:54:13.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(13,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 23:00:09.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(14,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 23:08:17.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(15,'lit',1.00,1.00,1.00,0,'1','1','2019-08-06 12:25:00.000000','2019-08-06 13:02:01.000000','nickst','1',1),(16,'lit',5.00,5.00,5.00,0,'g','g','2019-08-06 12:29:42.000000','2019-08-27 03:03:03.000000','nickst','g',1),(17,'bla',1.00,1.00,1.00,2,'g','g','2019-08-06 12:30:47.000000','2019-08-26 03:03:03.000000','johnakidis','g',1),(21,'jon',4.40,3.50,4.40,0,'grr','g','2019-08-08 11:33:45.000000','2019-08-06 02:01:01.000000','johnakidis','g',1),(24,'adada',3.00,3.44,3.00,0,'gg','re','2019-08-08 12:41:19.000000','2019-08-05 01:02:03.000000','null','da',1),(26,'checkbox2',2.50,1.50,2.50,0,'at','bla','2019-08-08 12:49:55.000000','2019-08-13 01:02:03.000000','null','de',1);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `photo_data` longblob,
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `photo_id_UNIQUE` (`photo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (3,15,''),(7,21,_binary 'index.jpeg'),(8,21,_binary 'indeyx.jpeg'),(12,24,''),(14,26,'');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-08 17:21:21
