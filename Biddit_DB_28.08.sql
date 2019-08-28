-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: MyEbayDB
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
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uname` char(30) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `fname` char(30) NOT NULL,
  `lname` char(30) NOT NULL,
  `email` char(50) NOT NULL,
  `phone` char(14) NOT NULL,
  `address` char(50) NOT NULL,
  `tin` char(10) NOT NULL,
  `verified` char(1) NOT NULL DEFAULT 'N',
  `admin` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'nickst','bad65492ede82b516379ec0289a7335d','Nick','Stavrakakis','nick@gmail.com','6988609982','Acharnwn 5, Kifissia, Greece','123456789','Y','N'),(2,'johnakidis','1121d7cf7dced5e30d6bdcb122e83c79','John','Giannakidis','jj13@yahoo.gr','6922558899','Baker Street 221B, Longon, England','987654321','Y','N'),(7,'panosbtw','58aa5dbab20ef510aff89f85d55e72d1','Panos','Stamatopoulos','panstam@aol.tu','6918211821','Kapodistriou 26, Exarcheia, Greece','1122334455','Y','N'),(8,'admin1','21232f297a57a5a743894a0e4a801fc3','-','-','admin1@gmail.com','-','-','-','Y','Y'),(29,'omgitsele','eb97cc69697520c669534a0177bc61aa','Dimitris','Eleftheriadis','d_e@lol.de','1597531287','Somewhere 25, South Africa','4126','Y','N'),(32,'violet1311','c59b469d724f7919b7d35514184fdc0f','Violet','Avlo','violavlo@gmail.com','1313131313','Somestreet 402, Athens, Greece','1331','Y','N'),(33,'marmell','c2aadac2ca30ca8aadfbe331ae180d28','Thodoris','Mellios','marmell@hotmail.com','123456789','Kapou','741852963','Y','N');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

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
  `time` varchar(45) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  UNIQUE KEY `bid_id_UNIQUE` (`bid_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES (1,17,'petros',NULL,'7.5'),(2,17,'peetros',NULL,'7.5'),(3,14,'johnakidis','2019-08-13 18:00:56','8.0'),(4,16,'johnakidis','2019-08-13 18:08:28','5.0'),(5,13,'johnakidis','2019-08-13 18:09:12','8.0'),(6,24,'johnakidis','2019-08-13 18:09:53','3.11'),(7,27,'johnakidis','2019-08-13 18:18:19','3.0'),(8,13,'johnakidis','2019-08-13 20:51:38','8.0'),(9,13,'johnakidis','2019-08-13 20:59:15','8.0'),(10,8,'johnakidis','2019-08-13 21:01:31','8.0'),(11,27,'johnakidis','2019-08-13 21:28:02','3.0'),(12,29,'johnakidis','2019-08-13 21:28:41','1.5'),(13,30,'johnakidis','2019-08-13 21:31:02','4.0'),(14,30,'johnakidis','2019-08-14 17:25:45','6.0'),(15,30,'johnakidis','2019-08-14 17:26:11','8.32'),(16,31,'johnakidis','2019-08-14 17:37:30','12.0'),(17,35,'johnakidis','2019-08-14 18:20:28','13.0'),(18,37,'johnakidis','2019-08-14 18:27:41','12.0'),(19,37,'johnakidis','2019-08-14 18:27:56','18.0'),(20,17,'johnakidis','2019-08-14 19:17:45','1.0'),(21,16,'nickst','2019-08-26 16:46:30','5.0'),(22,13,'nickst','2019-08-26 17:19:09','8.0'),(23,14,'nickst','2019-08-26 17:29:59','8.0');
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidder`
--

DROP TABLE IF EXISTS `bidder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bidder` (
  `user_id` varchar(45) NOT NULL,
  `location` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidder`
--

LOCK TABLES `bidder` WRITE;
/*!40000 ALTER TABLE `bidder` DISABLE KEYS */;
INSERT INTO `bidder` VALUES ('johnakidis','athens','greece'),('nickst','Kifissia','Greece');
/*!40000 ALTER TABLE `bidder` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,13,'Collectibles'),(2,13,'Movies'),(3,14,'Collectibles'),(4,14,'Movies'),(5,15,'Collectibles'),(6,15,'Movies'),(7,16,'Movies'),(8,16,'DVD'),(9,17,'Movies'),(10,17,'DVD'),(86,24,'Movies'),(87,24,'DVD'),(97,26,'Posters'),(98,26,'Shoes'),(99,26,'Jeans'),(100,26,'T-shirts'),(101,26,'Sweaters'),(102,26,'Accessories'),(105,29,'Accessories'),(106,29,'Backpacks'),(107,29,'Bags'),(108,30,'Men'),(109,30,'Jeans'),(110,30,'Extra-Large'),(114,31,'Women'),(115,31,'Jeans'),(116,31,'Medium'),(118,33,'Suits'),(121,35,'Accessories'),(122,36,'Accessories'),(123,37,'Video'),(124,34,'Shoes');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_labels`
--

DROP TABLE IF EXISTS `category_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_labels` (
  `idcat` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcat`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_labels`
--

LOCK TABLES `category_labels` WRITE;
/*!40000 ALTER TABLE `category_labels` DISABLE KEYS */;
INSERT INTO `category_labels` VALUES (1,'Collectibles'),(2,'Movies'),(3,'DVD'),(4,'Television'),(5,'Autographs'),(6,'Posters'),(7,'Music'),(8,'Video'),(9,'Clothing'),(10,'Boys'),(11,'Girls'),(12,'Teens'),(13,'Men'),(14,'Women'),(15,'Underwears'),(16,'Shoes'),(17,'Jeans'),(18,'T-shirts'),(19,'Sweaters'),(20,'Accessories'),(21,'Backpacks'),(22,'Bags'),(23,'Suits'),(24,'Sports'),(25,'Skirts'),(26,'Small'),(27,'Medium'),(28,'Large'),(29,'Extra-Small'),(30,'Extra-Large');
/*!40000 ALTER TABLE `category_labels` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'nam',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:39:06.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(2,'name',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:41:01.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(4,'nameee',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:45:40.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(5,'nameees',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:46:28.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(6,'nameees',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:46:49.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(7,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:47:29.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(8,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:48:18.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(9,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:48:35.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(10,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:50:42.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(11,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:50:59.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(12,'nameeess',8.00,8.00,8.00,0,'athens','athens','2019-08-05 22:54:13.000000','2019-08-26 18:00:00.000000','nickst','bla',1),(13,'nameeess',8.00,8.00,8.00,1,'athens','athens','2019-08-05 23:00:09.000000','2019-08-26 18:00:00.000000','nickst','bla',2),(14,'nameeess',8.00,8.00,8.00,1,'athens','athens','2019-08-05 23:08:17.000000','2019-08-26 18:00:00.000000','nickst','bla',2),(15,'lit',1.00,1.00,1.00,0,'1','1','2019-08-06 12:25:00.000000','2019-08-06 13:02:01.000000','nickst','1',2),(16,'lit',5.00,5.00,5.00,1,'g','g','2019-08-06 12:29:42.000000','2019-08-27 03:03:03.000000','nickst','g',2),(17,'bla',1.00,1.00,1.00,3,'g','g','2019-08-06 12:30:47.000000','2019-08-26 03:03:03.000000','johnakidis','g',2),(24,'adada',3.00,3.44,3.00,0,'gg','re','2019-08-08 12:41:19.000000','2019-08-05 01:02:03.000000','null','da',2),(26,'checkbox2',2.50,1.50,2.50,0,'at','bla','2019-08-08 12:49:55.000000','2019-08-13 01:02:03.000000','null','de',2),(29,'1234',1.50,1.50,1.50,0,'a','a','2019-08-13 21:19:40.000000','2019-08-27 01:02:03.000000','johnakidis','a',1),(30,'test',8.32,10.00,1.00,2,'a','a','2019-08-13 21:29:21.000000','2019-08-04 02:01:03.000000','johnakidis','a',2),(31,'rer',12.00,12.00,2.00,1,'s','d','2019-08-13 21:33:10.000000','2019-08-12 01:02:03.000000','johnakidis','as',2),(33,'2',1.00,123.00,1.00,0,'aw','sa','2019-08-13 21:35:02.000000','2019-08-09 01:02:03.000000','johnakidis','as for now',2),(34,'asasasa',0.10,1.50,0.10,0,'e','e','2019-08-13 21:42:32.000000','2019-08-06 01:02:03.000000','johnakidis','lit louis',2),(35,'pao',13.00,13.00,12.00,1,'a','a','2019-08-14 18:17:25.000000','2019-08-30 01:02:03.000000','johnakidis','as',2),(36,'aek',1.00,12.00,1.00,0,'a','s','2019-08-14 18:18:13.000000','2019-08-06 01:02:03.000000','johnakidis','louis lit',2),(37,'w',18.00,1234.00,1.00,2,'a','r','2019-08-14 18:26:22.000000','2019-08-14 18:31:00.000000','johnakidis','as',2);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `time` varchar(45) NOT NULL,
  `content` text,
  `sender_uname` char(30) NOT NULL,
  `receiver_uname` char(30) NOT NULL,
  `deleted_for` varchar(30) DEFAULT NULL,
  `viewed` char(1) NOT NULL DEFAULT 'N',
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (4,'2019-08-21 21:28:17','ti tha ginei me to kinito re?','nickst','johnakidis',NULL,'N',NULL),(5,'2019-08-22 12:23:58','geia!','nickst','johnakidis',NULL,'N',NULL),(7,'2018-03-02 12:23:58','Kalispera! Pote tha mporesoyme gia to ps4? Efxaristo!','johnakidis','nickst',NULL,'Y',NULL),(8,'2019-07-22 12:23:58','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum laoreet, nunc eget laoreet sa agittis, quam ligula sodales orci, congue imperdiet eros tortor ac lectus. Duis eget nisl orci. Aliquam mattis purus non mauris blandit id luctus felis convallis. Integer varius egestas vestibulum. Nullam a dolor arcu, ac tempor elit. Donec.  ','violet1311','nickst','nickst','N',NULL),(9,'2019-08-26 16:43:30','pame fort','nickst','johnakidis',NULL,'N',15),(10,'2019-08-28 16:02:56','kalispera','nickst','marmell',NULL,'N',13);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (3,15,''),(12,24,''),(14,26,''),(17,29,''),(18,30,''),(19,31,''),(21,33,''),(22,34,''),(23,35,''),(24,36,''),(25,37,'');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `won`
--

DROP TABLE IF EXISTS `won`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `won` (
  `won_id` int(11) NOT NULL AUTO_INCREMENT,
  `bidder` varchar(45) DEFAULT NULL,
  `seller` varchar(45) DEFAULT NULL,
  `item_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`won_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `won`
--

LOCK TABLES `won` WRITE;
/*!40000 ALTER TABLE `won` DISABLE KEYS */;
INSERT INTO `won` VALUES (1,'johnakidis','johnakidis','31'),(2,'johnakidis','johnakidis','30'),(3,'johnakidis','johnakidis','31'),(4,'johnakidis','johnakidis','30'),(5,'johnakidis','johnakidis','31'),(6,'johnakidis','johnakidis','30'),(7,'johnakidis','johnakidis','31'),(8,'johnakidis','johnakidis','35'),(9,'johnakidis','johnakidis','30'),(10,'johnakidis','johnakidis','31'),(11,'johnakidis','johnakidis','37'),(12,'johnakidis','johnakidis','17'),(13,'nickst','nickst','16'),(14,'nickst','nickst','13'),(15,'nickst','nickst','14');
/*!40000 ALTER TABLE `won` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-28 18:17:23
