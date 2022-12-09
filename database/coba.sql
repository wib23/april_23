-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2022 at 10:16 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coba`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pendaftar` ()   BEGIN
    DECLARE i,n INT;
    DECLARE jalur_id INT;
    DECLARE no_pendaftar varchar(20);
    DECLARE nama varchar(100);
    DECLARE nisn varchar(15);
    DECLARE nik varchar(20);
    DECLARE tempat_lahir varchar(60);
    DECLARE tanggal_lahir date;
    DECLARE jenis_kelamin varchar(30);
    DECLARE no_hp varchar(20);
    DECLARE alamat text;
    DECLARE agama varchar(25);
    DECLARE idp1 int(11);
    DECLARE idp2 int(11);
    DECLARE nominal_bayar varchar(15);
    DECLARE id_bank int(11);
    DECLARE isb int(11);
    
    DECLARE pendaftar_id INT;
    DECLARE tingkat_prestasi VARCHAR(30);
    DECLARE nama_prestasi VARCHAR(255);
    DECLARE tahun int;
    DECLARE url_dokumen VARCHAR(100);

SET i = 0;
SET n = 1000;
while i < n DO

    SET jalur_id = (SELECT id_jalur FROM jalur_masuk ORDER BY RAND() LIMIT 1);
    SET no_pendaftar = (SELECT CONCAT('P',YEAR(CURRENT_DATE()),jalur_id , (i+1)));
    SET nama = (SELECT CONCAT('AprilYandi Dwi W ', (i+1)));
    SET nisn = (SELECT CONCAT('56419974', (i+1)));
    SET nik = (SELECT CONCAT('3276010023', (i+1)));
    SET tempat_lahir = 'Jakarta';
    SET tanggal_lahir = (SELECT '2001-12-31'- INTERVAL FLOOR(RAND() * 30) DAY);
    SET jenis_kelamin = 'Laki-Laki';
    SET no_hp = (SELECT CONCAT('0851720231', (i+1)));
    SET alamat = (SELECT CONCAT('Kp,Babakan No. ', (i+1)));
    SET agama = 'Islam';
    SET idp1 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
    SET idp2 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
    SET nominal_bayar = 1500000;
    SET id_bank = (SELECT id_bank FROM bank ORDER BY RAND() LIMIT 1);
    SET isb = 1;
    
    IF jalur_id = 1 THEN
    SET nominal_bayar = null;
        SET nominal_bayar = null;
        SET isb = 1;
    END IF;

	IF (i+1) % 5 = 0 THEN
    SET jenis_kelamin = 'Perempuan';
        SET tempat_lahir = 'Depok';
    END IF;
    
    IF (i+1) % 3 = 0 THEN
    SET isb = 0;
    END IF;

 
    INSERT INTO pendaftar (id_jalur, no_pendaftar, nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, alamat, agama, id_prodi1, id_prodi2, nominal_bayar, id_bank, is_bayar)
    VALUES (jalur_id, no_pendaftar, nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, alamat, agama, idp1, idp2, nominal_bayar, id_bank, isb);

        SET pendaftar_id = (SELECT LAST_INSERT_ID());

        if jalur_id = 3 THEN
        SET tingkat_prestasi = 'NASIONAL';
        SET tahun = (SELECT YEAR(CURRENT_DATE()));

        if (1+i) % 6 = 0 THEN
        	SET tingkat_prestasi = 'INTERNASIONAL';
        	SET tahun = (SELECT YEAR(CURRENT_DATE()));
        END if;
        SET nama_prestasi = (SELECT CONCAT('Prestasi ', tingkat_prestasi,' ', nama));
        SET url_dokumen = (SELECT CONCAT('public/uploads/prestasi/', pendaftar_id)); 
        
        INSERT INTO pendaftar_prestasi (id_pendaftar, tingkat_prestasi, nama_prestasi, tahun, url_dokumen)
        VALUES(pendaftar_id, tingkat_prestasi, nama_prestasi, tahun, url_dokumen);
        
        END IF;
        SET i = i + 1;
        END WHILE;
        END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `bank` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `bank`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'BCA', '2022-12-07 04:46:34', NULL, NULL, NULL),
(2, 'MANDIRI', '2022-12-07 04:47:11', NULL, NULL, NULL),
(3, 'BNI', '2022-12-07 04:47:31', NULL, NULL, NULL),
(4, 'BRI', '2022-12-07 04:47:44', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fakultas`
--

CREATE TABLE `fakultas` (
  `id_fakultas` int(11) NOT NULL,
  `id_perguruan_tinggi` int(11) NOT NULL DEFAULT 0,
  `nama_fakultas` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fakultas`
--

INSERT INTO `fakultas` (`id_fakultas`, `id_perguruan_tinggi`, `nama_fakultas`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'Teknologi Industri', '2022-12-07 05:04:36', NULL, NULL, NULL),
(2, 1, 'Fakultas Sastra', '2022-12-07 05:06:18', NULL, NULL, NULL),
(3, 1, 'Fakultas Ilmu Komunikasi Dan Teknlogi Informasi', '2022-12-07 05:07:39', NULL, NULL, NULL),
(4, 1, 'Fakultas Ekonomi', '2022-12-07 05:08:25', NULL, NULL, NULL),
(5, 1, 'Fakultas Psikologi', '2022-12-07 05:21:02', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jalur_masuk`
--

CREATE TABLE `jalur_masuk` (
  `id_jalur` int(11) NOT NULL,
  `nama_jalur` varchar(255) NOT NULL,
  `is_tes` int(11) NOT NULL,
  `is_mandiri` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jalur_masuk`
--

INSERT INTO `jalur_masuk` (`id_jalur`, `nama_jalur`, `is_tes`, `is_mandiri`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'Mandiri(test)', 1, 1, '2022-12-07 11:45:56', NULL, NULL, '2022-12-07 11:47:36'),
(2, 'Mandiri(Prestasi)', 0, 1, '2022-12-07 11:47:27', NULL, NULL, NULL),
(3, 'SNMPTN', 0, 0, '2022-12-07 12:30:18', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pendaftar`
--

CREATE TABLE `pendaftar` (
  `id_pendaftar` int(11) NOT NULL,
  `id_jalur` int(11) NOT NULL,
  `no_pendaftar` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nisn` varchar(15) DEFAULT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `tempat_lahir` varchar(60) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-Laki','Perempuan') DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `agama` varchar(25) DEFAULT NULL,
  `id_prodi1` int(11) NOT NULL,
  `id_prodi2` int(11) DEFAULT NULL,
  `nominal_bayar` decimal(12,2) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `is_bayar` enum('1','0') NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendaftar`
--

INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 2, 'P202221', 'AprilYandi Dwi W 1', '564199741', '32760100231', 'Jakarta', '2001-12-22', 'Laki-Laki', '08517202311', 'Kp,Babakan No. 1', 'Islam', 1, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:28', NULL, NULL, NULL),
(2, 3, 'P202232', 'AprilYandi Dwi W 2', '564199742', '32760100232', 'Jakarta', '2001-12-15', 'Laki-Laki', '08517202312', 'Kp,Babakan No. 2', 'Islam', 3, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:28', NULL, NULL, NULL),
(3, 3, 'P202233', 'AprilYandi Dwi W 3', '564199743', '32760100233', 'Jakarta', '2001-12-06', 'Laki-Laki', '08517202313', 'Kp,Babakan No. 3', 'Islam', 12, 7, '1500000.00', NULL, '', '2022-12-07 13:58:28', NULL, NULL, NULL),
(4, 2, 'P202224', 'AprilYandi Dwi W 4', '564199744', '32760100234', 'Jakarta', '2001-12-21', 'Laki-Laki', '08517202314', 'Kp,Babakan No. 4', 'Islam', 11, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:28', NULL, NULL, NULL),
(5, 2, 'P202225', 'AprilYandi Dwi W 5', '564199745', '32760100235', 'Depok', '2001-12-19', 'Perempuan', '08517202315', 'Kp,Babakan No. 5', 'Islam', 9, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:28', NULL, NULL, NULL),
(6, 3, 'P202236', 'AprilYandi Dwi W 6', '564199746', '32760100236', 'Jakarta', '2001-12-14', 'Laki-Laki', '08517202316', 'Kp,Babakan No. 6', 'Islam', 4, 10, '1500000.00', NULL, '', '2022-12-07 13:58:28', NULL, NULL, NULL),
(7, 1, 'P202217', 'AprilYandi Dwi W 7', '564199747', '32760100237', 'Jakarta', '2001-12-18', 'Laki-Laki', '08517202317', 'Kp,Babakan No. 7', 'Islam', 11, 2, NULL, NULL, '1', '2022-12-07 13:58:28', NULL, NULL, NULL),
(8, 3, 'P202238', 'AprilYandi Dwi W 8', '564199748', '32760100238', 'Jakarta', '2001-12-17', 'Laki-Laki', '08517202318', 'Kp,Babakan No. 8', 'Islam', 5, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:28', NULL, NULL, NULL),
(9, 1, 'P202219', 'AprilYandi Dwi W 9', '564199749', '32760100239', 'Jakarta', '2001-12-27', 'Laki-Laki', '08517202319', 'Kp,Babakan No. 9', 'Islam', 1, 3, NULL, NULL, '', '2022-12-07 13:58:29', NULL, NULL, NULL),
(10, 2, 'P2022210', 'AprilYandi Dwi W 10', '5641997410', '327601002310', 'Depok', '2001-12-05', 'Perempuan', '085172023110', 'Kp,Babakan No. 10', 'Islam', 12, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(11, 1, 'P2022111', 'AprilYandi Dwi W 11', '5641997411', '327601002311', 'Jakarta', '2001-12-11', 'Laki-Laki', '085172023111', 'Kp,Babakan No. 11', 'Islam', 5, 9, NULL, NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(12, 2, 'P2022212', 'AprilYandi Dwi W 12', '5641997412', '327601002312', 'Jakarta', '2001-12-27', 'Laki-Laki', '085172023112', 'Kp,Babakan No. 12', 'Islam', 2, 1, '1500000.00', NULL, '', '2022-12-07 13:58:29', NULL, NULL, NULL),
(13, 3, 'P2022313', 'AprilYandi Dwi W 13', '5641997413', '327601002313', 'Jakarta', '2001-12-31', 'Laki-Laki', '085172023113', 'Kp,Babakan No. 13', 'Islam', 7, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(14, 1, 'P2022114', 'AprilYandi Dwi W 14', '5641997414', '327601002314', 'Jakarta', '2001-12-24', 'Laki-Laki', '085172023114', 'Kp,Babakan No. 14', 'Islam', 10, 6, NULL, NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(15, 3, 'P2022315', 'AprilYandi Dwi W 15', '5641997415', '327601002315', 'Depok', '2001-12-12', 'Perempuan', '085172023115', 'Kp,Babakan No. 15', 'Islam', 9, 4, '1500000.00', NULL, '', '2022-12-07 13:58:29', NULL, NULL, NULL),
(16, 1, 'P2022116', 'AprilYandi Dwi W 16', '5641997416', '327601002316', 'Jakarta', '2001-12-03', 'Laki-Laki', '085172023116', 'Kp,Babakan No. 16', 'Islam', 1, 13, NULL, NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(17, 2, 'P2022217', 'AprilYandi Dwi W 17', '5641997417', '327601002317', 'Jakarta', '2001-12-03', 'Laki-Laki', '085172023117', 'Kp,Babakan No. 17', 'Islam', 3, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(18, 3, 'P2022318', 'AprilYandi Dwi W 18', '5641997418', '327601002318', 'Jakarta', '2001-12-24', 'Laki-Laki', '085172023118', 'Kp,Babakan No. 18', 'Islam', 3, 1, '1500000.00', NULL, '', '2022-12-07 13:58:29', NULL, NULL, NULL),
(19, 2, 'P2022219', 'AprilYandi Dwi W 19', '5641997419', '327601002319', 'Jakarta', '2001-12-23', 'Laki-Laki', '085172023119', 'Kp,Babakan No. 19', 'Islam', 2, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(20, 2, 'P2022220', 'AprilYandi Dwi W 20', '5641997420', '327601002320', 'Depok', '2001-12-10', 'Perempuan', '085172023120', 'Kp,Babakan No. 20', 'Islam', 10, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(21, 2, 'P2022221', 'AprilYandi Dwi W 21', '5641997421', '327601002321', 'Jakarta', '2001-12-26', 'Laki-Laki', '085172023121', 'Kp,Babakan No. 21', 'Islam', 8, 8, '1500000.00', NULL, '', '2022-12-07 13:58:29', NULL, NULL, NULL),
(22, 1, 'P2022122', 'AprilYandi Dwi W 22', '5641997422', '327601002322', 'Jakarta', '2001-12-04', 'Laki-Laki', '085172023122', 'Kp,Babakan No. 22', 'Islam', 11, 8, NULL, NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(23, 3, 'P2022323', 'AprilYandi Dwi W 23', '5641997423', '327601002323', 'Jakarta', '2001-12-04', 'Laki-Laki', '085172023123', 'Kp,Babakan No. 23', 'Islam', 1, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(24, 1, 'P2022124', 'AprilYandi Dwi W 24', '5641997424', '327601002324', 'Jakarta', '2001-12-02', 'Laki-Laki', '085172023124', 'Kp,Babakan No. 24', 'Islam', 5, 10, NULL, NULL, '', '2022-12-07 13:58:29', NULL, NULL, NULL),
(25, 3, 'P2022325', 'AprilYandi Dwi W 25', '5641997425', '327601002325', 'Depok', '2001-12-12', 'Perempuan', '085172023125', 'Kp,Babakan No. 25', 'Islam', 9, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(26, 1, 'P2022126', 'AprilYandi Dwi W 26', '5641997426', '327601002326', 'Jakarta', '2001-12-15', 'Laki-Laki', '085172023126', 'Kp,Babakan No. 26', 'Islam', 2, 13, NULL, NULL, '1', '2022-12-07 13:58:29', NULL, NULL, NULL),
(27, 2, 'P2022227', 'AprilYandi Dwi W 27', '5641997427', '327601002327', 'Jakarta', '2001-12-16', 'Laki-Laki', '085172023127', 'Kp,Babakan No. 27', 'Islam', 11, 10, '1500000.00', NULL, '', '2022-12-07 13:58:30', NULL, NULL, NULL),
(28, 3, 'P2022328', 'AprilYandi Dwi W 28', '5641997428', '327601002328', 'Jakarta', '2001-12-11', 'Laki-Laki', '085172023128', 'Kp,Babakan No. 28', 'Islam', 3, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(29, 3, 'P2022329', 'AprilYandi Dwi W 29', '5641997429', '327601002329', 'Jakarta', '2001-12-17', 'Laki-Laki', '085172023129', 'Kp,Babakan No. 29', 'Islam', 10, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(30, 3, 'P2022330', 'AprilYandi Dwi W 30', '5641997430', '327601002330', 'Depok', '2001-12-24', 'Perempuan', '085172023130', 'Kp,Babakan No. 30', 'Islam', 4, 4, '1500000.00', NULL, '', '2022-12-07 13:58:30', NULL, NULL, NULL),
(31, 3, 'P2022331', 'AprilYandi Dwi W 31', '5641997431', '327601002331', 'Jakarta', '2001-12-11', 'Laki-Laki', '085172023131', 'Kp,Babakan No. 31', 'Islam', 11, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(32, 3, 'P2022332', 'AprilYandi Dwi W 32', '5641997432', '327601002332', 'Jakarta', '2001-12-02', 'Laki-Laki', '085172023132', 'Kp,Babakan No. 32', 'Islam', 3, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(33, 1, 'P2022133', 'AprilYandi Dwi W 33', '5641997433', '327601002333', 'Jakarta', '2001-12-09', 'Laki-Laki', '085172023133', 'Kp,Babakan No. 33', 'Islam', 11, 8, NULL, NULL, '', '2022-12-07 13:58:30', NULL, NULL, NULL),
(34, 2, 'P2022234', 'AprilYandi Dwi W 34', '5641997434', '327601002334', 'Jakarta', '2001-12-30', 'Laki-Laki', '085172023134', 'Kp,Babakan No. 34', 'Islam', 6, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(35, 2, 'P2022235', 'AprilYandi Dwi W 35', '5641997435', '327601002335', 'Depok', '2001-12-17', 'Perempuan', '085172023135', 'Kp,Babakan No. 35', 'Islam', 2, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(36, 2, 'P2022236', 'AprilYandi Dwi W 36', '5641997436', '327601002336', 'Jakarta', '2001-12-23', 'Laki-Laki', '085172023136', 'Kp,Babakan No. 36', 'Islam', 9, 12, '1500000.00', NULL, '', '2022-12-07 13:58:30', NULL, NULL, NULL),
(37, 1, 'P2022137', 'AprilYandi Dwi W 37', '5641997437', '327601002337', 'Jakarta', '2001-12-25', 'Laki-Laki', '085172023137', 'Kp,Babakan No. 37', 'Islam', 2, 4, NULL, NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(38, 3, 'P2022338', 'AprilYandi Dwi W 38', '5641997438', '327601002338', 'Jakarta', '2001-12-16', 'Laki-Laki', '085172023138', 'Kp,Babakan No. 38', 'Islam', 13, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(39, 2, 'P2022239', 'AprilYandi Dwi W 39', '5641997439', '327601002339', 'Jakarta', '2001-12-18', 'Laki-Laki', '085172023139', 'Kp,Babakan No. 39', 'Islam', 6, 4, '1500000.00', NULL, '', '2022-12-07 13:58:30', NULL, NULL, NULL),
(40, 2, 'P2022240', 'AprilYandi Dwi W 40', '5641997440', '327601002340', 'Depok', '2001-12-04', 'Perempuan', '085172023140', 'Kp,Babakan No. 40', 'Islam', 3, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(41, 1, 'P2022141', 'AprilYandi Dwi W 41', '5641997441', '327601002341', 'Jakarta', '2001-12-27', 'Laki-Laki', '085172023141', 'Kp,Babakan No. 41', 'Islam', 4, 11, NULL, NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(42, 1, 'P2022142', 'AprilYandi Dwi W 42', '5641997442', '327601002342', 'Jakarta', '2001-12-31', 'Laki-Laki', '085172023142', 'Kp,Babakan No. 42', 'Islam', 11, 11, NULL, NULL, '', '2022-12-07 13:58:30', NULL, NULL, NULL),
(43, 1, 'P2022143', 'AprilYandi Dwi W 43', '5641997443', '327601002343', 'Jakarta', '2001-12-09', 'Laki-Laki', '085172023143', 'Kp,Babakan No. 43', 'Islam', 11, 13, NULL, NULL, '1', '2022-12-07 13:58:30', NULL, NULL, NULL),
(44, 1, 'P2022144', 'AprilYandi Dwi W 44', '5641997444', '327601002344', 'Jakarta', '2001-12-04', 'Laki-Laki', '085172023144', 'Kp,Babakan No. 44', 'Islam', 11, 10, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(45, 1, 'P2022145', 'AprilYandi Dwi W 45', '5641997445', '327601002345', 'Depok', '2001-12-05', 'Perempuan', '085172023145', 'Kp,Babakan No. 45', 'Islam', 1, 11, NULL, NULL, '', '2022-12-07 13:58:31', NULL, NULL, NULL),
(46, 3, 'P2022346', 'AprilYandi Dwi W 46', '5641997446', '327601002346', 'Jakarta', '2001-12-25', 'Laki-Laki', '085172023146', 'Kp,Babakan No. 46', 'Islam', 10, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(47, 1, 'P2022147', 'AprilYandi Dwi W 47', '5641997447', '327601002347', 'Jakarta', '2001-12-22', 'Laki-Laki', '085172023147', 'Kp,Babakan No. 47', 'Islam', 8, 8, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(48, 1, 'P2022148', 'AprilYandi Dwi W 48', '5641997448', '327601002348', 'Jakarta', '2001-12-13', 'Laki-Laki', '085172023148', 'Kp,Babakan No. 48', 'Islam', 9, 13, NULL, NULL, '', '2022-12-07 13:58:31', NULL, NULL, NULL),
(49, 3, 'P2022349', 'AprilYandi Dwi W 49', '5641997449', '327601002349', 'Jakarta', '2001-12-02', 'Laki-Laki', '085172023149', 'Kp,Babakan No. 49', 'Islam', 5, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(50, 1, 'P2022150', 'AprilYandi Dwi W 50', '5641997450', '327601002350', 'Depok', '2001-12-09', 'Perempuan', '085172023150', 'Kp,Babakan No. 50', 'Islam', 11, 5, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(51, 1, 'P2022151', 'AprilYandi Dwi W 51', '5641997451', '327601002351', 'Jakarta', '2001-12-29', 'Laki-Laki', '085172023151', 'Kp,Babakan No. 51', 'Islam', 5, 7, NULL, NULL, '', '2022-12-07 13:58:31', NULL, NULL, NULL),
(52, 1, 'P2022152', 'AprilYandi Dwi W 52', '5641997452', '327601002352', 'Jakarta', '2001-12-02', 'Laki-Laki', '085172023152', 'Kp,Babakan No. 52', 'Islam', 5, 10, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(53, 1, 'P2022153', 'AprilYandi Dwi W 53', '5641997453', '327601002353', 'Jakarta', '2001-12-05', 'Laki-Laki', '085172023153', 'Kp,Babakan No. 53', 'Islam', 1, 9, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(54, 1, 'P2022154', 'AprilYandi Dwi W 54', '5641997454', '327601002354', 'Jakarta', '2001-12-24', 'Laki-Laki', '085172023154', 'Kp,Babakan No. 54', 'Islam', 3, 2, NULL, NULL, '', '2022-12-07 13:58:31', NULL, NULL, NULL),
(55, 3, 'P2022355', 'AprilYandi Dwi W 55', '5641997455', '327601002355', 'Depok', '2001-12-17', 'Perempuan', '085172023155', 'Kp,Babakan No. 55', 'Islam', 10, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(56, 1, 'P2022156', 'AprilYandi Dwi W 56', '5641997456', '327601002356', 'Jakarta', '2001-12-08', 'Laki-Laki', '085172023156', 'Kp,Babakan No. 56', 'Islam', 10, 1, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(57, 1, 'P2022157', 'AprilYandi Dwi W 57', '5641997457', '327601002357', 'Jakarta', '2001-12-13', 'Laki-Laki', '085172023157', 'Kp,Babakan No. 57', 'Islam', 1, 6, NULL, NULL, '', '2022-12-07 13:58:31', NULL, NULL, NULL),
(58, 1, 'P2022158', 'AprilYandi Dwi W 58', '5641997458', '327601002358', 'Jakarta', '2001-12-02', 'Laki-Laki', '085172023158', 'Kp,Babakan No. 58', 'Islam', 6, 3, NULL, NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(59, 2, 'P2022259', 'AprilYandi Dwi W 59', '5641997459', '327601002359', 'Jakarta', '2001-12-10', 'Laki-Laki', '085172023159', 'Kp,Babakan No. 59', 'Islam', 1, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:31', NULL, NULL, NULL),
(60, 3, 'P2022360', 'AprilYandi Dwi W 60', '5641997460', '327601002360', 'Depok', '2001-12-25', 'Perempuan', '085172023160', 'Kp,Babakan No. 60', 'Islam', 13, 6, '1500000.00', NULL, '', '2022-12-07 13:58:31', NULL, NULL, NULL),
(61, 3, 'P2022361', 'AprilYandi Dwi W 61', '5641997461', '327601002361', 'Jakarta', '2001-12-18', 'Laki-Laki', '085172023161', 'Kp,Babakan No. 61', 'Islam', 11, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(62, 3, 'P2022362', 'AprilYandi Dwi W 62', '5641997462', '327601002362', 'Jakarta', '2001-12-09', 'Laki-Laki', '085172023162', 'Kp,Babakan No. 62', 'Islam', 9, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(63, 1, 'P2022163', 'AprilYandi Dwi W 63', '5641997463', '327601002363', 'Jakarta', '2001-12-16', 'Laki-Laki', '085172023163', 'Kp,Babakan No. 63', 'Islam', 2, 9, NULL, NULL, '', '2022-12-07 13:58:32', NULL, NULL, NULL),
(64, 3, 'P2022364', 'AprilYandi Dwi W 64', '5641997464', '327601002364', 'Jakarta', '2001-12-18', 'Laki-Laki', '085172023164', 'Kp,Babakan No. 64', 'Islam', 10, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(65, 2, 'P2022265', 'AprilYandi Dwi W 65', '5641997465', '327601002365', 'Depok', '2001-12-02', 'Perempuan', '085172023165', 'Kp,Babakan No. 65', 'Islam', 1, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(66, 2, 'P2022266', 'AprilYandi Dwi W 66', '5641997466', '327601002366', 'Jakarta', '2001-12-15', 'Laki-Laki', '085172023166', 'Kp,Babakan No. 66', 'Islam', 13, 13, '1500000.00', NULL, '', '2022-12-07 13:58:32', NULL, NULL, NULL),
(67, 1, 'P2022167', 'AprilYandi Dwi W 67', '5641997467', '327601002367', 'Jakarta', '2001-12-29', 'Laki-Laki', '085172023167', 'Kp,Babakan No. 67', 'Islam', 4, 12, NULL, NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(68, 2, 'P2022268', 'AprilYandi Dwi W 68', '5641997468', '327601002368', 'Jakarta', '2001-12-07', 'Laki-Laki', '085172023168', 'Kp,Babakan No. 68', 'Islam', 10, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(69, 2, 'P2022269', 'AprilYandi Dwi W 69', '5641997469', '327601002369', 'Jakarta', '2001-12-03', 'Laki-Laki', '085172023169', 'Kp,Babakan No. 69', 'Islam', 8, 1, '1500000.00', NULL, '', '2022-12-07 13:58:32', NULL, NULL, NULL),
(70, 1, 'P2022170', 'AprilYandi Dwi W 70', '5641997470', '327601002370', 'Depok', '2001-12-17', 'Perempuan', '085172023170', 'Kp,Babakan No. 70', 'Islam', 2, 8, NULL, NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(71, 1, 'P2022171', 'AprilYandi Dwi W 71', '5641997471', '327601002371', 'Jakarta', '2001-12-29', 'Laki-Laki', '085172023171', 'Kp,Babakan No. 71', 'Islam', 6, 3, NULL, NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(72, 2, 'P2022272', 'AprilYandi Dwi W 72', '5641997472', '327601002372', 'Jakarta', '2001-12-16', 'Laki-Laki', '085172023172', 'Kp,Babakan No. 72', 'Islam', 5, 9, '1500000.00', NULL, '', '2022-12-07 13:58:32', NULL, NULL, NULL),
(73, 1, 'P2022173', 'AprilYandi Dwi W 73', '5641997473', '327601002373', 'Jakarta', '2001-12-21', 'Laki-Laki', '085172023173', 'Kp,Babakan No. 73', 'Islam', 7, 6, NULL, NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(74, 3, 'P2022374', 'AprilYandi Dwi W 74', '5641997474', '327601002374', 'Jakarta', '2001-12-28', 'Laki-Laki', '085172023174', 'Kp,Babakan No. 74', 'Islam', 8, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:32', NULL, NULL, NULL),
(75, 3, 'P2022375', 'AprilYandi Dwi W 75', '5641997475', '327601002375', 'Depok', '2001-12-11', 'Perempuan', '085172023175', 'Kp,Babakan No. 75', 'Islam', 10, 13, '1500000.00', NULL, '', '2022-12-07 13:58:33', NULL, NULL, NULL),
(76, 1, 'P2022176', 'AprilYandi Dwi W 76', '5641997476', '327601002376', 'Jakarta', '2001-12-22', 'Laki-Laki', '085172023176', 'Kp,Babakan No. 76', 'Islam', 6, 13, NULL, NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(77, 2, 'P2022277', 'AprilYandi Dwi W 77', '5641997477', '327601002377', 'Jakarta', '2001-12-27', 'Laki-Laki', '085172023177', 'Kp,Babakan No. 77', 'Islam', 10, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(78, 1, 'P2022178', 'AprilYandi Dwi W 78', '5641997478', '327601002378', 'Jakarta', '2001-12-29', 'Laki-Laki', '085172023178', 'Kp,Babakan No. 78', 'Islam', 7, 9, NULL, NULL, '', '2022-12-07 13:58:33', NULL, NULL, NULL),
(79, 3, 'P2022379', 'AprilYandi Dwi W 79', '5641997479', '327601002379', 'Jakarta', '2001-12-27', 'Laki-Laki', '085172023179', 'Kp,Babakan No. 79', 'Islam', 10, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(80, 3, 'P2022380', 'AprilYandi Dwi W 80', '5641997480', '327601002380', 'Depok', '2001-12-18', 'Perempuan', '085172023180', 'Kp,Babakan No. 80', 'Islam', 5, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(81, 2, 'P2022281', 'AprilYandi Dwi W 81', '5641997481', '327601002381', 'Jakarta', '2001-12-09', 'Laki-Laki', '085172023181', 'Kp,Babakan No. 81', 'Islam', 6, 12, '1500000.00', NULL, '', '2022-12-07 13:58:33', NULL, NULL, NULL),
(82, 2, 'P2022282', 'AprilYandi Dwi W 82', '5641997482', '327601002382', 'Jakarta', '2001-12-12', 'Laki-Laki', '085172023182', 'Kp,Babakan No. 82', 'Islam', 4, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(83, 2, 'P2022283', 'AprilYandi Dwi W 83', '5641997483', '327601002383', 'Jakarta', '2001-12-08', 'Laki-Laki', '085172023183', 'Kp,Babakan No. 83', 'Islam', 5, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(84, 3, 'P2022384', 'AprilYandi Dwi W 84', '5641997484', '327601002384', 'Jakarta', '2001-12-18', 'Laki-Laki', '085172023184', 'Kp,Babakan No. 84', 'Islam', 4, 5, '1500000.00', NULL, '', '2022-12-07 13:58:33', NULL, NULL, NULL),
(85, 1, 'P2022185', 'AprilYandi Dwi W 85', '5641997485', '327601002385', 'Depok', '2001-12-05', 'Perempuan', '085172023185', 'Kp,Babakan No. 85', 'Islam', 5, 3, NULL, NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(86, 3, 'P2022386', 'AprilYandi Dwi W 86', '5641997486', '327601002386', 'Jakarta', '2001-12-12', 'Laki-Laki', '085172023186', 'Kp,Babakan No. 86', 'Islam', 4, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:33', NULL, NULL, NULL),
(87, 2, 'P2022287', 'AprilYandi Dwi W 87', '5641997487', '327601002387', 'Jakarta', '2001-12-03', 'Laki-Laki', '085172023187', 'Kp,Babakan No. 87', 'Islam', 10, 5, '1500000.00', NULL, '', '2022-12-07 13:58:34', NULL, NULL, NULL),
(88, 3, 'P2022388', 'AprilYandi Dwi W 88', '5641997488', '327601002388', 'Jakarta', '2001-12-12', 'Laki-Laki', '085172023188', 'Kp,Babakan No. 88', 'Islam', 3, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:34', NULL, NULL, NULL),
(89, 2, 'P2022289', 'AprilYandi Dwi W 89', '5641997489', '327601002389', 'Jakarta', '2001-12-07', 'Laki-Laki', '085172023189', 'Kp,Babakan No. 89', 'Islam', 2, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:34', NULL, NULL, NULL),
(90, 2, 'P2022290', 'AprilYandi Dwi W 90', '5641997490', '327601002390', 'Depok', '2001-12-09', 'Perempuan', '085172023190', 'Kp,Babakan No. 90', 'Islam', 5, 10, '1500000.00', NULL, '', '2022-12-07 13:58:34', NULL, NULL, NULL),
(91, 1, 'P2022191', 'AprilYandi Dwi W 91', '5641997491', '327601002391', 'Jakarta', '2001-12-24', 'Laki-Laki', '085172023191', 'Kp,Babakan No. 91', 'Islam', 8, 2, NULL, NULL, '1', '2022-12-07 13:58:34', NULL, NULL, NULL),
(92, 3, 'P2022392', 'AprilYandi Dwi W 92', '5641997492', '327601002392', 'Jakarta', '2001-12-25', 'Laki-Laki', '085172023192', 'Kp,Babakan No. 92', 'Islam', 2, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:34', NULL, NULL, NULL),
(93, 2, 'P2022293', 'AprilYandi Dwi W 93', '5641997493', '327601002393', 'Jakarta', '2001-12-16', 'Laki-Laki', '085172023193', 'Kp,Babakan No. 93', 'Islam', 12, 7, '1500000.00', NULL, '', '2022-12-07 13:58:34', NULL, NULL, NULL),
(94, 3, 'P2022394', 'AprilYandi Dwi W 94', '5641997494', '327601002394', 'Jakarta', '2001-12-23', 'Laki-Laki', '085172023194', 'Kp,Babakan No. 94', 'Islam', 8, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(95, 2, 'P2022295', 'AprilYandi Dwi W 95', '5641997495', '327601002395', 'Depok', '2001-12-08', 'Perempuan', '085172023195', 'Kp,Babakan No. 95', 'Islam', 12, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(96, 3, 'P2022396', 'AprilYandi Dwi W 96', '5641997496', '327601002396', 'Jakarta', '2001-12-15', 'Laki-Laki', '085172023196', 'Kp,Babakan No. 96', 'Islam', 5, 13, '1500000.00', NULL, '', '2022-12-07 13:58:35', NULL, NULL, NULL),
(97, 3, 'P2022397', 'AprilYandi Dwi W 97', '5641997497', '327601002397', 'Jakarta', '2001-12-05', 'Laki-Laki', '085172023197', 'Kp,Babakan No. 97', 'Islam', 8, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(98, 1, 'P2022198', 'AprilYandi Dwi W 98', '5641997498', '327601002398', 'Jakarta', '2001-12-25', 'Laki-Laki', '085172023198', 'Kp,Babakan No. 98', 'Islam', 10, 1, NULL, NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(99, 1, 'P2022199', 'AprilYandi Dwi W 99', '5641997499', '327601002399', 'Jakarta', '2001-12-17', 'Laki-Laki', '085172023199', 'Kp,Babakan No. 99', 'Islam', 10, 11, NULL, NULL, '', '2022-12-07 13:58:35', NULL, NULL, NULL),
(100, 3, 'P20223100', 'AprilYandi Dwi W 100', '56419974100', '3276010023100', 'Depok', '2001-12-09', 'Perempuan', '0851720231100', 'Kp,Babakan No. 100', 'Islam', 12, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(101, 2, 'P20222101', 'AprilYandi Dwi W 101', '56419974101', '3276010023101', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231101', 'Kp,Babakan No. 101', 'Islam', 12, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(102, 3, 'P20223102', 'AprilYandi Dwi W 102', '56419974102', '3276010023102', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231102', 'Kp,Babakan No. 102', 'Islam', 12, 12, '1500000.00', NULL, '', '2022-12-07 13:58:35', NULL, NULL, NULL),
(103, 1, 'P20221103', 'AprilYandi Dwi W 103', '56419974103', '3276010023103', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231103', 'Kp,Babakan No. 103', 'Islam', 10, 1, NULL, NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(104, 2, 'P20222104', 'AprilYandi Dwi W 104', '56419974104', '3276010023104', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231104', 'Kp,Babakan No. 104', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:35', NULL, NULL, NULL),
(105, 1, 'P20221105', 'AprilYandi Dwi W 105', '56419974105', '3276010023105', 'Depok', '2001-12-08', 'Perempuan', '0851720231105', 'Kp,Babakan No. 105', 'Islam', 11, 13, NULL, NULL, '', '2022-12-07 13:58:35', NULL, NULL, NULL),
(106, 3, 'P20223106', 'AprilYandi Dwi W 106', '56419974106', '3276010023106', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231106', 'Kp,Babakan No. 106', 'Islam', 2, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(107, 2, 'P20222107', 'AprilYandi Dwi W 107', '56419974107', '3276010023107', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231107', 'Kp,Babakan No. 107', 'Islam', 10, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(108, 2, 'P20222108', 'AprilYandi Dwi W 108', '56419974108', '3276010023108', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231108', 'Kp,Babakan No. 108', 'Islam', 12, 9, '1500000.00', NULL, '', '2022-12-07 13:58:36', NULL, NULL, NULL),
(109, 2, 'P20222109', 'AprilYandi Dwi W 109', '56419974109', '3276010023109', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231109', 'Kp,Babakan No. 109', 'Islam', 8, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(110, 1, 'P20221110', 'AprilYandi Dwi W 110', '56419974110', '3276010023110', 'Depok', '2001-12-07', 'Perempuan', '0851720231110', 'Kp,Babakan No. 110', 'Islam', 11, 6, NULL, NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(111, 1, 'P20221111', 'AprilYandi Dwi W 111', '56419974111', '3276010023111', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231111', 'Kp,Babakan No. 111', 'Islam', 11, 10, NULL, NULL, '', '2022-12-07 13:58:36', NULL, NULL, NULL),
(112, 3, 'P20223112', 'AprilYandi Dwi W 112', '56419974112', '3276010023112', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231112', 'Kp,Babakan No. 112', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(113, 2, 'P20222113', 'AprilYandi Dwi W 113', '56419974113', '3276010023113', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231113', 'Kp,Babakan No. 113', 'Islam', 5, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(114, 3, 'P20223114', 'AprilYandi Dwi W 114', '56419974114', '3276010023114', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231114', 'Kp,Babakan No. 114', 'Islam', 8, 10, '1500000.00', NULL, '', '2022-12-07 13:58:36', NULL, NULL, NULL),
(115, 3, 'P20223115', 'AprilYandi Dwi W 115', '56419974115', '3276010023115', 'Depok', '2001-12-22', 'Perempuan', '0851720231115', 'Kp,Babakan No. 115', 'Islam', 13, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(116, 3, 'P20223116', 'AprilYandi Dwi W 116', '56419974116', '3276010023116', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231116', 'Kp,Babakan No. 116', 'Islam', 12, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(117, 2, 'P20222117', 'AprilYandi Dwi W 117', '56419974117', '3276010023117', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231117', 'Kp,Babakan No. 117', 'Islam', 11, 7, '1500000.00', NULL, '', '2022-12-07 13:58:36', NULL, NULL, NULL),
(118, 3, 'P20223118', 'AprilYandi Dwi W 118', '56419974118', '3276010023118', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231118', 'Kp,Babakan No. 118', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(119, 1, 'P20221119', 'AprilYandi Dwi W 119', '56419974119', '3276010023119', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231119', 'Kp,Babakan No. 119', 'Islam', 1, 10, NULL, NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(120, 1, 'P20221120', 'AprilYandi Dwi W 120', '56419974120', '3276010023120', 'Depok', '2001-12-19', 'Perempuan', '0851720231120', 'Kp,Babakan No. 120', 'Islam', 3, 12, NULL, NULL, '', '2022-12-07 13:58:36', NULL, NULL, NULL),
(121, 2, 'P20222121', 'AprilYandi Dwi W 121', '56419974121', '3276010023121', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231121', 'Kp,Babakan No. 121', 'Islam', 2, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(122, 2, 'P20222122', 'AprilYandi Dwi W 122', '56419974122', '3276010023122', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231122', 'Kp,Babakan No. 122', 'Islam', 1, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:36', NULL, NULL, NULL),
(123, 1, 'P20221123', 'AprilYandi Dwi W 123', '56419974123', '3276010023123', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231123', 'Kp,Babakan No. 123', 'Islam', 2, 3, NULL, NULL, '', '2022-12-07 13:58:37', NULL, NULL, NULL),
(124, 1, 'P20221124', 'AprilYandi Dwi W 124', '56419974124', '3276010023124', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231124', 'Kp,Babakan No. 124', 'Islam', 11, 8, NULL, NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(125, 2, 'P20222125', 'AprilYandi Dwi W 125', '56419974125', '3276010023125', 'Depok', '2001-12-20', 'Perempuan', '0851720231125', 'Kp,Babakan No. 125', 'Islam', 1, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(126, 1, 'P20221126', 'AprilYandi Dwi W 126', '56419974126', '3276010023126', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231126', 'Kp,Babakan No. 126', 'Islam', 3, 10, NULL, NULL, '', '2022-12-07 13:58:37', NULL, NULL, NULL),
(127, 1, 'P20221127', 'AprilYandi Dwi W 127', '56419974127', '3276010023127', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231127', 'Kp,Babakan No. 127', 'Islam', 4, 6, NULL, NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(128, 1, 'P20221128', 'AprilYandi Dwi W 128', '56419974128', '3276010023128', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231128', 'Kp,Babakan No. 128', 'Islam', 6, 4, NULL, NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(129, 1, 'P20221129', 'AprilYandi Dwi W 129', '56419974129', '3276010023129', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231129', 'Kp,Babakan No. 129', 'Islam', 2, 2, NULL, NULL, '', '2022-12-07 13:58:37', NULL, NULL, NULL),
(130, 1, 'P20221130', 'AprilYandi Dwi W 130', '56419974130', '3276010023130', 'Depok', '2001-12-29', 'Perempuan', '0851720231130', 'Kp,Babakan No. 130', 'Islam', 6, 6, NULL, NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(131, 3, 'P20223131', 'AprilYandi Dwi W 131', '56419974131', '3276010023131', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231131', 'Kp,Babakan No. 131', 'Islam', 3, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(132, 2, 'P20222132', 'AprilYandi Dwi W 132', '56419974132', '3276010023132', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231132', 'Kp,Babakan No. 132', 'Islam', 13, 13, '1500000.00', NULL, '', '2022-12-07 13:58:37', NULL, NULL, NULL),
(133, 1, 'P20221133', 'AprilYandi Dwi W 133', '56419974133', '3276010023133', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231133', 'Kp,Babakan No. 133', 'Islam', 7, 11, NULL, NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(134, 3, 'P20223134', 'AprilYandi Dwi W 134', '56419974134', '3276010023134', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231134', 'Kp,Babakan No. 134', 'Islam', 11, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(135, 1, 'P20221135', 'AprilYandi Dwi W 135', '56419974135', '3276010023135', 'Depok', '2001-12-18', 'Perempuan', '0851720231135', 'Kp,Babakan No. 135', 'Islam', 1, 12, NULL, NULL, '', '2022-12-07 13:58:37', NULL, NULL, NULL),
(136, 1, 'P20221136', 'AprilYandi Dwi W 136', '56419974136', '3276010023136', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231136', 'Kp,Babakan No. 136', 'Islam', 12, 8, NULL, NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(137, 3, 'P20223137', 'AprilYandi Dwi W 137', '56419974137', '3276010023137', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231137', 'Kp,Babakan No. 137', 'Islam', 7, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:37', NULL, NULL, NULL),
(138, 3, 'P20223138', 'AprilYandi Dwi W 138', '56419974138', '3276010023138', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231138', 'Kp,Babakan No. 138', 'Islam', 9, 9, '1500000.00', NULL, '', '2022-12-07 13:58:37', NULL, NULL, NULL),
(139, 2, 'P20222139', 'AprilYandi Dwi W 139', '56419974139', '3276010023139', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231139', 'Kp,Babakan No. 139', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(140, 1, 'P20221140', 'AprilYandi Dwi W 140', '56419974140', '3276010023140', 'Depok', '2001-12-30', 'Perempuan', '0851720231140', 'Kp,Babakan No. 140', 'Islam', 2, 12, NULL, NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(141, 1, 'P20221141', 'AprilYandi Dwi W 141', '56419974141', '3276010023141', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231141', 'Kp,Babakan No. 141', 'Islam', 12, 8, NULL, NULL, '', '2022-12-07 13:58:38', NULL, NULL, NULL),
(142, 2, 'P20222142', 'AprilYandi Dwi W 142', '56419974142', '3276010023142', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231142', 'Kp,Babakan No. 142', 'Islam', 9, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(143, 1, 'P20221143', 'AprilYandi Dwi W 143', '56419974143', '3276010023143', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231143', 'Kp,Babakan No. 143', 'Islam', 11, 3, NULL, NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(144, 2, 'P20222144', 'AprilYandi Dwi W 144', '56419974144', '3276010023144', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231144', 'Kp,Babakan No. 144', 'Islam', 12, 4, '1500000.00', NULL, '', '2022-12-07 13:58:38', NULL, NULL, NULL),
(145, 1, 'P20221145', 'AprilYandi Dwi W 145', '56419974145', '3276010023145', 'Depok', '2001-12-18', 'Perempuan', '0851720231145', 'Kp,Babakan No. 145', 'Islam', 3, 5, NULL, NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(146, 2, 'P20222146', 'AprilYandi Dwi W 146', '56419974146', '3276010023146', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231146', 'Kp,Babakan No. 146', 'Islam', 3, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(147, 3, 'P20223147', 'AprilYandi Dwi W 147', '56419974147', '3276010023147', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231147', 'Kp,Babakan No. 147', 'Islam', 5, 9, '1500000.00', NULL, '', '2022-12-07 13:58:38', NULL, NULL, NULL),
(148, 2, 'P20222148', 'AprilYandi Dwi W 148', '56419974148', '3276010023148', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231148', 'Kp,Babakan No. 148', 'Islam', 9, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(149, 1, 'P20221149', 'AprilYandi Dwi W 149', '56419974149', '3276010023149', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231149', 'Kp,Babakan No. 149', 'Islam', 8, 1, NULL, NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(150, 2, 'P20222150', 'AprilYandi Dwi W 150', '56419974150', '3276010023150', 'Depok', '2001-12-26', 'Perempuan', '0851720231150', 'Kp,Babakan No. 150', 'Islam', 6, 6, '1500000.00', NULL, '', '2022-12-07 13:58:38', NULL, NULL, NULL),
(151, 2, 'P20222151', 'AprilYandi Dwi W 151', '56419974151', '3276010023151', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231151', 'Kp,Babakan No. 151', 'Islam', 13, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(152, 2, 'P20222152', 'AprilYandi Dwi W 152', '56419974152', '3276010023152', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231152', 'Kp,Babakan No. 152', 'Islam', 5, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(153, 3, 'P20223153', 'AprilYandi Dwi W 153', '56419974153', '3276010023153', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231153', 'Kp,Babakan No. 153', 'Islam', 12, 12, '1500000.00', NULL, '', '2022-12-07 13:58:38', NULL, NULL, NULL),
(154, 3, 'P20223154', 'AprilYandi Dwi W 154', '56419974154', '3276010023154', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231154', 'Kp,Babakan No. 154', 'Islam', 13, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(155, 1, 'P20221155', 'AprilYandi Dwi W 155', '56419974155', '3276010023155', 'Depok', '2001-12-26', 'Perempuan', '0851720231155', 'Kp,Babakan No. 155', 'Islam', 7, 1, NULL, NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(156, 3, 'P20223156', 'AprilYandi Dwi W 156', '56419974156', '3276010023156', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231156', 'Kp,Babakan No. 156', 'Islam', 1, 8, '1500000.00', NULL, '', '2022-12-07 13:58:38', NULL, NULL, NULL),
(157, 2, 'P20222157', 'AprilYandi Dwi W 157', '56419974157', '3276010023157', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231157', 'Kp,Babakan No. 157', 'Islam', 4, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(158, 1, 'P20221158', 'AprilYandi Dwi W 158', '56419974158', '3276010023158', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231158', 'Kp,Babakan No. 158', 'Islam', 1, 1, NULL, NULL, '1', '2022-12-07 13:58:38', NULL, NULL, NULL),
(159, 1, 'P20221159', 'AprilYandi Dwi W 159', '56419974159', '3276010023159', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231159', 'Kp,Babakan No. 159', 'Islam', 12, 9, NULL, NULL, '', '2022-12-07 13:58:39', NULL, NULL, NULL),
(160, 1, 'P20221160', 'AprilYandi Dwi W 160', '56419974160', '3276010023160', 'Depok', '2001-12-31', 'Perempuan', '0851720231160', 'Kp,Babakan No. 160', 'Islam', 9, 9, NULL, NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(161, 3, 'P20223161', 'AprilYandi Dwi W 161', '56419974161', '3276010023161', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231161', 'Kp,Babakan No. 161', 'Islam', 3, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(162, 1, 'P20221162', 'AprilYandi Dwi W 162', '56419974162', '3276010023162', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231162', 'Kp,Babakan No. 162', 'Islam', 8, 9, NULL, NULL, '', '2022-12-07 13:58:39', NULL, NULL, NULL),
(163, 3, 'P20223163', 'AprilYandi Dwi W 163', '56419974163', '3276010023163', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231163', 'Kp,Babakan No. 163', 'Islam', 11, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(164, 2, 'P20222164', 'AprilYandi Dwi W 164', '56419974164', '3276010023164', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231164', 'Kp,Babakan No. 164', 'Islam', 4, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(165, 3, 'P20223165', 'AprilYandi Dwi W 165', '56419974165', '3276010023165', 'Depok', '2001-12-14', 'Perempuan', '0851720231165', 'Kp,Babakan No. 165', 'Islam', 11, 7, '1500000.00', NULL, '', '2022-12-07 13:58:39', NULL, NULL, NULL),
(166, 2, 'P20222166', 'AprilYandi Dwi W 166', '56419974166', '3276010023166', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231166', 'Kp,Babakan No. 166', 'Islam', 2, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(167, 1, 'P20221167', 'AprilYandi Dwi W 167', '56419974167', '3276010023167', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231167', 'Kp,Babakan No. 167', 'Islam', 1, 11, NULL, NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(168, 1, 'P20221168', 'AprilYandi Dwi W 168', '56419974168', '3276010023168', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231168', 'Kp,Babakan No. 168', 'Islam', 3, 2, NULL, NULL, '', '2022-12-07 13:58:39', NULL, NULL, NULL),
(169, 2, 'P20222169', 'AprilYandi Dwi W 169', '56419974169', '3276010023169', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231169', 'Kp,Babakan No. 169', 'Islam', 5, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(170, 1, 'P20221170', 'AprilYandi Dwi W 170', '56419974170', '3276010023170', 'Depok', '2001-12-19', 'Perempuan', '0851720231170', 'Kp,Babakan No. 170', 'Islam', 11, 3, NULL, NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(171, 3, 'P20223171', 'AprilYandi Dwi W 171', '56419974171', '3276010023171', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231171', 'Kp,Babakan No. 171', 'Islam', 2, 5, '1500000.00', NULL, '', '2022-12-07 13:58:39', NULL, NULL, NULL),
(172, 3, 'P20223172', 'AprilYandi Dwi W 172', '56419974172', '3276010023172', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231172', 'Kp,Babakan No. 172', 'Islam', 10, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:39', NULL, NULL, NULL),
(173, 3, 'P20223173', 'AprilYandi Dwi W 173', '56419974173', '3276010023173', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231173', 'Kp,Babakan No. 173', 'Islam', 11, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:40', NULL, NULL, NULL),
(174, 1, 'P20221174', 'AprilYandi Dwi W 174', '56419974174', '3276010023174', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231174', 'Kp,Babakan No. 174', 'Islam', 3, 10, NULL, NULL, '', '2022-12-07 13:58:40', NULL, NULL, NULL),
(175, 3, 'P20223175', 'AprilYandi Dwi W 175', '56419974175', '3276010023175', 'Depok', '2001-12-20', 'Perempuan', '0851720231175', 'Kp,Babakan No. 175', 'Islam', 9, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:40', NULL, NULL, NULL),
(176, 3, 'P20223176', 'AprilYandi Dwi W 176', '56419974176', '3276010023176', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231176', 'Kp,Babakan No. 176', 'Islam', 6, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:40', NULL, NULL, NULL),
(177, 1, 'P20221177', 'AprilYandi Dwi W 177', '56419974177', '3276010023177', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231177', 'Kp,Babakan No. 177', 'Islam', 12, 10, NULL, NULL, '', '2022-12-07 13:58:40', NULL, NULL, NULL),
(178, 1, 'P20221178', 'AprilYandi Dwi W 178', '56419974178', '3276010023178', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231178', 'Kp,Babakan No. 178', 'Islam', 4, 8, NULL, NULL, '1', '2022-12-07 13:58:40', NULL, NULL, NULL),
(179, 1, 'P20221179', 'AprilYandi Dwi W 179', '56419974179', '3276010023179', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231179', 'Kp,Babakan No. 179', 'Islam', 2, 2, NULL, NULL, '1', '2022-12-07 13:58:40', NULL, NULL, NULL),
(180, 3, 'P20223180', 'AprilYandi Dwi W 180', '56419974180', '3276010023180', 'Depok', '2001-12-25', 'Perempuan', '0851720231180', 'Kp,Babakan No. 180', 'Islam', 9, 7, '1500000.00', NULL, '', '2022-12-07 13:58:40', NULL, NULL, NULL),
(181, 3, 'P20223181', 'AprilYandi Dwi W 181', '56419974181', '3276010023181', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231181', 'Kp,Babakan No. 181', 'Islam', 4, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:40', NULL, NULL, NULL),
(182, 3, 'P20223182', 'AprilYandi Dwi W 182', '56419974182', '3276010023182', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231182', 'Kp,Babakan No. 182', 'Islam', 9, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(183, 2, 'P20222183', 'AprilYandi Dwi W 183', '56419974183', '3276010023183', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231183', 'Kp,Babakan No. 183', 'Islam', 7, 4, '1500000.00', NULL, '', '2022-12-07 13:58:41', NULL, NULL, NULL),
(184, 1, 'P20221184', 'AprilYandi Dwi W 184', '56419974184', '3276010023184', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231184', 'Kp,Babakan No. 184', 'Islam', 2, 5, NULL, NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(185, 2, 'P20222185', 'AprilYandi Dwi W 185', '56419974185', '3276010023185', 'Depok', '2001-12-23', 'Perempuan', '0851720231185', 'Kp,Babakan No. 185', 'Islam', 13, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(186, 1, 'P20221186', 'AprilYandi Dwi W 186', '56419974186', '3276010023186', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231186', 'Kp,Babakan No. 186', 'Islam', 2, 13, NULL, NULL, '', '2022-12-07 13:58:41', NULL, NULL, NULL),
(187, 3, 'P20223187', 'AprilYandi Dwi W 187', '56419974187', '3276010023187', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231187', 'Kp,Babakan No. 187', 'Islam', 7, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(188, 2, 'P20222188', 'AprilYandi Dwi W 188', '56419974188', '3276010023188', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231188', 'Kp,Babakan No. 188', 'Islam', 3, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(189, 3, 'P20223189', 'AprilYandi Dwi W 189', '56419974189', '3276010023189', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231189', 'Kp,Babakan No. 189', 'Islam', 4, 6, '1500000.00', NULL, '', '2022-12-07 13:58:41', NULL, NULL, NULL),
(190, 3, 'P20223190', 'AprilYandi Dwi W 190', '56419974190', '3276010023190', 'Depok', '2001-12-27', 'Perempuan', '0851720231190', 'Kp,Babakan No. 190', 'Islam', 13, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(191, 2, 'P20222191', 'AprilYandi Dwi W 191', '56419974191', '3276010023191', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231191', 'Kp,Babakan No. 191', 'Islam', 1, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(192, 3, 'P20223192', 'AprilYandi Dwi W 192', '56419974192', '3276010023192', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231192', 'Kp,Babakan No. 192', 'Islam', 3, 7, '1500000.00', NULL, '', '2022-12-07 13:58:41', NULL, NULL, NULL),
(193, 3, 'P20223193', 'AprilYandi Dwi W 193', '56419974193', '3276010023193', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231193', 'Kp,Babakan No. 193', 'Islam', 5, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:41', NULL, NULL, NULL),
(194, 1, 'P20221194', 'AprilYandi Dwi W 194', '56419974194', '3276010023194', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231194', 'Kp,Babakan No. 194', 'Islam', 9, 8, NULL, NULL, '1', '2022-12-07 13:58:42', NULL, NULL, NULL),
(195, 1, 'P20221195', 'AprilYandi Dwi W 195', '56419974195', '3276010023195', 'Depok', '2001-12-26', 'Perempuan', '0851720231195', 'Kp,Babakan No. 195', 'Islam', 3, 1, NULL, NULL, '', '2022-12-07 13:58:42', NULL, NULL, NULL),
(196, 1, 'P20221196', 'AprilYandi Dwi W 196', '56419974196', '3276010023196', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231196', 'Kp,Babakan No. 196', 'Islam', 10, 9, NULL, NULL, '1', '2022-12-07 13:58:42', NULL, NULL, NULL),
(197, 3, 'P20223197', 'AprilYandi Dwi W 197', '56419974197', '3276010023197', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231197', 'Kp,Babakan No. 197', 'Islam', 7, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:42', NULL, NULL, NULL),
(198, 1, 'P20221198', 'AprilYandi Dwi W 198', '56419974198', '3276010023198', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231198', 'Kp,Babakan No. 198', 'Islam', 1, 9, NULL, NULL, '', '2022-12-07 13:58:42', NULL, NULL, NULL),
(199, 1, 'P20221199', 'AprilYandi Dwi W 199', '56419974199', '3276010023199', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231199', 'Kp,Babakan No. 199', 'Islam', 9, 7, NULL, NULL, '1', '2022-12-07 13:58:42', NULL, NULL, NULL),
(200, 2, 'P20222200', 'AprilYandi Dwi W 200', '56419974200', '3276010023200', 'Depok', '2001-12-29', 'Perempuan', '0851720231200', 'Kp,Babakan No. 200', 'Islam', 5, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:42', NULL, NULL, NULL),
(201, 2, 'P20222201', 'AprilYandi Dwi W 201', '56419974201', '3276010023201', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231201', 'Kp,Babakan No. 201', 'Islam', 3, 4, '1500000.00', NULL, '', '2022-12-07 13:58:44', NULL, NULL, NULL),
(202, 3, 'P20223202', 'AprilYandi Dwi W 202', '56419974202', '3276010023202', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231202', 'Kp,Babakan No. 202', 'Islam', 8, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:44', NULL, NULL, NULL),
(203, 2, 'P20222203', 'AprilYandi Dwi W 203', '56419974203', '3276010023203', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231203', 'Kp,Babakan No. 203', 'Islam', 2, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:44', NULL, NULL, NULL),
(204, 1, 'P20221204', 'AprilYandi Dwi W 204', '56419974204', '3276010023204', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231204', 'Kp,Babakan No. 204', 'Islam', 1, 8, NULL, NULL, '', '2022-12-07 13:58:44', NULL, NULL, NULL),
(205, 2, 'P20222205', 'AprilYandi Dwi W 205', '56419974205', '3276010023205', 'Depok', '2001-12-12', 'Perempuan', '0851720231205', 'Kp,Babakan No. 205', 'Islam', 3, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:44', NULL, NULL, NULL),
(206, 2, 'P20222206', 'AprilYandi Dwi W 206', '56419974206', '3276010023206', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231206', 'Kp,Babakan No. 206', 'Islam', 10, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:44', NULL, NULL, NULL),
(207, 2, 'P20222207', 'AprilYandi Dwi W 207', '56419974207', '3276010023207', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231207', 'Kp,Babakan No. 207', 'Islam', 13, 13, '1500000.00', NULL, '', '2022-12-07 13:58:44', NULL, NULL, NULL),
(208, 2, 'P20222208', 'AprilYandi Dwi W 208', '56419974208', '3276010023208', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231208', 'Kp,Babakan No. 208', 'Islam', 10, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:45', NULL, NULL, NULL),
(209, 1, 'P20221209', 'AprilYandi Dwi W 209', '56419974209', '3276010023209', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231209', 'Kp,Babakan No. 209', 'Islam', 3, 1, NULL, NULL, '1', '2022-12-07 13:58:45', NULL, NULL, NULL),
(210, 3, 'P20223210', 'AprilYandi Dwi W 210', '56419974210', '3276010023210', 'Depok', '2001-12-20', 'Perempuan', '0851720231210', 'Kp,Babakan No. 210', 'Islam', 8, 7, '1500000.00', NULL, '', '2022-12-07 13:58:45', NULL, NULL, NULL),
(211, 1, 'P20221211', 'AprilYandi Dwi W 211', '56419974211', '3276010023211', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231211', 'Kp,Babakan No. 211', 'Islam', 3, 7, NULL, NULL, '1', '2022-12-07 13:58:45', NULL, NULL, NULL),
(212, 1, 'P20221212', 'AprilYandi Dwi W 212', '56419974212', '3276010023212', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231212', 'Kp,Babakan No. 212', 'Islam', 1, 13, NULL, NULL, '1', '2022-12-07 13:58:45', NULL, NULL, NULL),
(213, 3, 'P20223213', 'AprilYandi Dwi W 213', '56419974213', '3276010023213', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231213', 'Kp,Babakan No. 213', 'Islam', 12, 13, '1500000.00', NULL, '', '2022-12-07 13:58:45', NULL, NULL, NULL),
(214, 3, 'P20223214', 'AprilYandi Dwi W 214', '56419974214', '3276010023214', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231214', 'Kp,Babakan No. 214', 'Islam', 3, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:45', NULL, NULL, NULL),
(215, 3, 'P20223215', 'AprilYandi Dwi W 215', '56419974215', '3276010023215', 'Depok', '2001-12-28', 'Perempuan', '0851720231215', 'Kp,Babakan No. 215', 'Islam', 6, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:45', NULL, NULL, NULL),
(216, 1, 'P20221216', 'AprilYandi Dwi W 216', '56419974216', '3276010023216', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231216', 'Kp,Babakan No. 216', 'Islam', 2, 9, NULL, NULL, '', '2022-12-07 13:58:46', NULL, NULL, NULL),
(217, 1, 'P20221217', 'AprilYandi Dwi W 217', '56419974217', '3276010023217', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231217', 'Kp,Babakan No. 217', 'Islam', 10, 5, NULL, NULL, '1', '2022-12-07 13:58:46', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(218, 2, 'P20222218', 'AprilYandi Dwi W 218', '56419974218', '3276010023218', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231218', 'Kp,Babakan No. 218', 'Islam', 1, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:46', NULL, NULL, NULL),
(219, 3, 'P20223219', 'AprilYandi Dwi W 219', '56419974219', '3276010023219', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231219', 'Kp,Babakan No. 219', 'Islam', 7, 3, '1500000.00', NULL, '', '2022-12-07 13:58:46', NULL, NULL, NULL),
(220, 2, 'P20222220', 'AprilYandi Dwi W 220', '56419974220', '3276010023220', 'Depok', '2001-12-31', 'Perempuan', '0851720231220', 'Kp,Babakan No. 220', 'Islam', 9, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:47', NULL, NULL, NULL),
(221, 2, 'P20222221', 'AprilYandi Dwi W 221', '56419974221', '3276010023221', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231221', 'Kp,Babakan No. 221', 'Islam', 3, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:47', NULL, NULL, NULL),
(222, 1, 'P20221222', 'AprilYandi Dwi W 222', '56419974222', '3276010023222', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231222', 'Kp,Babakan No. 222', 'Islam', 3, 13, NULL, NULL, '', '2022-12-07 13:58:47', NULL, NULL, NULL),
(223, 1, 'P20221223', 'AprilYandi Dwi W 223', '56419974223', '3276010023223', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231223', 'Kp,Babakan No. 223', 'Islam', 8, 6, NULL, NULL, '1', '2022-12-07 13:58:47', NULL, NULL, NULL),
(224, 1, 'P20221224', 'AprilYandi Dwi W 224', '56419974224', '3276010023224', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231224', 'Kp,Babakan No. 224', 'Islam', 4, 6, NULL, NULL, '1', '2022-12-07 13:58:47', NULL, NULL, NULL),
(225, 3, 'P20223225', 'AprilYandi Dwi W 225', '56419974225', '3276010023225', 'Depok', '2001-12-25', 'Perempuan', '0851720231225', 'Kp,Babakan No. 225', 'Islam', 2, 4, '1500000.00', NULL, '', '2022-12-07 13:58:47', NULL, NULL, NULL),
(226, 1, 'P20221226', 'AprilYandi Dwi W 226', '56419974226', '3276010023226', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231226', 'Kp,Babakan No. 226', 'Islam', 12, 4, NULL, NULL, '1', '2022-12-07 13:58:47', NULL, NULL, NULL),
(227, 1, 'P20221227', 'AprilYandi Dwi W 227', '56419974227', '3276010023227', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231227', 'Kp,Babakan No. 227', 'Islam', 5, 10, NULL, NULL, '1', '2022-12-07 13:58:47', NULL, NULL, NULL),
(228, 2, 'P20222228', 'AprilYandi Dwi W 228', '56419974228', '3276010023228', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231228', 'Kp,Babakan No. 228', 'Islam', 7, 6, '1500000.00', NULL, '', '2022-12-07 13:58:47', NULL, NULL, NULL),
(229, 3, 'P20223229', 'AprilYandi Dwi W 229', '56419974229', '3276010023229', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231229', 'Kp,Babakan No. 229', 'Islam', 2, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:48', NULL, NULL, NULL),
(230, 1, 'P20221230', 'AprilYandi Dwi W 230', '56419974230', '3276010023230', 'Depok', '2001-12-14', 'Perempuan', '0851720231230', 'Kp,Babakan No. 230', 'Islam', 8, 10, NULL, NULL, '1', '2022-12-07 13:58:48', NULL, NULL, NULL),
(231, 2, 'P20222231', 'AprilYandi Dwi W 231', '56419974231', '3276010023231', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231231', 'Kp,Babakan No. 231', 'Islam', 7, 9, '1500000.00', NULL, '', '2022-12-07 13:58:48', NULL, NULL, NULL),
(232, 1, 'P20221232', 'AprilYandi Dwi W 232', '56419974232', '3276010023232', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231232', 'Kp,Babakan No. 232', 'Islam', 11, 5, NULL, NULL, '1', '2022-12-07 13:58:48', NULL, NULL, NULL),
(233, 2, 'P20222233', 'AprilYandi Dwi W 233', '56419974233', '3276010023233', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231233', 'Kp,Babakan No. 233', 'Islam', 4, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:48', NULL, NULL, NULL),
(234, 1, 'P20221234', 'AprilYandi Dwi W 234', '56419974234', '3276010023234', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231234', 'Kp,Babakan No. 234', 'Islam', 7, 1, NULL, NULL, '', '2022-12-07 13:58:48', NULL, NULL, NULL),
(235, 1, 'P20221235', 'AprilYandi Dwi W 235', '56419974235', '3276010023235', 'Depok', '2001-12-11', 'Perempuan', '0851720231235', 'Kp,Babakan No. 235', 'Islam', 9, 12, NULL, NULL, '1', '2022-12-07 13:58:48', NULL, NULL, NULL),
(236, 2, 'P20222236', 'AprilYandi Dwi W 236', '56419974236', '3276010023236', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231236', 'Kp,Babakan No. 236', 'Islam', 4, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:48', NULL, NULL, NULL),
(237, 1, 'P20221237', 'AprilYandi Dwi W 237', '56419974237', '3276010023237', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231237', 'Kp,Babakan No. 237', 'Islam', 9, 12, NULL, NULL, '', '2022-12-07 13:58:48', NULL, NULL, NULL),
(238, 3, 'P20223238', 'AprilYandi Dwi W 238', '56419974238', '3276010023238', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231238', 'Kp,Babakan No. 238', 'Islam', 9, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:49', NULL, NULL, NULL),
(239, 3, 'P20223239', 'AprilYandi Dwi W 239', '56419974239', '3276010023239', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231239', 'Kp,Babakan No. 239', 'Islam', 1, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:49', NULL, NULL, NULL),
(240, 3, 'P20223240', 'AprilYandi Dwi W 240', '56419974240', '3276010023240', 'Depok', '2001-12-02', 'Perempuan', '0851720231240', 'Kp,Babakan No. 240', 'Islam', 10, 9, '1500000.00', NULL, '', '2022-12-07 13:58:49', NULL, NULL, NULL),
(241, 2, 'P20222241', 'AprilYandi Dwi W 241', '56419974241', '3276010023241', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231241', 'Kp,Babakan No. 241', 'Islam', 4, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:50', NULL, NULL, NULL),
(242, 1, 'P20221242', 'AprilYandi Dwi W 242', '56419974242', '3276010023242', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231242', 'Kp,Babakan No. 242', 'Islam', 7, 7, NULL, NULL, '1', '2022-12-07 13:58:50', NULL, NULL, NULL),
(243, 3, 'P20223243', 'AprilYandi Dwi W 243', '56419974243', '3276010023243', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231243', 'Kp,Babakan No. 243', 'Islam', 5, 10, '1500000.00', NULL, '', '2022-12-07 13:58:50', NULL, NULL, NULL),
(244, 3, 'P20223244', 'AprilYandi Dwi W 244', '56419974244', '3276010023244', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231244', 'Kp,Babakan No. 244', 'Islam', 10, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:50', NULL, NULL, NULL),
(245, 3, 'P20223245', 'AprilYandi Dwi W 245', '56419974245', '3276010023245', 'Depok', '2001-12-23', 'Perempuan', '0851720231245', 'Kp,Babakan No. 245', 'Islam', 3, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:50', NULL, NULL, NULL),
(246, 2, 'P20222246', 'AprilYandi Dwi W 246', '56419974246', '3276010023246', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231246', 'Kp,Babakan No. 246', 'Islam', 5, 4, '1500000.00', NULL, '', '2022-12-07 13:58:50', NULL, NULL, NULL),
(247, 3, 'P20223247', 'AprilYandi Dwi W 247', '56419974247', '3276010023247', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231247', 'Kp,Babakan No. 247', 'Islam', 12, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:50', NULL, NULL, NULL),
(248, 1, 'P20221248', 'AprilYandi Dwi W 248', '56419974248', '3276010023248', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231248', 'Kp,Babakan No. 248', 'Islam', 3, 3, NULL, NULL, '1', '2022-12-07 13:58:51', NULL, NULL, NULL),
(249, 3, 'P20223249', 'AprilYandi Dwi W 249', '56419974249', '3276010023249', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231249', 'Kp,Babakan No. 249', 'Islam', 5, 1, '1500000.00', NULL, '', '2022-12-07 13:58:51', NULL, NULL, NULL),
(250, 2, 'P20222250', 'AprilYandi Dwi W 250', '56419974250', '3276010023250', 'Depok', '2001-12-27', 'Perempuan', '0851720231250', 'Kp,Babakan No. 250', 'Islam', 1, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:51', NULL, NULL, NULL),
(251, 1, 'P20221251', 'AprilYandi Dwi W 251', '56419974251', '3276010023251', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231251', 'Kp,Babakan No. 251', 'Islam', 5, 12, NULL, NULL, '1', '2022-12-07 13:58:51', NULL, NULL, NULL),
(252, 3, 'P20223252', 'AprilYandi Dwi W 252', '56419974252', '3276010023252', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231252', 'Kp,Babakan No. 252', 'Islam', 12, 9, '1500000.00', NULL, '', '2022-12-07 13:58:51', NULL, NULL, NULL),
(253, 3, 'P20223253', 'AprilYandi Dwi W 253', '56419974253', '3276010023253', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231253', 'Kp,Babakan No. 253', 'Islam', 8, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:51', NULL, NULL, NULL),
(254, 3, 'P20223254', 'AprilYandi Dwi W 254', '56419974254', '3276010023254', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231254', 'Kp,Babakan No. 254', 'Islam', 5, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:52', NULL, NULL, NULL),
(255, 1, 'P20221255', 'AprilYandi Dwi W 255', '56419974255', '3276010023255', 'Depok', '2001-12-17', 'Perempuan', '0851720231255', 'Kp,Babakan No. 255', 'Islam', 10, 1, NULL, NULL, '', '2022-12-07 13:58:52', NULL, NULL, NULL),
(256, 2, 'P20222256', 'AprilYandi Dwi W 256', '56419974256', '3276010023256', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231256', 'Kp,Babakan No. 256', 'Islam', 4, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:52', NULL, NULL, NULL),
(257, 2, 'P20222257', 'AprilYandi Dwi W 257', '56419974257', '3276010023257', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231257', 'Kp,Babakan No. 257', 'Islam', 11, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:53', NULL, NULL, NULL),
(258, 2, 'P20222258', 'AprilYandi Dwi W 258', '56419974258', '3276010023258', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231258', 'Kp,Babakan No. 258', 'Islam', 5, 7, '1500000.00', NULL, '', '2022-12-07 13:58:53', NULL, NULL, NULL),
(259, 1, 'P20221259', 'AprilYandi Dwi W 259', '56419974259', '3276010023259', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231259', 'Kp,Babakan No. 259', 'Islam', 11, 4, NULL, NULL, '1', '2022-12-07 13:58:53', NULL, NULL, NULL),
(260, 3, 'P20223260', 'AprilYandi Dwi W 260', '56419974260', '3276010023260', 'Depok', '2001-12-13', 'Perempuan', '0851720231260', 'Kp,Babakan No. 260', 'Islam', 7, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:53', NULL, NULL, NULL),
(261, 1, 'P20221261', 'AprilYandi Dwi W 261', '56419974261', '3276010023261', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231261', 'Kp,Babakan No. 261', 'Islam', 10, 9, NULL, NULL, '', '2022-12-07 13:58:53', NULL, NULL, NULL),
(262, 2, 'P20222262', 'AprilYandi Dwi W 262', '56419974262', '3276010023262', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231262', 'Kp,Babakan No. 262', 'Islam', 4, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:53', NULL, NULL, NULL),
(263, 3, 'P20223263', 'AprilYandi Dwi W 263', '56419974263', '3276010023263', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231263', 'Kp,Babakan No. 263', 'Islam', 7, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:53', NULL, NULL, NULL),
(264, 1, 'P20221264', 'AprilYandi Dwi W 264', '56419974264', '3276010023264', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231264', 'Kp,Babakan No. 264', 'Islam', 12, 9, NULL, NULL, '', '2022-12-07 13:58:54', NULL, NULL, NULL),
(265, 2, 'P20222265', 'AprilYandi Dwi W 265', '56419974265', '3276010023265', 'Depok', '2001-12-30', 'Perempuan', '0851720231265', 'Kp,Babakan No. 265', 'Islam', 3, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:54', NULL, NULL, NULL),
(266, 2, 'P20222266', 'AprilYandi Dwi W 266', '56419974266', '3276010023266', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231266', 'Kp,Babakan No. 266', 'Islam', 1, 12, '1500000.00', NULL, '1', '2022-12-07 13:58:54', NULL, NULL, NULL),
(267, 3, 'P20223267', 'AprilYandi Dwi W 267', '56419974267', '3276010023267', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231267', 'Kp,Babakan No. 267', 'Islam', 1, 12, '1500000.00', NULL, '', '2022-12-07 13:58:54', NULL, NULL, NULL),
(268, 1, 'P20221268', 'AprilYandi Dwi W 268', '56419974268', '3276010023268', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231268', 'Kp,Babakan No. 268', 'Islam', 1, 7, NULL, NULL, '1', '2022-12-07 13:58:54', NULL, NULL, NULL),
(269, 3, 'P20223269', 'AprilYandi Dwi W 269', '56419974269', '3276010023269', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231269', 'Kp,Babakan No. 269', 'Islam', 12, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:54', NULL, NULL, NULL),
(270, 1, 'P20221270', 'AprilYandi Dwi W 270', '56419974270', '3276010023270', 'Depok', '2001-12-05', 'Perempuan', '0851720231270', 'Kp,Babakan No. 270', 'Islam', 8, 2, NULL, NULL, '', '2022-12-07 13:58:54', NULL, NULL, NULL),
(271, 3, 'P20223271', 'AprilYandi Dwi W 271', '56419974271', '3276010023271', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231271', 'Kp,Babakan No. 271', 'Islam', 8, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:54', NULL, NULL, NULL),
(272, 3, 'P20223272', 'AprilYandi Dwi W 272', '56419974272', '3276010023272', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231272', 'Kp,Babakan No. 272', 'Islam', 11, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:54', NULL, NULL, NULL),
(273, 1, 'P20221273', 'AprilYandi Dwi W 273', '56419974273', '3276010023273', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231273', 'Kp,Babakan No. 273', 'Islam', 12, 3, NULL, NULL, '', '2022-12-07 13:58:54', NULL, NULL, NULL),
(274, 1, 'P20221274', 'AprilYandi Dwi W 274', '56419974274', '3276010023274', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231274', 'Kp,Babakan No. 274', 'Islam', 1, 9, NULL, NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(275, 3, 'P20223275', 'AprilYandi Dwi W 275', '56419974275', '3276010023275', 'Depok', '2001-12-20', 'Perempuan', '0851720231275', 'Kp,Babakan No. 275', 'Islam', 12, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(276, 1, 'P20221276', 'AprilYandi Dwi W 276', '56419974276', '3276010023276', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231276', 'Kp,Babakan No. 276', 'Islam', 6, 13, NULL, NULL, '', '2022-12-07 13:58:55', NULL, NULL, NULL),
(277, 3, 'P20223277', 'AprilYandi Dwi W 277', '56419974277', '3276010023277', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231277', 'Kp,Babakan No. 277', 'Islam', 9, 5, '1500000.00', NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(278, 2, 'P20222278', 'AprilYandi Dwi W 278', '56419974278', '3276010023278', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231278', 'Kp,Babakan No. 278', 'Islam', 12, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(279, 1, 'P20221279', 'AprilYandi Dwi W 279', '56419974279', '3276010023279', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231279', 'Kp,Babakan No. 279', 'Islam', 8, 12, NULL, NULL, '', '2022-12-07 13:58:55', NULL, NULL, NULL),
(280, 3, 'P20223280', 'AprilYandi Dwi W 280', '56419974280', '3276010023280', 'Depok', '2001-12-12', 'Perempuan', '0851720231280', 'Kp,Babakan No. 280', 'Islam', 5, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(281, 1, 'P20221281', 'AprilYandi Dwi W 281', '56419974281', '3276010023281', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231281', 'Kp,Babakan No. 281', 'Islam', 6, 7, NULL, NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(282, 1, 'P20221282', 'AprilYandi Dwi W 282', '56419974282', '3276010023282', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231282', 'Kp,Babakan No. 282', 'Islam', 4, 2, NULL, NULL, '', '2022-12-07 13:58:55', NULL, NULL, NULL),
(283, 1, 'P20221283', 'AprilYandi Dwi W 283', '56419974283', '3276010023283', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231283', 'Kp,Babakan No. 283', 'Islam', 13, 12, NULL, NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(284, 3, 'P20223284', 'AprilYandi Dwi W 284', '56419974284', '3276010023284', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231284', 'Kp,Babakan No. 284', 'Islam', 13, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:55', NULL, NULL, NULL),
(285, 2, 'P20222285', 'AprilYandi Dwi W 285', '56419974285', '3276010023285', 'Depok', '2001-12-28', 'Perempuan', '0851720231285', 'Kp,Babakan No. 285', 'Islam', 12, 3, '1500000.00', NULL, '', '2022-12-07 13:58:56', NULL, NULL, NULL),
(286, 3, 'P20223286', 'AprilYandi Dwi W 286', '56419974286', '3276010023286', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231286', 'Kp,Babakan No. 286', 'Islam', 11, 9, '1500000.00', NULL, '1', '2022-12-07 13:58:56', NULL, NULL, NULL),
(287, 2, 'P20222287', 'AprilYandi Dwi W 287', '56419974287', '3276010023287', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231287', 'Kp,Babakan No. 287', 'Islam', 7, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:56', NULL, NULL, NULL),
(288, 3, 'P20223288', 'AprilYandi Dwi W 288', '56419974288', '3276010023288', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231288', 'Kp,Babakan No. 288', 'Islam', 11, 8, '1500000.00', NULL, '', '2022-12-07 13:58:56', NULL, NULL, NULL),
(289, 2, 'P20222289', 'AprilYandi Dwi W 289', '56419974289', '3276010023289', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231289', 'Kp,Babakan No. 289', 'Islam', 4, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:56', NULL, NULL, NULL),
(290, 3, 'P20223290', 'AprilYandi Dwi W 290', '56419974290', '3276010023290', 'Depok', '2001-12-23', 'Perempuan', '0851720231290', 'Kp,Babakan No. 290', 'Islam', 13, 13, '1500000.00', NULL, '1', '2022-12-07 13:58:56', NULL, NULL, NULL),
(291, 3, 'P20223291', 'AprilYandi Dwi W 291', '56419974291', '3276010023291', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231291', 'Kp,Babakan No. 291', 'Islam', 11, 4, '1500000.00', NULL, '', '2022-12-07 13:58:56', NULL, NULL, NULL),
(292, 1, 'P20221292', 'AprilYandi Dwi W 292', '56419974292', '3276010023292', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231292', 'Kp,Babakan No. 292', 'Islam', 10, 1, NULL, NULL, '1', '2022-12-07 13:58:56', NULL, NULL, NULL),
(293, 2, 'P20222293', 'AprilYandi Dwi W 293', '56419974293', '3276010023293', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231293', 'Kp,Babakan No. 293', 'Islam', 2, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:56', NULL, NULL, NULL),
(294, 2, 'P20222294', 'AprilYandi Dwi W 294', '56419974294', '3276010023294', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231294', 'Kp,Babakan No. 294', 'Islam', 7, 4, '1500000.00', NULL, '', '2022-12-07 13:58:56', NULL, NULL, NULL),
(295, 2, 'P20222295', 'AprilYandi Dwi W 295', '56419974295', '3276010023295', 'Depok', '2001-12-22', 'Perempuan', '0851720231295', 'Kp,Babakan No. 295', 'Islam', 11, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(296, 1, 'P20221296', 'AprilYandi Dwi W 296', '56419974296', '3276010023296', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231296', 'Kp,Babakan No. 296', 'Islam', 13, 5, NULL, NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(297, 1, 'P20221297', 'AprilYandi Dwi W 297', '56419974297', '3276010023297', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231297', 'Kp,Babakan No. 297', 'Islam', 11, 12, NULL, NULL, '', '2022-12-07 13:58:57', NULL, NULL, NULL),
(298, 1, 'P20221298', 'AprilYandi Dwi W 298', '56419974298', '3276010023298', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231298', 'Kp,Babakan No. 298', 'Islam', 6, 4, NULL, NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(299, 3, 'P20223299', 'AprilYandi Dwi W 299', '56419974299', '3276010023299', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231299', 'Kp,Babakan No. 299', 'Islam', 4, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(300, 2, 'P20222300', 'AprilYandi Dwi W 300', '56419974300', '3276010023300', 'Depok', '2001-12-14', 'Perempuan', '0851720231300', 'Kp,Babakan No. 300', 'Islam', 9, 13, '1500000.00', NULL, '', '2022-12-07 13:58:57', NULL, NULL, NULL),
(301, 2, 'P20222301', 'AprilYandi Dwi W 301', '56419974301', '3276010023301', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231301', 'Kp,Babakan No. 301', 'Islam', 2, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(302, 2, 'P20222302', 'AprilYandi Dwi W 302', '56419974302', '3276010023302', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231302', 'Kp,Babakan No. 302', 'Islam', 7, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(303, 1, 'P20221303', 'AprilYandi Dwi W 303', '56419974303', '3276010023303', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231303', 'Kp,Babakan No. 303', 'Islam', 9, 5, NULL, NULL, '', '2022-12-07 13:58:57', NULL, NULL, NULL),
(304, 3, 'P20223304', 'AprilYandi Dwi W 304', '56419974304', '3276010023304', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231304', 'Kp,Babakan No. 304', 'Islam', 10, 8, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(305, 2, 'P20222305', 'AprilYandi Dwi W 305', '56419974305', '3276010023305', 'Depok', '2001-12-28', 'Perempuan', '0851720231305', 'Kp,Babakan No. 305', 'Islam', 3, 3, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(306, 2, 'P20222306', 'AprilYandi Dwi W 306', '56419974306', '3276010023306', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231306', 'Kp,Babakan No. 306', 'Islam', 7, 5, '1500000.00', NULL, '', '2022-12-07 13:58:57', NULL, NULL, NULL),
(307, 2, 'P20222307', 'AprilYandi Dwi W 307', '56419974307', '3276010023307', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231307', 'Kp,Babakan No. 307', 'Islam', 12, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(308, 1, 'P20221308', 'AprilYandi Dwi W 308', '56419974308', '3276010023308', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231308', 'Kp,Babakan No. 308', 'Islam', 1, 10, NULL, NULL, '1', '2022-12-07 13:58:57', NULL, NULL, NULL),
(309, 1, 'P20221309', 'AprilYandi Dwi W 309', '56419974309', '3276010023309', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231309', 'Kp,Babakan No. 309', 'Islam', 11, 3, NULL, NULL, '', '2022-12-07 13:58:57', NULL, NULL, NULL),
(310, 2, 'P20222310', 'AprilYandi Dwi W 310', '56419974310', '3276010023310', 'Depok', '2001-12-09', 'Perempuan', '0851720231310', 'Kp,Babakan No. 310', 'Islam', 1, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(311, 3, 'P20223311', 'AprilYandi Dwi W 311', '56419974311', '3276010023311', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231311', 'Kp,Babakan No. 311', 'Islam', 4, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(312, 1, 'P20221312', 'AprilYandi Dwi W 312', '56419974312', '3276010023312', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231312', 'Kp,Babakan No. 312', 'Islam', 6, 12, NULL, NULL, '', '2022-12-07 13:58:58', NULL, NULL, NULL),
(313, 3, 'P20223313', 'AprilYandi Dwi W 313', '56419974313', '3276010023313', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231313', 'Kp,Babakan No. 313', 'Islam', 1, 2, '1500000.00', NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(314, 1, 'P20221314', 'AprilYandi Dwi W 314', '56419974314', '3276010023314', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231314', 'Kp,Babakan No. 314', 'Islam', 11, 6, NULL, NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(315, 2, 'P20222315', 'AprilYandi Dwi W 315', '56419974315', '3276010023315', 'Depok', '2001-12-27', 'Perempuan', '0851720231315', 'Kp,Babakan No. 315', 'Islam', 4, 6, '1500000.00', NULL, '', '2022-12-07 13:58:58', NULL, NULL, NULL),
(316, 2, 'P20222316', 'AprilYandi Dwi W 316', '56419974316', '3276010023316', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231316', 'Kp,Babakan No. 316', 'Islam', 1, 11, '1500000.00', NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(317, 3, 'P20223317', 'AprilYandi Dwi W 317', '56419974317', '3276010023317', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231317', 'Kp,Babakan No. 317', 'Islam', 8, 6, '1500000.00', NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(318, 2, 'P20222318', 'AprilYandi Dwi W 318', '56419974318', '3276010023318', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231318', 'Kp,Babakan No. 318', 'Islam', 6, 2, '1500000.00', NULL, '', '2022-12-07 13:58:58', NULL, NULL, NULL),
(319, 3, 'P20223319', 'AprilYandi Dwi W 319', '56419974319', '3276010023319', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231319', 'Kp,Babakan No. 319', 'Islam', 7, 1, '1500000.00', NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(320, 1, 'P20221320', 'AprilYandi Dwi W 320', '56419974320', '3276010023320', 'Depok', '2001-12-27', 'Perempuan', '0851720231320', 'Kp,Babakan No. 320', 'Islam', 1, 7, NULL, NULL, '1', '2022-12-07 13:58:58', NULL, NULL, NULL),
(321, 3, 'P20223321', 'AprilYandi Dwi W 321', '56419974321', '3276010023321', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231321', 'Kp,Babakan No. 321', 'Islam', 7, 13, '1500000.00', NULL, '', '2022-12-07 13:58:58', NULL, NULL, NULL),
(322, 3, 'P20223322', 'AprilYandi Dwi W 322', '56419974322', '3276010023322', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231322', 'Kp,Babakan No. 322', 'Islam', 8, 4, '1500000.00', NULL, '1', '2022-12-07 13:58:59', NULL, NULL, NULL),
(323, 1, 'P20221323', 'AprilYandi Dwi W 323', '56419974323', '3276010023323', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231323', 'Kp,Babakan No. 323', 'Islam', 13, 6, NULL, NULL, '1', '2022-12-07 13:58:59', NULL, NULL, NULL),
(324, 1, 'P20221324', 'AprilYandi Dwi W 324', '56419974324', '3276010023324', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231324', 'Kp,Babakan No. 324', 'Islam', 5, 1, NULL, NULL, '', '2022-12-07 13:58:59', NULL, NULL, NULL),
(325, 1, 'P20221325', 'AprilYandi Dwi W 325', '56419974325', '3276010023325', 'Depok', '2001-12-03', 'Perempuan', '0851720231325', 'Kp,Babakan No. 325', 'Islam', 4, 3, NULL, NULL, '1', '2022-12-07 13:58:59', NULL, NULL, NULL),
(326, 2, 'P20222326', 'AprilYandi Dwi W 326', '56419974326', '3276010023326', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231326', 'Kp,Babakan No. 326', 'Islam', 4, 10, '1500000.00', NULL, '1', '2022-12-07 13:58:59', NULL, NULL, NULL),
(327, 1, 'P20221327', 'AprilYandi Dwi W 327', '56419974327', '3276010023327', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231327', 'Kp,Babakan No. 327', 'Islam', 1, 2, NULL, NULL, '', '2022-12-07 13:58:59', NULL, NULL, NULL),
(328, 1, 'P20221328', 'AprilYandi Dwi W 328', '56419974328', '3276010023328', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231328', 'Kp,Babakan No. 328', 'Islam', 10, 12, NULL, NULL, '1', '2022-12-07 13:58:59', NULL, NULL, NULL),
(329, 2, 'P20222329', 'AprilYandi Dwi W 329', '56419974329', '3276010023329', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231329', 'Kp,Babakan No. 329', 'Islam', 4, 7, '1500000.00', NULL, '1', '2022-12-07 13:58:59', NULL, NULL, NULL),
(330, 2, 'P20222330', 'AprilYandi Dwi W 330', '56419974330', '3276010023330', 'Depok', '2001-12-20', 'Perempuan', '0851720231330', 'Kp,Babakan No. 330', 'Islam', 5, 4, '1500000.00', NULL, '', '2022-12-07 13:59:00', NULL, NULL, NULL),
(331, 1, 'P20221331', 'AprilYandi Dwi W 331', '56419974331', '3276010023331', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231331', 'Kp,Babakan No. 331', 'Islam', 13, 11, NULL, NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(332, 1, 'P20221332', 'AprilYandi Dwi W 332', '56419974332', '3276010023332', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231332', 'Kp,Babakan No. 332', 'Islam', 11, 13, NULL, NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(333, 1, 'P20221333', 'AprilYandi Dwi W 333', '56419974333', '3276010023333', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231333', 'Kp,Babakan No. 333', 'Islam', 8, 10, NULL, NULL, '', '2022-12-07 13:59:00', NULL, NULL, NULL),
(334, 3, 'P20223334', 'AprilYandi Dwi W 334', '56419974334', '3276010023334', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231334', 'Kp,Babakan No. 334', 'Islam', 12, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(335, 1, 'P20221335', 'AprilYandi Dwi W 335', '56419974335', '3276010023335', 'Depok', '2001-12-31', 'Perempuan', '0851720231335', 'Kp,Babakan No. 335', 'Islam', 7, 11, NULL, NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(336, 2, 'P20222336', 'AprilYandi Dwi W 336', '56419974336', '3276010023336', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231336', 'Kp,Babakan No. 336', 'Islam', 13, 9, '1500000.00', NULL, '', '2022-12-07 13:59:00', NULL, NULL, NULL),
(337, 1, 'P20221337', 'AprilYandi Dwi W 337', '56419974337', '3276010023337', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231337', 'Kp,Babakan No. 337', 'Islam', 4, 5, NULL, NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(338, 3, 'P20223338', 'AprilYandi Dwi W 338', '56419974338', '3276010023338', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231338', 'Kp,Babakan No. 338', 'Islam', 5, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(339, 2, 'P20222339', 'AprilYandi Dwi W 339', '56419974339', '3276010023339', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231339', 'Kp,Babakan No. 339', 'Islam', 7, 8, '1500000.00', NULL, '', '2022-12-07 13:59:00', NULL, NULL, NULL),
(340, 3, 'P20223340', 'AprilYandi Dwi W 340', '56419974340', '3276010023340', 'Depok', '2001-12-23', 'Perempuan', '0851720231340', 'Kp,Babakan No. 340', 'Islam', 11, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(341, 3, 'P20223341', 'AprilYandi Dwi W 341', '56419974341', '3276010023341', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231341', 'Kp,Babakan No. 341', 'Islam', 12, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:00', NULL, NULL, NULL),
(342, 1, 'P20221342', 'AprilYandi Dwi W 342', '56419974342', '3276010023342', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231342', 'Kp,Babakan No. 342', 'Islam', 6, 12, NULL, NULL, '', '2022-12-07 13:59:00', NULL, NULL, NULL),
(343, 2, 'P20222343', 'AprilYandi Dwi W 343', '56419974343', '3276010023343', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231343', 'Kp,Babakan No. 343', 'Islam', 11, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(344, 1, 'P20221344', 'AprilYandi Dwi W 344', '56419974344', '3276010023344', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231344', 'Kp,Babakan No. 344', 'Islam', 1, 11, NULL, NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(345, 2, 'P20222345', 'AprilYandi Dwi W 345', '56419974345', '3276010023345', 'Depok', '2001-12-06', 'Perempuan', '0851720231345', 'Kp,Babakan No. 345', 'Islam', 10, 12, '1500000.00', NULL, '', '2022-12-07 13:59:01', NULL, NULL, NULL),
(346, 3, 'P20223346', 'AprilYandi Dwi W 346', '56419974346', '3276010023346', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231346', 'Kp,Babakan No. 346', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(347, 3, 'P20223347', 'AprilYandi Dwi W 347', '56419974347', '3276010023347', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231347', 'Kp,Babakan No. 347', 'Islam', 6, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(348, 3, 'P20223348', 'AprilYandi Dwi W 348', '56419974348', '3276010023348', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231348', 'Kp,Babakan No. 348', 'Islam', 9, 4, '1500000.00', NULL, '', '2022-12-07 13:59:01', NULL, NULL, NULL),
(349, 1, 'P20221349', 'AprilYandi Dwi W 349', '56419974349', '3276010023349', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231349', 'Kp,Babakan No. 349', 'Islam', 7, 2, NULL, NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(350, 1, 'P20221350', 'AprilYandi Dwi W 350', '56419974350', '3276010023350', 'Depok', '2001-12-09', 'Perempuan', '0851720231350', 'Kp,Babakan No. 350', 'Islam', 6, 11, NULL, NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(351, 2, 'P20222351', 'AprilYandi Dwi W 351', '56419974351', '3276010023351', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231351', 'Kp,Babakan No. 351', 'Islam', 1, 6, '1500000.00', NULL, '', '2022-12-07 13:59:01', NULL, NULL, NULL),
(352, 3, 'P20223352', 'AprilYandi Dwi W 352', '56419974352', '3276010023352', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231352', 'Kp,Babakan No. 352', 'Islam', 5, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(353, 1, 'P20221353', 'AprilYandi Dwi W 353', '56419974353', '3276010023353', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231353', 'Kp,Babakan No. 353', 'Islam', 4, 2, NULL, NULL, '1', '2022-12-07 13:59:01', NULL, NULL, NULL),
(354, 2, 'P20222354', 'AprilYandi Dwi W 354', '56419974354', '3276010023354', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231354', 'Kp,Babakan No. 354', 'Islam', 1, 13, '1500000.00', NULL, '', '2022-12-07 13:59:02', NULL, NULL, NULL),
(355, 3, 'P20223355', 'AprilYandi Dwi W 355', '56419974355', '3276010023355', 'Depok', '2001-12-22', 'Perempuan', '0851720231355', 'Kp,Babakan No. 355', 'Islam', 6, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(356, 3, 'P20223356', 'AprilYandi Dwi W 356', '56419974356', '3276010023356', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231356', 'Kp,Babakan No. 356', 'Islam', 11, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(357, 3, 'P20223357', 'AprilYandi Dwi W 357', '56419974357', '3276010023357', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231357', 'Kp,Babakan No. 357', 'Islam', 1, 1, '1500000.00', NULL, '', '2022-12-07 13:59:02', NULL, NULL, NULL),
(358, 1, 'P20221358', 'AprilYandi Dwi W 358', '56419974358', '3276010023358', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231358', 'Kp,Babakan No. 358', 'Islam', 6, 8, NULL, NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(359, 1, 'P20221359', 'AprilYandi Dwi W 359', '56419974359', '3276010023359', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231359', 'Kp,Babakan No. 359', 'Islam', 4, 7, NULL, NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(360, 3, 'P20223360', 'AprilYandi Dwi W 360', '56419974360', '3276010023360', 'Depok', '2001-12-18', 'Perempuan', '0851720231360', 'Kp,Babakan No. 360', 'Islam', 4, 10, '1500000.00', NULL, '', '2022-12-07 13:59:02', NULL, NULL, NULL),
(361, 1, 'P20221361', 'AprilYandi Dwi W 361', '56419974361', '3276010023361', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231361', 'Kp,Babakan No. 361', 'Islam', 3, 3, NULL, NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(362, 1, 'P20221362', 'AprilYandi Dwi W 362', '56419974362', '3276010023362', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231362', 'Kp,Babakan No. 362', 'Islam', 11, 2, NULL, NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(363, 1, 'P20221363', 'AprilYandi Dwi W 363', '56419974363', '3276010023363', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231363', 'Kp,Babakan No. 363', 'Islam', 12, 2, NULL, NULL, '', '2022-12-07 13:59:02', NULL, NULL, NULL),
(364, 3, 'P20223364', 'AprilYandi Dwi W 364', '56419974364', '3276010023364', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231364', 'Kp,Babakan No. 364', 'Islam', 1, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:02', NULL, NULL, NULL),
(365, 2, 'P20222365', 'AprilYandi Dwi W 365', '56419974365', '3276010023365', 'Depok', '2001-12-23', 'Perempuan', '0851720231365', 'Kp,Babakan No. 365', 'Islam', 1, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:03', NULL, NULL, NULL),
(366, 3, 'P20223366', 'AprilYandi Dwi W 366', '56419974366', '3276010023366', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231366', 'Kp,Babakan No. 366', 'Islam', 1, 7, '1500000.00', NULL, '', '2022-12-07 13:59:03', NULL, NULL, NULL),
(367, 1, 'P20221367', 'AprilYandi Dwi W 367', '56419974367', '3276010023367', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231367', 'Kp,Babakan No. 367', 'Islam', 5, 11, NULL, NULL, '1', '2022-12-07 13:59:03', NULL, NULL, NULL),
(368, 2, 'P20222368', 'AprilYandi Dwi W 368', '56419974368', '3276010023368', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231368', 'Kp,Babakan No. 368', 'Islam', 3, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:03', NULL, NULL, NULL),
(369, 1, 'P20221369', 'AprilYandi Dwi W 369', '56419974369', '3276010023369', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231369', 'Kp,Babakan No. 369', 'Islam', 9, 9, NULL, NULL, '', '2022-12-07 13:59:03', NULL, NULL, NULL),
(370, 2, 'P20222370', 'AprilYandi Dwi W 370', '56419974370', '3276010023370', 'Depok', '2001-12-25', 'Perempuan', '0851720231370', 'Kp,Babakan No. 370', 'Islam', 10, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:03', NULL, NULL, NULL),
(371, 1, 'P20221371', 'AprilYandi Dwi W 371', '56419974371', '3276010023371', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231371', 'Kp,Babakan No. 371', 'Islam', 13, 9, NULL, NULL, '1', '2022-12-07 13:59:03', NULL, NULL, NULL),
(372, 1, 'P20221372', 'AprilYandi Dwi W 372', '56419974372', '3276010023372', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231372', 'Kp,Babakan No. 372', 'Islam', 2, 10, NULL, NULL, '', '2022-12-07 13:59:04', NULL, NULL, NULL),
(373, 3, 'P20223373', 'AprilYandi Dwi W 373', '56419974373', '3276010023373', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231373', 'Kp,Babakan No. 373', 'Islam', 6, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(374, 3, 'P20223374', 'AprilYandi Dwi W 374', '56419974374', '3276010023374', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231374', 'Kp,Babakan No. 374', 'Islam', 13, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(375, 1, 'P20221375', 'AprilYandi Dwi W 375', '56419974375', '3276010023375', 'Depok', '2001-12-08', 'Perempuan', '0851720231375', 'Kp,Babakan No. 375', 'Islam', 2, 12, NULL, NULL, '', '2022-12-07 13:59:04', NULL, NULL, NULL),
(376, 2, 'P20222376', 'AprilYandi Dwi W 376', '56419974376', '3276010023376', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231376', 'Kp,Babakan No. 376', 'Islam', 8, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(377, 3, 'P20223377', 'AprilYandi Dwi W 377', '56419974377', '3276010023377', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231377', 'Kp,Babakan No. 377', 'Islam', 10, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(378, 2, 'P20222378', 'AprilYandi Dwi W 378', '56419974378', '3276010023378', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231378', 'Kp,Babakan No. 378', 'Islam', 6, 9, '1500000.00', NULL, '', '2022-12-07 13:59:04', NULL, NULL, NULL),
(379, 3, 'P20223379', 'AprilYandi Dwi W 379', '56419974379', '3276010023379', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231379', 'Kp,Babakan No. 379', 'Islam', 1, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(380, 3, 'P20223380', 'AprilYandi Dwi W 380', '56419974380', '3276010023380', 'Depok', '2001-12-04', 'Perempuan', '0851720231380', 'Kp,Babakan No. 380', 'Islam', 7, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(381, 2, 'P20222381', 'AprilYandi Dwi W 381', '56419974381', '3276010023381', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231381', 'Kp,Babakan No. 381', 'Islam', 8, 13, '1500000.00', NULL, '', '2022-12-07 13:59:04', NULL, NULL, NULL),
(382, 3, 'P20223382', 'AprilYandi Dwi W 382', '56419974382', '3276010023382', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231382', 'Kp,Babakan No. 382', 'Islam', 9, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:04', NULL, NULL, NULL),
(383, 1, 'P20221383', 'AprilYandi Dwi W 383', '56419974383', '3276010023383', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231383', 'Kp,Babakan No. 383', 'Islam', 12, 6, NULL, NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(384, 3, 'P20223384', 'AprilYandi Dwi W 384', '56419974384', '3276010023384', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231384', 'Kp,Babakan No. 384', 'Islam', 13, 1, '1500000.00', NULL, '', '2022-12-07 13:59:05', NULL, NULL, NULL),
(385, 2, 'P20222385', 'AprilYandi Dwi W 385', '56419974385', '3276010023385', 'Depok', '2001-12-22', 'Perempuan', '0851720231385', 'Kp,Babakan No. 385', 'Islam', 5, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(386, 2, 'P20222386', 'AprilYandi Dwi W 386', '56419974386', '3276010023386', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231386', 'Kp,Babakan No. 386', 'Islam', 11, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(387, 1, 'P20221387', 'AprilYandi Dwi W 387', '56419974387', '3276010023387', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231387', 'Kp,Babakan No. 387', 'Islam', 5, 2, NULL, NULL, '', '2022-12-07 13:59:05', NULL, NULL, NULL),
(388, 1, 'P20221388', 'AprilYandi Dwi W 388', '56419974388', '3276010023388', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231388', 'Kp,Babakan No. 388', 'Islam', 5, 5, NULL, NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(389, 3, 'P20223389', 'AprilYandi Dwi W 389', '56419974389', '3276010023389', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231389', 'Kp,Babakan No. 389', 'Islam', 5, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(390, 1, 'P20221390', 'AprilYandi Dwi W 390', '56419974390', '3276010023390', 'Depok', '2001-12-19', 'Perempuan', '0851720231390', 'Kp,Babakan No. 390', 'Islam', 13, 8, NULL, NULL, '', '2022-12-07 13:59:05', NULL, NULL, NULL),
(391, 1, 'P20221391', 'AprilYandi Dwi W 391', '56419974391', '3276010023391', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231391', 'Kp,Babakan No. 391', 'Islam', 7, 12, NULL, NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(392, 3, 'P20223392', 'AprilYandi Dwi W 392', '56419974392', '3276010023392', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231392', 'Kp,Babakan No. 392', 'Islam', 7, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(393, 1, 'P20221393', 'AprilYandi Dwi W 393', '56419974393', '3276010023393', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231393', 'Kp,Babakan No. 393', 'Islam', 1, 6, NULL, NULL, '', '2022-12-07 13:59:05', NULL, NULL, NULL),
(394, 2, 'P20222394', 'AprilYandi Dwi W 394', '56419974394', '3276010023394', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231394', 'Kp,Babakan No. 394', 'Islam', 6, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(395, 1, 'P20221395', 'AprilYandi Dwi W 395', '56419974395', '3276010023395', 'Depok', '2001-12-15', 'Perempuan', '0851720231395', 'Kp,Babakan No. 395', 'Islam', 4, 11, NULL, NULL, '1', '2022-12-07 13:59:05', NULL, NULL, NULL),
(396, 2, 'P20222396', 'AprilYandi Dwi W 396', '56419974396', '3276010023396', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231396', 'Kp,Babakan No. 396', 'Islam', 12, 3, '1500000.00', NULL, '', '2022-12-07 13:59:05', NULL, NULL, NULL),
(397, 3, 'P20223397', 'AprilYandi Dwi W 397', '56419974397', '3276010023397', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231397', 'Kp,Babakan No. 397', 'Islam', 12, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(398, 1, 'P20221398', 'AprilYandi Dwi W 398', '56419974398', '3276010023398', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231398', 'Kp,Babakan No. 398', 'Islam', 13, 8, NULL, NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(399, 3, 'P20223399', 'AprilYandi Dwi W 399', '56419974399', '3276010023399', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231399', 'Kp,Babakan No. 399', 'Islam', 2, 12, '1500000.00', NULL, '', '2022-12-07 13:59:06', NULL, NULL, NULL),
(400, 2, 'P20222400', 'AprilYandi Dwi W 400', '56419974400', '3276010023400', 'Depok', '2001-12-10', 'Perempuan', '0851720231400', 'Kp,Babakan No. 400', 'Islam', 4, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(401, 2, 'P20222401', 'AprilYandi Dwi W 401', '56419974401', '3276010023401', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231401', 'Kp,Babakan No. 401', 'Islam', 9, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(402, 2, 'P20222402', 'AprilYandi Dwi W 402', '56419974402', '3276010023402', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231402', 'Kp,Babakan No. 402', 'Islam', 5, 5, '1500000.00', NULL, '', '2022-12-07 13:59:06', NULL, NULL, NULL),
(403, 3, 'P20223403', 'AprilYandi Dwi W 403', '56419974403', '3276010023403', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231403', 'Kp,Babakan No. 403', 'Islam', 12, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(404, 3, 'P20223404', 'AprilYandi Dwi W 404', '56419974404', '3276010023404', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231404', 'Kp,Babakan No. 404', 'Islam', 4, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(405, 1, 'P20221405', 'AprilYandi Dwi W 405', '56419974405', '3276010023405', 'Depok', '2001-12-22', 'Perempuan', '0851720231405', 'Kp,Babakan No. 405', 'Islam', 3, 10, NULL, NULL, '', '2022-12-07 13:59:06', NULL, NULL, NULL),
(406, 2, 'P20222406', 'AprilYandi Dwi W 406', '56419974406', '3276010023406', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231406', 'Kp,Babakan No. 406', 'Islam', 12, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(407, 1, 'P20221407', 'AprilYandi Dwi W 407', '56419974407', '3276010023407', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231407', 'Kp,Babakan No. 407', 'Islam', 4, 2, NULL, NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(408, 1, 'P20221408', 'AprilYandi Dwi W 408', '56419974408', '3276010023408', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231408', 'Kp,Babakan No. 408', 'Islam', 5, 12, NULL, NULL, '', '2022-12-07 13:59:06', NULL, NULL, NULL),
(409, 1, 'P20221409', 'AprilYandi Dwi W 409', '56419974409', '3276010023409', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231409', 'Kp,Babakan No. 409', 'Islam', 6, 10, NULL, NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(410, 3, 'P20223410', 'AprilYandi Dwi W 410', '56419974410', '3276010023410', 'Depok', '2001-12-30', 'Perempuan', '0851720231410', 'Kp,Babakan No. 410', 'Islam', 7, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:06', NULL, NULL, NULL),
(411, 1, 'P20221411', 'AprilYandi Dwi W 411', '56419974411', '3276010023411', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231411', 'Kp,Babakan No. 411', 'Islam', 7, 4, NULL, NULL, '', '2022-12-07 13:59:07', NULL, NULL, NULL),
(412, 2, 'P20222412', 'AprilYandi Dwi W 412', '56419974412', '3276010023412', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231412', 'Kp,Babakan No. 412', 'Islam', 7, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:07', NULL, NULL, NULL),
(413, 3, 'P20223413', 'AprilYandi Dwi W 413', '56419974413', '3276010023413', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231413', 'Kp,Babakan No. 413', 'Islam', 5, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:07', NULL, NULL, NULL),
(414, 2, 'P20222414', 'AprilYandi Dwi W 414', '56419974414', '3276010023414', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231414', 'Kp,Babakan No. 414', 'Islam', 8, 9, '1500000.00', NULL, '', '2022-12-07 13:59:07', NULL, NULL, NULL),
(415, 3, 'P20223415', 'AprilYandi Dwi W 415', '56419974415', '3276010023415', 'Depok', '2001-12-10', 'Perempuan', '0851720231415', 'Kp,Babakan No. 415', 'Islam', 8, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:07', NULL, NULL, NULL),
(416, 3, 'P20223416', 'AprilYandi Dwi W 416', '56419974416', '3276010023416', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231416', 'Kp,Babakan No. 416', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:07', NULL, NULL, NULL),
(417, 1, 'P20221417', 'AprilYandi Dwi W 417', '56419974417', '3276010023417', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231417', 'Kp,Babakan No. 417', 'Islam', 11, 11, NULL, NULL, '', '2022-12-07 13:59:07', NULL, NULL, NULL),
(418, 1, 'P20221418', 'AprilYandi Dwi W 418', '56419974418', '3276010023418', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231418', 'Kp,Babakan No. 418', 'Islam', 12, 2, NULL, NULL, '1', '2022-12-07 13:59:07', NULL, NULL, NULL),
(419, 3, 'P20223419', 'AprilYandi Dwi W 419', '56419974419', '3276010023419', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231419', 'Kp,Babakan No. 419', 'Islam', 5, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:07', NULL, NULL, NULL),
(420, 3, 'P20223420', 'AprilYandi Dwi W 420', '56419974420', '3276010023420', 'Depok', '2001-12-09', 'Perempuan', '0851720231420', 'Kp,Babakan No. 420', 'Islam', 9, 6, '1500000.00', NULL, '', '2022-12-07 13:59:08', NULL, NULL, NULL),
(421, 3, 'P20223421', 'AprilYandi Dwi W 421', '56419974421', '3276010023421', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231421', 'Kp,Babakan No. 421', 'Islam', 1, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:08', NULL, NULL, NULL),
(422, 2, 'P20222422', 'AprilYandi Dwi W 422', '56419974422', '3276010023422', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231422', 'Kp,Babakan No. 422', 'Islam', 10, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:08', NULL, NULL, NULL),
(423, 1, 'P20221423', 'AprilYandi Dwi W 423', '56419974423', '3276010023423', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231423', 'Kp,Babakan No. 423', 'Islam', 2, 4, NULL, NULL, '', '2022-12-07 13:59:08', NULL, NULL, NULL),
(424, 3, 'P20223424', 'AprilYandi Dwi W 424', '56419974424', '3276010023424', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231424', 'Kp,Babakan No. 424', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:08', NULL, NULL, NULL),
(425, 3, 'P20223425', 'AprilYandi Dwi W 425', '56419974425', '3276010023425', 'Depok', '2001-12-29', 'Perempuan', '0851720231425', 'Kp,Babakan No. 425', 'Islam', 7, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:08', NULL, NULL, NULL),
(426, 2, 'P20222426', 'AprilYandi Dwi W 426', '56419974426', '3276010023426', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231426', 'Kp,Babakan No. 426', 'Islam', 11, 3, '1500000.00', NULL, '', '2022-12-07 13:59:08', NULL, NULL, NULL),
(427, 2, 'P20222427', 'AprilYandi Dwi W 427', '56419974427', '3276010023427', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231427', 'Kp,Babakan No. 427', 'Islam', 6, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:09', NULL, NULL, NULL),
(428, 3, 'P20223428', 'AprilYandi Dwi W 428', '56419974428', '3276010023428', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231428', 'Kp,Babakan No. 428', 'Islam', 4, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:09', NULL, NULL, NULL),
(429, 2, 'P20222429', 'AprilYandi Dwi W 429', '56419974429', '3276010023429', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231429', 'Kp,Babakan No. 429', 'Islam', 11, 5, '1500000.00', NULL, '', '2022-12-07 13:59:09', NULL, NULL, NULL),
(430, 2, 'P20222430', 'AprilYandi Dwi W 430', '56419974430', '3276010023430', 'Depok', '2001-12-13', 'Perempuan', '0851720231430', 'Kp,Babakan No. 430', 'Islam', 1, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:09', NULL, NULL, NULL),
(431, 3, 'P20223431', 'AprilYandi Dwi W 431', '56419974431', '3276010023431', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231431', 'Kp,Babakan No. 431', 'Islam', 5, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:09', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(432, 2, 'P20222432', 'AprilYandi Dwi W 432', '56419974432', '3276010023432', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231432', 'Kp,Babakan No. 432', 'Islam', 1, 13, '1500000.00', NULL, '', '2022-12-07 13:59:09', NULL, NULL, NULL),
(433, 1, 'P20221433', 'AprilYandi Dwi W 433', '56419974433', '3276010023433', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231433', 'Kp,Babakan No. 433', 'Islam', 1, 4, NULL, NULL, '1', '2022-12-07 13:59:09', NULL, NULL, NULL),
(434, 1, 'P20221434', 'AprilYandi Dwi W 434', '56419974434', '3276010023434', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231434', 'Kp,Babakan No. 434', 'Islam', 11, 6, NULL, NULL, '1', '2022-12-07 13:59:09', NULL, NULL, NULL),
(435, 2, 'P20222435', 'AprilYandi Dwi W 435', '56419974435', '3276010023435', 'Depok', '2001-12-27', 'Perempuan', '0851720231435', 'Kp,Babakan No. 435', 'Islam', 10, 10, '1500000.00', NULL, '', '2022-12-07 13:59:10', NULL, NULL, NULL),
(436, 2, 'P20222436', 'AprilYandi Dwi W 436', '56419974436', '3276010023436', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231436', 'Kp,Babakan No. 436', 'Islam', 8, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:10', NULL, NULL, NULL),
(437, 3, 'P20223437', 'AprilYandi Dwi W 437', '56419974437', '3276010023437', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231437', 'Kp,Babakan No. 437', 'Islam', 11, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:11', NULL, NULL, NULL),
(438, 2, 'P20222438', 'AprilYandi Dwi W 438', '56419974438', '3276010023438', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231438', 'Kp,Babakan No. 438', 'Islam', 2, 4, '1500000.00', NULL, '', '2022-12-07 13:59:11', NULL, NULL, NULL),
(439, 1, 'P20221439', 'AprilYandi Dwi W 439', '56419974439', '3276010023439', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231439', 'Kp,Babakan No. 439', 'Islam', 7, 9, NULL, NULL, '1', '2022-12-07 13:59:11', NULL, NULL, NULL),
(440, 3, 'P20223440', 'AprilYandi Dwi W 440', '56419974440', '3276010023440', 'Depok', '2001-12-03', 'Perempuan', '0851720231440', 'Kp,Babakan No. 440', 'Islam', 7, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:11', NULL, NULL, NULL),
(441, 3, 'P20223441', 'AprilYandi Dwi W 441', '56419974441', '3276010023441', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231441', 'Kp,Babakan No. 441', 'Islam', 8, 3, '1500000.00', NULL, '', '2022-12-07 13:59:11', NULL, NULL, NULL),
(442, 2, 'P20222442', 'AprilYandi Dwi W 442', '56419974442', '3276010023442', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231442', 'Kp,Babakan No. 442', 'Islam', 3, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:11', NULL, NULL, NULL),
(443, 3, 'P20223443', 'AprilYandi Dwi W 443', '56419974443', '3276010023443', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231443', 'Kp,Babakan No. 443', 'Islam', 5, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:12', NULL, NULL, NULL),
(444, 1, 'P20221444', 'AprilYandi Dwi W 444', '56419974444', '3276010023444', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231444', 'Kp,Babakan No. 444', 'Islam', 6, 4, NULL, NULL, '', '2022-12-07 13:59:12', NULL, NULL, NULL),
(445, 2, 'P20222445', 'AprilYandi Dwi W 445', '56419974445', '3276010023445', 'Depok', '2001-12-26', 'Perempuan', '0851720231445', 'Kp,Babakan No. 445', 'Islam', 10, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:12', NULL, NULL, NULL),
(446, 1, 'P20221446', 'AprilYandi Dwi W 446', '56419974446', '3276010023446', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231446', 'Kp,Babakan No. 446', 'Islam', 1, 4, NULL, NULL, '1', '2022-12-07 13:59:12', NULL, NULL, NULL),
(447, 2, 'P20222447', 'AprilYandi Dwi W 447', '56419974447', '3276010023447', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231447', 'Kp,Babakan No. 447', 'Islam', 3, 13, '1500000.00', NULL, '', '2022-12-07 13:59:12', NULL, NULL, NULL),
(448, 3, 'P20223448', 'AprilYandi Dwi W 448', '56419974448', '3276010023448', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231448', 'Kp,Babakan No. 448', 'Islam', 11, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:12', NULL, NULL, NULL),
(449, 3, 'P20223449', 'AprilYandi Dwi W 449', '56419974449', '3276010023449', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231449', 'Kp,Babakan No. 449', 'Islam', 4, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:13', NULL, NULL, NULL),
(450, 1, 'P20221450', 'AprilYandi Dwi W 450', '56419974450', '3276010023450', 'Depok', '2001-12-22', 'Perempuan', '0851720231450', 'Kp,Babakan No. 450', 'Islam', 7, 11, NULL, NULL, '', '2022-12-07 13:59:13', NULL, NULL, NULL),
(451, 1, 'P20221451', 'AprilYandi Dwi W 451', '56419974451', '3276010023451', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231451', 'Kp,Babakan No. 451', 'Islam', 10, 1, NULL, NULL, '1', '2022-12-07 13:59:13', NULL, NULL, NULL),
(452, 1, 'P20221452', 'AprilYandi Dwi W 452', '56419974452', '3276010023452', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231452', 'Kp,Babakan No. 452', 'Islam', 7, 6, NULL, NULL, '1', '2022-12-07 13:59:13', NULL, NULL, NULL),
(453, 3, 'P20223453', 'AprilYandi Dwi W 453', '56419974453', '3276010023453', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231453', 'Kp,Babakan No. 453', 'Islam', 12, 9, '1500000.00', NULL, '', '2022-12-07 13:59:13', NULL, NULL, NULL),
(454, 2, 'P20222454', 'AprilYandi Dwi W 454', '56419974454', '3276010023454', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231454', 'Kp,Babakan No. 454', 'Islam', 7, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:13', NULL, NULL, NULL),
(455, 1, 'P20221455', 'AprilYandi Dwi W 455', '56419974455', '3276010023455', 'Depok', '2001-12-09', 'Perempuan', '0851720231455', 'Kp,Babakan No. 455', 'Islam', 6, 12, NULL, NULL, '1', '2022-12-07 13:59:13', NULL, NULL, NULL),
(456, 1, 'P20221456', 'AprilYandi Dwi W 456', '56419974456', '3276010023456', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231456', 'Kp,Babakan No. 456', 'Islam', 9, 6, NULL, NULL, '', '2022-12-07 13:59:13', NULL, NULL, NULL),
(457, 2, 'P20222457', 'AprilYandi Dwi W 457', '56419974457', '3276010023457', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231457', 'Kp,Babakan No. 457', 'Islam', 10, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:14', NULL, NULL, NULL),
(458, 3, 'P20223458', 'AprilYandi Dwi W 458', '56419974458', '3276010023458', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231458', 'Kp,Babakan No. 458', 'Islam', 1, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:14', NULL, NULL, NULL),
(459, 1, 'P20221459', 'AprilYandi Dwi W 459', '56419974459', '3276010023459', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231459', 'Kp,Babakan No. 459', 'Islam', 5, 1, NULL, NULL, '', '2022-12-07 13:59:14', NULL, NULL, NULL),
(460, 3, 'P20223460', 'AprilYandi Dwi W 460', '56419974460', '3276010023460', 'Depok', '2001-12-02', 'Perempuan', '0851720231460', 'Kp,Babakan No. 460', 'Islam', 5, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:14', NULL, NULL, NULL),
(461, 3, 'P20223461', 'AprilYandi Dwi W 461', '56419974461', '3276010023461', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231461', 'Kp,Babakan No. 461', 'Islam', 2, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:14', NULL, NULL, NULL),
(462, 3, 'P20223462', 'AprilYandi Dwi W 462', '56419974462', '3276010023462', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231462', 'Kp,Babakan No. 462', 'Islam', 2, 10, '1500000.00', NULL, '', '2022-12-07 13:59:14', NULL, NULL, NULL),
(463, 1, 'P20221463', 'AprilYandi Dwi W 463', '56419974463', '3276010023463', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231463', 'Kp,Babakan No. 463', 'Islam', 10, 8, NULL, NULL, '1', '2022-12-07 13:59:14', NULL, NULL, NULL),
(464, 3, 'P20223464', 'AprilYandi Dwi W 464', '56419974464', '3276010023464', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231464', 'Kp,Babakan No. 464', 'Islam', 8, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:14', NULL, NULL, NULL),
(465, 3, 'P20223465', 'AprilYandi Dwi W 465', '56419974465', '3276010023465', 'Depok', '2001-12-06', 'Perempuan', '0851720231465', 'Kp,Babakan No. 465', 'Islam', 2, 12, '1500000.00', NULL, '', '2022-12-07 13:59:15', NULL, NULL, NULL),
(466, 2, 'P20222466', 'AprilYandi Dwi W 466', '56419974466', '3276010023466', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231466', 'Kp,Babakan No. 466', 'Islam', 5, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:15', NULL, NULL, NULL),
(467, 1, 'P20221467', 'AprilYandi Dwi W 467', '56419974467', '3276010023467', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231467', 'Kp,Babakan No. 467', 'Islam', 6, 4, NULL, NULL, '1', '2022-12-07 13:59:15', NULL, NULL, NULL),
(468, 1, 'P20221468', 'AprilYandi Dwi W 468', '56419974468', '3276010023468', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231468', 'Kp,Babakan No. 468', 'Islam', 12, 1, NULL, NULL, '', '2022-12-07 13:59:15', NULL, NULL, NULL),
(469, 3, 'P20223469', 'AprilYandi Dwi W 469', '56419974469', '3276010023469', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231469', 'Kp,Babakan No. 469', 'Islam', 3, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:15', NULL, NULL, NULL),
(470, 2, 'P20222470', 'AprilYandi Dwi W 470', '56419974470', '3276010023470', 'Depok', '2001-12-11', 'Perempuan', '0851720231470', 'Kp,Babakan No. 470', 'Islam', 5, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:15', NULL, NULL, NULL),
(471, 2, 'P20222471', 'AprilYandi Dwi W 471', '56419974471', '3276010023471', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231471', 'Kp,Babakan No. 471', 'Islam', 4, 3, '1500000.00', NULL, '', '2022-12-07 13:59:15', NULL, NULL, NULL),
(472, 2, 'P20222472', 'AprilYandi Dwi W 472', '56419974472', '3276010023472', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231472', 'Kp,Babakan No. 472', 'Islam', 9, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:15', NULL, NULL, NULL),
(473, 2, 'P20222473', 'AprilYandi Dwi W 473', '56419974473', '3276010023473', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231473', 'Kp,Babakan No. 473', 'Islam', 13, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:15', NULL, NULL, NULL),
(474, 3, 'P20223474', 'AprilYandi Dwi W 474', '56419974474', '3276010023474', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231474', 'Kp,Babakan No. 474', 'Islam', 2, 10, '1500000.00', NULL, '', '2022-12-07 13:59:16', NULL, NULL, NULL),
(475, 1, 'P20221475', 'AprilYandi Dwi W 475', '56419974475', '3276010023475', 'Depok', '2001-12-04', 'Perempuan', '0851720231475', 'Kp,Babakan No. 475', 'Islam', 1, 8, NULL, NULL, '1', '2022-12-07 13:59:16', NULL, NULL, NULL),
(476, 2, 'P20222476', 'AprilYandi Dwi W 476', '56419974476', '3276010023476', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231476', 'Kp,Babakan No. 476', 'Islam', 12, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:16', NULL, NULL, NULL),
(477, 2, 'P20222477', 'AprilYandi Dwi W 477', '56419974477', '3276010023477', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231477', 'Kp,Babakan No. 477', 'Islam', 13, 3, '1500000.00', NULL, '', '2022-12-07 13:59:16', NULL, NULL, NULL),
(478, 1, 'P20221478', 'AprilYandi Dwi W 478', '56419974478', '3276010023478', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231478', 'Kp,Babakan No. 478', 'Islam', 3, 5, NULL, NULL, '1', '2022-12-07 13:59:16', NULL, NULL, NULL),
(479, 3, 'P20223479', 'AprilYandi Dwi W 479', '56419974479', '3276010023479', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231479', 'Kp,Babakan No. 479', 'Islam', 5, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:16', NULL, NULL, NULL),
(480, 2, 'P20222480', 'AprilYandi Dwi W 480', '56419974480', '3276010023480', 'Depok', '2001-12-23', 'Perempuan', '0851720231480', 'Kp,Babakan No. 480', 'Islam', 1, 10, '1500000.00', NULL, '', '2022-12-07 13:59:17', NULL, NULL, NULL),
(481, 2, 'P20222481', 'AprilYandi Dwi W 481', '56419974481', '3276010023481', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231481', 'Kp,Babakan No. 481', 'Islam', 2, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:17', NULL, NULL, NULL),
(482, 2, 'P20222482', 'AprilYandi Dwi W 482', '56419974482', '3276010023482', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231482', 'Kp,Babakan No. 482', 'Islam', 4, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:18', NULL, NULL, NULL),
(483, 2, 'P20222483', 'AprilYandi Dwi W 483', '56419974483', '3276010023483', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231483', 'Kp,Babakan No. 483', 'Islam', 4, 9, '1500000.00', NULL, '', '2022-12-07 13:59:18', NULL, NULL, NULL),
(484, 2, 'P20222484', 'AprilYandi Dwi W 484', '56419974484', '3276010023484', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231484', 'Kp,Babakan No. 484', 'Islam', 12, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:18', NULL, NULL, NULL),
(485, 1, 'P20221485', 'AprilYandi Dwi W 485', '56419974485', '3276010023485', 'Depok', '2001-12-23', 'Perempuan', '0851720231485', 'Kp,Babakan No. 485', 'Islam', 9, 10, NULL, NULL, '1', '2022-12-07 13:59:18', NULL, NULL, NULL),
(486, 1, 'P20221486', 'AprilYandi Dwi W 486', '56419974486', '3276010023486', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231486', 'Kp,Babakan No. 486', 'Islam', 5, 2, NULL, NULL, '', '2022-12-07 13:59:19', NULL, NULL, NULL),
(487, 1, 'P20221487', 'AprilYandi Dwi W 487', '56419974487', '3276010023487', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231487', 'Kp,Babakan No. 487', 'Islam', 7, 13, NULL, NULL, '1', '2022-12-07 13:59:19', NULL, NULL, NULL),
(488, 2, 'P20222488', 'AprilYandi Dwi W 488', '56419974488', '3276010023488', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231488', 'Kp,Babakan No. 488', 'Islam', 13, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:19', NULL, NULL, NULL),
(489, 1, 'P20221489', 'AprilYandi Dwi W 489', '56419974489', '3276010023489', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231489', 'Kp,Babakan No. 489', 'Islam', 6, 1, NULL, NULL, '', '2022-12-07 13:59:19', NULL, NULL, NULL),
(490, 3, 'P20223490', 'AprilYandi Dwi W 490', '56419974490', '3276010023490', 'Depok', '2001-12-15', 'Perempuan', '0851720231490', 'Kp,Babakan No. 490', 'Islam', 8, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:19', NULL, NULL, NULL),
(491, 1, 'P20221491', 'AprilYandi Dwi W 491', '56419974491', '3276010023491', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231491', 'Kp,Babakan No. 491', 'Islam', 5, 1, NULL, NULL, '1', '2022-12-07 13:59:19', NULL, NULL, NULL),
(492, 3, 'P20223492', 'AprilYandi Dwi W 492', '56419974492', '3276010023492', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231492', 'Kp,Babakan No. 492', 'Islam', 12, 12, '1500000.00', NULL, '', '2022-12-07 13:59:20', NULL, NULL, NULL),
(493, 2, 'P20222493', 'AprilYandi Dwi W 493', '56419974493', '3276010023493', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231493', 'Kp,Babakan No. 493', 'Islam', 8, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:20', NULL, NULL, NULL),
(494, 2, 'P20222494', 'AprilYandi Dwi W 494', '56419974494', '3276010023494', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231494', 'Kp,Babakan No. 494', 'Islam', 8, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:20', NULL, NULL, NULL),
(495, 1, 'P20221495', 'AprilYandi Dwi W 495', '56419974495', '3276010023495', 'Depok', '2001-12-21', 'Perempuan', '0851720231495', 'Kp,Babakan No. 495', 'Islam', 9, 1, NULL, NULL, '', '2022-12-07 13:59:20', NULL, NULL, NULL),
(496, 1, 'P20221496', 'AprilYandi Dwi W 496', '56419974496', '3276010023496', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231496', 'Kp,Babakan No. 496', 'Islam', 2, 7, NULL, NULL, '1', '2022-12-07 13:59:20', NULL, NULL, NULL),
(497, 3, 'P20223497', 'AprilYandi Dwi W 497', '56419974497', '3276010023497', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231497', 'Kp,Babakan No. 497', 'Islam', 13, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:20', NULL, NULL, NULL),
(498, 2, 'P20222498', 'AprilYandi Dwi W 498', '56419974498', '3276010023498', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231498', 'Kp,Babakan No. 498', 'Islam', 2, 12, '1500000.00', NULL, '', '2022-12-07 13:59:21', NULL, NULL, NULL),
(499, 2, 'P20222499', 'AprilYandi Dwi W 499', '56419974499', '3276010023499', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231499', 'Kp,Babakan No. 499', 'Islam', 4, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:21', NULL, NULL, NULL),
(500, 1, 'P20221500', 'AprilYandi Dwi W 500', '56419974500', '3276010023500', 'Depok', '2001-12-16', 'Perempuan', '0851720231500', 'Kp,Babakan No. 500', 'Islam', 3, 1, NULL, NULL, '1', '2022-12-07 13:59:21', NULL, NULL, NULL),
(501, 1, 'P20221501', 'AprilYandi Dwi W 501', '56419974501', '3276010023501', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231501', 'Kp,Babakan No. 501', 'Islam', 7, 9, NULL, NULL, '', '2022-12-07 13:59:21', NULL, NULL, NULL),
(502, 1, 'P20221502', 'AprilYandi Dwi W 502', '56419974502', '3276010023502', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231502', 'Kp,Babakan No. 502', 'Islam', 6, 2, NULL, NULL, '1', '2022-12-07 13:59:21', NULL, NULL, NULL),
(503, 1, 'P20221503', 'AprilYandi Dwi W 503', '56419974503', '3276010023503', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231503', 'Kp,Babakan No. 503', 'Islam', 1, 11, NULL, NULL, '1', '2022-12-07 13:59:21', NULL, NULL, NULL),
(504, 2, 'P20222504', 'AprilYandi Dwi W 504', '56419974504', '3276010023504', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231504', 'Kp,Babakan No. 504', 'Islam', 13, 3, '1500000.00', NULL, '', '2022-12-07 13:59:21', NULL, NULL, NULL),
(505, 3, 'P20223505', 'AprilYandi Dwi W 505', '56419974505', '3276010023505', 'Depok', '2001-12-29', 'Perempuan', '0851720231505', 'Kp,Babakan No. 505', 'Islam', 6, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:21', NULL, NULL, NULL),
(506, 1, 'P20221506', 'AprilYandi Dwi W 506', '56419974506', '3276010023506', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231506', 'Kp,Babakan No. 506', 'Islam', 13, 13, NULL, NULL, '1', '2022-12-07 13:59:21', NULL, NULL, NULL),
(507, 2, 'P20222507', 'AprilYandi Dwi W 507', '56419974507', '3276010023507', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231507', 'Kp,Babakan No. 507', 'Islam', 11, 5, '1500000.00', NULL, '', '2022-12-07 13:59:22', NULL, NULL, NULL),
(508, 2, 'P20222508', 'AprilYandi Dwi W 508', '56419974508', '3276010023508', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231508', 'Kp,Babakan No. 508', 'Islam', 10, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:22', NULL, NULL, NULL),
(509, 1, 'P20221509', 'AprilYandi Dwi W 509', '56419974509', '3276010023509', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231509', 'Kp,Babakan No. 509', 'Islam', 6, 7, NULL, NULL, '1', '2022-12-07 13:59:22', NULL, NULL, NULL),
(510, 2, 'P20222510', 'AprilYandi Dwi W 510', '56419974510', '3276010023510', 'Depok', '2001-12-09', 'Perempuan', '0851720231510', 'Kp,Babakan No. 510', 'Islam', 6, 4, '1500000.00', NULL, '', '2022-12-07 13:59:22', NULL, NULL, NULL),
(511, 3, 'P20223511', 'AprilYandi Dwi W 511', '56419974511', '3276010023511', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231511', 'Kp,Babakan No. 511', 'Islam', 13, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:22', NULL, NULL, NULL),
(512, 3, 'P20223512', 'AprilYandi Dwi W 512', '56419974512', '3276010023512', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231512', 'Kp,Babakan No. 512', 'Islam', 12, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:22', NULL, NULL, NULL),
(513, 1, 'P20221513', 'AprilYandi Dwi W 513', '56419974513', '3276010023513', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231513', 'Kp,Babakan No. 513', 'Islam', 10, 12, NULL, NULL, '', '2022-12-07 13:59:22', NULL, NULL, NULL),
(514, 3, 'P20223514', 'AprilYandi Dwi W 514', '56419974514', '3276010023514', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231514', 'Kp,Babakan No. 514', 'Islam', 6, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:23', NULL, NULL, NULL),
(515, 3, 'P20223515', 'AprilYandi Dwi W 515', '56419974515', '3276010023515', 'Depok', '2001-12-07', 'Perempuan', '0851720231515', 'Kp,Babakan No. 515', 'Islam', 10, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:23', NULL, NULL, NULL),
(516, 1, 'P20221516', 'AprilYandi Dwi W 516', '56419974516', '3276010023516', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231516', 'Kp,Babakan No. 516', 'Islam', 11, 4, NULL, NULL, '', '2022-12-07 13:59:23', NULL, NULL, NULL),
(517, 2, 'P20222517', 'AprilYandi Dwi W 517', '56419974517', '3276010023517', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231517', 'Kp,Babakan No. 517', 'Islam', 4, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:23', NULL, NULL, NULL),
(518, 1, 'P20221518', 'AprilYandi Dwi W 518', '56419974518', '3276010023518', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231518', 'Kp,Babakan No. 518', 'Islam', 1, 10, NULL, NULL, '1', '2022-12-07 13:59:23', NULL, NULL, NULL),
(519, 3, 'P20223519', 'AprilYandi Dwi W 519', '56419974519', '3276010023519', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231519', 'Kp,Babakan No. 519', 'Islam', 13, 6, '1500000.00', NULL, '', '2022-12-07 13:59:24', NULL, NULL, NULL),
(520, 1, 'P20221520', 'AprilYandi Dwi W 520', '56419974520', '3276010023520', 'Depok', '2001-12-09', 'Perempuan', '0851720231520', 'Kp,Babakan No. 520', 'Islam', 8, 10, NULL, NULL, '1', '2022-12-07 13:59:24', NULL, NULL, NULL),
(521, 3, 'P20223521', 'AprilYandi Dwi W 521', '56419974521', '3276010023521', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231521', 'Kp,Babakan No. 521', 'Islam', 3, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:24', NULL, NULL, NULL),
(522, 2, 'P20222522', 'AprilYandi Dwi W 522', '56419974522', '3276010023522', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231522', 'Kp,Babakan No. 522', 'Islam', 7, 8, '1500000.00', NULL, '', '2022-12-07 13:59:24', NULL, NULL, NULL),
(523, 2, 'P20222523', 'AprilYandi Dwi W 523', '56419974523', '3276010023523', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231523', 'Kp,Babakan No. 523', 'Islam', 5, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:24', NULL, NULL, NULL),
(524, 3, 'P20223524', 'AprilYandi Dwi W 524', '56419974524', '3276010023524', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231524', 'Kp,Babakan No. 524', 'Islam', 8, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:24', NULL, NULL, NULL),
(525, 2, 'P20222525', 'AprilYandi Dwi W 525', '56419974525', '3276010023525', 'Depok', '2001-12-13', 'Perempuan', '0851720231525', 'Kp,Babakan No. 525', 'Islam', 12, 3, '1500000.00', NULL, '', '2022-12-07 13:59:25', NULL, NULL, NULL),
(526, 3, 'P20223526', 'AprilYandi Dwi W 526', '56419974526', '3276010023526', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231526', 'Kp,Babakan No. 526', 'Islam', 12, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:25', NULL, NULL, NULL),
(527, 1, 'P20221527', 'AprilYandi Dwi W 527', '56419974527', '3276010023527', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231527', 'Kp,Babakan No. 527', 'Islam', 9, 12, NULL, NULL, '1', '2022-12-07 13:59:25', NULL, NULL, NULL),
(528, 2, 'P20222528', 'AprilYandi Dwi W 528', '56419974528', '3276010023528', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231528', 'Kp,Babakan No. 528', 'Islam', 3, 4, '1500000.00', NULL, '', '2022-12-07 13:59:25', NULL, NULL, NULL),
(529, 3, 'P20223529', 'AprilYandi Dwi W 529', '56419974529', '3276010023529', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231529', 'Kp,Babakan No. 529', 'Islam', 3, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:25', NULL, NULL, NULL),
(530, 3, 'P20223530', 'AprilYandi Dwi W 530', '56419974530', '3276010023530', 'Depok', '2001-12-14', 'Perempuan', '0851720231530', 'Kp,Babakan No. 530', 'Islam', 9, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:25', NULL, NULL, NULL),
(531, 1, 'P20221531', 'AprilYandi Dwi W 531', '56419974531', '3276010023531', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231531', 'Kp,Babakan No. 531', 'Islam', 11, 9, NULL, NULL, '', '2022-12-07 13:59:25', NULL, NULL, NULL),
(532, 3, 'P20223532', 'AprilYandi Dwi W 532', '56419974532', '3276010023532', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231532', 'Kp,Babakan No. 532', 'Islam', 2, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:25', NULL, NULL, NULL),
(533, 3, 'P20223533', 'AprilYandi Dwi W 533', '56419974533', '3276010023533', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231533', 'Kp,Babakan No. 533', 'Islam', 5, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:25', NULL, NULL, NULL),
(534, 1, 'P20221534', 'AprilYandi Dwi W 534', '56419974534', '3276010023534', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231534', 'Kp,Babakan No. 534', 'Islam', 3, 10, NULL, NULL, '', '2022-12-07 13:59:25', NULL, NULL, NULL),
(535, 3, 'P20223535', 'AprilYandi Dwi W 535', '56419974535', '3276010023535', 'Depok', '2001-12-20', 'Perempuan', '0851720231535', 'Kp,Babakan No. 535', 'Islam', 13, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:26', NULL, NULL, NULL),
(536, 2, 'P20222536', 'AprilYandi Dwi W 536', '56419974536', '3276010023536', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231536', 'Kp,Babakan No. 536', 'Islam', 13, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:26', NULL, NULL, NULL),
(537, 2, 'P20222537', 'AprilYandi Dwi W 537', '56419974537', '3276010023537', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231537', 'Kp,Babakan No. 537', 'Islam', 4, 13, '1500000.00', NULL, '', '2022-12-07 13:59:26', NULL, NULL, NULL),
(538, 2, 'P20222538', 'AprilYandi Dwi W 538', '56419974538', '3276010023538', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231538', 'Kp,Babakan No. 538', 'Islam', 13, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(539, 3, 'P20223539', 'AprilYandi Dwi W 539', '56419974539', '3276010023539', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231539', 'Kp,Babakan No. 539', 'Islam', 13, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(540, 2, 'P20222540', 'AprilYandi Dwi W 540', '56419974540', '3276010023540', 'Depok', '2001-12-02', 'Perempuan', '0851720231540', 'Kp,Babakan No. 540', 'Islam', 6, 2, '1500000.00', NULL, '', '2022-12-07 13:59:27', NULL, NULL, NULL),
(541, 2, 'P20222541', 'AprilYandi Dwi W 541', '56419974541', '3276010023541', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231541', 'Kp,Babakan No. 541', 'Islam', 3, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(542, 3, 'P20223542', 'AprilYandi Dwi W 542', '56419974542', '3276010023542', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231542', 'Kp,Babakan No. 542', 'Islam', 8, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(543, 3, 'P20223543', 'AprilYandi Dwi W 543', '56419974543', '3276010023543', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231543', 'Kp,Babakan No. 543', 'Islam', 4, 8, '1500000.00', NULL, '', '2022-12-07 13:59:27', NULL, NULL, NULL),
(544, 3, 'P20223544', 'AprilYandi Dwi W 544', '56419974544', '3276010023544', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231544', 'Kp,Babakan No. 544', 'Islam', 10, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(545, 1, 'P20221545', 'AprilYandi Dwi W 545', '56419974545', '3276010023545', 'Depok', '2001-12-05', 'Perempuan', '0851720231545', 'Kp,Babakan No. 545', 'Islam', 7, 13, NULL, NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(546, 2, 'P20222546', 'AprilYandi Dwi W 546', '56419974546', '3276010023546', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231546', 'Kp,Babakan No. 546', 'Islam', 13, 9, '1500000.00', NULL, '', '2022-12-07 13:59:27', NULL, NULL, NULL),
(547, 2, 'P20222547', 'AprilYandi Dwi W 547', '56419974547', '3276010023547', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231547', 'Kp,Babakan No. 547', 'Islam', 7, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(548, 3, 'P20223548', 'AprilYandi Dwi W 548', '56419974548', '3276010023548', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231548', 'Kp,Babakan No. 548', 'Islam', 6, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:27', NULL, NULL, NULL),
(549, 2, 'P20222549', 'AprilYandi Dwi W 549', '56419974549', '3276010023549', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231549', 'Kp,Babakan No. 549', 'Islam', 8, 6, '1500000.00', NULL, '', '2022-12-07 13:59:28', NULL, NULL, NULL),
(550, 2, 'P20222550', 'AprilYandi Dwi W 550', '56419974550', '3276010023550', 'Depok', '2001-12-05', 'Perempuan', '0851720231550', 'Kp,Babakan No. 550', 'Islam', 2, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(551, 1, 'P20221551', 'AprilYandi Dwi W 551', '56419974551', '3276010023551', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231551', 'Kp,Babakan No. 551', 'Islam', 8, 8, NULL, NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(552, 1, 'P20221552', 'AprilYandi Dwi W 552', '56419974552', '3276010023552', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231552', 'Kp,Babakan No. 552', 'Islam', 3, 10, NULL, NULL, '', '2022-12-07 13:59:28', NULL, NULL, NULL),
(553, 3, 'P20223553', 'AprilYandi Dwi W 553', '56419974553', '3276010023553', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231553', 'Kp,Babakan No. 553', 'Islam', 7, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(554, 2, 'P20222554', 'AprilYandi Dwi W 554', '56419974554', '3276010023554', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231554', 'Kp,Babakan No. 554', 'Islam', 1, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(555, 1, 'P20221555', 'AprilYandi Dwi W 555', '56419974555', '3276010023555', 'Depok', '2001-12-30', 'Perempuan', '0851720231555', 'Kp,Babakan No. 555', 'Islam', 6, 8, NULL, NULL, '', '2022-12-07 13:59:28', NULL, NULL, NULL),
(556, 3, 'P20223556', 'AprilYandi Dwi W 556', '56419974556', '3276010023556', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231556', 'Kp,Babakan No. 556', 'Islam', 5, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(557, 1, 'P20221557', 'AprilYandi Dwi W 557', '56419974557', '3276010023557', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231557', 'Kp,Babakan No. 557', 'Islam', 13, 6, NULL, NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(558, 2, 'P20222558', 'AprilYandi Dwi W 558', '56419974558', '3276010023558', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231558', 'Kp,Babakan No. 558', 'Islam', 1, 11, '1500000.00', NULL, '', '2022-12-07 13:59:28', NULL, NULL, NULL),
(559, 1, 'P20221559', 'AprilYandi Dwi W 559', '56419974559', '3276010023559', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231559', 'Kp,Babakan No. 559', 'Islam', 2, 3, NULL, NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(560, 3, 'P20223560', 'AprilYandi Dwi W 560', '56419974560', '3276010023560', 'Depok', '2001-12-05', 'Perempuan', '0851720231560', 'Kp,Babakan No. 560', 'Islam', 3, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:28', NULL, NULL, NULL),
(561, 1, 'P20221561', 'AprilYandi Dwi W 561', '56419974561', '3276010023561', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231561', 'Kp,Babakan No. 561', 'Islam', 4, 9, NULL, NULL, '', '2022-12-07 13:59:29', NULL, NULL, NULL),
(562, 1, 'P20221562', 'AprilYandi Dwi W 562', '56419974562', '3276010023562', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231562', 'Kp,Babakan No. 562', 'Islam', 5, 12, NULL, NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(563, 3, 'P20223563', 'AprilYandi Dwi W 563', '56419974563', '3276010023563', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231563', 'Kp,Babakan No. 563', 'Islam', 5, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(564, 2, 'P20222564', 'AprilYandi Dwi W 564', '56419974564', '3276010023564', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231564', 'Kp,Babakan No. 564', 'Islam', 11, 2, '1500000.00', NULL, '', '2022-12-07 13:59:29', NULL, NULL, NULL),
(565, 3, 'P20223565', 'AprilYandi Dwi W 565', '56419974565', '3276010023565', 'Depok', '2001-12-08', 'Perempuan', '0851720231565', 'Kp,Babakan No. 565', 'Islam', 13, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(566, 3, 'P20223566', 'AprilYandi Dwi W 566', '56419974566', '3276010023566', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231566', 'Kp,Babakan No. 566', 'Islam', 1, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(567, 2, 'P20222567', 'AprilYandi Dwi W 567', '56419974567', '3276010023567', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231567', 'Kp,Babakan No. 567', 'Islam', 11, 4, '1500000.00', NULL, '', '2022-12-07 13:59:29', NULL, NULL, NULL),
(568, 1, 'P20221568', 'AprilYandi Dwi W 568', '56419974568', '3276010023568', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231568', 'Kp,Babakan No. 568', 'Islam', 6, 9, NULL, NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(569, 2, 'P20222569', 'AprilYandi Dwi W 569', '56419974569', '3276010023569', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231569', 'Kp,Babakan No. 569', 'Islam', 8, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(570, 1, 'P20221570', 'AprilYandi Dwi W 570', '56419974570', '3276010023570', 'Depok', '2001-12-30', 'Perempuan', '0851720231570', 'Kp,Babakan No. 570', 'Islam', 9, 6, NULL, NULL, '', '2022-12-07 13:59:29', NULL, NULL, NULL),
(571, 2, 'P20222571', 'AprilYandi Dwi W 571', '56419974571', '3276010023571', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231571', 'Kp,Babakan No. 571', 'Islam', 11, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(572, 2, 'P20222572', 'AprilYandi Dwi W 572', '56419974572', '3276010023572', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231572', 'Kp,Babakan No. 572', 'Islam', 1, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:29', NULL, NULL, NULL),
(573, 3, 'P20223573', 'AprilYandi Dwi W 573', '56419974573', '3276010023573', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231573', 'Kp,Babakan No. 573', 'Islam', 5, 6, '1500000.00', NULL, '', '2022-12-07 13:59:30', NULL, NULL, NULL),
(574, 3, 'P20223574', 'AprilYandi Dwi W 574', '56419974574', '3276010023574', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231574', 'Kp,Babakan No. 574', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:30', NULL, NULL, NULL),
(575, 1, 'P20221575', 'AprilYandi Dwi W 575', '56419974575', '3276010023575', 'Depok', '2001-12-25', 'Perempuan', '0851720231575', 'Kp,Babakan No. 575', 'Islam', 6, 3, NULL, NULL, '1', '2022-12-07 13:59:30', NULL, NULL, NULL),
(576, 2, 'P20222576', 'AprilYandi Dwi W 576', '56419974576', '3276010023576', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231576', 'Kp,Babakan No. 576', 'Islam', 11, 10, '1500000.00', NULL, '', '2022-12-07 13:59:30', NULL, NULL, NULL),
(577, 1, 'P20221577', 'AprilYandi Dwi W 577', '56419974577', '3276010023577', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231577', 'Kp,Babakan No. 577', 'Islam', 3, 13, NULL, NULL, '1', '2022-12-07 13:59:30', NULL, NULL, NULL),
(578, 2, 'P20222578', 'AprilYandi Dwi W 578', '56419974578', '3276010023578', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231578', 'Kp,Babakan No. 578', 'Islam', 9, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(579, 3, 'P20223579', 'AprilYandi Dwi W 579', '56419974579', '3276010023579', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231579', 'Kp,Babakan No. 579', 'Islam', 12, 10, '1500000.00', NULL, '', '2022-12-07 13:59:31', NULL, NULL, NULL),
(580, 1, 'P20221580', 'AprilYandi Dwi W 580', '56419974580', '3276010023580', 'Depok', '2001-12-02', 'Perempuan', '0851720231580', 'Kp,Babakan No. 580', 'Islam', 9, 4, NULL, NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(581, 2, 'P20222581', 'AprilYandi Dwi W 581', '56419974581', '3276010023581', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231581', 'Kp,Babakan No. 581', 'Islam', 11, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(582, 1, 'P20221582', 'AprilYandi Dwi W 582', '56419974582', '3276010023582', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231582', 'Kp,Babakan No. 582', 'Islam', 8, 4, NULL, NULL, '', '2022-12-07 13:59:31', NULL, NULL, NULL),
(583, 2, 'P20222583', 'AprilYandi Dwi W 583', '56419974583', '3276010023583', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231583', 'Kp,Babakan No. 583', 'Islam', 8, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(584, 1, 'P20221584', 'AprilYandi Dwi W 584', '56419974584', '3276010023584', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231584', 'Kp,Babakan No. 584', 'Islam', 11, 12, NULL, NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(585, 3, 'P20223585', 'AprilYandi Dwi W 585', '56419974585', '3276010023585', 'Depok', '2001-12-10', 'Perempuan', '0851720231585', 'Kp,Babakan No. 585', 'Islam', 6, 13, '1500000.00', NULL, '', '2022-12-07 13:59:31', NULL, NULL, NULL),
(586, 1, 'P20221586', 'AprilYandi Dwi W 586', '56419974586', '3276010023586', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231586', 'Kp,Babakan No. 586', 'Islam', 4, 3, NULL, NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(587, 1, 'P20221587', 'AprilYandi Dwi W 587', '56419974587', '3276010023587', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231587', 'Kp,Babakan No. 587', 'Islam', 10, 7, NULL, NULL, '1', '2022-12-07 13:59:31', NULL, NULL, NULL),
(588, 1, 'P20221588', 'AprilYandi Dwi W 588', '56419974588', '3276010023588', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231588', 'Kp,Babakan No. 588', 'Islam', 8, 9, NULL, NULL, '', '2022-12-07 13:59:32', NULL, NULL, NULL),
(589, 1, 'P20221589', 'AprilYandi Dwi W 589', '56419974589', '3276010023589', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231589', 'Kp,Babakan No. 589', 'Islam', 5, 10, NULL, NULL, '1', '2022-12-07 13:59:32', NULL, NULL, NULL),
(590, 3, 'P20223590', 'AprilYandi Dwi W 590', '56419974590', '3276010023590', 'Depok', '2001-12-12', 'Perempuan', '0851720231590', 'Kp,Babakan No. 590', 'Islam', 1, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:32', NULL, NULL, NULL),
(591, 1, 'P20221591', 'AprilYandi Dwi W 591', '56419974591', '3276010023591', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231591', 'Kp,Babakan No. 591', 'Islam', 1, 3, NULL, NULL, '', '2022-12-07 13:59:32', NULL, NULL, NULL),
(592, 1, 'P20221592', 'AprilYandi Dwi W 592', '56419974592', '3276010023592', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231592', 'Kp,Babakan No. 592', 'Islam', 11, 8, NULL, NULL, '1', '2022-12-07 13:59:32', NULL, NULL, NULL),
(593, 2, 'P20222593', 'AprilYandi Dwi W 593', '56419974593', '3276010023593', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231593', 'Kp,Babakan No. 593', 'Islam', 12, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:32', NULL, NULL, NULL),
(594, 3, 'P20223594', 'AprilYandi Dwi W 594', '56419974594', '3276010023594', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231594', 'Kp,Babakan No. 594', 'Islam', 4, 13, '1500000.00', NULL, '', '2022-12-07 13:59:32', NULL, NULL, NULL),
(595, 3, 'P20223595', 'AprilYandi Dwi W 595', '56419974595', '3276010023595', 'Depok', '2001-12-05', 'Perempuan', '0851720231595', 'Kp,Babakan No. 595', 'Islam', 2, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:32', NULL, NULL, NULL),
(596, 1, 'P20221596', 'AprilYandi Dwi W 596', '56419974596', '3276010023596', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231596', 'Kp,Babakan No. 596', 'Islam', 5, 9, NULL, NULL, '1', '2022-12-07 13:59:33', NULL, NULL, NULL),
(597, 3, 'P20223597', 'AprilYandi Dwi W 597', '56419974597', '3276010023597', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231597', 'Kp,Babakan No. 597', 'Islam', 12, 10, '1500000.00', NULL, '', '2022-12-07 13:59:33', NULL, NULL, NULL),
(598, 1, 'P20221598', 'AprilYandi Dwi W 598', '56419974598', '3276010023598', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231598', 'Kp,Babakan No. 598', 'Islam', 3, 12, NULL, NULL, '1', '2022-12-07 13:59:33', NULL, NULL, NULL),
(599, 3, 'P20223599', 'AprilYandi Dwi W 599', '56419974599', '3276010023599', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231599', 'Kp,Babakan No. 599', 'Islam', 12, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:33', NULL, NULL, NULL),
(600, 3, 'P20223600', 'AprilYandi Dwi W 600', '56419974600', '3276010023600', 'Depok', '2001-12-27', 'Perempuan', '0851720231600', 'Kp,Babakan No. 600', 'Islam', 8, 11, '1500000.00', NULL, '', '2022-12-07 13:59:34', NULL, NULL, NULL),
(601, 1, 'P20221601', 'AprilYandi Dwi W 601', '56419974601', '3276010023601', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231601', 'Kp,Babakan No. 601', 'Islam', 10, 3, NULL, NULL, '1', '2022-12-07 13:59:34', NULL, NULL, NULL),
(602, 1, 'P20221602', 'AprilYandi Dwi W 602', '56419974602', '3276010023602', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231602', 'Kp,Babakan No. 602', 'Islam', 6, 12, NULL, NULL, '1', '2022-12-07 13:59:34', NULL, NULL, NULL),
(603, 3, 'P20223603', 'AprilYandi Dwi W 603', '56419974603', '3276010023603', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231603', 'Kp,Babakan No. 603', 'Islam', 5, 10, '1500000.00', NULL, '', '2022-12-07 13:59:35', NULL, NULL, NULL),
(604, 3, 'P20223604', 'AprilYandi Dwi W 604', '56419974604', '3276010023604', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231604', 'Kp,Babakan No. 604', 'Islam', 10, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:35', NULL, NULL, NULL),
(605, 3, 'P20223605', 'AprilYandi Dwi W 605', '56419974605', '3276010023605', 'Depok', '2001-12-27', 'Perempuan', '0851720231605', 'Kp,Babakan No. 605', 'Islam', 12, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:35', NULL, NULL, NULL),
(606, 3, 'P20223606', 'AprilYandi Dwi W 606', '56419974606', '3276010023606', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231606', 'Kp,Babakan No. 606', 'Islam', 6, 3, '1500000.00', NULL, '', '2022-12-07 13:59:35', NULL, NULL, NULL),
(607, 3, 'P20223607', 'AprilYandi Dwi W 607', '56419974607', '3276010023607', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231607', 'Kp,Babakan No. 607', 'Islam', 11, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:35', NULL, NULL, NULL),
(608, 2, 'P20222608', 'AprilYandi Dwi W 608', '56419974608', '3276010023608', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231608', 'Kp,Babakan No. 608', 'Islam', 12, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(609, 2, 'P20222609', 'AprilYandi Dwi W 609', '56419974609', '3276010023609', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231609', 'Kp,Babakan No. 609', 'Islam', 3, 8, '1500000.00', NULL, '', '2022-12-07 13:59:36', NULL, NULL, NULL),
(610, 1, 'P20221610', 'AprilYandi Dwi W 610', '56419974610', '3276010023610', 'Depok', '2001-12-11', 'Perempuan', '0851720231610', 'Kp,Babakan No. 610', 'Islam', 6, 1, NULL, NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(611, 1, 'P20221611', 'AprilYandi Dwi W 611', '56419974611', '3276010023611', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231611', 'Kp,Babakan No. 611', 'Islam', 9, 9, NULL, NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(612, 1, 'P20221612', 'AprilYandi Dwi W 612', '56419974612', '3276010023612', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231612', 'Kp,Babakan No. 612', 'Islam', 6, 7, NULL, NULL, '', '2022-12-07 13:59:36', NULL, NULL, NULL),
(613, 1, 'P20221613', 'AprilYandi Dwi W 613', '56419974613', '3276010023613', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231613', 'Kp,Babakan No. 613', 'Islam', 13, 10, NULL, NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(614, 3, 'P20223614', 'AprilYandi Dwi W 614', '56419974614', '3276010023614', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231614', 'Kp,Babakan No. 614', 'Islam', 10, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(615, 3, 'P20223615', 'AprilYandi Dwi W 615', '56419974615', '3276010023615', 'Depok', '2001-12-20', 'Perempuan', '0851720231615', 'Kp,Babakan No. 615', 'Islam', 12, 2, '1500000.00', NULL, '', '2022-12-07 13:59:36', NULL, NULL, NULL),
(616, 1, 'P20221616', 'AprilYandi Dwi W 616', '56419974616', '3276010023616', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231616', 'Kp,Babakan No. 616', 'Islam', 2, 2, NULL, NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(617, 2, 'P20222617', 'AprilYandi Dwi W 617', '56419974617', '3276010023617', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231617', 'Kp,Babakan No. 617', 'Islam', 12, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:36', NULL, NULL, NULL),
(618, 1, 'P20221618', 'AprilYandi Dwi W 618', '56419974618', '3276010023618', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231618', 'Kp,Babakan No. 618', 'Islam', 6, 8, NULL, NULL, '', '2022-12-07 13:59:37', NULL, NULL, NULL),
(619, 3, 'P20223619', 'AprilYandi Dwi W 619', '56419974619', '3276010023619', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231619', 'Kp,Babakan No. 619', 'Islam', 12, 13, '1500000.00', NULL, '1', '2022-12-07 13:59:37', NULL, NULL, NULL),
(620, 1, 'P20221620', 'AprilYandi Dwi W 620', '56419974620', '3276010023620', 'Depok', '2001-12-12', 'Perempuan', '0851720231620', 'Kp,Babakan No. 620', 'Islam', 3, 9, NULL, NULL, '1', '2022-12-07 13:59:37', NULL, NULL, NULL),
(621, 2, 'P20222621', 'AprilYandi Dwi W 621', '56419974621', '3276010023621', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231621', 'Kp,Babakan No. 621', 'Islam', 13, 6, '1500000.00', NULL, '', '2022-12-07 13:59:37', NULL, NULL, NULL),
(622, 3, 'P20223622', 'AprilYandi Dwi W 622', '56419974622', '3276010023622', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231622', 'Kp,Babakan No. 622', 'Islam', 4, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:37', NULL, NULL, NULL),
(623, 3, 'P20223623', 'AprilYandi Dwi W 623', '56419974623', '3276010023623', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231623', 'Kp,Babakan No. 623', 'Islam', 5, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:37', NULL, NULL, NULL),
(624, 1, 'P20221624', 'AprilYandi Dwi W 624', '56419974624', '3276010023624', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231624', 'Kp,Babakan No. 624', 'Islam', 8, 12, NULL, NULL, '', '2022-12-07 13:59:38', NULL, NULL, NULL),
(625, 2, 'P20222625', 'AprilYandi Dwi W 625', '56419974625', '3276010023625', 'Depok', '2001-12-17', 'Perempuan', '0851720231625', 'Kp,Babakan No. 625', 'Islam', 9, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:38', NULL, NULL, NULL),
(626, 2, 'P20222626', 'AprilYandi Dwi W 626', '56419974626', '3276010023626', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231626', 'Kp,Babakan No. 626', 'Islam', 6, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:38', NULL, NULL, NULL),
(627, 3, 'P20223627', 'AprilYandi Dwi W 627', '56419974627', '3276010023627', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231627', 'Kp,Babakan No. 627', 'Islam', 11, 10, '1500000.00', NULL, '', '2022-12-07 13:59:38', NULL, NULL, NULL),
(628, 2, 'P20222628', 'AprilYandi Dwi W 628', '56419974628', '3276010023628', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231628', 'Kp,Babakan No. 628', 'Islam', 8, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:38', NULL, NULL, NULL),
(629, 1, 'P20221629', 'AprilYandi Dwi W 629', '56419974629', '3276010023629', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231629', 'Kp,Babakan No. 629', 'Islam', 7, 10, NULL, NULL, '1', '2022-12-07 13:59:38', NULL, NULL, NULL),
(630, 1, 'P20221630', 'AprilYandi Dwi W 630', '56419974630', '3276010023630', 'Depok', '2001-12-26', 'Perempuan', '0851720231630', 'Kp,Babakan No. 630', 'Islam', 10, 12, NULL, NULL, '', '2022-12-07 13:59:38', NULL, NULL, NULL),
(631, 2, 'P20222631', 'AprilYandi Dwi W 631', '56419974631', '3276010023631', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231631', 'Kp,Babakan No. 631', 'Islam', 1, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:38', NULL, NULL, NULL),
(632, 1, 'P20221632', 'AprilYandi Dwi W 632', '56419974632', '3276010023632', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231632', 'Kp,Babakan No. 632', 'Islam', 7, 5, NULL, NULL, '1', '2022-12-07 13:59:38', NULL, NULL, NULL),
(633, 1, 'P20221633', 'AprilYandi Dwi W 633', '56419974633', '3276010023633', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231633', 'Kp,Babakan No. 633', 'Islam', 7, 11, NULL, NULL, '', '2022-12-07 13:59:39', NULL, NULL, NULL),
(634, 2, 'P20222634', 'AprilYandi Dwi W 634', '56419974634', '3276010023634', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231634', 'Kp,Babakan No. 634', 'Islam', 4, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:39', NULL, NULL, NULL),
(635, 2, 'P20222635', 'AprilYandi Dwi W 635', '56419974635', '3276010023635', 'Depok', '2001-12-18', 'Perempuan', '0851720231635', 'Kp,Babakan No. 635', 'Islam', 4, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:39', NULL, NULL, NULL),
(636, 3, 'P20223636', 'AprilYandi Dwi W 636', '56419974636', '3276010023636', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231636', 'Kp,Babakan No. 636', 'Islam', 4, 5, '1500000.00', NULL, '', '2022-12-07 13:59:39', NULL, NULL, NULL),
(637, 2, 'P20222637', 'AprilYandi Dwi W 637', '56419974637', '3276010023637', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231637', 'Kp,Babakan No. 637', 'Islam', 5, 12, '1500000.00', NULL, '1', '2022-12-07 13:59:39', NULL, NULL, NULL),
(638, 1, 'P20221638', 'AprilYandi Dwi W 638', '56419974638', '3276010023638', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231638', 'Kp,Babakan No. 638', 'Islam', 2, 7, NULL, NULL, '1', '2022-12-07 13:59:39', NULL, NULL, NULL),
(639, 1, 'P20221639', 'AprilYandi Dwi W 639', '56419974639', '3276010023639', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231639', 'Kp,Babakan No. 639', 'Islam', 6, 11, NULL, NULL, '', '2022-12-07 13:59:40', NULL, NULL, NULL),
(640, 2, 'P20222640', 'AprilYandi Dwi W 640', '56419974640', '3276010023640', 'Depok', '2001-12-17', 'Perempuan', '0851720231640', 'Kp,Babakan No. 640', 'Islam', 5, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:40', NULL, NULL, NULL),
(641, 1, 'P20221641', 'AprilYandi Dwi W 641', '56419974641', '3276010023641', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231641', 'Kp,Babakan No. 641', 'Islam', 6, 6, NULL, NULL, '1', '2022-12-07 13:59:40', NULL, NULL, NULL),
(642, 2, 'P20222642', 'AprilYandi Dwi W 642', '56419974642', '3276010023642', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231642', 'Kp,Babakan No. 642', 'Islam', 13, 5, '1500000.00', NULL, '', '2022-12-07 13:59:40', NULL, NULL, NULL),
(643, 1, 'P20221643', 'AprilYandi Dwi W 643', '56419974643', '3276010023643', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231643', 'Kp,Babakan No. 643', 'Islam', 11, 6, NULL, NULL, '1', '2022-12-07 13:59:40', NULL, NULL, NULL),
(644, 3, 'P20223644', 'AprilYandi Dwi W 644', '56419974644', '3276010023644', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231644', 'Kp,Babakan No. 644', 'Islam', 8, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:40', NULL, NULL, NULL),
(645, 1, 'P20221645', 'AprilYandi Dwi W 645', '56419974645', '3276010023645', 'Depok', '2001-12-12', 'Perempuan', '0851720231645', 'Kp,Babakan No. 645', 'Islam', 11, 2, NULL, NULL, '', '2022-12-07 13:59:41', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(646, 3, 'P20223646', 'AprilYandi Dwi W 646', '56419974646', '3276010023646', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231646', 'Kp,Babakan No. 646', 'Islam', 13, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:41', NULL, NULL, NULL),
(647, 3, 'P20223647', 'AprilYandi Dwi W 647', '56419974647', '3276010023647', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231647', 'Kp,Babakan No. 647', 'Islam', 9, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:41', NULL, NULL, NULL),
(648, 1, 'P20221648', 'AprilYandi Dwi W 648', '56419974648', '3276010023648', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231648', 'Kp,Babakan No. 648', 'Islam', 5, 2, NULL, NULL, '', '2022-12-07 13:59:41', NULL, NULL, NULL),
(649, 1, 'P20221649', 'AprilYandi Dwi W 649', '56419974649', '3276010023649', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231649', 'Kp,Babakan No. 649', 'Islam', 8, 11, NULL, NULL, '1', '2022-12-07 13:59:41', NULL, NULL, NULL),
(650, 2, 'P20222650', 'AprilYandi Dwi W 650', '56419974650', '3276010023650', 'Depok', '2001-12-27', 'Perempuan', '0851720231650', 'Kp,Babakan No. 650', 'Islam', 11, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:41', NULL, NULL, NULL),
(651, 1, 'P20221651', 'AprilYandi Dwi W 651', '56419974651', '3276010023651', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231651', 'Kp,Babakan No. 651', 'Islam', 4, 9, NULL, NULL, '', '2022-12-07 13:59:42', NULL, NULL, NULL),
(652, 1, 'P20221652', 'AprilYandi Dwi W 652', '56419974652', '3276010023652', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231652', 'Kp,Babakan No. 652', 'Islam', 4, 2, NULL, NULL, '1', '2022-12-07 13:59:42', NULL, NULL, NULL),
(653, 2, 'P20222653', 'AprilYandi Dwi W 653', '56419974653', '3276010023653', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231653', 'Kp,Babakan No. 653', 'Islam', 13, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:42', NULL, NULL, NULL),
(654, 3, 'P20223654', 'AprilYandi Dwi W 654', '56419974654', '3276010023654', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231654', 'Kp,Babakan No. 654', 'Islam', 4, 7, '1500000.00', NULL, '', '2022-12-07 13:59:42', NULL, NULL, NULL),
(655, 2, 'P20222655', 'AprilYandi Dwi W 655', '56419974655', '3276010023655', 'Depok', '2001-12-31', 'Perempuan', '0851720231655', 'Kp,Babakan No. 655', 'Islam', 10, 10, '1500000.00', NULL, '1', '2022-12-07 13:59:43', NULL, NULL, NULL),
(656, 2, 'P20222656', 'AprilYandi Dwi W 656', '56419974656', '3276010023656', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231656', 'Kp,Babakan No. 656', 'Islam', 4, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:43', NULL, NULL, NULL),
(657, 3, 'P20223657', 'AprilYandi Dwi W 657', '56419974657', '3276010023657', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231657', 'Kp,Babakan No. 657', 'Islam', 7, 3, '1500000.00', NULL, '', '2022-12-07 13:59:43', NULL, NULL, NULL),
(658, 3, 'P20223658', 'AprilYandi Dwi W 658', '56419974658', '3276010023658', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231658', 'Kp,Babakan No. 658', 'Islam', 11, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:43', NULL, NULL, NULL),
(659, 3, 'P20223659', 'AprilYandi Dwi W 659', '56419974659', '3276010023659', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231659', 'Kp,Babakan No. 659', 'Islam', 13, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:44', NULL, NULL, NULL),
(660, 2, 'P20222660', 'AprilYandi Dwi W 660', '56419974660', '3276010023660', 'Depok', '2001-12-23', 'Perempuan', '0851720231660', 'Kp,Babakan No. 660', 'Islam', 2, 4, '1500000.00', NULL, '', '2022-12-07 13:59:44', NULL, NULL, NULL),
(661, 3, 'P20223661', 'AprilYandi Dwi W 661', '56419974661', '3276010023661', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231661', 'Kp,Babakan No. 661', 'Islam', 4, 11, '1500000.00', NULL, '1', '2022-12-07 13:59:44', NULL, NULL, NULL),
(662, 2, 'P20222662', 'AprilYandi Dwi W 662', '56419974662', '3276010023662', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231662', 'Kp,Babakan No. 662', 'Islam', 11, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:44', NULL, NULL, NULL),
(663, 2, 'P20222663', 'AprilYandi Dwi W 663', '56419974663', '3276010023663', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231663', 'Kp,Babakan No. 663', 'Islam', 10, 5, '1500000.00', NULL, '', '2022-12-07 13:59:44', NULL, NULL, NULL),
(664, 2, 'P20222664', 'AprilYandi Dwi W 664', '56419974664', '3276010023664', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231664', 'Kp,Babakan No. 664', 'Islam', 1, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:45', NULL, NULL, NULL),
(665, 3, 'P20223665', 'AprilYandi Dwi W 665', '56419974665', '3276010023665', 'Depok', '2001-12-22', 'Perempuan', '0851720231665', 'Kp,Babakan No. 665', 'Islam', 12, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:46', NULL, NULL, NULL),
(666, 2, 'P20222666', 'AprilYandi Dwi W 666', '56419974666', '3276010023666', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231666', 'Kp,Babakan No. 666', 'Islam', 9, 6, '1500000.00', NULL, '', '2022-12-07 13:59:46', NULL, NULL, NULL),
(667, 3, 'P20223667', 'AprilYandi Dwi W 667', '56419974667', '3276010023667', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231667', 'Kp,Babakan No. 667', 'Islam', 7, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:46', NULL, NULL, NULL),
(668, 2, 'P20222668', 'AprilYandi Dwi W 668', '56419974668', '3276010023668', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231668', 'Kp,Babakan No. 668', 'Islam', 4, 3, '1500000.00', NULL, '1', '2022-12-07 13:59:46', NULL, NULL, NULL),
(669, 3, 'P20223669', 'AprilYandi Dwi W 669', '56419974669', '3276010023669', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231669', 'Kp,Babakan No. 669', 'Islam', 5, 4, '1500000.00', NULL, '', '2022-12-07 13:59:46', NULL, NULL, NULL),
(670, 2, 'P20222670', 'AprilYandi Dwi W 670', '56419974670', '3276010023670', 'Depok', '2001-12-10', 'Perempuan', '0851720231670', 'Kp,Babakan No. 670', 'Islam', 4, 2, '1500000.00', NULL, '1', '2022-12-07 13:59:47', NULL, NULL, NULL),
(671, 3, 'P20223671', 'AprilYandi Dwi W 671', '56419974671', '3276010023671', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231671', 'Kp,Babakan No. 671', 'Islam', 7, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:47', NULL, NULL, NULL),
(672, 3, 'P20223672', 'AprilYandi Dwi W 672', '56419974672', '3276010023672', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231672', 'Kp,Babakan No. 672', 'Islam', 7, 3, '1500000.00', NULL, '', '2022-12-07 13:59:48', NULL, NULL, NULL),
(673, 1, 'P20221673', 'AprilYandi Dwi W 673', '56419974673', '3276010023673', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231673', 'Kp,Babakan No. 673', 'Islam', 13, 12, NULL, NULL, '1', '2022-12-07 13:59:48', NULL, NULL, NULL),
(674, 1, 'P20221674', 'AprilYandi Dwi W 674', '56419974674', '3276010023674', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231674', 'Kp,Babakan No. 674', 'Islam', 6, 7, NULL, NULL, '1', '2022-12-07 13:59:48', NULL, NULL, NULL),
(675, 3, 'P20223675', 'AprilYandi Dwi W 675', '56419974675', '3276010023675', 'Depok', '2001-12-05', 'Perempuan', '0851720231675', 'Kp,Babakan No. 675', 'Islam', 13, 1, '1500000.00', NULL, '', '2022-12-07 13:59:49', NULL, NULL, NULL),
(676, 1, 'P20221676', 'AprilYandi Dwi W 676', '56419974676', '3276010023676', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231676', 'Kp,Babakan No. 676', 'Islam', 1, 12, NULL, NULL, '1', '2022-12-07 13:59:49', NULL, NULL, NULL),
(677, 2, 'P20222677', 'AprilYandi Dwi W 677', '56419974677', '3276010023677', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231677', 'Kp,Babakan No. 677', 'Islam', 13, 9, '1500000.00', NULL, '1', '2022-12-07 13:59:50', NULL, NULL, NULL),
(678, 3, 'P20223678', 'AprilYandi Dwi W 678', '56419974678', '3276010023678', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231678', 'Kp,Babakan No. 678', 'Islam', 13, 4, '1500000.00', NULL, '', '2022-12-07 13:59:50', NULL, NULL, NULL),
(679, 1, 'P20221679', 'AprilYandi Dwi W 679', '56419974679', '3276010023679', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231679', 'Kp,Babakan No. 679', 'Islam', 1, 12, NULL, NULL, '1', '2022-12-07 13:59:50', NULL, NULL, NULL),
(680, 3, 'P20223680', 'AprilYandi Dwi W 680', '56419974680', '3276010023680', 'Depok', '2001-12-06', 'Perempuan', '0851720231680', 'Kp,Babakan No. 680', 'Islam', 7, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:50', NULL, NULL, NULL),
(681, 2, 'P20222681', 'AprilYandi Dwi W 681', '56419974681', '3276010023681', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231681', 'Kp,Babakan No. 681', 'Islam', 13, 3, '1500000.00', NULL, '', '2022-12-07 13:59:51', NULL, NULL, NULL),
(682, 3, 'P20223682', 'AprilYandi Dwi W 682', '56419974682', '3276010023682', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231682', 'Kp,Babakan No. 682', 'Islam', 7, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:51', NULL, NULL, NULL),
(683, 1, 'P20221683', 'AprilYandi Dwi W 683', '56419974683', '3276010023683', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231683', 'Kp,Babakan No. 683', 'Islam', 9, 7, NULL, NULL, '1', '2022-12-07 13:59:51', NULL, NULL, NULL),
(684, 1, 'P20221684', 'AprilYandi Dwi W 684', '56419974684', '3276010023684', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231684', 'Kp,Babakan No. 684', 'Islam', 13, 9, NULL, NULL, '', '2022-12-07 13:59:52', NULL, NULL, NULL),
(685, 1, 'P20221685', 'AprilYandi Dwi W 685', '56419974685', '3276010023685', 'Depok', '2001-12-24', 'Perempuan', '0851720231685', 'Kp,Babakan No. 685', 'Islam', 7, 3, NULL, NULL, '1', '2022-12-07 13:59:52', NULL, NULL, NULL),
(686, 1, 'P20221686', 'AprilYandi Dwi W 686', '56419974686', '3276010023686', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231686', 'Kp,Babakan No. 686', 'Islam', 2, 12, NULL, NULL, '1', '2022-12-07 13:59:52', NULL, NULL, NULL),
(687, 1, 'P20221687', 'AprilYandi Dwi W 687', '56419974687', '3276010023687', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231687', 'Kp,Babakan No. 687', 'Islam', 10, 12, NULL, NULL, '', '2022-12-07 13:59:52', NULL, NULL, NULL),
(688, 2, 'P20222688', 'AprilYandi Dwi W 688', '56419974688', '3276010023688', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231688', 'Kp,Babakan No. 688', 'Islam', 2, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:53', NULL, NULL, NULL),
(689, 2, 'P20222689', 'AprilYandi Dwi W 689', '56419974689', '3276010023689', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231689', 'Kp,Babakan No. 689', 'Islam', 3, 5, '1500000.00', NULL, '1', '2022-12-07 13:59:53', NULL, NULL, NULL),
(690, 1, 'P20221690', 'AprilYandi Dwi W 690', '56419974690', '3276010023690', 'Depok', '2001-12-15', 'Perempuan', '0851720231690', 'Kp,Babakan No. 690', 'Islam', 6, 5, NULL, NULL, '', '2022-12-07 13:59:53', NULL, NULL, NULL),
(691, 3, 'P20223691', 'AprilYandi Dwi W 691', '56419974691', '3276010023691', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231691', 'Kp,Babakan No. 691', 'Islam', 8, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:53', NULL, NULL, NULL),
(692, 3, 'P20223692', 'AprilYandi Dwi W 692', '56419974692', '3276010023692', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231692', 'Kp,Babakan No. 692', 'Islam', 3, 1, '1500000.00', NULL, '1', '2022-12-07 13:59:55', NULL, NULL, NULL),
(693, 1, 'P20221693', 'AprilYandi Dwi W 693', '56419974693', '3276010023693', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231693', 'Kp,Babakan No. 693', 'Islam', 1, 11, NULL, NULL, '', '2022-12-07 13:59:55', NULL, NULL, NULL),
(694, 3, 'P20223694', 'AprilYandi Dwi W 694', '56419974694', '3276010023694', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231694', 'Kp,Babakan No. 694', 'Islam', 12, 8, '1500000.00', NULL, '1', '2022-12-07 13:59:56', NULL, NULL, NULL),
(695, 2, 'P20222695', 'AprilYandi Dwi W 695', '56419974695', '3276010023695', 'Depok', '2001-12-02', 'Perempuan', '0851720231695', 'Kp,Babakan No. 695', 'Islam', 11, 7, '1500000.00', NULL, '1', '2022-12-07 13:59:56', NULL, NULL, NULL),
(696, 1, 'P20221696', 'AprilYandi Dwi W 696', '56419974696', '3276010023696', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231696', 'Kp,Babakan No. 696', 'Islam', 4, 6, NULL, NULL, '', '2022-12-07 13:59:57', NULL, NULL, NULL),
(697, 1, 'P20221697', 'AprilYandi Dwi W 697', '56419974697', '3276010023697', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231697', 'Kp,Babakan No. 697', 'Islam', 10, 13, NULL, NULL, '1', '2022-12-07 13:59:57', NULL, NULL, NULL),
(698, 1, 'P20221698', 'AprilYandi Dwi W 698', '56419974698', '3276010023698', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231698', 'Kp,Babakan No. 698', 'Islam', 5, 2, NULL, NULL, '1', '2022-12-07 13:59:58', NULL, NULL, NULL),
(699, 2, 'P20222699', 'AprilYandi Dwi W 699', '56419974699', '3276010023699', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231699', 'Kp,Babakan No. 699', 'Islam', 1, 5, '1500000.00', NULL, '', '2022-12-07 13:59:58', NULL, NULL, NULL),
(700, 1, 'P20221700', 'AprilYandi Dwi W 700', '56419974700', '3276010023700', 'Depok', '2001-12-25', 'Perempuan', '0851720231700', 'Kp,Babakan No. 700', 'Islam', 12, 7, NULL, NULL, '1', '2022-12-07 13:59:58', NULL, NULL, NULL),
(701, 2, 'P20222701', 'AprilYandi Dwi W 701', '56419974701', '3276010023701', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231701', 'Kp,Babakan No. 701', 'Islam', 13, 4, '1500000.00', NULL, '1', '2022-12-07 13:59:58', NULL, NULL, NULL),
(702, 1, 'P20221702', 'AprilYandi Dwi W 702', '56419974702', '3276010023702', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231702', 'Kp,Babakan No. 702', 'Islam', 12, 3, NULL, NULL, '', '2022-12-07 13:59:59', NULL, NULL, NULL),
(703, 3, 'P20223703', 'AprilYandi Dwi W 703', '56419974703', '3276010023703', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231703', 'Kp,Babakan No. 703', 'Islam', 7, 6, '1500000.00', NULL, '1', '2022-12-07 13:59:59', NULL, NULL, NULL),
(704, 1, 'P20221704', 'AprilYandi Dwi W 704', '56419974704', '3276010023704', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231704', 'Kp,Babakan No. 704', 'Islam', 3, 6, NULL, NULL, '1', '2022-12-07 14:00:00', NULL, NULL, NULL),
(705, 1, 'P20221705', 'AprilYandi Dwi W 705', '56419974705', '3276010023705', 'Depok', '2001-12-26', 'Perempuan', '0851720231705', 'Kp,Babakan No. 705', 'Islam', 3, 7, NULL, NULL, '', '2022-12-07 14:00:00', NULL, NULL, NULL),
(706, 1, 'P20221706', 'AprilYandi Dwi W 706', '56419974706', '3276010023706', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231706', 'Kp,Babakan No. 706', 'Islam', 8, 3, NULL, NULL, '1', '2022-12-07 14:00:00', NULL, NULL, NULL),
(707, 1, 'P20221707', 'AprilYandi Dwi W 707', '56419974707', '3276010023707', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231707', 'Kp,Babakan No. 707', 'Islam', 13, 12, NULL, NULL, '1', '2022-12-07 14:00:01', NULL, NULL, NULL),
(708, 1, 'P20221708', 'AprilYandi Dwi W 708', '56419974708', '3276010023708', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231708', 'Kp,Babakan No. 708', 'Islam', 3, 9, NULL, NULL, '', '2022-12-07 14:00:01', NULL, NULL, NULL),
(709, 2, 'P20222709', 'AprilYandi Dwi W 709', '56419974709', '3276010023709', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231709', 'Kp,Babakan No. 709', 'Islam', 5, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:01', NULL, NULL, NULL),
(710, 2, 'P20222710', 'AprilYandi Dwi W 710', '56419974710', '3276010023710', 'Depok', '2001-12-06', 'Perempuan', '0851720231710', 'Kp,Babakan No. 710', 'Islam', 1, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:01', NULL, NULL, NULL),
(711, 2, 'P20222711', 'AprilYandi Dwi W 711', '56419974711', '3276010023711', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231711', 'Kp,Babakan No. 711', 'Islam', 10, 7, '1500000.00', NULL, '', '2022-12-07 14:00:02', NULL, NULL, NULL),
(712, 2, 'P20222712', 'AprilYandi Dwi W 712', '56419974712', '3276010023712', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231712', 'Kp,Babakan No. 712', 'Islam', 7, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:02', NULL, NULL, NULL),
(713, 1, 'P20221713', 'AprilYandi Dwi W 713', '56419974713', '3276010023713', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231713', 'Kp,Babakan No. 713', 'Islam', 11, 1, NULL, NULL, '1', '2022-12-07 14:00:02', NULL, NULL, NULL),
(714, 3, 'P20223714', 'AprilYandi Dwi W 714', '56419974714', '3276010023714', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231714', 'Kp,Babakan No. 714', 'Islam', 8, 11, '1500000.00', NULL, '', '2022-12-07 14:00:02', NULL, NULL, NULL),
(715, 2, 'P20222715', 'AprilYandi Dwi W 715', '56419974715', '3276010023715', 'Depok', '2001-12-09', 'Perempuan', '0851720231715', 'Kp,Babakan No. 715', 'Islam', 9, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:02', NULL, NULL, NULL),
(716, 2, 'P20222716', 'AprilYandi Dwi W 716', '56419974716', '3276010023716', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231716', 'Kp,Babakan No. 716', 'Islam', 5, 6, '1500000.00', NULL, '1', '2022-12-07 14:00:03', NULL, NULL, NULL),
(717, 3, 'P20223717', 'AprilYandi Dwi W 717', '56419974717', '3276010023717', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231717', 'Kp,Babakan No. 717', 'Islam', 4, 12, '1500000.00', NULL, '', '2022-12-07 14:00:03', NULL, NULL, NULL),
(718, 2, 'P20222718', 'AprilYandi Dwi W 718', '56419974718', '3276010023718', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231718', 'Kp,Babakan No. 718', 'Islam', 11, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:03', NULL, NULL, NULL),
(719, 3, 'P20223719', 'AprilYandi Dwi W 719', '56419974719', '3276010023719', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231719', 'Kp,Babakan No. 719', 'Islam', 3, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:04', NULL, NULL, NULL),
(720, 1, 'P20221720', 'AprilYandi Dwi W 720', '56419974720', '3276010023720', 'Depok', '2001-12-09', 'Perempuan', '0851720231720', 'Kp,Babakan No. 720', 'Islam', 6, 5, NULL, NULL, '', '2022-12-07 14:00:04', NULL, NULL, NULL),
(721, 2, 'P20222721', 'AprilYandi Dwi W 721', '56419974721', '3276010023721', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231721', 'Kp,Babakan No. 721', 'Islam', 1, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:04', NULL, NULL, NULL),
(722, 2, 'P20222722', 'AprilYandi Dwi W 722', '56419974722', '3276010023722', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231722', 'Kp,Babakan No. 722', 'Islam', 4, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:04', NULL, NULL, NULL),
(723, 3, 'P20223723', 'AprilYandi Dwi W 723', '56419974723', '3276010023723', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231723', 'Kp,Babakan No. 723', 'Islam', 11, 4, '1500000.00', NULL, '', '2022-12-07 14:00:04', NULL, NULL, NULL),
(724, 1, 'P20221724', 'AprilYandi Dwi W 724', '56419974724', '3276010023724', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231724', 'Kp,Babakan No. 724', 'Islam', 12, 9, NULL, NULL, '1', '2022-12-07 14:00:04', NULL, NULL, NULL),
(725, 3, 'P20223725', 'AprilYandi Dwi W 725', '56419974725', '3276010023725', 'Depok', '2001-12-17', 'Perempuan', '0851720231725', 'Kp,Babakan No. 725', 'Islam', 11, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:05', NULL, NULL, NULL),
(726, 3, 'P20223726', 'AprilYandi Dwi W 726', '56419974726', '3276010023726', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231726', 'Kp,Babakan No. 726', 'Islam', 12, 12, '1500000.00', NULL, '', '2022-12-07 14:00:05', NULL, NULL, NULL),
(727, 2, 'P20222727', 'AprilYandi Dwi W 727', '56419974727', '3276010023727', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231727', 'Kp,Babakan No. 727', 'Islam', 3, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:05', NULL, NULL, NULL),
(728, 2, 'P20222728', 'AprilYandi Dwi W 728', '56419974728', '3276010023728', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231728', 'Kp,Babakan No. 728', 'Islam', 12, 12, '1500000.00', NULL, '1', '2022-12-07 14:00:05', NULL, NULL, NULL),
(729, 3, 'P20223729', 'AprilYandi Dwi W 729', '56419974729', '3276010023729', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231729', 'Kp,Babakan No. 729', 'Islam', 9, 13, '1500000.00', NULL, '', '2022-12-07 14:00:05', NULL, NULL, NULL),
(730, 2, 'P20222730', 'AprilYandi Dwi W 730', '56419974730', '3276010023730', 'Depok', '2001-12-07', 'Perempuan', '0851720231730', 'Kp,Babakan No. 730', 'Islam', 2, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:05', NULL, NULL, NULL),
(731, 2, 'P20222731', 'AprilYandi Dwi W 731', '56419974731', '3276010023731', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231731', 'Kp,Babakan No. 731', 'Islam', 4, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:05', NULL, NULL, NULL),
(732, 1, 'P20221732', 'AprilYandi Dwi W 732', '56419974732', '3276010023732', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231732', 'Kp,Babakan No. 732', 'Islam', 11, 9, NULL, NULL, '', '2022-12-07 14:00:06', NULL, NULL, NULL),
(733, 2, 'P20222733', 'AprilYandi Dwi W 733', '56419974733', '3276010023733', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231733', 'Kp,Babakan No. 733', 'Islam', 13, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:06', NULL, NULL, NULL),
(734, 1, 'P20221734', 'AprilYandi Dwi W 734', '56419974734', '3276010023734', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231734', 'Kp,Babakan No. 734', 'Islam', 2, 13, NULL, NULL, '1', '2022-12-07 14:00:06', NULL, NULL, NULL),
(735, 3, 'P20223735', 'AprilYandi Dwi W 735', '56419974735', '3276010023735', 'Depok', '2001-12-17', 'Perempuan', '0851720231735', 'Kp,Babakan No. 735', 'Islam', 3, 9, '1500000.00', NULL, '', '2022-12-07 14:00:06', NULL, NULL, NULL),
(736, 2, 'P20222736', 'AprilYandi Dwi W 736', '56419974736', '3276010023736', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231736', 'Kp,Babakan No. 736', 'Islam', 2, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:06', NULL, NULL, NULL),
(737, 1, 'P20221737', 'AprilYandi Dwi W 737', '56419974737', '3276010023737', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231737', 'Kp,Babakan No. 737', 'Islam', 6, 10, NULL, NULL, '1', '2022-12-07 14:00:06', NULL, NULL, NULL),
(738, 1, 'P20221738', 'AprilYandi Dwi W 738', '56419974738', '3276010023738', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231738', 'Kp,Babakan No. 738', 'Islam', 1, 11, NULL, NULL, '', '2022-12-07 14:00:07', NULL, NULL, NULL),
(739, 1, 'P20221739', 'AprilYandi Dwi W 739', '56419974739', '3276010023739', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231739', 'Kp,Babakan No. 739', 'Islam', 1, 11, NULL, NULL, '1', '2022-12-07 14:00:07', NULL, NULL, NULL),
(740, 1, 'P20221740', 'AprilYandi Dwi W 740', '56419974740', '3276010023740', 'Depok', '2001-12-26', 'Perempuan', '0851720231740', 'Kp,Babakan No. 740', 'Islam', 13, 8, NULL, NULL, '1', '2022-12-07 14:00:07', NULL, NULL, NULL),
(741, 2, 'P20222741', 'AprilYandi Dwi W 741', '56419974741', '3276010023741', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231741', 'Kp,Babakan No. 741', 'Islam', 3, 11, '1500000.00', NULL, '', '2022-12-07 14:00:07', NULL, NULL, NULL),
(742, 3, 'P20223742', 'AprilYandi Dwi W 742', '56419974742', '3276010023742', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231742', 'Kp,Babakan No. 742', 'Islam', 5, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:07', NULL, NULL, NULL),
(743, 3, 'P20223743', 'AprilYandi Dwi W 743', '56419974743', '3276010023743', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231743', 'Kp,Babakan No. 743', 'Islam', 3, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:07', NULL, NULL, NULL),
(744, 2, 'P20222744', 'AprilYandi Dwi W 744', '56419974744', '3276010023744', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231744', 'Kp,Babakan No. 744', 'Islam', 12, 9, '1500000.00', NULL, '', '2022-12-07 14:00:07', NULL, NULL, NULL),
(745, 2, 'P20222745', 'AprilYandi Dwi W 745', '56419974745', '3276010023745', 'Depok', '2001-12-30', 'Perempuan', '0851720231745', 'Kp,Babakan No. 745', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:08', NULL, NULL, NULL),
(746, 1, 'P20221746', 'AprilYandi Dwi W 746', '56419974746', '3276010023746', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231746', 'Kp,Babakan No. 746', 'Islam', 1, 10, NULL, NULL, '1', '2022-12-07 14:00:08', NULL, NULL, NULL),
(747, 1, 'P20221747', 'AprilYandi Dwi W 747', '56419974747', '3276010023747', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231747', 'Kp,Babakan No. 747', 'Islam', 8, 2, NULL, NULL, '', '2022-12-07 14:00:08', NULL, NULL, NULL),
(748, 2, 'P20222748', 'AprilYandi Dwi W 748', '56419974748', '3276010023748', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231748', 'Kp,Babakan No. 748', 'Islam', 10, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:09', NULL, NULL, NULL),
(749, 2, 'P20222749', 'AprilYandi Dwi W 749', '56419974749', '3276010023749', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231749', 'Kp,Babakan No. 749', 'Islam', 12, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:09', NULL, NULL, NULL),
(750, 1, 'P20221750', 'AprilYandi Dwi W 750', '56419974750', '3276010023750', 'Depok', '2001-12-02', 'Perempuan', '0851720231750', 'Kp,Babakan No. 750', 'Islam', 3, 9, NULL, NULL, '', '2022-12-07 14:00:09', NULL, NULL, NULL),
(751, 3, 'P20223751', 'AprilYandi Dwi W 751', '56419974751', '3276010023751', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231751', 'Kp,Babakan No. 751', 'Islam', 12, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:09', NULL, NULL, NULL),
(752, 1, 'P20221752', 'AprilYandi Dwi W 752', '56419974752', '3276010023752', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231752', 'Kp,Babakan No. 752', 'Islam', 3, 13, NULL, NULL, '1', '2022-12-07 14:00:09', NULL, NULL, NULL),
(753, 1, 'P20221753', 'AprilYandi Dwi W 753', '56419974753', '3276010023753', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231753', 'Kp,Babakan No. 753', 'Islam', 3, 5, NULL, NULL, '', '2022-12-07 14:00:09', NULL, NULL, NULL),
(754, 2, 'P20222754', 'AprilYandi Dwi W 754', '56419974754', '3276010023754', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231754', 'Kp,Babakan No. 754', 'Islam', 13, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:10', NULL, NULL, NULL),
(755, 1, 'P20221755', 'AprilYandi Dwi W 755', '56419974755', '3276010023755', 'Depok', '2001-12-17', 'Perempuan', '0851720231755', 'Kp,Babakan No. 755', 'Islam', 5, 12, NULL, NULL, '1', '2022-12-07 14:00:10', NULL, NULL, NULL),
(756, 3, 'P20223756', 'AprilYandi Dwi W 756', '56419974756', '3276010023756', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231756', 'Kp,Babakan No. 756', 'Islam', 9, 2, '1500000.00', NULL, '', '2022-12-07 14:00:10', NULL, NULL, NULL),
(757, 1, 'P20221757', 'AprilYandi Dwi W 757', '56419974757', '3276010023757', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231757', 'Kp,Babakan No. 757', 'Islam', 5, 6, NULL, NULL, '1', '2022-12-07 14:00:10', NULL, NULL, NULL),
(758, 3, 'P20223758', 'AprilYandi Dwi W 758', '56419974758', '3276010023758', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231758', 'Kp,Babakan No. 758', 'Islam', 11, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:10', NULL, NULL, NULL),
(759, 1, 'P20221759', 'AprilYandi Dwi W 759', '56419974759', '3276010023759', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231759', 'Kp,Babakan No. 759', 'Islam', 10, 9, NULL, NULL, '', '2022-12-07 14:00:11', NULL, NULL, NULL),
(760, 3, 'P20223760', 'AprilYandi Dwi W 760', '56419974760', '3276010023760', 'Depok', '2001-12-23', 'Perempuan', '0851720231760', 'Kp,Babakan No. 760', 'Islam', 4, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:11', NULL, NULL, NULL),
(761, 3, 'P20223761', 'AprilYandi Dwi W 761', '56419974761', '3276010023761', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231761', 'Kp,Babakan No. 761', 'Islam', 3, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:11', NULL, NULL, NULL),
(762, 1, 'P20221762', 'AprilYandi Dwi W 762', '56419974762', '3276010023762', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231762', 'Kp,Babakan No. 762', 'Islam', 4, 4, NULL, NULL, '', '2022-12-07 14:00:11', NULL, NULL, NULL),
(763, 2, 'P20222763', 'AprilYandi Dwi W 763', '56419974763', '3276010023763', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231763', 'Kp,Babakan No. 763', 'Islam', 2, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:11', NULL, NULL, NULL),
(764, 2, 'P20222764', 'AprilYandi Dwi W 764', '56419974764', '3276010023764', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231764', 'Kp,Babakan No. 764', 'Islam', 10, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:12', NULL, NULL, NULL),
(765, 1, 'P20221765', 'AprilYandi Dwi W 765', '56419974765', '3276010023765', 'Depok', '2001-12-25', 'Perempuan', '0851720231765', 'Kp,Babakan No. 765', 'Islam', 7, 13, NULL, NULL, '', '2022-12-07 14:00:12', NULL, NULL, NULL),
(766, 2, 'P20222766', 'AprilYandi Dwi W 766', '56419974766', '3276010023766', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231766', 'Kp,Babakan No. 766', 'Islam', 7, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:12', NULL, NULL, NULL),
(767, 3, 'P20223767', 'AprilYandi Dwi W 767', '56419974767', '3276010023767', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231767', 'Kp,Babakan No. 767', 'Islam', 1, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:12', NULL, NULL, NULL),
(768, 3, 'P20223768', 'AprilYandi Dwi W 768', '56419974768', '3276010023768', 'Jakarta', '2001-12-07', 'Laki-Laki', '0851720231768', 'Kp,Babakan No. 768', 'Islam', 13, 10, '1500000.00', NULL, '', '2022-12-07 14:00:12', NULL, NULL, NULL),
(769, 3, 'P20223769', 'AprilYandi Dwi W 769', '56419974769', '3276010023769', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231769', 'Kp,Babakan No. 769', 'Islam', 1, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:13', NULL, NULL, NULL),
(770, 3, 'P20223770', 'AprilYandi Dwi W 770', '56419974770', '3276010023770', 'Depok', '2001-12-11', 'Perempuan', '0851720231770', 'Kp,Babakan No. 770', 'Islam', 3, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:13', NULL, NULL, NULL),
(771, 3, 'P20223771', 'AprilYandi Dwi W 771', '56419974771', '3276010023771', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231771', 'Kp,Babakan No. 771', 'Islam', 9, 1, '1500000.00', NULL, '', '2022-12-07 14:00:13', NULL, NULL, NULL),
(772, 3, 'P20223772', 'AprilYandi Dwi W 772', '56419974772', '3276010023772', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231772', 'Kp,Babakan No. 772', 'Islam', 10, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:13', NULL, NULL, NULL),
(773, 1, 'P20221773', 'AprilYandi Dwi W 773', '56419974773', '3276010023773', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231773', 'Kp,Babakan No. 773', 'Islam', 11, 10, NULL, NULL, '1', '2022-12-07 14:00:14', NULL, NULL, NULL),
(774, 1, 'P20221774', 'AprilYandi Dwi W 774', '56419974774', '3276010023774', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231774', 'Kp,Babakan No. 774', 'Islam', 1, 13, NULL, NULL, '', '2022-12-07 14:00:14', NULL, NULL, NULL),
(775, 3, 'P20223775', 'AprilYandi Dwi W 775', '56419974775', '3276010023775', 'Depok', '2001-12-12', 'Perempuan', '0851720231775', 'Kp,Babakan No. 775', 'Islam', 10, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:14', NULL, NULL, NULL),
(776, 1, 'P20221776', 'AprilYandi Dwi W 776', '56419974776', '3276010023776', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231776', 'Kp,Babakan No. 776', 'Islam', 1, 6, NULL, NULL, '1', '2022-12-07 14:00:14', NULL, NULL, NULL),
(777, 2, 'P20222777', 'AprilYandi Dwi W 777', '56419974777', '3276010023777', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231777', 'Kp,Babakan No. 777', 'Islam', 12, 4, '1500000.00', NULL, '', '2022-12-07 14:00:14', NULL, NULL, NULL),
(778, 2, 'P20222778', 'AprilYandi Dwi W 778', '56419974778', '3276010023778', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231778', 'Kp,Babakan No. 778', 'Islam', 8, 6, '1500000.00', NULL, '1', '2022-12-07 14:00:14', NULL, NULL, NULL),
(779, 1, 'P20221779', 'AprilYandi Dwi W 779', '56419974779', '3276010023779', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231779', 'Kp,Babakan No. 779', 'Islam', 12, 6, NULL, NULL, '1', '2022-12-07 14:00:15', NULL, NULL, NULL),
(780, 2, 'P20222780', 'AprilYandi Dwi W 780', '56419974780', '3276010023780', 'Depok', '2001-12-13', 'Perempuan', '0851720231780', 'Kp,Babakan No. 780', 'Islam', 10, 11, '1500000.00', NULL, '', '2022-12-07 14:00:15', NULL, NULL, NULL),
(781, 2, 'P20222781', 'AprilYandi Dwi W 781', '56419974781', '3276010023781', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231781', 'Kp,Babakan No. 781', 'Islam', 13, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:15', NULL, NULL, NULL),
(782, 2, 'P20222782', 'AprilYandi Dwi W 782', '56419974782', '3276010023782', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231782', 'Kp,Babakan No. 782', 'Islam', 7, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:15', NULL, NULL, NULL),
(783, 1, 'P20221783', 'AprilYandi Dwi W 783', '56419974783', '3276010023783', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231783', 'Kp,Babakan No. 783', 'Islam', 10, 13, NULL, NULL, '', '2022-12-07 14:00:15', NULL, NULL, NULL),
(784, 2, 'P20222784', 'AprilYandi Dwi W 784', '56419974784', '3276010023784', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231784', 'Kp,Babakan No. 784', 'Islam', 4, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:15', NULL, NULL, NULL),
(785, 1, 'P20221785', 'AprilYandi Dwi W 785', '56419974785', '3276010023785', 'Depok', '2001-12-23', 'Perempuan', '0851720231785', 'Kp,Babakan No. 785', 'Islam', 6, 5, NULL, NULL, '1', '2022-12-07 14:00:15', NULL, NULL, NULL),
(786, 3, 'P20223786', 'AprilYandi Dwi W 786', '56419974786', '3276010023786', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231786', 'Kp,Babakan No. 786', 'Islam', 11, 9, '1500000.00', NULL, '', '2022-12-07 14:00:15', NULL, NULL, NULL),
(787, 1, 'P20221787', 'AprilYandi Dwi W 787', '56419974787', '3276010023787', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231787', 'Kp,Babakan No. 787', 'Islam', 12, 4, NULL, NULL, '1', '2022-12-07 14:00:15', NULL, NULL, NULL),
(788, 1, 'P20221788', 'AprilYandi Dwi W 788', '56419974788', '3276010023788', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231788', 'Kp,Babakan No. 788', 'Islam', 5, 6, NULL, NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(789, 3, 'P20223789', 'AprilYandi Dwi W 789', '56419974789', '3276010023789', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231789', 'Kp,Babakan No. 789', 'Islam', 7, 5, '1500000.00', NULL, '', '2022-12-07 14:00:16', NULL, NULL, NULL),
(790, 1, 'P20221790', 'AprilYandi Dwi W 790', '56419974790', '3276010023790', 'Depok', '2001-12-06', 'Perempuan', '0851720231790', 'Kp,Babakan No. 790', 'Islam', 3, 6, NULL, NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(791, 1, 'P20221791', 'AprilYandi Dwi W 791', '56419974791', '3276010023791', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231791', 'Kp,Babakan No. 791', 'Islam', 13, 3, NULL, NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(792, 1, 'P20221792', 'AprilYandi Dwi W 792', '56419974792', '3276010023792', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231792', 'Kp,Babakan No. 792', 'Islam', 5, 11, NULL, NULL, '', '2022-12-07 14:00:16', NULL, NULL, NULL),
(793, 2, 'P20222793', 'AprilYandi Dwi W 793', '56419974793', '3276010023793', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231793', 'Kp,Babakan No. 793', 'Islam', 4, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(794, 2, 'P20222794', 'AprilYandi Dwi W 794', '56419974794', '3276010023794', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231794', 'Kp,Babakan No. 794', 'Islam', 3, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(795, 3, 'P20223795', 'AprilYandi Dwi W 795', '56419974795', '3276010023795', 'Depok', '2001-12-09', 'Perempuan', '0851720231795', 'Kp,Babakan No. 795', 'Islam', 13, 6, '1500000.00', NULL, '', '2022-12-07 14:00:16', NULL, NULL, NULL),
(796, 3, 'P20223796', 'AprilYandi Dwi W 796', '56419974796', '3276010023796', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231796', 'Kp,Babakan No. 796', 'Islam', 6, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(797, 1, 'P20221797', 'AprilYandi Dwi W 797', '56419974797', '3276010023797', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231797', 'Kp,Babakan No. 797', 'Islam', 13, 4, NULL, NULL, '1', '2022-12-07 14:00:16', NULL, NULL, NULL),
(798, 2, 'P20222798', 'AprilYandi Dwi W 798', '56419974798', '3276010023798', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231798', 'Kp,Babakan No. 798', 'Islam', 6, 11, '1500000.00', NULL, '', '2022-12-07 14:00:16', NULL, NULL, NULL),
(799, 2, 'P20222799', 'AprilYandi Dwi W 799', '56419974799', '3276010023799', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231799', 'Kp,Babakan No. 799', 'Islam', 9, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:17', NULL, NULL, NULL),
(800, 2, 'P20222800', 'AprilYandi Dwi W 800', '56419974800', '3276010023800', 'Depok', '2001-12-02', 'Perempuan', '0851720231800', 'Kp,Babakan No. 800', 'Islam', 13, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:17', NULL, NULL, NULL),
(801, 1, 'P20221801', 'AprilYandi Dwi W 801', '56419974801', '3276010023801', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231801', 'Kp,Babakan No. 801', 'Islam', 6, 3, NULL, NULL, '', '2022-12-07 14:00:17', NULL, NULL, NULL),
(802, 3, 'P20223802', 'AprilYandi Dwi W 802', '56419974802', '3276010023802', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231802', 'Kp,Babakan No. 802', 'Islam', 9, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:17', NULL, NULL, NULL),
(803, 3, 'P20223803', 'AprilYandi Dwi W 803', '56419974803', '3276010023803', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231803', 'Kp,Babakan No. 803', 'Islam', 10, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:17', NULL, NULL, NULL),
(804, 2, 'P20222804', 'AprilYandi Dwi W 804', '56419974804', '3276010023804', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231804', 'Kp,Babakan No. 804', 'Islam', 2, 8, '1500000.00', NULL, '', '2022-12-07 14:00:17', NULL, NULL, NULL),
(805, 3, 'P20223805', 'AprilYandi Dwi W 805', '56419974805', '3276010023805', 'Depok', '2001-12-06', 'Perempuan', '0851720231805', 'Kp,Babakan No. 805', 'Islam', 2, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:17', NULL, NULL, NULL),
(806, 2, 'P20222806', 'AprilYandi Dwi W 806', '56419974806', '3276010023806', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231806', 'Kp,Babakan No. 806', 'Islam', 6, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:18', NULL, NULL, NULL),
(807, 2, 'P20222807', 'AprilYandi Dwi W 807', '56419974807', '3276010023807', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231807', 'Kp,Babakan No. 807', 'Islam', 12, 12, '1500000.00', NULL, '', '2022-12-07 14:00:18', NULL, NULL, NULL),
(808, 3, 'P20223808', 'AprilYandi Dwi W 808', '56419974808', '3276010023808', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231808', 'Kp,Babakan No. 808', 'Islam', 2, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:18', NULL, NULL, NULL),
(809, 1, 'P20221809', 'AprilYandi Dwi W 809', '56419974809', '3276010023809', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231809', 'Kp,Babakan No. 809', 'Islam', 10, 7, NULL, NULL, '1', '2022-12-07 14:00:18', NULL, NULL, NULL),
(810, 1, 'P20221810', 'AprilYandi Dwi W 810', '56419974810', '3276010023810', 'Depok', '2001-12-14', 'Perempuan', '0851720231810', 'Kp,Babakan No. 810', 'Islam', 11, 6, NULL, NULL, '', '2022-12-07 14:00:18', NULL, NULL, NULL),
(811, 1, 'P20221811', 'AprilYandi Dwi W 811', '56419974811', '3276010023811', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231811', 'Kp,Babakan No. 811', 'Islam', 7, 2, NULL, NULL, '1', '2022-12-07 14:00:18', NULL, NULL, NULL),
(812, 3, 'P20223812', 'AprilYandi Dwi W 812', '56419974812', '3276010023812', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231812', 'Kp,Babakan No. 812', 'Islam', 5, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:18', NULL, NULL, NULL),
(813, 3, 'P20223813', 'AprilYandi Dwi W 813', '56419974813', '3276010023813', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231813', 'Kp,Babakan No. 813', 'Islam', 13, 9, '1500000.00', NULL, '', '2022-12-07 14:00:19', NULL, NULL, NULL),
(814, 2, 'P20222814', 'AprilYandi Dwi W 814', '56419974814', '3276010023814', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231814', 'Kp,Babakan No. 814', 'Islam', 10, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:19', NULL, NULL, NULL),
(815, 2, 'P20222815', 'AprilYandi Dwi W 815', '56419974815', '3276010023815', 'Depok', '2001-12-15', 'Perempuan', '0851720231815', 'Kp,Babakan No. 815', 'Islam', 5, 6, '1500000.00', NULL, '1', '2022-12-07 14:00:19', NULL, NULL, NULL),
(816, 1, 'P20221816', 'AprilYandi Dwi W 816', '56419974816', '3276010023816', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231816', 'Kp,Babakan No. 816', 'Islam', 11, 11, NULL, NULL, '', '2022-12-07 14:00:19', NULL, NULL, NULL),
(817, 3, 'P20223817', 'AprilYandi Dwi W 817', '56419974817', '3276010023817', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231817', 'Kp,Babakan No. 817', 'Islam', 13, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:19', NULL, NULL, NULL),
(818, 1, 'P20221818', 'AprilYandi Dwi W 818', '56419974818', '3276010023818', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231818', 'Kp,Babakan No. 818', 'Islam', 13, 6, NULL, NULL, '1', '2022-12-07 14:00:19', NULL, NULL, NULL),
(819, 2, 'P20222819', 'AprilYandi Dwi W 819', '56419974819', '3276010023819', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231819', 'Kp,Babakan No. 819', 'Islam', 3, 10, '1500000.00', NULL, '', '2022-12-07 14:00:19', NULL, NULL, NULL),
(820, 3, 'P20223820', 'AprilYandi Dwi W 820', '56419974820', '3276010023820', 'Depok', '2001-12-15', 'Perempuan', '0851720231820', 'Kp,Babakan No. 820', 'Islam', 13, 6, '1500000.00', NULL, '1', '2022-12-07 14:00:19', NULL, NULL, NULL),
(821, 2, 'P20222821', 'AprilYandi Dwi W 821', '56419974821', '3276010023821', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231821', 'Kp,Babakan No. 821', 'Islam', 7, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(822, 3, 'P20223822', 'AprilYandi Dwi W 822', '56419974822', '3276010023822', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231822', 'Kp,Babakan No. 822', 'Islam', 13, 3, '1500000.00', NULL, '', '2022-12-07 14:00:20', NULL, NULL, NULL),
(823, 3, 'P20223823', 'AprilYandi Dwi W 823', '56419974823', '3276010023823', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231823', 'Kp,Babakan No. 823', 'Islam', 10, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(824, 2, 'P20222824', 'AprilYandi Dwi W 824', '56419974824', '3276010023824', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231824', 'Kp,Babakan No. 824', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(825, 1, 'P20221825', 'AprilYandi Dwi W 825', '56419974825', '3276010023825', 'Depok', '2001-12-06', 'Perempuan', '0851720231825', 'Kp,Babakan No. 825', 'Islam', 5, 9, NULL, NULL, '', '2022-12-07 14:00:20', NULL, NULL, NULL),
(826, 1, 'P20221826', 'AprilYandi Dwi W 826', '56419974826', '3276010023826', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231826', 'Kp,Babakan No. 826', 'Islam', 12, 10, NULL, NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(827, 1, 'P20221827', 'AprilYandi Dwi W 827', '56419974827', '3276010023827', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231827', 'Kp,Babakan No. 827', 'Islam', 4, 8, NULL, NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(828, 1, 'P20221828', 'AprilYandi Dwi W 828', '56419974828', '3276010023828', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231828', 'Kp,Babakan No. 828', 'Islam', 1, 13, NULL, NULL, '', '2022-12-07 14:00:20', NULL, NULL, NULL),
(829, 2, 'P20222829', 'AprilYandi Dwi W 829', '56419974829', '3276010023829', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231829', 'Kp,Babakan No. 829', 'Islam', 5, 12, '1500000.00', NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(830, 2, 'P20222830', 'AprilYandi Dwi W 830', '56419974830', '3276010023830', 'Depok', '2001-12-17', 'Perempuan', '0851720231830', 'Kp,Babakan No. 830', 'Islam', 9, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:20', NULL, NULL, NULL),
(831, 2, 'P20222831', 'AprilYandi Dwi W 831', '56419974831', '3276010023831', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231831', 'Kp,Babakan No. 831', 'Islam', 3, 5, '1500000.00', NULL, '', '2022-12-07 14:00:20', NULL, NULL, NULL),
(832, 3, 'P20223832', 'AprilYandi Dwi W 832', '56419974832', '3276010023832', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231832', 'Kp,Babakan No. 832', 'Islam', 1, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:21', NULL, NULL, NULL),
(833, 2, 'P20222833', 'AprilYandi Dwi W 833', '56419974833', '3276010023833', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231833', 'Kp,Babakan No. 833', 'Islam', 1, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:21', NULL, NULL, NULL),
(834, 2, 'P20222834', 'AprilYandi Dwi W 834', '56419974834', '3276010023834', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231834', 'Kp,Babakan No. 834', 'Islam', 8, 4, '1500000.00', NULL, '', '2022-12-07 14:00:21', NULL, NULL, NULL),
(835, 2, 'P20222835', 'AprilYandi Dwi W 835', '56419974835', '3276010023835', 'Depok', '2001-12-06', 'Perempuan', '0851720231835', 'Kp,Babakan No. 835', 'Islam', 8, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:21', NULL, NULL, NULL),
(836, 1, 'P20221836', 'AprilYandi Dwi W 836', '56419974836', '3276010023836', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231836', 'Kp,Babakan No. 836', 'Islam', 8, 1, NULL, NULL, '1', '2022-12-07 14:00:21', NULL, NULL, NULL),
(837, 3, 'P20223837', 'AprilYandi Dwi W 837', '56419974837', '3276010023837', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231837', 'Kp,Babakan No. 837', 'Islam', 10, 6, '1500000.00', NULL, '', '2022-12-07 14:00:22', NULL, NULL, NULL),
(838, 1, 'P20221838', 'AprilYandi Dwi W 838', '56419974838', '3276010023838', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231838', 'Kp,Babakan No. 838', 'Islam', 13, 8, NULL, NULL, '1', '2022-12-07 14:00:22', NULL, NULL, NULL),
(839, 2, 'P20222839', 'AprilYandi Dwi W 839', '56419974839', '3276010023839', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231839', 'Kp,Babakan No. 839', 'Islam', 7, 12, '1500000.00', NULL, '1', '2022-12-07 14:00:22', NULL, NULL, NULL),
(840, 2, 'P20222840', 'AprilYandi Dwi W 840', '56419974840', '3276010023840', 'Depok', '2001-12-27', 'Perempuan', '0851720231840', 'Kp,Babakan No. 840', 'Islam', 6, 1, '1500000.00', NULL, '', '2022-12-07 14:00:22', NULL, NULL, NULL),
(841, 1, 'P20221841', 'AprilYandi Dwi W 841', '56419974841', '3276010023841', 'Jakarta', '2001-12-20', 'Laki-Laki', '0851720231841', 'Kp,Babakan No. 841', 'Islam', 5, 6, NULL, NULL, '1', '2022-12-07 14:00:22', NULL, NULL, NULL),
(842, 3, 'P20223842', 'AprilYandi Dwi W 842', '56419974842', '3276010023842', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231842', 'Kp,Babakan No. 842', 'Islam', 5, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:22', NULL, NULL, NULL),
(843, 2, 'P20222843', 'AprilYandi Dwi W 843', '56419974843', '3276010023843', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231843', 'Kp,Babakan No. 843', 'Islam', 6, 5, '1500000.00', NULL, '', '2022-12-07 14:00:22', NULL, NULL, NULL),
(844, 3, 'P20223844', 'AprilYandi Dwi W 844', '56419974844', '3276010023844', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231844', 'Kp,Babakan No. 844', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:23', NULL, NULL, NULL),
(845, 1, 'P20221845', 'AprilYandi Dwi W 845', '56419974845', '3276010023845', 'Depok', '2001-12-31', 'Perempuan', '0851720231845', 'Kp,Babakan No. 845', 'Islam', 8, 8, NULL, NULL, '1', '2022-12-07 14:00:23', NULL, NULL, NULL),
(846, 3, 'P20223846', 'AprilYandi Dwi W 846', '56419974846', '3276010023846', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231846', 'Kp,Babakan No. 846', 'Islam', 6, 12, '1500000.00', NULL, '', '2022-12-07 14:00:23', NULL, NULL, NULL),
(847, 2, 'P20222847', 'AprilYandi Dwi W 847', '56419974847', '3276010023847', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231847', 'Kp,Babakan No. 847', 'Islam', 13, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:23', NULL, NULL, NULL),
(848, 2, 'P20222848', 'AprilYandi Dwi W 848', '56419974848', '3276010023848', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231848', 'Kp,Babakan No. 848', 'Islam', 4, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:23', NULL, NULL, NULL),
(849, 3, 'P20223849', 'AprilYandi Dwi W 849', '56419974849', '3276010023849', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231849', 'Kp,Babakan No. 849', 'Islam', 13, 12, '1500000.00', NULL, '', '2022-12-07 14:00:23', NULL, NULL, NULL),
(850, 3, 'P20223850', 'AprilYandi Dwi W 850', '56419974850', '3276010023850', 'Depok', '2001-12-04', 'Perempuan', '0851720231850', 'Kp,Babakan No. 850', 'Islam', 9, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:24', NULL, NULL, NULL),
(851, 2, 'P20222851', 'AprilYandi Dwi W 851', '56419974851', '3276010023851', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231851', 'Kp,Babakan No. 851', 'Islam', 5, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:24', NULL, NULL, NULL),
(852, 3, 'P20223852', 'AprilYandi Dwi W 852', '56419974852', '3276010023852', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231852', 'Kp,Babakan No. 852', 'Islam', 7, 12, '1500000.00', NULL, '', '2022-12-07 14:00:25', NULL, NULL, NULL),
(853, 3, 'P20223853', 'AprilYandi Dwi W 853', '56419974853', '3276010023853', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231853', 'Kp,Babakan No. 853', 'Islam', 5, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:25', NULL, NULL, NULL),
(854, 1, 'P20221854', 'AprilYandi Dwi W 854', '56419974854', '3276010023854', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231854', 'Kp,Babakan No. 854', 'Islam', 11, 4, NULL, NULL, '1', '2022-12-07 14:00:25', NULL, NULL, NULL),
(855, 1, 'P20221855', 'AprilYandi Dwi W 855', '56419974855', '3276010023855', 'Depok', '2001-12-28', 'Perempuan', '0851720231855', 'Kp,Babakan No. 855', 'Islam', 10, 7, NULL, NULL, '', '2022-12-07 14:00:25', NULL, NULL, NULL),
(856, 2, 'P20222856', 'AprilYandi Dwi W 856', '56419974856', '3276010023856', 'Jakarta', '2001-12-05', 'Laki-Laki', '0851720231856', 'Kp,Babakan No. 856', 'Islam', 9, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:25', NULL, NULL, NULL),
(857, 3, 'P20223857', 'AprilYandi Dwi W 857', '56419974857', '3276010023857', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231857', 'Kp,Babakan No. 857', 'Islam', 5, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:25', NULL, NULL, NULL),
(858, 3, 'P20223858', 'AprilYandi Dwi W 858', '56419974858', '3276010023858', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231858', 'Kp,Babakan No. 858', 'Islam', 13, 5, '1500000.00', NULL, '', '2022-12-07 14:00:25', NULL, NULL, NULL),
(859, 1, 'P20221859', 'AprilYandi Dwi W 859', '56419974859', '3276010023859', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231859', 'Kp,Babakan No. 859', 'Islam', 2, 7, NULL, NULL, '1', '2022-12-07 14:00:26', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(860, 3, 'P20223860', 'AprilYandi Dwi W 860', '56419974860', '3276010023860', 'Depok', '2001-12-10', 'Perempuan', '0851720231860', 'Kp,Babakan No. 860', 'Islam', 12, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:26', NULL, NULL, NULL),
(861, 2, 'P20222861', 'AprilYandi Dwi W 861', '56419974861', '3276010023861', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231861', 'Kp,Babakan No. 861', 'Islam', 1, 4, '1500000.00', NULL, '', '2022-12-07 14:00:26', NULL, NULL, NULL),
(862, 2, 'P20222862', 'AprilYandi Dwi W 862', '56419974862', '3276010023862', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231862', 'Kp,Babakan No. 862', 'Islam', 11, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:26', NULL, NULL, NULL),
(863, 1, 'P20221863', 'AprilYandi Dwi W 863', '56419974863', '3276010023863', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231863', 'Kp,Babakan No. 863', 'Islam', 13, 3, NULL, NULL, '1', '2022-12-07 14:00:26', NULL, NULL, NULL),
(864, 1, 'P20221864', 'AprilYandi Dwi W 864', '56419974864', '3276010023864', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231864', 'Kp,Babakan No. 864', 'Islam', 7, 5, NULL, NULL, '', '2022-12-07 14:00:26', NULL, NULL, NULL),
(865, 2, 'P20222865', 'AprilYandi Dwi W 865', '56419974865', '3276010023865', 'Depok', '2001-12-10', 'Perempuan', '0851720231865', 'Kp,Babakan No. 865', 'Islam', 8, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:26', NULL, NULL, NULL),
(866, 2, 'P20222866', 'AprilYandi Dwi W 866', '56419974866', '3276010023866', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231866', 'Kp,Babakan No. 866', 'Islam', 5, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:26', NULL, NULL, NULL),
(867, 3, 'P20223867', 'AprilYandi Dwi W 867', '56419974867', '3276010023867', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231867', 'Kp,Babakan No. 867', 'Islam', 4, 3, '1500000.00', NULL, '', '2022-12-07 14:00:26', NULL, NULL, NULL),
(868, 1, 'P20221868', 'AprilYandi Dwi W 868', '56419974868', '3276010023868', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231868', 'Kp,Babakan No. 868', 'Islam', 4, 12, NULL, NULL, '1', '2022-12-07 14:00:27', NULL, NULL, NULL),
(869, 2, 'P20222869', 'AprilYandi Dwi W 869', '56419974869', '3276010023869', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231869', 'Kp,Babakan No. 869', 'Islam', 4, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:27', NULL, NULL, NULL),
(870, 3, 'P20223870', 'AprilYandi Dwi W 870', '56419974870', '3276010023870', 'Depok', '2001-12-11', 'Perempuan', '0851720231870', 'Kp,Babakan No. 870', 'Islam', 6, 11, '1500000.00', NULL, '', '2022-12-07 14:00:27', NULL, NULL, NULL),
(871, 1, 'P20221871', 'AprilYandi Dwi W 871', '56419974871', '3276010023871', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231871', 'Kp,Babakan No. 871', 'Islam', 5, 13, NULL, NULL, '1', '2022-12-07 14:00:27', NULL, NULL, NULL),
(872, 3, 'P20223872', 'AprilYandi Dwi W 872', '56419974872', '3276010023872', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231872', 'Kp,Babakan No. 872', 'Islam', 10, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:27', NULL, NULL, NULL),
(873, 3, 'P20223873', 'AprilYandi Dwi W 873', '56419974873', '3276010023873', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231873', 'Kp,Babakan No. 873', 'Islam', 7, 12, '1500000.00', NULL, '', '2022-12-07 14:00:27', NULL, NULL, NULL),
(874, 3, 'P20223874', 'AprilYandi Dwi W 874', '56419974874', '3276010023874', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231874', 'Kp,Babakan No. 874', 'Islam', 6, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:28', NULL, NULL, NULL),
(875, 2, 'P20222875', 'AprilYandi Dwi W 875', '56419974875', '3276010023875', 'Depok', '2001-12-10', 'Perempuan', '0851720231875', 'Kp,Babakan No. 875', 'Islam', 8, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:28', NULL, NULL, NULL),
(876, 2, 'P20222876', 'AprilYandi Dwi W 876', '56419974876', '3276010023876', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231876', 'Kp,Babakan No. 876', 'Islam', 12, 11, '1500000.00', NULL, '', '2022-12-07 14:00:28', NULL, NULL, NULL),
(877, 1, 'P20221877', 'AprilYandi Dwi W 877', '56419974877', '3276010023877', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231877', 'Kp,Babakan No. 877', 'Islam', 7, 7, NULL, NULL, '1', '2022-12-07 14:00:28', NULL, NULL, NULL),
(878, 1, 'P20221878', 'AprilYandi Dwi W 878', '56419974878', '3276010023878', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231878', 'Kp,Babakan No. 878', 'Islam', 9, 3, NULL, NULL, '1', '2022-12-07 14:00:28', NULL, NULL, NULL),
(879, 2, 'P20222879', 'AprilYandi Dwi W 879', '56419974879', '3276010023879', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231879', 'Kp,Babakan No. 879', 'Islam', 4, 9, '1500000.00', NULL, '', '2022-12-07 14:00:29', NULL, NULL, NULL),
(880, 2, 'P20222880', 'AprilYandi Dwi W 880', '56419974880', '3276010023880', 'Depok', '2001-12-10', 'Perempuan', '0851720231880', 'Kp,Babakan No. 880', 'Islam', 12, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:29', NULL, NULL, NULL),
(881, 3, 'P20223881', 'AprilYandi Dwi W 881', '56419974881', '3276010023881', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231881', 'Kp,Babakan No. 881', 'Islam', 12, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:29', NULL, NULL, NULL),
(882, 1, 'P20221882', 'AprilYandi Dwi W 882', '56419974882', '3276010023882', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231882', 'Kp,Babakan No. 882', 'Islam', 1, 1, NULL, NULL, '', '2022-12-07 14:00:29', NULL, NULL, NULL),
(883, 2, 'P20222883', 'AprilYandi Dwi W 883', '56419974883', '3276010023883', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231883', 'Kp,Babakan No. 883', 'Islam', 13, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:30', NULL, NULL, NULL),
(884, 3, 'P20223884', 'AprilYandi Dwi W 884', '56419974884', '3276010023884', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231884', 'Kp,Babakan No. 884', 'Islam', 3, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:30', NULL, NULL, NULL),
(885, 3, 'P20223885', 'AprilYandi Dwi W 885', '56419974885', '3276010023885', 'Depok', '2001-12-22', 'Perempuan', '0851720231885', 'Kp,Babakan No. 885', 'Islam', 8, 6, '1500000.00', NULL, '', '2022-12-07 14:00:30', NULL, NULL, NULL),
(886, 2, 'P20222886', 'AprilYandi Dwi W 886', '56419974886', '3276010023886', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231886', 'Kp,Babakan No. 886', 'Islam', 3, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:30', NULL, NULL, NULL),
(887, 1, 'P20221887', 'AprilYandi Dwi W 887', '56419974887', '3276010023887', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231887', 'Kp,Babakan No. 887', 'Islam', 1, 1, NULL, NULL, '1', '2022-12-07 14:00:30', NULL, NULL, NULL),
(888, 2, 'P20222888', 'AprilYandi Dwi W 888', '56419974888', '3276010023888', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231888', 'Kp,Babakan No. 888', 'Islam', 5, 1, '1500000.00', NULL, '', '2022-12-07 14:00:31', NULL, NULL, NULL),
(889, 1, 'P20221889', 'AprilYandi Dwi W 889', '56419974889', '3276010023889', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231889', 'Kp,Babakan No. 889', 'Islam', 7, 2, NULL, NULL, '1', '2022-12-07 14:00:31', NULL, NULL, NULL),
(890, 3, 'P20223890', 'AprilYandi Dwi W 890', '56419974890', '3276010023890', 'Depok', '2001-12-20', 'Perempuan', '0851720231890', 'Kp,Babakan No. 890', 'Islam', 5, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:31', NULL, NULL, NULL),
(891, 1, 'P20221891', 'AprilYandi Dwi W 891', '56419974891', '3276010023891', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231891', 'Kp,Babakan No. 891', 'Islam', 9, 13, NULL, NULL, '', '2022-12-07 14:00:31', NULL, NULL, NULL),
(892, 2, 'P20222892', 'AprilYandi Dwi W 892', '56419974892', '3276010023892', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231892', 'Kp,Babakan No. 892', 'Islam', 4, 6, '1500000.00', NULL, '1', '2022-12-07 14:00:31', NULL, NULL, NULL),
(893, 1, 'P20221893', 'AprilYandi Dwi W 893', '56419974893', '3276010023893', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231893', 'Kp,Babakan No. 893', 'Islam', 12, 10, NULL, NULL, '1', '2022-12-07 14:00:31', NULL, NULL, NULL),
(894, 2, 'P20222894', 'AprilYandi Dwi W 894', '56419974894', '3276010023894', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231894', 'Kp,Babakan No. 894', 'Islam', 9, 3, '1500000.00', NULL, '', '2022-12-07 14:00:32', NULL, NULL, NULL),
(895, 3, 'P20223895', 'AprilYandi Dwi W 895', '56419974895', '3276010023895', 'Depok', '2001-12-13', 'Perempuan', '0851720231895', 'Kp,Babakan No. 895', 'Islam', 2, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:32', NULL, NULL, NULL),
(896, 1, 'P20221896', 'AprilYandi Dwi W 896', '56419974896', '3276010023896', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231896', 'Kp,Babakan No. 896', 'Islam', 8, 8, NULL, NULL, '1', '2022-12-07 14:00:32', NULL, NULL, NULL),
(897, 2, 'P20222897', 'AprilYandi Dwi W 897', '56419974897', '3276010023897', 'Jakarta', '2001-12-26', 'Laki-Laki', '0851720231897', 'Kp,Babakan No. 897', 'Islam', 12, 10, '1500000.00', NULL, '', '2022-12-07 14:00:32', NULL, NULL, NULL),
(898, 1, 'P20221898', 'AprilYandi Dwi W 898', '56419974898', '3276010023898', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231898', 'Kp,Babakan No. 898', 'Islam', 11, 9, NULL, NULL, '1', '2022-12-07 14:00:32', NULL, NULL, NULL),
(899, 2, 'P20222899', 'AprilYandi Dwi W 899', '56419974899', '3276010023899', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231899', 'Kp,Babakan No. 899', 'Islam', 4, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:32', NULL, NULL, NULL),
(900, 2, 'P20222900', 'AprilYandi Dwi W 900', '56419974900', '3276010023900', 'Depok', '2001-12-30', 'Perempuan', '0851720231900', 'Kp,Babakan No. 900', 'Islam', 4, 1, '1500000.00', NULL, '', '2022-12-07 14:00:32', NULL, NULL, NULL),
(901, 1, 'P20221901', 'AprilYandi Dwi W 901', '56419974901', '3276010023901', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231901', 'Kp,Babakan No. 901', 'Islam', 3, 4, NULL, NULL, '1', '2022-12-07 14:00:33', NULL, NULL, NULL),
(902, 1, 'P20221902', 'AprilYandi Dwi W 902', '56419974902', '3276010023902', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231902', 'Kp,Babakan No. 902', 'Islam', 4, 12, NULL, NULL, '1', '2022-12-07 14:00:33', NULL, NULL, NULL),
(903, 1, 'P20221903', 'AprilYandi Dwi W 903', '56419974903', '3276010023903', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231903', 'Kp,Babakan No. 903', 'Islam', 7, 8, NULL, NULL, '', '2022-12-07 14:00:33', NULL, NULL, NULL),
(904, 3, 'P20223904', 'AprilYandi Dwi W 904', '56419974904', '3276010023904', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231904', 'Kp,Babakan No. 904', 'Islam', 12, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:33', NULL, NULL, NULL),
(905, 2, 'P20222905', 'AprilYandi Dwi W 905', '56419974905', '3276010023905', 'Depok', '2001-12-06', 'Perempuan', '0851720231905', 'Kp,Babakan No. 905', 'Islam', 7, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:33', NULL, NULL, NULL),
(906, 1, 'P20221906', 'AprilYandi Dwi W 906', '56419974906', '3276010023906', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231906', 'Kp,Babakan No. 906', 'Islam', 3, 4, NULL, NULL, '', '2022-12-07 14:00:33', NULL, NULL, NULL),
(907, 2, 'P20222907', 'AprilYandi Dwi W 907', '56419974907', '3276010023907', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231907', 'Kp,Babakan No. 907', 'Islam', 11, 2, '1500000.00', NULL, '1', '2022-12-07 14:00:34', NULL, NULL, NULL),
(908, 1, 'P20221908', 'AprilYandi Dwi W 908', '56419974908', '3276010023908', 'Jakarta', '2001-12-29', 'Laki-Laki', '0851720231908', 'Kp,Babakan No. 908', 'Islam', 9, 2, NULL, NULL, '1', '2022-12-07 14:00:35', NULL, NULL, NULL),
(909, 1, 'P20221909', 'AprilYandi Dwi W 909', '56419974909', '3276010023909', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231909', 'Kp,Babakan No. 909', 'Islam', 11, 11, NULL, NULL, '', '2022-12-07 14:00:35', NULL, NULL, NULL),
(910, 1, 'P20221910', 'AprilYandi Dwi W 910', '56419974910', '3276010023910', 'Depok', '2001-12-10', 'Perempuan', '0851720231910', 'Kp,Babakan No. 910', 'Islam', 7, 3, NULL, NULL, '1', '2022-12-07 14:00:35', NULL, NULL, NULL),
(911, 3, 'P20223911', 'AprilYandi Dwi W 911', '56419974911', '3276010023911', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231911', 'Kp,Babakan No. 911', 'Islam', 10, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:35', NULL, NULL, NULL),
(912, 3, 'P20223912', 'AprilYandi Dwi W 912', '56419974912', '3276010023912', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231912', 'Kp,Babakan No. 912', 'Islam', 9, 11, '1500000.00', NULL, '', '2022-12-07 14:00:35', NULL, NULL, NULL),
(913, 3, 'P20223913', 'AprilYandi Dwi W 913', '56419974913', '3276010023913', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231913', 'Kp,Babakan No. 913', 'Islam', 13, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:35', NULL, NULL, NULL),
(914, 1, 'P20221914', 'AprilYandi Dwi W 914', '56419974914', '3276010023914', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231914', 'Kp,Babakan No. 914', 'Islam', 13, 10, NULL, NULL, '1', '2022-12-07 14:00:36', NULL, NULL, NULL),
(915, 2, 'P20222915', 'AprilYandi Dwi W 915', '56419974915', '3276010023915', 'Depok', '2001-12-07', 'Perempuan', '0851720231915', 'Kp,Babakan No. 915', 'Islam', 4, 9, '1500000.00', NULL, '', '2022-12-07 14:00:36', NULL, NULL, NULL),
(916, 1, 'P20221916', 'AprilYandi Dwi W 916', '56419974916', '3276010023916', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231916', 'Kp,Babakan No. 916', 'Islam', 9, 8, NULL, NULL, '1', '2022-12-07 14:00:36', NULL, NULL, NULL),
(917, 3, 'P20223917', 'AprilYandi Dwi W 917', '56419974917', '3276010023917', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231917', 'Kp,Babakan No. 917', 'Islam', 1, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:36', NULL, NULL, NULL),
(918, 2, 'P20222918', 'AprilYandi Dwi W 918', '56419974918', '3276010023918', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231918', 'Kp,Babakan No. 918', 'Islam', 11, 11, '1500000.00', NULL, '', '2022-12-07 14:00:37', NULL, NULL, NULL),
(919, 1, 'P20221919', 'AprilYandi Dwi W 919', '56419974919', '3276010023919', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231919', 'Kp,Babakan No. 919', 'Islam', 8, 2, NULL, NULL, '1', '2022-12-07 14:00:37', NULL, NULL, NULL),
(920, 1, 'P20221920', 'AprilYandi Dwi W 920', '56419974920', '3276010023920', 'Depok', '2001-12-03', 'Perempuan', '0851720231920', 'Kp,Babakan No. 920', 'Islam', 12, 1, NULL, NULL, '1', '2022-12-07 14:00:37', NULL, NULL, NULL),
(921, 1, 'P20221921', 'AprilYandi Dwi W 921', '56419974921', '3276010023921', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231921', 'Kp,Babakan No. 921', 'Islam', 3, 4, NULL, NULL, '', '2022-12-07 14:00:37', NULL, NULL, NULL),
(922, 1, 'P20221922', 'AprilYandi Dwi W 922', '56419974922', '3276010023922', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231922', 'Kp,Babakan No. 922', 'Islam', 2, 10, NULL, NULL, '1', '2022-12-07 14:00:37', NULL, NULL, NULL),
(923, 3, 'P20223923', 'AprilYandi Dwi W 923', '56419974923', '3276010023923', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231923', 'Kp,Babakan No. 923', 'Islam', 2, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:38', NULL, NULL, NULL),
(924, 2, 'P20222924', 'AprilYandi Dwi W 924', '56419974924', '3276010023924', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231924', 'Kp,Babakan No. 924', 'Islam', 2, 4, '1500000.00', NULL, '', '2022-12-07 14:00:38', NULL, NULL, NULL),
(925, 2, 'P20222925', 'AprilYandi Dwi W 925', '56419974925', '3276010023925', 'Depok', '2001-12-10', 'Perempuan', '0851720231925', 'Kp,Babakan No. 925', 'Islam', 2, 3, '1500000.00', NULL, '1', '2022-12-07 14:00:38', NULL, NULL, NULL),
(926, 3, 'P20223926', 'AprilYandi Dwi W 926', '56419974926', '3276010023926', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231926', 'Kp,Babakan No. 926', 'Islam', 10, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:38', NULL, NULL, NULL),
(927, 1, 'P20221927', 'AprilYandi Dwi W 927', '56419974927', '3276010023927', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231927', 'Kp,Babakan No. 927', 'Islam', 4, 12, NULL, NULL, '', '2022-12-07 14:00:39', NULL, NULL, NULL),
(928, 1, 'P20221928', 'AprilYandi Dwi W 928', '56419974928', '3276010023928', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231928', 'Kp,Babakan No. 928', 'Islam', 9, 3, NULL, NULL, '1', '2022-12-07 14:00:39', NULL, NULL, NULL),
(929, 2, 'P20222929', 'AprilYandi Dwi W 929', '56419974929', '3276010023929', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231929', 'Kp,Babakan No. 929', 'Islam', 2, 1, '1500000.00', NULL, '1', '2022-12-07 14:00:39', NULL, NULL, NULL),
(930, 2, 'P20222930', 'AprilYandi Dwi W 930', '56419974930', '3276010023930', 'Depok', '2001-12-04', 'Perempuan', '0851720231930', 'Kp,Babakan No. 930', 'Islam', 13, 1, '1500000.00', NULL, '', '2022-12-07 14:00:39', NULL, NULL, NULL),
(931, 3, 'P20223931', 'AprilYandi Dwi W 931', '56419974931', '3276010023931', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231931', 'Kp,Babakan No. 931', 'Islam', 6, 6, '1500000.00', NULL, '1', '2022-12-07 14:00:39', NULL, NULL, NULL),
(932, 1, 'P20221932', 'AprilYandi Dwi W 932', '56419974932', '3276010023932', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231932', 'Kp,Babakan No. 932', 'Islam', 5, 10, NULL, NULL, '1', '2022-12-07 14:00:39', NULL, NULL, NULL),
(933, 2, 'P20222933', 'AprilYandi Dwi W 933', '56419974933', '3276010023933', 'Jakarta', '2001-12-21', 'Laki-Laki', '0851720231933', 'Kp,Babakan No. 933', 'Islam', 11, 1, '1500000.00', NULL, '', '2022-12-07 14:00:40', NULL, NULL, NULL),
(934, 2, 'P20222934', 'AprilYandi Dwi W 934', '56419974934', '3276010023934', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231934', 'Kp,Babakan No. 934', 'Islam', 12, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:40', NULL, NULL, NULL),
(935, 2, 'P20222935', 'AprilYandi Dwi W 935', '56419974935', '3276010023935', 'Depok', '2001-12-02', 'Perempuan', '0851720231935', 'Kp,Babakan No. 935', 'Islam', 8, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:40', NULL, NULL, NULL),
(936, 2, 'P20222936', 'AprilYandi Dwi W 936', '56419974936', '3276010023936', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231936', 'Kp,Babakan No. 936', 'Islam', 2, 3, '1500000.00', NULL, '', '2022-12-07 14:00:40', NULL, NULL, NULL),
(937, 2, 'P20222937', 'AprilYandi Dwi W 937', '56419974937', '3276010023937', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231937', 'Kp,Babakan No. 937', 'Islam', 6, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:40', NULL, NULL, NULL),
(938, 3, 'P20223938', 'AprilYandi Dwi W 938', '56419974938', '3276010023938', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231938', 'Kp,Babakan No. 938', 'Islam', 11, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:40', NULL, NULL, NULL),
(939, 3, 'P20223939', 'AprilYandi Dwi W 939', '56419974939', '3276010023939', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231939', 'Kp,Babakan No. 939', 'Islam', 3, 12, '1500000.00', NULL, '', '2022-12-07 14:00:41', NULL, NULL, NULL),
(940, 2, 'P20222940', 'AprilYandi Dwi W 940', '56419974940', '3276010023940', 'Depok', '2001-12-27', 'Perempuan', '0851720231940', 'Kp,Babakan No. 940', 'Islam', 2, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:41', NULL, NULL, NULL),
(941, 3, 'P20223941', 'AprilYandi Dwi W 941', '56419974941', '3276010023941', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231941', 'Kp,Babakan No. 941', 'Islam', 9, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:41', NULL, NULL, NULL),
(942, 1, 'P20221942', 'AprilYandi Dwi W 942', '56419974942', '3276010023942', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231942', 'Kp,Babakan No. 942', 'Islam', 8, 1, NULL, NULL, '', '2022-12-07 14:00:42', NULL, NULL, NULL),
(943, 3, 'P20223943', 'AprilYandi Dwi W 943', '56419974943', '3276010023943', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231943', 'Kp,Babakan No. 943', 'Islam', 13, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:43', NULL, NULL, NULL),
(944, 1, 'P20221944', 'AprilYandi Dwi W 944', '56419974944', '3276010023944', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231944', 'Kp,Babakan No. 944', 'Islam', 13, 3, NULL, NULL, '1', '2022-12-07 14:00:43', NULL, NULL, NULL),
(945, 2, 'P20222945', 'AprilYandi Dwi W 945', '56419974945', '3276010023945', 'Depok', '2001-12-26', 'Perempuan', '0851720231945', 'Kp,Babakan No. 945', 'Islam', 3, 2, '1500000.00', NULL, '', '2022-12-07 14:00:43', NULL, NULL, NULL),
(946, 1, 'P20221946', 'AprilYandi Dwi W 946', '56419974946', '3276010023946', 'Jakarta', '2001-12-03', 'Laki-Laki', '0851720231946', 'Kp,Babakan No. 946', 'Islam', 2, 1, NULL, NULL, '1', '2022-12-07 14:00:43', NULL, NULL, NULL),
(947, 2, 'P20222947', 'AprilYandi Dwi W 947', '56419974947', '3276010023947', 'Jakarta', '2001-12-12', 'Laki-Laki', '0851720231947', 'Kp,Babakan No. 947', 'Islam', 5, 8, '1500000.00', NULL, '1', '2022-12-07 14:00:43', NULL, NULL, NULL),
(948, 2, 'P20222948', 'AprilYandi Dwi W 948', '56419974948', '3276010023948', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231948', 'Kp,Babakan No. 948', 'Islam', 1, 11, '1500000.00', NULL, '', '2022-12-07 14:00:44', NULL, NULL, NULL),
(949, 3, 'P20223949', 'AprilYandi Dwi W 949', '56419974949', '3276010023949', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231949', 'Kp,Babakan No. 949', 'Islam', 12, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:44', NULL, NULL, NULL),
(950, 2, 'P20222950', 'AprilYandi Dwi W 950', '56419974950', '3276010023950', 'Depok', '2001-12-26', 'Perempuan', '0851720231950', 'Kp,Babakan No. 950', 'Islam', 8, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:44', NULL, NULL, NULL),
(951, 2, 'P20222951', 'AprilYandi Dwi W 951', '56419974951', '3276010023951', 'Jakarta', '2001-12-27', 'Laki-Laki', '0851720231951', 'Kp,Babakan No. 951', 'Islam', 2, 4, '1500000.00', NULL, '', '2022-12-07 14:00:44', NULL, NULL, NULL),
(952, 3, 'P20223952', 'AprilYandi Dwi W 952', '56419974952', '3276010023952', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231952', 'Kp,Babakan No. 952', 'Islam', 4, 7, '1500000.00', NULL, '1', '2022-12-07 14:00:44', NULL, NULL, NULL),
(953, 1, 'P20221953', 'AprilYandi Dwi W 953', '56419974953', '3276010023953', 'Jakarta', '2001-12-23', 'Laki-Laki', '0851720231953', 'Kp,Babakan No. 953', 'Islam', 13, 12, NULL, NULL, '1', '2022-12-07 14:00:44', NULL, NULL, NULL),
(954, 3, 'P20223954', 'AprilYandi Dwi W 954', '56419974954', '3276010023954', 'Jakarta', '2001-12-22', 'Laki-Laki', '0851720231954', 'Kp,Babakan No. 954', 'Islam', 13, 9, '1500000.00', NULL, '', '2022-12-07 14:00:45', NULL, NULL, NULL),
(955, 2, 'P20222955', 'AprilYandi Dwi W 955', '56419974955', '3276010023955', 'Depok', '2001-12-17', 'Perempuan', '0851720231955', 'Kp,Babakan No. 955', 'Islam', 3, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:45', NULL, NULL, NULL),
(956, 1, 'P20221956', 'AprilYandi Dwi W 956', '56419974956', '3276010023956', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231956', 'Kp,Babakan No. 956', 'Islam', 8, 6, NULL, NULL, '1', '2022-12-07 14:00:45', NULL, NULL, NULL),
(957, 3, 'P20223957', 'AprilYandi Dwi W 957', '56419974957', '3276010023957', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231957', 'Kp,Babakan No. 957', 'Islam', 1, 3, '1500000.00', NULL, '', '2022-12-07 14:00:45', NULL, NULL, NULL),
(958, 2, 'P20222958', 'AprilYandi Dwi W 958', '56419974958', '3276010023958', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231958', 'Kp,Babakan No. 958', 'Islam', 4, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:45', NULL, NULL, NULL),
(959, 1, 'P20221959', 'AprilYandi Dwi W 959', '56419974959', '3276010023959', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231959', 'Kp,Babakan No. 959', 'Islam', 8, 8, NULL, NULL, '1', '2022-12-07 14:00:45', NULL, NULL, NULL),
(960, 3, 'P20223960', 'AprilYandi Dwi W 960', '56419974960', '3276010023960', 'Depok', '2001-12-12', 'Perempuan', '0851720231960', 'Kp,Babakan No. 960', 'Islam', 12, 6, '1500000.00', NULL, '', '2022-12-07 14:00:46', NULL, NULL, NULL),
(961, 2, 'P20222961', 'AprilYandi Dwi W 961', '56419974961', '3276010023961', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231961', 'Kp,Babakan No. 961', 'Islam', 13, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:46', NULL, NULL, NULL),
(962, 3, 'P20223962', 'AprilYandi Dwi W 962', '56419974962', '3276010023962', 'Jakarta', '2001-12-06', 'Laki-Laki', '0851720231962', 'Kp,Babakan No. 962', 'Islam', 3, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:47', NULL, NULL, NULL),
(963, 1, 'P20221963', 'AprilYandi Dwi W 963', '56419974963', '3276010023963', 'Jakarta', '2001-12-02', 'Laki-Laki', '0851720231963', 'Kp,Babakan No. 963', 'Islam', 12, 7, NULL, NULL, '', '2022-12-07 14:00:51', NULL, NULL, NULL),
(964, 3, 'P20223964', 'AprilYandi Dwi W 964', '56419974964', '3276010023964', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231964', 'Kp,Babakan No. 964', 'Islam', 6, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:52', NULL, NULL, NULL),
(965, 2, 'P20222965', 'AprilYandi Dwi W 965', '56419974965', '3276010023965', 'Depok', '2001-12-09', 'Perempuan', '0851720231965', 'Kp,Babakan No. 965', 'Islam', 12, 9, '1500000.00', NULL, '1', '2022-12-07 14:00:53', NULL, NULL, NULL),
(966, 3, 'P20223966', 'AprilYandi Dwi W 966', '56419974966', '3276010023966', 'Jakarta', '2001-12-28', 'Laki-Laki', '0851720231966', 'Kp,Babakan No. 966', 'Islam', 5, 13, '1500000.00', NULL, '', '2022-12-07 14:00:54', NULL, NULL, NULL),
(967, 1, 'P20221967', 'AprilYandi Dwi W 967', '56419974967', '3276010023967', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231967', 'Kp,Babakan No. 967', 'Islam', 4, 5, NULL, NULL, '1', '2022-12-07 14:00:54', NULL, NULL, NULL),
(968, 1, 'P20221968', 'AprilYandi Dwi W 968', '56419974968', '3276010023968', 'Jakarta', '2001-12-08', 'Laki-Laki', '0851720231968', 'Kp,Babakan No. 968', 'Islam', 3, 1, NULL, NULL, '1', '2022-12-07 14:00:54', NULL, NULL, NULL),
(969, 2, 'P20222969', 'AprilYandi Dwi W 969', '56419974969', '3276010023969', 'Jakarta', '2001-12-15', 'Laki-Laki', '0851720231969', 'Kp,Babakan No. 969', 'Islam', 9, 10, '1500000.00', NULL, '', '2022-12-07 14:00:55', NULL, NULL, NULL),
(970, 1, 'P20221970', 'AprilYandi Dwi W 970', '56419974970', '3276010023970', 'Depok', '2001-12-17', 'Perempuan', '0851720231970', 'Kp,Babakan No. 970', 'Islam', 12, 7, NULL, NULL, '1', '2022-12-07 14:00:55', NULL, NULL, NULL),
(971, 1, 'P20221971', 'AprilYandi Dwi W 971', '56419974971', '3276010023971', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231971', 'Kp,Babakan No. 971', 'Islam', 3, 7, NULL, NULL, '1', '2022-12-07 14:00:55', NULL, NULL, NULL),
(972, 1, 'P20221972', 'AprilYandi Dwi W 972', '56419974972', '3276010023972', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231972', 'Kp,Babakan No. 972', 'Islam', 3, 13, NULL, NULL, '', '2022-12-07 14:00:55', NULL, NULL, NULL),
(973, 3, 'P20223973', 'AprilYandi Dwi W 973', '56419974973', '3276010023973', 'Jakarta', '2001-12-14', 'Laki-Laki', '0851720231973', 'Kp,Babakan No. 973', 'Islam', 11, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:56', NULL, NULL, NULL),
(974, 2, 'P20222974', 'AprilYandi Dwi W 974', '56419974974', '3276010023974', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231974', 'Kp,Babakan No. 974', 'Islam', 12, 12, '1500000.00', NULL, '1', '2022-12-07 14:00:56', NULL, NULL, NULL),
(975, 2, 'P20222975', 'AprilYandi Dwi W 975', '56419974975', '3276010023975', 'Depok', '2001-12-07', 'Perempuan', '0851720231975', 'Kp,Babakan No. 975', 'Islam', 9, 8, '1500000.00', NULL, '', '2022-12-07 14:00:57', NULL, NULL, NULL),
(976, 2, 'P20222976', 'AprilYandi Dwi W 976', '56419974976', '3276010023976', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231976', 'Kp,Babakan No. 976', 'Islam', 10, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:57', NULL, NULL, NULL),
(977, 2, 'P20222977', 'AprilYandi Dwi W 977', '56419974977', '3276010023977', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231977', 'Kp,Babakan No. 977', 'Islam', 1, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:57', NULL, NULL, NULL),
(978, 2, 'P20222978', 'AprilYandi Dwi W 978', '56419974978', '3276010023978', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231978', 'Kp,Babakan No. 978', 'Islam', 2, 2, '1500000.00', NULL, '', '2022-12-07 14:00:57', NULL, NULL, NULL),
(979, 2, 'P20222979', 'AprilYandi Dwi W 979', '56419974979', '3276010023979', 'Jakarta', '2001-12-25', 'Laki-Laki', '0851720231979', 'Kp,Babakan No. 979', 'Islam', 2, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:57', NULL, NULL, NULL),
(980, 2, 'P20222980', 'AprilYandi Dwi W 980', '56419974980', '3276010023980', 'Depok', '2001-12-15', 'Perempuan', '0851720231980', 'Kp,Babakan No. 980', 'Islam', 13, 13, '1500000.00', NULL, '1', '2022-12-07 14:00:57', NULL, NULL, NULL),
(981, 2, 'P20222981', 'AprilYandi Dwi W 981', '56419974981', '3276010023981', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231981', 'Kp,Babakan No. 981', 'Islam', 11, 10, '1500000.00', NULL, '', '2022-12-07 14:00:57', NULL, NULL, NULL),
(982, 2, 'P20222982', 'AprilYandi Dwi W 982', '56419974982', '3276010023982', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231982', 'Kp,Babakan No. 982', 'Islam', 12, 10, '1500000.00', NULL, '1', '2022-12-07 14:00:58', NULL, NULL, NULL),
(983, 2, 'P20222983', 'AprilYandi Dwi W 983', '56419974983', '3276010023983', 'Jakarta', '2001-12-18', 'Laki-Laki', '0851720231983', 'Kp,Babakan No. 983', 'Islam', 2, 5, '1500000.00', NULL, '1', '2022-12-07 14:00:58', NULL, NULL, NULL),
(984, 2, 'P20222984', 'AprilYandi Dwi W 984', '56419974984', '3276010023984', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231984', 'Kp,Babakan No. 984', 'Islam', 3, 12, '1500000.00', NULL, '', '2022-12-07 14:00:58', NULL, NULL, NULL),
(985, 1, 'P20221985', 'AprilYandi Dwi W 985', '56419974985', '3276010023985', 'Depok', '2001-12-24', 'Perempuan', '0851720231985', 'Kp,Babakan No. 985', 'Islam', 10, 3, NULL, NULL, '1', '2022-12-07 14:00:58', NULL, NULL, NULL),
(986, 3, 'P20223986', 'AprilYandi Dwi W 986', '56419974986', '3276010023986', 'Jakarta', '2001-12-13', 'Laki-Laki', '0851720231986', 'Kp,Babakan No. 986', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 14:00:58', NULL, NULL, NULL),
(987, 2, 'P20222987', 'AprilYandi Dwi W 987', '56419974987', '3276010023987', 'Jakarta', '2001-12-30', 'Laki-Laki', '0851720231987', 'Kp,Babakan No. 987', 'Islam', 7, 3, '1500000.00', NULL, '', '2022-12-07 14:00:59', NULL, NULL, NULL),
(988, 2, 'P20222988', 'AprilYandi Dwi W 988', '56419974988', '3276010023988', 'Jakarta', '2001-12-04', 'Laki-Laki', '0851720231988', 'Kp,Babakan No. 988', 'Islam', 11, 11, '1500000.00', NULL, '1', '2022-12-07 14:00:59', NULL, NULL, NULL),
(989, 1, 'P20221989', 'AprilYandi Dwi W 989', '56419974989', '3276010023989', 'Jakarta', '2001-12-17', 'Laki-Laki', '0851720231989', 'Kp,Babakan No. 989', 'Islam', 2, 8, NULL, NULL, '1', '2022-12-07 14:01:00', NULL, NULL, NULL),
(990, 2, 'P20222990', 'AprilYandi Dwi W 990', '56419974990', '3276010023990', 'Depok', '2001-12-03', 'Perempuan', '0851720231990', 'Kp,Babakan No. 990', 'Islam', 11, 13, '1500000.00', NULL, '', '2022-12-07 14:01:00', NULL, NULL, NULL),
(991, 2, 'P20222991', 'AprilYandi Dwi W 991', '56419974991', '3276010023991', 'Jakarta', '2001-12-10', 'Laki-Laki', '0851720231991', 'Kp,Babakan No. 991', 'Islam', 1, 4, '1500000.00', NULL, '1', '2022-12-07 14:01:00', NULL, NULL, NULL),
(992, 3, 'P20223992', 'AprilYandi Dwi W 992', '56419974992', '3276010023992', 'Jakarta', '2001-12-09', 'Laki-Laki', '0851720231992', 'Kp,Babakan No. 992', 'Islam', 11, 4, '1500000.00', NULL, '1', '2022-12-07 14:01:00', NULL, NULL, NULL),
(993, 2, 'P20222993', 'AprilYandi Dwi W 993', '56419974993', '3276010023993', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231993', 'Kp,Babakan No. 993', 'Islam', 12, 2, '1500000.00', NULL, '', '2022-12-07 14:01:00', NULL, NULL, NULL),
(994, 2, 'P20222994', 'AprilYandi Dwi W 994', '56419974994', '3276010023994', 'Jakarta', '2001-12-24', 'Laki-Laki', '0851720231994', 'Kp,Babakan No. 994', 'Islam', 6, 12, '1500000.00', NULL, '1', '2022-12-07 14:01:01', NULL, NULL, NULL),
(995, 1, 'P20221995', 'AprilYandi Dwi W 995', '56419974995', '3276010023995', 'Depok', '2001-12-31', 'Perempuan', '0851720231995', 'Kp,Babakan No. 995', 'Islam', 3, 9, NULL, NULL, '1', '2022-12-07 14:01:01', NULL, NULL, NULL),
(996, 3, 'P20223996', 'AprilYandi Dwi W 996', '56419974996', '3276010023996', 'Jakarta', '2001-12-31', 'Laki-Laki', '0851720231996', 'Kp,Babakan No. 996', 'Islam', 7, 6, '1500000.00', NULL, '', '2022-12-07 14:01:01', NULL, NULL, NULL),
(997, 1, 'P20221997', 'AprilYandi Dwi W 997', '56419974997', '3276010023997', 'Jakarta', '2001-12-19', 'Laki-Laki', '0851720231997', 'Kp,Babakan No. 997', 'Islam', 13, 4, NULL, NULL, '1', '2022-12-07 14:01:01', NULL, NULL, NULL),
(998, 3, 'P20223998', 'AprilYandi Dwi W 998', '56419974998', '3276010023998', 'Jakarta', '2001-12-11', 'Laki-Laki', '0851720231998', 'Kp,Babakan No. 998', 'Islam', 3, 4, '1500000.00', NULL, '1', '2022-12-07 14:01:02', NULL, NULL, NULL),
(999, 2, 'P20222999', 'AprilYandi Dwi W 999', '56419974999', '3276010023999', 'Jakarta', '2001-12-16', 'Laki-Laki', '0851720231999', 'Kp,Babakan No. 999', 'Islam', 6, 7, '1500000.00', NULL, '', '2022-12-07 14:01:03', NULL, NULL, NULL),
(1000, 1, 'P202211000', 'AprilYandi Dwi W 1000', '564199741000', '32760100231000', 'Depok', '2001-12-21', 'Perempuan', '08517202311000', 'Kp,Babakan No. 1000', 'Islam', 7, 12, NULL, NULL, '1', '2022-12-07 14:01:03', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pendaftar_prestasi`
--

CREATE TABLE `pendaftar_prestasi` (
  `id` int(11) NOT NULL,
  `id_pendaftar` int(11) NOT NULL DEFAULT 0,
  `tingkat_prestasi` enum('NASIONAL','INTERNASIONAL') NOT NULL DEFAULT 'NASIONAL',
  `nama_prestasi` varchar(255) NOT NULL,
  `tahun` int(11) NOT NULL,
  `url_dokumen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendaftar_prestasi`
--

INSERT INTO `pendaftar_prestasi` (`id`, `id_pendaftar`, `tingkat_prestasi`, `nama_prestasi`, `tahun`, `url_dokumen`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 2, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 2', 2022, 'public/uploads/prestasi/2', '2022-12-07 13:58:28', NULL, NULL, NULL),
(2, 3, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 3', 2022, 'public/uploads/prestasi/3', '2022-12-07 13:58:28', NULL, NULL, NULL),
(3, 6, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 6', 2022, 'public/uploads/prestasi/6', '2022-12-07 13:58:28', NULL, NULL, NULL),
(4, 8, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 8', 2022, 'public/uploads/prestasi/8', '2022-12-07 13:58:28', NULL, NULL, NULL),
(5, 13, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 13', 2022, 'public/uploads/prestasi/13', '2022-12-07 13:58:29', NULL, NULL, NULL),
(6, 15, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 15', 2022, 'public/uploads/prestasi/15', '2022-12-07 13:58:29', NULL, NULL, NULL),
(7, 18, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 18', 2022, 'public/uploads/prestasi/18', '2022-12-07 13:58:29', NULL, NULL, NULL),
(8, 23, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 23', 2022, 'public/uploads/prestasi/23', '2022-12-07 13:58:29', NULL, NULL, NULL),
(9, 25, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 25', 2022, 'public/uploads/prestasi/25', '2022-12-07 13:58:29', NULL, NULL, NULL),
(10, 28, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 28', 2022, 'public/uploads/prestasi/28', '2022-12-07 13:58:30', NULL, NULL, NULL),
(11, 29, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 29', 2022, 'public/uploads/prestasi/29', '2022-12-07 13:58:30', NULL, NULL, NULL),
(12, 30, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 30', 2022, 'public/uploads/prestasi/30', '2022-12-07 13:58:30', NULL, NULL, NULL),
(13, 31, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 31', 2022, 'public/uploads/prestasi/31', '2022-12-07 13:58:30', NULL, NULL, NULL),
(14, 32, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 32', 2022, 'public/uploads/prestasi/32', '2022-12-07 13:58:30', NULL, NULL, NULL),
(15, 38, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 38', 2022, 'public/uploads/prestasi/38', '2022-12-07 13:58:30', NULL, NULL, NULL),
(16, 46, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 46', 2022, 'public/uploads/prestasi/46', '2022-12-07 13:58:31', NULL, NULL, NULL),
(17, 49, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 49', 2022, 'public/uploads/prestasi/49', '2022-12-07 13:58:31', NULL, NULL, NULL),
(18, 55, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 55', 2022, 'public/uploads/prestasi/55', '2022-12-07 13:58:31', NULL, NULL, NULL),
(19, 60, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 60', 2022, 'public/uploads/prestasi/60', '2022-12-07 13:58:31', NULL, NULL, NULL),
(20, 61, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 61', 2022, 'public/uploads/prestasi/61', '2022-12-07 13:58:32', NULL, NULL, NULL),
(21, 62, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 62', 2022, 'public/uploads/prestasi/62', '2022-12-07 13:58:32', NULL, NULL, NULL),
(22, 64, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 64', 2022, 'public/uploads/prestasi/64', '2022-12-07 13:58:32', NULL, NULL, NULL),
(23, 74, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 74', 2022, 'public/uploads/prestasi/74', '2022-12-07 13:58:32', NULL, NULL, NULL),
(24, 75, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 75', 2022, 'public/uploads/prestasi/75', '2022-12-07 13:58:33', NULL, NULL, NULL),
(25, 79, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 79', 2022, 'public/uploads/prestasi/79', '2022-12-07 13:58:33', NULL, NULL, NULL),
(26, 80, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 80', 2022, 'public/uploads/prestasi/80', '2022-12-07 13:58:33', NULL, NULL, NULL),
(27, 84, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 84', 2022, 'public/uploads/prestasi/84', '2022-12-07 13:58:33', NULL, NULL, NULL),
(28, 86, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 86', 2022, 'public/uploads/prestasi/86', '2022-12-07 13:58:34', NULL, NULL, NULL),
(29, 88, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 88', 2022, 'public/uploads/prestasi/88', '2022-12-07 13:58:34', NULL, NULL, NULL),
(30, 92, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 92', 2022, 'public/uploads/prestasi/92', '2022-12-07 13:58:34', NULL, NULL, NULL),
(31, 94, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 94', 2022, 'public/uploads/prestasi/94', '2022-12-07 13:58:35', NULL, NULL, NULL),
(32, 96, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 96', 2022, 'public/uploads/prestasi/96', '2022-12-07 13:58:35', NULL, NULL, NULL),
(33, 97, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 97', 2022, 'public/uploads/prestasi/97', '2022-12-07 13:58:35', NULL, NULL, NULL),
(34, 100, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 100', 2022, 'public/uploads/prestasi/100', '2022-12-07 13:58:35', NULL, NULL, NULL),
(35, 102, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 102', 2022, 'public/uploads/prestasi/102', '2022-12-07 13:58:35', NULL, NULL, NULL),
(36, 106, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 106', 2022, 'public/uploads/prestasi/106', '2022-12-07 13:58:36', NULL, NULL, NULL),
(37, 112, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 112', 2022, 'public/uploads/prestasi/112', '2022-12-07 13:58:36', NULL, NULL, NULL),
(38, 114, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 114', 2022, 'public/uploads/prestasi/114', '2022-12-07 13:58:36', NULL, NULL, NULL),
(39, 115, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 115', 2022, 'public/uploads/prestasi/115', '2022-12-07 13:58:36', NULL, NULL, NULL),
(40, 116, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 116', 2022, 'public/uploads/prestasi/116', '2022-12-07 13:58:36', NULL, NULL, NULL),
(41, 118, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 118', 2022, 'public/uploads/prestasi/118', '2022-12-07 13:58:36', NULL, NULL, NULL),
(42, 131, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 131', 2022, 'public/uploads/prestasi/131', '2022-12-07 13:58:37', NULL, NULL, NULL),
(43, 134, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 134', 2022, 'public/uploads/prestasi/134', '2022-12-07 13:58:37', NULL, NULL, NULL),
(44, 137, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 137', 2022, 'public/uploads/prestasi/137', '2022-12-07 13:58:37', NULL, NULL, NULL),
(45, 138, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 138', 2022, 'public/uploads/prestasi/138', '2022-12-07 13:58:37', NULL, NULL, NULL),
(46, 147, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 147', 2022, 'public/uploads/prestasi/147', '2022-12-07 13:58:38', NULL, NULL, NULL),
(47, 153, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 153', 2022, 'public/uploads/prestasi/153', '2022-12-07 13:58:38', NULL, NULL, NULL),
(48, 154, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 154', 2022, 'public/uploads/prestasi/154', '2022-12-07 13:58:38', NULL, NULL, NULL),
(49, 156, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 156', 2022, 'public/uploads/prestasi/156', '2022-12-07 13:58:38', NULL, NULL, NULL),
(50, 161, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 161', 2022, 'public/uploads/prestasi/161', '2022-12-07 13:58:39', NULL, NULL, NULL),
(51, 163, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 163', 2022, 'public/uploads/prestasi/163', '2022-12-07 13:58:39', NULL, NULL, NULL),
(52, 165, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 165', 2022, 'public/uploads/prestasi/165', '2022-12-07 13:58:39', NULL, NULL, NULL),
(53, 171, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 171', 2022, 'public/uploads/prestasi/171', '2022-12-07 13:58:39', NULL, NULL, NULL),
(54, 172, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 172', 2022, 'public/uploads/prestasi/172', '2022-12-07 13:58:39', NULL, NULL, NULL),
(55, 173, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 173', 2022, 'public/uploads/prestasi/173', '2022-12-07 13:58:40', NULL, NULL, NULL),
(56, 175, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 175', 2022, 'public/uploads/prestasi/175', '2022-12-07 13:58:40', NULL, NULL, NULL),
(57, 176, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 176', 2022, 'public/uploads/prestasi/176', '2022-12-07 13:58:40', NULL, NULL, NULL),
(58, 180, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 180', 2022, 'public/uploads/prestasi/180', '2022-12-07 13:58:40', NULL, NULL, NULL),
(59, 181, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 181', 2022, 'public/uploads/prestasi/181', '2022-12-07 13:58:40', NULL, NULL, NULL),
(60, 182, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 182', 2022, 'public/uploads/prestasi/182', '2022-12-07 13:58:41', NULL, NULL, NULL),
(61, 187, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 187', 2022, 'public/uploads/prestasi/187', '2022-12-07 13:58:41', NULL, NULL, NULL),
(62, 189, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 189', 2022, 'public/uploads/prestasi/189', '2022-12-07 13:58:41', NULL, NULL, NULL),
(63, 190, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 190', 2022, 'public/uploads/prestasi/190', '2022-12-07 13:58:41', NULL, NULL, NULL),
(64, 192, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 192', 2022, 'public/uploads/prestasi/192', '2022-12-07 13:58:41', NULL, NULL, NULL),
(65, 193, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 193', 2022, 'public/uploads/prestasi/193', '2022-12-07 13:58:41', NULL, NULL, NULL),
(66, 197, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 197', 2022, 'public/uploads/prestasi/197', '2022-12-07 13:58:42', NULL, NULL, NULL),
(67, 202, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 202', 2022, 'public/uploads/prestasi/202', '2022-12-07 13:58:44', NULL, NULL, NULL),
(68, 210, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 210', 2022, 'public/uploads/prestasi/210', '2022-12-07 13:58:45', NULL, NULL, NULL),
(69, 213, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 213', 2022, 'public/uploads/prestasi/213', '2022-12-07 13:58:45', NULL, NULL, NULL),
(70, 214, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 214', 2022, 'public/uploads/prestasi/214', '2022-12-07 13:58:45', NULL, NULL, NULL),
(71, 215, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 215', 2022, 'public/uploads/prestasi/215', '2022-12-07 13:58:45', NULL, NULL, NULL),
(72, 219, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 219', 2022, 'public/uploads/prestasi/219', '2022-12-07 13:58:46', NULL, NULL, NULL),
(73, 225, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 225', 2022, 'public/uploads/prestasi/225', '2022-12-07 13:58:47', NULL, NULL, NULL),
(74, 229, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 229', 2022, 'public/uploads/prestasi/229', '2022-12-07 13:58:48', NULL, NULL, NULL),
(75, 238, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 238', 2022, 'public/uploads/prestasi/238', '2022-12-07 13:58:49', NULL, NULL, NULL),
(76, 239, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 239', 2022, 'public/uploads/prestasi/239', '2022-12-07 13:58:49', NULL, NULL, NULL),
(77, 240, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 240', 2022, 'public/uploads/prestasi/240', '2022-12-07 13:58:49', NULL, NULL, NULL),
(78, 243, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 243', 2022, 'public/uploads/prestasi/243', '2022-12-07 13:58:50', NULL, NULL, NULL),
(79, 244, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 244', 2022, 'public/uploads/prestasi/244', '2022-12-07 13:58:50', NULL, NULL, NULL),
(80, 245, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 245', 2022, 'public/uploads/prestasi/245', '2022-12-07 13:58:50', NULL, NULL, NULL),
(81, 247, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 247', 2022, 'public/uploads/prestasi/247', '2022-12-07 13:58:51', NULL, NULL, NULL),
(82, 249, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 249', 2022, 'public/uploads/prestasi/249', '2022-12-07 13:58:51', NULL, NULL, NULL),
(83, 252, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 252', 2022, 'public/uploads/prestasi/252', '2022-12-07 13:58:51', NULL, NULL, NULL),
(84, 253, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 253', 2022, 'public/uploads/prestasi/253', '2022-12-07 13:58:52', NULL, NULL, NULL),
(85, 254, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 254', 2022, 'public/uploads/prestasi/254', '2022-12-07 13:58:52', NULL, NULL, NULL),
(86, 260, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 260', 2022, 'public/uploads/prestasi/260', '2022-12-07 13:58:53', NULL, NULL, NULL),
(87, 263, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 263', 2022, 'public/uploads/prestasi/263', '2022-12-07 13:58:53', NULL, NULL, NULL),
(88, 267, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 267', 2022, 'public/uploads/prestasi/267', '2022-12-07 13:58:54', NULL, NULL, NULL),
(89, 269, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 269', 2022, 'public/uploads/prestasi/269', '2022-12-07 13:58:54', NULL, NULL, NULL),
(90, 271, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 271', 2022, 'public/uploads/prestasi/271', '2022-12-07 13:58:54', NULL, NULL, NULL),
(91, 272, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 272', 2022, 'public/uploads/prestasi/272', '2022-12-07 13:58:54', NULL, NULL, NULL),
(92, 275, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 275', 2022, 'public/uploads/prestasi/275', '2022-12-07 13:58:55', NULL, NULL, NULL),
(93, 277, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 277', 2022, 'public/uploads/prestasi/277', '2022-12-07 13:58:55', NULL, NULL, NULL),
(94, 280, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 280', 2022, 'public/uploads/prestasi/280', '2022-12-07 13:58:55', NULL, NULL, NULL),
(95, 284, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 284', 2022, 'public/uploads/prestasi/284', '2022-12-07 13:58:55', NULL, NULL, NULL),
(96, 286, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 286', 2022, 'public/uploads/prestasi/286', '2022-12-07 13:58:56', NULL, NULL, NULL),
(97, 288, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 288', 2022, 'public/uploads/prestasi/288', '2022-12-07 13:58:56', NULL, NULL, NULL),
(98, 290, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 290', 2022, 'public/uploads/prestasi/290', '2022-12-07 13:58:56', NULL, NULL, NULL),
(99, 291, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 291', 2022, 'public/uploads/prestasi/291', '2022-12-07 13:58:56', NULL, NULL, NULL),
(100, 299, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 299', 2022, 'public/uploads/prestasi/299', '2022-12-07 13:58:57', NULL, NULL, NULL),
(101, 304, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 304', 2022, 'public/uploads/prestasi/304', '2022-12-07 13:58:57', NULL, NULL, NULL),
(102, 311, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 311', 2022, 'public/uploads/prestasi/311', '2022-12-07 13:58:58', NULL, NULL, NULL),
(103, 313, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 313', 2022, 'public/uploads/prestasi/313', '2022-12-07 13:58:58', NULL, NULL, NULL),
(104, 317, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 317', 2022, 'public/uploads/prestasi/317', '2022-12-07 13:58:58', NULL, NULL, NULL),
(105, 319, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 319', 2022, 'public/uploads/prestasi/319', '2022-12-07 13:58:58', NULL, NULL, NULL),
(106, 321, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 321', 2022, 'public/uploads/prestasi/321', '2022-12-07 13:58:58', NULL, NULL, NULL),
(107, 322, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 322', 2022, 'public/uploads/prestasi/322', '2022-12-07 13:58:59', NULL, NULL, NULL),
(108, 334, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 334', 2022, 'public/uploads/prestasi/334', '2022-12-07 13:59:00', NULL, NULL, NULL),
(109, 338, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 338', 2022, 'public/uploads/prestasi/338', '2022-12-07 13:59:00', NULL, NULL, NULL),
(110, 340, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 340', 2022, 'public/uploads/prestasi/340', '2022-12-07 13:59:00', NULL, NULL, NULL),
(111, 341, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 341', 2022, 'public/uploads/prestasi/341', '2022-12-07 13:59:00', NULL, NULL, NULL),
(112, 346, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 346', 2022, 'public/uploads/prestasi/346', '2022-12-07 13:59:01', NULL, NULL, NULL),
(113, 347, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 347', 2022, 'public/uploads/prestasi/347', '2022-12-07 13:59:01', NULL, NULL, NULL),
(114, 348, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 348', 2022, 'public/uploads/prestasi/348', '2022-12-07 13:59:01', NULL, NULL, NULL),
(115, 352, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 352', 2022, 'public/uploads/prestasi/352', '2022-12-07 13:59:01', NULL, NULL, NULL),
(116, 355, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 355', 2022, 'public/uploads/prestasi/355', '2022-12-07 13:59:02', NULL, NULL, NULL),
(117, 356, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 356', 2022, 'public/uploads/prestasi/356', '2022-12-07 13:59:02', NULL, NULL, NULL),
(118, 357, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 357', 2022, 'public/uploads/prestasi/357', '2022-12-07 13:59:02', NULL, NULL, NULL),
(119, 360, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 360', 2022, 'public/uploads/prestasi/360', '2022-12-07 13:59:02', NULL, NULL, NULL),
(120, 364, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 364', 2022, 'public/uploads/prestasi/364', '2022-12-07 13:59:02', NULL, NULL, NULL),
(121, 366, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 366', 2022, 'public/uploads/prestasi/366', '2022-12-07 13:59:03', NULL, NULL, NULL),
(122, 373, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 373', 2022, 'public/uploads/prestasi/373', '2022-12-07 13:59:04', NULL, NULL, NULL),
(123, 374, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 374', 2022, 'public/uploads/prestasi/374', '2022-12-07 13:59:04', NULL, NULL, NULL),
(124, 377, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 377', 2022, 'public/uploads/prestasi/377', '2022-12-07 13:59:04', NULL, NULL, NULL),
(125, 379, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 379', 2022, 'public/uploads/prestasi/379', '2022-12-07 13:59:04', NULL, NULL, NULL),
(126, 380, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 380', 2022, 'public/uploads/prestasi/380', '2022-12-07 13:59:04', NULL, NULL, NULL),
(127, 382, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 382', 2022, 'public/uploads/prestasi/382', '2022-12-07 13:59:04', NULL, NULL, NULL),
(128, 384, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 384', 2022, 'public/uploads/prestasi/384', '2022-12-07 13:59:05', NULL, NULL, NULL),
(129, 389, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 389', 2022, 'public/uploads/prestasi/389', '2022-12-07 13:59:05', NULL, NULL, NULL),
(130, 392, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 392', 2022, 'public/uploads/prestasi/392', '2022-12-07 13:59:05', NULL, NULL, NULL),
(131, 397, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 397', 2022, 'public/uploads/prestasi/397', '2022-12-07 13:59:06', NULL, NULL, NULL),
(132, 399, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 399', 2022, 'public/uploads/prestasi/399', '2022-12-07 13:59:06', NULL, NULL, NULL),
(133, 403, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 403', 2022, 'public/uploads/prestasi/403', '2022-12-07 13:59:06', NULL, NULL, NULL),
(134, 404, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 404', 2022, 'public/uploads/prestasi/404', '2022-12-07 13:59:06', NULL, NULL, NULL),
(135, 410, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 410', 2022, 'public/uploads/prestasi/410', '2022-12-07 13:59:06', NULL, NULL, NULL),
(136, 413, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 413', 2022, 'public/uploads/prestasi/413', '2022-12-07 13:59:07', NULL, NULL, NULL),
(137, 415, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 415', 2022, 'public/uploads/prestasi/415', '2022-12-07 13:59:07', NULL, NULL, NULL),
(138, 416, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 416', 2022, 'public/uploads/prestasi/416', '2022-12-07 13:59:07', NULL, NULL, NULL),
(139, 419, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 419', 2022, 'public/uploads/prestasi/419', '2022-12-07 13:59:08', NULL, NULL, NULL),
(140, 420, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 420', 2022, 'public/uploads/prestasi/420', '2022-12-07 13:59:08', NULL, NULL, NULL),
(141, 421, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 421', 2022, 'public/uploads/prestasi/421', '2022-12-07 13:59:08', NULL, NULL, NULL),
(142, 424, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 424', 2022, 'public/uploads/prestasi/424', '2022-12-07 13:59:08', NULL, NULL, NULL),
(143, 425, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 425', 2022, 'public/uploads/prestasi/425', '2022-12-07 13:59:08', NULL, NULL, NULL),
(144, 428, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 428', 2022, 'public/uploads/prestasi/428', '2022-12-07 13:59:09', NULL, NULL, NULL),
(145, 431, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 431', 2022, 'public/uploads/prestasi/431', '2022-12-07 13:59:09', NULL, NULL, NULL),
(146, 437, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 437', 2022, 'public/uploads/prestasi/437', '2022-12-07 13:59:11', NULL, NULL, NULL),
(147, 440, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 440', 2022, 'public/uploads/prestasi/440', '2022-12-07 13:59:11', NULL, NULL, NULL),
(148, 441, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 441', 2022, 'public/uploads/prestasi/441', '2022-12-07 13:59:11', NULL, NULL, NULL),
(149, 443, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 443', 2022, 'public/uploads/prestasi/443', '2022-12-07 13:59:12', NULL, NULL, NULL),
(150, 448, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 448', 2022, 'public/uploads/prestasi/448', '2022-12-07 13:59:12', NULL, NULL, NULL),
(151, 449, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 449', 2022, 'public/uploads/prestasi/449', '2022-12-07 13:59:13', NULL, NULL, NULL),
(152, 453, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 453', 2022, 'public/uploads/prestasi/453', '2022-12-07 13:59:13', NULL, NULL, NULL),
(153, 458, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 458', 2022, 'public/uploads/prestasi/458', '2022-12-07 13:59:14', NULL, NULL, NULL),
(154, 460, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 460', 2022, 'public/uploads/prestasi/460', '2022-12-07 13:59:14', NULL, NULL, NULL),
(155, 461, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 461', 2022, 'public/uploads/prestasi/461', '2022-12-07 13:59:14', NULL, NULL, NULL),
(156, 462, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 462', 2022, 'public/uploads/prestasi/462', '2022-12-07 13:59:14', NULL, NULL, NULL),
(157, 464, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 464', 2022, 'public/uploads/prestasi/464', '2022-12-07 13:59:15', NULL, NULL, NULL),
(158, 465, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 465', 2022, 'public/uploads/prestasi/465', '2022-12-07 13:59:15', NULL, NULL, NULL),
(159, 469, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 469', 2022, 'public/uploads/prestasi/469', '2022-12-07 13:59:15', NULL, NULL, NULL),
(160, 474, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 474', 2022, 'public/uploads/prestasi/474', '2022-12-07 13:59:16', NULL, NULL, NULL),
(161, 479, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 479', 2022, 'public/uploads/prestasi/479', '2022-12-07 13:59:17', NULL, NULL, NULL),
(162, 490, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 490', 2022, 'public/uploads/prestasi/490', '2022-12-07 13:59:19', NULL, NULL, NULL),
(163, 492, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 492', 2022, 'public/uploads/prestasi/492', '2022-12-07 13:59:20', NULL, NULL, NULL),
(164, 497, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 497', 2022, 'public/uploads/prestasi/497', '2022-12-07 13:59:20', NULL, NULL, NULL),
(165, 505, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 505', 2022, 'public/uploads/prestasi/505', '2022-12-07 13:59:21', NULL, NULL, NULL),
(166, 511, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 511', 2022, 'public/uploads/prestasi/511', '2022-12-07 13:59:22', NULL, NULL, NULL),
(167, 512, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 512', 2022, 'public/uploads/prestasi/512', '2022-12-07 13:59:22', NULL, NULL, NULL),
(168, 514, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 514', 2022, 'public/uploads/prestasi/514', '2022-12-07 13:59:23', NULL, NULL, NULL),
(169, 515, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 515', 2022, 'public/uploads/prestasi/515', '2022-12-07 13:59:23', NULL, NULL, NULL),
(170, 519, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 519', 2022, 'public/uploads/prestasi/519', '2022-12-07 13:59:24', NULL, NULL, NULL),
(171, 521, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 521', 2022, 'public/uploads/prestasi/521', '2022-12-07 13:59:24', NULL, NULL, NULL),
(172, 524, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 524', 2022, 'public/uploads/prestasi/524', '2022-12-07 13:59:25', NULL, NULL, NULL),
(173, 526, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 526', 2022, 'public/uploads/prestasi/526', '2022-12-07 13:59:25', NULL, NULL, NULL),
(174, 529, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 529', 2022, 'public/uploads/prestasi/529', '2022-12-07 13:59:25', NULL, NULL, NULL),
(175, 530, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 530', 2022, 'public/uploads/prestasi/530', '2022-12-07 13:59:25', NULL, NULL, NULL),
(176, 532, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 532', 2022, 'public/uploads/prestasi/532', '2022-12-07 13:59:25', NULL, NULL, NULL),
(177, 533, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 533', 2022, 'public/uploads/prestasi/533', '2022-12-07 13:59:25', NULL, NULL, NULL),
(178, 535, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 535', 2022, 'public/uploads/prestasi/535', '2022-12-07 13:59:26', NULL, NULL, NULL),
(179, 539, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 539', 2022, 'public/uploads/prestasi/539', '2022-12-07 13:59:27', NULL, NULL, NULL),
(180, 542, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 542', 2022, 'public/uploads/prestasi/542', '2022-12-07 13:59:27', NULL, NULL, NULL),
(181, 543, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 543', 2022, 'public/uploads/prestasi/543', '2022-12-07 13:59:27', NULL, NULL, NULL),
(182, 544, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 544', 2022, 'public/uploads/prestasi/544', '2022-12-07 13:59:27', NULL, NULL, NULL),
(183, 548, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 548', 2022, 'public/uploads/prestasi/548', '2022-12-07 13:59:28', NULL, NULL, NULL),
(184, 553, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 553', 2022, 'public/uploads/prestasi/553', '2022-12-07 13:59:28', NULL, NULL, NULL),
(185, 556, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 556', 2022, 'public/uploads/prestasi/556', '2022-12-07 13:59:28', NULL, NULL, NULL),
(186, 560, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 560', 2022, 'public/uploads/prestasi/560', '2022-12-07 13:59:29', NULL, NULL, NULL),
(187, 563, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 563', 2022, 'public/uploads/prestasi/563', '2022-12-07 13:59:29', NULL, NULL, NULL),
(188, 565, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 565', 2022, 'public/uploads/prestasi/565', '2022-12-07 13:59:29', NULL, NULL, NULL),
(189, 566, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 566', 2022, 'public/uploads/prestasi/566', '2022-12-07 13:59:29', NULL, NULL, NULL),
(190, 573, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 573', 2022, 'public/uploads/prestasi/573', '2022-12-07 13:59:30', NULL, NULL, NULL),
(191, 574, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 574', 2022, 'public/uploads/prestasi/574', '2022-12-07 13:59:30', NULL, NULL, NULL),
(192, 579, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 579', 2022, 'public/uploads/prestasi/579', '2022-12-07 13:59:31', NULL, NULL, NULL),
(193, 585, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 585', 2022, 'public/uploads/prestasi/585', '2022-12-07 13:59:31', NULL, NULL, NULL),
(194, 590, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 590', 2022, 'public/uploads/prestasi/590', '2022-12-07 13:59:32', NULL, NULL, NULL),
(195, 594, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 594', 2022, 'public/uploads/prestasi/594', '2022-12-07 13:59:32', NULL, NULL, NULL),
(196, 595, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 595', 2022, 'public/uploads/prestasi/595', '2022-12-07 13:59:32', NULL, NULL, NULL),
(197, 597, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 597', 2022, 'public/uploads/prestasi/597', '2022-12-07 13:59:33', NULL, NULL, NULL),
(198, 599, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 599', 2022, 'public/uploads/prestasi/599', '2022-12-07 13:59:34', NULL, NULL, NULL),
(199, 600, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 600', 2022, 'public/uploads/prestasi/600', '2022-12-07 13:59:34', NULL, NULL, NULL),
(200, 603, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 603', 2022, 'public/uploads/prestasi/603', '2022-12-07 13:59:35', NULL, NULL, NULL),
(201, 604, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 604', 2022, 'public/uploads/prestasi/604', '2022-12-07 13:59:35', NULL, NULL, NULL),
(202, 605, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 605', 2022, 'public/uploads/prestasi/605', '2022-12-07 13:59:35', NULL, NULL, NULL),
(203, 606, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 606', 2022, 'public/uploads/prestasi/606', '2022-12-07 13:59:35', NULL, NULL, NULL),
(204, 607, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 607', 2022, 'public/uploads/prestasi/607', '2022-12-07 13:59:35', NULL, NULL, NULL),
(205, 614, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 614', 2022, 'public/uploads/prestasi/614', '2022-12-07 13:59:36', NULL, NULL, NULL),
(206, 615, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 615', 2022, 'public/uploads/prestasi/615', '2022-12-07 13:59:36', NULL, NULL, NULL),
(207, 619, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 619', 2022, 'public/uploads/prestasi/619', '2022-12-07 13:59:37', NULL, NULL, NULL),
(208, 622, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 622', 2022, 'public/uploads/prestasi/622', '2022-12-07 13:59:37', NULL, NULL, NULL),
(209, 623, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 623', 2022, 'public/uploads/prestasi/623', '2022-12-07 13:59:37', NULL, NULL, NULL),
(210, 627, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 627', 2022, 'public/uploads/prestasi/627', '2022-12-07 13:59:38', NULL, NULL, NULL),
(211, 636, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 636', 2022, 'public/uploads/prestasi/636', '2022-12-07 13:59:39', NULL, NULL, NULL),
(212, 644, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 644', 2022, 'public/uploads/prestasi/644', '2022-12-07 13:59:40', NULL, NULL, NULL),
(213, 646, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 646', 2022, 'public/uploads/prestasi/646', '2022-12-07 13:59:41', NULL, NULL, NULL),
(214, 647, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 647', 2022, 'public/uploads/prestasi/647', '2022-12-07 13:59:41', NULL, NULL, NULL),
(215, 654, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 654', 2022, 'public/uploads/prestasi/654', '2022-12-07 13:59:42', NULL, NULL, NULL),
(216, 657, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 657', 2022, 'public/uploads/prestasi/657', '2022-12-07 13:59:43', NULL, NULL, NULL),
(217, 658, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 658', 2022, 'public/uploads/prestasi/658', '2022-12-07 13:59:44', NULL, NULL, NULL),
(218, 659, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 659', 2022, 'public/uploads/prestasi/659', '2022-12-07 13:59:44', NULL, NULL, NULL),
(219, 661, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 661', 2022, 'public/uploads/prestasi/661', '2022-12-07 13:59:44', NULL, NULL, NULL),
(220, 665, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 665', 2022, 'public/uploads/prestasi/665', '2022-12-07 13:59:46', NULL, NULL, NULL),
(221, 667, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 667', 2022, 'public/uploads/prestasi/667', '2022-12-07 13:59:46', NULL, NULL, NULL),
(222, 669, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 669', 2022, 'public/uploads/prestasi/669', '2022-12-07 13:59:47', NULL, NULL, NULL),
(223, 671, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 671', 2022, 'public/uploads/prestasi/671', '2022-12-07 13:59:47', NULL, NULL, NULL),
(224, 672, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 672', 2022, 'public/uploads/prestasi/672', '2022-12-07 13:59:48', NULL, NULL, NULL),
(225, 675, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 675', 2022, 'public/uploads/prestasi/675', '2022-12-07 13:59:49', NULL, NULL, NULL),
(226, 678, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 678', 2022, 'public/uploads/prestasi/678', '2022-12-07 13:59:50', NULL, NULL, NULL),
(227, 680, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 680', 2022, 'public/uploads/prestasi/680', '2022-12-07 13:59:50', NULL, NULL, NULL),
(228, 682, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 682', 2022, 'public/uploads/prestasi/682', '2022-12-07 13:59:51', NULL, NULL, NULL),
(229, 691, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 691', 2022, 'public/uploads/prestasi/691', '2022-12-07 13:59:54', NULL, NULL, NULL),
(230, 692, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 692', 2022, 'public/uploads/prestasi/692', '2022-12-07 13:59:55', NULL, NULL, NULL),
(231, 694, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 694', 2022, 'public/uploads/prestasi/694', '2022-12-07 13:59:56', NULL, NULL, NULL),
(232, 703, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 703', 2022, 'public/uploads/prestasi/703', '2022-12-07 13:59:59', NULL, NULL, NULL),
(233, 714, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 714', 2022, 'public/uploads/prestasi/714', '2022-12-07 14:00:02', NULL, NULL, NULL),
(234, 717, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 717', 2022, 'public/uploads/prestasi/717', '2022-12-07 14:00:03', NULL, NULL, NULL),
(235, 719, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 719', 2022, 'public/uploads/prestasi/719', '2022-12-07 14:00:04', NULL, NULL, NULL),
(236, 723, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 723', 2022, 'public/uploads/prestasi/723', '2022-12-07 14:00:04', NULL, NULL, NULL),
(237, 725, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 725', 2022, 'public/uploads/prestasi/725', '2022-12-07 14:00:05', NULL, NULL, NULL),
(238, 726, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 726', 2022, 'public/uploads/prestasi/726', '2022-12-07 14:00:05', NULL, NULL, NULL),
(239, 729, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 729', 2022, 'public/uploads/prestasi/729', '2022-12-07 14:00:05', NULL, NULL, NULL),
(240, 735, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 735', 2022, 'public/uploads/prestasi/735', '2022-12-07 14:00:06', NULL, NULL, NULL),
(241, 742, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 742', 2022, 'public/uploads/prestasi/742', '2022-12-07 14:00:07', NULL, NULL, NULL),
(242, 743, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 743', 2022, 'public/uploads/prestasi/743', '2022-12-07 14:00:07', NULL, NULL, NULL),
(243, 751, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 751', 2022, 'public/uploads/prestasi/751', '2022-12-07 14:00:09', NULL, NULL, NULL),
(244, 756, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 756', 2022, 'public/uploads/prestasi/756', '2022-12-07 14:00:10', NULL, NULL, NULL),
(245, 758, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 758', 2022, 'public/uploads/prestasi/758', '2022-12-07 14:00:11', NULL, NULL, NULL),
(246, 760, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 760', 2022, 'public/uploads/prestasi/760', '2022-12-07 14:00:11', NULL, NULL, NULL),
(247, 761, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 761', 2022, 'public/uploads/prestasi/761', '2022-12-07 14:00:11', NULL, NULL, NULL),
(248, 767, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 767', 2022, 'public/uploads/prestasi/767', '2022-12-07 14:00:12', NULL, NULL, NULL),
(249, 768, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 768', 2022, 'public/uploads/prestasi/768', '2022-12-07 14:00:12', NULL, NULL, NULL),
(250, 769, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 769', 2022, 'public/uploads/prestasi/769', '2022-12-07 14:00:13', NULL, NULL, NULL),
(251, 770, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 770', 2022, 'public/uploads/prestasi/770', '2022-12-07 14:00:13', NULL, NULL, NULL),
(252, 771, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 771', 2022, 'public/uploads/prestasi/771', '2022-12-07 14:00:13', NULL, NULL, NULL),
(253, 772, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 772', 2022, 'public/uploads/prestasi/772', '2022-12-07 14:00:14', NULL, NULL, NULL),
(254, 775, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 775', 2022, 'public/uploads/prestasi/775', '2022-12-07 14:00:14', NULL, NULL, NULL),
(255, 786, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 786', 2022, 'public/uploads/prestasi/786', '2022-12-07 14:00:15', NULL, NULL, NULL),
(256, 789, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 789', 2022, 'public/uploads/prestasi/789', '2022-12-07 14:00:16', NULL, NULL, NULL),
(257, 795, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 795', 2022, 'public/uploads/prestasi/795', '2022-12-07 14:00:16', NULL, NULL, NULL),
(258, 796, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 796', 2022, 'public/uploads/prestasi/796', '2022-12-07 14:00:16', NULL, NULL, NULL),
(259, 802, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 802', 2022, 'public/uploads/prestasi/802', '2022-12-07 14:00:17', NULL, NULL, NULL),
(260, 803, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 803', 2022, 'public/uploads/prestasi/803', '2022-12-07 14:00:17', NULL, NULL, NULL),
(261, 805, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 805', 2022, 'public/uploads/prestasi/805', '2022-12-07 14:00:18', NULL, NULL, NULL),
(262, 808, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 808', 2022, 'public/uploads/prestasi/808', '2022-12-07 14:00:18', NULL, NULL, NULL),
(263, 812, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 812', 2022, 'public/uploads/prestasi/812', '2022-12-07 14:00:19', NULL, NULL, NULL),
(264, 813, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 813', 2022, 'public/uploads/prestasi/813', '2022-12-07 14:00:19', NULL, NULL, NULL),
(265, 817, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 817', 2022, 'public/uploads/prestasi/817', '2022-12-07 14:00:19', NULL, NULL, NULL),
(266, 820, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 820', 2022, 'public/uploads/prestasi/820', '2022-12-07 14:00:19', NULL, NULL, NULL),
(267, 822, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 822', 2022, 'public/uploads/prestasi/822', '2022-12-07 14:00:20', NULL, NULL, NULL),
(268, 823, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 823', 2022, 'public/uploads/prestasi/823', '2022-12-07 14:00:20', NULL, NULL, NULL),
(269, 832, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 832', 2022, 'public/uploads/prestasi/832', '2022-12-07 14:00:21', NULL, NULL, NULL),
(270, 837, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 837', 2022, 'public/uploads/prestasi/837', '2022-12-07 14:00:22', NULL, NULL, NULL),
(271, 842, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 842', 2022, 'public/uploads/prestasi/842', '2022-12-07 14:00:22', NULL, NULL, NULL),
(272, 844, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 844', 2022, 'public/uploads/prestasi/844', '2022-12-07 14:00:23', NULL, NULL, NULL),
(273, 846, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 846', 2022, 'public/uploads/prestasi/846', '2022-12-07 14:00:23', NULL, NULL, NULL),
(274, 849, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 849', 2022, 'public/uploads/prestasi/849', '2022-12-07 14:00:24', NULL, NULL, NULL),
(275, 850, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 850', 2022, 'public/uploads/prestasi/850', '2022-12-07 14:00:24', NULL, NULL, NULL),
(276, 852, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 852', 2022, 'public/uploads/prestasi/852', '2022-12-07 14:00:25', NULL, NULL, NULL),
(277, 853, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 853', 2022, 'public/uploads/prestasi/853', '2022-12-07 14:00:25', NULL, NULL, NULL),
(278, 857, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 857', 2022, 'public/uploads/prestasi/857', '2022-12-07 14:00:25', NULL, NULL, NULL),
(279, 858, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 858', 2022, 'public/uploads/prestasi/858', '2022-12-07 14:00:25', NULL, NULL, NULL),
(280, 860, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 860', 2022, 'public/uploads/prestasi/860', '2022-12-07 14:00:26', NULL, NULL, NULL),
(281, 867, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 867', 2022, 'public/uploads/prestasi/867', '2022-12-07 14:00:26', NULL, NULL, NULL),
(282, 870, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 870', 2022, 'public/uploads/prestasi/870', '2022-12-07 14:00:27', NULL, NULL, NULL),
(283, 872, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 872', 2022, 'public/uploads/prestasi/872', '2022-12-07 14:00:27', NULL, NULL, NULL),
(284, 873, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 873', 2022, 'public/uploads/prestasi/873', '2022-12-07 14:00:28', NULL, NULL, NULL),
(285, 874, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 874', 2022, 'public/uploads/prestasi/874', '2022-12-07 14:00:28', NULL, NULL, NULL),
(286, 881, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 881', 2022, 'public/uploads/prestasi/881', '2022-12-07 14:00:29', NULL, NULL, NULL),
(287, 884, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 884', 2022, 'public/uploads/prestasi/884', '2022-12-07 14:00:30', NULL, NULL, NULL),
(288, 885, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 885', 2022, 'public/uploads/prestasi/885', '2022-12-07 14:00:30', NULL, NULL, NULL),
(289, 890, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 890', 2022, 'public/uploads/prestasi/890', '2022-12-07 14:00:31', NULL, NULL, NULL),
(290, 895, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 895', 2022, 'public/uploads/prestasi/895', '2022-12-07 14:00:32', NULL, NULL, NULL),
(291, 904, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 904', 2022, 'public/uploads/prestasi/904', '2022-12-07 14:00:33', NULL, NULL, NULL),
(292, 911, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 911', 2022, 'public/uploads/prestasi/911', '2022-12-07 14:00:35', NULL, NULL, NULL),
(293, 912, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 912', 2022, 'public/uploads/prestasi/912', '2022-12-07 14:00:35', NULL, NULL, NULL),
(294, 913, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 913', 2022, 'public/uploads/prestasi/913', '2022-12-07 14:00:36', NULL, NULL, NULL),
(295, 917, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 917', 2022, 'public/uploads/prestasi/917', '2022-12-07 14:00:36', NULL, NULL, NULL),
(296, 923, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 923', 2022, 'public/uploads/prestasi/923', '2022-12-07 14:00:38', NULL, NULL, NULL),
(297, 926, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 926', 2022, 'public/uploads/prestasi/926', '2022-12-07 14:00:38', NULL, NULL, NULL),
(298, 931, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 931', 2022, 'public/uploads/prestasi/931', '2022-12-07 14:00:39', NULL, NULL, NULL),
(299, 938, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 938', 2022, 'public/uploads/prestasi/938', '2022-12-07 14:00:41', NULL, NULL, NULL),
(300, 939, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 939', 2022, 'public/uploads/prestasi/939', '2022-12-07 14:00:41', NULL, NULL, NULL),
(301, 941, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 941', 2022, 'public/uploads/prestasi/941', '2022-12-07 14:00:42', NULL, NULL, NULL),
(302, 943, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 943', 2022, 'public/uploads/prestasi/943', '2022-12-07 14:00:43', NULL, NULL, NULL),
(303, 949, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 949', 2022, 'public/uploads/prestasi/949', '2022-12-07 14:00:44', NULL, NULL, NULL),
(304, 952, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 952', 2022, 'public/uploads/prestasi/952', '2022-12-07 14:00:44', NULL, NULL, NULL),
(305, 954, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 954', 2022, 'public/uploads/prestasi/954', '2022-12-07 14:00:45', NULL, NULL, NULL),
(306, 957, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 957', 2022, 'public/uploads/prestasi/957', '2022-12-07 14:00:45', NULL, NULL, NULL),
(307, 960, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 960', 2022, 'public/uploads/prestasi/960', '2022-12-07 14:00:46', NULL, NULL, NULL),
(308, 962, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 962', 2022, 'public/uploads/prestasi/962', '2022-12-07 14:00:50', NULL, NULL, NULL),
(309, 964, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 964', 2022, 'public/uploads/prestasi/964', '2022-12-07 14:00:53', NULL, NULL, NULL),
(310, 966, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 966', 2022, 'public/uploads/prestasi/966', '2022-12-07 14:00:54', NULL, NULL, NULL),
(311, 973, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 973', 2022, 'public/uploads/prestasi/973', '2022-12-07 14:00:56', NULL, NULL, NULL),
(312, 986, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 986', 2022, 'public/uploads/prestasi/986', '2022-12-07 14:00:59', NULL, NULL, NULL),
(313, 992, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 992', 2022, 'public/uploads/prestasi/992', '2022-12-07 14:01:00', NULL, NULL, NULL),
(314, 996, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 996', 2022, 'public/uploads/prestasi/996', '2022-12-07 14:01:01', NULL, NULL, NULL),
(315, 998, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 998', 2022, 'public/uploads/prestasi/998', '2022-12-07 14:01:02', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `perguruan_tinggi`
--

CREATE TABLE `perguruan_tinggi` (
  `id_perguruan_tinggi` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `perguruan_tinggi`
--

INSERT INTO `perguruan_tinggi` (`id_perguruan_tinggi`, `nama`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'AMD Academy', '2022-12-07 04:58:50', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prodi`
--

CREATE TABLE `prodi` (
  `id_prodi` int(11) NOT NULL,
  `id_fakultas` int(11) NOT NULL,
  `nama_prodi` varchar(255) NOT NULL,
  `jenjang` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prodi`
--

INSERT INTO `prodi` (`id_prodi`, `id_fakultas`, `nama_prodi`, `jenjang`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'Teknik Informatika', 'S1', '2022-12-07 05:11:46', NULL, NULL, '2022-12-07 05:26:33'),
(2, 1, 'Teknik Industri', 'S1', '2022-12-07 05:11:46', NULL, NULL, '2022-12-07 05:22:51'),
(3, 1, 'Teknin Mesin', 'S1', '2022-12-07 05:17:31', NULL, NULL, '2022-12-07 05:22:55'),
(4, 1, 'Teknik Elektro', 'S1', '2022-12-07 05:17:31', NULL, NULL, '2022-12-07 05:22:58'),
(5, 2, 'Sastra Inggris', 'S1', '2022-12-07 05:18:25', NULL, NULL, '2022-12-07 05:23:01'),
(6, 3, 'Sistem Infromasi', 'S1', '2022-12-07 05:18:25', NULL, NULL, '2022-12-07 05:23:04'),
(7, 4, 'Manajemen', 'S1', '2022-12-07 05:20:04', NULL, NULL, '2022-12-07 05:23:07'),
(8, 4, 'Akuntansi', 'S1', '2022-12-07 05:20:04', NULL, NULL, '2022-12-07 05:23:10'),
(9, 4, 'Ilmu Ekonomi', 'S1', '2022-12-07 05:22:28', NULL, NULL, '2022-12-07 05:23:14'),
(10, 5, 'Psikologi', 'S1', '2022-12-07 05:22:28', NULL, NULL, '2022-12-07 05:23:19'),
(11, 5, 'Psikologi', 'S2', '2022-12-07 05:25:10', NULL, NULL, '2022-12-07 05:25:31'),
(12, 2, 'Sastra Inggris', 'S2', '2022-12-07 05:25:10', NULL, NULL, '2022-12-07 05:26:55'),
(13, 1, 'Teknik Mesin', 'S2', '2022-12-07 05:26:01', NULL, NULL, '2022-12-07 05:27:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indexes for table `fakultas`
--
ALTER TABLE `fakultas`
  ADD PRIMARY KEY (`id_fakultas`),
  ADD KEY `id_perguruan_tinggi` (`id_perguruan_tinggi`),
  ADD KEY `id_perguruan_tinggi_2` (`id_perguruan_tinggi`);

--
-- Indexes for table `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  ADD PRIMARY KEY (`id_jalur`);

--
-- Indexes for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id_pendaftar`),
  ADD UNIQUE KEY `UNI` (`no_pendaftar`),
  ADD KEY `MUL` (`id_jalur`),
  ADD KEY `id_prodi1` (`id_prodi1`),
  ADD KEY `id_prodi2` (`id_prodi2`),
  ADD KEY `id_bank` (`id_bank`);

--
-- Indexes for table `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pendaftar` (`id_pendaftar`);

--
-- Indexes for table `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  ADD PRIMARY KEY (`id_perguruan_tinggi`);

--
-- Indexes for table `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`id_prodi`),
  ADD KEY `id_fakultas` (`id_fakultas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `fakultas`
--
ALTER TABLE `fakultas`
  MODIFY `id_fakultas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  MODIFY `id_jalur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pendaftar`
--
ALTER TABLE `pendaftar`
  MODIFY `id_pendaftar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT for table `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=316;

--
-- AUTO_INCREMENT for table `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  MODIFY `id_perguruan_tinggi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prodi`
--
ALTER TABLE `prodi`
  MODIFY `id_prodi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fakultas`
--
ALTER TABLE `fakultas`
  ADD CONSTRAINT `fakultas_ibfk_1` FOREIGN KEY (`id_perguruan_tinggi`) REFERENCES `perguruan_tinggi` (`id_perguruan_tinggi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD CONSTRAINT `pendaftar_ibfk_1` FOREIGN KEY (`id_prodi1`) REFERENCES `prodi` (`id_prodi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_2` FOREIGN KEY (`id_prodi2`) REFERENCES `prodi` (`id_prodi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_3` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_4` FOREIGN KEY (`id_jalur`) REFERENCES `jalur_masuk` (`id_jalur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD CONSTRAINT `pendaftar_prestasi_ibfk_1` FOREIGN KEY (`id_pendaftar`) REFERENCES `pendaftar` (`id_pendaftar`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prodi`
--
ALTER TABLE `prodi`
  ADD CONSTRAINT `prodi_ibfk_1` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
