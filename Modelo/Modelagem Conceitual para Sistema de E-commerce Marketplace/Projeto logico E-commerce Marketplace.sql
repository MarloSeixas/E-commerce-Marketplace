CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `cartão_crédito`
--

DROP TABLE IF EXISTS `cartão_crédito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartão_crédito` (
  `idCartão_Crédito` int NOT NULL AUTO_INCREMENT,
  `Nome_Titular` varchar(45) NOT NULL,
  `Numero_Cartão` char(16) NOT NULL,
  `Data_Validade` date NOT NULL,
  `id_Cartão_pagamento` int NOT NULL,
  `CodigoSeguranca` char(3) DEFAULT NULL,
  PRIMARY KEY (`idCartão_Crédito`),
  KEY `fk_Cartão_Pagamento` (`id_Cartão_pagamento`),
  CONSTRAINT `fk_Cartão_Pagamento` FOREIGN KEY (`id_Cartão_pagamento`) REFERENCES `pagamento` (`idPagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `CPF` char(11) DEFAULT NULL,
  `Data_de_Nascimento` date DEFAULT NULL,
  `NomeCompleto` varchar(255) DEFAULT NULL,
  `Numero` varchar(10) DEFAULT NULL,
  `Complemento` varchar(50) DEFAULT NULL,
  `Bairro` varchar(50) DEFAULT NULL,
  `Cidade` varchar(50) NOT NULL,
  `Estado` char(2) NOT NULL,
  `CEP` char(8) DEFAULT NULL,
  `Telefone` char(11) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `unique_CPF_Cliente` (`CPF`),
  UNIQUE KEY `unique_Email_Cliente` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `idEntrega` int NOT NULL AUTO_INCREMENT,
  `Status_Entrega` enum('Em processamento','Enviado','Entregue','Cancelado') DEFAULT 'Em processamento',
  `Codigo_Rastreio` varchar(45) DEFAULT NULL,
  `Data_Envio` date DEFAULT NULL,
  `Data_Entrega_Prevista` date DEFAULT NULL,
  `id_Entrega_Pedido` int DEFAULT NULL,
  `Data_Entrega_Real` date DEFAULT NULL,
  PRIMARY KEY (`idEntrega`),
  KEY `fk_Pedido_Entrega` (`id_Entrega_Pedido`),
  CONSTRAINT `fk_Pedido_Entrega` FOREIGN KEY (`id_Entrega_Pedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `idEstoque` int NOT NULL AUTO_INCREMENT,
  `Localização` varchar(200) DEFAULT NULL,
  `Quantidade` int DEFAULT '0',
  PRIMARY KEY (`idEstoque`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `idFornecedor` int NOT NULL AUTO_INCREMENT,
  `Razão_Social` varchar(45) NOT NULL,
  `CNPJ` char(14) NOT NULL,
  `Contato` char(11) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE KEY `unique_Fornecedor` (`CNPJ`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `idPagamento` int NOT NULL AUTO_INCREMENT,
  `Forma_de_Pagamento` enum('Cartão','Dois cartões','Pix','Boleto','Transferência') DEFAULT NULL,
  `id_Pagamento_Cliente` int DEFAULT NULL,
  `Valor_Total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idPagamento`),
  KEY `fk_Pagamento_Cliente` (`id_Pagamento_Cliente`),
  CONSTRAINT `fk_Pagamento_Cliente` FOREIGN KEY (`id_Pagamento_Cliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `id_Pedido_Cliente` int DEFAULT NULL,
  `Status_Pedidos` enum('Em andamento','Em processamento','Enviado','Entregue','Cancelado') DEFAULT 'Em processamento',
  `Descrição` varchar(255) DEFAULT NULL,
  `Frete` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `fk_Pedido_Cliente` (`id_Pedido_Cliente`),
  CONSTRAINT `fk_Pedido_Cliente` FOREIGN KEY (`id_Pedido_Cliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `idProduto` int NOT NULL AUTO_INCREMENT,
  `Nome_Produto` varchar(100) NOT NULL,
  `Categoria` enum('Supermercado','Moda','Informática','Eletrodoméstico','Celular') DEFAULT NULL,
  `Valor` decimal(10,2) DEFAULT NULL,
  `Avaliação` float DEFAULT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produto_estoque`
--

DROP TABLE IF EXISTS `produto_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_estoque` (
  `idPEestoque` int NOT NULL,
  `idPEproduto` int NOT NULL,
  PRIMARY KEY (`idPEestoque`,`idPEproduto`),
  KEY `fk_produto_PEproduto` (`idPEproduto`),
  CONSTRAINT `fk_produto_Estoque` FOREIGN KEY (`idPEestoque`) REFERENCES `estoque` (`idEstoque`),
  CONSTRAINT `fk_produto_PEproduto` FOREIGN KEY (`idPEproduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produto_fornecedor`
--

DROP TABLE IF EXISTS `produto_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_fornecedor` (
  `idPFproduto` int NOT NULL,
  `idPFfornecedor` int NOT NULL,
  PRIMARY KEY (`idPFproduto`,`idPFfornecedor`),
  KEY `fk_produto_Fornecedor` (`idPFfornecedor`),
  CONSTRAINT `fk_produto_Fornecedor` FOREIGN KEY (`idPFfornecedor`) REFERENCES `fornecedor` (`idFornecedor`),
  CONSTRAINT `fk_produto_PFproduto` FOREIGN KEY (`idPFproduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produto_pedido`
--

DROP TABLE IF EXISTS `produto_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_pedido` (
  `idPPproduto` int NOT NULL,
  `idPPpedido` int NOT NULL,
  `Quantidade` int DEFAULT '1',
  `PPstatus` enum('Disponível','Sem estoque') DEFAULT 'Disponível',
  PRIMARY KEY (`idPPproduto`,`idPPpedido`),
  KEY `fk_Produto_Pedido` (`idPPpedido`),
  CONSTRAINT `fk_Produto_Pedido` FOREIGN KEY (`idPPpedido`) REFERENCES `pedido` (`idPedido`),
  CONSTRAINT `fk_produto_PPproduto` FOREIGN KEY (`idPPproduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produto_vendedor`
--

DROP TABLE IF EXISTS `produto_vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_vendedor` (
  `idPVvendedor` int NOT NULL,
  `idPVproduto` int NOT NULL,
  `Quantidade_Produto` int DEFAULT '1',
  PRIMARY KEY (`idPVvendedor`,`idPVproduto`),
  KEY `fk_produto_Produto` (`idPVproduto`),
  CONSTRAINT `fk_produto_Produto` FOREIGN KEY (`idPVproduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_produto_Vendedor` FOREIGN KEY (`idPVvendedor`) REFERENCES `vendedor` (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `idVendedor` int NOT NULL AUTO_INCREMENT,
  `Razão_Social` varchar(45) NOT NULL,
  `Localização` varchar(200) DEFAULT NULL,
  `CNPJ` char(14) DEFAULT NULL,
  `CPF` char(11) DEFAULT NULL,
  `Contato` char(11) NOT NULL,
  PRIMARY KEY (`idVendedor`),
  UNIQUE KEY `unique_CNPJ_Vendedor` (`CNPJ`),
  UNIQUE KEY `unique_CPF_Vendedor` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-14 10:23:46
