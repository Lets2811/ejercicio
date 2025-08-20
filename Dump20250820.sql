-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ejercicio
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `name` varchar(60) NOT NULL,
  `description` text,
  `parent_category_id` int DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `fk_category_parent` (`parent_category_id`),
  CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Alimentos','Comida y abarrotes',NULL),(2,'Bebidas','Bebidas y refrescos',NULL),(3,'Lácteos','Productos lácteos',NULL),(4,'Hogar','Limpieza y hogar',NULL),(5,'Frutas y Verduras','Productos frescos',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `contact_name` varchar(30) NOT NULL,
  `company_name` varchar(40) DEFAULT NULL,
  `contact_email` varchar(128) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `idx_customer_city` (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Alice Wilson','FreshFoods','alice@fresh.com','123 Apple Rd','Knoxville','USA'),(2,'Bob Johnson','Verdant','bob@verdant.com','456 Market St','Stockton','USA'),(3,'Carlos Ruiz','TechMart','carlos@techmart.com','789 1st Ave','Seattle','USA'),(4,'Diana Prince','Daily Planet','diana@planet.com','111 Hero St','Metropolis','USA'),(5,'Ethan Hunt','IMF Supplies','ethan@imf.com','222 Spy Blvd','Austin','USA'),(6,'Fiona Glenanne','Boom Retail','fiona@boom.com','333 Ocean Dr','Miami','USA'),(7,'George Bluth','Banana Stand','george@banana.com','444 Stand St','Newport Beach','USA'),(8,'Hannah Baker','Riverdale Shop','hannah@river.com','555 River Rd','Denver','USA'),(9,'Ian Malcolm','Jurassic Co','ian@jurassic.com','666 Dino Way','San Diego','USA'),(10,'Julia Meier','EuroShop','julia@euro.com','777 Desert Ave','Phoenix','USA'),(11,'Alice Wilsonsa','FreshFoodssa','alice@fresh.cosa','123 Apple Rd','Knoxville','USA');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `reports_to` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employee_manager` (`reports_to`),
  CONSTRAINT `fk_employee_manager` FOREIGN KEY (`reports_to`) REFERENCES `employee` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Smith','John','1990-01-15','2012-05-01','100 Main St','Seattle','USA',NULL),(2,'Doe','Jane','1985-09-01','2010-03-12','200 Pine St','Austin','USA',1),(3,'Lee','Kevin','1998-06-30','2019-07-15','300 Oak Ave','Miami','USA',1),(4,'Brown','Emily','1975-12-05','2005-11-20','400 Elm Rd','Denver','USA',2),(5,'Garcia','Lucia','2000-03-20','2022-02-01','500 Maple Ln','Phoenix','USA',3);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `product_name` varchar(40) NOT NULL,
  `category_id` int NOT NULL,
  `quantity_per_unit` varchar(60) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `units_in_stock` int NOT NULL DEFAULT '0',
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`),
  KEY `idx_product_category` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `product_chk_1` CHECK ((`unit_price` >= 0)),
  CONSTRAINT `product_chk_2` CHECK ((`units_in_stock` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (101,'Arroz integral 1kg',1,'Bolsa 1kg',4.20,100,0),(102,'Pasta fusilli 500g',1,'Bolsa 500g',3.60,150,0),(103,'Harina de maíz 1kg',1,'Bolsa 1kg',2.90,200,0),(104,'Aceite de oliva 500ml',1,'Botella 500ml',7.50,80,0),(105,'Sal marina 1kg',1,'Bolsa 1kg',1.80,300,0),(201,'Manzana roja kg',5,'Kg',4.00,120,0),(202,'Banano kg',5,'Kg',2.50,150,0),(203,'Aguacate unidad',5,'Unidad',3.80,100,0),(204,'Zanahoria kg',5,'Kg',2.20,140,0),(205,'Uvas verdes kg',5,'Kg',5.90,60,0),(301,'Soda cola lata',2,'Lata 350ml',1.00,500,1),(302,'Jugo naranja 1L',2,'Botella 1L',2.30,200,1),(303,'Té verde botella',2,'Botella 500ml',1.50,300,1),(304,'Agua mineral 600ml',2,'Botella 600ml',1.10,400,0),(401,'Detergente polvo 1kg',4,'Bolsa 1kg',6.50,70,1),(402,'Suavizante 1L',4,'Botella 1L',5.20,90,1),(403,'Esponjas x3',4,'Paquete 3',2.00,120,1),(404,'Toallas cocina x2',4,'Paquete 2',3.80,110,0),(405,'Bolsas basura x50',4,'Rollo 50',4.10,80,1),(501,'Leche entera 1L',3,'Caja 1L',1.20,200,0),(502,'Yogur natural 1L',3,'Botella 1L',2.40,180,0),(503,'Queso cheddar 200g',3,'Paquete 200g',3.90,90,0);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `purchase_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `purchase_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shipped_date` timestamp NULL DEFAULT NULL,
  `ship_address` varchar(160) DEFAULT NULL,
  `ship_city` varchar(60) DEFAULT NULL,
  `ship_country` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `idx_purchase_customer` (`customer_id`),
  KEY `idx_purchase_employee` (`employee_id`),
  CONSTRAINT `fk_purchase_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_purchase_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `purchase_chk_1` CHECK ((`total_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` VALUES (1001,3,1,0.00,'2025-08-01 15:00:00','2025-08-02 14:00:00','789 1st Ave','Seattle','USA'),(1002,1,2,0.00,'2025-08-02 16:30:00','2025-08-03 15:30:00','123 Apple Rd','Knoxville','USA'),(1003,6,3,0.00,'2025-08-03 20:45:00','2025-08-04 17:10:00','333 Ocean Dr','Miami','USA'),(1004,8,4,0.00,'2025-08-04 14:25:00','2025-08-04 22:00:00','555 River Rd','Denver','USA'),(1005,2,5,0.00,'2025-08-05 19:05:00','2025-08-06 13:40:00','456 Market St','Stockton','USA'),(1006,9,2,0.00,'2025-08-06 21:20:00','2025-08-07 15:15:00','666 Dino Way','San Diego','USA'),(1007,4,1,0.00,'2025-08-07 15:10:00','2025-08-08 14:50:00','111 Hero St','Metropolis','USA'),(1008,10,3,0.00,'2025-08-08 23:30:00',NULL,'777 Desert Ave','Phoenix','USA');
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_item`
--

DROP TABLE IF EXISTS `purchase_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_item` (
  `purchase_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`purchase_id`,`product_id`),
  KEY `idx_item_product` (`product_id`),
  CONSTRAINT `fk_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_item_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`purchase_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `purchase_item_chk_1` CHECK ((`unit_price` >= 0)),
  CONSTRAINT `purchase_item_chk_2` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_item`
--

LOCK TABLES `purchase_item` WRITE;
/*!40000 ALTER TABLE `purchase_item` DISABLE KEYS */;
INSERT INTO `purchase_item` VALUES (1001,101,4.20,5),(1001,201,4.00,3),(1001,301,1.00,6),(1002,104,7.50,2),(1002,205,5.90,1),(1003,401,6.50,2),(1003,404,3.80,5),(1004,202,2.50,8),(1004,302,2.30,10),(1004,503,3.90,4),(1005,203,3.80,6),(1005,402,5.20,1),(1006,101,4.20,2),(1006,304,1.10,20),(1007,105,1.80,3),(1007,204,2.20,7),(1008,303,1.50,12),(1008,401,6.50,1),(1008,405,4.10,4);
/*!40000 ALTER TABLE `purchase_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-20 18:09:56
