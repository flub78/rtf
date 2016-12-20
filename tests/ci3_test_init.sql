-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ci3
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

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
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'admin','Administrator'),(2,'members','General User');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_attempts` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempts`
--

LOCK TABLES `login_attempts` WRITE;
/*!40000 ALTER TABLE `login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_test1`
--

DROP TABLE IF EXISTS `meta_test1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meta_test1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `expiration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(4) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `epoch` int(11) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `oaci` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oaci` (`oaci`),
  CONSTRAINT `meta_test1_ibfk_1` FOREIGN KEY (`oaci`) REFERENCES `meta_test2` (`oaci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_test1`
--

LOCK TABLES `meta_test1` WRITE;
/*!40000 ALTER TABLE `meta_test1` DISABLE KEYS */;
/*!40000 ALTER TABLE `meta_test1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_test2`
--

DROP TABLE IF EXISTS `meta_test2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meta_test2` (
  `oaci` varchar(4) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`oaci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_test2`
--

LOCK TABLES `meta_test2` WRITE;
/*!40000 ALTER TABLE `meta_test2` DISABLE KEYS */;
INSERT INTO `meta_test2` VALUES ('LFOI','Abbeville'),('LFQB','Troyes');
/*!40000 ALTER TABLE `meta_test2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (20160101000000);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(16) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(80) NOT NULL,
  `salt` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'127.0.0.1','administrator','$2a$07$SeBknntpZror9uyftVopmu61qg0ms8Qv1yV6FG.kQOSM.9QhmTo36','','admin@admin.com','',NULL,NULL,NULL,1268889823,1268889823,1,'Admin','istrator','ADMIN','0'),(2,'127.0.0.1','admin','$2y$08$PcdixwDfxDs4C4LeTSRHTeYRHDCdTu0/WQMBHQXANBR7eRPAxtFpm','','admin@gmail.com',NULL,NULL,NULL,NULL,1461227279,1461227290,1,'Admin','Admin',NULL,NULL),(3,'127.0.0.1','user_0','$2y$08$WO1PowdVfHqPZ/pIduN0t.FPPklm67g1ROnKbtUrVSZ8HCmvmVXpu','','user_0@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'admin_firstname_0','admin_name_0',NULL,NULL),(4,'127.0.0.1','user_1','$2y$08$e0wBnRJ6RRWn73ObJs2RAeZj0s5kDsW.5x9NkOXaNFbTCCWHhSevC','','user_1@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_0_firstname_1','user_0_name_1',NULL,NULL),(5,'127.0.0.1','user_2','$2y$08$svuBOAiTRtsZb4ncUeG4.OqGn1YGjPH/2jM/Vsaem5kKXVV8//Rpu','','user_2@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_1_firstname_2','user_1_name_2',NULL,NULL),(6,'127.0.0.1','user_3','$2y$08$QLAUBBTCUweK5cgJpnhV2ujO3HuH/8IRNMWshmk.boRmF5ESzWTlG','','user_3@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_2_firstname_3','user_2_name_3',NULL,NULL),(7,'127.0.0.1','user_4','$2y$08$J..cVfoCES7jbknGaf7UpepL6KLwWS5/Lv4g/ULkW0NdDBEn.nNzW','','user_4@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_3_firstname_4','user_3_name_4',NULL,NULL),(8,'127.0.0.1','user_5','$2y$08$1tEG.VJ01jwvr2mIxEKxuuhOIG3CZYA//0k64dHlfI6aOVjfspF82','','user_5@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_4_firstname_5','user_4_name_5',NULL,NULL),(9,'127.0.0.1','user_6','$2y$08$jbm4BC5hTk2DbIJCi8s1y.iLWHe4rWOJ.soorcTLNXKdiv9rbl/fa','','user_6@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_5_firstname_6','user_5_name_6',NULL,NULL),(10,'127.0.0.1','user_7','$2y$08$1BjtcSdM7l3ZL9IIjpUnDOCODtfWj8NdFcNG9OsyPOwATB/tvttSS','','user_7@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_6_firstname_7','user_6_name_7',NULL,NULL),(11,'127.0.0.1','user_8','$2y$08$TWWhRR/Ljqlsw7MAThnxZ.NIdShLuYdGQq7ZmKeI5ezaC6Q/7xEqm','','user_8@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_7_firstname_8','user_7_name_8',NULL,NULL),(12,'127.0.0.1','user_9','$2y$08$LdYoxrV6cINEEslyRNeXUOHyXSbKPZFpMY56CnJuXuTF3/5AhOVzK','','user_9@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_8_firstname_9','user_8_name_9',NULL,NULL),(13,'127.0.0.1','user_10','$2y$08$u.JMsOX7pprWbwVPLh9px.AOMMC8t4pv5D8rsalnSB9KcJIKdurNi','','user_10@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_9_firstname_10','user_9_name_10',NULL,NULL),(14,'127.0.0.1','user_11','$2y$08$RnJelle7JN8K4MhpKzyb8e3VYaXeJbhY4sZRlOaIMKJWI1Z/GzoR.','','user_11@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_10_firstname_11','user_10_name_11',NULL,NULL),(15,'127.0.0.1','user_12','$2y$08$.HhwitnREl3k2fdNT.FZ8elQgsAUq8D506/iiq0zG1/TrWkgOpV.e','','user_12@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_11_firstname_12','user_11_name_12',NULL,NULL),(16,'127.0.0.1','user_13','$2y$08$5.cUJ2uddiC1yMIf5iFJqeoff5JZaIJ8TaqFPhMKleuilw5Yc4HgW','','user_13@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_12_firstname_13','user_12_name_13',NULL,NULL),(17,'127.0.0.1','user_14','$2y$08$umxrN4vbf0h/0ccRCqbpne.cLj.nvKTwWmOW5yIaPcvW1Uez7OV1K','','user_14@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_13_firstname_14','user_13_name_14',NULL,NULL),(18,'127.0.0.1','user_15','$2y$08$s0dEwwyPDhh0S6WwVnRfQeUNVKPaDWryeQMel80a1BDiQbVGXPpRq','','user_15@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_14_firstname_15','user_14_name_15',NULL,NULL),(19,'127.0.0.1','user_16','$2y$08$EAJDj2qxV8ovElhayZa4puCA5A8MZmh7k6aHL4qNOF7sGiyzjh0e6','','user_16@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_15_firstname_16','user_15_name_16',NULL,NULL),(20,'127.0.0.1','user_17','$2y$08$245MYWDyOpVbecCSpMlytuckul6zUWECrQhL0YhaqAR2zvtGkeyiW','','user_17@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_16_firstname_17','user_16_name_17',NULL,NULL),(21,'127.0.0.1','user_18','$2y$08$co.ReChx61Y5Xg1jxULtiuKIJ8atYbT2wvyIPmNcUttX6KdIsYdBe','','user_18@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_17_firstname_18','user_17_name_18',NULL,NULL),(22,'127.0.0.1','user_19','$2y$08$sxxH.mYtWUurS0.L1rcwV.1DPrp37a4ep3cZKnYVjoF9i.5rWi.Om','','user_19@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_18_firstname_19','user_18_name_19',NULL,NULL),(23,'127.0.0.1','user_20','$2y$08$O6pNUsq4amhIGc6eY6LyYOwbTBfUFkFpv/9UZORKEVInmImv1WN7e','','user_20@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_19_firstname_20','user_19_name_20',NULL,NULL),(24,'127.0.0.1','user_21','$2y$08$QevpKjm4ssmD20UFlNiNXuMYhRYzKIXdXzNomdluQgS6liBhzXeXi','','user_21@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_20_firstname_21','user_20_name_21',NULL,NULL),(25,'127.0.0.1','user_22','$2y$08$Ns9P62tX.7lv3jZhXj4HMul0v0HyowkhGUPADWc3QHN3n0E.lLBHW','','user_22@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_21_firstname_22','user_21_name_22',NULL,NULL),(26,'127.0.0.1','user_23','$2y$08$j8SDeiPypnqsAD9M4/Dnp.O7j3W5E1eYRnZQJLhGsZlPMLL1fswwm','','user_23@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_22_firstname_23','user_22_name_23',NULL,NULL),(27,'127.0.0.1','user_24','$2y$08$Jh5uGSGfvPbcISuOlimMc.Ou33bmZLId9BAFIJLNSEvf4ggVRjdQC','','user_24@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_23_firstname_24','user_23_name_24',NULL,NULL),(28,'127.0.0.1','user_25','$2y$08$OJZdWXGsGvlGdrMIWhCDJOrFMTzKZMQNtblzGOzPcCoSbe8reShHa','','user_25@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_24_firstname_25','user_24_name_25',NULL,NULL),(29,'127.0.0.1','user_26','$2y$08$07RbB5ecoVRMpsZFQPD/g.EYOV6PBb6MV52MQF2qaJzpKO1yh1j7S','','user_26@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_25_firstname_26','user_25_name_26',NULL,NULL),(30,'127.0.0.1','user_27','$2y$08$PtsrJtPMSKHuB9qic/oq3OFBJP2PkJJa.jnpuzMWbZdh94K1Dwj6.','','user_27@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_26_firstname_27','user_26_name_27',NULL,NULL),(31,'127.0.0.1','user_28','$2y$08$Y1vh0LnIaVzJSRRRIWBzFODMxqUgiZD7Hb.aZZNFRyJPR35ev2ny6','','user_28@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_27_firstname_28','user_27_name_28',NULL,NULL),(32,'127.0.0.1','user_29','$2y$08$iHxv8LDAwnCni7Y39YNlbOpz97.G4lj8oEGrsFVBBcxXmxcIyx6nG','','user_29@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_28_firstname_29','user_28_name_29',NULL,NULL),(33,'127.0.0.1','user_30','$2y$08$W1jTPQOP52sdUr5cNlEYGOYE4zf25kXxCNZnXymKaVeJs7VcnYgJq','','user_30@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_29_firstname_30','user_29_name_30',NULL,NULL),(34,'127.0.0.1','user_31','$2y$08$AHF/P64QQRIPelO4gDdRbO.mo6tklkYzsFNPP0scTpFAEO1GPMPZW','','user_31@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_30_firstname_31','user_30_name_31',NULL,NULL),(35,'127.0.0.1','user_32','$2y$08$cjIxtmZnxdKbmJL8nOZMtO0W1OxdMQBzPrKY.K6rxFsZlt60sy4KO','','user_32@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_31_firstname_32','user_31_name_32',NULL,NULL),(36,'127.0.0.1','user_33','$2y$08$a0v6r9nrlYvn6mx9bYXaweo7Mm5eAhQjiG2P2EoA1gteIS4Q4Yxke','','user_33@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_32_firstname_33','user_32_name_33',NULL,NULL),(37,'127.0.0.1','user_34','$2y$08$McVbPcVU3/uJdM1BNj1e2ulOYnHKxTC8gemu49NOL5z29RaoWZZ7m','','user_34@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_33_firstname_34','user_33_name_34',NULL,NULL),(38,'127.0.0.1','user_35','$2y$08$BYvQSGitpeIaMqPcoJlOtefQyFUnfb161EpexiTeNFJJI.KyuJVA.','','user_35@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_34_firstname_35','user_34_name_35',NULL,NULL),(39,'127.0.0.1','user_36','$2y$08$qttg0/UHddn41v2ZNbCYVes0b51wb9ruMLwCZQ4ir8ngRfgZdrMiG','','user_36@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_35_firstname_36','user_35_name_36',NULL,NULL),(40,'127.0.0.1','user_37','$2y$08$aZ6YgovtyU4jZocmvSE0SOAliz9Iyt3M6hLyXbW59EqrNsvr1t//O','','user_37@gmail.com',NULL,NULL,NULL,NULL,1461227279,NULL,1,'user_36_firstname_37','user_36_name_37',NULL,NULL),(41,'127.0.0.1','user_38','$2y$08$lBWDHEFkQr80kdXZgQplKuD2NSQq.xTXO6RLfIWsHL1bSk6jUzSDS','','user_38@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_37_firstname_38','user_37_name_38',NULL,NULL),(42,'127.0.0.1','user_39','$2y$08$Gr1pS4OXmzjhT3CcXY06keYcN/LEX73J3N1uLi.T92jk.FvHQqyOa','','user_39@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_38_firstname_39','user_38_name_39',NULL,NULL),(43,'127.0.0.1','user_40','$2y$08$Y9siSNq3VyaBinvTV8sSRO98L5XlrlRZ/YGcYCH/3OmirjbrxFvDK','','user_40@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_39_firstname_40','user_39_name_40',NULL,NULL),(44,'127.0.0.1','user_41','$2y$08$Tcy7vrTcehpgcc4y2HCLLuZ5EHtEt2.bltxNrGAhPpQCkrj7tsvey','','user_41@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_40_firstname_41','user_40_name_41',NULL,NULL),(45,'127.0.0.1','user_42','$2y$08$ubpSLI.STYFzmYhEELC1OePUeMqxFe/zYwNiuQiEp/HBZLXiYIb5K','','user_42@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_41_firstname_42','user_41_name_42',NULL,NULL),(46,'127.0.0.1','user_43','$2y$08$hSknPT/CdXgPT8HE7oP.TO9PBXaLIYQLgyiogsdq1yPqk/Vo7aJJ6','','user_43@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_42_firstname_43','user_42_name_43',NULL,NULL),(47,'127.0.0.1','user_44','$2y$08$M7qMJqk7Oahk/aWvqrEWvuPajJVY3CGneIJxwhjEC6.HUsUF0tKq.','','user_44@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_43_firstname_44','user_43_name_44',NULL,NULL),(48,'127.0.0.1','user_45','$2y$08$BKGtmz2wFEZW/Z4TdDLWTuLliKUHyeidPoMgqxLXiSkYZ4gFNkKky','','user_45@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_44_firstname_45','user_44_name_45',NULL,NULL),(49,'127.0.0.1','user_46','$2y$08$ZLfSoo.gffPSEK/CZcWBju4FjO6HdsY5ZcP5iIcK27FYLzEQYWp4q','','user_46@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_45_firstname_46','user_45_name_46',NULL,NULL),(50,'127.0.0.1','user_47','$2y$08$7CygM9NKlTlmLhNjUE2mheIetKmT1b3bdii/vpYnr91Ssej7BThG2','','user_47@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_46_firstname_47','user_46_name_47',NULL,NULL),(51,'127.0.0.1','user_48','$2y$08$RgPkKApo7M4P892138y1c.gxeARdlLWfqNwbGh5XJ4s5SQ9b0ukMa','','user_48@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_47_firstname_48','user_47_name_48',NULL,NULL),(52,'127.0.0.1','user_49','$2y$08$QaK1edKJ7o05kQIPzU1uy.8K9wuG9FdxhMZkVyZqfFWYp4YWOxIfO','','user_49@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_48_firstname_49','user_48_name_49',NULL,NULL),(53,'127.0.0.1','user_50','$2y$08$COxUkiwJNxbLeO6ng.y0EuJ49yNtjD6cG7p.bfpqIApc4/O/2a9nq','','user_50@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_49_firstname_50','user_49_name_50',NULL,NULL),(54,'127.0.0.1','user_51','$2y$08$qju4QbYMxdyKdEAundMPcOw/lKlp8lP5DdSPdym9Niu8nezP/as62','','user_51@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_50_firstname_51','user_50_name_51',NULL,NULL),(55,'127.0.0.1','user_52','$2y$08$nMo4bTtXnuTSwf2ktVI17.A5AlKw2fF0WuO9B5LX9B.qSVcZe8XCi','','user_52@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_51_firstname_52','user_51_name_52',NULL,NULL),(56,'127.0.0.1','user_53','$2y$08$MjC2HGwVV85KoJPNHLCQleUuHcc7hWQTS7mYOn/hRaj8ferATZ0gO','','user_53@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_52_firstname_53','user_52_name_53',NULL,NULL),(57,'127.0.0.1','user_54','$2y$08$yUax1hUl8iPFzMt6jKNeaOZwPn.Kthu3i.JZPvWp5V60W0e5rRBKq','','user_54@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_53_firstname_54','user_53_name_54',NULL,NULL),(58,'127.0.0.1','user_55','$2y$08$OvvUGWeKJbTbkkM.aRUGnOPHVLKyZSrgyUUCS1xYIlNpYQrDM9Ubm','','user_55@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_54_firstname_55','user_54_name_55',NULL,NULL),(59,'127.0.0.1','user_56','$2y$08$gvw.VIejFaSe8PmIe5dh9.CmF5eBW14hzJhmw98PQ71CuAtDo/tbO','','user_56@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_55_firstname_56','user_55_name_56',NULL,NULL),(60,'127.0.0.1','user_57','$2y$08$1tt2WTCocS9XlzbkygQfNeLpDvktXM7oMtlyS/hPY4Qz7By7Ym4di','','user_57@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_56_firstname_57','user_56_name_57',NULL,NULL),(61,'127.0.0.1','user_58','$2y$08$5dfHiemfuJlYgHy3oCaPWeDf3X6kLnZe3KcskLTLY8mGlB.6J3Brm','','user_58@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_57_firstname_58','user_57_name_58',NULL,NULL),(62,'127.0.0.1','user_59','$2y$08$FSo7uSjYHxF.UdQg.NBg2O5wZ49n3.W5RwZ1pFfdl.WS.PRn7LuIi','','user_59@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_58_firstname_59','user_58_name_59',NULL,NULL),(63,'127.0.0.1','user_60','$2y$08$aSVntdfvHwy0G48Pwj7wg.Y5kbhIDaaJYSGtk515p45QIZDoBNfgq','','user_60@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_59_firstname_60','user_59_name_60',NULL,NULL),(64,'127.0.0.1','user_61','$2y$08$UOGoXf752Nf1zPeJ7F6cwOf9QcLI.Va1VcnpAfO/nSLVf9zx/Rqg6','','user_61@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_60_firstname_61','user_60_name_61',NULL,NULL),(65,'127.0.0.1','user_62','$2y$08$ke7UuVuBS8XOX8uAdaT3yuNZwR/tltNLAVwiwoh2fSNlza97w56w2','','user_62@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_61_firstname_62','user_61_name_62',NULL,NULL),(66,'127.0.0.1','user_63','$2y$08$0pr19AkKq/xul05LbvbEaO3u12m2g3K1U.Yb832WzwF7G4tyxhzUy','','user_63@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_62_firstname_63','user_62_name_63',NULL,NULL),(67,'127.0.0.1','user_64','$2y$08$.BTq6DsRuQg2XL8FuoKRAuy46db4HG./DSrIwvJVus51zVOctgclS','','user_64@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_63_firstname_64','user_63_name_64',NULL,NULL),(68,'127.0.0.1','user_65','$2y$08$D1rzAzEvlu.JF9oRd5nGAOj1mGIz93zqnfVn0X5BGxAiUcO0qM3LG','','user_65@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_64_firstname_65','user_64_name_65',NULL,NULL),(69,'127.0.0.1','user_66','$2y$08$RYVjgNMWEhW7J5vXTgsDG.OmysAR35Okj8kwF2Dvfs4sZ2NdOh5tS','','user_66@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_65_firstname_66','user_65_name_66',NULL,NULL),(70,'127.0.0.1','user_67','$2y$08$NW7uI67PA7vP4JfMe6/SAu4vCLeL7Xa6ggwS6rMQJQHPWdUc0e9KW','','user_67@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_66_firstname_67','user_66_name_67',NULL,NULL),(71,'127.0.0.1','user_68','$2y$08$0XKArRSl6i3DnyjVzJgD/eXf7opAQizr4hSQOhf1pkFv/zSwj675y','','user_68@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_67_firstname_68','user_67_name_68',NULL,NULL),(72,'127.0.0.1','user_69','$2y$08$m9BvA7c.zkmJbNC7NdhwC.Vy9HMgXdH70rLbAyHeGFeJPV7QOySLu','','user_69@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_68_firstname_69','user_68_name_69',NULL,NULL),(73,'127.0.0.1','user_70','$2y$08$/yOFnx/H9tfjSmNcon6sF.ssFrXoA/hj.3jxFBzTjnZ3M1voVYcCO','','user_70@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_69_firstname_70','user_69_name_70',NULL,NULL),(74,'127.0.0.1','user_71','$2y$08$JI.BV0ryfzaMIXMPga8eGuMDE7idW0.XLgXrz9Bu/fnTAqL357w5q','','user_71@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_70_firstname_71','user_70_name_71',NULL,NULL),(75,'127.0.0.1','user_72','$2y$08$kQ9RAAlks0zg1kEVlfJjAOKGKH5b0QqPst/QBu4phii2grI5FweJu','','user_72@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_71_firstname_72','user_71_name_72',NULL,NULL),(76,'127.0.0.1','user_73','$2y$08$LBCLx0NrTvrkEwqIuGFLMOXVcwEIKoJzeMBvuLxGt70Y4OmaZ9BrW','','user_73@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_72_firstname_73','user_72_name_73',NULL,NULL),(77,'127.0.0.1','user_74','$2y$08$4JlsoR9LxCp6BjEvv1/A/e7GQ7KzezSVvXDzlYlsW5HkUiZKtzPQC','','user_74@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_73_firstname_74','user_73_name_74',NULL,NULL),(78,'127.0.0.1','user_75','$2y$08$FJ5ckrlX2Xdq.XiHZXE3HOqqyfriYpHZCYD8jIZcs6Pk.5v.h0bq.','','user_75@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_74_firstname_75','user_74_name_75',NULL,NULL),(79,'127.0.0.1','user_76','$2y$08$7f8A.DMm1DDQqY3lVwgLg.GW7nSEpfv2aK4CkXam8r70DfxGZeCsO','','user_76@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_75_firstname_76','user_75_name_76',NULL,NULL),(80,'127.0.0.1','user_77','$2y$08$brRgj5Cv84/ehPkSwm3DmuMaMcnKWcEOvChHDkqzjRssazqYNhAXm','','user_77@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_76_firstname_77','user_76_name_77',NULL,NULL),(81,'127.0.0.1','user_78','$2y$08$7SL9ySxOouMRxG04ama0z.GkSoBEHFrTBr4YsTermm0kfpe4SahUu','','user_78@gmail.com',NULL,NULL,NULL,NULL,1461227280,NULL,1,'user_77_firstname_78','user_77_name_78',NULL,NULL),(82,'127.0.0.1','user_79','$2y$08$iucqYZfrRA4w8KW5BSTVb.2gQqheym5diba9WuoX45rS1Od0uFg4i','','user_79@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_78_firstname_79','user_78_name_79',NULL,NULL),(83,'127.0.0.1','user_80','$2y$08$KmlPL.vOeUov/ydDFLt9L.JwzBU2uKcb7d8FPq98MWgh7gxik0E4e','','user_80@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_79_firstname_80','user_79_name_80',NULL,NULL),(84,'127.0.0.1','user_81','$2y$08$SiOeC3KCaxy.OgclRVPglOq/UTB9KjX8Vd0cqmrjMCU4I728Ra3ny','','user_81@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_80_firstname_81','user_80_name_81',NULL,NULL),(85,'127.0.0.1','user_82','$2y$08$f8htdoIWvKeh7wUgHGtmVOMSqO4g3VO0i9TUCSAHUi0c97gVkYQwu','','user_82@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_81_firstname_82','user_81_name_82',NULL,NULL),(86,'127.0.0.1','user_83','$2y$08$GJ2tjDZMlDytOnWWFHkGS.KDCUMSdJF0N1VzReFZMV7/P4.ONyug2','','user_83@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_82_firstname_83','user_82_name_83',NULL,NULL),(87,'127.0.0.1','user_84','$2y$08$F7OTwsevv21./XKKn8.iqOqAZkU4c73UUmwNhjl.78FLKDQxMMC8m','','user_84@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_83_firstname_84','user_83_name_84',NULL,NULL),(88,'127.0.0.1','user_85','$2y$08$iOa7N3PNIwkqsuN3cWYKxeThsAY3xT844YUd.Vfuy9JmaTdOr35N.','','user_85@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_84_firstname_85','user_84_name_85',NULL,NULL),(89,'127.0.0.1','user_86','$2y$08$fSnM4PhPsDdEkO3yLGsEluQLuQGuaVZobvZ/fWlPqrVac0MvRpwFa','','user_86@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_85_firstname_86','user_85_name_86',NULL,NULL),(90,'127.0.0.1','user_87','$2y$08$aRJDuEvN4DziZAy1H.yu2uC5.wU/cKqbMtI.TDfR3MpLwoAQCb1nG','','user_87@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_86_firstname_87','user_86_name_87',NULL,NULL),(91,'127.0.0.1','user_88','$2y$08$OvNzkfoQqFljGvUK7YehSeDWxLVSoo3COcv9WI60kUPSpRqhR2IcC','','user_88@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_87_firstname_88','user_87_name_88',NULL,NULL),(92,'127.0.0.1','user_89','$2y$08$6AB/RSoB6ptC4RFcVWp0s.11MOifXjio/AhryNzDgENSJ/dfgpK/u','','user_89@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_88_firstname_89','user_88_name_89',NULL,NULL),(93,'127.0.0.1','user_90','$2y$08$UchkzwXjoCq/88SSrNJEn.JB9lwb8kqycbr2oUEWMjuwHvyhpZxri','','user_90@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_89_firstname_90','user_89_name_90',NULL,NULL),(94,'127.0.0.1','user_91','$2y$08$n4038QNbkoi2UOmPmGak2eoXyD1Ass6MOaEIMBdDZQPsRlXVvHzzi','','user_91@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_90_firstname_91','user_90_name_91',NULL,NULL),(95,'127.0.0.1','user_92','$2y$08$Axwuw.2nZFcDbov/40dpFeoL1UiYvuS4DCrwPthtNo7lEG1VJmdqK','','user_92@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_91_firstname_92','user_91_name_92',NULL,NULL),(96,'127.0.0.1','user_93','$2y$08$PnefUnGRqCojJsSRfYft0.pDLEbeZW8xIRhii/66uHHlfg2tEmZeq','','user_93@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_92_firstname_93','user_92_name_93',NULL,NULL),(97,'127.0.0.1','user_94','$2y$08$LnEH0bb04BKCQ46QNeFlkeuiVBHGGiNenVPuYLudqiye38RvEIDe.','','user_94@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_93_firstname_94','user_93_name_94',NULL,NULL),(98,'127.0.0.1','user_95','$2y$08$A0kSmuAbwrdVOYZPNge79uGBWDrDCBHwZLa5Jy9ZnQQsjP7rYnHmK','','user_95@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_94_firstname_95','user_94_name_95',NULL,NULL),(99,'127.0.0.1','user_96','$2y$08$xXMLvSeMpAl6k06RevdHKOwe83KkcPjSxZFarzHvVRlOF2CI//qte','','user_96@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_95_firstname_96','user_95_name_96',NULL,NULL),(100,'127.0.0.1','user_97','$2y$08$eqnP82o//umMmbbWUaBuj.8d4pcQtDaxUHEkQyHEWt0ISgsXye0nu','','user_97@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_96_firstname_97','user_96_name_97',NULL,NULL),(101,'127.0.0.1','user_98','$2y$08$qCz5MnBRLA/355FC1nOgYeLpcXBPgJl0/.rZqa34U/QgxMrbp8Exy','','user_98@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_97_firstname_98','user_97_name_98',NULL,NULL),(102,'127.0.0.1','user_99','$2y$08$AYgWpkR//qc7RYxRnt/17uBNFV/Qvgiz3W5esUBwBjiG9acxuzksm','','user_99@gmail.com',NULL,NULL,NULL,NULL,1461227281,NULL,1,'user_98_firstname_99','user_98_name_99',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `users_groups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (1,1,1),(2,1,2),(3,2,1),(4,3,1),(5,4,1),(6,5,1),(7,6,1),(8,7,1),(9,8,1),(10,9,1),(11,10,1),(12,11,1),(13,12,1),(14,13,1),(15,14,1),(16,15,1),(17,16,1),(18,17,1),(19,18,1),(20,19,1),(21,20,1),(22,21,1),(23,22,1),(24,23,1),(25,24,1),(26,25,1),(27,26,1),(28,27,1),(29,28,1),(30,29,1),(31,30,1),(32,31,1),(33,32,1),(34,33,1),(35,34,1),(36,35,1),(37,36,1),(38,37,1),(39,38,1),(40,39,1),(41,40,1),(42,41,1),(43,42,1),(44,43,1),(45,44,1),(46,45,1),(47,46,1),(48,47,1),(49,48,1),(50,49,1),(51,50,1),(52,51,1),(53,52,1),(54,53,1),(55,54,1),(56,55,1),(57,56,1),(58,57,1),(59,58,1),(60,59,1),(61,60,1),(62,61,1),(63,62,1),(64,63,1),(65,64,1),(66,65,1),(67,66,1),(68,67,1),(69,68,1),(70,69,1),(71,70,1),(72,71,1),(73,72,1),(74,73,1),(75,74,1),(76,75,1),(77,76,1),(78,77,1),(79,78,1),(80,79,1),(81,80,1),(82,81,1),(83,82,1),(84,83,1),(85,84,1),(86,85,1),(87,86,1),(88,87,1),(89,88,1),(90,89,1),(91,90,1),(92,91,1),(93,92,1),(94,93,1),(95,94,1),(96,95,1),(97,96,1),(98,97,1),(99,98,1),(100,99,1),(101,100,1),(102,101,1),(103,102,1);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `users_groups_view`
--

DROP TABLE IF EXISTS `users_groups_view`;
/*!50001 DROP VIEW IF EXISTS `users_groups_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `users_groups_view` (
  `username` tinyint NOT NULL,
  `groupname` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `users_view`
--

DROP TABLE IF EXISTS `users_view`;
/*!50001 DROP VIEW IF EXISTS `users_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `users_view` (
  `id` tinyint NOT NULL,
  `ip_address` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `salt` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `activation_code` tinyint NOT NULL,
  `forgotten_password_code` tinyint NOT NULL,
  `forgotten_password_time` tinyint NOT NULL,
  `remember_code` tinyint NOT NULL,
  `created_on` tinyint NOT NULL,
  `last_login` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `first_name` tinyint NOT NULL,
  `last_name` tinyint NOT NULL,
  `company` tinyint NOT NULL,
  `phone` tinyint NOT NULL,
  `image` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `users_groups_view`
--

/*!50001 DROP TABLE IF EXISTS `users_groups_view`*/;
/*!50001 DROP VIEW IF EXISTS `users_groups_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ci3`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `users_groups_view` AS select `users`.`username` AS `username`,`groups`.`name` AS `groupname` from ((`users` join `users_groups`) join `groups`) where ((`users`.`id` = `users_groups`.`user_id`) and (`groups`.`id` = `users_groups`.`group_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `users_view`
--

/*!50001 DROP TABLE IF EXISTS `users_view`*/;
/*!50001 DROP VIEW IF EXISTS `users_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ci3`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `users_view` AS select `users`.`id` AS `id`,`users`.`ip_address` AS `ip_address`,`users`.`username` AS `username`,`users`.`password` AS `password`,`users`.`salt` AS `salt`,`users`.`email` AS `email`,`users`.`activation_code` AS `activation_code`,`users`.`forgotten_password_code` AS `forgotten_password_code`,`users`.`forgotten_password_time` AS `forgotten_password_time`,`users`.`remember_code` AS `remember_code`,`users`.`created_on` AS `created_on`,`users`.`last_login` AS `last_login`,`users`.`active` AS `active`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`company` AS `company`,`users`.`phone` AS `phone`,concat(`users`.`first_name`,' ',`users`.`last_name`) AS `image` from `users` */;
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

-- Dump completed on 2016-04-21 10:29:06
