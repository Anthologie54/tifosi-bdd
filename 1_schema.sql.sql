-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 30 sep. 2025 à 11:33
-- Version du serveur : 8.0.43
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tifosi`
--

-- --------------------------------------------------------

--
-- Structure de la table `achat`
--

DROP TABLE IF EXISTS `achat`;
CREATE TABLE IF NOT EXISTS `achat` (
  `id_client` int NOT NULL,
  `id_menu` int NOT NULL,
  `date_achat` date NOT NULL,
  `id_achat` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_achat`),
  KEY `achat_ibfk_1` (`id_client`),
  KEY `id_menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `boisson`
--

DROP TABLE IF EXISTS `boisson`;
CREATE TABLE IF NOT EXISTS `boisson` (
  `id_boisson` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `id_marque` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id_boisson`),
  UNIQUE KEY `nom` (`nom`),
  KEY `id_marque` (`id_marque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'UNIQUE',
  `code_postal` char(5) NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `foccacia`
--

DROP TABLE IF EXISTS `foccacia`;
CREATE TABLE IF NOT EXISTS `foccacia` (
  `id_foccacia` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prix` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_foccacia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `foccacia_ingredient`
--

DROP TABLE IF EXISTS `foccacia_ingredient`;
CREATE TABLE IF NOT EXISTS `foccacia_ingredient` (
  `id_foccacia` int NOT NULL,
  `id_ingredient` int NOT NULL,
  `quantite_grammes` int NOT NULL COMMENT 'Quantité en grammes',
  PRIMARY KEY (`id_foccacia`,`id_ingredient`),
  KEY `id_ingredient` (`id_ingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `id_marque` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id_marque`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prix` decimal(5,2) NOT NULL,
  `id_foccacia` int NOT NULL,
  `id_boisson` int NOT NULL,
  PRIMARY KEY (`id_menu`),
  KEY `id_foccacia` (`id_foccacia`),
  KEY `id_boisson` (`id_boisson`)
) ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `achat`
--
ALTER TABLE `achat`
  ADD CONSTRAINT `achat_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `achat_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Contraintes pour la table `boisson`
--
ALTER TABLE `boisson`
  ADD CONSTRAINT `boisson_ibfk_1` FOREIGN KEY (`id_marque`) REFERENCES `marque` (`id_marque`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `foccacia_ingredient`
--
ALTER TABLE `foccacia_ingredient`
  ADD CONSTRAINT `foccacia_ingredient_ibfk_1` FOREIGN KEY (`id_foccacia`) REFERENCES `foccacia` (`id_foccacia`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `foccacia_ingredient_ibfk_2` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_foccacia`) REFERENCES `foccacia` (`id_foccacia`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `menu_ibfk_2` FOREIGN KEY (`id_boisson`) REFERENCES `boisson` (`id_boisson`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
