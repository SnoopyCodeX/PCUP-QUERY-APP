-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql12.freesqldatabase.com
-- Generation Time: Nov 03, 2023 at 06:33 PM
-- Server version: 5.5.62-0ubuntu0.14.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql12657302`
--

-- --------------------------------------------------------

--
-- Table structure for table `acrceditations`
--

CREATE TABLE `acrceditations` (
  `AcrceditationID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `BarangayID` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `president` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `ca_no` varchar(255) DEFAULT NULL,
  `d_accreditation` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `family` varchar(255) DEFAULT NULL,
  `maleA` varchar(255) DEFAULT NULL,
  `femaleA` varchar(255) DEFAULT NULL,
  `maleB` varchar(255) DEFAULT NULL,
  `femaleB` varchar(255) DEFAULT NULL,
  `others` varchar(255) DEFAULT NULL,
  `areasq` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `danger` varchar(255) DEFAULT NULL,
  `govreg` varchar(255) DEFAULT NULL,
  `gen_ob` varchar(255) DEFAULT NULL,
  `ongoing` varchar(255) DEFAULT NULL,
  `common` varchar(255) DEFAULT NULL,
  `date_org` varchar(255) DEFAULT NULL,
  `v_pres` varchar(255) DEFAULT NULL,
  `sex1` varchar(255) DEFAULT NULL,
  `sec` varchar(255) DEFAULT NULL,
  `sex2` varchar(255) DEFAULT NULL,
  `treasurer` varchar(255) DEFAULT NULL,
  `sex3` varchar(255) DEFAULT NULL,
  `auditor` varchar(255) DEFAULT NULL,
  `sex4` varchar(255) DEFAULT NULL,
  `pro` varchar(255) DEFAULT NULL,
  `sex5` varchar(255) DEFAULT NULL,
  `sgt` varchar(255) DEFAULT NULL,
  `sex6` varchar(255) DEFAULT NULL,
  `sgt1` varchar(255) DEFAULT NULL,
  `sex7` varchar(255) DEFAULT NULL,
  `bod` varchar(255) DEFAULT NULL,
  `sex8` varchar(255) DEFAULT NULL,
  `bod1` varchar(255) DEFAULT NULL,
  `sex9` varchar(255) DEFAULT NULL,
  `bod2` varchar(255) DEFAULT NULL,
  `sex10` varchar(255) DEFAULT NULL,
  `bod3` varchar(255) DEFAULT NULL,
  `sex11` varchar(255) DEFAULT NULL,
  `bod4` varchar(255) DEFAULT NULL,
  `sex12` varchar(255) DEFAULT NULL,
  `bod5` varchar(255) DEFAULT NULL,
  `sex13` varchar(255) DEFAULT NULL,
  `bod6` varchar(255) DEFAULT NULL,
  `sex14` varchar(255) DEFAULT NULL,
  `bod7` varchar(255) DEFAULT NULL,
  `sex15` varchar(255) DEFAULT NULL,
  `bod8` varchar(255) DEFAULT NULL,
  `sex16` varchar(255) DEFAULT NULL,
  `bod9` varchar(255) DEFAULT NULL,
  `notify` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `acrceditations`
--

INSERT INTO `acrceditations` (`AcrceditationID`, `Name`, `BarangayID`, `address`, `president`, `contact`, `sex`, `ca_no`, `d_accreditation`, `expire`, `status`, `family`, `maleA`, `femaleA`, `maleB`, `femaleB`, `others`, `areasq`, `type`, `class`, `danger`, `govreg`, `gen_ob`, `ongoing`, `common`, `date_org`, `v_pres`, `sex1`, `sec`, `sex2`, `treasurer`, `sex3`, `auditor`, `sex4`, `pro`, `sex5`, `sgt`, `sex6`, `sgt1`, `sex7`, `bod`, `sex8`, `bod1`, `sex9`, `bod2`, `sex10`, `bod3`, `sex11`, `bod4`, `sex12`, `bod5`, `sex13`, `bod6`, `sex14`, `bod7`, `sex15`, `bod8`, `sex16`, `bod9`, `notify`) VALUES
(1, 'TAGPURO', 1, 'didi1 b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'GREENDALE', 1, 'didi2 b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'PATAG', 1, 'AWEFAWE', 'AWFEAWEFA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'SAMAR', 2, 'AFA', 'AFEAAEFAWFE', 'AWFA', 'FAEF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'a', NULL, 'a', 'a', 'q', 'a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'arzel', NULL, 'uaus', 'dysys', 'dydyd', 'dydysy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, '12', NULL, '12', '13', '12', '12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'hahs', NULL, 's', 's', 'a', 's', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `barangays`
--

CREATE TABLE `barangays` (
  `BarangayID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `MunicipalityID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barangays`
--

INSERT INTO `barangays` (`BarangayID`, `Name`, `MunicipalityID`) VALUES
(1, 'BOUGAINVILLA', 1),
(2, 'GUMAMELA', 2);

-- --------------------------------------------------------

--
-- Table structure for table `municipalities`
--

CREATE TABLE `municipalities` (
  `MunicipalityID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `ProvinceID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `municipalities`
--

INSERT INTO `municipalities` (`MunicipalityID`, `Name`, `ProvinceID`) VALUES
(1, 'CARCAR', 1),
(2, 'MANILa', 2);

-- --------------------------------------------------------

--
-- Table structure for table `pregnant`
--

CREATE TABLE `pregnant` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `pregnancies` int(5) NOT NULL,
  `age` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pregnant`
--

INSERT INTO `pregnant` (`id`, `name`, `pregnancies`, `age`) VALUES
(1, 'anna', 2, '18'),
(2, 'annie', 2, '19'),
(3, 'janna', 1, '21'),
(4, 'lina', 3, '50'),
(5, 'kimy', 4, '35');

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `ProvinceID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `RegionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`ProvinceID`, `Name`, `RegionID`) VALUES
(1, 'Cebu', 1),
(2, 'Tacloban', 2);

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `RegionID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`RegionID`, `Name`) VALUES
(1, 'Region 1'),
(2, 'Region 2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accreditations`
--

CREATE TABLE `tbl_accreditations` (
  `accreditation_id` int(11) NOT NULL,
  `accreditation_name` varchar(255) DEFAULT NULL,
  `accreditation_barangay` varchar(255) NOT NULL,
  `BarangayID` int(11) DEFAULT NULL,
  `accreditation_address` varchar(255) DEFAULT NULL,
  `accreditation_contactperson` varchar(255) DEFAULT NULL,
  `accreditation_phone` varchar(255) DEFAULT NULL,
  `accreditation_number` varchar(255) DEFAULT NULL,
  `accreditation_issued` varchar(255) DEFAULT NULL,
  `accreditation_expired` varchar(255) DEFAULT NULL,
  `accreditation_president` varchar(255) DEFAULT NULL,
  `accreditation_type` varchar(255) DEFAULT NULL,
  `accreditation_ddress` varchar(255) DEFAULT NULL,
  `accreditation_members` varchar(255) DEFAULT NULL,
  `accreditation_population` varchar(255) DEFAULT NULL,
  `accreditation_belowm` varchar(255) DEFAULT NULL,
  `accreditation_belowf` varchar(255) DEFAULT NULL,
  `accreditation_belowo` varchar(255) DEFAULT NULL,
  `accreditation_abovem` varchar(255) DEFAULT NULL,
  `accreditation_abovef` varchar(255) DEFAULT NULL,
  `accreditation_aboveo` varchar(255) DEFAULT NULL,
  `accreditation_area` varchar(255) DEFAULT NULL,
  `accreditation_class` varchar(255) DEFAULT NULL,
  `accreditation_programs` varchar(255) DEFAULT NULL,
  `accreditation_problems` varchar(255) DEFAULT NULL,
  `accreditation_coordinator` varchar(255) DEFAULT NULL,
  `accreditation_created` varchar(255) DEFAULT NULL,
  `accreditation_remarks` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_accreditations`
--

INSERT INTO `tbl_accreditations` (`accreditation_id`, `accreditation_name`, `accreditation_barangay`, `BarangayID`, `accreditation_address`, `accreditation_contactperson`, `accreditation_phone`, `accreditation_number`, `accreditation_issued`, `accreditation_expired`, `accreditation_president`, `accreditation_type`, `accreditation_ddress`, `accreditation_members`, `accreditation_population`, `accreditation_belowm`, `accreditation_belowf`, `accreditation_belowo`, `accreditation_abovem`, `accreditation_abovef`, `accreditation_aboveo`, `accreditation_area`, `accreditation_class`, `accreditation_programs`, `accreditation_problems`, `accreditation_coordinator`, `accreditation_created`, `accreditation_remarks`) VALUES
(1, 'PCUP', 'BOUGAINVILLA', NULL, '', 'Faith', '09456545414', '02021', 'October 31, 2023', 'October 31, 2023', 'lou', NULL, NULL, '5', '100', NULL, NULL, NULL, NULL, NULL, NULL, 'small', 'dfgfds', 'awef - awefwaef', 'pregnancy rate', 'dfsgfd', NULL, 'APPROVED'),
(2, 'APPROVED', 'GUMAMELA', NULL, '234234', '23423', '', '', 'October 31 2023', 'Expiration : \r\n', '', NULL, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', NULL, 'APPROVED'),
(3, 'orgname', 'GUMAMELA', NULL, 'adress', 'contact', 'phone', 'acc number', 'October 31, 2023', 'October 31, 2023', 'presi', NULL, NULL, 'total ofice', 'poulation', NULL, NULL, NULL, NULL, NULL, NULL, 'area', 'class', 'ssdcsdc - sdsdcs', 'problem', 'acc officer', NULL, 'APPROVED');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_crime`
--

CREATE TABLE `tbl_crime` (
  `crime_id` int(11) NOT NULL,
  `crime_violation` varchar(255) NOT NULL,
  `crime_date` varchar(255) NOT NULL,
  `crime_victim` varchar(255) NOT NULL,
  `crime_perpetrator` varchar(255) NOT NULL,
  `crime_barangay` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_crime`
--

INSERT INTO `tbl_crime` (`crime_id`, `crime_violation`, `crime_date`, `crime_victim`, `crime_perpetrator`, `crime_barangay`) VALUES
(1, 'thief', '04/10/2023', 'ako', 'ikaw', 'BOUGAINVILLA');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_households`
--

CREATE TABLE `tbl_households` (
  `household_id` int(11) NOT NULL,
  `household_lastname` varchar(250) NOT NULL,
  `household_firstname` varchar(250) NOT NULL,
  `household_middlename` varchar(250) NOT NULL,
  `household_suffix` varchar(250) NOT NULL,
  `household_birthdate` varchar(255) NOT NULL,
  `household_age` int(3) NOT NULL,
  `household_sex` varchar(250) NOT NULL,
  `household_student` varchar(250) NOT NULL,
  `household_education` varchar(250) NOT NULL,
  `employment` varchar(250) NOT NULL,
  `household_school` varchar(250) NOT NULL,
  `source` varchar(250) NOT NULL,
  `pregnant` varchar(250) NOT NULL,
  `last_preg` varchar(255) NOT NULL,
  `children` int(11) NOT NULL,
  `household_type` varchar(255) NOT NULL,
  `household_leader` varchar(250) NOT NULL,
  `household_relation` varchar(250) NOT NULL,
  `household_barangay` varchar(255) NOT NULL,
  `household_remarks` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_households`
--

INSERT INTO `tbl_households` (`household_id`, `household_lastname`, `household_firstname`, `household_middlename`, `household_suffix`, `household_birthdate`, `household_age`, `household_sex`, `household_student`, `household_education`, `employment`, `household_school`, `source`, `pregnant`, `last_preg`, `children`, `household_type`, `household_leader`, `household_relation`, `household_barangay`, `household_remarks`) VALUES
(2, '1231', '123', '23', 'JR.', '0000-00-00', 123, 'MALE 	', 'NO', 'Completed senior high school', '', '', '', '', '0000-00-00', 1, '', '', '', '0', '0'),
(3, '123123', '123123', '123123', 'SR.', '2018-02-06', 13, 'FEMALE', 'YES ', 'Enrolled in an undergraduate program at a university or college', '', '', '', '', '0000-00-00', 3, '', '', '', '0', '0'),
(4, 'cydric', 'mayoaef', 'awefaw', 'aefwe', '2023-10-13', 14, '', '', '', '', '', '', '', '0000-00-00', 2, '', '', '', '0', '0'),
(5, 'asasc', 'ascasscasca', 'acascas', 'SR.', '2023-10-03', 21, 'FEMALE', 'NO', 'Completed junior high school', '', '', '', '', '0000-00-00', 2, '', '', '', '0', '0'),
(6, 'bt', 'bt', '', '', '2023-10-03', 51, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(7, 'gg', 'gg', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(8, 'tt', 'tt', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(9, 'hh', 'hh', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(10, 'uu', 'uu', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(11, 'th', 'th', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(12, 'yu', 'yu', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(13, '45', '45', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(14, 'ty', 'ty', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(15, '67', '67', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', '', '0', '0'),
(16, 'tryc', 'tryc', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', 'OTHERS SPECIFY.... / anak', '0', '0'),
(17, 'jjej', 'jeje', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', 'OTHERS SPECIFY.... / anak', '0', '0'),
(18, 'fefe', 'fefe', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', ' / anakfef', '0', '0'),
(19, 'fefe', 'fefe', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', ' / anak', '0', '0'),
(20, 'q', 'q', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', ' / tatay', '0', '0'),
(21, 'gege', 'gege', '', '', '2023-10-03', 0, '', '', '', '', '', '', '', '0000-00-00', 0, '', '', ' taayayya', '0', '0'),
(22, 'fva', 'aw', 'awef', 'SR', '2023-10-31', 56, 'M', '', 'Elementary Level', 'NO', 'grad', '123', 'YES', '2023-11-02', 123, 'LEADER', 'hatdog', 'MOTHER', 'GUMAMELA', 'APPROVED'),
(23, 'wrer', 'wer', 'wer', 'JR', '2023-10-31', 0, 'M', '', 'Elementary Graduate', 'YES', '', 'wer', 'YES', '2023-11-02', 0, 'LEADER', 'wer', 'GRANDMOTHER', 'BOUGAINVILLA', 'APPROVED');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leaders`
--

CREATE TABLE `tbl_leaders` (
  `leader_id` int(11) NOT NULL,
  `leader_name` varchar(255) NOT NULL,
  `leader_sex` varchar(10) NOT NULL,
  `leader_age` int(11) NOT NULL,
  `leader_civilstatus` varchar(20) NOT NULL,
  `leader_barangay_id` int(11) DEFAULT NULL,
  `leader_barangay` varchar(255) NOT NULL,
  `leader_position` varchar(255) NOT NULL,
  `leader_num_family_members` int(11) NOT NULL,
  `leader_total_male` int(11) NOT NULL,
  `leader_total_female` int(11) NOT NULL,
  `leader_totalpwd_physical_male` int(11) NOT NULL,
  `leader_totalpwd_physical_female` int(11) NOT NULL,
  `leader_totalpwd_ndd_male` int(11) NOT NULL,
  `leader_totalpwd_ndd_female` int(11) NOT NULL,
  `leader_senior_male` int(11) NOT NULL,
  `leader_senior_female` int(11) NOT NULL,
  `leader_below_18_male` int(11) NOT NULL,
  `leader_below_18_female` int(11) NOT NULL,
  `leader_education_attainment` varchar(255) NOT NULL,
  `leader_average_income` int(11) NOT NULL,
  `leader_remarks` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_leaders`
--

INSERT INTO `tbl_leaders` (`leader_id`, `leader_name`, `leader_sex`, `leader_age`, `leader_civilstatus`, `leader_barangay_id`, `leader_barangay`, `leader_position`, `leader_num_family_members`, `leader_total_male`, `leader_total_female`, `leader_totalpwd_physical_male`, `leader_totalpwd_physical_female`, `leader_totalpwd_ndd_male`, `leader_totalpwd_ndd_female`, `leader_senior_male`, `leader_senior_female`, `leader_below_18_male`, `leader_below_18_female`, `leader_education_attainment`, `leader_average_income`, `leader_remarks`) VALUES
(3, 'fullnama', 'F', 21, 'Married', NULL, 'GUMAMELA', 'PRESIDENT', 2, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, '', 0, 'APPROVED'),
(4, 'wer', 'BOUGAINVIL', 45, 'Married', NULL, 'wefw', 'PRESIDENT', 55, 44, 44, 44, 44, 0, 0, 44, 44, 44, 4, '', 0, 'NEW'),
(6, 'erser', 'BOUGAINVIL', 0, 'single', NULL, 'ascas', 'MEMBER', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 'APPROVED');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_logs`
--

CREATE TABLE `tbl_logs` (
  `ID` int(11) NOT NULL,
  `logs_username` varchar(255) NOT NULL,
  `logs_content` longtext NOT NULL,
  `logs_date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_logs`
--

INSERT INTO `tbl_logs` (`ID`, `logs_username`, `logs_content`, `logs_date`) VALUES
(8, '123', 'Successfully login', '10 30, YYYY 09:08:52'),
(9, '123', 'Successfully login', 'October 30, 2023 09:11:22'),
(10, '123', 'Successfully login', 'October 30, 2023 09:18:47'),
(11, '123', 'Successfully login', 'October 30, 2023 09:20:43'),
(12, '123', 'Successfully login', 'October 30, 2023 09:29:57'),
(13, '123', 'Successfully login', 'October 30, 2023 09:31:50'),
(14, '123', 'Successfully login', 'October 30, 2023 09:35:12'),
(15, '123', 'Successfully login', 'October 30, 2023 09:37:37'),
(16, '123', 'Successfully login', 'October 30, 2023 09:41:13'),
(17, '123', 'Successfully login', 'October 30, 2023 09:45:39'),
(18, 'elar', 'Successfully login', 'October 30, 2023 10:33:19'),
(19, 'elar', 'Successfully login', 'October 30, 2023 10:45:00'),
(20, 'drix', 'Successfully login', 'November 02, 2023 06:44:49'),
(21, 'drix', 'Successfully login', 'November 02, 2023 06:47:37'),
(22, 'drix', 'Successfully login', 'November 02, 2023 06:55:57'),
(23, 'drix', 'Successfully login', 'November 02, 2023 07:10:59'),
(24, 'drix', 'Successfully login', 'November 02, 2023 07:13:54'),
(25, 'drix', 'Successfully login', 'November 02, 2023 07:50:53'),
(26, 'lou', 'Successfully login', 'November 02, 2023 10:30:30'),
(27, 'lou', 'Successfully login', 'November 02, 2023 10:31:18'),
(28, 'lou', 'Successfully login', 'November 02, 2023 10:35:47'),
(29, 'drix', 'Successfully login', 'November 02, 2023 08:48:14'),
(30, 'drix', 'Successfully login', 'November 02, 2023 08:52:05'),
(31, 'drix', 'Successfully login', 'November 03, 2023 12:16:33'),
(32, 'drix', 'Successfully login', 'November 03, 2023 12:20:12'),
(33, 'louie', 'Successfully login', 'November 03, 2023 12:28:23'),
(34, 'tatay', 'Successfully login', 'November 03, 2023 12:45:56'),
(35, 'tatay', 'Successfully login', 'November 03, 2023 01:01:28'),
(36, 'user', 'Successfully login', 'November 03, 2023 01:11:43'),
(37, 'user', 'Successfully login', 'November 03, 2023 01:17:57'),
(38, 'user', 'Successfully login', 'November 03, 2023 12:04:33'),
(39, '123', 'Successfully login', 'November 03, 2023 12:17:47'),
(40, '123', 'Successfully login', 'November 03, 2023 12:29:55'),
(41, '123', 'Successfully login', 'November 03, 2023 12:32:27'),
(42, '123', 'Successfully login', 'November 03, 2023 12:52:47'),
(43, '123', 'Successfully login', 'November 03, 2023 12:57:07');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_members`
--

CREATE TABLE `tbl_members` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL,
  `phone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_members`
--

INSERT INTO `tbl_members` (`id`, `name`, `address`, `phone`) VALUES
(12, 'dsgd', 'fghfg', '09'),
(2020, 'Lou', 'Caibaan', '09456545414'),
(24354, 'dfd', 'dgfd', '24335'),
(1234567, 'John Carlo Cañada', 'Cubao', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_org`
--

CREATE TABLE `tbl_org` (
  `ID` int(11) NOT NULL,
  `OrgName` varchar(250) NOT NULL,
  `Address` varchar(250) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `ContactPerson` varchar(11) NOT NULL,
  `Remarks` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_org`
--

INSERT INTO `tbl_org` (`ID`, `OrgName`, `Address`, `Phone`, `ContactPerson`, `Remarks`) VALUES
(1, 'DFGD', 'fdfsd', '353', 'fgd', 'Pending'),
(2, 'fawef', 'awefa', 'awefa', 'awfaf', 'Approved'),
(3, 'Orgy Debils', 'Quarry', '09273746089', 'Akira', 'Pending'),
(4, 'WEFW', 'WEF', 'WEFW', 'WEF', 'Pending'),
(5, 'awdfawe', 'awefawef', 'awefaweawef', 'awefawef', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reports`
--

CREATE TABLE `tbl_reports` (
  `report_id` int(11) NOT NULL,
  `report_name` varchar(255) NOT NULL,
  `report_facilitator` varchar(255) NOT NULL,
  `report_date` varchar(255) NOT NULL,
  `report_objective` varchar(255) NOT NULL,
  `report_barangay` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_reports`
--

INSERT INTO `tbl_reports` (`report_id`, `report_name`, `report_facilitator`, `report_date`, `report_objective`, `report_barangay`) VALUES
(1, 'ssdcsdc', 'sdsdcs', '31/10/2023', 'basta la', 'BOUGAINVILLA'),
(2, 'awef', 'awefwaef', '31/10/2023', 'awefaw', 'BOUGAINVILLA'),
(4, 'program', 'faci', '31/10/2023', '\r\nobj', 'BOUGAINVILLA'),
(5, 'pabahay', 'akonala', '28/02/2019', 'luawvkawjvlawgfahwbcbkjawgechawbecmawc', 'BOUGAINVILLA');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(250) NOT NULL,
  `user_password` varchar(250) NOT NULL,
  `user_email` varchar(250) NOT NULL,
  `user_phone` int(11) NOT NULL,
  `user_type` varchar(250) NOT NULL,
  `user_fullname` varchar(255) NOT NULL,
  `user_barangay` varchar(255) NOT NULL,
  `user_remarks` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_name`, `user_password`, `user_email`, `user_phone`, `user_type`, `user_fullname`, `user_barangay`, `user_remarks`) VALUES
(1, 'drix', '1234', 'drix@jduwowl', 90875656, 'CLIENT', 'drixmayor', 'BOUGAINVILLA', 'NEW'),
(2, '123', '123', 'kjbaj@gmail.com', 12351213, 'CLIENT', '', 'BOUGAINVILLA', 'APPROVED'),
(3, 'user', 'pass', 'email', 908, 'CLIENT', 'fullname', 'BOUGAINVILLA', 'APPROVED'),
(4, '4', '4', '4', 4, 'ADMIN', 'drix', 'BOUGAINVILLA', 'NEW'),
(7, 'scSa', 'aSCa', 'AcA', 0, 'CLIENT', '', '', 'APPROVED'),
(8, 'drix', 'drix', 'drid@gmail.com', 123124, 'CLIENT', 'drixfull', '', '0'),
(9, 'qwd', 'qwd', 'qwqwd@gg', 0, '', '', '', '0'),
(10, 'lou', '123', 'lou@gmail.com', 2147483647, 'CLIENT', '', '', '0'),
(11, 'elar', 'elar', 'elar@gmail.com', 2147483647, '', '', '', '0'),
(12, 'faithuy', 'peeytt', 'faithuy@gmail.com', 2147483647, 'CLIENT', '', '', '0'),
(13, 'faithuyy', 'pityangg', 'faithuyy@gmail.com', 2147483647, 'CLIENT', '', '', '0'),
(14, 'louie', '1234', 'loiue@gmail.com', 2147483647, '', '', '', ''),
(15, 'tatay', 'tatay', 'tatay@gmail.com', 13212423, '', 'tatayhahaha', '', 'APPROVED'),
(16, 'esrg', 'esrg', 'serg', 0, 'CLIENT', 'serg', 'GUMAMELA', 'NEW'),
(17, '0', '0', '0@gmail.com', 0, 'CLIENT', '', '', 'APPROVED'),
(18, 'sirneil', 'sirneil', 'sirneil@gmail.com', 908080123, '', 'sirneil', '', 'NEW');

-- --------------------------------------------------------

--
-- Table structure for table `test_table`
--

CREATE TABLE `test_table` (
  `test_id` int(11) NOT NULL,
  `test_name` varchar(255) NOT NULL,
  `test_address` varchar(255) NOT NULL,
  `test_age` varchar(255) NOT NULL,
  `test_violation` varchar(250) NOT NULL,
  `test_pregnant` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test_table`
--

INSERT INTO `test_table` (`test_id`, `test_name`, `test_address`, `test_age`, `test_violation`, `test_pregnant`) VALUES
(1, 'dric', 'guadalupe', '17', '1', '3'),
(2, 'chubs', 'guadalupe', '15', '2', '7'),
(3, 'killo', 'bougainvilla', '16', '2', '1'),
(4, 'halow', 'bougainvilla', '26', '1', '2');

-- --------------------------------------------------------

--
-- Table structure for table `test_test`
--

CREATE TABLE `test_test` (
  `TestID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `BarangayID` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `violation` int(11) DEFAULT NULL,
  `pregnant` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test_test`
--

INSERT INTO `test_test` (`TestID`, `Name`, `BarangayID`, `age`, `violation`, `pregnant`) VALUES
(1, 'DRIX', 1, 15, 2, 2),
(2, 'CHUBS', 1, 25, 3, 1),
(3, 'GUY', 2, 21, 2, 2),
(4, 'YAKS', 2, 15, 3, 1),
(5, 'kiko', 1, 17, 2, 5),
(6, 'loli', 2, 15, 3, 1),
(7, 'yummy', 1, 100, 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acrceditations`
--
ALTER TABLE `acrceditations`
  ADD PRIMARY KEY (`AcrceditationID`),
  ADD KEY `BarangayID` (`BarangayID`);

--
-- Indexes for table `barangays`
--
ALTER TABLE `barangays`
  ADD PRIMARY KEY (`BarangayID`),
  ADD KEY `MunicipalityID` (`MunicipalityID`);

--
-- Indexes for table `municipalities`
--
ALTER TABLE `municipalities`
  ADD PRIMARY KEY (`MunicipalityID`),
  ADD KEY `ProvinceID` (`ProvinceID`);

--
-- Indexes for table `pregnant`
--
ALTER TABLE `pregnant`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`ProvinceID`),
  ADD KEY `RegionID` (`RegionID`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`RegionID`);

--
-- Indexes for table `tbl_accreditations`
--
ALTER TABLE `tbl_accreditations`
  ADD PRIMARY KEY (`accreditation_id`),
  ADD KEY `BarangayID` (`BarangayID`);

--
-- Indexes for table `tbl_crime`
--
ALTER TABLE `tbl_crime`
  ADD PRIMARY KEY (`crime_id`);

--
-- Indexes for table `tbl_households`
--
ALTER TABLE `tbl_households`
  ADD PRIMARY KEY (`household_id`);

--
-- Indexes for table `tbl_leaders`
--
ALTER TABLE `tbl_leaders`
  ADD PRIMARY KEY (`leader_id`),
  ADD KEY `FK_leader_barangay` (`leader_barangay_id`);

--
-- Indexes for table `tbl_logs`
--
ALTER TABLE `tbl_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_members`
--
ALTER TABLE `tbl_members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_org`
--
ALTER TABLE `tbl_org`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_reports`
--
ALTER TABLE `tbl_reports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `test_table`
--
ALTER TABLE `test_table`
  ADD PRIMARY KEY (`test_id`);

--
-- Indexes for table `test_test`
--
ALTER TABLE `test_test`
  ADD PRIMARY KEY (`TestID`),
  ADD KEY `BarangayID` (`BarangayID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acrceditations`
--
ALTER TABLE `acrceditations`
  MODIFY `AcrceditationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `barangays`
--
ALTER TABLE `barangays`
  MODIFY `BarangayID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `municipalities`
--
ALTER TABLE `municipalities`
  MODIFY `MunicipalityID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `pregnant`
--
ALTER TABLE `pregnant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `ProvinceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tbl_accreditations`
--
ALTER TABLE `tbl_accreditations`
  MODIFY `accreditation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tbl_crime`
--
ALTER TABLE `tbl_crime`
  MODIFY `crime_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tbl_households`
--
ALTER TABLE `tbl_households`
  MODIFY `household_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `tbl_leaders`
--
ALTER TABLE `tbl_leaders`
  MODIFY `leader_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_logs`
--
ALTER TABLE `tbl_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `tbl_org`
--
ALTER TABLE `tbl_org`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_reports`
--
ALTER TABLE `tbl_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_accreditations`
--
ALTER TABLE `tbl_accreditations`
  ADD CONSTRAINT `tbl_accreditations_ibfk_1` FOREIGN KEY (`BarangayID`) REFERENCES `barangays` (`BarangayID`);

--
-- Constraints for table `tbl_leaders`
--
ALTER TABLE `tbl_leaders`
  ADD CONSTRAINT `FK_leader_barangay` FOREIGN KEY (`leader_barangay_id`) REFERENCES `barangays` (`BarangayID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
