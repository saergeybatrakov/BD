-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.26

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

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
	  `cnum` int NOT NULL,
	  `cname` varchar(25) NOT NULL,
	  `city` varchar(25) DEFAULT NULL,
	  `rating` int DEFAULT '100',
	  `snum` int DEFAULT NULL,
	  PRIMARY KEY (`cnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (201,'Игорь','Омск',100,NULL),(202,'Гарик','Томск',100,104),(203,'Гриша','Владимир',200,NULL),(204,'Гоша','Чита',300,109),(205,'Алиса','Бада',200,106),(206,'Таня','Питер',200,101),(208,'Лина','Шахты',100,104);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
	  `snum` int NOT NULL,
	  `cnum` varchar(45) NOT NULL,
	  `sdate` date NOT NULL,
	  `amount` double(7,2) NOT NULL,
	  PRIMARY KEY (`snum`,`cnum`,`sdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (101,'201','2024-10-01',35.00),(101,'202','2024-08-15',743.09),(101,'202','2024-10-15',43.09),(101,'203','2024-09-12',531.10),(101,'204','2024-09-12',1019.99),(102,'201','2024-09-17',1500.23),(102,'208','2024-07-14',800.03),(102,'208','2024-09-12',54.99),(104,'206','2024-09-13',101.01),(104,'208','2024-08-25',342.78),(105,'206','2024-07-30',133.99),(106,'203','2024-09-15',30000.10);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salespeaple`
--

DROP TABLE IF EXISTS `salespeaple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salespeaple` (
	  `snum` int NOT NULL,
	  `sname` varchar(25) NOT NULL,
	  `city` varchar(25) DEFAULT NULL,
	  `comm` decimal(3,2) DEFAULT NULL,
	  PRIMARY KEY (`snum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salespeaple`
--

LOCK TABLES `salespeaple` WRITE;
/*!40000 ALTER TABLE `salespeaple` DISABLE KEYS */;
INSERT INTO `salespeaple` VALUES (101,'Артём','Новосибирск',0.10),(102,'Саша','Сочи',0.09),(104,'Паша','Томск',0.09),(105,'Николай','Сочи',0.11),(106,'Мия','Адлел',0.09),(109,'Аня','Шмаковка',0.07);
/*!40000 ALTER TABLE `salespeaple` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-31 10:26:25
