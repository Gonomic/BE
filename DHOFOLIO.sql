-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 01, 2020 at 04:54 PM
-- Server version: 10.3.21-MariaDB
-- PHP Version: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `DHOFOLIO`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAfwijkingen` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get deviations with regard to the planning'
SELECT `Eindklanten`.`Naam` AS "Naam klant" , `Projecten`.`Naam` AS "Naam project", `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`PlanningBuitenAfwijking`, `Rapportage`.`PlanningBuitenOnwerkbaar`, `Rapportage`.`PlanningBinnenAfwijking`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
    WHERE `Rapportage`.`DatumRappPeriode` IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetKnelpunten` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get data for Knelpunten per customer/project'
SELECT `Eindklanten`.`Naam` AS "Naam klant" , `Projecten`.`Naam` AS "Naam project", `Projecten`.`Projectnummer`, `Knelpunten`.`DatumIngebracht`, `Knelpunten`.`Honkbal`, `Knelpunten`.`ActieVerantwoordelijke`, `Knelpunten`.`OmschrijvingActie`, `Knelpunten`.`DatumVerwachtOpgelost`, `Knelpunten`.`DatumWerkelijkOpgelost`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Knelpunten` ON `Knelpunten`.`Project` = `Projecten`.`ID`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetKwaliteit` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get figures for kwaliteit per week for each cust/prj'
SELECT `Eindklanten`.`Naam` AS "Naam klant", `Projecten`.`Naam` AS "Naam project", `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`KwaliteitMaandag`, `Rapportage`.`KwaliteitDinsdag`, `Rapportage`.`KwaliteitWoensdag`, `Rapportage`.`KwaliteitDonderdag`, `Rapportage`.`KwaliteitVrijdag`,
`Rapportage`.`RedenAfwijkingKwaliteit`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
    WHERE `Rapportage`.`DatumRappPeriode` IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOverigeGrafieken` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get all data form rapportage for all customers'
SELECT `Eindklanten`.`Naam`, `Projecten`.`Naam`, `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`PlanningBuitenAfwijking`, `Rapportage`.`PlanningBuitenOnwerkbaar`, `Rapportage`.`PlanningBinnenAfwijking`, `Rapportage`.`TevredenheidOpdrachtgever`, `Rapportage`.`Tevredenheid omgeving`, `Rapportage`.`Algemeen gevoel`, `Rapportage`.`VeiligheidMaandag`, `Rapportage`.`VeiligheidDinsdag`, `Rapportage`.`VeiligheidWoensdag`, `Rapportage`.`VeiligheidDonderdag`, `Rapportage`.`VeiligheidVrijdag`, `Rapportage`.`WerkplezierMaandag`, `Rapportage`.`WerkplezierDinsdag`, `Rapportage`.`WerkplezierWoensdag`, `Rapportage`.`WerkplezierDonderdag`, `Rapportage`.`WerkplezierVrijdag`, `Rapportage`.`KwaliteitMaandag`, `Rapportage`.`KwaliteitDinsdag`, `Rapportage`.`KwaliteitWoensdag`, `Rapportage`.`KwaliteitDonderdag`, `Rapportage`.`KwaliteitVrijdag`, `Rapportage`.`PlanningMaandag`, `Rapportage`.`PlanningDinsdag`, `Rapportage`.`PlanningWoensdag`, `Rapportage`.`PlanningDonderdag`, `Rapportage`.`PlanningVrijdag`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
    WHERE `Rapportage`.`DatumRappPeriode`IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPANScore` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get the PAN scores, sorted by week and then TypeAanneme'
SELECT `Samenwerkingen`.`DatumSamenwerkingPeriode`, `Samenwerkingen`.`TypeAannemer`, `Aannemers`.`Naam`, `Projecten`.`Projectnummer`, `Projecten`.`Naam`, `Eindklanten`.`Naam`, `Samenwerkingen`.`NagekomenAfspraken`, `Samenwerkingen`.`NietNagekomenAfspraken`, `Samenwerkingen`.`RedenNietNagekomenAfspraken`, `Samenwerkingen`.`NieuweOpleverPunten`
FROM `Samenwerkingen` 
	LEFT JOIN `Aannemers` ON `Samenwerkingen`.`Aannemer` = `Aannemers`.`ID` 
	LEFT JOIN `Projecten` ON `Samenwerkingen`.`Project` = `Projecten`.`ID` 
	LEFT JOIN `Eindklanten` ON `Projecten`.`Klant` = `Eindklanten`.`ID`
    ORDER BY DatumSamenwerkingPeriode ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlanning` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get all planning figures for customer per week/project'
SELECT `Eindklanten`.`Naam` AS "Naam Klant", `Projecten`.`Naam` AS "Naam project", `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`PlanningMaandag`, `Rapportage`.`PlanningDinsdag`, `Rapportage`.`PlanningWoensdag`, `Rapportage`.`PlanningDonderdag`, `Rapportage`.`PlanningVrijdag`, `Rapportage`.`RedenAfwijkingPlanning`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
    WHERE `Rapportage`.`DatumRappPeriode` IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectenAndTheirKnelpunten` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Get projects with their knelpunten'
SELECT `Projecten`.`Naam` AS Project, `Knelpunten`.`Omschrijving` AS Knelpunt, `Knelpunten`.`Honkbal` AS `Honkbal`
FROM `Projecten` 
	LEFT JOIN `Knelpunten` ON `Knelpunten`.`Project` = `Projecten`.`ID`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectenMetKlantEnRapportage` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get All projects, customer per project and reporting'
SELECT `Rapportage`.`DatumRappPeriode` AS Week, `Projecten`.`Naam` AS Project, `Eindklanten`.`Naam` AS Klant, `Rapportage`.`PlanningBuitenAfwijking`, `Rapportage`.`PlanningBuitenOnwerkbaar`, `Rapportage`.`PlanningBinnenAfwijking`, `Rapportage`.`TevredenheidOpdrachtgever`, `Rapportage`.`Tevredenheid omgeving`, `Rapportage`.`Algemeen gevoel`
FROM `Rapportage` 
	LEFT JOIN `Projecten` ON `Rapportage`.`Project` = `Projecten`.`ID` 
	LEFT JOIN `Eindklanten` ON `Projecten`.`Klant` = `Eindklanten`.`ID`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectRapportageBuitenAfwijkingEnOnwerkbaar` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'This SPROC gets all planning figures'
SELECT `Projecten`.`Naam`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`PlanningBuitenAfwijking`, `Rapportage`.`PlanningBuitenOnwerkbaar`
FROM `Projecten` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
WHERE `Rapportage`.`DatumRappPeriode` IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTevredenheid` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get tevredenheid figures per week per customer/project'
SELECT `Eindklanten`.`Naam` AS "Naam klant" , `Projecten`.`Naam` AS "Naam project", `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`TevredenheidOpdrachtgever`, `Rapportage`.`Tevredenheid omgeving`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
    WHERE `Rapportage`.`DatumRappPeriode` IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVeiligheid` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get all Veiligheidfigures for projects per customer'
SELECT `Eindklanten`.`Naam`, `Projecten`.`Naam`, `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`VeiligheidMaandag`, `Rapportage`.`VeiligheidDinsdag`, `Rapportage`.`VeiligheidWoensdag`, `Rapportage`.`VeiligheidDonderdag`, `Rapportage`.`VeiligheidVrijdag`,
`Rapportage`.`RedenAfwijkingVeiligheid`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWerkplezier` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get the figures for Werkplezier per project and custome'
SELECT `Eindklanten`.`Naam`, `Projecten`.`Naam`, `Projecten`.`Projectnummer`, `Rapportage`.`DatumRappPeriode`, `Rapportage`.`WerkplezierMaandag`, `Rapportage`.`WerkplezierDinsdag`, `Rapportage`.`WerkplezierWoensdag`, `Rapportage`.`WerkplezierDonderdag`, `Rapportage`.`WerkplezierVrijdag`, `Rapportage`.`RedenAfwijkingWerkplezier`
FROM `Eindklanten` 
	LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID` 
	LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
    WHERE `Rapportage`.`DatumRappPeriode` IS NOT NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ProjectenMetKlantEnAannemerEnSamenwerking` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Haal projecten met klant, aannemer en kengetallen samenwerking'
SELECT
    `Samenwerkingen`.`DatumSamenwerkingPeriode`,
    `Eindklanten`.`Naam` AS Klant,
    `Projecten`.`Naam` AS `Project`,
    `Samenwerkingen`.`TypeAannemer` AS `Type_aannemer`,
    `Aannemers`.`Naam` AS `Aannemer`,
    `Samenwerkingen`.`NagekomenAfspraken` AS `Nagekomen_afspraken`,
    `Samenwerkingen`.`NietNagekomenAfspraken` AS `Niet_nagekomen_afspraken`
FROM
    `Eindklanten`
LEFT JOIN `Projecten` ON `Projecten`.`Klant` = `Eindklanten`.`ID`
LEFT JOIN `Samenwerkingen` ON `Samenwerkingen`.`Project` = `Projecten`.`ID`
LEFT JOIN `Aannemers` ON `Samenwerkingen`.`Aannemer` = `Aannemers`.`ID`
WHERE
    `Aannemers`.`ID` IS NOT NULL
ORDER BY
    `Samenwerkingen`.`DatumSamenwerkingPeriode` ASC$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Aannemers`
--

CREATE TABLE `Aannemers` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Naam` varchar(30) NOT NULL,
  `Adres` varchar(30) NOT NULL,
  `Postcode` varchar(6) NOT NULL,
  `Woonplaats` varchar(30) NOT NULL,
  `Contact` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used to store data for aannemerspartners (= all companies involved)';

--
-- Dumping data for table `Aannemers`
--

INSERT INTO `Aannemers` (`ID`, `Naam`, `Adres`, `Postcode`, `Woonplaats`, `Contact`) VALUES
(7, 'Fa. Een', 'Eenstraat 1', '1111AA', 'Eendorp', 'Eduard En'),
(8, 'Fa. Twee', 'Tweestraat 2', '2222BB', 'Tweedorp', 'Tinus Wee'),
(9, 'Fa. Drie', 'Driestraat', '3333CC', 'Driedorp', 'Dirk Rie'),
(10, 'Fa. Vier', 'Vierstraat 4', '4444DD', 'Vierdorp', 'Victor Ier');

-- --------------------------------------------------------

--
-- Table structure for table `Acties`
--

CREATE TABLE `Acties` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Knelpunt` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Linkt to tabel Knelpunten',
  `ActieNummer` int(11) NOT NULL,
  `ActieOmschrijving` varchar(240) DEFAULT NULL,
  `ActieOwner` varchar(80) NOT NULL,
  `DatumOntstaan` date NOT NULL,
  `DatumGeplandKlaar` date NOT NULL,
  `DatumWerkelijkKlaar` date NOT NULL,
  `ActieAfhandeling` varchar(240) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Eindklanten`
--

CREATE TABLE `Eindklanten` (
  `ID` bigint(20) NOT NULL,
  `Naam` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Eindklanten`
--

INSERT INTO `Eindklanten` (`ID`, `Naam`) VALUES
(4, 'Klant Een'),
(5, 'Klant Twee'),
(6, 'Klant Drie'),
(7, 'De Hele Olifant');

-- --------------------------------------------------------

--
-- Table structure for table `Gebruikers`
--

CREATE TABLE `Gebruikers` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Aannemer` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Link naar de werkgever (is een aannemer)',
  `Voornaam` varchar(20) NOT NULL,
  `Achternaam` varchar(20) NOT NULL,
  `EmailAdres` varchar(20) NOT NULL,
  `Telefoonnummer` varchar(20) NOT NULL,
  `ZieLogin` tinyint(1) NOT NULL DEFAULT 0,
  `ZietWeekInvoer` tinyint(1) NOT NULL DEFAULT 0,
  `ZietKlanten` tinyint(1) NOT NULL DEFAULT 0,
  `ZietProjecten` tinyint(1) NOT NULL DEFAULT 0,
  `ZietGebruikers` tinyint(1) NOT NULL DEFAULT 0,
  `ZietSysteem` tinyint(1) NOT NULL DEFAULT 0,
  `ManagesGebruikers` tinyint(1) NOT NULL DEFAULT 0,
  `ManagesLogin` tinyint(1) NOT NULL DEFAULT 0,
  `ManagesWeekInvoer` tinyint(1) NOT NULL DEFAULT 0,
  `ManagesKlanten` tinyint(1) NOT NULL DEFAULT 0,
  `ManagesProjecten` tinyint(1) NOT NULL,
  `ManagesSysteem` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Gebruikers`
--

INSERT INTO `Gebruikers` (`ID`, `Aannemer`, `Voornaam`, `Achternaam`, `EmailAdres`, `Telefoonnummer`, `ZieLogin`, `ZietWeekInvoer`, `ZietKlanten`, `ZietProjecten`, `ZietGebruikers`, `ZietSysteem`, `ManagesGebruikers`, `ManagesLogin`, `ManagesWeekInvoer`, `ManagesKlanten`, `ManagesProjecten`, `ManagesSysteem`) VALUES
(2, 7, 'Gebruiker', 'Een', 'ge@fa-een.nl', '0174-112233', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 8, 'Gebruiker', 'Twee', 'gt@fa-twee.nl', '010-119922', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 9, 'Gebruiker', 'Drie', 'gd@fa-drie.nl', '070201893', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Knelpunten`
--

CREATE TABLE `Knelpunten` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Omschrijving` varchar(240) NOT NULL,
  `Project` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Link naar projecten',
  `Honkbal` tinyint(1) NOT NULL COMMENT 'Wel of geen Honkbal status',
  `DatumIngebracht` date NOT NULL COMMENT 'Date on which this knelpunt has been entered',
  `OmschrijvingActie` varchar(254) NOT NULL COMMENT 'Description of the Knelpunt',
  `ActieVerantwoordelijke` varchar(80) NOT NULL COMMENT 'The person who is responsible for the action(s) for this Knelpunt',
  `DatumVerwachtOpgelost` date NOT NULL COMMENT 'The date at which the Knelpunt is expected to be solved',
  `DatumWerkelijkOpgelost` date DEFAULT NULL COMMENT 'The date the Knelpunt was really solved'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Knelpunten`
--

INSERT INTO `Knelpunten` (`ID`, `Omschrijving`, `Project`, `Honkbal`, `DatumIngebracht`, `OmschrijvingActie`, `ActieVerantwoordelijke`, `DatumVerwachtOpgelost`, `DatumWerkelijkOpgelost`) VALUES
(2, 'Het beton wil niet harden', 4, 1, '2020-11-01', 'Beton vroeger bestellen', 'Jos Bakker', '2020-12-31', '2021-02-28'),
(3, 'Vlechtijzer niet op tijd geleverd', 5, 0, '2020-11-25', 'Betere routebeschrijving sturen en per dag de komende wegwerkzaamheden in de buurt van het werk ophalen bij de ANWB', 'Roulant Tebeschrijving', '2020-11-30', '2021-03-31'),
(4, 'Geen metselaars beschikbaar', 6, 0, '2020-10-01', 'Polen inhuren', 'Ron Selaar', '2020-11-27', '2021-04-30'),
(5, 'Date null dates produces error in Klipfolio', 7, 0, '2020-11-27', 'Change query string to what Klipfolio advices', 'Frans', '2020-11-30', '2021-04-30');

-- --------------------------------------------------------

--
-- Table structure for table `Projecten`
--

CREATE TABLE `Projecten` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Klant` bigint(20) DEFAULT NULL COMMENT 'Link naar klanten',
  `Naam` varchar(30) NOT NULL,
  `Projectnummer` mediumint(15) NOT NULL,
  `Omschrijving` varchar(240) NOT NULL,
  `Startdatum` date NOT NULL,
  `GewensteEinddatum` date NOT NULL,
  `WerkelijkeEinddatum` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Projecten`
--

INSERT INTO `Projecten` (`ID`, `Klant`, `Naam`, `Projectnummer`, `Omschrijving`, `Startdatum`, `GewensteEinddatum`, `WerkelijkeEinddatum`) VALUES
(4, 4, 'Project Een', 111111, 'Het eerste testproject', '2020-11-15', '2021-12-31', '2021-12-31'),
(5, 5, 'Project twee', 222222, 'Het tweede testproject', '2020-06-06', '2021-06-06', '2021-06-06'),
(6, 6, 'Project Drie', 333333, 'Het derde testproject', '2020-01-01', '2021-06-06', '2021-06-06'),
(7, 7, 'Solve DHOFolio errors', 1, 'When DB sends a null value for date, Klipfolio gives an error', '2020-11-27', '2020-11-30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Rapportage`
--

CREATE TABLE `Rapportage` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Project` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Link to Project table',
  `DatumRappPeriode` date NOT NULL COMMENT 'Datum waarop deze (week) rapportage is ingevoerd',
  `DatumInvoerRapp` date NOT NULL COMMENT 'Date at which report was created',
  `PlanningBuitenAfwijking` int(2) NOT NULL COMMENT 'Aantal afwijkende dagen gedurende de rapportage periode',
  `PlanningBuitenOnwerkbaar` int(2) NOT NULL COMMENT 'Aantal onwerkbare dagen geurende de rapportage periode',
  `PlanningBinnenAfwijking` int(11) NOT NULL DEFAULT 0 COMMENT 'Totaal dagen afwijking m.b.t. de planning voor binnen',
  `TevredenheidOpdrachtgever` int(11) NOT NULL DEFAULT 0 COMMENT 'Tevredenheid van de opdrachtgever over de rapportageperiode',
  `Tevredenheid omgeving` int(11) NOT NULL DEFAULT 0 COMMENT 'Tevredenheid van de omgeving over de rapportage periode',
  `Algemeen gevoel` int(11) NOT NULL DEFAULT 0 COMMENT 'Hoe loopt het hele project',
  `VeiligheidMaandag` int(11) NOT NULL DEFAULT 0,
  `VeiligheidDinsdag` int(11) NOT NULL DEFAULT 0,
  `VeiligheidWoensdag` int(11) NOT NULL DEFAULT 0,
  `VeiligheidDonderdag` int(11) NOT NULL DEFAULT 0,
  `VeiligheidVrijdag` int(11) NOT NULL DEFAULT 0,
  `RedenAfwijkingVeiligheid` varchar(240) DEFAULT NULL COMMENT 'Reason for deviation regarding Security this week',
  `WerkplezierMaandag` int(11) NOT NULL DEFAULT 0,
  `WerkplezierDinsdag` int(11) NOT NULL DEFAULT 0,
  `WerkplezierWoensdag` int(11) NOT NULL DEFAULT 0,
  `WerkplezierDonderdag` int(11) NOT NULL DEFAULT 0,
  `WerkplezierVrijdag` int(11) NOT NULL DEFAULT 0,
  `RedenAfwijkingWerkplezier` varchar(240) DEFAULT NULL COMMENT 'Reason for deviation regarding Job satisfaction this week',
  `KwaliteitMaandag` int(11) NOT NULL DEFAULT 0,
  `KwaliteitDinsdag` int(11) NOT NULL DEFAULT 0,
  `KwaliteitWoensdag` int(11) NOT NULL DEFAULT 0,
  `KwaliteitDonderdag` int(11) NOT NULL DEFAULT 0,
  `KwaliteitVrijdag` int(11) NOT NULL DEFAULT 0,
  `RedenAfwijkingKwaliteit` varchar(240) DEFAULT NULL COMMENT 'Resaon for deviation regarding quality this week',
  `PlanningMaandag` int(11) NOT NULL DEFAULT 0,
  `PlanningDinsdag` int(11) NOT NULL DEFAULT 0,
  `PlanningWoensdag` int(11) NOT NULL DEFAULT 0,
  `PlanningDonderdag` int(11) NOT NULL DEFAULT 0,
  `PlanningVrijdag` int(11) NOT NULL DEFAULT 0,
  `RedenAfwijkingPlanning` varchar(240) DEFAULT NULL COMMENT 'Reason for deviation regarding planning this week'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Rapportage`
--

INSERT INTO `Rapportage` (`ID`, `Project`, `DatumRappPeriode`, `DatumInvoerRapp`, `PlanningBuitenAfwijking`, `PlanningBuitenOnwerkbaar`, `PlanningBinnenAfwijking`, `TevredenheidOpdrachtgever`, `Tevredenheid omgeving`, `Algemeen gevoel`, `VeiligheidMaandag`, `VeiligheidDinsdag`, `VeiligheidWoensdag`, `VeiligheidDonderdag`, `VeiligheidVrijdag`, `RedenAfwijkingVeiligheid`, `WerkplezierMaandag`, `WerkplezierDinsdag`, `WerkplezierWoensdag`, `WerkplezierDonderdag`, `WerkplezierVrijdag`, `RedenAfwijkingWerkplezier`, `KwaliteitMaandag`, `KwaliteitDinsdag`, `KwaliteitWoensdag`, `KwaliteitDonderdag`, `KwaliteitVrijdag`, `RedenAfwijkingKwaliteit`, `PlanningMaandag`, `PlanningDinsdag`, `PlanningWoensdag`, `PlanningDonderdag`, `PlanningVrijdag`, `RedenAfwijkingPlanning`) VALUES
(8, 4, '2020-09-28', '2020-09-28', 2, 0, 0, 0, 3, 3, 3, 3, 3, 2, 2, NULL, 2, 2, 2, 3, 3, NULL, 3, 2, 3, 2, 3, NULL, 1, 1, 1, 1, 1, NULL),
(9, 4, '2020-10-05', '2020-10-05', 1, 0, 0, 2, 2, 1, 1, 1, 1, 1, 1, NULL, 2, 2, 2, 2, 2, NULL, 3, 3, 3, 3, 3, NULL, 2, 2, 2, 2, 2, NULL),
(10, 4, '2020-10-12', '2020-10-12', 1, 1, 0, 1, 2, 3, 2, 1, 2, 3, 2, NULL, 1, 2, 3, 2, 1, NULL, 2, 3, 2, 1, 2, NULL, 3, 2, 1, 2, 3, NULL),
(11, 4, '2020-10-19', '2020-10-19', 1, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(12, 4, '2020-10-26', '2020-10-26', 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL),
(13, 4, '2020-11-02', '2020-11-02', 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL),
(14, 5, '2020-09-28', '2020-09-28', 0, 0, 0, 2, 3, 2, 3, 2, 3, 2, 3, NULL, 2, 3, 2, 3, 2, NULL, 3, 2, 3, 2, 3, NULL, 2, 3, 2, 3, 2, NULL),
(15, 5, '2020-10-05', '2020-10-05', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL),
(16, 5, '2020-10-12', '2020-10-12', 3, 3, 0, 3, 3, 3, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(17, 5, '2020-10-19', '2020-10-19', 4, 4, 4, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL),
(18, 5, '2020-10-26', '2020-10-26', 4, 4, 0, 2, 2, 2, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL),
(19, 5, '2020-11-02', '2020-11-02', 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL),
(20, 6, '2020-09-28', '2020-09-28', 10, 0, 10, 1, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 2, 2, 2, 1, NULL, 1, 1, 1, 1, 2, NULL, 2, 2, 1, 1, 1, NULL),
(21, 6, '2020-10-05', '2020-10-05', 0, 10, 0, 3, 3, 3, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 32, 2, NULL, 2, 3, 3, 2, 2, NULL, 3, 3, 3, 3, 3, NULL),
(22, 6, '2020-10-12', '2020-10-12', 5, 0, 0, 2, 3, 2, 3, 2, 3, 2, 3, NULL, 2, 3, 2, 3, 2, NULL, 3, 2, 3, 2, 3, NULL, 2, 3, 2, 3, 2, NULL),
(23, 6, '2020-10-19', '2020-10-19', 0, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL, 2, 2, 2, 2, 2, NULL),
(24, 6, '2020-10-26', '2020-10-26', 1, 1, 0, 2, 2, 1, 2, 3, 1, 2, 3, NULL, 1, 2, 3, 1, 2, NULL, 3, 1, 2, 3, 1, NULL, 2, 3, 1, 2, 3, NULL),
(25, 6, '2020-11-02', '2020-11-02', 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 3, NULL, 2, 3, 1, 2, 3, NULL, 1, 2, 3, 1, 2, NULL, 3, 2, 2, 3, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Samenwerkingen`
--

CREATE TABLE `Samenwerkingen` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `Aannemer` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Link naar aannemer',
  `TypeAannemer` varchar(40) NOT NULL DEFAULT 'Hoofdaannemer',
  `Project` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Link naar project',
  `DatumSamenwerkingPeriode` date NOT NULL COMMENT 'Eerste maandag van de (rapportage) week',
  `DatumInvoerSamenwerking` date NOT NULL,
  `NagekomenAfspraken` int(11) NOT NULL DEFAULT 0 COMMENT 'Aantal afspraken welke wel nagekomen zijn',
  `NietNagekomenAfspraken` int(11) NOT NULL DEFAULT 0 COMMENT 'Aantal afspraken welke niet nagekomen zijn',
  `RedenNietNagekomenAfspraken` varchar(240) DEFAULT NULL COMMENT 'Globale reden van de afwijking(en)',
  `NieuweOpleverPunten` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Samenwerkingen`
--

INSERT INTO `Samenwerkingen` (`ID`, `Aannemer`, `TypeAannemer`, `Project`, `DatumSamenwerkingPeriode`, `DatumInvoerSamenwerking`, `NagekomenAfspraken`, `NietNagekomenAfspraken`, `RedenNietNagekomenAfspraken`, `NieuweOpleverPunten`) VALUES
(16, 7, 'Hoofdaannemer', 4, '2020-09-28', '2020-09-28', 5, 1, 'Aanlevering cement te laat door file onderweg', 0),
(17, 8, 'Hoofdaannemer', 5, '2020-10-05', '2020-10-05', 7, 0, 'Geen bijzonderheden', 0),
(18, 9, 'Hoofdaannemer', 6, '2020-10-12', '2020-10-12', 0, 3, 'Alle polen niet aanwezig op het werk wegens staking', 0),
(19, 10, 'Onderaannemer', 4, '2020-10-12', '2020-10-12', 10, 0, 'Geen bijzonderheden', 0),
(20, 7, 'Hoofdaannemer', 4, '2020-10-26', '2020-10-26', 1, 1, 'Miscommunicatie', 0),
(21, 7, 'Hoofdaannemer', 4, '2020-10-19', '2020-10-19', 4, 2, 'Miscommunicatie', 0),
(22, 7, 'Hoofdaannemer', 4, '2020-10-26', '2020-10-26', 5, 0, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Aannemers`
--
ALTER TABLE `Aannemers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Acties`
--
ALTER TABLE `Acties`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `LinkNaarKnelpunten` (`Knelpunt`);

--
-- Indexes for table `Eindklanten`
--
ALTER TABLE `Eindklanten`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Gebruikers`
--
ALTER TABLE `Gebruikers`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Gebruikers_LinkNaarAannemer` (`Aannemer`) USING BTREE;

--
-- Indexes for table `Knelpunten`
--
ALTER TABLE `Knelpunten`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Knelpunten_LinkNaarProject` (`Project`) USING BTREE;

--
-- Indexes for table `Projecten`
--
ALTER TABLE `Projecten`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Projecten_LinkNaarEindklant` (`Klant`) USING BTREE;

--
-- Indexes for table `Rapportage`
--
ALTER TABLE `Rapportage`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `LinkNaarProject` (`Project`) USING BTREE;

--
-- Indexes for table `Samenwerkingen`
--
ALTER TABLE `Samenwerkingen`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Samenwerkingsverband_LinkNaarProject` (`Project`),
  ADD KEY `Samenwerkingsverband_LinkNaarAannemer` (`Aannemer`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Aannemers`
--
ALTER TABLE `Aannemers`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Acties`
--
ALTER TABLE `Acties`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Eindklanten`
--
ALTER TABLE `Eindklanten`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Gebruikers`
--
ALTER TABLE `Gebruikers`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Knelpunten`
--
ALTER TABLE `Knelpunten`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Projecten`
--
ALTER TABLE `Projecten`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Rapportage`
--
ALTER TABLE `Rapportage`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `Samenwerkingen`
--
ALTER TABLE `Samenwerkingen`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Acties`
--
ALTER TABLE `Acties`
  ADD CONSTRAINT `Acties_LinkNaarKnelpunten` FOREIGN KEY (`Knelpunt`) REFERENCES `Knelpunten` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Gebruikers`
--
ALTER TABLE `Gebruikers`
  ADD CONSTRAINT `Gebruikers_ibfk_1` FOREIGN KEY (`Aannemer`) REFERENCES `Aannemers` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Knelpunten`
--
ALTER TABLE `Knelpunten`
  ADD CONSTRAINT `Knelpunten_ibfk_1` FOREIGN KEY (`Project`) REFERENCES `Projecten` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Projecten`
--
ALTER TABLE `Projecten`
  ADD CONSTRAINT `Projecten_ibfk_1` FOREIGN KEY (`Klant`) REFERENCES `Eindklanten` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Rapportage`
--
ALTER TABLE `Rapportage`
  ADD CONSTRAINT `Rapportage_ibfk_1` FOREIGN KEY (`Project`) REFERENCES `Projecten` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Samenwerkingen`
--
ALTER TABLE `Samenwerkingen`
  ADD CONSTRAINT `Samenwerkingen_ibfk_1` FOREIGN KEY (`Aannemer`) REFERENCES `Aannemers` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Samenwerkingen_ibfk_2` FOREIGN KEY (`Project`) REFERENCES `Projecten` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
