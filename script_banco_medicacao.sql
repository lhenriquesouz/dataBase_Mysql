-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.19 - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para banco_medicacao
DROP DATABASE IF EXISTS `banco_medicacao`;
CREATE DATABASE IF NOT EXISTS `banco_medicacao` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `banco_medicacao`;

-- Copiando estrutura para procedure banco_medicacao.busca_validade
DROP PROCEDURE IF EXISTS `busca_validade`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `busca_validade`(data_inicio date, data_fim date)
BEGIN
	SELECT * FROM medicacao
    WHERE validade BETWEEN data_inicio AND data_fim ;
END//
DELIMITER ;

-- Copiando estrutura para procedure banco_medicacao.delete_medicacao
DROP PROCEDURE IF EXISTS `delete_medicacao`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_medicacao`(id int)
BEGIN
	DELETE FROM medicacao where idmedicacao = id;
END//
DELIMITER ;

-- Copiando estrutura para tabela banco_medicacao.fornecedor
DROP TABLE IF EXISTS `fornecedor`;
CREATE TABLE IF NOT EXISTS `fornecedor` (
  `idfornecedor` int(11) unsigned NOT NULL,
  `nome_fantasia` varchar(45) NOT NULL,
  `cnpj` varchar(45) NOT NULL DEFAULT '0',
  `telefone` varchar(20) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `endereço` varchar(45) NOT NULL,
  `bairro` varchar(45) DEFAULT NULL,
  `cep` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idfornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela banco_medicacao.fornecedor: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;

-- Copiando estrutura para tabela banco_medicacao.fornecedor_has_medicacao
DROP TABLE IF EXISTS `fornecedor_has_medicacao`;
CREATE TABLE IF NOT EXISTS `fornecedor_has_medicacao` (
  `fornecedor_idfornecedor` int(11) unsigned NOT NULL,
  `medicacao_idmedicacao` int(11) NOT NULL,
  PRIMARY KEY (`fornecedor_idfornecedor`,`medicacao_idmedicacao`),
  KEY `fk_fornecedor_has_medicacao_medicacao1_idx` (`medicacao_idmedicacao`),
  KEY `fk_fornecedor_has_medicacao_fornecedor1_idx` (`fornecedor_idfornecedor`),
  CONSTRAINT `fk_fornecedor_has_medicacao_fornecedor1` FOREIGN KEY (`fornecedor_idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_medicacao_medicacao1` FOREIGN KEY (`medicacao_idmedicacao`) REFERENCES `medicacao` (`idmedicacao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela banco_medicacao.fornecedor_has_medicacao: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `fornecedor_has_medicacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor_has_medicacao` ENABLE KEYS */;

-- Copiando estrutura para procedure banco_medicacao.insere_medicacao
DROP PROCEDURE IF EXISTS `insere_medicacao`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insere_medicacao`(nome varchar(45),descricao varchar(45), quantidade int, validade date)
BEGIN
INSERT INTO `banco_medicacao`.`medicacao`
(
`nome`,
`descricao`,
`quantidade`,
`validade`)
VALUES
(nome,descricao,quantidade,validade);
END//
DELIMITER ;

-- Copiando estrutura para procedure banco_medicacao.lista_medicacao
DROP PROCEDURE IF EXISTS `lista_medicacao`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_medicacao`()
BEGIN
SELECT `medicacao`.`idmedicacao`,
    `medicacao`.`nome` as Nome,
    `medicacao`.`descricao` as Descricao,
    `medicacao`.`quantidade` as Quantidade,
    `medicacao`.`validade` as Validade
FROM `banco_medicacao`.`medicacao`;

END//
DELIMITER ;

-- Copiando estrutura para tabela banco_medicacao.log
DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `idlog` int(11) NOT NULL,
  `data` varchar(45) DEFAULT NULL,
  `idusuario` varchar(45) DEFAULT NULL,
  `idmedicacao` varchar(45) DEFAULT NULL,
  `acao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idlog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela banco_medicacao.log: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;

-- Copiando estrutura para tabela banco_medicacao.medicacao
DROP TABLE IF EXISTS `medicacao`;
CREATE TABLE IF NOT EXISTS `medicacao` (
  `idmedicacao` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  PRIMARY KEY (`idmedicacao`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela banco_medicacao.medicacao: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `medicacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicacao` ENABLE KEYS */;

-- Copiando estrutura para procedure banco_medicacao.update_medicacao
DROP PROCEDURE IF EXISTS `update_medicacao`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_medicacao`(id int, nome varchar(45), descricao varchar(45), quantidade int, validade date)
BEGIN
UPDATE `banco_medicacao`.`medicacao`
SET
`nome` = Nome,
`descricao` = Descricao,
`quantidade` = Quantidade,
`validade` = Validade

WHERE `idmedicacao` = id;

END//
DELIMITER ;

-- Copiando estrutura para tabela banco_medicacao.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idusuarios` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cpf` int(11) NOT NULL,
  `login` varchar(45) DEFAULT NULL,
  `senha` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `funcao` enum('medico','enfermeiro','recepcao','farmaceutico') NOT NULL,
  PRIMARY KEY (`idusuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela banco_medicacao.usuarios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Copiando estrutura para tabela banco_medicacao.usuarios_has_medicacao
DROP TABLE IF EXISTS `usuarios_has_medicacao`;
CREATE TABLE IF NOT EXISTS `usuarios_has_medicacao` (
  `usuarios_idusuarios` int(11) NOT NULL,
  `medicacao_idmedicacao` int(11) NOT NULL,
  PRIMARY KEY (`usuarios_idusuarios`,`medicacao_idmedicacao`),
  KEY `fk_usuarios_has_medicacao_medicacao1_idx` (`medicacao_idmedicacao`),
  KEY `fk_usuarios_has_medicacao_usuarios_idx` (`usuarios_idusuarios`),
  CONSTRAINT `fk_usuarios_has_medicacao_medicacao1` FOREIGN KEY (`medicacao_idmedicacao`) REFERENCES `medicacao` (`idmedicacao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_medicacao_usuarios` FOREIGN KEY (`usuarios_idusuarios`) REFERENCES `usuarios` (`idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela banco_medicacao.usuarios_has_medicacao: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios_has_medicacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_has_medicacao` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
