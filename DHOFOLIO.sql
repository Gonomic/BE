-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 19, 2021 at 09:57 PM
-- Server version: 10.3.21-MariaDB
-- PHP Version: 5.6.40

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetContractor` (IN `ContractorIDIn` INT)  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Sproc to get the details of a certain contractor by contractorID'
select * from Aannemers
where ID = ContractorIDIn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetKnelpunten` ()  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get data for Knelpunten per customer/project'
SELECT `Eindklanten`.`Naam` AS "Naam klant" , `Projecten`.`Naam` AS "Naam project", `Projecten`.`Projectnummer`, 
`Knelpunten`.`Omschrijving`,
`Knelpunten`.`DatumIngebracht`, `Knelpunten`.`Honkbal`, `Knelpunten`.`ActieVerantwoordelijke`, `Knelpunten`.`OmschrijvingActie`, `Knelpunten`.`DatumVerwachtOpgelost`, `Knelpunten`.`DatumWerkelijkOpgelost`
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
SELECT `Samenwerkingen`.`DatumSamenwerkingPeriode`, `Samenwerkingen`.`TypeAannemer`, `Aannemers`.`Naam`, `Projecten`.`Projectnummer`, `Projecten`.`Naam`, `Eindklanten`.`Naam`, `Samenwerkingen`.`NagekomenAfspraken`, `Samenwerkingen`.`NietNagekomenAfspraken`, `Samenwerkingen`.`RedenNietNagekomenAfspraken`, `Samenwerkingen`.`NieuweOpleverPunten`,
`Samenwerkingen`.`OpenstaandeOpleverpunten`
FROM `Samenwerkingen` 
	LEFT JOIN `Aannemers` ON `Samenwerkingen`.`Aannemer` = `Aannemers`.`ID` 
	LEFT JOIN `Projecten` ON `Samenwerkingen`.`Project` = `Projecten`.`ID` 
	LEFT JOIN `Eindklanten` ON `Projecten`.`Klant` = `Eindklanten`.`ID`
    ORDER BY DatumSamenwerkingPeriode ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlainListOfContractors` (IN `ContractorNameIn` VARCHAR(20))  READS SQL DATA
    COMMENT 'Sproc to get all contractors with a name sounding like...'
SELECT DISTINCT * FROM Aannemers 
	WHERE Naam LIKE CONCAT('%',ContractorNameIn, '%')
    ORDER By Naam ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlainListOfProjects` (IN `ProjectnumberIn` INT)  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Sproc to get projects with number Like ...'
SELECT DISTINCT * FROM Projecten 
	WHERE Projectnummer LIKE CONCAT(ProjectNumberIn, '%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPlainListOfWeeksForAProject` (IN `projectIDIn` INT)  READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'Returns all report weeks for a specific project'
SELECT
    `Projecten`.`ID` as ProjectID,
    `Rapportage`.`ID`as RapportageID,
    WEEK(`Rapportage`.`DatumRappPeriode`) as Week,
    CONCAT(YEAR(`Rapportage`.`DatumRappPeriode`), ' - ', 'Wk ', WEEK(`Rapportage`.`DatumRappPeriode`)) as YearAndWeek
FROM
    `Projecten`
LEFT JOIN `Rapportage` ON `Rapportage`.`Project` = `Projecten`.`ID`
WHERE
    `Projecten`.`ID` = ProjectIDIn
ORDER BY YEAR(`Rapportage`.`DatumRappPeriode`), 		WEEK(`Rapportage`.`DatumRappPeriode`)$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSamenWerkingenForASpecificWeek` (IN `ProjectIdIn` INT, IN `WeekNbrIn` INT)  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Sproc to get all contractors for a spec. project in a spec. wk'
SELECT
    `Projecten`.`ID` AS ProjectID,
    `Samenwerkingen`.*,
    `Aannemers`.`Naam`
FROM
    `Projecten`
LEFT JOIN `Samenwerkingen` ON `Samenwerkingen`.`Project` = `Projecten`.`ID`
LEFT JOIN `Aannemers` ON `Samenwerkingen`.`Aannemer` = `Aannemers`.`ID`
WHERE
    `Projecten`.`ID` = ProjectIdIn
    AND
    WEEK(`Samenwerkingen`.`DatumSamenwerkingPeriode`) = WeekNbrIn$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWeekRappDetails` (IN `WeekRappIDIn` INT)  READS SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'SPROC to get the details of a report for a specific projectweek'
SELECT `Rapportage`.*
FROM `Rapportage` WHERE ID = WeekRappIDIn$$

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
(7, 'Fa. Installateur', 'Eenstraat 1', '1111AA', 'Eendorp', 'Eduard En'),
(8, 'Fa. Metselaar', 'Tweestraat 2', '2222BB', 'Tweedorp', 'Tinus Wee'),
(9, 'Fa. Timmerman', 'Driestraat', '3333CC', 'Driedorp', 'Dirk Rie'),
(10, 'Fa. Loodgieter', 'Vierstraat 4', '4444DD', 'Vierdorp', 'Victor Ier'),
(11, 'Fa. Dakbedekking', 'Vijfstraat 5', '5555AA', 'Vijfdorp', 'Jan vijf'),
(12, 'Fa. Trappen', 'Zesstraat 6', '6666AA', 'Zesdorp', 'Piet Zes');

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
(2, 'Metselaar wil definitieve keuze voor tijdig bestelling stenen', 4, 0, '2021-01-11', 'Opvragen keuze bij opdrachtgever', 'Jos Bakker', '2021-01-18', '2021-01-25'),
(3, 'Vlechtijzer niet op tijd geleverd', 5, 0, '2020-11-25', 'Betere routebeschrijving sturen en per dag de komende wegwerkzaamheden in de buurt van het werk ophalen bij de ANWB', 'Roulant Tebeschrijving', '2020-11-30', '2021-03-31'),
(4, 'Geen metselaars beschikbaar', 6, 0, '2020-10-01', 'Polen inhuren', 'Ron Selaar', '2020-11-27', '2021-04-30'),
(5, 'Date null dates produces error in Klipfolio', 7, 0, '2020-11-27', 'Change query string to what Klipfolio advices', 'Frans', '2020-11-30', '2021-04-30'),
(6, 'Extra verwarming nodig', 4, 0, '2021-01-18', 'Mogelijkheden navragen', 'Jos Bakker', '2021-01-19', '2021-01-18'),
(7, 'Mannen zijn erg tevreden over geplaatste toiletunits. Kunnen we niet standaard toiletten plaatsen op alle projecten?', 4, 1, '2021-01-11', '', 'Jos Bakker', '2021-01-11', '2021-01-11');

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
(8, 4, '2021-01-04', '2021-02-07', 0, 0, 0, 3, 3, 5, 3, 3, 3, 2, 2, 'Helmen worden niet correct gedragen', 3, 3, 3, 3, 3, '', 1, 1, 1, 2, 2, 'Installateur heeft gewerkt met verkeerde tekening', 3, 3, 3, 3, 3, ''),
(9, 4, '2021-01-11', '2021-02-07', 1, 1, 0, 3, 2, 5, 3, 3, 3, 3, 3, 'Helmen werden deze week goed gedragen', 3, 2, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 2, 2, 'Wegens regen achterstand opgelopen'),
(10, 4, '2021-01-18', '2021-02-07', 1, 1, 0, 3, 2, 4, 3, 3, 3, 3, 3, NULL, 2, 2, 2, 2, 2, 'Veel onduidelijkheden tekening', 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(11, 4, '2021-01-25', '2021-02-07', 3, 1, 0, 2, 3, 4, 1, 2, 2, 3, 3, 'Steiger niet goed geplaatst', 2, 2, 2, 2, 2, NULL, 3, 3, 3, 3, 3, NULL, 2, 3, 3, 3, 3, 'Betonplaten niet geleverd, hierdoor twee dagen stilstand'),
(12, 4, '2021-02-01', '2021-02-07', 4, 2, 0, 3, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 2, 2, 2, 'Elektriciteit viel steeds uit', 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(13, 4, '2021-02-08', '2021-02-07', 4, 2, 1, 1, 3, 3, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 1, 1, NULL, 1, 2, 2, 1, 1, 'Afkeuring beton door opdrachtgever', 3, 3, 1, 1, 1, 'Door afkeuring beton, werkzaamheden opnieuw moeten uitvoeren. '),
(14, 5, '2021-01-04', '2021-01-04', 0, 0, 0, 3, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, 'Net opgestart alles loopt prima'),
(15, 5, '2021-01-11', '2021-01-11', 1, 1, 0, 3, 2, 5, 3, 3, 2, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 2, 1, 1, 1, 'Partner x kon afspraken niet nakomen'),
(16, 5, '2021-01-18', '2021-01-18', 1, 1, 0, 3, 3, 4, 1, 1, 1, 1, 1, 'Door harde wind steiger instabiel', 3, 3, 2, 2, 2, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(17, 5, '2021-01-25', '2021-01-25', 3, 1, 4, 2, 2, 2, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 2, 2, 2, 1, 'Opdrachtgever heeft oplevering afgekeurd', 3, 3, 3, 3, 3, NULL),
(18, 5, '2021-02-01', '2021-02-01', 4, 3, 0, 3, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 2, 3, 2, 2, '', 3, 3, 3, 2, 2, 'Problemen met nat weer i.c.m. schilderen'),
(19, 5, '2021-02-08', '2021-02-08', 4, 3, 0, 2, 3, 4, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 2, 2, 2, 2, 1, 'Weersomstandigheden zitten tegen'),
(20, 6, '2021-01-04', '2021-01-04', 0, 0, 0, 3, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(21, 6, '2021-01-11', '2021-01-11', 0, 0, 0, 2, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 2, 2, 2, NULL, 3, 3, 3, 2, 2, NULL, 3, 3, 3, 3, 3, NULL),
(22, 6, '2021-01-18', '2021-01-18', 1, 0, 0, 3, 3, 4, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 2, 2, 2, 2, 3, NULL, 3, 3, 3, 3, 2, NULL),
(23, 6, '2021-01-25', '2021-01-25', 1, 2, 0, 3, 2, 5, 3, 3, 2, 2, 2, 'Gevaarlijke situatie voor bewoners door hijsbeweging', 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL),
(24, 6, '2021-02-01', '2021-02-01', 3, 1, 0, 2, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 2, 2, 1, 1, 1, 'Door ziekte grote achterstand opgelopen'),
(25, 6, '2021-02-08', '2021-02-08', 3, 0, 0, 5, 3, 4, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 2, 2, 2, 2, 2, NULL),
(26, 4, '2021-02-15', '2021-02-07', 5, 3, 0, 3, 3, 5, 3, 3, 3, 2, 2, 'Losse steigerplanken', 3, 3, 3, 3, 3, '', 3, 3, 3, 3, 3, 'Nieuw beton goedgekeurd door opdrachtgever. Dank aan extra inspanningen partner X', 2, 2, 2, 2, 2, 'Lopen wel in maar zijn er nog niet'),
(27, 5, '2021-02-15', '2021-02-15', 3, 3, 0, 2, 3, 4, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 2, 3, 3, 3, 3, ''),
(28, 6, '2021-02-15', '2021-02-15', 3, 0, 0, 5, 3, 5, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 3, 3, 3, 3, 3, NULL, 2, 2, 2, 2, 2, NULL);

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
  `NieuweOpleverPunten` int(11) NOT NULL,
  `OpenstaandeOpleverpunten` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Samenwerkingen`
--

INSERT INTO `Samenwerkingen` (`ID`, `Aannemer`, `TypeAannemer`, `Project`, `DatumSamenwerkingPeriode`, `DatumInvoerSamenwerking`, `NagekomenAfspraken`, `NietNagekomenAfspraken`, `RedenNietNagekomenAfspraken`, `NieuweOpleverPunten`, `OpenstaandeOpleverpunten`) VALUES
(18, 9, 'Hoofdaannemer', 6, '2021-01-04', '2021-01-04', 10, 0, '', 2, NULL),
(19, 8, 'Onderaannemer', 4, '2021-01-04', '2021-01-04', 10, 0, 'Geen bijzonderheden', 3, 3),
(22, 7, 'Hoofdaannemer', 4, '2021-01-18', '2021-01-18', 10, 0, NULL, 5, 0),
(23, 7, 'Hoofdaannemer', 4, '2021-01-11', '2021-01-11', 10, 8, NULL, 4, 1),
(24, 7, 'Hoofdaannemer', 4, '2021-01-04', '2021-01-04', 10, 6, NULL, 2, 3),
(25, 7, 'Hoofdaannemer', 4, '2021-02-01', '2021-02-01', 10, 8, NULL, 5, 1),
(26, 7, 'Hoofdaannemer', 4, '2021-01-25', '2020-12-03', 10, 0, NULL, 0, 8),
(28, 7, 'Hoofdaannemer', 4, '2021-02-08', '2021-02-08', 9, 4, NULL, 0, NULL),
(29, 8, 'Onderaannemer', 4, '2021-01-11', '2021-01-11', 10, 2, '', 2, NULL),
(30, 8, 'Onderaannemer', 4, '2021-01-18', '2021-01-18', 10, 1, '', 6, NULL),
(31, 8, 'Onderaannemer', 4, '2021-01-25', '2021-01-25', 10, 0, '', 3, NULL),
(32, 8, 'Onderaannemer', 4, '2021-02-01', '2021-02-01', 10, 0, '', 0, 4),
(33, 8, 'Onderaannemer', 4, '2021-02-08', '2021-02-08', 10, 2, '', 1, 0),
(34, 9, 'Onderaannemer', 4, '2021-01-04', '2021-01-04', 10, 2, '', 0, 2),
(35, 9, 'Onderaannemer', 4, '2021-01-11', '2021-01-11', 10, 0, '', 3, 3),
(36, 9, 'Onderaannemer', 4, '2021-01-18', '2021-01-18', 10, 1, '', 0, 0),
(37, 9, 'Onderaannemer', 4, '2021-01-25', '2021-01-25', 10, 0, '', 0, 7),
(38, 9, 'Onderaannemer', 4, '2021-02-01', '2021-02-01', 10, 0, '', 0, 4),
(39, 9, 'Onderaannemer', 4, '2021-02-08', '2021-02-08', 11, 0, '', 4, 3),
(40, 9, 'Onderaannemer', 4, '2021-02-15', '2021-02-15', 11, 0, '', 4, 6),
(41, 8, 'Onderaannemer', 4, '2021-02-15', '2021-02-15', 10, 1, '', 4, 2),
(42, 7, 'Onderaannemer', 4, '2021-02-15', '2021-02-15', 11, 3, '', 4, 8),
(43, 7, 'Hoofdaannemer', 6, '2021-01-04', '2021-01-04', 10, 5, '', 2, NULL),
(44, 8, 'Hoofdaannemer', 6, '2021-01-04', '2021-01-04', 10, 0, '', 2, NULL),
(45, 9, 'Hoofdaannemer', 6, '2021-01-11', '2021-01-11', 10, 5, '', 2, NULL),
(46, 8, 'Hoofdaannemer', 6, '2021-01-11', '2021-01-11', 10, 0, '', 2, NULL),
(47, 7, 'Hoofdaannemer', 6, '2021-01-11', '2021-01-11', 10, 2, '', 2, NULL),
(48, 7, 'Hoofdaannemer', 6, '2021-01-18', '2021-01-18', 10, 0, '', 2, NULL),
(49, 8, 'Hoofdaannemer', 6, '2021-01-18', '2021-01-18', 10, 0, '', 2, NULL),
(50, 9, 'Hoofdaannemer', 6, '2021-01-18', '2021-01-18', 10, 8, '', 2, NULL),
(51, 9, 'Hoofdaannemer', 6, '2021-01-25', '2021-01-25', 10, 4, '', 2, NULL),
(52, 9, 'Hoofdaannemer', 6, '2021-02-01', '2021-02-01', 10, 0, '', 2, NULL),
(53, 9, 'Hoofdaannemer', 6, '2021-02-08', '2021-02-08', 10, 0, '', 2, NULL),
(54, 9, 'Hoofdaannemer', 6, '2021-02-15', '2021-02-15', 10, 0, '', 2, NULL),
(55, 8, 'Hoofdaannemer', 6, '2021-01-25', '2021-01-25', 10, 0, '', 2, NULL),
(56, 8, 'Hoofdaannemer', 6, '2021-02-01', '2021-01-04', 10, 0, '', 2, NULL),
(57, 8, 'Hoofdaannemer', 6, '2021-02-08', '2021-02-08', 10, 0, '', 2, NULL),
(58, 8, 'Hoofdaannemer', 6, '2021-02-15', '2021-02-15', 10, 0, '', 2, NULL),
(59, 7, 'Hoofdaannemer', 6, '2021-01-25', '2021-01-25', 10, 3, '', 2, NULL),
(60, 7, 'Hoofdaannemer', 6, '2021-02-01', '2021-02-01', 10, 6, '', 2, NULL),
(61, 7, 'Hoofdaannemer', 6, '2021-02-08', '2021-02-08', 10, 10, '', 2, NULL),
(62, 7, 'Hoofdaannemer', 6, '2021-02-15', '2021-02-15', 10, 0, '', 2, NULL),
(63, 9, 'Hoofdaannemer', 5, '2021-01-04', '2021-01-04', 10, 8, '', 2, NULL),
(64, 9, 'Hoofdaannemer', 5, '2021-01-11', '2021-01-11', 10, 5, '', 2, NULL),
(65, 9, 'Hoofdaannemer', 5, '2021-01-18', '2021-01-18', 10, 3, '', 2, NULL),
(66, 9, 'Hoofdaannemer', 5, '2021-01-25', '2021-01-25', 10, 10, '', 2, NULL),
(67, 9, 'Hoofdaannemer', 5, '2021-02-01', '2021-02-01', 10, 7, '', 2, NULL),
(68, 9, 'Hoofdaannemer', 5, '2021-02-08', '2021-02-08', 10, 4, '', 2, NULL),
(69, 9, 'Hoofdaannemer', 5, '2021-02-15', '2021-02-15', 10, 4, '', 2, NULL),
(70, 8, 'Hoofdaannemer', 5, '2021-01-04', '2021-01-04', 10, 0, '', 2, NULL),
(71, 8, 'Hoofdaannemer', 5, '2021-01-11', '2021-01-11', 10, 0, '', 2, NULL),
(72, 8, 'Hoofdaannemer', 5, '2021-01-18', '2021-01-18', 10, 0, '', 2, NULL),
(73, 8, 'Hoofdaannemer', 5, '2021-01-25', '2021-01-25', 10, 1, '', 2, NULL),
(74, 8, 'Hoofdaannemer', 5, '2021-02-01', '2021-02-01', 10, 1, '', 2, NULL),
(75, 8, 'Hoofdaannemer', 5, '2021-02-08', '2021-02-08', 10, 0, '', 2, NULL),
(76, 8, 'Hoofdaannemer', 5, '2021-02-15', '2021-02-15', 10, 0, '', 2, NULL),
(77, 7, 'Hoofdaannemer', 5, '2021-01-04', '2021-01-04', 10, 1, '', 2, NULL),
(78, 7, 'Hoofdaannemer', 5, '2021-01-11', '2021-01-11', 10, 1, '', 2, NULL),
(79, 7, 'Hoofdaannemer', 5, '2021-02-08', '2021-02-08', 10, 0, '', 2, NULL),
(80, 7, 'Hoofdaannemer', 5, '2021-01-18', '2021-01-18', 10, 0, '', 2, NULL),
(81, 7, 'Hoofdaannemer', 5, '2021-01-25', '2021-01-25', 10, 0, '', 2, NULL),
(82, 7, 'Hoofdaannemer', 5, '2021-02-01', '2021-02-01', 10, 2, '', 2, NULL),
(83, 7, 'Hoofdaannemer', 5, '2021-02-01', '2021-02-01', 10, 0, '', 2, NULL),
(84, 7, 'Hoofdaannemer', 5, '2021-02-15', '2021-02-15', 10, 2, '', 2, NULL);

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
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Projecten`
--
ALTER TABLE `Projecten`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Rapportage`
--
ALTER TABLE `Rapportage`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `Samenwerkingen`
--
ALTER TABLE `Samenwerkingen`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

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
