-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2022 at 08:42 AM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `dummy` ()   BEGIN

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
    DECLARE bank_id int(11);
    DECLARE isb enum('Ya','Tidak');
    
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
    SET nama = (SELECT CONCAT('AprilYandi Dwi W', (i+1)));
    SET nisn = (SELECT CONCAT('56419974', (i+1)));
    SET nik = (SELECT CONCAT('3276022304010010', (i+1)));
    SET tempat_lahir = 'Jakarta';
    SET tanggal_lahir = (SELECT '2001-04-23'- INTERVAL FLOOR(RAND() * 30) DAY);
    SET jenis_kelamin = 'Laki-Laki';
    SET no_hp = (SELECT CONCAT('08810243', (i+1)));
    SET alamat = (SELECT CONCAT('Kp.Babakan No. ', (i+1)));
    SET agama = 'Islam';
    SET idp1 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
    SET idp2 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
    SET nominal_bayar = 150000;
    SET bank_id = (SELECT id_bank FROM bank ORDER BY RAND() LIMIT 1);
    SET isb = 'Ya';
    
    IF jalur_id = 3 THEN
        SET nominal_bayar = null;
        SET bank_id = null;
        SET isb = 'Tidak';
        END IF;

    IF (i+1) % 5 = 0 THEN
        SET jenis_kelamin = 'Perempuan';
        SET tempat_lahir = 'Semarang';
        END IF;
 
    INSERT INTO pendaftar (id_jalur, no_pendaftar, nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, alamat, agama, id_prodi1, id_prodi2, nominal_bayar, id_bank, status_bayar)
    VALUES (jalur_id, no_pendaftar, nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, alamat, agama, idp1, idp2, nominal_bayar, bank_id, isb);

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
  `nama_bank` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
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
(1, 'Mandiri Tes', 1, 0, '2022-12-07 11:40:52', NULL, NULL, NULL),
(2, 'Mandiri Prestasi', 0, 1, '2022-12-07 11:40:52', NULL, NULL, NULL),
(3, 'SNMPTN', 0, 0, '2022-12-07 11:40:52', NULL, NULL, NULL);

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
  `alamat` text NOT NULL,
  `agama` varchar(25) NOT NULL,
  `id_prodi1` int(11) NOT NULL,
  `id_prodi2` int(11) DEFAULT NULL,
  `nominal_bayar` decimal(12,2) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `status_bayar` enum('Ya','Tidak') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendaftar`
--

INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 2, 'P202221', 'AprilYandi Dwi W1', '564199741', '32760223040100101', 'Jakarta', '2001-04-02', 'Laki-Laki', '088102431', 'Kp.Babakan No. 1', 'Islam', 13, 8, '150000.00', 1, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(2, 1, 'P202212', 'AprilYandi Dwi W2', '564199742', '32760223040100102', 'Jakarta', '2001-04-06', 'Laki-Laki', '088102432', 'Kp.Babakan No. 2', 'Islam', 10, 10, '150000.00', 3, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(3, 2, 'P202223', 'AprilYandi Dwi W3', '564199743', '32760223040100103', 'Jakarta', '2001-04-08', 'Laki-Laki', '088102433', 'Kp.Babakan No. 3', 'Islam', 2, 10, '150000.00', 3, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(4, 3, 'P202234', 'AprilYandi Dwi W4', '564199744', '32760223040100104', 'Jakarta', '2001-04-16', 'Laki-Laki', '088102434', 'Kp.Babakan No. 4', 'Islam', 6, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:21', NULL, NULL, NULL),
(5, 2, 'P202225', 'AprilYandi Dwi W5', '564199745', '32760223040100105', 'Semarang', '2001-04-12', 'Perempuan', '088102435', 'Kp.Babakan No. 5', 'Islam', 9, 3, '150000.00', 1, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(6, 2, 'P202226', 'AprilYandi Dwi W6', '564199746', '32760223040100106', 'Jakarta', '2001-03-28', 'Laki-Laki', '088102436', 'Kp.Babakan No. 6', 'Islam', 10, 9, '150000.00', 3, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(7, 1, 'P202217', 'AprilYandi Dwi W7', '564199747', '32760223040100107', 'Jakarta', '2001-03-30', 'Laki-Laki', '088102437', 'Kp.Babakan No. 7', 'Islam', 6, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(8, 1, 'P202218', 'AprilYandi Dwi W8', '564199748', '32760223040100108', 'Jakarta', '2001-04-04', 'Laki-Laki', '088102438', 'Kp.Babakan No. 8', 'Islam', 8, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(9, 2, 'P202229', 'AprilYandi Dwi W9', '564199749', '32760223040100109', 'Jakarta', '2001-04-18', 'Laki-Laki', '088102439', 'Kp.Babakan No. 9', 'Islam', 11, 10, '150000.00', 2, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(10, 1, 'P2022110', 'AprilYandi Dwi W10', '5641997410', '327602230401001010', 'Semarang', '2001-04-06', 'Perempuan', '0881024310', 'Kp.Babakan No. 10', 'Islam', 12, 11, '150000.00', 4, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(11, 2, 'P2022211', 'AprilYandi Dwi W11', '5641997411', '327602230401001011', 'Jakarta', '2001-04-22', 'Laki-Laki', '0881024311', 'Kp.Babakan No. 11', 'Islam', 2, 1, '150000.00', 1, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(12, 1, 'P2022112', 'AprilYandi Dwi W12', '5641997412', '327602230401001012', 'Jakarta', '2001-04-08', 'Laki-Laki', '0881024312', 'Kp.Babakan No. 12', 'Islam', 8, 7, '150000.00', 4, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(13, 2, 'P2022213', 'AprilYandi Dwi W13', '5641997413', '327602230401001013', 'Jakarta', '2001-03-27', 'Laki-Laki', '0881024313', 'Kp.Babakan No. 13', 'Islam', 1, 4, '150000.00', 3, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(14, 1, 'P2022114', 'AprilYandi Dwi W14', '5641997414', '327602230401001014', 'Jakarta', '2001-04-15', 'Laki-Laki', '0881024314', 'Kp.Babakan No. 14', 'Islam', 5, 4, '150000.00', 2, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(15, 1, 'P2022115', 'AprilYandi Dwi W15', '5641997415', '327602230401001015', 'Semarang', '2001-04-11', 'Perempuan', '0881024315', 'Kp.Babakan No. 15', 'Islam', 5, 4, '150000.00', 4, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(16, 1, 'P2022116', 'AprilYandi Dwi W16', '5641997416', '327602230401001016', 'Jakarta', '2001-04-05', 'Laki-Laki', '0881024316', 'Kp.Babakan No. 16', 'Islam', 7, 3, '150000.00', 1, 'Ya', '2022-12-11 06:45:21', NULL, NULL, NULL),
(17, 3, 'P2022317', 'AprilYandi Dwi W17', '5641997417', '327602230401001017', 'Jakarta', '2001-04-18', 'Laki-Laki', '0881024317', 'Kp.Babakan No. 17', 'Islam', 13, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:22', NULL, NULL, NULL),
(18, 2, 'P2022218', 'AprilYandi Dwi W18', '5641997418', '327602230401001018', 'Jakarta', '2001-03-26', 'Laki-Laki', '0881024318', 'Kp.Babakan No. 18', 'Islam', 2, 4, '150000.00', 1, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(19, 1, 'P2022119', 'AprilYandi Dwi W19', '5641997419', '327602230401001019', 'Jakarta', '2001-03-31', 'Laki-Laki', '0881024319', 'Kp.Babakan No. 19', 'Islam', 9, 11, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(20, 3, 'P2022320', 'AprilYandi Dwi W20', '5641997420', '327602230401001020', 'Semarang', '2001-04-08', 'Perempuan', '0881024320', 'Kp.Babakan No. 20', 'Islam', 10, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:22', NULL, NULL, NULL),
(21, 2, 'P2022221', 'AprilYandi Dwi W21', '5641997421', '327602230401001021', 'Jakarta', '2001-03-28', 'Laki-Laki', '0881024321', 'Kp.Babakan No. 21', 'Islam', 6, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(22, 3, 'P2022322', 'AprilYandi Dwi W22', '5641997422', '327602230401001022', 'Jakarta', '2001-04-21', 'Laki-Laki', '0881024322', 'Kp.Babakan No. 22', 'Islam', 4, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:22', NULL, NULL, NULL),
(23, 3, 'P2022323', 'AprilYandi Dwi W23', '5641997423', '327602230401001023', 'Jakarta', '2001-04-13', 'Laki-Laki', '0881024323', 'Kp.Babakan No. 23', 'Islam', 12, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:22', NULL, NULL, NULL),
(24, 1, 'P2022124', 'AprilYandi Dwi W24', '5641997424', '327602230401001024', 'Jakarta', '2001-04-22', 'Laki-Laki', '0881024324', 'Kp.Babakan No. 24', 'Islam', 6, 9, '150000.00', 1, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(25, 2, 'P2022225', 'AprilYandi Dwi W25', '5641997425', '327602230401001025', 'Semarang', '2001-04-07', 'Perempuan', '0881024325', 'Kp.Babakan No. 25', 'Islam', 12, 1, '150000.00', 2, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(26, 2, 'P2022226', 'AprilYandi Dwi W26', '5641997426', '327602230401001026', 'Jakarta', '2001-04-19', 'Laki-Laki', '0881024326', 'Kp.Babakan No. 26', 'Islam', 13, 3, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(27, 3, 'P2022327', 'AprilYandi Dwi W27', '5641997427', '327602230401001027', 'Jakarta', '2001-04-07', 'Laki-Laki', '0881024327', 'Kp.Babakan No. 27', 'Islam', 12, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:22', NULL, NULL, NULL),
(28, 2, 'P2022228', 'AprilYandi Dwi W28', '5641997428', '327602230401001028', 'Jakarta', '2001-03-30', 'Laki-Laki', '0881024328', 'Kp.Babakan No. 28', 'Islam', 6, 13, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(29, 1, 'P2022129', 'AprilYandi Dwi W29', '5641997429', '327602230401001029', 'Jakarta', '2001-04-15', 'Laki-Laki', '0881024329', 'Kp.Babakan No. 29', 'Islam', 9, 3, '150000.00', 4, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(30, 1, 'P2022130', 'AprilYandi Dwi W30', '5641997430', '327602230401001030', 'Semarang', '2001-04-10', 'Perempuan', '0881024330', 'Kp.Babakan No. 30', 'Islam', 4, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(31, 2, 'P2022231', 'AprilYandi Dwi W31', '5641997431', '327602230401001031', 'Jakarta', '2001-04-18', 'Laki-Laki', '0881024331', 'Kp.Babakan No. 31', 'Islam', 1, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(32, 1, 'P2022132', 'AprilYandi Dwi W32', '5641997432', '327602230401001032', 'Jakarta', '2001-04-06', 'Laki-Laki', '0881024332', 'Kp.Babakan No. 32', 'Islam', 10, 12, '150000.00', 2, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(33, 2, 'P2022233', 'AprilYandi Dwi W33', '5641997433', '327602230401001033', 'Jakarta', '2001-04-04', 'Laki-Laki', '0881024333', 'Kp.Babakan No. 33', 'Islam', 12, 9, '150000.00', 2, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(34, 2, 'P2022234', 'AprilYandi Dwi W34', '5641997434', '327602230401001034', 'Jakarta', '2001-03-31', 'Laki-Laki', '0881024334', 'Kp.Babakan No. 34', 'Islam', 12, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(35, 1, 'P2022135', 'AprilYandi Dwi W35', '5641997435', '327602230401001035', 'Semarang', '2001-04-12', 'Perempuan', '0881024335', 'Kp.Babakan No. 35', 'Islam', 13, 3, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(36, 3, 'P2022336', 'AprilYandi Dwi W36', '5641997436', '327602230401001036', 'Jakarta', '2001-03-29', 'Laki-Laki', '0881024336', 'Kp.Babakan No. 36', 'Islam', 8, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:22', NULL, NULL, NULL),
(37, 1, 'P2022137', 'AprilYandi Dwi W37', '5641997437', '327602230401001037', 'Jakarta', '2001-03-27', 'Laki-Laki', '0881024337', 'Kp.Babakan No. 37', 'Islam', 13, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:22', NULL, NULL, NULL),
(38, 2, 'P2022238', 'AprilYandi Dwi W38', '5641997438', '327602230401001038', 'Jakarta', '2001-04-16', 'Laki-Laki', '0881024338', 'Kp.Babakan No. 38', 'Islam', 5, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(39, 1, 'P2022139', 'AprilYandi Dwi W39', '5641997439', '327602230401001039', 'Jakarta', '2001-04-08', 'Laki-Laki', '0881024339', 'Kp.Babakan No. 39', 'Islam', 3, 3, '150000.00', 1, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(40, 2, 'P2022240', 'AprilYandi Dwi W40', '5641997440', '327602230401001040', 'Semarang', '2001-04-21', 'Perempuan', '0881024340', 'Kp.Babakan No. 40', 'Islam', 5, 8, '150000.00', 1, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(41, 2, 'P2022241', 'AprilYandi Dwi W41', '5641997441', '327602230401001041', 'Jakarta', '2001-04-08', 'Laki-Laki', '0881024341', 'Kp.Babakan No. 41', 'Islam', 4, 5, '150000.00', 3, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(42, 3, 'P2022342', 'AprilYandi Dwi W42', '5641997442', '327602230401001042', 'Jakarta', '2001-04-17', 'Laki-Laki', '0881024342', 'Kp.Babakan No. 42', 'Islam', 1, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:23', NULL, NULL, NULL),
(43, 2, 'P2022243', 'AprilYandi Dwi W43', '5641997443', '327602230401001043', 'Jakarta', '2001-03-28', 'Laki-Laki', '0881024343', 'Kp.Babakan No. 43', 'Islam', 13, 2, '150000.00', 4, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(44, 1, 'P2022144', 'AprilYandi Dwi W44', '5641997444', '327602230401001044', 'Jakarta', '2001-04-15', 'Laki-Laki', '0881024344', 'Kp.Babakan No. 44', 'Islam', 9, 7, '150000.00', 4, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(45, 1, 'P2022145', 'AprilYandi Dwi W45', '5641997445', '327602230401001045', 'Semarang', '2001-04-03', 'Perempuan', '0881024345', 'Kp.Babakan No. 45', 'Islam', 5, 4, '150000.00', 4, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(46, 3, 'P2022346', 'AprilYandi Dwi W46', '5641997446', '327602230401001046', 'Jakarta', '2001-03-31', 'Laki-Laki', '0881024346', 'Kp.Babakan No. 46', 'Islam', 2, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:23', NULL, NULL, NULL),
(47, 1, 'P2022147', 'AprilYandi Dwi W47', '5641997447', '327602230401001047', 'Jakarta', '2001-04-05', 'Laki-Laki', '0881024347', 'Kp.Babakan No. 47', 'Islam', 9, 11, '150000.00', 4, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(48, 1, 'P2022148', 'AprilYandi Dwi W48', '5641997448', '327602230401001048', 'Jakarta', '2001-04-14', 'Laki-Laki', '0881024348', 'Kp.Babakan No. 48', 'Islam', 12, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(49, 3, 'P2022349', 'AprilYandi Dwi W49', '5641997449', '327602230401001049', 'Jakarta', '2001-04-01', 'Laki-Laki', '0881024349', 'Kp.Babakan No. 49', 'Islam', 10, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:23', NULL, NULL, NULL),
(50, 3, 'P2022350', 'AprilYandi Dwi W50', '5641997450', '327602230401001050', 'Semarang', '2001-03-31', 'Perempuan', '0881024350', 'Kp.Babakan No. 50', 'Islam', 1, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:23', NULL, NULL, NULL),
(51, 3, 'P2022351', 'AprilYandi Dwi W51', '5641997451', '327602230401001051', 'Jakarta', '2001-04-20', 'Laki-Laki', '0881024351', 'Kp.Babakan No. 51', 'Islam', 7, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:23', NULL, NULL, NULL),
(52, 1, 'P2022152', 'AprilYandi Dwi W52', '5641997452', '327602230401001052', 'Jakarta', '2001-04-13', 'Laki-Laki', '0881024352', 'Kp.Babakan No. 52', 'Islam', 4, 3, '150000.00', 3, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(53, 1, 'P2022153', 'AprilYandi Dwi W53', '5641997453', '327602230401001053', 'Jakarta', '2001-04-13', 'Laki-Laki', '0881024353', 'Kp.Babakan No. 53', 'Islam', 2, 1, '150000.00', 2, 'Ya', '2022-12-11 06:45:23', NULL, NULL, NULL),
(54, 2, 'P2022254', 'AprilYandi Dwi W54', '5641997454', '327602230401001054', 'Jakarta', '2001-03-30', 'Laki-Laki', '0881024354', 'Kp.Babakan No. 54', 'Islam', 1, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(55, 1, 'P2022155', 'AprilYandi Dwi W55', '5641997455', '327602230401001055', 'Semarang', '2001-04-11', 'Perempuan', '0881024355', 'Kp.Babakan No. 55', 'Islam', 3, 4, '150000.00', 1, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(56, 2, 'P2022256', 'AprilYandi Dwi W56', '5641997456', '327602230401001056', 'Jakarta', '2001-04-16', 'Laki-Laki', '0881024356', 'Kp.Babakan No. 56', 'Islam', 3, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(57, 2, 'P2022257', 'AprilYandi Dwi W57', '5641997457', '327602230401001057', 'Jakarta', '2001-03-29', 'Laki-Laki', '0881024357', 'Kp.Babakan No. 57', 'Islam', 8, 10, '150000.00', 4, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(58, 3, 'P2022358', 'AprilYandi Dwi W58', '5641997458', '327602230401001058', 'Jakarta', '2001-04-08', 'Laki-Laki', '0881024358', 'Kp.Babakan No. 58', 'Islam', 7, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:24', NULL, NULL, NULL),
(59, 2, 'P2022259', 'AprilYandi Dwi W59', '5641997459', '327602230401001059', 'Jakarta', '2001-03-31', 'Laki-Laki', '0881024359', 'Kp.Babakan No. 59', 'Islam', 3, 4, '150000.00', 3, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(60, 3, 'P2022360', 'AprilYandi Dwi W60', '5641997460', '327602230401001060', 'Semarang', '2001-04-12', 'Perempuan', '0881024360', 'Kp.Babakan No. 60', 'Islam', 3, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:24', NULL, NULL, NULL),
(61, 1, 'P2022161', 'AprilYandi Dwi W61', '5641997461', '327602230401001061', 'Jakarta', '2001-04-10', 'Laki-Laki', '0881024361', 'Kp.Babakan No. 61', 'Islam', 13, 9, '150000.00', 3, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(62, 1, 'P2022162', 'AprilYandi Dwi W62', '5641997462', '327602230401001062', 'Jakarta', '2001-04-02', 'Laki-Laki', '0881024362', 'Kp.Babakan No. 62', 'Islam', 11, 6, '150000.00', 3, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(63, 2, 'P2022263', 'AprilYandi Dwi W63', '5641997463', '327602230401001063', 'Jakarta', '2001-04-06', 'Laki-Laki', '0881024363', 'Kp.Babakan No. 63', 'Islam', 13, 2, '150000.00', 1, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(64, 2, 'P2022264', 'AprilYandi Dwi W64', '5641997464', '327602230401001064', 'Jakarta', '2001-04-09', 'Laki-Laki', '0881024364', 'Kp.Babakan No. 64', 'Islam', 7, 3, '150000.00', 1, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(65, 1, 'P2022165', 'AprilYandi Dwi W65', '5641997465', '327602230401001065', 'Semarang', '2001-03-25', 'Perempuan', '0881024365', 'Kp.Babakan No. 65', 'Islam', 4, 3, '150000.00', 3, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(66, 1, 'P2022166', 'AprilYandi Dwi W66', '5641997466', '327602230401001066', 'Jakarta', '2001-04-12', 'Laki-Laki', '0881024366', 'Kp.Babakan No. 66', 'Islam', 10, 8, '150000.00', 2, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(67, 3, 'P2022367', 'AprilYandi Dwi W67', '5641997467', '327602230401001067', 'Jakarta', '2001-03-27', 'Laki-Laki', '0881024367', 'Kp.Babakan No. 67', 'Islam', 6, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:24', NULL, NULL, NULL),
(68, 1, 'P2022168', 'AprilYandi Dwi W68', '5641997468', '327602230401001068', 'Jakarta', '2001-03-30', 'Laki-Laki', '0881024368', 'Kp.Babakan No. 68', 'Islam', 4, 5, '150000.00', 3, 'Ya', '2022-12-11 06:45:24', NULL, NULL, NULL),
(69, 3, 'P2022369', 'AprilYandi Dwi W69', '5641997469', '327602230401001069', 'Jakarta', '2001-04-21', 'Laki-Laki', '0881024369', 'Kp.Babakan No. 69', 'Islam', 1, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:24', NULL, NULL, NULL),
(70, 2, 'P2022270', 'AprilYandi Dwi W70', '5641997470', '327602230401001070', 'Semarang', '2001-04-12', 'Perempuan', '0881024370', 'Kp.Babakan No. 70', 'Islam', 13, 10, '150000.00', 1, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(71, 2, 'P2022271', 'AprilYandi Dwi W71', '5641997471', '327602230401001071', 'Jakarta', '2001-04-16', 'Laki-Laki', '0881024371', 'Kp.Babakan No. 71', 'Islam', 5, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(72, 1, 'P2022172', 'AprilYandi Dwi W72', '5641997472', '327602230401001072', 'Jakarta', '2001-04-17', 'Laki-Laki', '0881024372', 'Kp.Babakan No. 72', 'Islam', 11, 12, '150000.00', 2, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(73, 2, 'P2022273', 'AprilYandi Dwi W73', '5641997473', '327602230401001073', 'Jakarta', '2001-03-27', 'Laki-Laki', '0881024373', 'Kp.Babakan No. 73', 'Islam', 13, 6, '150000.00', 2, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(74, 1, 'P2022174', 'AprilYandi Dwi W74', '5641997474', '327602230401001074', 'Jakarta', '2001-04-06', 'Laki-Laki', '0881024374', 'Kp.Babakan No. 74', 'Islam', 13, 1, '150000.00', 2, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(75, 1, 'P2022175', 'AprilYandi Dwi W75', '5641997475', '327602230401001075', 'Semarang', '2001-04-23', 'Perempuan', '0881024375', 'Kp.Babakan No. 75', 'Islam', 8, 6, '150000.00', 4, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(76, 3, 'P2022376', 'AprilYandi Dwi W76', '5641997476', '327602230401001076', 'Jakarta', '2001-03-31', 'Laki-Laki', '0881024376', 'Kp.Babakan No. 76', 'Islam', 12, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(77, 3, 'P2022377', 'AprilYandi Dwi W77', '5641997477', '327602230401001077', 'Jakarta', '2001-04-08', 'Laki-Laki', '0881024377', 'Kp.Babakan No. 77', 'Islam', 6, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(78, 3, 'P2022378', 'AprilYandi Dwi W78', '5641997478', '327602230401001078', 'Jakarta', '2001-03-25', 'Laki-Laki', '0881024378', 'Kp.Babakan No. 78', 'Islam', 12, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(79, 1, 'P2022179', 'AprilYandi Dwi W79', '5641997479', '327602230401001079', 'Jakarta', '2001-03-29', 'Laki-Laki', '0881024379', 'Kp.Babakan No. 79', 'Islam', 11, 1, '150000.00', 3, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(80, 2, 'P2022280', 'AprilYandi Dwi W80', '5641997480', '327602230401001080', 'Semarang', '2001-04-18', 'Perempuan', '0881024380', 'Kp.Babakan No. 80', 'Islam', 9, 3, '150000.00', 3, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(81, 3, 'P2022381', 'AprilYandi Dwi W81', '5641997481', '327602230401001081', 'Jakarta', '2001-04-13', 'Laki-Laki', '0881024381', 'Kp.Babakan No. 81', 'Islam', 7, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(82, 3, 'P2022382', 'AprilYandi Dwi W82', '5641997482', '327602230401001082', 'Jakarta', '2001-04-20', 'Laki-Laki', '0881024382', 'Kp.Babakan No. 82', 'Islam', 5, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(83, 2, 'P2022283', 'AprilYandi Dwi W83', '5641997483', '327602230401001083', 'Jakarta', '2001-04-08', 'Laki-Laki', '0881024383', 'Kp.Babakan No. 83', 'Islam', 7, 8, '150000.00', 2, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(84, 1, 'P2022184', 'AprilYandi Dwi W84', '5641997484', '327602230401001084', 'Jakarta', '2001-03-31', 'Laki-Laki', '0881024384', 'Kp.Babakan No. 84', 'Islam', 13, 4, '150000.00', 4, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(85, 3, 'P2022385', 'AprilYandi Dwi W85', '5641997485', '327602230401001085', 'Semarang', '2001-04-23', 'Perempuan', '0881024385', 'Kp.Babakan No. 85', 'Islam', 13, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(86, 3, 'P2022386', 'AprilYandi Dwi W86', '5641997486', '327602230401001086', 'Jakarta', '2001-04-02', 'Laki-Laki', '0881024386', 'Kp.Babakan No. 86', 'Islam', 10, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:25', NULL, NULL, NULL),
(87, 1, 'P2022187', 'AprilYandi Dwi W87', '5641997487', '327602230401001087', 'Jakarta', '2001-03-26', 'Laki-Laki', '0881024387', 'Kp.Babakan No. 87', 'Islam', 7, 11, '150000.00', 1, 'Ya', '2022-12-11 06:45:25', NULL, NULL, NULL),
(88, 1, 'P2022188', 'AprilYandi Dwi W88', '5641997488', '327602230401001088', 'Jakarta', '2001-04-02', 'Laki-Laki', '0881024388', 'Kp.Babakan No. 88', 'Islam', 2, 7, '150000.00', 3, 'Ya', '2022-12-11 06:45:26', NULL, NULL, NULL),
(89, 3, 'P2022389', 'AprilYandi Dwi W89', '5641997489', '327602230401001089', 'Jakarta', '2001-04-05', 'Laki-Laki', '0881024389', 'Kp.Babakan No. 89', 'Islam', 12, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:26', NULL, NULL, NULL),
(90, 1, 'P2022190', 'AprilYandi Dwi W90', '5641997490', '327602230401001090', 'Semarang', '2001-04-16', 'Perempuan', '0881024390', 'Kp.Babakan No. 90', 'Islam', 12, 2, '150000.00', 4, 'Ya', '2022-12-11 06:45:26', NULL, NULL, NULL),
(91, 2, 'P2022291', 'AprilYandi Dwi W91', '5641997491', '327602230401001091', 'Jakarta', '2001-04-17', 'Laki-Laki', '0881024391', 'Kp.Babakan No. 91', 'Islam', 6, 13, '150000.00', 3, 'Ya', '2022-12-11 06:45:26', NULL, NULL, NULL),
(92, 3, 'P2022392', 'AprilYandi Dwi W92', '5641997492', '327602230401001092', 'Jakarta', '2001-04-23', 'Laki-Laki', '0881024392', 'Kp.Babakan No. 92', 'Islam', 7, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:26', NULL, NULL, NULL),
(93, 3, 'P2022393', 'AprilYandi Dwi W93', '5641997493', '327602230401001093', 'Jakarta', '2001-03-26', 'Laki-Laki', '0881024393', 'Kp.Babakan No. 93', 'Islam', 8, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:26', NULL, NULL, NULL),
(94, 3, 'P2022394', 'AprilYandi Dwi W94', '5641997494', '327602230401001094', 'Jakarta', '2001-04-16', 'Laki-Laki', '0881024394', 'Kp.Babakan No. 94', 'Islam', 3, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:26', NULL, NULL, NULL),
(95, 1, 'P2022195', 'AprilYandi Dwi W95', '5641997495', '327602230401001095', 'Semarang', '2001-03-30', 'Perempuan', '0881024395', 'Kp.Babakan No. 95', 'Islam', 5, 13, '150000.00', 4, 'Ya', '2022-12-11 06:45:26', NULL, NULL, NULL),
(96, 2, 'P2022296', 'AprilYandi Dwi W96', '5641997496', '327602230401001096', 'Jakarta', '2001-04-12', 'Laki-Laki', '0881024396', 'Kp.Babakan No. 96', 'Islam', 13, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:26', NULL, NULL, NULL),
(97, 3, 'P2022397', 'AprilYandi Dwi W97', '5641997497', '327602230401001097', 'Jakarta', '2001-03-25', 'Laki-Laki', '0881024397', 'Kp.Babakan No. 97', 'Islam', 2, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:26', NULL, NULL, NULL),
(98, 1, 'P2022198', 'AprilYandi Dwi W98', '5641997498', '327602230401001098', 'Jakarta', '2001-03-25', 'Laki-Laki', '0881024398', 'Kp.Babakan No. 98', 'Islam', 6, 8, '150000.00', 2, 'Ya', '2022-12-11 06:45:26', NULL, NULL, NULL),
(99, 3, 'P2022399', 'AprilYandi Dwi W99', '5641997499', '327602230401001099', 'Jakarta', '2001-04-20', 'Laki-Laki', '0881024399', 'Kp.Babakan No. 99', 'Islam', 1, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:27', NULL, NULL, NULL),
(100, 3, 'P20223100', 'AprilYandi Dwi W100', '56419974100', '3276022304010010100', 'Semarang', '2001-03-30', 'Perempuan', '08810243100', 'Kp.Babakan No. 100', 'Islam', 9, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:27', NULL, NULL, NULL),
(101, 1, 'P20221101', 'AprilYandi Dwi W101', '56419974101', '3276022304010010101', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243101', 'Kp.Babakan No. 101', 'Islam', 13, 4, '150000.00', 3, 'Ya', '2022-12-11 06:45:27', NULL, NULL, NULL),
(102, 1, 'P20221102', 'AprilYandi Dwi W102', '56419974102', '3276022304010010102', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243102', 'Kp.Babakan No. 102', 'Islam', 8, 1, '150000.00', 1, 'Ya', '2022-12-11 06:45:27', NULL, NULL, NULL),
(103, 1, 'P20221103', 'AprilYandi Dwi W103', '56419974103', '3276022304010010103', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243103', 'Kp.Babakan No. 103', 'Islam', 6, 11, '150000.00', 4, 'Ya', '2022-12-11 06:45:27', NULL, NULL, NULL),
(104, 3, 'P20223104', 'AprilYandi Dwi W104', '56419974104', '3276022304010010104', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243104', 'Kp.Babakan No. 104', 'Islam', 5, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:27', NULL, NULL, NULL),
(105, 3, 'P20223105', 'AprilYandi Dwi W105', '56419974105', '3276022304010010105', 'Semarang', '2001-04-17', 'Perempuan', '08810243105', 'Kp.Babakan No. 105', 'Islam', 7, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:27', NULL, NULL, NULL),
(106, 3, 'P20223106', 'AprilYandi Dwi W106', '56419974106', '3276022304010010106', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243106', 'Kp.Babakan No. 106', 'Islam', 12, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:27', NULL, NULL, NULL),
(107, 1, 'P20221107', 'AprilYandi Dwi W107', '56419974107', '3276022304010010107', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243107', 'Kp.Babakan No. 107', 'Islam', 3, 1, '150000.00', 2, 'Ya', '2022-12-11 06:45:27', NULL, NULL, NULL),
(108, 2, 'P20222108', 'AprilYandi Dwi W108', '56419974108', '3276022304010010108', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243108', 'Kp.Babakan No. 108', 'Islam', 5, 8, '150000.00', 4, 'Ya', '2022-12-11 06:45:27', NULL, NULL, NULL),
(109, 3, 'P20223109', 'AprilYandi Dwi W109', '56419974109', '3276022304010010109', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243109', 'Kp.Babakan No. 109', 'Islam', 13, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:27', NULL, NULL, NULL),
(110, 1, 'P20221110', 'AprilYandi Dwi W110', '56419974110', '3276022304010010110', 'Semarang', '2001-04-23', 'Perempuan', '08810243110', 'Kp.Babakan No. 110', 'Islam', 12, 9, '150000.00', 2, 'Ya', '2022-12-11 06:45:27', NULL, NULL, NULL),
(111, 3, 'P20223111', 'AprilYandi Dwi W111', '56419974111', '3276022304010010111', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243111', 'Kp.Babakan No. 111', 'Islam', 8, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:28', NULL, NULL, NULL),
(112, 2, 'P20222112', 'AprilYandi Dwi W112', '56419974112', '3276022304010010112', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243112', 'Kp.Babakan No. 112', 'Islam', 1, 10, '150000.00', 4, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(113, 3, 'P20223113', 'AprilYandi Dwi W113', '56419974113', '3276022304010010113', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243113', 'Kp.Babakan No. 113', 'Islam', 6, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:28', NULL, NULL, NULL),
(114, 3, 'P20223114', 'AprilYandi Dwi W114', '56419974114', '3276022304010010114', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243114', 'Kp.Babakan No. 114', 'Islam', 9, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:28', NULL, NULL, NULL),
(115, 1, 'P20221115', 'AprilYandi Dwi W115', '56419974115', '3276022304010010115', 'Semarang', '2001-04-22', 'Perempuan', '08810243115', 'Kp.Babakan No. 115', 'Islam', 7, 7, '150000.00', 2, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(116, 2, 'P20222116', 'AprilYandi Dwi W116', '56419974116', '3276022304010010116', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243116', 'Kp.Babakan No. 116', 'Islam', 6, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(117, 3, 'P20223117', 'AprilYandi Dwi W117', '56419974117', '3276022304010010117', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243117', 'Kp.Babakan No. 117', 'Islam', 8, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:28', NULL, NULL, NULL),
(118, 3, 'P20223118', 'AprilYandi Dwi W118', '56419974118', '3276022304010010118', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243118', 'Kp.Babakan No. 118', 'Islam', 8, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:28', NULL, NULL, NULL),
(119, 2, 'P20222119', 'AprilYandi Dwi W119', '56419974119', '3276022304010010119', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243119', 'Kp.Babakan No. 119', 'Islam', 1, 5, '150000.00', 3, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(120, 2, 'P20222120', 'AprilYandi Dwi W120', '56419974120', '3276022304010010120', 'Semarang', '2001-04-23', 'Perempuan', '08810243120', 'Kp.Babakan No. 120', 'Islam', 10, 13, '150000.00', 2, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(121, 2, 'P20222121', 'AprilYandi Dwi W121', '56419974121', '3276022304010010121', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243121', 'Kp.Babakan No. 121', 'Islam', 10, 12, '150000.00', 4, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(122, 3, 'P20223122', 'AprilYandi Dwi W122', '56419974122', '3276022304010010122', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243122', 'Kp.Babakan No. 122', 'Islam', 5, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:28', NULL, NULL, NULL),
(123, 1, 'P20221123', 'AprilYandi Dwi W123', '56419974123', '3276022304010010123', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243123', 'Kp.Babakan No. 123', 'Islam', 3, 1, '150000.00', 4, 'Ya', '2022-12-11 06:45:28', NULL, NULL, NULL),
(124, 2, 'P20222124', 'AprilYandi Dwi W124', '56419974124', '3276022304010010124', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243124', 'Kp.Babakan No. 124', 'Islam', 12, 10, '150000.00', 4, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(125, 3, 'P20223125', 'AprilYandi Dwi W125', '56419974125', '3276022304010010125', 'Semarang', '2001-04-13', 'Perempuan', '08810243125', 'Kp.Babakan No. 125', 'Islam', 11, 4, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(126, 2, 'P20222126', 'AprilYandi Dwi W126', '56419974126', '3276022304010010126', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243126', 'Kp.Babakan No. 126', 'Islam', 6, 6, '150000.00', 3, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(127, 3, 'P20223127', 'AprilYandi Dwi W127', '56419974127', '3276022304010010127', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243127', 'Kp.Babakan No. 127', 'Islam', 6, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(128, 3, 'P20223128', 'AprilYandi Dwi W128', '56419974128', '3276022304010010128', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243128', 'Kp.Babakan No. 128', 'Islam', 13, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(129, 3, 'P20223129', 'AprilYandi Dwi W129', '56419974129', '3276022304010010129', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243129', 'Kp.Babakan No. 129', 'Islam', 9, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(130, 2, 'P20222130', 'AprilYandi Dwi W130', '56419974130', '3276022304010010130', 'Semarang', '2001-04-16', 'Perempuan', '08810243130', 'Kp.Babakan No. 130', 'Islam', 4, 1, '150000.00', 1, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(131, 1, 'P20221131', 'AprilYandi Dwi W131', '56419974131', '3276022304010010131', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243131', 'Kp.Babakan No. 131', 'Islam', 13, 13, '150000.00', 1, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(132, 1, 'P20221132', 'AprilYandi Dwi W132', '56419974132', '3276022304010010132', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243132', 'Kp.Babakan No. 132', 'Islam', 1, 6, '150000.00', 4, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(133, 3, 'P20223133', 'AprilYandi Dwi W133', '56419974133', '3276022304010010133', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243133', 'Kp.Babakan No. 133', 'Islam', 4, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(134, 1, 'P20221134', 'AprilYandi Dwi W134', '56419974134', '3276022304010010134', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243134', 'Kp.Babakan No. 134', 'Islam', 3, 12, '150000.00', 2, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(135, 3, 'P20223135', 'AprilYandi Dwi W135', '56419974135', '3276022304010010135', 'Semarang', '2001-04-02', 'Perempuan', '08810243135', 'Kp.Babakan No. 135', 'Islam', 12, 4, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(136, 2, 'P20222136', 'AprilYandi Dwi W136', '56419974136', '3276022304010010136', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243136', 'Kp.Babakan No. 136', 'Islam', 6, 13, '150000.00', 4, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(137, 3, 'P20223137', 'AprilYandi Dwi W137', '56419974137', '3276022304010010137', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243137', 'Kp.Babakan No. 137', 'Islam', 2, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(138, 3, 'P20223138', 'AprilYandi Dwi W138', '56419974138', '3276022304010010138', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243138', 'Kp.Babakan No. 138', 'Islam', 10, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(139, 1, 'P20221139', 'AprilYandi Dwi W139', '56419974139', '3276022304010010139', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243139', 'Kp.Babakan No. 139', 'Islam', 9, 4, '150000.00', 4, 'Ya', '2022-12-11 06:45:29', NULL, NULL, NULL),
(140, 3, 'P20223140', 'AprilYandi Dwi W140', '56419974140', '3276022304010010140', 'Semarang', '2001-04-09', 'Perempuan', '08810243140', 'Kp.Babakan No. 140', 'Islam', 1, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:29', NULL, NULL, NULL),
(141, 3, 'P20223141', 'AprilYandi Dwi W141', '56419974141', '3276022304010010141', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243141', 'Kp.Babakan No. 141', 'Islam', 12, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:30', NULL, NULL, NULL),
(142, 3, 'P20223142', 'AprilYandi Dwi W142', '56419974142', '3276022304010010142', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243142', 'Kp.Babakan No. 142', 'Islam', 12, 4, NULL, NULL, 'Tidak', '2022-12-11 06:45:30', NULL, NULL, NULL),
(143, 3, 'P20223143', 'AprilYandi Dwi W143', '56419974143', '3276022304010010143', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243143', 'Kp.Babakan No. 143', 'Islam', 3, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:30', NULL, NULL, NULL),
(144, 3, 'P20223144', 'AprilYandi Dwi W144', '56419974144', '3276022304010010144', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243144', 'Kp.Babakan No. 144', 'Islam', 10, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:30', NULL, NULL, NULL),
(145, 2, 'P20222145', 'AprilYandi Dwi W145', '56419974145', '3276022304010010145', 'Semarang', '2001-03-27', 'Perempuan', '08810243145', 'Kp.Babakan No. 145', 'Islam', 9, 12, '150000.00', 1, 'Ya', '2022-12-11 06:45:31', NULL, NULL, NULL),
(146, 3, 'P20223146', 'AprilYandi Dwi W146', '56419974146', '3276022304010010146', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243146', 'Kp.Babakan No. 146', 'Islam', 10, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:31', NULL, NULL, NULL),
(147, 3, 'P20223147', 'AprilYandi Dwi W147', '56419974147', '3276022304010010147', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243147', 'Kp.Babakan No. 147', 'Islam', 9, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:31', NULL, NULL, NULL),
(148, 1, 'P20221148', 'AprilYandi Dwi W148', '56419974148', '3276022304010010148', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243148', 'Kp.Babakan No. 148', 'Islam', 12, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:31', NULL, NULL, NULL),
(149, 1, 'P20221149', 'AprilYandi Dwi W149', '56419974149', '3276022304010010149', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243149', 'Kp.Babakan No. 149', 'Islam', 4, 7, '150000.00', 4, 'Ya', '2022-12-11 06:45:31', NULL, NULL, NULL),
(150, 1, 'P20221150', 'AprilYandi Dwi W150', '56419974150', '3276022304010010150', 'Semarang', '2001-03-25', 'Perempuan', '08810243150', 'Kp.Babakan No. 150', 'Islam', 4, 9, '150000.00', 2, 'Ya', '2022-12-11 06:45:31', NULL, NULL, NULL),
(151, 1, 'P20221151', 'AprilYandi Dwi W151', '56419974151', '3276022304010010151', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243151', 'Kp.Babakan No. 151', 'Islam', 7, 11, '150000.00', 3, 'Ya', '2022-12-11 06:45:31', NULL, NULL, NULL),
(152, 3, 'P20223152', 'AprilYandi Dwi W152', '56419974152', '3276022304010010152', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243152', 'Kp.Babakan No. 152', 'Islam', 11, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:31', NULL, NULL, NULL),
(153, 3, 'P20223153', 'AprilYandi Dwi W153', '56419974153', '3276022304010010153', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243153', 'Kp.Babakan No. 153', 'Islam', 1, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:31', NULL, NULL, NULL),
(154, 1, 'P20221154', 'AprilYandi Dwi W154', '56419974154', '3276022304010010154', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243154', 'Kp.Babakan No. 154', 'Islam', 6, 7, '150000.00', 1, 'Ya', '2022-12-11 06:45:32', NULL, NULL, NULL),
(155, 3, 'P20223155', 'AprilYandi Dwi W155', '56419974155', '3276022304010010155', 'Semarang', '2001-04-08', 'Perempuan', '08810243155', 'Kp.Babakan No. 155', 'Islam', 11, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:32', NULL, NULL, NULL),
(156, 1, 'P20221156', 'AprilYandi Dwi W156', '56419974156', '3276022304010010156', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243156', 'Kp.Babakan No. 156', 'Islam', 1, 8, '150000.00', 4, 'Ya', '2022-12-11 06:45:32', NULL, NULL, NULL),
(157, 2, 'P20222157', 'AprilYandi Dwi W157', '56419974157', '3276022304010010157', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243157', 'Kp.Babakan No. 157', 'Islam', 8, 6, '150000.00', 1, 'Ya', '2022-12-11 06:45:32', NULL, NULL, NULL),
(158, 2, 'P20222158', 'AprilYandi Dwi W158', '56419974158', '3276022304010010158', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243158', 'Kp.Babakan No. 158', 'Islam', 13, 4, '150000.00', 3, 'Ya', '2022-12-11 06:45:33', NULL, NULL, NULL),
(159, 3, 'P20223159', 'AprilYandi Dwi W159', '56419974159', '3276022304010010159', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243159', 'Kp.Babakan No. 159', 'Islam', 5, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:33', NULL, NULL, NULL),
(160, 3, 'P20223160', 'AprilYandi Dwi W160', '56419974160', '3276022304010010160', 'Semarang', '2001-04-02', 'Perempuan', '08810243160', 'Kp.Babakan No. 160', 'Islam', 3, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:33', NULL, NULL, NULL),
(161, 3, 'P20223161', 'AprilYandi Dwi W161', '56419974161', '3276022304010010161', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243161', 'Kp.Babakan No. 161', 'Islam', 3, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:34', NULL, NULL, NULL),
(162, 3, 'P20223162', 'AprilYandi Dwi W162', '56419974162', '3276022304010010162', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243162', 'Kp.Babakan No. 162', 'Islam', 13, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:34', NULL, NULL, NULL),
(163, 2, 'P20222163', 'AprilYandi Dwi W163', '56419974163', '3276022304010010163', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243163', 'Kp.Babakan No. 163', 'Islam', 3, 9, '150000.00', 3, 'Ya', '2022-12-11 06:45:34', NULL, NULL, NULL),
(164, 2, 'P20222164', 'AprilYandi Dwi W164', '56419974164', '3276022304010010164', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243164', 'Kp.Babakan No. 164', 'Islam', 7, 5, '150000.00', 4, 'Ya', '2022-12-11 06:45:34', NULL, NULL, NULL),
(165, 2, 'P20222165', 'AprilYandi Dwi W165', '56419974165', '3276022304010010165', 'Semarang', '2001-03-30', 'Perempuan', '08810243165', 'Kp.Babakan No. 165', 'Islam', 7, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:34', NULL, NULL, NULL),
(166, 1, 'P20221166', 'AprilYandi Dwi W166', '56419974166', '3276022304010010166', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243166', 'Kp.Babakan No. 166', 'Islam', 8, 1, '150000.00', 4, 'Ya', '2022-12-11 06:45:34', NULL, NULL, NULL),
(167, 3, 'P20223167', 'AprilYandi Dwi W167', '56419974167', '3276022304010010167', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243167', 'Kp.Babakan No. 167', 'Islam', 2, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:34', NULL, NULL, NULL),
(168, 3, 'P20223168', 'AprilYandi Dwi W168', '56419974168', '3276022304010010168', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243168', 'Kp.Babakan No. 168', 'Islam', 10, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:34', NULL, NULL, NULL),
(169, 2, 'P20222169', 'AprilYandi Dwi W169', '56419974169', '3276022304010010169', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243169', 'Kp.Babakan No. 169', 'Islam', 7, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:35', NULL, NULL, NULL),
(170, 1, 'P20221170', 'AprilYandi Dwi W170', '56419974170', '3276022304010010170', 'Semarang', '2001-04-02', 'Perempuan', '08810243170', 'Kp.Babakan No. 170', 'Islam', 9, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:35', NULL, NULL, NULL),
(171, 3, 'P20223171', 'AprilYandi Dwi W171', '56419974171', '3276022304010010171', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243171', 'Kp.Babakan No. 171', 'Islam', 7, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:35', NULL, NULL, NULL),
(172, 3, 'P20223172', 'AprilYandi Dwi W172', '56419974172', '3276022304010010172', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243172', 'Kp.Babakan No. 172', 'Islam', 7, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:35', NULL, NULL, NULL),
(173, 3, 'P20223173', 'AprilYandi Dwi W173', '56419974173', '3276022304010010173', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243173', 'Kp.Babakan No. 173', 'Islam', 1, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:35', NULL, NULL, NULL),
(174, 1, 'P20221174', 'AprilYandi Dwi W174', '56419974174', '3276022304010010174', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243174', 'Kp.Babakan No. 174', 'Islam', 10, 3, '150000.00', 4, 'Ya', '2022-12-11 06:45:35', NULL, NULL, NULL),
(175, 2, 'P20222175', 'AprilYandi Dwi W175', '56419974175', '3276022304010010175', 'Semarang', '2001-04-07', 'Perempuan', '08810243175', 'Kp.Babakan No. 175', 'Islam', 10, 8, '150000.00', 2, 'Ya', '2022-12-11 06:45:35', NULL, NULL, NULL),
(176, 1, 'P20221176', 'AprilYandi Dwi W176', '56419974176', '3276022304010010176', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243176', 'Kp.Babakan No. 176', 'Islam', 1, 11, '150000.00', 4, 'Ya', '2022-12-11 06:45:35', NULL, NULL, NULL),
(177, 1, 'P20221177', 'AprilYandi Dwi W177', '56419974177', '3276022304010010177', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243177', 'Kp.Babakan No. 177', 'Islam', 12, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:36', NULL, NULL, NULL),
(178, 3, 'P20223178', 'AprilYandi Dwi W178', '56419974178', '3276022304010010178', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243178', 'Kp.Babakan No. 178', 'Islam', 10, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:36', NULL, NULL, NULL),
(179, 2, 'P20222179', 'AprilYandi Dwi W179', '56419974179', '3276022304010010179', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243179', 'Kp.Babakan No. 179', 'Islam', 6, 13, '150000.00', 1, 'Ya', '2022-12-11 06:45:36', NULL, NULL, NULL),
(180, 3, 'P20223180', 'AprilYandi Dwi W180', '56419974180', '3276022304010010180', 'Semarang', '2001-04-16', 'Perempuan', '08810243180', 'Kp.Babakan No. 180', 'Islam', 7, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:36', NULL, NULL, NULL),
(181, 3, 'P20223181', 'AprilYandi Dwi W181', '56419974181', '3276022304010010181', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243181', 'Kp.Babakan No. 181', 'Islam', 8, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:36', NULL, NULL, NULL),
(182, 3, 'P20223182', 'AprilYandi Dwi W182', '56419974182', '3276022304010010182', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243182', 'Kp.Babakan No. 182', 'Islam', 9, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:36', NULL, NULL, NULL),
(183, 3, 'P20223183', 'AprilYandi Dwi W183', '56419974183', '3276022304010010183', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243183', 'Kp.Babakan No. 183', 'Islam', 3, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:36', NULL, NULL, NULL),
(184, 2, 'P20222184', 'AprilYandi Dwi W184', '56419974184', '3276022304010010184', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243184', 'Kp.Babakan No. 184', 'Islam', 1, 10, '150000.00', 2, 'Ya', '2022-12-11 06:45:36', NULL, NULL, NULL),
(185, 2, 'P20222185', 'AprilYandi Dwi W185', '56419974185', '3276022304010010185', 'Semarang', '2001-04-07', 'Perempuan', '08810243185', 'Kp.Babakan No. 185', 'Islam', 8, 2, '150000.00', 2, 'Ya', '2022-12-11 06:45:37', NULL, NULL, NULL),
(186, 1, 'P20221186', 'AprilYandi Dwi W186', '56419974186', '3276022304010010186', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243186', 'Kp.Babakan No. 186', 'Islam', 9, 1, '150000.00', 3, 'Ya', '2022-12-11 06:45:37', NULL, NULL, NULL),
(187, 1, 'P20221187', 'AprilYandi Dwi W187', '56419974187', '3276022304010010187', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243187', 'Kp.Babakan No. 187', 'Islam', 12, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:37', NULL, NULL, NULL),
(188, 1, 'P20221188', 'AprilYandi Dwi W188', '56419974188', '3276022304010010188', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243188', 'Kp.Babakan No. 188', 'Islam', 9, 10, '150000.00', 2, 'Ya', '2022-12-11 06:45:38', NULL, NULL, NULL),
(189, 2, 'P20222189', 'AprilYandi Dwi W189', '56419974189', '3276022304010010189', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243189', 'Kp.Babakan No. 189', 'Islam', 5, 5, '150000.00', 2, 'Ya', '2022-12-11 06:45:38', NULL, NULL, NULL),
(190, 2, 'P20222190', 'AprilYandi Dwi W190', '56419974190', '3276022304010010190', 'Semarang', '2001-04-14', 'Perempuan', '08810243190', 'Kp.Babakan No. 190', 'Islam', 6, 6, '150000.00', 1, 'Ya', '2022-12-11 06:45:38', NULL, NULL, NULL),
(191, 2, 'P20222191', 'AprilYandi Dwi W191', '56419974191', '3276022304010010191', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243191', 'Kp.Babakan No. 191', 'Islam', 5, 7, '150000.00', 2, 'Ya', '2022-12-11 06:45:38', NULL, NULL, NULL),
(192, 1, 'P20221192', 'AprilYandi Dwi W192', '56419974192', '3276022304010010192', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243192', 'Kp.Babakan No. 192', 'Islam', 8, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:39', NULL, NULL, NULL),
(193, 1, 'P20221193', 'AprilYandi Dwi W193', '56419974193', '3276022304010010193', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243193', 'Kp.Babakan No. 193', 'Islam', 8, 10, '150000.00', 1, 'Ya', '2022-12-11 06:45:39', NULL, NULL, NULL),
(194, 3, 'P20223194', 'AprilYandi Dwi W194', '56419974194', '3276022304010010194', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243194', 'Kp.Babakan No. 194', 'Islam', 8, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:39', NULL, NULL, NULL),
(195, 3, 'P20223195', 'AprilYandi Dwi W195', '56419974195', '3276022304010010195', 'Semarang', '2001-04-06', 'Perempuan', '08810243195', 'Kp.Babakan No. 195', 'Islam', 7, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:39', NULL, NULL, NULL),
(196, 1, 'P20221196', 'AprilYandi Dwi W196', '56419974196', '3276022304010010196', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243196', 'Kp.Babakan No. 196', 'Islam', 1, 3, '150000.00', 1, 'Ya', '2022-12-11 06:45:39', NULL, NULL, NULL),
(197, 2, 'P20222197', 'AprilYandi Dwi W197', '56419974197', '3276022304010010197', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243197', 'Kp.Babakan No. 197', 'Islam', 12, 8, '150000.00', 3, 'Ya', '2022-12-11 06:45:40', NULL, NULL, NULL),
(198, 2, 'P20222198', 'AprilYandi Dwi W198', '56419974198', '3276022304010010198', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243198', 'Kp.Babakan No. 198', 'Islam', 5, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:40', NULL, NULL, NULL),
(199, 2, 'P20222199', 'AprilYandi Dwi W199', '56419974199', '3276022304010010199', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243199', 'Kp.Babakan No. 199', 'Islam', 9, 7, '150000.00', 2, 'Ya', '2022-12-11 06:45:41', NULL, NULL, NULL),
(200, 3, 'P20223200', 'AprilYandi Dwi W200', '56419974200', '3276022304010010200', 'Semarang', '2001-04-16', 'Perempuan', '08810243200', 'Kp.Babakan No. 200', 'Islam', 6, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:41', NULL, NULL, NULL),
(201, 2, 'P20222201', 'AprilYandi Dwi W201', '56419974201', '3276022304010010201', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243201', 'Kp.Babakan No. 201', 'Islam', 1, 7, '150000.00', 1, 'Ya', '2022-12-11 06:45:41', NULL, NULL, NULL),
(202, 2, 'P20222202', 'AprilYandi Dwi W202', '56419974202', '3276022304010010202', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243202', 'Kp.Babakan No. 202', 'Islam', 13, 7, '150000.00', 3, 'Ya', '2022-12-11 06:45:41', NULL, NULL, NULL),
(203, 3, 'P20223203', 'AprilYandi Dwi W203', '56419974203', '3276022304010010203', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243203', 'Kp.Babakan No. 203', 'Islam', 4, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:41', NULL, NULL, NULL),
(204, 2, 'P20222204', 'AprilYandi Dwi W204', '56419974204', '3276022304010010204', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243204', 'Kp.Babakan No. 204', 'Islam', 8, 11, '150000.00', 3, 'Ya', '2022-12-11 06:45:42', NULL, NULL, NULL),
(205, 3, 'P20223205', 'AprilYandi Dwi W205', '56419974205', '3276022304010010205', 'Semarang', '2001-04-17', 'Perempuan', '08810243205', 'Kp.Babakan No. 205', 'Islam', 2, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:42', NULL, NULL, NULL),
(206, 1, 'P20221206', 'AprilYandi Dwi W206', '56419974206', '3276022304010010206', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243206', 'Kp.Babakan No. 206', 'Islam', 10, 2, '150000.00', 2, 'Ya', '2022-12-11 06:45:43', NULL, NULL, NULL),
(207, 2, 'P20222207', 'AprilYandi Dwi W207', '56419974207', '3276022304010010207', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243207', 'Kp.Babakan No. 207', 'Islam', 13, 10, '150000.00', 2, 'Ya', '2022-12-11 06:45:43', NULL, NULL, NULL),
(208, 3, 'P20223208', 'AprilYandi Dwi W208', '56419974208', '3276022304010010208', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243208', 'Kp.Babakan No. 208', 'Islam', 7, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:43', NULL, NULL, NULL),
(209, 3, 'P20223209', 'AprilYandi Dwi W209', '56419974209', '3276022304010010209', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243209', 'Kp.Babakan No. 209', 'Islam', 3, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:44', NULL, NULL, NULL),
(210, 3, 'P20223210', 'AprilYandi Dwi W210', '56419974210', '3276022304010010210', 'Semarang', '2001-04-14', 'Perempuan', '08810243210', 'Kp.Babakan No. 210', 'Islam', 3, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:44', NULL, NULL, NULL),
(211, 3, 'P20223211', 'AprilYandi Dwi W211', '56419974211', '3276022304010010211', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243211', 'Kp.Babakan No. 211', 'Islam', 6, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:45', NULL, NULL, NULL),
(212, 2, 'P20222212', 'AprilYandi Dwi W212', '56419974212', '3276022304010010212', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243212', 'Kp.Babakan No. 212', 'Islam', 3, 2, '150000.00', 4, 'Ya', '2022-12-11 06:45:45', NULL, NULL, NULL),
(213, 3, 'P20223213', 'AprilYandi Dwi W213', '56419974213', '3276022304010010213', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243213', 'Kp.Babakan No. 213', 'Islam', 12, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:46', NULL, NULL, NULL),
(214, 3, 'P20223214', 'AprilYandi Dwi W214', '56419974214', '3276022304010010214', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243214', 'Kp.Babakan No. 214', 'Islam', 3, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:46', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(215, 2, 'P20222215', 'AprilYandi Dwi W215', '56419974215', '3276022304010010215', 'Semarang', '2001-04-01', 'Perempuan', '08810243215', 'Kp.Babakan No. 215', 'Islam', 12, 6, '150000.00', 1, 'Ya', '2022-12-11 06:45:46', NULL, NULL, NULL),
(216, 3, 'P20223216', 'AprilYandi Dwi W216', '56419974216', '3276022304010010216', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243216', 'Kp.Babakan No. 216', 'Islam', 8, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:46', NULL, NULL, NULL),
(217, 1, 'P20221217', 'AprilYandi Dwi W217', '56419974217', '3276022304010010217', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243217', 'Kp.Babakan No. 217', 'Islam', 7, 4, '150000.00', 3, 'Ya', '2022-12-11 06:45:46', NULL, NULL, NULL),
(218, 2, 'P20222218', 'AprilYandi Dwi W218', '56419974218', '3276022304010010218', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243218', 'Kp.Babakan No. 218', 'Islam', 13, 11, '150000.00', 3, 'Ya', '2022-12-11 06:45:47', NULL, NULL, NULL),
(219, 3, 'P20223219', 'AprilYandi Dwi W219', '56419974219', '3276022304010010219', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243219', 'Kp.Babakan No. 219', 'Islam', 4, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:47', NULL, NULL, NULL),
(220, 3, 'P20223220', 'AprilYandi Dwi W220', '56419974220', '3276022304010010220', 'Semarang', '2001-04-06', 'Perempuan', '08810243220', 'Kp.Babakan No. 220', 'Islam', 10, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:47', NULL, NULL, NULL),
(221, 2, 'P20222221', 'AprilYandi Dwi W221', '56419974221', '3276022304010010221', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243221', 'Kp.Babakan No. 221', 'Islam', 8, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:47', NULL, NULL, NULL),
(222, 3, 'P20223222', 'AprilYandi Dwi W222', '56419974222', '3276022304010010222', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243222', 'Kp.Babakan No. 222', 'Islam', 7, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:47', NULL, NULL, NULL),
(223, 1, 'P20221223', 'AprilYandi Dwi W223', '56419974223', '3276022304010010223', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243223', 'Kp.Babakan No. 223', 'Islam', 8, 5, '150000.00', 2, 'Ya', '2022-12-11 06:45:47', NULL, NULL, NULL),
(224, 1, 'P20221224', 'AprilYandi Dwi W224', '56419974224', '3276022304010010224', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243224', 'Kp.Babakan No. 224', 'Islam', 12, 1, '150000.00', 2, 'Ya', '2022-12-11 06:45:48', NULL, NULL, NULL),
(225, 3, 'P20223225', 'AprilYandi Dwi W225', '56419974225', '3276022304010010225', 'Semarang', '2001-04-09', 'Perempuan', '08810243225', 'Kp.Babakan No. 225', 'Islam', 2, 4, NULL, NULL, 'Tidak', '2022-12-11 06:45:48', NULL, NULL, NULL),
(226, 3, 'P20223226', 'AprilYandi Dwi W226', '56419974226', '3276022304010010226', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243226', 'Kp.Babakan No. 226', 'Islam', 6, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:48', NULL, NULL, NULL),
(227, 1, 'P20221227', 'AprilYandi Dwi W227', '56419974227', '3276022304010010227', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243227', 'Kp.Babakan No. 227', 'Islam', 6, 13, '150000.00', 4, 'Ya', '2022-12-11 06:45:48', NULL, NULL, NULL),
(228, 2, 'P20222228', 'AprilYandi Dwi W228', '56419974228', '3276022304010010228', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243228', 'Kp.Babakan No. 228', 'Islam', 1, 11, '150000.00', 1, 'Ya', '2022-12-11 06:45:48', NULL, NULL, NULL),
(229, 1, 'P20221229', 'AprilYandi Dwi W229', '56419974229', '3276022304010010229', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243229', 'Kp.Babakan No. 229', 'Islam', 4, 5, '150000.00', 1, 'Ya', '2022-12-11 06:45:49', NULL, NULL, NULL),
(230, 1, 'P20221230', 'AprilYandi Dwi W230', '56419974230', '3276022304010010230', 'Semarang', '2001-04-19', 'Perempuan', '08810243230', 'Kp.Babakan No. 230', 'Islam', 3, 6, '150000.00', 1, 'Ya', '2022-12-11 06:45:49', NULL, NULL, NULL),
(231, 2, 'P20222231', 'AprilYandi Dwi W231', '56419974231', '3276022304010010231', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243231', 'Kp.Babakan No. 231', 'Islam', 5, 9, '150000.00', 2, 'Ya', '2022-12-11 06:45:49', NULL, NULL, NULL),
(232, 2, 'P20222232', 'AprilYandi Dwi W232', '56419974232', '3276022304010010232', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243232', 'Kp.Babakan No. 232', 'Islam', 12, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:49', NULL, NULL, NULL),
(233, 3, 'P20223233', 'AprilYandi Dwi W233', '56419974233', '3276022304010010233', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243233', 'Kp.Babakan No. 233', 'Islam', 1, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:49', NULL, NULL, NULL),
(234, 2, 'P20222234', 'AprilYandi Dwi W234', '56419974234', '3276022304010010234', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243234', 'Kp.Babakan No. 234', 'Islam', 2, 8, '150000.00', 2, 'Ya', '2022-12-11 06:45:50', NULL, NULL, NULL),
(235, 1, 'P20221235', 'AprilYandi Dwi W235', '56419974235', '3276022304010010235', 'Semarang', '2001-04-18', 'Perempuan', '08810243235', 'Kp.Babakan No. 235', 'Islam', 13, 12, '150000.00', 3, 'Ya', '2022-12-11 06:45:50', NULL, NULL, NULL),
(236, 3, 'P20223236', 'AprilYandi Dwi W236', '56419974236', '3276022304010010236', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243236', 'Kp.Babakan No. 236', 'Islam', 5, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:50', NULL, NULL, NULL),
(237, 1, 'P20221237', 'AprilYandi Dwi W237', '56419974237', '3276022304010010237', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243237', 'Kp.Babakan No. 237', 'Islam', 3, 6, '150000.00', 4, 'Ya', '2022-12-11 06:45:50', NULL, NULL, NULL),
(238, 1, 'P20221238', 'AprilYandi Dwi W238', '56419974238', '3276022304010010238', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243238', 'Kp.Babakan No. 238', 'Islam', 5, 6, '150000.00', 1, 'Ya', '2022-12-11 06:45:50', NULL, NULL, NULL),
(239, 2, 'P20222239', 'AprilYandi Dwi W239', '56419974239', '3276022304010010239', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243239', 'Kp.Babakan No. 239', 'Islam', 2, 4, '150000.00', 3, 'Ya', '2022-12-11 06:45:50', NULL, NULL, NULL),
(240, 2, 'P20222240', 'AprilYandi Dwi W240', '56419974240', '3276022304010010240', 'Semarang', '2001-04-17', 'Perempuan', '08810243240', 'Kp.Babakan No. 240', 'Islam', 11, 8, '150000.00', 1, 'Ya', '2022-12-11 06:45:50', NULL, NULL, NULL),
(241, 3, 'P20223241', 'AprilYandi Dwi W241', '56419974241', '3276022304010010241', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243241', 'Kp.Babakan No. 241', 'Islam', 4, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:51', NULL, NULL, NULL),
(242, 2, 'P20222242', 'AprilYandi Dwi W242', '56419974242', '3276022304010010242', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243242', 'Kp.Babakan No. 242', 'Islam', 9, 2, '150000.00', 4, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(243, 1, 'P20221243', 'AprilYandi Dwi W243', '56419974243', '3276022304010010243', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243243', 'Kp.Babakan No. 243', 'Islam', 4, 12, '150000.00', 4, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(244, 2, 'P20222244', 'AprilYandi Dwi W244', '56419974244', '3276022304010010244', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243244', 'Kp.Babakan No. 244', 'Islam', 4, 11, '150000.00', 3, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(245, 1, 'P20221245', 'AprilYandi Dwi W245', '56419974245', '3276022304010010245', 'Semarang', '2001-04-12', 'Perempuan', '08810243245', 'Kp.Babakan No. 245', 'Islam', 8, 10, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(246, 1, 'P20221246', 'AprilYandi Dwi W246', '56419974246', '3276022304010010246', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243246', 'Kp.Babakan No. 246', 'Islam', 8, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(247, 3, 'P20223247', 'AprilYandi Dwi W247', '56419974247', '3276022304010010247', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243247', 'Kp.Babakan No. 247', 'Islam', 4, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:51', NULL, NULL, NULL),
(248, 1, 'P20221248', 'AprilYandi Dwi W248', '56419974248', '3276022304010010248', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243248', 'Kp.Babakan No. 248', 'Islam', 12, 8, '150000.00', 4, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(249, 2, 'P20222249', 'AprilYandi Dwi W249', '56419974249', '3276022304010010249', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243249', 'Kp.Babakan No. 249', 'Islam', 9, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(250, 2, 'P20222250', 'AprilYandi Dwi W250', '56419974250', '3276022304010010250', 'Semarang', '2001-04-11', 'Perempuan', '08810243250', 'Kp.Babakan No. 250', 'Islam', 2, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(251, 2, 'P20222251', 'AprilYandi Dwi W251', '56419974251', '3276022304010010251', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243251', 'Kp.Babakan No. 251', 'Islam', 6, 11, '150000.00', 4, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(252, 2, 'P20222252', 'AprilYandi Dwi W252', '56419974252', '3276022304010010252', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243252', 'Kp.Babakan No. 252', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(253, 1, 'P20221253', 'AprilYandi Dwi W253', '56419974253', '3276022304010010253', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243253', 'Kp.Babakan No. 253', 'Islam', 5, 3, '150000.00', 1, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(254, 1, 'P20221254', 'AprilYandi Dwi W254', '56419974254', '3276022304010010254', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243254', 'Kp.Babakan No. 254', 'Islam', 4, 10, '150000.00', 1, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(255, 2, 'P20222255', 'AprilYandi Dwi W255', '56419974255', '3276022304010010255', 'Semarang', '2001-04-04', 'Perempuan', '08810243255', 'Kp.Babakan No. 255', 'Islam', 3, 6, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(256, 1, 'P20221256', 'AprilYandi Dwi W256', '56419974256', '3276022304010010256', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243256', 'Kp.Babakan No. 256', 'Islam', 7, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:51', NULL, NULL, NULL),
(257, 3, 'P20223257', 'AprilYandi Dwi W257', '56419974257', '3276022304010010257', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243257', 'Kp.Babakan No. 257', 'Islam', 9, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:51', NULL, NULL, NULL),
(258, 3, 'P20223258', 'AprilYandi Dwi W258', '56419974258', '3276022304010010258', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243258', 'Kp.Babakan No. 258', 'Islam', 12, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:52', NULL, NULL, NULL),
(259, 3, 'P20223259', 'AprilYandi Dwi W259', '56419974259', '3276022304010010259', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243259', 'Kp.Babakan No. 259', 'Islam', 8, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:52', NULL, NULL, NULL),
(260, 2, 'P20222260', 'AprilYandi Dwi W260', '56419974260', '3276022304010010260', 'Semarang', '2001-04-09', 'Perempuan', '08810243260', 'Kp.Babakan No. 260', 'Islam', 7, 6, '150000.00', 3, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(261, 3, 'P20223261', 'AprilYandi Dwi W261', '56419974261', '3276022304010010261', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243261', 'Kp.Babakan No. 261', 'Islam', 4, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:52', NULL, NULL, NULL),
(262, 1, 'P20221262', 'AprilYandi Dwi W262', '56419974262', '3276022304010010262', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243262', 'Kp.Babakan No. 262', 'Islam', 9, 2, '150000.00', 3, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(263, 1, 'P20221263', 'AprilYandi Dwi W263', '56419974263', '3276022304010010263', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243263', 'Kp.Babakan No. 263', 'Islam', 3, 12, '150000.00', 4, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(264, 2, 'P20222264', 'AprilYandi Dwi W264', '56419974264', '3276022304010010264', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243264', 'Kp.Babakan No. 264', 'Islam', 2, 10, '150000.00', 4, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(265, 2, 'P20222265', 'AprilYandi Dwi W265', '56419974265', '3276022304010010265', 'Semarang', '2001-04-20', 'Perempuan', '08810243265', 'Kp.Babakan No. 265', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(266, 1, 'P20221266', 'AprilYandi Dwi W266', '56419974266', '3276022304010010266', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243266', 'Kp.Babakan No. 266', 'Islam', 1, 13, '150000.00', 2, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(267, 1, 'P20221267', 'AprilYandi Dwi W267', '56419974267', '3276022304010010267', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243267', 'Kp.Babakan No. 267', 'Islam', 5, 7, '150000.00', 1, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(268, 1, 'P20221268', 'AprilYandi Dwi W268', '56419974268', '3276022304010010268', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243268', 'Kp.Babakan No. 268', 'Islam', 10, 6, '150000.00', 2, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(269, 1, 'P20221269', 'AprilYandi Dwi W269', '56419974269', '3276022304010010269', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243269', 'Kp.Babakan No. 269', 'Islam', 12, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(270, 2, 'P20222270', 'AprilYandi Dwi W270', '56419974270', '3276022304010010270', 'Semarang', '2001-03-29', 'Perempuan', '08810243270', 'Kp.Babakan No. 270', 'Islam', 7, 10, '150000.00', 1, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(271, 1, 'P20221271', 'AprilYandi Dwi W271', '56419974271', '3276022304010010271', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243271', 'Kp.Babakan No. 271', 'Islam', 2, 8, '150000.00', 4, 'Ya', '2022-12-11 06:45:52', NULL, NULL, NULL),
(272, 1, 'P20221272', 'AprilYandi Dwi W272', '56419974272', '3276022304010010272', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243272', 'Kp.Babakan No. 272', 'Islam', 2, 12, '150000.00', 4, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(273, 3, 'P20223273', 'AprilYandi Dwi W273', '56419974273', '3276022304010010273', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243273', 'Kp.Babakan No. 273', 'Islam', 4, 4, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(274, 3, 'P20223274', 'AprilYandi Dwi W274', '56419974274', '3276022304010010274', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243274', 'Kp.Babakan No. 274', 'Islam', 7, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(275, 2, 'P20222275', 'AprilYandi Dwi W275', '56419974275', '3276022304010010275', 'Semarang', '2001-04-07', 'Perempuan', '08810243275', 'Kp.Babakan No. 275', 'Islam', 7, 8, '150000.00', 3, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(276, 3, 'P20223276', 'AprilYandi Dwi W276', '56419974276', '3276022304010010276', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243276', 'Kp.Babakan No. 276', 'Islam', 4, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(277, 2, 'P20222277', 'AprilYandi Dwi W277', '56419974277', '3276022304010010277', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243277', 'Kp.Babakan No. 277', 'Islam', 13, 13, '150000.00', 3, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(278, 2, 'P20222278', 'AprilYandi Dwi W278', '56419974278', '3276022304010010278', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243278', 'Kp.Babakan No. 278', 'Islam', 12, 2, '150000.00', 1, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(279, 3, 'P20223279', 'AprilYandi Dwi W279', '56419974279', '3276022304010010279', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243279', 'Kp.Babakan No. 279', 'Islam', 11, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(280, 3, 'P20223280', 'AprilYandi Dwi W280', '56419974280', '3276022304010010280', 'Semarang', '2001-04-03', 'Perempuan', '08810243280', 'Kp.Babakan No. 280', 'Islam', 8, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(281, 2, 'P20222281', 'AprilYandi Dwi W281', '56419974281', '3276022304010010281', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243281', 'Kp.Babakan No. 281', 'Islam', 3, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(282, 3, 'P20223282', 'AprilYandi Dwi W282', '56419974282', '3276022304010010282', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243282', 'Kp.Babakan No. 282', 'Islam', 9, 8, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(283, 1, 'P20221283', 'AprilYandi Dwi W283', '56419974283', '3276022304010010283', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243283', 'Kp.Babakan No. 283', 'Islam', 1, 4, '150000.00', 4, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(284, 1, 'P20221284', 'AprilYandi Dwi W284', '56419974284', '3276022304010010284', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243284', 'Kp.Babakan No. 284', 'Islam', 12, 9, '150000.00', 1, 'Ya', '2022-12-11 06:45:53', NULL, NULL, NULL),
(285, 3, 'P20223285', 'AprilYandi Dwi W285', '56419974285', '3276022304010010285', 'Semarang', '2001-04-20', 'Perempuan', '08810243285', 'Kp.Babakan No. 285', 'Islam', 12, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:53', NULL, NULL, NULL),
(286, 1, 'P20221286', 'AprilYandi Dwi W286', '56419974286', '3276022304010010286', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243286', 'Kp.Babakan No. 286', 'Islam', 12, 6, '150000.00', 1, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(287, 1, 'P20221287', 'AprilYandi Dwi W287', '56419974287', '3276022304010010287', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243287', 'Kp.Babakan No. 287', 'Islam', 6, 6, '150000.00', 3, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(288, 1, 'P20221288', 'AprilYandi Dwi W288', '56419974288', '3276022304010010288', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243288', 'Kp.Babakan No. 288', 'Islam', 11, 4, '150000.00', 4, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(289, 2, 'P20222289', 'AprilYandi Dwi W289', '56419974289', '3276022304010010289', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243289', 'Kp.Babakan No. 289', 'Islam', 12, 3, '150000.00', 4, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(290, 2, 'P20222290', 'AprilYandi Dwi W290', '56419974290', '3276022304010010290', 'Semarang', '2001-04-17', 'Perempuan', '08810243290', 'Kp.Babakan No. 290', 'Islam', 4, 13, '150000.00', 1, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(291, 3, 'P20223291', 'AprilYandi Dwi W291', '56419974291', '3276022304010010291', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243291', 'Kp.Babakan No. 291', 'Islam', 6, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:54', NULL, NULL, NULL),
(292, 1, 'P20221292', 'AprilYandi Dwi W292', '56419974292', '3276022304010010292', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243292', 'Kp.Babakan No. 292', 'Islam', 10, 11, '150000.00', 1, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(293, 2, 'P20222293', 'AprilYandi Dwi W293', '56419974293', '3276022304010010293', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243293', 'Kp.Babakan No. 293', 'Islam', 9, 5, '150000.00', 2, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(294, 3, 'P20223294', 'AprilYandi Dwi W294', '56419974294', '3276022304010010294', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243294', 'Kp.Babakan No. 294', 'Islam', 6, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:54', NULL, NULL, NULL),
(295, 1, 'P20221295', 'AprilYandi Dwi W295', '56419974295', '3276022304010010295', 'Semarang', '2001-04-07', 'Perempuan', '08810243295', 'Kp.Babakan No. 295', 'Islam', 9, 13, '150000.00', 3, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(296, 1, 'P20221296', 'AprilYandi Dwi W296', '56419974296', '3276022304010010296', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243296', 'Kp.Babakan No. 296', 'Islam', 9, 13, '150000.00', 4, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(297, 3, 'P20223297', 'AprilYandi Dwi W297', '56419974297', '3276022304010010297', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243297', 'Kp.Babakan No. 297', 'Islam', 2, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:54', NULL, NULL, NULL),
(298, 3, 'P20223298', 'AprilYandi Dwi W298', '56419974298', '3276022304010010298', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243298', 'Kp.Babakan No. 298', 'Islam', 3, 10, NULL, NULL, 'Tidak', '2022-12-11 06:45:54', NULL, NULL, NULL),
(299, 3, 'P20223299', 'AprilYandi Dwi W299', '56419974299', '3276022304010010299', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243299', 'Kp.Babakan No. 299', 'Islam', 3, 4, NULL, NULL, 'Tidak', '2022-12-11 06:45:54', NULL, NULL, NULL),
(300, 3, 'P20223300', 'AprilYandi Dwi W300', '56419974300', '3276022304010010300', 'Semarang', '2001-04-19', 'Perempuan', '08810243300', 'Kp.Babakan No. 300', 'Islam', 11, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:54', NULL, NULL, NULL),
(301, 1, 'P20221301', 'AprilYandi Dwi W301', '56419974301', '3276022304010010301', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243301', 'Kp.Babakan No. 301', 'Islam', 13, 3, '150000.00', 2, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(302, 1, 'P20221302', 'AprilYandi Dwi W302', '56419974302', '3276022304010010302', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243302', 'Kp.Babakan No. 302', 'Islam', 1, 2, '150000.00', 2, 'Ya', '2022-12-11 06:45:54', NULL, NULL, NULL),
(303, 3, 'P20223303', 'AprilYandi Dwi W303', '56419974303', '3276022304010010303', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243303', 'Kp.Babakan No. 303', 'Islam', 6, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:55', NULL, NULL, NULL),
(304, 1, 'P20221304', 'AprilYandi Dwi W304', '56419974304', '3276022304010010304', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243304', 'Kp.Babakan No. 304', 'Islam', 8, 10, '150000.00', 4, 'Ya', '2022-12-11 06:45:55', NULL, NULL, NULL),
(305, 1, 'P20221305', 'AprilYandi Dwi W305', '56419974305', '3276022304010010305', 'Semarang', '2001-04-06', 'Perempuan', '08810243305', 'Kp.Babakan No. 305', 'Islam', 12, 11, '150000.00', 2, 'Ya', '2022-12-11 06:45:55', NULL, NULL, NULL),
(306, 1, 'P20221306', 'AprilYandi Dwi W306', '56419974306', '3276022304010010306', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243306', 'Kp.Babakan No. 306', 'Islam', 13, 12, '150000.00', 2, 'Ya', '2022-12-11 06:45:55', NULL, NULL, NULL),
(307, 1, 'P20221307', 'AprilYandi Dwi W307', '56419974307', '3276022304010010307', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243307', 'Kp.Babakan No. 307', 'Islam', 13, 11, '150000.00', 1, 'Ya', '2022-12-11 06:45:55', NULL, NULL, NULL),
(308, 3, 'P20223308', 'AprilYandi Dwi W308', '56419974308', '3276022304010010308', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243308', 'Kp.Babakan No. 308', 'Islam', 9, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:55', NULL, NULL, NULL),
(309, 2, 'P20222309', 'AprilYandi Dwi W309', '56419974309', '3276022304010010309', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243309', 'Kp.Babakan No. 309', 'Islam', 13, 8, '150000.00', 3, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(310, 3, 'P20223310', 'AprilYandi Dwi W310', '56419974310', '3276022304010010310', 'Semarang', '2001-04-02', 'Perempuan', '08810243310', 'Kp.Babakan No. 310', 'Islam', 12, 12, NULL, NULL, 'Tidak', '2022-12-11 06:45:56', NULL, NULL, NULL),
(311, 1, 'P20221311', 'AprilYandi Dwi W311', '56419974311', '3276022304010010311', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243311', 'Kp.Babakan No. 311', 'Islam', 11, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(312, 3, 'P20223312', 'AprilYandi Dwi W312', '56419974312', '3276022304010010312', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243312', 'Kp.Babakan No. 312', 'Islam', 7, 13, NULL, NULL, 'Tidak', '2022-12-11 06:45:56', NULL, NULL, NULL),
(313, 1, 'P20221313', 'AprilYandi Dwi W313', '56419974313', '3276022304010010313', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243313', 'Kp.Babakan No. 313', 'Islam', 5, 13, '150000.00', 1, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(314, 3, 'P20223314', 'AprilYandi Dwi W314', '56419974314', '3276022304010010314', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243314', 'Kp.Babakan No. 314', 'Islam', 9, 1, NULL, NULL, 'Tidak', '2022-12-11 06:45:56', NULL, NULL, NULL),
(315, 2, 'P20222315', 'AprilYandi Dwi W315', '56419974315', '3276022304010010315', 'Semarang', '2001-04-20', 'Perempuan', '08810243315', 'Kp.Babakan No. 315', 'Islam', 8, 5, '150000.00', 3, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(316, 2, 'P20222316', 'AprilYandi Dwi W316', '56419974316', '3276022304010010316', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243316', 'Kp.Babakan No. 316', 'Islam', 6, 11, '150000.00', 4, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(317, 2, 'P20222317', 'AprilYandi Dwi W317', '56419974317', '3276022304010010317', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243317', 'Kp.Babakan No. 317', 'Islam', 2, 6, '150000.00', 4, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(318, 3, 'P20223318', 'AprilYandi Dwi W318', '56419974318', '3276022304010010318', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243318', 'Kp.Babakan No. 318', 'Islam', 6, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:56', NULL, NULL, NULL),
(319, 2, 'P20222319', 'AprilYandi Dwi W319', '56419974319', '3276022304010010319', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243319', 'Kp.Babakan No. 319', 'Islam', 10, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(320, 1, 'P20221320', 'AprilYandi Dwi W320', '56419974320', '3276022304010010320', 'Semarang', '2001-03-29', 'Perempuan', '08810243320', 'Kp.Babakan No. 320', 'Islam', 2, 8, '150000.00', 2, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(321, 2, 'P20222321', 'AprilYandi Dwi W321', '56419974321', '3276022304010010321', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243321', 'Kp.Babakan No. 321', 'Islam', 13, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(322, 1, 'P20221322', 'AprilYandi Dwi W322', '56419974322', '3276022304010010322', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243322', 'Kp.Babakan No. 322', 'Islam', 2, 3, '150000.00', 4, 'Ya', '2022-12-11 06:45:56', NULL, NULL, NULL),
(323, 1, 'P20221323', 'AprilYandi Dwi W323', '56419974323', '3276022304010010323', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243323', 'Kp.Babakan No. 323', 'Islam', 1, 2, '150000.00', 4, 'Ya', '2022-12-11 06:45:57', NULL, NULL, NULL),
(324, 3, 'P20223324', 'AprilYandi Dwi W324', '56419974324', '3276022304010010324', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243324', 'Kp.Babakan No. 324', 'Islam', 7, 9, NULL, NULL, 'Tidak', '2022-12-11 06:45:57', NULL, NULL, NULL),
(325, 2, 'P20222325', 'AprilYandi Dwi W325', '56419974325', '3276022304010010325', 'Semarang', '2001-04-21', 'Perempuan', '08810243325', 'Kp.Babakan No. 325', 'Islam', 5, 7, '150000.00', 1, 'Ya', '2022-12-11 06:45:57', NULL, NULL, NULL),
(326, 1, 'P20221326', 'AprilYandi Dwi W326', '56419974326', '3276022304010010326', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243326', 'Kp.Babakan No. 326', 'Islam', 7, 11, '150000.00', 1, 'Ya', '2022-12-11 06:45:57', NULL, NULL, NULL),
(327, 3, 'P20223327', 'AprilYandi Dwi W327', '56419974327', '3276022304010010327', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243327', 'Kp.Babakan No. 327', 'Islam', 9, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:57', NULL, NULL, NULL),
(328, 3, 'P20223328', 'AprilYandi Dwi W328', '56419974328', '3276022304010010328', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243328', 'Kp.Babakan No. 328', 'Islam', 10, 3, NULL, NULL, 'Tidak', '2022-12-11 06:45:57', NULL, NULL, NULL),
(329, 3, 'P20223329', 'AprilYandi Dwi W329', '56419974329', '3276022304010010329', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243329', 'Kp.Babakan No. 329', 'Islam', 12, 5, NULL, NULL, 'Tidak', '2022-12-11 06:45:57', NULL, NULL, NULL),
(330, 2, 'P20222330', 'AprilYandi Dwi W330', '56419974330', '3276022304010010330', 'Semarang', '2001-04-14', 'Perempuan', '08810243330', 'Kp.Babakan No. 330', 'Islam', 2, 1, '150000.00', 1, 'Ya', '2022-12-11 06:45:57', NULL, NULL, NULL),
(331, 2, 'P20222331', 'AprilYandi Dwi W331', '56419974331', '3276022304010010331', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243331', 'Kp.Babakan No. 331', 'Islam', 5, 5, '150000.00', 2, 'Ya', '2022-12-11 06:45:58', NULL, NULL, NULL),
(332, 3, 'P20223332', 'AprilYandi Dwi W332', '56419974332', '3276022304010010332', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243332', 'Kp.Babakan No. 332', 'Islam', 5, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:58', NULL, NULL, NULL),
(333, 1, 'P20221333', 'AprilYandi Dwi W333', '56419974333', '3276022304010010333', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243333', 'Kp.Babakan No. 333', 'Islam', 3, 4, '150000.00', 2, 'Ya', '2022-12-11 06:45:58', NULL, NULL, NULL),
(334, 1, 'P20221334', 'AprilYandi Dwi W334', '56419974334', '3276022304010010334', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243334', 'Kp.Babakan No. 334', 'Islam', 13, 6, '150000.00', 2, 'Ya', '2022-12-11 06:45:58', NULL, NULL, NULL),
(335, 1, 'P20221335', 'AprilYandi Dwi W335', '56419974335', '3276022304010010335', 'Semarang', '2001-03-29', 'Perempuan', '08810243335', 'Kp.Babakan No. 335', 'Islam', 9, 9, '150000.00', 2, 'Ya', '2022-12-11 06:45:58', NULL, NULL, NULL),
(336, 3, 'P20223336', 'AprilYandi Dwi W336', '56419974336', '3276022304010010336', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243336', 'Kp.Babakan No. 336', 'Islam', 11, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:58', NULL, NULL, NULL),
(337, 3, 'P20223337', 'AprilYandi Dwi W337', '56419974337', '3276022304010010337', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243337', 'Kp.Babakan No. 337', 'Islam', 4, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:58', NULL, NULL, NULL),
(338, 2, 'P20222338', 'AprilYandi Dwi W338', '56419974338', '3276022304010010338', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243338', 'Kp.Babakan No. 338', 'Islam', 5, 9, '150000.00', 4, 'Ya', '2022-12-11 06:45:58', NULL, NULL, NULL),
(339, 3, 'P20223339', 'AprilYandi Dwi W339', '56419974339', '3276022304010010339', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243339', 'Kp.Babakan No. 339', 'Islam', 8, 2, NULL, NULL, 'Tidak', '2022-12-11 06:45:58', NULL, NULL, NULL),
(340, 2, 'P20222340', 'AprilYandi Dwi W340', '56419974340', '3276022304010010340', 'Semarang', '2001-03-27', 'Perempuan', '08810243340', 'Kp.Babakan No. 340', 'Islam', 1, 9, '150000.00', 1, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(341, 1, 'P20221341', 'AprilYandi Dwi W341', '56419974341', '3276022304010010341', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243341', 'Kp.Babakan No. 341', 'Islam', 7, 8, '150000.00', 4, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(342, 1, 'P20221342', 'AprilYandi Dwi W342', '56419974342', '3276022304010010342', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243342', 'Kp.Babakan No. 342', 'Islam', 8, 13, '150000.00', 3, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(343, 1, 'P20221343', 'AprilYandi Dwi W343', '56419974343', '3276022304010010343', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243343', 'Kp.Babakan No. 343', 'Islam', 2, 5, '150000.00', 1, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(344, 1, 'P20221344', 'AprilYandi Dwi W344', '56419974344', '3276022304010010344', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243344', 'Kp.Babakan No. 344', 'Islam', 6, 13, '150000.00', 4, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(345, 1, 'P20221345', 'AprilYandi Dwi W345', '56419974345', '3276022304010010345', 'Semarang', '2001-04-04', 'Perempuan', '08810243345', 'Kp.Babakan No. 345', 'Islam', 13, 13, '150000.00', 1, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(346, 3, 'P20223346', 'AprilYandi Dwi W346', '56419974346', '3276022304010010346', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243346', 'Kp.Babakan No. 346', 'Islam', 1, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:59', NULL, NULL, NULL),
(347, 1, 'P20221347', 'AprilYandi Dwi W347', '56419974347', '3276022304010010347', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243347', 'Kp.Babakan No. 347', 'Islam', 1, 5, '150000.00', 3, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(348, 1, 'P20221348', 'AprilYandi Dwi W348', '56419974348', '3276022304010010348', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243348', 'Kp.Babakan No. 348', 'Islam', 8, 7, '150000.00', 3, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(349, 1, 'P20221349', 'AprilYandi Dwi W349', '56419974349', '3276022304010010349', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243349', 'Kp.Babakan No. 349', 'Islam', 3, 7, '150000.00', 1, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(350, 3, 'P20223350', 'AprilYandi Dwi W350', '56419974350', '3276022304010010350', 'Semarang', '2001-03-30', 'Perempuan', '08810243350', 'Kp.Babakan No. 350', 'Islam', 3, 7, NULL, NULL, 'Tidak', '2022-12-11 06:45:59', NULL, NULL, NULL),
(351, 2, 'P20222351', 'AprilYandi Dwi W351', '56419974351', '3276022304010010351', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243351', 'Kp.Babakan No. 351', 'Islam', 7, 7, '150000.00', 2, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(352, 3, 'P20223352', 'AprilYandi Dwi W352', '56419974352', '3276022304010010352', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243352', 'Kp.Babakan No. 352', 'Islam', 13, 11, NULL, NULL, 'Tidak', '2022-12-11 06:45:59', NULL, NULL, NULL),
(353, 2, 'P20222353', 'AprilYandi Dwi W353', '56419974353', '3276022304010010353', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243353', 'Kp.Babakan No. 353', 'Islam', 13, 1, '150000.00', 3, 'Ya', '2022-12-11 06:45:59', NULL, NULL, NULL),
(354, 3, 'P20223354', 'AprilYandi Dwi W354', '56419974354', '3276022304010010354', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243354', 'Kp.Babakan No. 354', 'Islam', 10, 6, NULL, NULL, 'Tidak', '2022-12-11 06:45:59', NULL, NULL, NULL),
(355, 1, 'P20221355', 'AprilYandi Dwi W355', '56419974355', '3276022304010010355', 'Semarang', '2001-04-17', 'Perempuan', '08810243355', 'Kp.Babakan No. 355', 'Islam', 1, 12, '150000.00', 4, 'Ya', '2022-12-11 06:46:00', NULL, NULL, NULL),
(356, 1, 'P20221356', 'AprilYandi Dwi W356', '56419974356', '3276022304010010356', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243356', 'Kp.Babakan No. 356', 'Islam', 9, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:00', NULL, NULL, NULL),
(357, 3, 'P20223357', 'AprilYandi Dwi W357', '56419974357', '3276022304010010357', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243357', 'Kp.Babakan No. 357', 'Islam', 13, 9, NULL, NULL, 'Tidak', '2022-12-11 06:46:00', NULL, NULL, NULL),
(358, 2, 'P20222358', 'AprilYandi Dwi W358', '56419974358', '3276022304010010358', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243358', 'Kp.Babakan No. 358', 'Islam', 5, 8, '150000.00', 3, 'Ya', '2022-12-11 06:46:00', NULL, NULL, NULL),
(359, 3, 'P20223359', 'AprilYandi Dwi W359', '56419974359', '3276022304010010359', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243359', 'Kp.Babakan No. 359', 'Islam', 4, 12, NULL, NULL, 'Tidak', '2022-12-11 06:46:00', NULL, NULL, NULL),
(360, 1, 'P20221360', 'AprilYandi Dwi W360', '56419974360', '3276022304010010360', 'Semarang', '2001-04-03', 'Perempuan', '08810243360', 'Kp.Babakan No. 360', 'Islam', 7, 11, '150000.00', 3, 'Ya', '2022-12-11 06:46:00', NULL, NULL, NULL),
(361, 1, 'P20221361', 'AprilYandi Dwi W361', '56419974361', '3276022304010010361', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243361', 'Kp.Babakan No. 361', 'Islam', 11, 9, '150000.00', 3, 'Ya', '2022-12-11 06:46:00', NULL, NULL, NULL),
(362, 1, 'P20221362', 'AprilYandi Dwi W362', '56419974362', '3276022304010010362', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243362', 'Kp.Babakan No. 362', 'Islam', 12, 1, '150000.00', 3, 'Ya', '2022-12-11 06:46:00', NULL, NULL, NULL),
(363, 2, 'P20222363', 'AprilYandi Dwi W363', '56419974363', '3276022304010010363', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243363', 'Kp.Babakan No. 363', 'Islam', 6, 6, '150000.00', 3, 'Ya', '2022-12-11 06:46:01', NULL, NULL, NULL),
(364, 2, 'P20222364', 'AprilYandi Dwi W364', '56419974364', '3276022304010010364', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243364', 'Kp.Babakan No. 364', 'Islam', 12, 10, '150000.00', 4, 'Ya', '2022-12-11 06:46:01', NULL, NULL, NULL),
(365, 2, 'P20222365', 'AprilYandi Dwi W365', '56419974365', '3276022304010010365', 'Semarang', '2001-03-30', 'Perempuan', '08810243365', 'Kp.Babakan No. 365', 'Islam', 10, 10, '150000.00', 1, 'Ya', '2022-12-11 06:46:01', NULL, NULL, NULL),
(366, 2, 'P20222366', 'AprilYandi Dwi W366', '56419974366', '3276022304010010366', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243366', 'Kp.Babakan No. 366', 'Islam', 12, 6, '150000.00', 1, 'Ya', '2022-12-11 06:46:01', NULL, NULL, NULL),
(367, 3, 'P20223367', 'AprilYandi Dwi W367', '56419974367', '3276022304010010367', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243367', 'Kp.Babakan No. 367', 'Islam', 11, 8, NULL, NULL, 'Tidak', '2022-12-11 06:46:01', NULL, NULL, NULL),
(368, 1, 'P20221368', 'AprilYandi Dwi W368', '56419974368', '3276022304010010368', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243368', 'Kp.Babakan No. 368', 'Islam', 7, 9, '150000.00', 1, 'Ya', '2022-12-11 06:46:01', NULL, NULL, NULL),
(369, 3, 'P20223369', 'AprilYandi Dwi W369', '56419974369', '3276022304010010369', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243369', 'Kp.Babakan No. 369', 'Islam', 10, 10, NULL, NULL, 'Tidak', '2022-12-11 06:46:02', NULL, NULL, NULL),
(370, 2, 'P20222370', 'AprilYandi Dwi W370', '56419974370', '3276022304010010370', 'Semarang', '2001-04-08', 'Perempuan', '08810243370', 'Kp.Babakan No. 370', 'Islam', 11, 8, '150000.00', 3, 'Ya', '2022-12-11 06:46:07', NULL, NULL, NULL),
(371, 2, 'P20222371', 'AprilYandi Dwi W371', '56419974371', '3276022304010010371', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243371', 'Kp.Babakan No. 371', 'Islam', 7, 9, '150000.00', 3, 'Ya', '2022-12-11 06:46:08', NULL, NULL, NULL),
(372, 1, 'P20221372', 'AprilYandi Dwi W372', '56419974372', '3276022304010010372', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243372', 'Kp.Babakan No. 372', 'Islam', 7, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:10', NULL, NULL, NULL),
(373, 1, 'P20221373', 'AprilYandi Dwi W373', '56419974373', '3276022304010010373', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243373', 'Kp.Babakan No. 373', 'Islam', 6, 1, '150000.00', 1, 'Ya', '2022-12-11 06:46:10', NULL, NULL, NULL),
(374, 2, 'P20222374', 'AprilYandi Dwi W374', '56419974374', '3276022304010010374', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243374', 'Kp.Babakan No. 374', 'Islam', 7, 5, '150000.00', 4, 'Ya', '2022-12-11 06:46:10', NULL, NULL, NULL),
(375, 2, 'P20222375', 'AprilYandi Dwi W375', '56419974375', '3276022304010010375', 'Semarang', '2001-04-13', 'Perempuan', '08810243375', 'Kp.Babakan No. 375', 'Islam', 12, 13, '150000.00', 3, 'Ya', '2022-12-11 06:46:11', NULL, NULL, NULL),
(376, 1, 'P20221376', 'AprilYandi Dwi W376', '56419974376', '3276022304010010376', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243376', 'Kp.Babakan No. 376', 'Islam', 13, 10, '150000.00', 1, 'Ya', '2022-12-11 06:46:12', NULL, NULL, NULL),
(377, 1, 'P20221377', 'AprilYandi Dwi W377', '56419974377', '3276022304010010377', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243377', 'Kp.Babakan No. 377', 'Islam', 10, 5, '150000.00', 4, 'Ya', '2022-12-11 06:46:13', NULL, NULL, NULL),
(378, 3, 'P20223378', 'AprilYandi Dwi W378', '56419974378', '3276022304010010378', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243378', 'Kp.Babakan No. 378', 'Islam', 10, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:13', NULL, NULL, NULL),
(379, 2, 'P20222379', 'AprilYandi Dwi W379', '56419974379', '3276022304010010379', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243379', 'Kp.Babakan No. 379', 'Islam', 11, 9, '150000.00', 1, 'Ya', '2022-12-11 06:46:14', NULL, NULL, NULL),
(380, 1, 'P20221380', 'AprilYandi Dwi W380', '56419974380', '3276022304010010380', 'Semarang', '2001-03-29', 'Perempuan', '08810243380', 'Kp.Babakan No. 380', 'Islam', 3, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:14', NULL, NULL, NULL),
(381, 3, 'P20223381', 'AprilYandi Dwi W381', '56419974381', '3276022304010010381', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243381', 'Kp.Babakan No. 381', 'Islam', 8, 8, NULL, NULL, 'Tidak', '2022-12-11 06:46:14', NULL, NULL, NULL),
(382, 2, 'P20222382', 'AprilYandi Dwi W382', '56419974382', '3276022304010010382', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243382', 'Kp.Babakan No. 382', 'Islam', 8, 12, '150000.00', 2, 'Ya', '2022-12-11 06:46:15', NULL, NULL, NULL),
(383, 1, 'P20221383', 'AprilYandi Dwi W383', '56419974383', '3276022304010010383', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243383', 'Kp.Babakan No. 383', 'Islam', 7, 4, '150000.00', 4, 'Ya', '2022-12-11 06:46:15', NULL, NULL, NULL),
(384, 2, 'P20222384', 'AprilYandi Dwi W384', '56419974384', '3276022304010010384', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243384', 'Kp.Babakan No. 384', 'Islam', 8, 8, '150000.00', 2, 'Ya', '2022-12-11 06:46:15', NULL, NULL, NULL),
(385, 3, 'P20223385', 'AprilYandi Dwi W385', '56419974385', '3276022304010010385', 'Semarang', '2001-04-18', 'Perempuan', '08810243385', 'Kp.Babakan No. 385', 'Islam', 5, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:15', NULL, NULL, NULL),
(386, 2, 'P20222386', 'AprilYandi Dwi W386', '56419974386', '3276022304010010386', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243386', 'Kp.Babakan No. 386', 'Islam', 9, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:16', NULL, NULL, NULL),
(387, 1, 'P20221387', 'AprilYandi Dwi W387', '56419974387', '3276022304010010387', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243387', 'Kp.Babakan No. 387', 'Islam', 6, 1, '150000.00', 2, 'Ya', '2022-12-11 06:46:16', NULL, NULL, NULL),
(388, 1, 'P20221388', 'AprilYandi Dwi W388', '56419974388', '3276022304010010388', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243388', 'Kp.Babakan No. 388', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:16', NULL, NULL, NULL),
(389, 1, 'P20221389', 'AprilYandi Dwi W389', '56419974389', '3276022304010010389', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243389', 'Kp.Babakan No. 389', 'Islam', 5, 3, '150000.00', 1, 'Ya', '2022-12-11 06:46:16', NULL, NULL, NULL),
(390, 1, 'P20221390', 'AprilYandi Dwi W390', '56419974390', '3276022304010010390', 'Semarang', '2001-04-14', 'Perempuan', '08810243390', 'Kp.Babakan No. 390', 'Islam', 13, 13, '150000.00', 4, 'Ya', '2022-12-11 06:46:17', NULL, NULL, NULL),
(391, 1, 'P20221391', 'AprilYandi Dwi W391', '56419974391', '3276022304010010391', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243391', 'Kp.Babakan No. 391', 'Islam', 1, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:17', NULL, NULL, NULL),
(392, 1, 'P20221392', 'AprilYandi Dwi W392', '56419974392', '3276022304010010392', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243392', 'Kp.Babakan No. 392', 'Islam', 1, 1, '150000.00', 4, 'Ya', '2022-12-11 06:46:18', NULL, NULL, NULL),
(393, 1, 'P20221393', 'AprilYandi Dwi W393', '56419974393', '3276022304010010393', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243393', 'Kp.Babakan No. 393', 'Islam', 7, 4, '150000.00', 1, 'Ya', '2022-12-11 06:46:18', NULL, NULL, NULL),
(394, 1, 'P20221394', 'AprilYandi Dwi W394', '56419974394', '3276022304010010394', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243394', 'Kp.Babakan No. 394', 'Islam', 10, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:18', NULL, NULL, NULL),
(395, 1, 'P20221395', 'AprilYandi Dwi W395', '56419974395', '3276022304010010395', 'Semarang', '2001-04-05', 'Perempuan', '08810243395', 'Kp.Babakan No. 395', 'Islam', 4, 3, '150000.00', 3, 'Ya', '2022-12-11 06:46:18', NULL, NULL, NULL),
(396, 1, 'P20221396', 'AprilYandi Dwi W396', '56419974396', '3276022304010010396', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243396', 'Kp.Babakan No. 396', 'Islam', 12, 12, '150000.00', 3, 'Ya', '2022-12-11 06:46:19', NULL, NULL, NULL),
(397, 1, 'P20221397', 'AprilYandi Dwi W397', '56419974397', '3276022304010010397', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243397', 'Kp.Babakan No. 397', 'Islam', 9, 11, '150000.00', 3, 'Ya', '2022-12-11 06:46:19', NULL, NULL, NULL),
(398, 1, 'P20221398', 'AprilYandi Dwi W398', '56419974398', '3276022304010010398', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243398', 'Kp.Babakan No. 398', 'Islam', 13, 4, '150000.00', 2, 'Ya', '2022-12-11 06:46:19', NULL, NULL, NULL),
(399, 3, 'P20223399', 'AprilYandi Dwi W399', '56419974399', '3276022304010010399', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243399', 'Kp.Babakan No. 399', 'Islam', 12, 11, NULL, NULL, 'Tidak', '2022-12-11 06:46:19', NULL, NULL, NULL),
(400, 3, 'P20223400', 'AprilYandi Dwi W400', '56419974400', '3276022304010010400', 'Semarang', '2001-04-15', 'Perempuan', '08810243400', 'Kp.Babakan No. 400', 'Islam', 4, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:20', NULL, NULL, NULL),
(401, 1, 'P20221401', 'AprilYandi Dwi W401', '56419974401', '3276022304010010401', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243401', 'Kp.Babakan No. 401', 'Islam', 9, 7, '150000.00', 4, 'Ya', '2022-12-11 06:46:23', NULL, NULL, NULL),
(402, 2, 'P20222402', 'AprilYandi Dwi W402', '56419974402', '3276022304010010402', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243402', 'Kp.Babakan No. 402', 'Islam', 6, 6, '150000.00', 4, 'Ya', '2022-12-11 06:46:23', NULL, NULL, NULL),
(403, 1, 'P20221403', 'AprilYandi Dwi W403', '56419974403', '3276022304010010403', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243403', 'Kp.Babakan No. 403', 'Islam', 2, 7, '150000.00', 2, 'Ya', '2022-12-11 06:46:23', NULL, NULL, NULL),
(404, 2, 'P20222404', 'AprilYandi Dwi W404', '56419974404', '3276022304010010404', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243404', 'Kp.Babakan No. 404', 'Islam', 4, 1, '150000.00', 4, 'Ya', '2022-12-11 06:46:24', NULL, NULL, NULL),
(405, 2, 'P20222405', 'AprilYandi Dwi W405', '56419974405', '3276022304010010405', 'Semarang', '2001-04-18', 'Perempuan', '08810243405', 'Kp.Babakan No. 405', 'Islam', 3, 6, '150000.00', 1, 'Ya', '2022-12-11 06:46:24', NULL, NULL, NULL),
(406, 1, 'P20221406', 'AprilYandi Dwi W406', '56419974406', '3276022304010010406', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243406', 'Kp.Babakan No. 406', 'Islam', 13, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:24', NULL, NULL, NULL),
(407, 3, 'P20223407', 'AprilYandi Dwi W407', '56419974407', '3276022304010010407', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243407', 'Kp.Babakan No. 407', 'Islam', 4, 9, NULL, NULL, 'Tidak', '2022-12-11 06:46:24', NULL, NULL, NULL),
(408, 2, 'P20222408', 'AprilYandi Dwi W408', '56419974408', '3276022304010010408', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243408', 'Kp.Babakan No. 408', 'Islam', 5, 13, '150000.00', 4, 'Ya', '2022-12-11 06:46:25', NULL, NULL, NULL),
(409, 1, 'P20221409', 'AprilYandi Dwi W409', '56419974409', '3276022304010010409', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243409', 'Kp.Babakan No. 409', 'Islam', 1, 2, '150000.00', 1, 'Ya', '2022-12-11 06:46:25', NULL, NULL, NULL),
(410, 3, 'P20223410', 'AprilYandi Dwi W410', '56419974410', '3276022304010010410', 'Semarang', '2001-04-19', 'Perempuan', '08810243410', 'Kp.Babakan No. 410', 'Islam', 5, 4, NULL, NULL, 'Tidak', '2022-12-11 06:46:25', NULL, NULL, NULL),
(411, 3, 'P20223411', 'AprilYandi Dwi W411', '56419974411', '3276022304010010411', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243411', 'Kp.Babakan No. 411', 'Islam', 3, 8, NULL, NULL, 'Tidak', '2022-12-11 06:46:25', NULL, NULL, NULL),
(412, 3, 'P20223412', 'AprilYandi Dwi W412', '56419974412', '3276022304010010412', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243412', 'Kp.Babakan No. 412', 'Islam', 3, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:26', NULL, NULL, NULL),
(413, 1, 'P20221413', 'AprilYandi Dwi W413', '56419974413', '3276022304010010413', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243413', 'Kp.Babakan No. 413', 'Islam', 1, 12, '150000.00', 1, 'Ya', '2022-12-11 06:46:26', NULL, NULL, NULL),
(414, 1, 'P20221414', 'AprilYandi Dwi W414', '56419974414', '3276022304010010414', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243414', 'Kp.Babakan No. 414', 'Islam', 2, 4, '150000.00', 1, 'Ya', '2022-12-11 06:46:26', NULL, NULL, NULL),
(415, 1, 'P20221415', 'AprilYandi Dwi W415', '56419974415', '3276022304010010415', 'Semarang', '2001-04-07', 'Perempuan', '08810243415', 'Kp.Babakan No. 415', 'Islam', 2, 1, '150000.00', 1, 'Ya', '2022-12-11 06:46:27', NULL, NULL, NULL),
(416, 2, 'P20222416', 'AprilYandi Dwi W416', '56419974416', '3276022304010010416', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243416', 'Kp.Babakan No. 416', 'Islam', 1, 5, '150000.00', 1, 'Ya', '2022-12-11 06:46:27', NULL, NULL, NULL),
(417, 3, 'P20223417', 'AprilYandi Dwi W417', '56419974417', '3276022304010010417', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243417', 'Kp.Babakan No. 417', 'Islam', 11, 9, NULL, NULL, 'Tidak', '2022-12-11 06:46:27', NULL, NULL, NULL),
(418, 2, 'P20222418', 'AprilYandi Dwi W418', '56419974418', '3276022304010010418', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243418', 'Kp.Babakan No. 418', 'Islam', 8, 5, '150000.00', 1, 'Ya', '2022-12-11 06:46:27', NULL, NULL, NULL),
(419, 1, 'P20221419', 'AprilYandi Dwi W419', '56419974419', '3276022304010010419', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243419', 'Kp.Babakan No. 419', 'Islam', 3, 13, '150000.00', 3, 'Ya', '2022-12-11 06:46:27', NULL, NULL, NULL),
(420, 2, 'P20222420', 'AprilYandi Dwi W420', '56419974420', '3276022304010010420', 'Semarang', '2001-04-02', 'Perempuan', '08810243420', 'Kp.Babakan No. 420', 'Islam', 11, 3, '150000.00', 2, 'Ya', '2022-12-11 06:46:27', NULL, NULL, NULL),
(421, 3, 'P20223421', 'AprilYandi Dwi W421', '56419974421', '3276022304010010421', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243421', 'Kp.Babakan No. 421', 'Islam', 10, 2, NULL, NULL, 'Tidak', '2022-12-11 06:46:27', NULL, NULL, NULL),
(422, 2, 'P20222422', 'AprilYandi Dwi W422', '56419974422', '3276022304010010422', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243422', 'Kp.Babakan No. 422', 'Islam', 8, 11, '150000.00', 1, 'Ya', '2022-12-11 06:46:28', NULL, NULL, NULL),
(423, 3, 'P20223423', 'AprilYandi Dwi W423', '56419974423', '3276022304010010423', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243423', 'Kp.Babakan No. 423', 'Islam', 6, 8, NULL, NULL, 'Tidak', '2022-12-11 06:46:28', NULL, NULL, NULL),
(424, 2, 'P20222424', 'AprilYandi Dwi W424', '56419974424', '3276022304010010424', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243424', 'Kp.Babakan No. 424', 'Islam', 11, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:29', NULL, NULL, NULL),
(425, 1, 'P20221425', 'AprilYandi Dwi W425', '56419974425', '3276022304010010425', 'Semarang', '2001-04-14', 'Perempuan', '08810243425', 'Kp.Babakan No. 425', 'Islam', 3, 7, '150000.00', 1, 'Ya', '2022-12-11 06:46:29', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(426, 1, 'P20221426', 'AprilYandi Dwi W426', '56419974426', '3276022304010010426', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243426', 'Kp.Babakan No. 426', 'Islam', 8, 5, '150000.00', 1, 'Ya', '2022-12-11 06:46:29', NULL, NULL, NULL),
(427, 1, 'P20221427', 'AprilYandi Dwi W427', '56419974427', '3276022304010010427', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243427', 'Kp.Babakan No. 427', 'Islam', 3, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:29', NULL, NULL, NULL),
(428, 1, 'P20221428', 'AprilYandi Dwi W428', '56419974428', '3276022304010010428', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243428', 'Kp.Babakan No. 428', 'Islam', 9, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:29', NULL, NULL, NULL),
(429, 3, 'P20223429', 'AprilYandi Dwi W429', '56419974429', '3276022304010010429', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243429', 'Kp.Babakan No. 429', 'Islam', 6, 1, NULL, NULL, 'Tidak', '2022-12-11 06:46:29', NULL, NULL, NULL),
(430, 1, 'P20221430', 'AprilYandi Dwi W430', '56419974430', '3276022304010010430', 'Semarang', '2001-03-28', 'Perempuan', '08810243430', 'Kp.Babakan No. 430', 'Islam', 8, 2, '150000.00', 1, 'Ya', '2022-12-11 06:46:29', NULL, NULL, NULL),
(431, 2, 'P20222431', 'AprilYandi Dwi W431', '56419974431', '3276022304010010431', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243431', 'Kp.Babakan No. 431', 'Islam', 10, 3, '150000.00', 4, 'Ya', '2022-12-11 06:46:30', NULL, NULL, NULL),
(432, 1, 'P20221432', 'AprilYandi Dwi W432', '56419974432', '3276022304010010432', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243432', 'Kp.Babakan No. 432', 'Islam', 3, 10, '150000.00', 1, 'Ya', '2022-12-11 06:46:30', NULL, NULL, NULL),
(433, 3, 'P20223433', 'AprilYandi Dwi W433', '56419974433', '3276022304010010433', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243433', 'Kp.Babakan No. 433', 'Islam', 3, 13, NULL, NULL, 'Tidak', '2022-12-11 06:46:30', NULL, NULL, NULL),
(434, 2, 'P20222434', 'AprilYandi Dwi W434', '56419974434', '3276022304010010434', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243434', 'Kp.Babakan No. 434', 'Islam', 2, 13, '150000.00', 4, 'Ya', '2022-12-11 06:46:30', NULL, NULL, NULL),
(435, 2, 'P20222435', 'AprilYandi Dwi W435', '56419974435', '3276022304010010435', 'Semarang', '2001-03-26', 'Perempuan', '08810243435', 'Kp.Babakan No. 435', 'Islam', 1, 12, '150000.00', 3, 'Ya', '2022-12-11 06:46:31', NULL, NULL, NULL),
(436, 3, 'P20223436', 'AprilYandi Dwi W436', '56419974436', '3276022304010010436', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243436', 'Kp.Babakan No. 436', 'Islam', 11, 7, NULL, NULL, 'Tidak', '2022-12-11 06:46:32', NULL, NULL, NULL),
(437, 3, 'P20223437', 'AprilYandi Dwi W437', '56419974437', '3276022304010010437', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243437', 'Kp.Babakan No. 437', 'Islam', 5, 9, NULL, NULL, 'Tidak', '2022-12-11 06:46:32', NULL, NULL, NULL),
(438, 2, 'P20222438', 'AprilYandi Dwi W438', '56419974438', '3276022304010010438', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243438', 'Kp.Babakan No. 438', 'Islam', 11, 12, '150000.00', 3, 'Ya', '2022-12-11 06:46:34', NULL, NULL, NULL),
(439, 3, 'P20223439', 'AprilYandi Dwi W439', '56419974439', '3276022304010010439', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243439', 'Kp.Babakan No. 439', 'Islam', 9, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:34', NULL, NULL, NULL),
(440, 1, 'P20221440', 'AprilYandi Dwi W440', '56419974440', '3276022304010010440', 'Semarang', '2001-03-27', 'Perempuan', '08810243440', 'Kp.Babakan No. 440', 'Islam', 9, 11, '150000.00', 4, 'Ya', '2022-12-11 06:46:35', NULL, NULL, NULL),
(441, 1, 'P20221441', 'AprilYandi Dwi W441', '56419974441', '3276022304010010441', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243441', 'Kp.Babakan No. 441', 'Islam', 3, 7, '150000.00', 4, 'Ya', '2022-12-11 06:46:35', NULL, NULL, NULL),
(442, 2, 'P20222442', 'AprilYandi Dwi W442', '56419974442', '3276022304010010442', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243442', 'Kp.Babakan No. 442', 'Islam', 4, 12, '150000.00', 2, 'Ya', '2022-12-11 06:46:36', NULL, NULL, NULL),
(443, 1, 'P20221443', 'AprilYandi Dwi W443', '56419974443', '3276022304010010443', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243443', 'Kp.Babakan No. 443', 'Islam', 11, 12, '150000.00', 4, 'Ya', '2022-12-11 06:46:36', NULL, NULL, NULL),
(444, 3, 'P20223444', 'AprilYandi Dwi W444', '56419974444', '3276022304010010444', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243444', 'Kp.Babakan No. 444', 'Islam', 2, 1, NULL, NULL, 'Tidak', '2022-12-11 06:46:36', NULL, NULL, NULL),
(445, 3, 'P20223445', 'AprilYandi Dwi W445', '56419974445', '3276022304010010445', 'Semarang', '2001-04-02', 'Perempuan', '08810243445', 'Kp.Babakan No. 445', 'Islam', 6, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:36', NULL, NULL, NULL),
(446, 1, 'P20221446', 'AprilYandi Dwi W446', '56419974446', '3276022304010010446', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243446', 'Kp.Babakan No. 446', 'Islam', 13, 1, '150000.00', 3, 'Ya', '2022-12-11 06:46:36', NULL, NULL, NULL),
(447, 1, 'P20221447', 'AprilYandi Dwi W447', '56419974447', '3276022304010010447', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243447', 'Kp.Babakan No. 447', 'Islam', 13, 4, '150000.00', 2, 'Ya', '2022-12-11 06:46:36', NULL, NULL, NULL),
(448, 3, 'P20223448', 'AprilYandi Dwi W448', '56419974448', '3276022304010010448', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243448', 'Kp.Babakan No. 448', 'Islam', 1, 13, NULL, NULL, 'Tidak', '2022-12-11 06:46:37', NULL, NULL, NULL),
(449, 1, 'P20221449', 'AprilYandi Dwi W449', '56419974449', '3276022304010010449', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243449', 'Kp.Babakan No. 449', 'Islam', 11, 12, '150000.00', 2, 'Ya', '2022-12-11 06:46:37', NULL, NULL, NULL),
(450, 3, 'P20223450', 'AprilYandi Dwi W450', '56419974450', '3276022304010010450', 'Semarang', '2001-04-20', 'Perempuan', '08810243450', 'Kp.Babakan No. 450', 'Islam', 1, 9, NULL, NULL, 'Tidak', '2022-12-11 06:46:37', NULL, NULL, NULL),
(451, 3, 'P20223451', 'AprilYandi Dwi W451', '56419974451', '3276022304010010451', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243451', 'Kp.Babakan No. 451', 'Islam', 9, 4, NULL, NULL, 'Tidak', '2022-12-11 06:46:37', NULL, NULL, NULL),
(452, 3, 'P20223452', 'AprilYandi Dwi W452', '56419974452', '3276022304010010452', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243452', 'Kp.Babakan No. 452', 'Islam', 5, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:38', NULL, NULL, NULL),
(453, 3, 'P20223453', 'AprilYandi Dwi W453', '56419974453', '3276022304010010453', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243453', 'Kp.Babakan No. 453', 'Islam', 13, 13, NULL, NULL, 'Tidak', '2022-12-11 06:46:38', NULL, NULL, NULL),
(454, 3, 'P20223454', 'AprilYandi Dwi W454', '56419974454', '3276022304010010454', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243454', 'Kp.Babakan No. 454', 'Islam', 13, 10, NULL, NULL, 'Tidak', '2022-12-11 06:46:38', NULL, NULL, NULL),
(455, 1, 'P20221455', 'AprilYandi Dwi W455', '56419974455', '3276022304010010455', 'Semarang', '2001-04-01', 'Perempuan', '08810243455', 'Kp.Babakan No. 455', 'Islam', 3, 2, '150000.00', 4, 'Ya', '2022-12-11 06:46:39', NULL, NULL, NULL),
(456, 1, 'P20221456', 'AprilYandi Dwi W456', '56419974456', '3276022304010010456', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243456', 'Kp.Babakan No. 456', 'Islam', 3, 5, '150000.00', 2, 'Ya', '2022-12-11 06:46:39', NULL, NULL, NULL),
(457, 2, 'P20222457', 'AprilYandi Dwi W457', '56419974457', '3276022304010010457', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243457', 'Kp.Babakan No. 457', 'Islam', 10, 13, '150000.00', 4, 'Ya', '2022-12-11 06:46:39', NULL, NULL, NULL),
(458, 2, 'P20222458', 'AprilYandi Dwi W458', '56419974458', '3276022304010010458', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243458', 'Kp.Babakan No. 458', 'Islam', 4, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:39', NULL, NULL, NULL),
(459, 1, 'P20221459', 'AprilYandi Dwi W459', '56419974459', '3276022304010010459', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243459', 'Kp.Babakan No. 459', 'Islam', 2, 6, '150000.00', 3, 'Ya', '2022-12-11 06:46:39', NULL, NULL, NULL),
(460, 3, 'P20223460', 'AprilYandi Dwi W460', '56419974460', '3276022304010010460', 'Semarang', '2001-04-15', 'Perempuan', '08810243460', 'Kp.Babakan No. 460', 'Islam', 12, 7, NULL, NULL, 'Tidak', '2022-12-11 06:46:39', NULL, NULL, NULL),
(461, 1, 'P20221461', 'AprilYandi Dwi W461', '56419974461', '3276022304010010461', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243461', 'Kp.Babakan No. 461', 'Islam', 5, 1, '150000.00', 4, 'Ya', '2022-12-11 06:46:40', NULL, NULL, NULL),
(462, 2, 'P20222462', 'AprilYandi Dwi W462', '56419974462', '3276022304010010462', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243462', 'Kp.Babakan No. 462', 'Islam', 10, 12, '150000.00', 4, 'Ya', '2022-12-11 06:46:40', NULL, NULL, NULL),
(463, 1, 'P20221463', 'AprilYandi Dwi W463', '56419974463', '3276022304010010463', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243463', 'Kp.Babakan No. 463', 'Islam', 7, 2, '150000.00', 1, 'Ya', '2022-12-11 06:46:40', NULL, NULL, NULL),
(464, 1, 'P20221464', 'AprilYandi Dwi W464', '56419974464', '3276022304010010464', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243464', 'Kp.Babakan No. 464', 'Islam', 1, 4, '150000.00', 2, 'Ya', '2022-12-11 06:46:41', NULL, NULL, NULL),
(465, 3, 'P20223465', 'AprilYandi Dwi W465', '56419974465', '3276022304010010465', 'Semarang', '2001-04-11', 'Perempuan', '08810243465', 'Kp.Babakan No. 465', 'Islam', 6, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:41', NULL, NULL, NULL),
(466, 3, 'P20223466', 'AprilYandi Dwi W466', '56419974466', '3276022304010010466', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243466', 'Kp.Babakan No. 466', 'Islam', 8, 8, NULL, NULL, 'Tidak', '2022-12-11 06:46:41', NULL, NULL, NULL),
(467, 3, 'P20223467', 'AprilYandi Dwi W467', '56419974467', '3276022304010010467', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243467', 'Kp.Babakan No. 467', 'Islam', 11, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:42', NULL, NULL, NULL),
(468, 1, 'P20221468', 'AprilYandi Dwi W468', '56419974468', '3276022304010010468', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243468', 'Kp.Babakan No. 468', 'Islam', 3, 12, '150000.00', 3, 'Ya', '2022-12-11 06:46:43', NULL, NULL, NULL),
(469, 2, 'P20222469', 'AprilYandi Dwi W469', '56419974469', '3276022304010010469', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243469', 'Kp.Babakan No. 469', 'Islam', 10, 13, '150000.00', 4, 'Ya', '2022-12-11 06:46:43', NULL, NULL, NULL),
(470, 1, 'P20221470', 'AprilYandi Dwi W470', '56419974470', '3276022304010010470', 'Semarang', '2001-03-26', 'Perempuan', '08810243470', 'Kp.Babakan No. 470', 'Islam', 4, 6, '150000.00', 4, 'Ya', '2022-12-11 06:46:43', NULL, NULL, NULL),
(471, 1, 'P20221471', 'AprilYandi Dwi W471', '56419974471', '3276022304010010471', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243471', 'Kp.Babakan No. 471', 'Islam', 13, 1, '150000.00', 1, 'Ya', '2022-12-11 06:46:43', NULL, NULL, NULL),
(472, 2, 'P20222472', 'AprilYandi Dwi W472', '56419974472', '3276022304010010472', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243472', 'Kp.Babakan No. 472', 'Islam', 7, 6, '150000.00', 3, 'Ya', '2022-12-11 06:46:44', NULL, NULL, NULL),
(473, 1, 'P20221473', 'AprilYandi Dwi W473', '56419974473', '3276022304010010473', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243473', 'Kp.Babakan No. 473', 'Islam', 3, 2, '150000.00', 1, 'Ya', '2022-12-11 06:46:44', NULL, NULL, NULL),
(474, 2, 'P20222474', 'AprilYandi Dwi W474', '56419974474', '3276022304010010474', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243474', 'Kp.Babakan No. 474', 'Islam', 10, 4, '150000.00', 3, 'Ya', '2022-12-11 06:46:44', NULL, NULL, NULL),
(475, 1, 'P20221475', 'AprilYandi Dwi W475', '56419974475', '3276022304010010475', 'Semarang', '2001-04-13', 'Perempuan', '08810243475', 'Kp.Babakan No. 475', 'Islam', 10, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:44', NULL, NULL, NULL),
(476, 2, 'P20222476', 'AprilYandi Dwi W476', '56419974476', '3276022304010010476', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243476', 'Kp.Babakan No. 476', 'Islam', 11, 2, '150000.00', 1, 'Ya', '2022-12-11 06:46:45', NULL, NULL, NULL),
(477, 3, 'P20223477', 'AprilYandi Dwi W477', '56419974477', '3276022304010010477', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243477', 'Kp.Babakan No. 477', 'Islam', 12, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:45', NULL, NULL, NULL),
(478, 1, 'P20221478', 'AprilYandi Dwi W478', '56419974478', '3276022304010010478', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243478', 'Kp.Babakan No. 478', 'Islam', 1, 12, '150000.00', 2, 'Ya', '2022-12-11 06:46:45', NULL, NULL, NULL),
(479, 2, 'P20222479', 'AprilYandi Dwi W479', '56419974479', '3276022304010010479', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243479', 'Kp.Babakan No. 479', 'Islam', 1, 9, '150000.00', 4, 'Ya', '2022-12-11 06:46:45', NULL, NULL, NULL),
(480, 2, 'P20222480', 'AprilYandi Dwi W480', '56419974480', '3276022304010010480', 'Semarang', '2001-04-07', 'Perempuan', '08810243480', 'Kp.Babakan No. 480', 'Islam', 11, 12, '150000.00', 2, 'Ya', '2022-12-11 06:46:46', NULL, NULL, NULL),
(481, 2, 'P20222481', 'AprilYandi Dwi W481', '56419974481', '3276022304010010481', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243481', 'Kp.Babakan No. 481', 'Islam', 8, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:46', NULL, NULL, NULL),
(482, 1, 'P20221482', 'AprilYandi Dwi W482', '56419974482', '3276022304010010482', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243482', 'Kp.Babakan No. 482', 'Islam', 5, 8, '150000.00', 1, 'Ya', '2022-12-11 06:46:46', NULL, NULL, NULL),
(483, 2, 'P20222483', 'AprilYandi Dwi W483', '56419974483', '3276022304010010483', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243483', 'Kp.Babakan No. 483', 'Islam', 5, 5, '150000.00', 4, 'Ya', '2022-12-11 06:46:46', NULL, NULL, NULL),
(484, 2, 'P20222484', 'AprilYandi Dwi W484', '56419974484', '3276022304010010484', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243484', 'Kp.Babakan No. 484', 'Islam', 12, 8, '150000.00', 2, 'Ya', '2022-12-11 06:46:47', NULL, NULL, NULL),
(485, 3, 'P20223485', 'AprilYandi Dwi W485', '56419974485', '3276022304010010485', 'Semarang', '2001-04-04', 'Perempuan', '08810243485', 'Kp.Babakan No. 485', 'Islam', 7, 11, NULL, NULL, 'Tidak', '2022-12-11 06:46:47', NULL, NULL, NULL),
(486, 2, 'P20222486', 'AprilYandi Dwi W486', '56419974486', '3276022304010010486', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243486', 'Kp.Babakan No. 486', 'Islam', 9, 7, '150000.00', 1, 'Ya', '2022-12-11 06:46:47', NULL, NULL, NULL),
(487, 1, 'P20221487', 'AprilYandi Dwi W487', '56419974487', '3276022304010010487', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243487', 'Kp.Babakan No. 487', 'Islam', 9, 3, '150000.00', 1, 'Ya', '2022-12-11 06:46:47', NULL, NULL, NULL),
(488, 2, 'P20222488', 'AprilYandi Dwi W488', '56419974488', '3276022304010010488', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243488', 'Kp.Babakan No. 488', 'Islam', 9, 8, '150000.00', 3, 'Ya', '2022-12-11 06:46:48', NULL, NULL, NULL),
(489, 2, 'P20222489', 'AprilYandi Dwi W489', '56419974489', '3276022304010010489', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243489', 'Kp.Babakan No. 489', 'Islam', 5, 1, '150000.00', 4, 'Ya', '2022-12-11 06:46:48', NULL, NULL, NULL),
(490, 1, 'P20221490', 'AprilYandi Dwi W490', '56419974490', '3276022304010010490', 'Semarang', '2001-04-17', 'Perempuan', '08810243490', 'Kp.Babakan No. 490', 'Islam', 9, 11, '150000.00', 4, 'Ya', '2022-12-11 06:46:48', NULL, NULL, NULL),
(491, 1, 'P20221491', 'AprilYandi Dwi W491', '56419974491', '3276022304010010491', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243491', 'Kp.Babakan No. 491', 'Islam', 9, 13, '150000.00', 3, 'Ya', '2022-12-11 06:46:48', NULL, NULL, NULL),
(492, 3, 'P20223492', 'AprilYandi Dwi W492', '56419974492', '3276022304010010492', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243492', 'Kp.Babakan No. 492', 'Islam', 8, 5, NULL, NULL, 'Tidak', '2022-12-11 06:46:48', NULL, NULL, NULL),
(493, 3, 'P20223493', 'AprilYandi Dwi W493', '56419974493', '3276022304010010493', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243493', 'Kp.Babakan No. 493', 'Islam', 11, 1, NULL, NULL, 'Tidak', '2022-12-11 06:46:49', NULL, NULL, NULL),
(494, 2, 'P20222494', 'AprilYandi Dwi W494', '56419974494', '3276022304010010494', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243494', 'Kp.Babakan No. 494', 'Islam', 4, 3, '150000.00', 4, 'Ya', '2022-12-11 06:46:49', NULL, NULL, NULL),
(495, 3, 'P20223495', 'AprilYandi Dwi W495', '56419974495', '3276022304010010495', 'Semarang', '2001-04-12', 'Perempuan', '08810243495', 'Kp.Babakan No. 495', 'Islam', 9, 12, NULL, NULL, 'Tidak', '2022-12-11 06:46:49', NULL, NULL, NULL),
(496, 2, 'P20222496', 'AprilYandi Dwi W496', '56419974496', '3276022304010010496', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243496', 'Kp.Babakan No. 496', 'Islam', 10, 5, '150000.00', 2, 'Ya', '2022-12-11 06:46:50', NULL, NULL, NULL),
(497, 1, 'P20221497', 'AprilYandi Dwi W497', '56419974497', '3276022304010010497', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243497', 'Kp.Babakan No. 497', 'Islam', 3, 11, '150000.00', 4, 'Ya', '2022-12-11 06:46:50', NULL, NULL, NULL),
(498, 2, 'P20222498', 'AprilYandi Dwi W498', '56419974498', '3276022304010010498', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243498', 'Kp.Babakan No. 498', 'Islam', 5, 1, '150000.00', 3, 'Ya', '2022-12-11 06:46:50', NULL, NULL, NULL),
(499, 1, 'P20221499', 'AprilYandi Dwi W499', '56419974499', '3276022304010010499', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243499', 'Kp.Babakan No. 499', 'Islam', 7, 5, '150000.00', 1, 'Ya', '2022-12-11 06:46:50', NULL, NULL, NULL),
(500, 1, 'P20221500', 'AprilYandi Dwi W500', '56419974500', '3276022304010010500', 'Semarang', '2001-04-15', 'Perempuan', '08810243500', 'Kp.Babakan No. 500', 'Islam', 12, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:50', NULL, NULL, NULL),
(501, 1, 'P20221501', 'AprilYandi Dwi W501', '56419974501', '3276022304010010501', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243501', 'Kp.Babakan No. 501', 'Islam', 8, 6, '150000.00', 3, 'Ya', '2022-12-11 06:46:51', NULL, NULL, NULL),
(502, 1, 'P20221502', 'AprilYandi Dwi W502', '56419974502', '3276022304010010502', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243502', 'Kp.Babakan No. 502', 'Islam', 12, 3, '150000.00', 4, 'Ya', '2022-12-11 06:46:51', NULL, NULL, NULL),
(503, 2, 'P20222503', 'AprilYandi Dwi W503', '56419974503', '3276022304010010503', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243503', 'Kp.Babakan No. 503', 'Islam', 4, 7, '150000.00', 3, 'Ya', '2022-12-11 06:46:51', NULL, NULL, NULL),
(504, 2, 'P20222504', 'AprilYandi Dwi W504', '56419974504', '3276022304010010504', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243504', 'Kp.Babakan No. 504', 'Islam', 7, 13, '150000.00', 4, 'Ya', '2022-12-11 06:46:51', NULL, NULL, NULL),
(505, 2, 'P20222505', 'AprilYandi Dwi W505', '56419974505', '3276022304010010505', 'Semarang', '2001-04-13', 'Perempuan', '08810243505', 'Kp.Babakan No. 505', 'Islam', 1, 2, '150000.00', 2, 'Ya', '2022-12-11 06:46:51', NULL, NULL, NULL),
(506, 3, 'P20223506', 'AprilYandi Dwi W506', '56419974506', '3276022304010010506', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243506', 'Kp.Babakan No. 506', 'Islam', 9, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:51', NULL, NULL, NULL),
(507, 3, 'P20223507', 'AprilYandi Dwi W507', '56419974507', '3276022304010010507', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243507', 'Kp.Babakan No. 507', 'Islam', 11, 2, NULL, NULL, 'Tidak', '2022-12-11 06:46:51', NULL, NULL, NULL),
(508, 3, 'P20223508', 'AprilYandi Dwi W508', '56419974508', '3276022304010010508', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243508', 'Kp.Babakan No. 508', 'Islam', 4, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:52', NULL, NULL, NULL),
(509, 1, 'P20221509', 'AprilYandi Dwi W509', '56419974509', '3276022304010010509', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243509', 'Kp.Babakan No. 509', 'Islam', 11, 11, '150000.00', 3, 'Ya', '2022-12-11 06:46:52', NULL, NULL, NULL),
(510, 2, 'P20222510', 'AprilYandi Dwi W510', '56419974510', '3276022304010010510', 'Semarang', '2001-04-01', 'Perempuan', '08810243510', 'Kp.Babakan No. 510', 'Islam', 9, 12, '150000.00', 4, 'Ya', '2022-12-11 06:46:52', NULL, NULL, NULL),
(511, 2, 'P20222511', 'AprilYandi Dwi W511', '56419974511', '3276022304010010511', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243511', 'Kp.Babakan No. 511', 'Islam', 4, 5, '150000.00', 3, 'Ya', '2022-12-11 06:46:52', NULL, NULL, NULL),
(512, 2, 'P20222512', 'AprilYandi Dwi W512', '56419974512', '3276022304010010512', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243512', 'Kp.Babakan No. 512', 'Islam', 10, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:52', NULL, NULL, NULL),
(513, 2, 'P20222513', 'AprilYandi Dwi W513', '56419974513', '3276022304010010513', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243513', 'Kp.Babakan No. 513', 'Islam', 4, 4, '150000.00', 3, 'Ya', '2022-12-11 06:46:52', NULL, NULL, NULL),
(514, 1, 'P20221514', 'AprilYandi Dwi W514', '56419974514', '3276022304010010514', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243514', 'Kp.Babakan No. 514', 'Islam', 13, 5, '150000.00', 4, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(515, 1, 'P20221515', 'AprilYandi Dwi W515', '56419974515', '3276022304010010515', 'Semarang', '2001-04-03', 'Perempuan', '08810243515', 'Kp.Babakan No. 515', 'Islam', 3, 6, '150000.00', 1, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(516, 3, 'P20223516', 'AprilYandi Dwi W516', '56419974516', '3276022304010010516', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243516', 'Kp.Babakan No. 516', 'Islam', 2, 4, NULL, NULL, 'Tidak', '2022-12-11 06:46:53', NULL, NULL, NULL),
(517, 1, 'P20221517', 'AprilYandi Dwi W517', '56419974517', '3276022304010010517', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243517', 'Kp.Babakan No. 517', 'Islam', 1, 8, '150000.00', 2, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(518, 2, 'P20222518', 'AprilYandi Dwi W518', '56419974518', '3276022304010010518', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243518', 'Kp.Babakan No. 518', 'Islam', 6, 3, '150000.00', 1, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(519, 2, 'P20222519', 'AprilYandi Dwi W519', '56419974519', '3276022304010010519', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243519', 'Kp.Babakan No. 519', 'Islam', 10, 8, '150000.00', 2, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(520, 1, 'P20221520', 'AprilYandi Dwi W520', '56419974520', '3276022304010010520', 'Semarang', '2001-04-05', 'Perempuan', '08810243520', 'Kp.Babakan No. 520', 'Islam', 7, 7, '150000.00', 4, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(521, 2, 'P20222521', 'AprilYandi Dwi W521', '56419974521', '3276022304010010521', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243521', 'Kp.Babakan No. 521', 'Islam', 11, 10, '150000.00', 4, 'Ya', '2022-12-11 06:46:53', NULL, NULL, NULL),
(522, 3, 'P20223522', 'AprilYandi Dwi W522', '56419974522', '3276022304010010522', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243522', 'Kp.Babakan No. 522', 'Islam', 13, 7, NULL, NULL, 'Tidak', '2022-12-11 06:46:53', NULL, NULL, NULL),
(523, 2, 'P20222523', 'AprilYandi Dwi W523', '56419974523', '3276022304010010523', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243523', 'Kp.Babakan No. 523', 'Islam', 10, 12, '150000.00', 2, 'Ya', '2022-12-11 06:46:54', NULL, NULL, NULL),
(524, 2, 'P20222524', 'AprilYandi Dwi W524', '56419974524', '3276022304010010524', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243524', 'Kp.Babakan No. 524', 'Islam', 11, 13, '150000.00', 2, 'Ya', '2022-12-11 06:46:54', NULL, NULL, NULL),
(525, 3, 'P20223525', 'AprilYandi Dwi W525', '56419974525', '3276022304010010525', 'Semarang', '2001-04-08', 'Perempuan', '08810243525', 'Kp.Babakan No. 525', 'Islam', 6, 3, NULL, NULL, 'Tidak', '2022-12-11 06:46:54', NULL, NULL, NULL),
(526, 1, 'P20221526', 'AprilYandi Dwi W526', '56419974526', '3276022304010010526', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243526', 'Kp.Babakan No. 526', 'Islam', 9, 6, '150000.00', 2, 'Ya', '2022-12-11 06:46:55', NULL, NULL, NULL),
(527, 1, 'P20221527', 'AprilYandi Dwi W527', '56419974527', '3276022304010010527', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243527', 'Kp.Babakan No. 527', 'Islam', 9, 4, '150000.00', 3, 'Ya', '2022-12-11 06:46:55', NULL, NULL, NULL),
(528, 2, 'P20222528', 'AprilYandi Dwi W528', '56419974528', '3276022304010010528', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243528', 'Kp.Babakan No. 528', 'Islam', 5, 2, '150000.00', 4, 'Ya', '2022-12-11 06:46:55', NULL, NULL, NULL),
(529, 3, 'P20223529', 'AprilYandi Dwi W529', '56419974529', '3276022304010010529', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243529', 'Kp.Babakan No. 529', 'Islam', 9, 10, NULL, NULL, 'Tidak', '2022-12-11 06:46:55', NULL, NULL, NULL),
(530, 2, 'P20222530', 'AprilYandi Dwi W530', '56419974530', '3276022304010010530', 'Semarang', '2001-04-19', 'Perempuan', '08810243530', 'Kp.Babakan No. 530', 'Islam', 10, 13, '150000.00', 3, 'Ya', '2022-12-11 06:46:55', NULL, NULL, NULL),
(531, 1, 'P20221531', 'AprilYandi Dwi W531', '56419974531', '3276022304010010531', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243531', 'Kp.Babakan No. 531', 'Islam', 5, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:55', NULL, NULL, NULL),
(532, 1, 'P20221532', 'AprilYandi Dwi W532', '56419974532', '3276022304010010532', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243532', 'Kp.Babakan No. 532', 'Islam', 12, 11, '150000.00', 1, 'Ya', '2022-12-11 06:46:56', NULL, NULL, NULL),
(533, 3, 'P20223533', 'AprilYandi Dwi W533', '56419974533', '3276022304010010533', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243533', 'Kp.Babakan No. 533', 'Islam', 2, 2, NULL, NULL, 'Tidak', '2022-12-11 06:46:56', NULL, NULL, NULL),
(534, 1, 'P20221534', 'AprilYandi Dwi W534', '56419974534', '3276022304010010534', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243534', 'Kp.Babakan No. 534', 'Islam', 3, 10, '150000.00', 1, 'Ya', '2022-12-11 06:46:56', NULL, NULL, NULL),
(535, 1, 'P20221535', 'AprilYandi Dwi W535', '56419974535', '3276022304010010535', 'Semarang', '2001-03-27', 'Perempuan', '08810243535', 'Kp.Babakan No. 535', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:46:56', NULL, NULL, NULL),
(536, 2, 'P20222536', 'AprilYandi Dwi W536', '56419974536', '3276022304010010536', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243536', 'Kp.Babakan No. 536', 'Islam', 10, 8, '150000.00', 4, 'Ya', '2022-12-11 06:46:56', NULL, NULL, NULL),
(537, 2, 'P20222537', 'AprilYandi Dwi W537', '56419974537', '3276022304010010537', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243537', 'Kp.Babakan No. 537', 'Islam', 7, 3, '150000.00', 1, 'Ya', '2022-12-11 06:46:56', NULL, NULL, NULL),
(538, 3, 'P20223538', 'AprilYandi Dwi W538', '56419974538', '3276022304010010538', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243538', 'Kp.Babakan No. 538', 'Islam', 6, 12, NULL, NULL, 'Tidak', '2022-12-11 06:46:56', NULL, NULL, NULL),
(539, 2, 'P20222539', 'AprilYandi Dwi W539', '56419974539', '3276022304010010539', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243539', 'Kp.Babakan No. 539', 'Islam', 2, 4, '150000.00', 3, 'Ya', '2022-12-11 06:46:57', NULL, NULL, NULL),
(540, 1, 'P20221540', 'AprilYandi Dwi W540', '56419974540', '3276022304010010540', 'Semarang', '2001-04-19', 'Perempuan', '08810243540', 'Kp.Babakan No. 540', 'Islam', 4, 5, '150000.00', 1, 'Ya', '2022-12-11 06:46:57', NULL, NULL, NULL),
(541, 3, 'P20223541', 'AprilYandi Dwi W541', '56419974541', '3276022304010010541', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243541', 'Kp.Babakan No. 541', 'Islam', 13, 7, NULL, NULL, 'Tidak', '2022-12-11 06:46:57', NULL, NULL, NULL),
(542, 2, 'P20222542', 'AprilYandi Dwi W542', '56419974542', '3276022304010010542', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243542', 'Kp.Babakan No. 542', 'Islam', 3, 6, '150000.00', 4, 'Ya', '2022-12-11 06:46:57', NULL, NULL, NULL),
(543, 1, 'P20221543', 'AprilYandi Dwi W543', '56419974543', '3276022304010010543', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243543', 'Kp.Babakan No. 543', 'Islam', 4, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:57', NULL, NULL, NULL),
(544, 2, 'P20222544', 'AprilYandi Dwi W544', '56419974544', '3276022304010010544', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243544', 'Kp.Babakan No. 544', 'Islam', 13, 10, '150000.00', 1, 'Ya', '2022-12-11 06:46:57', NULL, NULL, NULL),
(545, 3, 'P20223545', 'AprilYandi Dwi W545', '56419974545', '3276022304010010545', 'Semarang', '2001-04-10', 'Perempuan', '08810243545', 'Kp.Babakan No. 545', 'Islam', 8, 5, NULL, NULL, 'Tidak', '2022-12-11 06:46:57', NULL, NULL, NULL),
(546, 2, 'P20222546', 'AprilYandi Dwi W546', '56419974546', '3276022304010010546', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243546', 'Kp.Babakan No. 546', 'Islam', 9, 9, '150000.00', 2, 'Ya', '2022-12-11 06:46:58', NULL, NULL, NULL),
(547, 3, 'P20223547', 'AprilYandi Dwi W547', '56419974547', '3276022304010010547', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243547', 'Kp.Babakan No. 547', 'Islam', 2, 10, NULL, NULL, 'Tidak', '2022-12-11 06:46:58', NULL, NULL, NULL),
(548, 2, 'P20222548', 'AprilYandi Dwi W548', '56419974548', '3276022304010010548', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243548', 'Kp.Babakan No. 548', 'Islam', 3, 7, '150000.00', 2, 'Ya', '2022-12-11 06:46:58', NULL, NULL, NULL),
(549, 3, 'P20223549', 'AprilYandi Dwi W549', '56419974549', '3276022304010010549', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243549', 'Kp.Babakan No. 549', 'Islam', 11, 10, NULL, NULL, 'Tidak', '2022-12-11 06:46:58', NULL, NULL, NULL),
(550, 1, 'P20221550', 'AprilYandi Dwi W550', '56419974550', '3276022304010010550', 'Semarang', '2001-04-14', 'Perempuan', '08810243550', 'Kp.Babakan No. 550', 'Islam', 2, 10, '150000.00', 4, 'Ya', '2022-12-11 06:46:58', NULL, NULL, NULL),
(551, 1, 'P20221551', 'AprilYandi Dwi W551', '56419974551', '3276022304010010551', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243551', 'Kp.Babakan No. 551', 'Islam', 2, 2, '150000.00', 1, 'Ya', '2022-12-11 06:46:58', NULL, NULL, NULL),
(552, 3, 'P20223552', 'AprilYandi Dwi W552', '56419974552', '3276022304010010552', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243552', 'Kp.Babakan No. 552', 'Islam', 9, 11, NULL, NULL, 'Tidak', '2022-12-11 06:46:58', NULL, NULL, NULL),
(553, 3, 'P20223553', 'AprilYandi Dwi W553', '56419974553', '3276022304010010553', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243553', 'Kp.Babakan No. 553', 'Islam', 1, 6, NULL, NULL, 'Tidak', '2022-12-11 06:46:59', NULL, NULL, NULL),
(554, 2, 'P20222554', 'AprilYandi Dwi W554', '56419974554', '3276022304010010554', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243554', 'Kp.Babakan No. 554', 'Islam', 12, 2, '150000.00', 3, 'Ya', '2022-12-11 06:46:59', NULL, NULL, NULL),
(555, 2, 'P20222555', 'AprilYandi Dwi W555', '56419974555', '3276022304010010555', 'Semarang', '2001-04-13', 'Perempuan', '08810243555', 'Kp.Babakan No. 555', 'Islam', 11, 10, '150000.00', 2, 'Ya', '2022-12-11 06:46:59', NULL, NULL, NULL),
(556, 1, 'P20221556', 'AprilYandi Dwi W556', '56419974556', '3276022304010010556', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243556', 'Kp.Babakan No. 556', 'Islam', 4, 10, '150000.00', 1, 'Ya', '2022-12-11 06:46:59', NULL, NULL, NULL),
(557, 1, 'P20221557', 'AprilYandi Dwi W557', '56419974557', '3276022304010010557', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243557', 'Kp.Babakan No. 557', 'Islam', 3, 9, '150000.00', 3, 'Ya', '2022-12-11 06:46:59', NULL, NULL, NULL),
(558, 2, 'P20222558', 'AprilYandi Dwi W558', '56419974558', '3276022304010010558', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243558', 'Kp.Babakan No. 558', 'Islam', 8, 7, '150000.00', 2, 'Ya', '2022-12-11 06:46:59', NULL, NULL, NULL),
(559, 2, 'P20222559', 'AprilYandi Dwi W559', '56419974559', '3276022304010010559', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243559', 'Kp.Babakan No. 559', 'Islam', 7, 5, '150000.00', 2, 'Ya', '2022-12-11 06:46:59', NULL, NULL, NULL),
(560, 1, 'P20221560', 'AprilYandi Dwi W560', '56419974560', '3276022304010010560', 'Semarang', '2001-03-31', 'Perempuan', '08810243560', 'Kp.Babakan No. 560', 'Islam', 11, 12, '150000.00', 2, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(561, 1, 'P20221561', 'AprilYandi Dwi W561', '56419974561', '3276022304010010561', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243561', 'Kp.Babakan No. 561', 'Islam', 6, 4, '150000.00', 4, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(562, 2, 'P20222562', 'AprilYandi Dwi W562', '56419974562', '3276022304010010562', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243562', 'Kp.Babakan No. 562', 'Islam', 5, 6, '150000.00', 1, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(563, 1, 'P20221563', 'AprilYandi Dwi W563', '56419974563', '3276022304010010563', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243563', 'Kp.Babakan No. 563', 'Islam', 1, 13, '150000.00', 2, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(564, 3, 'P20223564', 'AprilYandi Dwi W564', '56419974564', '3276022304010010564', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243564', 'Kp.Babakan No. 564', 'Islam', 1, 5, NULL, NULL, 'Tidak', '2022-12-11 06:47:00', NULL, NULL, NULL),
(565, 2, 'P20222565', 'AprilYandi Dwi W565', '56419974565', '3276022304010010565', 'Semarang', '2001-04-06', 'Perempuan', '08810243565', 'Kp.Babakan No. 565', 'Islam', 1, 4, '150000.00', 4, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(566, 2, 'P20222566', 'AprilYandi Dwi W566', '56419974566', '3276022304010010566', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243566', 'Kp.Babakan No. 566', 'Islam', 5, 2, '150000.00', 2, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(567, 1, 'P20221567', 'AprilYandi Dwi W567', '56419974567', '3276022304010010567', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243567', 'Kp.Babakan No. 567', 'Islam', 4, 12, '150000.00', 2, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(568, 1, 'P20221568', 'AprilYandi Dwi W568', '56419974568', '3276022304010010568', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243568', 'Kp.Babakan No. 568', 'Islam', 3, 11, '150000.00', 3, 'Ya', '2022-12-11 06:47:00', NULL, NULL, NULL),
(569, 3, 'P20223569', 'AprilYandi Dwi W569', '56419974569', '3276022304010010569', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243569', 'Kp.Babakan No. 569', 'Islam', 5, 10, NULL, NULL, 'Tidak', '2022-12-11 06:47:01', NULL, NULL, NULL),
(570, 2, 'P20222570', 'AprilYandi Dwi W570', '56419974570', '3276022304010010570', 'Semarang', '2001-04-11', 'Perempuan', '08810243570', 'Kp.Babakan No. 570', 'Islam', 11, 12, '150000.00', 4, 'Ya', '2022-12-11 06:47:01', NULL, NULL, NULL),
(571, 2, 'P20222571', 'AprilYandi Dwi W571', '56419974571', '3276022304010010571', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243571', 'Kp.Babakan No. 571', 'Islam', 1, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:01', NULL, NULL, NULL),
(572, 2, 'P20222572', 'AprilYandi Dwi W572', '56419974572', '3276022304010010572', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243572', 'Kp.Babakan No. 572', 'Islam', 5, 8, '150000.00', 2, 'Ya', '2022-12-11 06:47:01', NULL, NULL, NULL),
(573, 1, 'P20221573', 'AprilYandi Dwi W573', '56419974573', '3276022304010010573', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243573', 'Kp.Babakan No. 573', 'Islam', 7, 8, '150000.00', 4, 'Ya', '2022-12-11 06:47:01', NULL, NULL, NULL),
(574, 2, 'P20222574', 'AprilYandi Dwi W574', '56419974574', '3276022304010010574', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243574', 'Kp.Babakan No. 574', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:47:01', NULL, NULL, NULL),
(575, 3, 'P20223575', 'AprilYandi Dwi W575', '56419974575', '3276022304010010575', 'Semarang', '2001-03-28', 'Perempuan', '08810243575', 'Kp.Babakan No. 575', 'Islam', 13, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:02', NULL, NULL, NULL),
(576, 2, 'P20222576', 'AprilYandi Dwi W576', '56419974576', '3276022304010010576', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243576', 'Kp.Babakan No. 576', 'Islam', 9, 5, '150000.00', 1, 'Ya', '2022-12-11 06:47:02', NULL, NULL, NULL),
(577, 1, 'P20221577', 'AprilYandi Dwi W577', '56419974577', '3276022304010010577', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243577', 'Kp.Babakan No. 577', 'Islam', 3, 7, '150000.00', 2, 'Ya', '2022-12-11 06:47:02', NULL, NULL, NULL),
(578, 2, 'P20222578', 'AprilYandi Dwi W578', '56419974578', '3276022304010010578', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243578', 'Kp.Babakan No. 578', 'Islam', 7, 9, '150000.00', 2, 'Ya', '2022-12-11 06:47:03', NULL, NULL, NULL),
(579, 2, 'P20222579', 'AprilYandi Dwi W579', '56419974579', '3276022304010010579', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243579', 'Kp.Babakan No. 579', 'Islam', 7, 6, '150000.00', 3, 'Ya', '2022-12-11 06:47:03', NULL, NULL, NULL),
(580, 3, 'P20223580', 'AprilYandi Dwi W580', '56419974580', '3276022304010010580', 'Semarang', '2001-03-27', 'Perempuan', '08810243580', 'Kp.Babakan No. 580', 'Islam', 13, 13, NULL, NULL, 'Tidak', '2022-12-11 06:47:03', NULL, NULL, NULL),
(581, 3, 'P20223581', 'AprilYandi Dwi W581', '56419974581', '3276022304010010581', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243581', 'Kp.Babakan No. 581', 'Islam', 12, 3, NULL, NULL, 'Tidak', '2022-12-11 06:47:04', NULL, NULL, NULL),
(582, 1, 'P20221582', 'AprilYandi Dwi W582', '56419974582', '3276022304010010582', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243582', 'Kp.Babakan No. 582', 'Islam', 9, 7, '150000.00', 1, 'Ya', '2022-12-11 06:47:05', NULL, NULL, NULL),
(583, 1, 'P20221583', 'AprilYandi Dwi W583', '56419974583', '3276022304010010583', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243583', 'Kp.Babakan No. 583', 'Islam', 8, 3, '150000.00', 4, 'Ya', '2022-12-11 06:47:05', NULL, NULL, NULL),
(584, 2, 'P20222584', 'AprilYandi Dwi W584', '56419974584', '3276022304010010584', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243584', 'Kp.Babakan No. 584', 'Islam', 9, 11, '150000.00', 3, 'Ya', '2022-12-11 06:47:05', NULL, NULL, NULL),
(585, 1, 'P20221585', 'AprilYandi Dwi W585', '56419974585', '3276022304010010585', 'Semarang', '2001-04-16', 'Perempuan', '08810243585', 'Kp.Babakan No. 585', 'Islam', 7, 10, '150000.00', 4, 'Ya', '2022-12-11 06:47:05', NULL, NULL, NULL),
(586, 1, 'P20221586', 'AprilYandi Dwi W586', '56419974586', '3276022304010010586', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243586', 'Kp.Babakan No. 586', 'Islam', 4, 12, '150000.00', 1, 'Ya', '2022-12-11 06:47:05', NULL, NULL, NULL),
(587, 2, 'P20222587', 'AprilYandi Dwi W587', '56419974587', '3276022304010010587', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243587', 'Kp.Babakan No. 587', 'Islam', 4, 10, '150000.00', 4, 'Ya', '2022-12-11 06:47:06', NULL, NULL, NULL),
(588, 2, 'P20222588', 'AprilYandi Dwi W588', '56419974588', '3276022304010010588', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243588', 'Kp.Babakan No. 588', 'Islam', 13, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:06', NULL, NULL, NULL),
(589, 1, 'P20221589', 'AprilYandi Dwi W589', '56419974589', '3276022304010010589', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243589', 'Kp.Babakan No. 589', 'Islam', 1, 13, '150000.00', 2, 'Ya', '2022-12-11 06:47:06', NULL, NULL, NULL),
(590, 1, 'P20221590', 'AprilYandi Dwi W590', '56419974590', '3276022304010010590', 'Semarang', '2001-04-21', 'Perempuan', '08810243590', 'Kp.Babakan No. 590', 'Islam', 11, 10, '150000.00', 4, 'Ya', '2022-12-11 06:47:06', NULL, NULL, NULL),
(591, 1, 'P20221591', 'AprilYandi Dwi W591', '56419974591', '3276022304010010591', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243591', 'Kp.Babakan No. 591', 'Islam', 9, 2, '150000.00', 2, 'Ya', '2022-12-11 06:47:06', NULL, NULL, NULL),
(592, 3, 'P20223592', 'AprilYandi Dwi W592', '56419974592', '3276022304010010592', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243592', 'Kp.Babakan No. 592', 'Islam', 10, 7, NULL, NULL, 'Tidak', '2022-12-11 06:47:07', NULL, NULL, NULL),
(593, 2, 'P20222593', 'AprilYandi Dwi W593', '56419974593', '3276022304010010593', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243593', 'Kp.Babakan No. 593', 'Islam', 3, 10, '150000.00', 4, 'Ya', '2022-12-11 06:47:07', NULL, NULL, NULL),
(594, 2, 'P20222594', 'AprilYandi Dwi W594', '56419974594', '3276022304010010594', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243594', 'Kp.Babakan No. 594', 'Islam', 6, 7, '150000.00', 4, 'Ya', '2022-12-11 06:47:07', NULL, NULL, NULL),
(595, 2, 'P20222595', 'AprilYandi Dwi W595', '56419974595', '3276022304010010595', 'Semarang', '2001-04-20', 'Perempuan', '08810243595', 'Kp.Babakan No. 595', 'Islam', 7, 13, '150000.00', 1, 'Ya', '2022-12-11 06:47:07', NULL, NULL, NULL),
(596, 3, 'P20223596', 'AprilYandi Dwi W596', '56419974596', '3276022304010010596', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243596', 'Kp.Babakan No. 596', 'Islam', 8, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:07', NULL, NULL, NULL),
(597, 3, 'P20223597', 'AprilYandi Dwi W597', '56419974597', '3276022304010010597', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243597', 'Kp.Babakan No. 597', 'Islam', 10, 10, NULL, NULL, 'Tidak', '2022-12-11 06:47:08', NULL, NULL, NULL),
(598, 1, 'P20221598', 'AprilYandi Dwi W598', '56419974598', '3276022304010010598', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243598', 'Kp.Babakan No. 598', 'Islam', 10, 3, '150000.00', 3, 'Ya', '2022-12-11 06:47:08', NULL, NULL, NULL),
(599, 1, 'P20221599', 'AprilYandi Dwi W599', '56419974599', '3276022304010010599', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243599', 'Kp.Babakan No. 599', 'Islam', 4, 2, '150000.00', 3, 'Ya', '2022-12-11 06:47:08', NULL, NULL, NULL),
(600, 2, 'P20222600', 'AprilYandi Dwi W600', '56419974600', '3276022304010010600', 'Semarang', '2001-04-09', 'Perempuan', '08810243600', 'Kp.Babakan No. 600', 'Islam', 5, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:08', NULL, NULL, NULL),
(601, 3, 'P20223601', 'AprilYandi Dwi W601', '56419974601', '3276022304010010601', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243601', 'Kp.Babakan No. 601', 'Islam', 5, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:08', NULL, NULL, NULL),
(602, 2, 'P20222602', 'AprilYandi Dwi W602', '56419974602', '3276022304010010602', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243602', 'Kp.Babakan No. 602', 'Islam', 9, 9, '150000.00', 3, 'Ya', '2022-12-11 06:47:09', NULL, NULL, NULL),
(603, 1, 'P20221603', 'AprilYandi Dwi W603', '56419974603', '3276022304010010603', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243603', 'Kp.Babakan No. 603', 'Islam', 2, 11, '150000.00', 3, 'Ya', '2022-12-11 06:47:09', NULL, NULL, NULL),
(604, 3, 'P20223604', 'AprilYandi Dwi W604', '56419974604', '3276022304010010604', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243604', 'Kp.Babakan No. 604', 'Islam', 6, 2, NULL, NULL, 'Tidak', '2022-12-11 06:47:09', NULL, NULL, NULL),
(605, 3, 'P20223605', 'AprilYandi Dwi W605', '56419974605', '3276022304010010605', 'Semarang', '2001-04-10', 'Perempuan', '08810243605', 'Kp.Babakan No. 605', 'Islam', 10, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:09', NULL, NULL, NULL),
(606, 3, 'P20223606', 'AprilYandi Dwi W606', '56419974606', '3276022304010010606', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243606', 'Kp.Babakan No. 606', 'Islam', 8, 7, NULL, NULL, 'Tidak', '2022-12-11 06:47:10', NULL, NULL, NULL),
(607, 3, 'P20223607', 'AprilYandi Dwi W607', '56419974607', '3276022304010010607', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243607', 'Kp.Babakan No. 607', 'Islam', 13, 9, NULL, NULL, 'Tidak', '2022-12-11 06:47:10', NULL, NULL, NULL),
(608, 2, 'P20222608', 'AprilYandi Dwi W608', '56419974608', '3276022304010010608', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243608', 'Kp.Babakan No. 608', 'Islam', 5, 5, '150000.00', 4, 'Ya', '2022-12-11 06:47:10', NULL, NULL, NULL),
(609, 3, 'P20223609', 'AprilYandi Dwi W609', '56419974609', '3276022304010010609', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243609', 'Kp.Babakan No. 609', 'Islam', 5, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:10', NULL, NULL, NULL),
(610, 2, 'P20222610', 'AprilYandi Dwi W610', '56419974610', '3276022304010010610', 'Semarang', '2001-04-16', 'Perempuan', '08810243610', 'Kp.Babakan No. 610', 'Islam', 12, 8, '150000.00', 1, 'Ya', '2022-12-11 06:47:11', NULL, NULL, NULL),
(611, 3, 'P20223611', 'AprilYandi Dwi W611', '56419974611', '3276022304010010611', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243611', 'Kp.Babakan No. 611', 'Islam', 8, 6, NULL, NULL, 'Tidak', '2022-12-11 06:47:11', NULL, NULL, NULL),
(612, 2, 'P20222612', 'AprilYandi Dwi W612', '56419974612', '3276022304010010612', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243612', 'Kp.Babakan No. 612', 'Islam', 5, 7, '150000.00', 3, 'Ya', '2022-12-11 06:47:11', NULL, NULL, NULL),
(613, 2, 'P20222613', 'AprilYandi Dwi W613', '56419974613', '3276022304010010613', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243613', 'Kp.Babakan No. 613', 'Islam', 13, 7, '150000.00', 4, 'Ya', '2022-12-11 06:47:11', NULL, NULL, NULL),
(614, 1, 'P20221614', 'AprilYandi Dwi W614', '56419974614', '3276022304010010614', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243614', 'Kp.Babakan No. 614', 'Islam', 9, 8, '150000.00', 3, 'Ya', '2022-12-11 06:47:11', NULL, NULL, NULL),
(615, 2, 'P20222615', 'AprilYandi Dwi W615', '56419974615', '3276022304010010615', 'Semarang', '2001-04-23', 'Perempuan', '08810243615', 'Kp.Babakan No. 615', 'Islam', 7, 13, '150000.00', 3, 'Ya', '2022-12-11 06:47:11', NULL, NULL, NULL),
(616, 3, 'P20223616', 'AprilYandi Dwi W616', '56419974616', '3276022304010010616', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243616', 'Kp.Babakan No. 616', 'Islam', 9, 13, NULL, NULL, 'Tidak', '2022-12-11 06:47:12', NULL, NULL, NULL),
(617, 3, 'P20223617', 'AprilYandi Dwi W617', '56419974617', '3276022304010010617', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243617', 'Kp.Babakan No. 617', 'Islam', 10, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:12', NULL, NULL, NULL),
(618, 2, 'P20222618', 'AprilYandi Dwi W618', '56419974618', '3276022304010010618', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243618', 'Kp.Babakan No. 618', 'Islam', 13, 6, '150000.00', 1, 'Ya', '2022-12-11 06:47:12', NULL, NULL, NULL),
(619, 1, 'P20221619', 'AprilYandi Dwi W619', '56419974619', '3276022304010010619', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243619', 'Kp.Babakan No. 619', 'Islam', 6, 3, '150000.00', 2, 'Ya', '2022-12-11 06:47:12', NULL, NULL, NULL),
(620, 1, 'P20221620', 'AprilYandi Dwi W620', '56419974620', '3276022304010010620', 'Semarang', '2001-03-27', 'Perempuan', '08810243620', 'Kp.Babakan No. 620', 'Islam', 6, 1, '150000.00', 4, 'Ya', '2022-12-11 06:47:12', NULL, NULL, NULL),
(621, 1, 'P20221621', 'AprilYandi Dwi W621', '56419974621', '3276022304010010621', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243621', 'Kp.Babakan No. 621', 'Islam', 3, 13, '150000.00', 4, 'Ya', '2022-12-11 06:47:12', NULL, NULL, NULL),
(622, 1, 'P20221622', 'AprilYandi Dwi W622', '56419974622', '3276022304010010622', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243622', 'Kp.Babakan No. 622', 'Islam', 5, 13, '150000.00', 3, 'Ya', '2022-12-11 06:47:13', NULL, NULL, NULL),
(623, 2, 'P20222623', 'AprilYandi Dwi W623', '56419974623', '3276022304010010623', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243623', 'Kp.Babakan No. 623', 'Islam', 2, 10, '150000.00', 1, 'Ya', '2022-12-11 06:47:13', NULL, NULL, NULL),
(624, 1, 'P20221624', 'AprilYandi Dwi W624', '56419974624', '3276022304010010624', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243624', 'Kp.Babakan No. 624', 'Islam', 13, 11, '150000.00', 1, 'Ya', '2022-12-11 06:47:14', NULL, NULL, NULL),
(625, 3, 'P20223625', 'AprilYandi Dwi W625', '56419974625', '3276022304010010625', 'Semarang', '2001-04-15', 'Perempuan', '08810243625', 'Kp.Babakan No. 625', 'Islam', 12, 3, NULL, NULL, 'Tidak', '2022-12-11 06:47:14', NULL, NULL, NULL),
(626, 3, 'P20223626', 'AprilYandi Dwi W626', '56419974626', '3276022304010010626', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243626', 'Kp.Babakan No. 626', 'Islam', 5, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:15', NULL, NULL, NULL),
(627, 3, 'P20223627', 'AprilYandi Dwi W627', '56419974627', '3276022304010010627', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243627', 'Kp.Babakan No. 627', 'Islam', 7, 6, NULL, NULL, 'Tidak', '2022-12-11 06:47:15', NULL, NULL, NULL),
(628, 1, 'P20221628', 'AprilYandi Dwi W628', '56419974628', '3276022304010010628', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243628', 'Kp.Babakan No. 628', 'Islam', 12, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:15', NULL, NULL, NULL),
(629, 2, 'P20222629', 'AprilYandi Dwi W629', '56419974629', '3276022304010010629', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243629', 'Kp.Babakan No. 629', 'Islam', 4, 5, '150000.00', 2, 'Ya', '2022-12-11 06:47:15', NULL, NULL, NULL),
(630, 3, 'P20223630', 'AprilYandi Dwi W630', '56419974630', '3276022304010010630', 'Semarang', '2001-04-18', 'Perempuan', '08810243630', 'Kp.Babakan No. 630', 'Islam', 12, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:16', NULL, NULL, NULL),
(631, 1, 'P20221631', 'AprilYandi Dwi W631', '56419974631', '3276022304010010631', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243631', 'Kp.Babakan No. 631', 'Islam', 7, 13, '150000.00', 2, 'Ya', '2022-12-11 06:47:16', NULL, NULL, NULL),
(632, 3, 'P20223632', 'AprilYandi Dwi W632', '56419974632', '3276022304010010632', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243632', 'Kp.Babakan No. 632', 'Islam', 13, 3, NULL, NULL, 'Tidak', '2022-12-11 06:47:16', NULL, NULL, NULL),
(633, 1, 'P20221633', 'AprilYandi Dwi W633', '56419974633', '3276022304010010633', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243633', 'Kp.Babakan No. 633', 'Islam', 8, 4, '150000.00', 3, 'Ya', '2022-12-11 06:47:17', NULL, NULL, NULL),
(634, 2, 'P20222634', 'AprilYandi Dwi W634', '56419974634', '3276022304010010634', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243634', 'Kp.Babakan No. 634', 'Islam', 3, 13, '150000.00', 2, 'Ya', '2022-12-11 06:47:17', NULL, NULL, NULL),
(635, 2, 'P20222635', 'AprilYandi Dwi W635', '56419974635', '3276022304010010635', 'Semarang', '2001-04-03', 'Perempuan', '08810243635', 'Kp.Babakan No. 635', 'Islam', 6, 10, '150000.00', 4, 'Ya', '2022-12-11 06:47:17', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(636, 1, 'P20221636', 'AprilYandi Dwi W636', '56419974636', '3276022304010010636', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243636', 'Kp.Babakan No. 636', 'Islam', 13, 11, '150000.00', 3, 'Ya', '2022-12-11 06:47:17', NULL, NULL, NULL),
(637, 1, 'P20221637', 'AprilYandi Dwi W637', '56419974637', '3276022304010010637', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243637', 'Kp.Babakan No. 637', 'Islam', 8, 4, '150000.00', 2, 'Ya', '2022-12-11 06:47:17', NULL, NULL, NULL),
(638, 2, 'P20222638', 'AprilYandi Dwi W638', '56419974638', '3276022304010010638', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243638', 'Kp.Babakan No. 638', 'Islam', 11, 2, '150000.00', 4, 'Ya', '2022-12-11 06:47:17', NULL, NULL, NULL),
(639, 3, 'P20223639', 'AprilYandi Dwi W639', '56419974639', '3276022304010010639', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243639', 'Kp.Babakan No. 639', 'Islam', 12, 9, NULL, NULL, 'Tidak', '2022-12-11 06:47:17', NULL, NULL, NULL),
(640, 3, 'P20223640', 'AprilYandi Dwi W640', '56419974640', '3276022304010010640', 'Semarang', '2001-04-06', 'Perempuan', '08810243640', 'Kp.Babakan No. 640', 'Islam', 8, 9, NULL, NULL, 'Tidak', '2022-12-11 06:47:18', NULL, NULL, NULL),
(641, 3, 'P20223641', 'AprilYandi Dwi W641', '56419974641', '3276022304010010641', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243641', 'Kp.Babakan No. 641', 'Islam', 1, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:18', NULL, NULL, NULL),
(642, 1, 'P20221642', 'AprilYandi Dwi W642', '56419974642', '3276022304010010642', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243642', 'Kp.Babakan No. 642', 'Islam', 6, 2, '150000.00', 4, 'Ya', '2022-12-11 06:47:18', NULL, NULL, NULL),
(643, 3, 'P20223643', 'AprilYandi Dwi W643', '56419974643', '3276022304010010643', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243643', 'Kp.Babakan No. 643', 'Islam', 9, 2, NULL, NULL, 'Tidak', '2022-12-11 06:47:18', NULL, NULL, NULL),
(644, 1, 'P20221644', 'AprilYandi Dwi W644', '56419974644', '3276022304010010644', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243644', 'Kp.Babakan No. 644', 'Islam', 11, 2, '150000.00', 3, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(645, 1, 'P20221645', 'AprilYandi Dwi W645', '56419974645', '3276022304010010645', 'Semarang', '2001-04-07', 'Perempuan', '08810243645', 'Kp.Babakan No. 645', 'Islam', 6, 4, '150000.00', 2, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(646, 1, 'P20221646', 'AprilYandi Dwi W646', '56419974646', '3276022304010010646', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243646', 'Kp.Babakan No. 646', 'Islam', 7, 6, '150000.00', 3, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(647, 2, 'P20222647', 'AprilYandi Dwi W647', '56419974647', '3276022304010010647', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243647', 'Kp.Babakan No. 647', 'Islam', 6, 6, '150000.00', 1, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(648, 2, 'P20222648', 'AprilYandi Dwi W648', '56419974648', '3276022304010010648', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243648', 'Kp.Babakan No. 648', 'Islam', 10, 6, '150000.00', 3, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(649, 2, 'P20222649', 'AprilYandi Dwi W649', '56419974649', '3276022304010010649', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243649', 'Kp.Babakan No. 649', 'Islam', 10, 9, '150000.00', 2, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(650, 2, 'P20222650', 'AprilYandi Dwi W650', '56419974650', '3276022304010010650', 'Semarang', '2001-04-16', 'Perempuan', '08810243650', 'Kp.Babakan No. 650', 'Islam', 2, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:19', NULL, NULL, NULL),
(651, 2, 'P20222651', 'AprilYandi Dwi W651', '56419974651', '3276022304010010651', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243651', 'Kp.Babakan No. 651', 'Islam', 8, 5, '150000.00', 4, 'Ya', '2022-12-11 06:47:20', NULL, NULL, NULL),
(652, 1, 'P20221652', 'AprilYandi Dwi W652', '56419974652', '3276022304010010652', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243652', 'Kp.Babakan No. 652', 'Islam', 11, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:20', NULL, NULL, NULL),
(653, 1, 'P20221653', 'AprilYandi Dwi W653', '56419974653', '3276022304010010653', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243653', 'Kp.Babakan No. 653', 'Islam', 6, 9, '150000.00', 3, 'Ya', '2022-12-11 06:47:20', NULL, NULL, NULL),
(654, 2, 'P20222654', 'AprilYandi Dwi W654', '56419974654', '3276022304010010654', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243654', 'Kp.Babakan No. 654', 'Islam', 11, 2, '150000.00', 3, 'Ya', '2022-12-11 06:47:20', NULL, NULL, NULL),
(655, 2, 'P20222655', 'AprilYandi Dwi W655', '56419974655', '3276022304010010655', 'Semarang', '2001-04-21', 'Perempuan', '08810243655', 'Kp.Babakan No. 655', 'Islam', 11, 2, '150000.00', 4, 'Ya', '2022-12-11 06:47:20', NULL, NULL, NULL),
(656, 2, 'P20222656', 'AprilYandi Dwi W656', '56419974656', '3276022304010010656', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243656', 'Kp.Babakan No. 656', 'Islam', 7, 6, '150000.00', 1, 'Ya', '2022-12-11 06:47:20', NULL, NULL, NULL),
(657, 3, 'P20223657', 'AprilYandi Dwi W657', '56419974657', '3276022304010010657', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243657', 'Kp.Babakan No. 657', 'Islam', 8, 6, NULL, NULL, 'Tidak', '2022-12-11 06:47:20', NULL, NULL, NULL),
(658, 3, 'P20223658', 'AprilYandi Dwi W658', '56419974658', '3276022304010010658', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243658', 'Kp.Babakan No. 658', 'Islam', 1, 2, NULL, NULL, 'Tidak', '2022-12-11 06:47:21', NULL, NULL, NULL),
(659, 2, 'P20222659', 'AprilYandi Dwi W659', '56419974659', '3276022304010010659', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243659', 'Kp.Babakan No. 659', 'Islam', 1, 3, '150000.00', 4, 'Ya', '2022-12-11 06:47:21', NULL, NULL, NULL),
(660, 3, 'P20223660', 'AprilYandi Dwi W660', '56419974660', '3276022304010010660', 'Semarang', '2001-04-07', 'Perempuan', '08810243660', 'Kp.Babakan No. 660', 'Islam', 4, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:22', NULL, NULL, NULL),
(661, 1, 'P20221661', 'AprilYandi Dwi W661', '56419974661', '3276022304010010661', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243661', 'Kp.Babakan No. 661', 'Islam', 1, 8, '150000.00', 4, 'Ya', '2022-12-11 06:47:22', NULL, NULL, NULL),
(662, 3, 'P20223662', 'AprilYandi Dwi W662', '56419974662', '3276022304010010662', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243662', 'Kp.Babakan No. 662', 'Islam', 12, 11, NULL, NULL, 'Tidak', '2022-12-11 06:47:22', NULL, NULL, NULL),
(663, 2, 'P20222663', 'AprilYandi Dwi W663', '56419974663', '3276022304010010663', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243663', 'Kp.Babakan No. 663', 'Islam', 10, 7, '150000.00', 1, 'Ya', '2022-12-11 06:47:22', NULL, NULL, NULL),
(664, 1, 'P20221664', 'AprilYandi Dwi W664', '56419974664', '3276022304010010664', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243664', 'Kp.Babakan No. 664', 'Islam', 3, 10, '150000.00', 3, 'Ya', '2022-12-11 06:47:23', NULL, NULL, NULL),
(665, 2, 'P20222665', 'AprilYandi Dwi W665', '56419974665', '3276022304010010665', 'Semarang', '2001-04-13', 'Perempuan', '08810243665', 'Kp.Babakan No. 665', 'Islam', 9, 3, '150000.00', 1, 'Ya', '2022-12-11 06:47:23', NULL, NULL, NULL),
(666, 1, 'P20221666', 'AprilYandi Dwi W666', '56419974666', '3276022304010010666', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243666', 'Kp.Babakan No. 666', 'Islam', 6, 11, '150000.00', 4, 'Ya', '2022-12-11 06:47:23', NULL, NULL, NULL),
(667, 1, 'P20221667', 'AprilYandi Dwi W667', '56419974667', '3276022304010010667', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243667', 'Kp.Babakan No. 667', 'Islam', 11, 4, '150000.00', 1, 'Ya', '2022-12-11 06:47:23', NULL, NULL, NULL),
(668, 3, 'P20223668', 'AprilYandi Dwi W668', '56419974668', '3276022304010010668', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243668', 'Kp.Babakan No. 668', 'Islam', 4, 7, NULL, NULL, 'Tidak', '2022-12-11 06:47:23', NULL, NULL, NULL),
(669, 1, 'P20221669', 'AprilYandi Dwi W669', '56419974669', '3276022304010010669', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243669', 'Kp.Babakan No. 669', 'Islam', 2, 12, '150000.00', 4, 'Ya', '2022-12-11 06:47:23', NULL, NULL, NULL),
(670, 3, 'P20223670', 'AprilYandi Dwi W670', '56419974670', '3276022304010010670', 'Semarang', '2001-04-03', 'Perempuan', '08810243670', 'Kp.Babakan No. 670', 'Islam', 6, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:23', NULL, NULL, NULL),
(671, 3, 'P20223671', 'AprilYandi Dwi W671', '56419974671', '3276022304010010671', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243671', 'Kp.Babakan No. 671', 'Islam', 3, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:24', NULL, NULL, NULL),
(672, 2, 'P20222672', 'AprilYandi Dwi W672', '56419974672', '3276022304010010672', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243672', 'Kp.Babakan No. 672', 'Islam', 6, 3, '150000.00', 2, 'Ya', '2022-12-11 06:47:24', NULL, NULL, NULL),
(673, 2, 'P20222673', 'AprilYandi Dwi W673', '56419974673', '3276022304010010673', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243673', 'Kp.Babakan No. 673', 'Islam', 12, 11, '150000.00', 3, 'Ya', '2022-12-11 06:47:24', NULL, NULL, NULL),
(674, 3, 'P20223674', 'AprilYandi Dwi W674', '56419974674', '3276022304010010674', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243674', 'Kp.Babakan No. 674', 'Islam', 8, 10, NULL, NULL, 'Tidak', '2022-12-11 06:47:24', NULL, NULL, NULL),
(675, 2, 'P20222675', 'AprilYandi Dwi W675', '56419974675', '3276022304010010675', 'Semarang', '2001-04-07', 'Perempuan', '08810243675', 'Kp.Babakan No. 675', 'Islam', 6, 11, '150000.00', 3, 'Ya', '2022-12-11 06:47:24', NULL, NULL, NULL),
(676, 1, 'P20221676', 'AprilYandi Dwi W676', '56419974676', '3276022304010010676', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243676', 'Kp.Babakan No. 676', 'Islam', 7, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:24', NULL, NULL, NULL),
(677, 3, 'P20223677', 'AprilYandi Dwi W677', '56419974677', '3276022304010010677', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243677', 'Kp.Babakan No. 677', 'Islam', 4, 3, NULL, NULL, 'Tidak', '2022-12-11 06:47:24', NULL, NULL, NULL),
(678, 1, 'P20221678', 'AprilYandi Dwi W678', '56419974678', '3276022304010010678', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243678', 'Kp.Babakan No. 678', 'Islam', 12, 1, '150000.00', 3, 'Ya', '2022-12-11 06:47:25', NULL, NULL, NULL),
(679, 3, 'P20223679', 'AprilYandi Dwi W679', '56419974679', '3276022304010010679', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243679', 'Kp.Babakan No. 679', 'Islam', 11, 10, NULL, NULL, 'Tidak', '2022-12-11 06:47:25', NULL, NULL, NULL),
(680, 3, 'P20223680', 'AprilYandi Dwi W680', '56419974680', '3276022304010010680', 'Semarang', '2001-04-15', 'Perempuan', '08810243680', 'Kp.Babakan No. 680', 'Islam', 13, 8, NULL, NULL, 'Tidak', '2022-12-11 06:47:25', NULL, NULL, NULL),
(681, 3, 'P20223681', 'AprilYandi Dwi W681', '56419974681', '3276022304010010681', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243681', 'Kp.Babakan No. 681', 'Islam', 6, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:26', NULL, NULL, NULL),
(682, 1, 'P20221682', 'AprilYandi Dwi W682', '56419974682', '3276022304010010682', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243682', 'Kp.Babakan No. 682', 'Islam', 2, 13, '150000.00', 3, 'Ya', '2022-12-11 06:47:26', NULL, NULL, NULL),
(683, 2, 'P20222683', 'AprilYandi Dwi W683', '56419974683', '3276022304010010683', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243683', 'Kp.Babakan No. 683', 'Islam', 11, 12, '150000.00', 4, 'Ya', '2022-12-11 06:47:26', NULL, NULL, NULL),
(684, 1, 'P20221684', 'AprilYandi Dwi W684', '56419974684', '3276022304010010684', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243684', 'Kp.Babakan No. 684', 'Islam', 4, 12, '150000.00', 2, 'Ya', '2022-12-11 06:47:26', NULL, NULL, NULL),
(685, 3, 'P20223685', 'AprilYandi Dwi W685', '56419974685', '3276022304010010685', 'Semarang', '2001-03-31', 'Perempuan', '08810243685', 'Kp.Babakan No. 685', 'Islam', 5, 5, NULL, NULL, 'Tidak', '2022-12-11 06:47:26', NULL, NULL, NULL),
(686, 1, 'P20221686', 'AprilYandi Dwi W686', '56419974686', '3276022304010010686', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243686', 'Kp.Babakan No. 686', 'Islam', 6, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:26', NULL, NULL, NULL),
(687, 2, 'P20222687', 'AprilYandi Dwi W687', '56419974687', '3276022304010010687', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243687', 'Kp.Babakan No. 687', 'Islam', 5, 4, '150000.00', 3, 'Ya', '2022-12-11 06:47:26', NULL, NULL, NULL),
(688, 1, 'P20221688', 'AprilYandi Dwi W688', '56419974688', '3276022304010010688', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243688', 'Kp.Babakan No. 688', 'Islam', 2, 7, '150000.00', 2, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(689, 1, 'P20221689', 'AprilYandi Dwi W689', '56419974689', '3276022304010010689', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243689', 'Kp.Babakan No. 689', 'Islam', 7, 7, '150000.00', 4, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(690, 1, 'P20221690', 'AprilYandi Dwi W690', '56419974690', '3276022304010010690', 'Semarang', '2001-04-20', 'Perempuan', '08810243690', 'Kp.Babakan No. 690', 'Islam', 8, 2, '150000.00', 1, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(691, 1, 'P20221691', 'AprilYandi Dwi W691', '56419974691', '3276022304010010691', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243691', 'Kp.Babakan No. 691', 'Islam', 1, 3, '150000.00', 3, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(692, 2, 'P20222692', 'AprilYandi Dwi W692', '56419974692', '3276022304010010692', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243692', 'Kp.Babakan No. 692', 'Islam', 12, 5, '150000.00', 2, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(693, 2, 'P20222693', 'AprilYandi Dwi W693', '56419974693', '3276022304010010693', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243693', 'Kp.Babakan No. 693', 'Islam', 7, 13, '150000.00', 2, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(694, 1, 'P20221694', 'AprilYandi Dwi W694', '56419974694', '3276022304010010694', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243694', 'Kp.Babakan No. 694', 'Islam', 13, 3, '150000.00', 3, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(695, 1, 'P20221695', 'AprilYandi Dwi W695', '56419974695', '3276022304010010695', 'Semarang', '2001-04-15', 'Perempuan', '08810243695', 'Kp.Babakan No. 695', 'Islam', 12, 4, '150000.00', 1, 'Ya', '2022-12-11 06:47:27', NULL, NULL, NULL),
(696, 2, 'P20222696', 'AprilYandi Dwi W696', '56419974696', '3276022304010010696', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243696', 'Kp.Babakan No. 696', 'Islam', 11, 11, '150000.00', 1, 'Ya', '2022-12-11 06:47:28', NULL, NULL, NULL),
(697, 2, 'P20222697', 'AprilYandi Dwi W697', '56419974697', '3276022304010010697', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243697', 'Kp.Babakan No. 697', 'Islam', 4, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:28', NULL, NULL, NULL),
(698, 1, 'P20221698', 'AprilYandi Dwi W698', '56419974698', '3276022304010010698', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243698', 'Kp.Babakan No. 698', 'Islam', 3, 5, '150000.00', 3, 'Ya', '2022-12-11 06:47:28', NULL, NULL, NULL),
(699, 2, 'P20222699', 'AprilYandi Dwi W699', '56419974699', '3276022304010010699', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243699', 'Kp.Babakan No. 699', 'Islam', 1, 12, '150000.00', 4, 'Ya', '2022-12-11 06:47:28', NULL, NULL, NULL),
(700, 3, 'P20223700', 'AprilYandi Dwi W700', '56419974700', '3276022304010010700', 'Semarang', '2001-03-31', 'Perempuan', '08810243700', 'Kp.Babakan No. 700', 'Islam', 3, 11, NULL, NULL, 'Tidak', '2022-12-11 06:47:28', NULL, NULL, NULL),
(701, 1, 'P20221701', 'AprilYandi Dwi W701', '56419974701', '3276022304010010701', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243701', 'Kp.Babakan No. 701', 'Islam', 7, 10, '150000.00', 3, 'Ya', '2022-12-11 06:47:28', NULL, NULL, NULL),
(702, 3, 'P20223702', 'AprilYandi Dwi W702', '56419974702', '3276022304010010702', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243702', 'Kp.Babakan No. 702', 'Islam', 8, 8, NULL, NULL, 'Tidak', '2022-12-11 06:47:28', NULL, NULL, NULL),
(703, 1, 'P20221703', 'AprilYandi Dwi W703', '56419974703', '3276022304010010703', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243703', 'Kp.Babakan No. 703', 'Islam', 7, 1, '150000.00', 2, 'Ya', '2022-12-11 06:47:29', NULL, NULL, NULL),
(704, 3, 'P20223704', 'AprilYandi Dwi W704', '56419974704', '3276022304010010704', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243704', 'Kp.Babakan No. 704', 'Islam', 13, 13, NULL, NULL, 'Tidak', '2022-12-11 06:47:29', NULL, NULL, NULL),
(705, 2, 'P20222705', 'AprilYandi Dwi W705', '56419974705', '3276022304010010705', 'Semarang', '2001-04-23', 'Perempuan', '08810243705', 'Kp.Babakan No. 705', 'Islam', 6, 9, '150000.00', 3, 'Ya', '2022-12-11 06:47:29', NULL, NULL, NULL),
(706, 1, 'P20221706', 'AprilYandi Dwi W706', '56419974706', '3276022304010010706', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243706', 'Kp.Babakan No. 706', 'Islam', 13, 13, '150000.00', 2, 'Ya', '2022-12-11 06:47:29', NULL, NULL, NULL),
(707, 1, 'P20221707', 'AprilYandi Dwi W707', '56419974707', '3276022304010010707', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243707', 'Kp.Babakan No. 707', 'Islam', 13, 8, '150000.00', 1, 'Ya', '2022-12-11 06:47:29', NULL, NULL, NULL),
(708, 2, 'P20222708', 'AprilYandi Dwi W708', '56419974708', '3276022304010010708', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243708', 'Kp.Babakan No. 708', 'Islam', 12, 7, '150000.00', 4, 'Ya', '2022-12-11 06:47:29', NULL, NULL, NULL),
(709, 3, 'P20223709', 'AprilYandi Dwi W709', '56419974709', '3276022304010010709', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243709', 'Kp.Babakan No. 709', 'Islam', 3, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:29', NULL, NULL, NULL),
(710, 2, 'P20222710', 'AprilYandi Dwi W710', '56419974710', '3276022304010010710', 'Semarang', '2001-04-16', 'Perempuan', '08810243710', 'Kp.Babakan No. 710', 'Islam', 2, 4, '150000.00', 4, 'Ya', '2022-12-11 06:47:29', NULL, NULL, NULL),
(711, 3, 'P20223711', 'AprilYandi Dwi W711', '56419974711', '3276022304010010711', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243711', 'Kp.Babakan No. 711', 'Islam', 5, 8, NULL, NULL, 'Tidak', '2022-12-11 06:47:30', NULL, NULL, NULL),
(712, 2, 'P20222712', 'AprilYandi Dwi W712', '56419974712', '3276022304010010712', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243712', 'Kp.Babakan No. 712', 'Islam', 12, 10, '150000.00', 3, 'Ya', '2022-12-11 06:47:30', NULL, NULL, NULL),
(713, 1, 'P20221713', 'AprilYandi Dwi W713', '56419974713', '3276022304010010713', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243713', 'Kp.Babakan No. 713', 'Islam', 8, 3, '150000.00', 2, 'Ya', '2022-12-11 06:47:30', NULL, NULL, NULL),
(714, 2, 'P20222714', 'AprilYandi Dwi W714', '56419974714', '3276022304010010714', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243714', 'Kp.Babakan No. 714', 'Islam', 10, 6, '150000.00', 3, 'Ya', '2022-12-11 06:47:30', NULL, NULL, NULL),
(715, 1, 'P20221715', 'AprilYandi Dwi W715', '56419974715', '3276022304010010715', 'Semarang', '2001-04-17', 'Perempuan', '08810243715', 'Kp.Babakan No. 715', 'Islam', 11, 13, '150000.00', 3, 'Ya', '2022-12-11 06:47:30', NULL, NULL, NULL),
(716, 3, 'P20223716', 'AprilYandi Dwi W716', '56419974716', '3276022304010010716', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243716', 'Kp.Babakan No. 716', 'Islam', 10, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:31', NULL, NULL, NULL),
(717, 1, 'P20221717', 'AprilYandi Dwi W717', '56419974717', '3276022304010010717', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243717', 'Kp.Babakan No. 717', 'Islam', 13, 12, '150000.00', 4, 'Ya', '2022-12-11 06:47:31', NULL, NULL, NULL),
(718, 1, 'P20221718', 'AprilYandi Dwi W718', '56419974718', '3276022304010010718', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243718', 'Kp.Babakan No. 718', 'Islam', 3, 7, '150000.00', 3, 'Ya', '2022-12-11 06:47:32', NULL, NULL, NULL),
(719, 1, 'P20221719', 'AprilYandi Dwi W719', '56419974719', '3276022304010010719', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243719', 'Kp.Babakan No. 719', 'Islam', 8, 10, '150000.00', 1, 'Ya', '2022-12-11 06:47:32', NULL, NULL, NULL),
(720, 2, 'P20222720', 'AprilYandi Dwi W720', '56419974720', '3276022304010010720', 'Semarang', '2001-04-08', 'Perempuan', '08810243720', 'Kp.Babakan No. 720', 'Islam', 10, 7, '150000.00', 1, 'Ya', '2022-12-11 06:47:32', NULL, NULL, NULL),
(721, 2, 'P20222721', 'AprilYandi Dwi W721', '56419974721', '3276022304010010721', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243721', 'Kp.Babakan No. 721', 'Islam', 8, 10, '150000.00', 3, 'Ya', '2022-12-11 06:47:32', NULL, NULL, NULL),
(722, 1, 'P20221722', 'AprilYandi Dwi W722', '56419974722', '3276022304010010722', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243722', 'Kp.Babakan No. 722', 'Islam', 11, 3, '150000.00', 2, 'Ya', '2022-12-11 06:47:32', NULL, NULL, NULL),
(723, 3, 'P20223723', 'AprilYandi Dwi W723', '56419974723', '3276022304010010723', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243723', 'Kp.Babakan No. 723', 'Islam', 5, 10, NULL, NULL, 'Tidak', '2022-12-11 06:47:32', NULL, NULL, NULL),
(724, 2, 'P20222724', 'AprilYandi Dwi W724', '56419974724', '3276022304010010724', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243724', 'Kp.Babakan No. 724', 'Islam', 3, 6, '150000.00', 3, 'Ya', '2022-12-11 06:47:33', NULL, NULL, NULL),
(725, 2, 'P20222725', 'AprilYandi Dwi W725', '56419974725', '3276022304010010725', 'Semarang', '2001-04-20', 'Perempuan', '08810243725', 'Kp.Babakan No. 725', 'Islam', 1, 2, '150000.00', 4, 'Ya', '2022-12-11 06:47:33', NULL, NULL, NULL),
(726, 3, 'P20223726', 'AprilYandi Dwi W726', '56419974726', '3276022304010010726', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243726', 'Kp.Babakan No. 726', 'Islam', 11, 11, NULL, NULL, 'Tidak', '2022-12-11 06:47:33', NULL, NULL, NULL),
(727, 2, 'P20222727', 'AprilYandi Dwi W727', '56419974727', '3276022304010010727', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243727', 'Kp.Babakan No. 727', 'Islam', 2, 8, '150000.00', 4, 'Ya', '2022-12-11 06:47:33', NULL, NULL, NULL),
(728, 1, 'P20221728', 'AprilYandi Dwi W728', '56419974728', '3276022304010010728', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243728', 'Kp.Babakan No. 728', 'Islam', 1, 2, '150000.00', 4, 'Ya', '2022-12-11 06:47:34', NULL, NULL, NULL),
(729, 1, 'P20221729', 'AprilYandi Dwi W729', '56419974729', '3276022304010010729', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243729', 'Kp.Babakan No. 729', 'Islam', 6, 10, '150000.00', 4, 'Ya', '2022-12-11 06:47:34', NULL, NULL, NULL),
(730, 2, 'P20222730', 'AprilYandi Dwi W730', '56419974730', '3276022304010010730', 'Semarang', '2001-04-09', 'Perempuan', '08810243730', 'Kp.Babakan No. 730', 'Islam', 11, 2, '150000.00', 3, 'Ya', '2022-12-11 06:47:34', NULL, NULL, NULL),
(731, 3, 'P20223731', 'AprilYandi Dwi W731', '56419974731', '3276022304010010731', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243731', 'Kp.Babakan No. 731', 'Islam', 8, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:34', NULL, NULL, NULL),
(732, 2, 'P20222732', 'AprilYandi Dwi W732', '56419974732', '3276022304010010732', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243732', 'Kp.Babakan No. 732', 'Islam', 6, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:35', NULL, NULL, NULL),
(733, 2, 'P20222733', 'AprilYandi Dwi W733', '56419974733', '3276022304010010733', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243733', 'Kp.Babakan No. 733', 'Islam', 10, 4, '150000.00', 4, 'Ya', '2022-12-11 06:47:35', NULL, NULL, NULL),
(734, 1, 'P20221734', 'AprilYandi Dwi W734', '56419974734', '3276022304010010734', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243734', 'Kp.Babakan No. 734', 'Islam', 6, 7, '150000.00', 1, 'Ya', '2022-12-11 06:47:35', NULL, NULL, NULL),
(735, 1, 'P20221735', 'AprilYandi Dwi W735', '56419974735', '3276022304010010735', 'Semarang', '2001-04-23', 'Perempuan', '08810243735', 'Kp.Babakan No. 735', 'Islam', 11, 9, '150000.00', 4, 'Ya', '2022-12-11 06:47:35', NULL, NULL, NULL),
(736, 2, 'P20222736', 'AprilYandi Dwi W736', '56419974736', '3276022304010010736', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243736', 'Kp.Babakan No. 736', 'Islam', 3, 4, '150000.00', 1, 'Ya', '2022-12-11 06:47:36', NULL, NULL, NULL),
(737, 2, 'P20222737', 'AprilYandi Dwi W737', '56419974737', '3276022304010010737', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243737', 'Kp.Babakan No. 737', 'Islam', 9, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:36', NULL, NULL, NULL),
(738, 1, 'P20221738', 'AprilYandi Dwi W738', '56419974738', '3276022304010010738', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243738', 'Kp.Babakan No. 738', 'Islam', 4, 13, '150000.00', 4, 'Ya', '2022-12-11 06:47:36', NULL, NULL, NULL),
(739, 2, 'P20222739', 'AprilYandi Dwi W739', '56419974739', '3276022304010010739', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243739', 'Kp.Babakan No. 739', 'Islam', 8, 7, '150000.00', 1, 'Ya', '2022-12-11 06:47:37', NULL, NULL, NULL),
(740, 2, 'P20222740', 'AprilYandi Dwi W740', '56419974740', '3276022304010010740', 'Semarang', '2001-04-23', 'Perempuan', '08810243740', 'Kp.Babakan No. 740', 'Islam', 1, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:37', NULL, NULL, NULL),
(741, 3, 'P20223741', 'AprilYandi Dwi W741', '56419974741', '3276022304010010741', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243741', 'Kp.Babakan No. 741', 'Islam', 9, 11, NULL, NULL, 'Tidak', '2022-12-11 06:47:37', NULL, NULL, NULL),
(742, 3, 'P20223742', 'AprilYandi Dwi W742', '56419974742', '3276022304010010742', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243742', 'Kp.Babakan No. 742', 'Islam', 13, 13, NULL, NULL, 'Tidak', '2022-12-11 06:47:38', NULL, NULL, NULL),
(743, 3, 'P20223743', 'AprilYandi Dwi W743', '56419974743', '3276022304010010743', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243743', 'Kp.Babakan No. 743', 'Islam', 12, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:38', NULL, NULL, NULL),
(744, 2, 'P20222744', 'AprilYandi Dwi W744', '56419974744', '3276022304010010744', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243744', 'Kp.Babakan No. 744', 'Islam', 11, 9, '150000.00', 2, 'Ya', '2022-12-11 06:47:39', NULL, NULL, NULL),
(745, 1, 'P20221745', 'AprilYandi Dwi W745', '56419974745', '3276022304010010745', 'Semarang', '2001-04-06', 'Perempuan', '08810243745', 'Kp.Babakan No. 745', 'Islam', 11, 7, '150000.00', 4, 'Ya', '2022-12-11 06:47:39', NULL, NULL, NULL),
(746, 1, 'P20221746', 'AprilYandi Dwi W746', '56419974746', '3276022304010010746', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243746', 'Kp.Babakan No. 746', 'Islam', 7, 4, '150000.00', 2, 'Ya', '2022-12-11 06:47:39', NULL, NULL, NULL),
(747, 1, 'P20221747', 'AprilYandi Dwi W747', '56419974747', '3276022304010010747', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243747', 'Kp.Babakan No. 747', 'Islam', 13, 10, '150000.00', 2, 'Ya', '2022-12-11 06:47:40', NULL, NULL, NULL),
(748, 1, 'P20221748', 'AprilYandi Dwi W748', '56419974748', '3276022304010010748', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243748', 'Kp.Babakan No. 748', 'Islam', 2, 8, '150000.00', 1, 'Ya', '2022-12-11 06:47:40', NULL, NULL, NULL),
(749, 3, 'P20223749', 'AprilYandi Dwi W749', '56419974749', '3276022304010010749', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243749', 'Kp.Babakan No. 749', 'Islam', 4, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:40', NULL, NULL, NULL),
(750, 3, 'P20223750', 'AprilYandi Dwi W750', '56419974750', '3276022304010010750', 'Semarang', '2001-04-13', 'Perempuan', '08810243750', 'Kp.Babakan No. 750', 'Islam', 8, 7, NULL, NULL, 'Tidak', '2022-12-11 06:47:40', NULL, NULL, NULL),
(751, 3, 'P20223751', 'AprilYandi Dwi W751', '56419974751', '3276022304010010751', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243751', 'Kp.Babakan No. 751', 'Islam', 11, 9, NULL, NULL, 'Tidak', '2022-12-11 06:47:41', NULL, NULL, NULL),
(752, 2, 'P20222752', 'AprilYandi Dwi W752', '56419974752', '3276022304010010752', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243752', 'Kp.Babakan No. 752', 'Islam', 7, 12, '150000.00', 4, 'Ya', '2022-12-11 06:47:42', NULL, NULL, NULL),
(753, 3, 'P20223753', 'AprilYandi Dwi W753', '56419974753', '3276022304010010753', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243753', 'Kp.Babakan No. 753', 'Islam', 9, 3, NULL, NULL, 'Tidak', '2022-12-11 06:47:42', NULL, NULL, NULL),
(754, 1, 'P20221754', 'AprilYandi Dwi W754', '56419974754', '3276022304010010754', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243754', 'Kp.Babakan No. 754', 'Islam', 12, 10, '150000.00', 2, 'Ya', '2022-12-11 06:47:42', NULL, NULL, NULL),
(755, 2, 'P20222755', 'AprilYandi Dwi W755', '56419974755', '3276022304010010755', 'Semarang', '2001-04-01', 'Perempuan', '08810243755', 'Kp.Babakan No. 755', 'Islam', 5, 5, '150000.00', 3, 'Ya', '2022-12-11 06:47:42', NULL, NULL, NULL),
(756, 1, 'P20221756', 'AprilYandi Dwi W756', '56419974756', '3276022304010010756', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243756', 'Kp.Babakan No. 756', 'Islam', 3, 4, '150000.00', 1, 'Ya', '2022-12-11 06:47:42', NULL, NULL, NULL),
(757, 1, 'P20221757', 'AprilYandi Dwi W757', '56419974757', '3276022304010010757', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243757', 'Kp.Babakan No. 757', 'Islam', 7, 1, '150000.00', 4, 'Ya', '2022-12-11 06:47:42', NULL, NULL, NULL),
(758, 2, 'P20222758', 'AprilYandi Dwi W758', '56419974758', '3276022304010010758', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243758', 'Kp.Babakan No. 758', 'Islam', 4, 5, '150000.00', 1, 'Ya', '2022-12-11 06:47:43', NULL, NULL, NULL),
(759, 2, 'P20222759', 'AprilYandi Dwi W759', '56419974759', '3276022304010010759', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243759', 'Kp.Babakan No. 759', 'Islam', 6, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:43', NULL, NULL, NULL),
(760, 3, 'P20223760', 'AprilYandi Dwi W760', '56419974760', '3276022304010010760', 'Semarang', '2001-03-30', 'Perempuan', '08810243760', 'Kp.Babakan No. 760', 'Islam', 7, 12, NULL, NULL, 'Tidak', '2022-12-11 06:47:43', NULL, NULL, NULL),
(761, 1, 'P20221761', 'AprilYandi Dwi W761', '56419974761', '3276022304010010761', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243761', 'Kp.Babakan No. 761', 'Islam', 7, 5, '150000.00', 1, 'Ya', '2022-12-11 06:47:44', NULL, NULL, NULL),
(762, 1, 'P20221762', 'AprilYandi Dwi W762', '56419974762', '3276022304010010762', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243762', 'Kp.Babakan No. 762', 'Islam', 5, 3, '150000.00', 3, 'Ya', '2022-12-11 06:47:44', NULL, NULL, NULL),
(763, 2, 'P20222763', 'AprilYandi Dwi W763', '56419974763', '3276022304010010763', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243763', 'Kp.Babakan No. 763', 'Islam', 8, 9, '150000.00', 1, 'Ya', '2022-12-11 06:47:44', NULL, NULL, NULL),
(764, 3, 'P20223764', 'AprilYandi Dwi W764', '56419974764', '3276022304010010764', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243764', 'Kp.Babakan No. 764', 'Islam', 8, 6, NULL, NULL, 'Tidak', '2022-12-11 06:47:45', NULL, NULL, NULL),
(765, 3, 'P20223765', 'AprilYandi Dwi W765', '56419974765', '3276022304010010765', 'Semarang', '2001-04-17', 'Perempuan', '08810243765', 'Kp.Babakan No. 765', 'Islam', 5, 9, NULL, NULL, 'Tidak', '2022-12-11 06:47:45', NULL, NULL, NULL),
(766, 3, 'P20223766', 'AprilYandi Dwi W766', '56419974766', '3276022304010010766', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243766', 'Kp.Babakan No. 766', 'Islam', 11, 10, NULL, NULL, 'Tidak', '2022-12-11 06:47:45', NULL, NULL, NULL),
(767, 1, 'P20221767', 'AprilYandi Dwi W767', '56419974767', '3276022304010010767', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243767', 'Kp.Babakan No. 767', 'Islam', 3, 12, '150000.00', 1, 'Ya', '2022-12-11 06:47:46', NULL, NULL, NULL),
(768, 3, 'P20223768', 'AprilYandi Dwi W768', '56419974768', '3276022304010010768', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243768', 'Kp.Babakan No. 768', 'Islam', 7, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:47', NULL, NULL, NULL),
(769, 3, 'P20223769', 'AprilYandi Dwi W769', '56419974769', '3276022304010010769', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243769', 'Kp.Babakan No. 769', 'Islam', 9, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:48', NULL, NULL, NULL),
(770, 1, 'P20221770', 'AprilYandi Dwi W770', '56419974770', '3276022304010010770', 'Semarang', '2001-03-29', 'Perempuan', '08810243770', 'Kp.Babakan No. 770', 'Islam', 1, 1, '150000.00', 1, 'Ya', '2022-12-11 06:47:50', NULL, NULL, NULL),
(771, 1, 'P20221771', 'AprilYandi Dwi W771', '56419974771', '3276022304010010771', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243771', 'Kp.Babakan No. 771', 'Islam', 5, 5, '150000.00', 4, 'Ya', '2022-12-11 06:47:52', NULL, NULL, NULL),
(772, 3, 'P20223772', 'AprilYandi Dwi W772', '56419974772', '3276022304010010772', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243772', 'Kp.Babakan No. 772', 'Islam', 1, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:52', NULL, NULL, NULL),
(773, 2, 'P20222773', 'AprilYandi Dwi W773', '56419974773', '3276022304010010773', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243773', 'Kp.Babakan No. 773', 'Islam', 7, 6, '150000.00', 1, 'Ya', '2022-12-11 06:47:53', NULL, NULL, NULL),
(774, 3, 'P20223774', 'AprilYandi Dwi W774', '56419974774', '3276022304010010774', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243774', 'Kp.Babakan No. 774', 'Islam', 11, 4, NULL, NULL, 'Tidak', '2022-12-11 06:47:53', NULL, NULL, NULL),
(775, 2, 'P20222775', 'AprilYandi Dwi W775', '56419974775', '3276022304010010775', 'Semarang', '2001-04-01', 'Perempuan', '08810243775', 'Kp.Babakan No. 775', 'Islam', 6, 1, '150000.00', 4, 'Ya', '2022-12-11 06:47:55', NULL, NULL, NULL),
(776, 1, 'P20221776', 'AprilYandi Dwi W776', '56419974776', '3276022304010010776', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243776', 'Kp.Babakan No. 776', 'Islam', 4, 8, '150000.00', 4, 'Ya', '2022-12-11 06:47:55', NULL, NULL, NULL),
(777, 1, 'P20221777', 'AprilYandi Dwi W777', '56419974777', '3276022304010010777', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243777', 'Kp.Babakan No. 777', 'Islam', 13, 5, '150000.00', 1, 'Ya', '2022-12-11 06:47:55', NULL, NULL, NULL),
(778, 3, 'P20223778', 'AprilYandi Dwi W778', '56419974778', '3276022304010010778', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243778', 'Kp.Babakan No. 778', 'Islam', 3, 6, NULL, NULL, 'Tidak', '2022-12-11 06:47:56', NULL, NULL, NULL),
(779, 3, 'P20223779', 'AprilYandi Dwi W779', '56419974779', '3276022304010010779', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243779', 'Kp.Babakan No. 779', 'Islam', 1, 3, NULL, NULL, 'Tidak', '2022-12-11 06:47:57', NULL, NULL, NULL),
(780, 3, 'P20223780', 'AprilYandi Dwi W780', '56419974780', '3276022304010010780', 'Semarang', '2001-04-17', 'Perempuan', '08810243780', 'Kp.Babakan No. 780', 'Islam', 9, 1, NULL, NULL, 'Tidak', '2022-12-11 06:47:57', NULL, NULL, NULL),
(781, 3, 'P20223781', 'AprilYandi Dwi W781', '56419974781', '3276022304010010781', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243781', 'Kp.Babakan No. 781', 'Islam', 4, 13, NULL, NULL, 'Tidak', '2022-12-11 06:47:57', NULL, NULL, NULL),
(782, 2, 'P20222782', 'AprilYandi Dwi W782', '56419974782', '3276022304010010782', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243782', 'Kp.Babakan No. 782', 'Islam', 9, 11, '150000.00', 4, 'Ya', '2022-12-11 06:47:58', NULL, NULL, NULL),
(783, 2, 'P20222783', 'AprilYandi Dwi W783', '56419974783', '3276022304010010783', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243783', 'Kp.Babakan No. 783', 'Islam', 6, 7, '150000.00', 3, 'Ya', '2022-12-11 06:47:58', NULL, NULL, NULL),
(784, 3, 'P20223784', 'AprilYandi Dwi W784', '56419974784', '3276022304010010784', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243784', 'Kp.Babakan No. 784', 'Islam', 2, 6, NULL, NULL, 'Tidak', '2022-12-11 06:47:59', NULL, NULL, NULL),
(785, 1, 'P20221785', 'AprilYandi Dwi W785', '56419974785', '3276022304010010785', 'Semarang', '2001-04-05', 'Perempuan', '08810243785', 'Kp.Babakan No. 785', 'Islam', 1, 10, '150000.00', 3, 'Ya', '2022-12-11 06:48:00', NULL, NULL, NULL),
(786, 1, 'P20221786', 'AprilYandi Dwi W786', '56419974786', '3276022304010010786', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243786', 'Kp.Babakan No. 786', 'Islam', 1, 4, '150000.00', 4, 'Ya', '2022-12-11 06:48:00', NULL, NULL, NULL),
(787, 1, 'P20221787', 'AprilYandi Dwi W787', '56419974787', '3276022304010010787', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243787', 'Kp.Babakan No. 787', 'Islam', 7, 11, '150000.00', 1, 'Ya', '2022-12-11 06:48:00', NULL, NULL, NULL),
(788, 1, 'P20221788', 'AprilYandi Dwi W788', '56419974788', '3276022304010010788', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243788', 'Kp.Babakan No. 788', 'Islam', 12, 9, '150000.00', 2, 'Ya', '2022-12-11 06:48:01', NULL, NULL, NULL),
(789, 2, 'P20222789', 'AprilYandi Dwi W789', '56419974789', '3276022304010010789', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243789', 'Kp.Babakan No. 789', 'Islam', 5, 11, '150000.00', 1, 'Ya', '2022-12-11 06:48:01', NULL, NULL, NULL),
(790, 2, 'P20222790', 'AprilYandi Dwi W790', '56419974790', '3276022304010010790', 'Semarang', '2001-04-16', 'Perempuan', '08810243790', 'Kp.Babakan No. 790', 'Islam', 7, 6, '150000.00', 3, 'Ya', '2022-12-11 06:48:02', NULL, NULL, NULL),
(791, 2, 'P20222791', 'AprilYandi Dwi W791', '56419974791', '3276022304010010791', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243791', 'Kp.Babakan No. 791', 'Islam', 9, 12, '150000.00', 3, 'Ya', '2022-12-11 06:48:02', NULL, NULL, NULL),
(792, 1, 'P20221792', 'AprilYandi Dwi W792', '56419974792', '3276022304010010792', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243792', 'Kp.Babakan No. 792', 'Islam', 9, 5, '150000.00', 3, 'Ya', '2022-12-11 06:48:02', NULL, NULL, NULL),
(793, 2, 'P20222793', 'AprilYandi Dwi W793', '56419974793', '3276022304010010793', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243793', 'Kp.Babakan No. 793', 'Islam', 13, 4, '150000.00', 1, 'Ya', '2022-12-11 06:48:09', NULL, NULL, NULL),
(794, 1, 'P20221794', 'AprilYandi Dwi W794', '56419974794', '3276022304010010794', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243794', 'Kp.Babakan No. 794', 'Islam', 2, 8, '150000.00', 2, 'Ya', '2022-12-11 06:48:10', NULL, NULL, NULL),
(795, 1, 'P20221795', 'AprilYandi Dwi W795', '56419974795', '3276022304010010795', 'Semarang', '2001-04-23', 'Perempuan', '08810243795', 'Kp.Babakan No. 795', 'Islam', 11, 1, '150000.00', 3, 'Ya', '2022-12-11 06:48:10', NULL, NULL, NULL),
(796, 1, 'P20221796', 'AprilYandi Dwi W796', '56419974796', '3276022304010010796', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243796', 'Kp.Babakan No. 796', 'Islam', 7, 10, '150000.00', 1, 'Ya', '2022-12-11 06:48:11', NULL, NULL, NULL),
(797, 3, 'P20223797', 'AprilYandi Dwi W797', '56419974797', '3276022304010010797', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243797', 'Kp.Babakan No. 797', 'Islam', 10, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:11', NULL, NULL, NULL),
(798, 2, 'P20222798', 'AprilYandi Dwi W798', '56419974798', '3276022304010010798', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243798', 'Kp.Babakan No. 798', 'Islam', 3, 10, '150000.00', 4, 'Ya', '2022-12-11 06:48:12', NULL, NULL, NULL),
(799, 3, 'P20223799', 'AprilYandi Dwi W799', '56419974799', '3276022304010010799', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243799', 'Kp.Babakan No. 799', 'Islam', 12, 7, NULL, NULL, 'Tidak', '2022-12-11 06:48:12', NULL, NULL, NULL),
(800, 3, 'P20223800', 'AprilYandi Dwi W800', '56419974800', '3276022304010010800', 'Semarang', '2001-04-09', 'Perempuan', '08810243800', 'Kp.Babakan No. 800', 'Islam', 3, 13, NULL, NULL, 'Tidak', '2022-12-11 06:48:12', NULL, NULL, NULL),
(801, 3, 'P20223801', 'AprilYandi Dwi W801', '56419974801', '3276022304010010801', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243801', 'Kp.Babakan No. 801', 'Islam', 3, 13, NULL, NULL, 'Tidak', '2022-12-11 06:48:12', NULL, NULL, NULL),
(802, 2, 'P20222802', 'AprilYandi Dwi W802', '56419974802', '3276022304010010802', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243802', 'Kp.Babakan No. 802', 'Islam', 6, 1, '150000.00', 4, 'Ya', '2022-12-11 06:48:13', NULL, NULL, NULL),
(803, 1, 'P20221803', 'AprilYandi Dwi W803', '56419974803', '3276022304010010803', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243803', 'Kp.Babakan No. 803', 'Islam', 7, 10, '150000.00', 2, 'Ya', '2022-12-11 06:48:13', NULL, NULL, NULL),
(804, 3, 'P20223804', 'AprilYandi Dwi W804', '56419974804', '3276022304010010804', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243804', 'Kp.Babakan No. 804', 'Islam', 13, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:13', NULL, NULL, NULL),
(805, 3, 'P20223805', 'AprilYandi Dwi W805', '56419974805', '3276022304010010805', 'Semarang', '2001-04-23', 'Perempuan', '08810243805', 'Kp.Babakan No. 805', 'Islam', 9, 5, NULL, NULL, 'Tidak', '2022-12-11 06:48:13', NULL, NULL, NULL),
(806, 3, 'P20223806', 'AprilYandi Dwi W806', '56419974806', '3276022304010010806', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243806', 'Kp.Babakan No. 806', 'Islam', 10, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:14', NULL, NULL, NULL),
(807, 1, 'P20221807', 'AprilYandi Dwi W807', '56419974807', '3276022304010010807', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243807', 'Kp.Babakan No. 807', 'Islam', 7, 11, '150000.00', 3, 'Ya', '2022-12-11 06:48:15', NULL, NULL, NULL),
(808, 1, 'P20221808', 'AprilYandi Dwi W808', '56419974808', '3276022304010010808', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243808', 'Kp.Babakan No. 808', 'Islam', 6, 13, '150000.00', 3, 'Ya', '2022-12-11 06:48:15', NULL, NULL, NULL),
(809, 3, 'P20223809', 'AprilYandi Dwi W809', '56419974809', '3276022304010010809', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243809', 'Kp.Babakan No. 809', 'Islam', 1, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:16', NULL, NULL, NULL),
(810, 1, 'P20221810', 'AprilYandi Dwi W810', '56419974810', '3276022304010010810', 'Semarang', '2001-04-19', 'Perempuan', '08810243810', 'Kp.Babakan No. 810', 'Islam', 8, 12, '150000.00', 4, 'Ya', '2022-12-11 06:48:18', NULL, NULL, NULL),
(811, 2, 'P20222811', 'AprilYandi Dwi W811', '56419974811', '3276022304010010811', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243811', 'Kp.Babakan No. 811', 'Islam', 11, 8, '150000.00', 3, 'Ya', '2022-12-11 06:48:18', NULL, NULL, NULL),
(812, 1, 'P20221812', 'AprilYandi Dwi W812', '56419974812', '3276022304010010812', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243812', 'Kp.Babakan No. 812', 'Islam', 7, 3, '150000.00', 4, 'Ya', '2022-12-11 06:48:19', NULL, NULL, NULL),
(813, 2, 'P20222813', 'AprilYandi Dwi W813', '56419974813', '3276022304010010813', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243813', 'Kp.Babakan No. 813', 'Islam', 2, 12, '150000.00', 1, 'Ya', '2022-12-11 06:48:19', NULL, NULL, NULL),
(814, 1, 'P20221814', 'AprilYandi Dwi W814', '56419974814', '3276022304010010814', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243814', 'Kp.Babakan No. 814', 'Islam', 13, 6, '150000.00', 1, 'Ya', '2022-12-11 06:48:19', NULL, NULL, NULL),
(815, 1, 'P20221815', 'AprilYandi Dwi W815', '56419974815', '3276022304010010815', 'Semarang', '2001-04-13', 'Perempuan', '08810243815', 'Kp.Babakan No. 815', 'Islam', 11, 4, '150000.00', 4, 'Ya', '2022-12-11 06:48:20', NULL, NULL, NULL),
(816, 1, 'P20221816', 'AprilYandi Dwi W816', '56419974816', '3276022304010010816', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243816', 'Kp.Babakan No. 816', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:48:20', NULL, NULL, NULL),
(817, 1, 'P20221817', 'AprilYandi Dwi W817', '56419974817', '3276022304010010817', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243817', 'Kp.Babakan No. 817', 'Islam', 3, 13, '150000.00', 3, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(818, 2, 'P20222818', 'AprilYandi Dwi W818', '56419974818', '3276022304010010818', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243818', 'Kp.Babakan No. 818', 'Islam', 12, 5, '150000.00', 2, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(819, 2, 'P20222819', 'AprilYandi Dwi W819', '56419974819', '3276022304010010819', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243819', 'Kp.Babakan No. 819', 'Islam', 10, 1, '150000.00', 2, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(820, 1, 'P20221820', 'AprilYandi Dwi W820', '56419974820', '3276022304010010820', 'Semarang', '2001-04-01', 'Perempuan', '08810243820', 'Kp.Babakan No. 820', 'Islam', 3, 10, '150000.00', 1, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(821, 1, 'P20221821', 'AprilYandi Dwi W821', '56419974821', '3276022304010010821', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243821', 'Kp.Babakan No. 821', 'Islam', 3, 4, '150000.00', 3, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(822, 2, 'P20222822', 'AprilYandi Dwi W822', '56419974822', '3276022304010010822', 'Jakarta', '2001-04-16', 'Laki-Laki', '08810243822', 'Kp.Babakan No. 822', 'Islam', 3, 1, '150000.00', 1, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(823, 2, 'P20222823', 'AprilYandi Dwi W823', '56419974823', '3276022304010010823', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243823', 'Kp.Babakan No. 823', 'Islam', 1, 13, '150000.00', 3, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(824, 2, 'P20222824', 'AprilYandi Dwi W824', '56419974824', '3276022304010010824', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243824', 'Kp.Babakan No. 824', 'Islam', 1, 9, '150000.00', 1, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(825, 1, 'P20221825', 'AprilYandi Dwi W825', '56419974825', '3276022304010010825', 'Semarang', '2001-04-06', 'Perempuan', '08810243825', 'Kp.Babakan No. 825', 'Islam', 11, 8, '150000.00', 1, 'Ya', '2022-12-11 06:48:21', NULL, NULL, NULL),
(826, 1, 'P20221826', 'AprilYandi Dwi W826', '56419974826', '3276022304010010826', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243826', 'Kp.Babakan No. 826', 'Islam', 9, 6, '150000.00', 1, 'Ya', '2022-12-11 06:48:22', NULL, NULL, NULL),
(827, 3, 'P20223827', 'AprilYandi Dwi W827', '56419974827', '3276022304010010827', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243827', 'Kp.Babakan No. 827', 'Islam', 2, 7, NULL, NULL, 'Tidak', '2022-12-11 06:48:22', NULL, NULL, NULL),
(828, 2, 'P20222828', 'AprilYandi Dwi W828', '56419974828', '3276022304010010828', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243828', 'Kp.Babakan No. 828', 'Islam', 5, 2, '150000.00', 2, 'Ya', '2022-12-11 06:48:22', NULL, NULL, NULL),
(829, 3, 'P20223829', 'AprilYandi Dwi W829', '56419974829', '3276022304010010829', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243829', 'Kp.Babakan No. 829', 'Islam', 11, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:22', NULL, NULL, NULL),
(830, 3, 'P20223830', 'AprilYandi Dwi W830', '56419974830', '3276022304010010830', 'Semarang', '2001-04-18', 'Perempuan', '08810243830', 'Kp.Babakan No. 830', 'Islam', 9, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:22', NULL, NULL, NULL),
(831, 3, 'P20223831', 'AprilYandi Dwi W831', '56419974831', '3276022304010010831', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243831', 'Kp.Babakan No. 831', 'Islam', 11, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:22', NULL, NULL, NULL),
(832, 1, 'P20221832', 'AprilYandi Dwi W832', '56419974832', '3276022304010010832', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243832', 'Kp.Babakan No. 832', 'Islam', 7, 6, '150000.00', 2, 'Ya', '2022-12-11 06:48:22', NULL, NULL, NULL),
(833, 3, 'P20223833', 'AprilYandi Dwi W833', '56419974833', '3276022304010010833', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243833', 'Kp.Babakan No. 833', 'Islam', 3, 3, NULL, NULL, 'Tidak', '2022-12-11 06:48:23', NULL, NULL, NULL),
(834, 3, 'P20223834', 'AprilYandi Dwi W834', '56419974834', '3276022304010010834', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243834', 'Kp.Babakan No. 834', 'Islam', 9, 4, NULL, NULL, 'Tidak', '2022-12-11 06:48:23', NULL, NULL, NULL),
(835, 3, 'P20223835', 'AprilYandi Dwi W835', '56419974835', '3276022304010010835', 'Semarang', '2001-04-03', 'Perempuan', '08810243835', 'Kp.Babakan No. 835', 'Islam', 11, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:23', NULL, NULL, NULL),
(836, 2, 'P20222836', 'AprilYandi Dwi W836', '56419974836', '3276022304010010836', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243836', 'Kp.Babakan No. 836', 'Islam', 13, 1, '150000.00', 1, 'Ya', '2022-12-11 06:48:24', NULL, NULL, NULL),
(837, 2, 'P20222837', 'AprilYandi Dwi W837', '56419974837', '3276022304010010837', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243837', 'Kp.Babakan No. 837', 'Islam', 7, 12, '150000.00', 2, 'Ya', '2022-12-11 06:48:24', NULL, NULL, NULL),
(838, 2, 'P20222838', 'AprilYandi Dwi W838', '56419974838', '3276022304010010838', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243838', 'Kp.Babakan No. 838', 'Islam', 12, 10, '150000.00', 1, 'Ya', '2022-12-11 06:48:24', NULL, NULL, NULL),
(839, 1, 'P20221839', 'AprilYandi Dwi W839', '56419974839', '3276022304010010839', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243839', 'Kp.Babakan No. 839', 'Islam', 6, 2, '150000.00', 1, 'Ya', '2022-12-11 06:48:24', NULL, NULL, NULL),
(840, 3, 'P20223840', 'AprilYandi Dwi W840', '56419974840', '3276022304010010840', 'Semarang', '2001-03-25', 'Perempuan', '08810243840', 'Kp.Babakan No. 840', 'Islam', 6, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:24', NULL, NULL, NULL),
(841, 3, 'P20223841', 'AprilYandi Dwi W841', '56419974841', '3276022304010010841', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243841', 'Kp.Babakan No. 841', 'Islam', 10, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:25', NULL, NULL, NULL),
(842, 1, 'P20221842', 'AprilYandi Dwi W842', '56419974842', '3276022304010010842', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243842', 'Kp.Babakan No. 842', 'Islam', 13, 2, '150000.00', 2, 'Ya', '2022-12-11 06:48:25', NULL, NULL, NULL),
(843, 3, 'P20223843', 'AprilYandi Dwi W843', '56419974843', '3276022304010010843', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243843', 'Kp.Babakan No. 843', 'Islam', 5, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:25', NULL, NULL, NULL),
(844, 2, 'P20222844', 'AprilYandi Dwi W844', '56419974844', '3276022304010010844', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243844', 'Kp.Babakan No. 844', 'Islam', 5, 9, '150000.00', 4, 'Ya', '2022-12-11 06:48:25', NULL, NULL, NULL),
(845, 3, 'P20223845', 'AprilYandi Dwi W845', '56419974845', '3276022304010010845', 'Semarang', '2001-03-25', 'Perempuan', '08810243845', 'Kp.Babakan No. 845', 'Islam', 5, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:25', NULL, NULL, NULL),
(846, 3, 'P20223846', 'AprilYandi Dwi W846', '56419974846', '3276022304010010846', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243846', 'Kp.Babakan No. 846', 'Islam', 1, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:25', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(847, 2, 'P20222847', 'AprilYandi Dwi W847', '56419974847', '3276022304010010847', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243847', 'Kp.Babakan No. 847', 'Islam', 4, 4, '150000.00', 3, 'Ya', '2022-12-11 06:48:26', NULL, NULL, NULL),
(848, 1, 'P20221848', 'AprilYandi Dwi W848', '56419974848', '3276022304010010848', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243848', 'Kp.Babakan No. 848', 'Islam', 7, 10, '150000.00', 3, 'Ya', '2022-12-11 06:48:26', NULL, NULL, NULL),
(849, 2, 'P20222849', 'AprilYandi Dwi W849', '56419974849', '3276022304010010849', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243849', 'Kp.Babakan No. 849', 'Islam', 10, 1, '150000.00', 1, 'Ya', '2022-12-11 06:48:26', NULL, NULL, NULL),
(850, 1, 'P20221850', 'AprilYandi Dwi W850', '56419974850', '3276022304010010850', 'Semarang', '2001-04-12', 'Perempuan', '08810243850', 'Kp.Babakan No. 850', 'Islam', 9, 3, '150000.00', 4, 'Ya', '2022-12-11 06:48:26', NULL, NULL, NULL),
(851, 1, 'P20221851', 'AprilYandi Dwi W851', '56419974851', '3276022304010010851', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243851', 'Kp.Babakan No. 851', 'Islam', 12, 3, '150000.00', 3, 'Ya', '2022-12-11 06:48:26', NULL, NULL, NULL),
(852, 3, 'P20223852', 'AprilYandi Dwi W852', '56419974852', '3276022304010010852', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243852', 'Kp.Babakan No. 852', 'Islam', 7, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:26', NULL, NULL, NULL),
(853, 3, 'P20223853', 'AprilYandi Dwi W853', '56419974853', '3276022304010010853', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243853', 'Kp.Babakan No. 853', 'Islam', 9, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:26', NULL, NULL, NULL),
(854, 1, 'P20221854', 'AprilYandi Dwi W854', '56419974854', '3276022304010010854', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243854', 'Kp.Babakan No. 854', 'Islam', 2, 6, '150000.00', 3, 'Ya', '2022-12-11 06:48:27', NULL, NULL, NULL),
(855, 2, 'P20222855', 'AprilYandi Dwi W855', '56419974855', '3276022304010010855', 'Semarang', '2001-03-29', 'Perempuan', '08810243855', 'Kp.Babakan No. 855', 'Islam', 1, 1, '150000.00', 2, 'Ya', '2022-12-11 06:48:27', NULL, NULL, NULL),
(856, 2, 'P20222856', 'AprilYandi Dwi W856', '56419974856', '3276022304010010856', 'Jakarta', '2001-03-26', 'Laki-Laki', '08810243856', 'Kp.Babakan No. 856', 'Islam', 12, 13, '150000.00', 2, 'Ya', '2022-12-11 06:48:27', NULL, NULL, NULL),
(857, 3, 'P20223857', 'AprilYandi Dwi W857', '56419974857', '3276022304010010857', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243857', 'Kp.Babakan No. 857', 'Islam', 6, 12, NULL, NULL, 'Tidak', '2022-12-11 06:48:27', NULL, NULL, NULL),
(858, 2, 'P20222858', 'AprilYandi Dwi W858', '56419974858', '3276022304010010858', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243858', 'Kp.Babakan No. 858', 'Islam', 12, 8, '150000.00', 4, 'Ya', '2022-12-11 06:48:27', NULL, NULL, NULL),
(859, 2, 'P20222859', 'AprilYandi Dwi W859', '56419974859', '3276022304010010859', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243859', 'Kp.Babakan No. 859', 'Islam', 11, 13, '150000.00', 2, 'Ya', '2022-12-11 06:48:27', NULL, NULL, NULL),
(860, 1, 'P20221860', 'AprilYandi Dwi W860', '56419974860', '3276022304010010860', 'Semarang', '2001-04-06', 'Perempuan', '08810243860', 'Kp.Babakan No. 860', 'Islam', 3, 7, '150000.00', 3, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(861, 2, 'P20222861', 'AprilYandi Dwi W861', '56419974861', '3276022304010010861', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243861', 'Kp.Babakan No. 861', 'Islam', 4, 4, '150000.00', 3, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(862, 1, 'P20221862', 'AprilYandi Dwi W862', '56419974862', '3276022304010010862', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243862', 'Kp.Babakan No. 862', 'Islam', 12, 10, '150000.00', 2, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(863, 3, 'P20223863', 'AprilYandi Dwi W863', '56419974863', '3276022304010010863', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243863', 'Kp.Babakan No. 863', 'Islam', 7, 7, NULL, NULL, 'Tidak', '2022-12-11 06:48:28', NULL, NULL, NULL),
(864, 1, 'P20221864', 'AprilYandi Dwi W864', '56419974864', '3276022304010010864', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243864', 'Kp.Babakan No. 864', 'Islam', 13, 7, '150000.00', 3, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(865, 2, 'P20222865', 'AprilYandi Dwi W865', '56419974865', '3276022304010010865', 'Semarang', '2001-04-20', 'Perempuan', '08810243865', 'Kp.Babakan No. 865', 'Islam', 1, 11, '150000.00', 2, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(866, 2, 'P20222866', 'AprilYandi Dwi W866', '56419974866', '3276022304010010866', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243866', 'Kp.Babakan No. 866', 'Islam', 2, 3, '150000.00', 2, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(867, 2, 'P20222867', 'AprilYandi Dwi W867', '56419974867', '3276022304010010867', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243867', 'Kp.Babakan No. 867', 'Islam', 6, 12, '150000.00', 3, 'Ya', '2022-12-11 06:48:28', NULL, NULL, NULL),
(868, 3, 'P20223868', 'AprilYandi Dwi W868', '56419974868', '3276022304010010868', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243868', 'Kp.Babakan No. 868', 'Islam', 13, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:29', NULL, NULL, NULL),
(869, 1, 'P20221869', 'AprilYandi Dwi W869', '56419974869', '3276022304010010869', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243869', 'Kp.Babakan No. 869', 'Islam', 10, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:29', NULL, NULL, NULL),
(870, 2, 'P20222870', 'AprilYandi Dwi W870', '56419974870', '3276022304010010870', 'Semarang', '2001-04-16', 'Perempuan', '08810243870', 'Kp.Babakan No. 870', 'Islam', 6, 5, '150000.00', 4, 'Ya', '2022-12-11 06:48:29', NULL, NULL, NULL),
(871, 1, 'P20221871', 'AprilYandi Dwi W871', '56419974871', '3276022304010010871', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243871', 'Kp.Babakan No. 871', 'Islam', 4, 11, '150000.00', 2, 'Ya', '2022-12-11 06:48:29', NULL, NULL, NULL),
(872, 3, 'P20223872', 'AprilYandi Dwi W872', '56419974872', '3276022304010010872', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243872', 'Kp.Babakan No. 872', 'Islam', 4, 12, NULL, NULL, 'Tidak', '2022-12-11 06:48:29', NULL, NULL, NULL),
(873, 2, 'P20222873', 'AprilYandi Dwi W873', '56419974873', '3276022304010010873', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243873', 'Kp.Babakan No. 873', 'Islam', 3, 1, '150000.00', 4, 'Ya', '2022-12-11 06:48:29', NULL, NULL, NULL),
(874, 2, 'P20222874', 'AprilYandi Dwi W874', '56419974874', '3276022304010010874', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243874', 'Kp.Babakan No. 874', 'Islam', 12, 8, '150000.00', 4, 'Ya', '2022-12-11 06:48:29', NULL, NULL, NULL),
(875, 1, 'P20221875', 'AprilYandi Dwi W875', '56419974875', '3276022304010010875', 'Semarang', '2001-03-27', 'Perempuan', '08810243875', 'Kp.Babakan No. 875', 'Islam', 4, 3, '150000.00', 4, 'Ya', '2022-12-11 06:48:29', NULL, NULL, NULL),
(876, 3, 'P20223876', 'AprilYandi Dwi W876', '56419974876', '3276022304010010876', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243876', 'Kp.Babakan No. 876', 'Islam', 3, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:30', NULL, NULL, NULL),
(877, 1, 'P20221877', 'AprilYandi Dwi W877', '56419974877', '3276022304010010877', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243877', 'Kp.Babakan No. 877', 'Islam', 1, 1, '150000.00', 2, 'Ya', '2022-12-11 06:48:30', NULL, NULL, NULL),
(878, 1, 'P20221878', 'AprilYandi Dwi W878', '56419974878', '3276022304010010878', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243878', 'Kp.Babakan No. 878', 'Islam', 11, 3, '150000.00', 2, 'Ya', '2022-12-11 06:48:30', NULL, NULL, NULL),
(879, 3, 'P20223879', 'AprilYandi Dwi W879', '56419974879', '3276022304010010879', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243879', 'Kp.Babakan No. 879', 'Islam', 5, 13, NULL, NULL, 'Tidak', '2022-12-11 06:48:30', NULL, NULL, NULL),
(880, 2, 'P20222880', 'AprilYandi Dwi W880', '56419974880', '3276022304010010880', 'Semarang', '2001-03-28', 'Perempuan', '08810243880', 'Kp.Babakan No. 880', 'Islam', 4, 4, '150000.00', 1, 'Ya', '2022-12-11 06:48:30', NULL, NULL, NULL),
(881, 2, 'P20222881', 'AprilYandi Dwi W881', '56419974881', '3276022304010010881', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243881', 'Kp.Babakan No. 881', 'Islam', 10, 13, '150000.00', 2, 'Ya', '2022-12-11 06:48:30', NULL, NULL, NULL),
(882, 3, 'P20223882', 'AprilYandi Dwi W882', '56419974882', '3276022304010010882', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243882', 'Kp.Babakan No. 882', 'Islam', 3, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:30', NULL, NULL, NULL),
(883, 1, 'P20221883', 'AprilYandi Dwi W883', '56419974883', '3276022304010010883', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243883', 'Kp.Babakan No. 883', 'Islam', 13, 2, '150000.00', 1, 'Ya', '2022-12-11 06:48:30', NULL, NULL, NULL),
(884, 3, 'P20223884', 'AprilYandi Dwi W884', '56419974884', '3276022304010010884', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243884', 'Kp.Babakan No. 884', 'Islam', 2, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:31', NULL, NULL, NULL),
(885, 2, 'P20222885', 'AprilYandi Dwi W885', '56419974885', '3276022304010010885', 'Semarang', '2001-04-05', 'Perempuan', '08810243885', 'Kp.Babakan No. 885', 'Islam', 6, 8, '150000.00', 4, 'Ya', '2022-12-11 06:48:31', NULL, NULL, NULL),
(886, 2, 'P20222886', 'AprilYandi Dwi W886', '56419974886', '3276022304010010886', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243886', 'Kp.Babakan No. 886', 'Islam', 11, 13, '150000.00', 2, 'Ya', '2022-12-11 06:48:31', NULL, NULL, NULL),
(887, 3, 'P20223887', 'AprilYandi Dwi W887', '56419974887', '3276022304010010887', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243887', 'Kp.Babakan No. 887', 'Islam', 9, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:31', NULL, NULL, NULL),
(888, 3, 'P20223888', 'AprilYandi Dwi W888', '56419974888', '3276022304010010888', 'Jakarta', '2001-03-28', 'Laki-Laki', '08810243888', 'Kp.Babakan No. 888', 'Islam', 1, 4, NULL, NULL, 'Tidak', '2022-12-11 06:48:31', NULL, NULL, NULL),
(889, 1, 'P20221889', 'AprilYandi Dwi W889', '56419974889', '3276022304010010889', 'Jakarta', '2001-03-31', 'Laki-Laki', '08810243889', 'Kp.Babakan No. 889', 'Islam', 3, 6, '150000.00', 1, 'Ya', '2022-12-11 06:48:31', NULL, NULL, NULL),
(890, 2, 'P20222890', 'AprilYandi Dwi W890', '56419974890', '3276022304010010890', 'Semarang', '2001-03-31', 'Perempuan', '08810243890', 'Kp.Babakan No. 890', 'Islam', 2, 5, '150000.00', 2, 'Ya', '2022-12-11 06:48:31', NULL, NULL, NULL),
(891, 2, 'P20222891', 'AprilYandi Dwi W891', '56419974891', '3276022304010010891', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243891', 'Kp.Babakan No. 891', 'Islam', 3, 5, '150000.00', 2, 'Ya', '2022-12-11 06:48:31', NULL, NULL, NULL),
(892, 1, 'P20221892', 'AprilYandi Dwi W892', '56419974892', '3276022304010010892', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243892', 'Kp.Babakan No. 892', 'Islam', 11, 10, '150000.00', 3, 'Ya', '2022-12-11 06:48:31', NULL, NULL, NULL),
(893, 3, 'P20223893', 'AprilYandi Dwi W893', '56419974893', '3276022304010010893', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243893', 'Kp.Babakan No. 893', 'Islam', 9, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:31', NULL, NULL, NULL),
(894, 1, 'P20221894', 'AprilYandi Dwi W894', '56419974894', '3276022304010010894', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243894', 'Kp.Babakan No. 894', 'Islam', 4, 10, '150000.00', 4, 'Ya', '2022-12-11 06:48:32', NULL, NULL, NULL),
(895, 2, 'P20222895', 'AprilYandi Dwi W895', '56419974895', '3276022304010010895', 'Semarang', '2001-04-01', 'Perempuan', '08810243895', 'Kp.Babakan No. 895', 'Islam', 6, 3, '150000.00', 4, 'Ya', '2022-12-11 06:48:32', NULL, NULL, NULL),
(896, 3, 'P20223896', 'AprilYandi Dwi W896', '56419974896', '3276022304010010896', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243896', 'Kp.Babakan No. 896', 'Islam', 2, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:32', NULL, NULL, NULL),
(897, 2, 'P20222897', 'AprilYandi Dwi W897', '56419974897', '3276022304010010897', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243897', 'Kp.Babakan No. 897', 'Islam', 13, 4, '150000.00', 4, 'Ya', '2022-12-11 06:48:32', NULL, NULL, NULL),
(898, 1, 'P20221898', 'AprilYandi Dwi W898', '56419974898', '3276022304010010898', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243898', 'Kp.Babakan No. 898', 'Islam', 12, 8, '150000.00', 1, 'Ya', '2022-12-11 06:48:32', NULL, NULL, NULL),
(899, 2, 'P20222899', 'AprilYandi Dwi W899', '56419974899', '3276022304010010899', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243899', 'Kp.Babakan No. 899', 'Islam', 5, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:32', NULL, NULL, NULL),
(900, 2, 'P20222900', 'AprilYandi Dwi W900', '56419974900', '3276022304010010900', 'Semarang', '2001-04-02', 'Perempuan', '08810243900', 'Kp.Babakan No. 900', 'Islam', 6, 8, '150000.00', 3, 'Ya', '2022-12-11 06:48:32', NULL, NULL, NULL),
(901, 3, 'P20223901', 'AprilYandi Dwi W901', '56419974901', '3276022304010010901', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243901', 'Kp.Babakan No. 901', 'Islam', 10, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:32', NULL, NULL, NULL),
(902, 1, 'P20221902', 'AprilYandi Dwi W902', '56419974902', '3276022304010010902', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243902', 'Kp.Babakan No. 902', 'Islam', 13, 12, '150000.00', 2, 'Ya', '2022-12-11 06:48:33', NULL, NULL, NULL),
(903, 3, 'P20223903', 'AprilYandi Dwi W903', '56419974903', '3276022304010010903', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243903', 'Kp.Babakan No. 903', 'Islam', 7, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:33', NULL, NULL, NULL),
(904, 3, 'P20223904', 'AprilYandi Dwi W904', '56419974904', '3276022304010010904', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243904', 'Kp.Babakan No. 904', 'Islam', 7, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:34', NULL, NULL, NULL),
(905, 3, 'P20223905', 'AprilYandi Dwi W905', '56419974905', '3276022304010010905', 'Semarang', '2001-03-25', 'Perempuan', '08810243905', 'Kp.Babakan No. 905', 'Islam', 9, 7, NULL, NULL, 'Tidak', '2022-12-11 06:48:34', NULL, NULL, NULL),
(906, 2, 'P20222906', 'AprilYandi Dwi W906', '56419974906', '3276022304010010906', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243906', 'Kp.Babakan No. 906', 'Islam', 6, 5, '150000.00', 1, 'Ya', '2022-12-11 06:48:34', NULL, NULL, NULL),
(907, 3, 'P20223907', 'AprilYandi Dwi W907', '56419974907', '3276022304010010907', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243907', 'Kp.Babakan No. 907', 'Islam', 10, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:35', NULL, NULL, NULL),
(908, 2, 'P20222908', 'AprilYandi Dwi W908', '56419974908', '3276022304010010908', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243908', 'Kp.Babakan No. 908', 'Islam', 10, 11, '150000.00', 4, 'Ya', '2022-12-11 06:48:35', NULL, NULL, NULL),
(909, 2, 'P20222909', 'AprilYandi Dwi W909', '56419974909', '3276022304010010909', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243909', 'Kp.Babakan No. 909', 'Islam', 7, 9, '150000.00', 3, 'Ya', '2022-12-11 06:48:35', NULL, NULL, NULL),
(910, 1, 'P20221910', 'AprilYandi Dwi W910', '56419974910', '3276022304010010910', 'Semarang', '2001-03-30', 'Perempuan', '08810243910', 'Kp.Babakan No. 910', 'Islam', 9, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:35', NULL, NULL, NULL),
(911, 1, 'P20221911', 'AprilYandi Dwi W911', '56419974911', '3276022304010010911', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243911', 'Kp.Babakan No. 911', 'Islam', 1, 4, '150000.00', 2, 'Ya', '2022-12-11 06:48:36', NULL, NULL, NULL),
(912, 1, 'P20221912', 'AprilYandi Dwi W912', '56419974912', '3276022304010010912', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243912', 'Kp.Babakan No. 912', 'Islam', 13, 12, '150000.00', 1, 'Ya', '2022-12-11 06:48:36', NULL, NULL, NULL),
(913, 2, 'P20222913', 'AprilYandi Dwi W913', '56419974913', '3276022304010010913', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243913', 'Kp.Babakan No. 913', 'Islam', 3, 13, '150000.00', 2, 'Ya', '2022-12-11 06:48:36', NULL, NULL, NULL),
(914, 1, 'P20221914', 'AprilYandi Dwi W914', '56419974914', '3276022304010010914', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243914', 'Kp.Babakan No. 914', 'Islam', 1, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:36', NULL, NULL, NULL),
(915, 2, 'P20222915', 'AprilYandi Dwi W915', '56419974915', '3276022304010010915', 'Semarang', '2001-04-11', 'Perempuan', '08810243915', 'Kp.Babakan No. 915', 'Islam', 8, 4, '150000.00', 4, 'Ya', '2022-12-11 06:48:36', NULL, NULL, NULL),
(916, 3, 'P20223916', 'AprilYandi Dwi W916', '56419974916', '3276022304010010916', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243916', 'Kp.Babakan No. 916', 'Islam', 6, 13, NULL, NULL, 'Tidak', '2022-12-11 06:48:36', NULL, NULL, NULL),
(917, 3, 'P20223917', 'AprilYandi Dwi W917', '56419974917', '3276022304010010917', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243917', 'Kp.Babakan No. 917', 'Islam', 13, 6, NULL, NULL, 'Tidak', '2022-12-11 06:48:37', NULL, NULL, NULL),
(918, 2, 'P20222918', 'AprilYandi Dwi W918', '56419974918', '3276022304010010918', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243918', 'Kp.Babakan No. 918', 'Islam', 5, 1, '150000.00', 2, 'Ya', '2022-12-11 06:48:37', NULL, NULL, NULL),
(919, 1, 'P20221919', 'AprilYandi Dwi W919', '56419974919', '3276022304010010919', 'Jakarta', '2001-04-04', 'Laki-Laki', '08810243919', 'Kp.Babakan No. 919', 'Islam', 10, 8, '150000.00', 1, 'Ya', '2022-12-11 06:48:37', NULL, NULL, NULL),
(920, 2, 'P20222920', 'AprilYandi Dwi W920', '56419974920', '3276022304010010920', 'Semarang', '2001-04-07', 'Perempuan', '08810243920', 'Kp.Babakan No. 920', 'Islam', 12, 5, '150000.00', 4, 'Ya', '2022-12-11 06:48:37', NULL, NULL, NULL),
(921, 3, 'P20223921', 'AprilYandi Dwi W921', '56419974921', '3276022304010010921', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243921', 'Kp.Babakan No. 921', 'Islam', 12, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:37', NULL, NULL, NULL),
(922, 3, 'P20223922', 'AprilYandi Dwi W922', '56419974922', '3276022304010010922', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243922', 'Kp.Babakan No. 922', 'Islam', 3, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:37', NULL, NULL, NULL),
(923, 3, 'P20223923', 'AprilYandi Dwi W923', '56419974923', '3276022304010010923', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243923', 'Kp.Babakan No. 923', 'Islam', 6, 4, NULL, NULL, 'Tidak', '2022-12-11 06:48:37', NULL, NULL, NULL),
(924, 1, 'P20221924', 'AprilYandi Dwi W924', '56419974924', '3276022304010010924', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243924', 'Kp.Babakan No. 924', 'Islam', 7, 2, '150000.00', 1, 'Ya', '2022-12-11 06:48:38', NULL, NULL, NULL),
(925, 1, 'P20221925', 'AprilYandi Dwi W925', '56419974925', '3276022304010010925', 'Semarang', '2001-04-19', 'Perempuan', '08810243925', 'Kp.Babakan No. 925', 'Islam', 8, 2, '150000.00', 1, 'Ya', '2022-12-11 06:48:38', NULL, NULL, NULL),
(926, 3, 'P20223926', 'AprilYandi Dwi W926', '56419974926', '3276022304010010926', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243926', 'Kp.Babakan No. 926', 'Islam', 9, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:38', NULL, NULL, NULL),
(927, 1, 'P20221927', 'AprilYandi Dwi W927', '56419974927', '3276022304010010927', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243927', 'Kp.Babakan No. 927', 'Islam', 13, 8, '150000.00', 4, 'Ya', '2022-12-11 06:48:38', NULL, NULL, NULL),
(928, 1, 'P20221928', 'AprilYandi Dwi W928', '56419974928', '3276022304010010928', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243928', 'Kp.Babakan No. 928', 'Islam', 3, 4, '150000.00', 3, 'Ya', '2022-12-11 06:48:39', NULL, NULL, NULL),
(929, 3, 'P20223929', 'AprilYandi Dwi W929', '56419974929', '3276022304010010929', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243929', 'Kp.Babakan No. 929', 'Islam', 13, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:39', NULL, NULL, NULL),
(930, 3, 'P20223930', 'AprilYandi Dwi W930', '56419974930', '3276022304010010930', 'Semarang', '2001-04-23', 'Perempuan', '08810243930', 'Kp.Babakan No. 930', 'Islam', 1, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:39', NULL, NULL, NULL),
(931, 2, 'P20222931', 'AprilYandi Dwi W931', '56419974931', '3276022304010010931', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243931', 'Kp.Babakan No. 931', 'Islam', 2, 11, '150000.00', 4, 'Ya', '2022-12-11 06:48:39', NULL, NULL, NULL),
(932, 1, 'P20221932', 'AprilYandi Dwi W932', '56419974932', '3276022304010010932', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243932', 'Kp.Babakan No. 932', 'Islam', 7, 2, '150000.00', 3, 'Ya', '2022-12-11 06:48:39', NULL, NULL, NULL),
(933, 2, 'P20222933', 'AprilYandi Dwi W933', '56419974933', '3276022304010010933', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243933', 'Kp.Babakan No. 933', 'Islam', 8, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:39', NULL, NULL, NULL),
(934, 1, 'P20221934', 'AprilYandi Dwi W934', '56419974934', '3276022304010010934', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243934', 'Kp.Babakan No. 934', 'Islam', 8, 3, '150000.00', 1, 'Ya', '2022-12-11 06:48:39', NULL, NULL, NULL),
(935, 1, 'P20221935', 'AprilYandi Dwi W935', '56419974935', '3276022304010010935', 'Semarang', '2001-04-08', 'Perempuan', '08810243935', 'Kp.Babakan No. 935', 'Islam', 9, 9, '150000.00', 4, 'Ya', '2022-12-11 06:48:39', NULL, NULL, NULL),
(936, 3, 'P20223936', 'AprilYandi Dwi W936', '56419974936', '3276022304010010936', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243936', 'Kp.Babakan No. 936', 'Islam', 8, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:39', NULL, NULL, NULL),
(937, 2, 'P20222937', 'AprilYandi Dwi W937', '56419974937', '3276022304010010937', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243937', 'Kp.Babakan No. 937', 'Islam', 1, 6, '150000.00', 1, 'Ya', '2022-12-11 06:48:40', NULL, NULL, NULL),
(938, 3, 'P20223938', 'AprilYandi Dwi W938', '56419974938', '3276022304010010938', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243938', 'Kp.Babakan No. 938', 'Islam', 1, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:40', NULL, NULL, NULL),
(939, 1, 'P20221939', 'AprilYandi Dwi W939', '56419974939', '3276022304010010939', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243939', 'Kp.Babakan No. 939', 'Islam', 7, 7, '150000.00', 3, 'Ya', '2022-12-11 06:48:40', NULL, NULL, NULL),
(940, 1, 'P20221940', 'AprilYandi Dwi W940', '56419974940', '3276022304010010940', 'Semarang', '2001-04-01', 'Perempuan', '08810243940', 'Kp.Babakan No. 940', 'Islam', 10, 12, '150000.00', 2, 'Ya', '2022-12-11 06:48:40', NULL, NULL, NULL),
(941, 3, 'P20223941', 'AprilYandi Dwi W941', '56419974941', '3276022304010010941', 'Jakarta', '2001-04-17', 'Laki-Laki', '08810243941', 'Kp.Babakan No. 941', 'Islam', 11, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:41', NULL, NULL, NULL),
(942, 2, 'P20222942', 'AprilYandi Dwi W942', '56419974942', '3276022304010010942', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243942', 'Kp.Babakan No. 942', 'Islam', 7, 9, '150000.00', 3, 'Ya', '2022-12-11 06:48:41', NULL, NULL, NULL),
(943, 3, 'P20223943', 'AprilYandi Dwi W943', '56419974943', '3276022304010010943', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243943', 'Kp.Babakan No. 943', 'Islam', 10, 1, NULL, NULL, 'Tidak', '2022-12-11 06:48:41', NULL, NULL, NULL),
(944, 1, 'P20221944', 'AprilYandi Dwi W944', '56419974944', '3276022304010010944', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243944', 'Kp.Babakan No. 944', 'Islam', 2, 12, '150000.00', 2, 'Ya', '2022-12-11 06:48:41', NULL, NULL, NULL),
(945, 2, 'P20222945', 'AprilYandi Dwi W945', '56419974945', '3276022304010010945', 'Semarang', '2001-04-01', 'Perempuan', '08810243945', 'Kp.Babakan No. 945', 'Islam', 12, 2, '150000.00', 3, 'Ya', '2022-12-11 06:48:41', NULL, NULL, NULL),
(946, 2, 'P20222946', 'AprilYandi Dwi W946', '56419974946', '3276022304010010946', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243946', 'Kp.Babakan No. 946', 'Islam', 13, 6, '150000.00', 2, 'Ya', '2022-12-11 06:48:41', NULL, NULL, NULL),
(947, 1, 'P20221947', 'AprilYandi Dwi W947', '56419974947', '3276022304010010947', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243947', 'Kp.Babakan No. 947', 'Islam', 7, 12, '150000.00', 2, 'Ya', '2022-12-11 06:48:41', NULL, NULL, NULL),
(948, 2, 'P20222948', 'AprilYandi Dwi W948', '56419974948', '3276022304010010948', 'Jakarta', '2001-03-27', 'Laki-Laki', '08810243948', 'Kp.Babakan No. 948', 'Islam', 7, 8, '150000.00', 4, 'Ya', '2022-12-11 06:48:42', NULL, NULL, NULL),
(949, 2, 'P20222949', 'AprilYandi Dwi W949', '56419974949', '3276022304010010949', 'Jakarta', '2001-04-21', 'Laki-Laki', '08810243949', 'Kp.Babakan No. 949', 'Islam', 9, 13, '150000.00', 4, 'Ya', '2022-12-11 06:48:42', NULL, NULL, NULL),
(950, 3, 'P20223950', 'AprilYandi Dwi W950', '56419974950', '3276022304010010950', 'Semarang', '2001-04-20', 'Perempuan', '08810243950', 'Kp.Babakan No. 950', 'Islam', 11, 4, NULL, NULL, 'Tidak', '2022-12-11 06:48:42', NULL, NULL, NULL),
(951, 3, 'P20223951', 'AprilYandi Dwi W951', '56419974951', '3276022304010010951', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243951', 'Kp.Babakan No. 951', 'Islam', 1, 9, NULL, NULL, 'Tidak', '2022-12-11 06:48:42', NULL, NULL, NULL),
(952, 1, 'P20221952', 'AprilYandi Dwi W952', '56419974952', '3276022304010010952', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243952', 'Kp.Babakan No. 952', 'Islam', 4, 8, '150000.00', 4, 'Ya', '2022-12-11 06:48:42', NULL, NULL, NULL),
(953, 2, 'P20222953', 'AprilYandi Dwi W953', '56419974953', '3276022304010010953', 'Jakarta', '2001-04-23', 'Laki-Laki', '08810243953', 'Kp.Babakan No. 953', 'Islam', 13, 3, '150000.00', 1, 'Ya', '2022-12-11 06:48:43', NULL, NULL, NULL),
(954, 2, 'P20222954', 'AprilYandi Dwi W954', '56419974954', '3276022304010010954', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243954', 'Kp.Babakan No. 954', 'Islam', 1, 12, '150000.00', 4, 'Ya', '2022-12-11 06:48:43', NULL, NULL, NULL),
(955, 3, 'P20223955', 'AprilYandi Dwi W955', '56419974955', '3276022304010010955', 'Semarang', '2001-04-11', 'Perempuan', '08810243955', 'Kp.Babakan No. 955', 'Islam', 12, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:43', NULL, NULL, NULL),
(956, 1, 'P20221956', 'AprilYandi Dwi W956', '56419974956', '3276022304010010956', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243956', 'Kp.Babakan No. 956', 'Islam', 11, 5, '150000.00', 4, 'Ya', '2022-12-11 06:48:43', NULL, NULL, NULL),
(957, 3, 'P20223957', 'AprilYandi Dwi W957', '56419974957', '3276022304010010957', 'Jakarta', '2001-04-07', 'Laki-Laki', '08810243957', 'Kp.Babakan No. 957', 'Islam', 1, 5, NULL, NULL, 'Tidak', '2022-12-11 06:48:43', NULL, NULL, NULL),
(958, 1, 'P20221958', 'AprilYandi Dwi W958', '56419974958', '3276022304010010958', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243958', 'Kp.Babakan No. 958', 'Islam', 8, 2, '150000.00', 2, 'Ya', '2022-12-11 06:48:43', NULL, NULL, NULL),
(959, 3, 'P20223959', 'AprilYandi Dwi W959', '56419974959', '3276022304010010959', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243959', 'Kp.Babakan No. 959', 'Islam', 12, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:43', NULL, NULL, NULL),
(960, 2, 'P20222960', 'AprilYandi Dwi W960', '56419974960', '3276022304010010960', 'Semarang', '2001-03-26', 'Perempuan', '08810243960', 'Kp.Babakan No. 960', 'Islam', 8, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:43', NULL, NULL, NULL),
(961, 3, 'P20223961', 'AprilYandi Dwi W961', '56419974961', '3276022304010010961', 'Jakarta', '2001-03-30', 'Laki-Laki', '08810243961', 'Kp.Babakan No. 961', 'Islam', 13, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:44', NULL, NULL, NULL),
(962, 3, 'P20223962', 'AprilYandi Dwi W962', '56419974962', '3276022304010010962', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243962', 'Kp.Babakan No. 962', 'Islam', 11, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:44', NULL, NULL, NULL),
(963, 1, 'P20221963', 'AprilYandi Dwi W963', '56419974963', '3276022304010010963', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243963', 'Kp.Babakan No. 963', 'Islam', 4, 2, '150000.00', 4, 'Ya', '2022-12-11 06:48:44', NULL, NULL, NULL),
(964, 2, 'P20222964', 'AprilYandi Dwi W964', '56419974964', '3276022304010010964', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243964', 'Kp.Babakan No. 964', 'Islam', 10, 13, '150000.00', 2, 'Ya', '2022-12-11 06:48:44', NULL, NULL, NULL),
(965, 2, 'P20222965', 'AprilYandi Dwi W965', '56419974965', '3276022304010010965', 'Semarang', '2001-04-13', 'Perempuan', '08810243965', 'Kp.Babakan No. 965', 'Islam', 7, 7, '150000.00', 1, 'Ya', '2022-12-11 06:48:44', NULL, NULL, NULL),
(966, 2, 'P20222966', 'AprilYandi Dwi W966', '56419974966', '3276022304010010966', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243966', 'Kp.Babakan No. 966', 'Islam', 2, 13, '150000.00', 4, 'Ya', '2022-12-11 06:48:44', NULL, NULL, NULL),
(967, 3, 'P20223967', 'AprilYandi Dwi W967', '56419974967', '3276022304010010967', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243967', 'Kp.Babakan No. 967', 'Islam', 7, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:44', NULL, NULL, NULL),
(968, 3, 'P20223968', 'AprilYandi Dwi W968', '56419974968', '3276022304010010968', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243968', 'Kp.Babakan No. 968', 'Islam', 2, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:45', NULL, NULL, NULL),
(969, 3, 'P20223969', 'AprilYandi Dwi W969', '56419974969', '3276022304010010969', 'Jakarta', '2001-04-06', 'Laki-Laki', '08810243969', 'Kp.Babakan No. 969', 'Islam', 10, 8, NULL, NULL, 'Tidak', '2022-12-11 06:48:45', NULL, NULL, NULL),
(970, 1, 'P20221970', 'AprilYandi Dwi W970', '56419974970', '3276022304010010970', 'Semarang', '2001-04-23', 'Perempuan', '08810243970', 'Kp.Babakan No. 970', 'Islam', 13, 2, '150000.00', 3, 'Ya', '2022-12-11 06:48:45', NULL, NULL, NULL),
(971, 3, 'P20223971', 'AprilYandi Dwi W971', '56419974971', '3276022304010010971', 'Jakarta', '2001-04-13', 'Laki-Laki', '08810243971', 'Kp.Babakan No. 971', 'Islam', 6, 7, NULL, NULL, 'Tidak', '2022-12-11 06:48:45', NULL, NULL, NULL),
(972, 3, 'P20223972', 'AprilYandi Dwi W972', '56419974972', '3276022304010010972', 'Jakarta', '2001-04-19', 'Laki-Laki', '08810243972', 'Kp.Babakan No. 972', 'Islam', 5, 7, NULL, NULL, 'Tidak', '2022-12-11 06:48:45', NULL, NULL, NULL),
(973, 1, 'P20221973', 'AprilYandi Dwi W973', '56419974973', '3276022304010010973', 'Jakarta', '2001-04-12', 'Laki-Laki', '08810243973', 'Kp.Babakan No. 973', 'Islam', 6, 9, '150000.00', 3, 'Ya', '2022-12-11 06:48:45', NULL, NULL, NULL),
(974, 1, 'P20221974', 'AprilYandi Dwi W974', '56419974974', '3276022304010010974', 'Jakarta', '2001-04-09', 'Laki-Laki', '08810243974', 'Kp.Babakan No. 974', 'Islam', 10, 6, '150000.00', 4, 'Ya', '2022-12-11 06:48:45', NULL, NULL, NULL),
(975, 2, 'P20222975', 'AprilYandi Dwi W975', '56419974975', '3276022304010010975', 'Semarang', '2001-04-08', 'Perempuan', '08810243975', 'Kp.Babakan No. 975', 'Islam', 9, 7, '150000.00', 4, 'Ya', '2022-12-11 06:48:45', NULL, NULL, NULL),
(976, 1, 'P20221976', 'AprilYandi Dwi W976', '56419974976', '3276022304010010976', 'Jakarta', '2001-04-01', 'Laki-Laki', '08810243976', 'Kp.Babakan No. 976', 'Islam', 2, 10, '150000.00', 4, 'Ya', '2022-12-11 06:48:46', NULL, NULL, NULL),
(977, 3, 'P20223977', 'AprilYandi Dwi W977', '56419974977', '3276022304010010977', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243977', 'Kp.Babakan No. 977', 'Islam', 12, 12, NULL, NULL, 'Tidak', '2022-12-11 06:48:46', NULL, NULL, NULL),
(978, 1, 'P20221978', 'AprilYandi Dwi W978', '56419974978', '3276022304010010978', 'Jakarta', '2001-04-05', 'Laki-Laki', '08810243978', 'Kp.Babakan No. 978', 'Islam', 3, 10, '150000.00', 1, 'Ya', '2022-12-11 06:48:46', NULL, NULL, NULL),
(979, 3, 'P20223979', 'AprilYandi Dwi W979', '56419974979', '3276022304010010979', 'Jakarta', '2001-03-29', 'Laki-Laki', '08810243979', 'Kp.Babakan No. 979', 'Islam', 6, 1, NULL, NULL, 'Tidak', '2022-12-11 06:48:46', NULL, NULL, NULL),
(980, 1, 'P20221980', 'AprilYandi Dwi W980', '56419974980', '3276022304010010980', 'Semarang', '2001-04-02', 'Perempuan', '08810243980', 'Kp.Babakan No. 980', 'Islam', 8, 6, '150000.00', 4, 'Ya', '2022-12-11 06:48:46', NULL, NULL, NULL),
(981, 3, 'P20223981', 'AprilYandi Dwi W981', '56419974981', '3276022304010010981', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243981', 'Kp.Babakan No. 981', 'Islam', 5, 5, NULL, NULL, 'Tidak', '2022-12-11 06:48:46', NULL, NULL, NULL),
(982, 1, 'P20221982', 'AprilYandi Dwi W982', '56419974982', '3276022304010010982', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243982', 'Kp.Babakan No. 982', 'Islam', 2, 8, '150000.00', 2, 'Ya', '2022-12-11 06:48:46', NULL, NULL, NULL),
(983, 1, 'P20221983', 'AprilYandi Dwi W983', '56419974983', '3276022304010010983', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243983', 'Kp.Babakan No. 983', 'Islam', 13, 9, '150000.00', 2, 'Ya', '2022-12-11 06:48:47', NULL, NULL, NULL),
(984, 2, 'P20222984', 'AprilYandi Dwi W984', '56419974984', '3276022304010010984', 'Jakarta', '2001-04-18', 'Laki-Laki', '08810243984', 'Kp.Babakan No. 984', 'Islam', 5, 4, '150000.00', 1, 'Ya', '2022-12-11 06:48:47', NULL, NULL, NULL),
(985, 2, 'P20222985', 'AprilYandi Dwi W985', '56419974985', '3276022304010010985', 'Semarang', '2001-03-31', 'Perempuan', '08810243985', 'Kp.Babakan No. 985', 'Islam', 1, 11, '150000.00', 4, 'Ya', '2022-12-11 06:48:47', NULL, NULL, NULL),
(986, 3, 'P20223986', 'AprilYandi Dwi W986', '56419974986', '3276022304010010986', 'Jakarta', '2001-03-25', 'Laki-Laki', '08810243986', 'Kp.Babakan No. 986', 'Islam', 4, 13, NULL, NULL, 'Tidak', '2022-12-11 06:48:47', NULL, NULL, NULL),
(987, 1, 'P20221987', 'AprilYandi Dwi W987', '56419974987', '3276022304010010987', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243987', 'Kp.Babakan No. 987', 'Islam', 7, 5, '150000.00', 1, 'Ya', '2022-12-11 06:48:47', NULL, NULL, NULL),
(988, 3, 'P20223988', 'AprilYandi Dwi W988', '56419974988', '3276022304010010988', 'Jakarta', '2001-04-20', 'Laki-Laki', '08810243988', 'Kp.Babakan No. 988', 'Islam', 13, 3, NULL, NULL, 'Tidak', '2022-12-11 06:48:47', NULL, NULL, NULL),
(989, 3, 'P20223989', 'AprilYandi Dwi W989', '56419974989', '3276022304010010989', 'Jakarta', '2001-04-10', 'Laki-Laki', '08810243989', 'Kp.Babakan No. 989', 'Islam', 9, 4, NULL, NULL, 'Tidak', '2022-12-11 06:48:48', NULL, NULL, NULL),
(990, 1, 'P20221990', 'AprilYandi Dwi W990', '56419974990', '3276022304010010990', 'Semarang', '2001-04-12', 'Perempuan', '08810243990', 'Kp.Babakan No. 990', 'Islam', 12, 10, '150000.00', 1, 'Ya', '2022-12-11 06:48:48', NULL, NULL, NULL),
(991, 3, 'P20223991', 'AprilYandi Dwi W991', '56419974991', '3276022304010010991', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243991', 'Kp.Babakan No. 991', 'Islam', 6, 2, NULL, NULL, 'Tidak', '2022-12-11 06:48:48', NULL, NULL, NULL),
(992, 2, 'P20222992', 'AprilYandi Dwi W992', '56419974992', '3276022304010010992', 'Jakarta', '2001-04-11', 'Laki-Laki', '08810243992', 'Kp.Babakan No. 992', 'Islam', 3, 10, '150000.00', 4, 'Ya', '2022-12-11 06:48:49', NULL, NULL, NULL),
(993, 2, 'P20222993', 'AprilYandi Dwi W993', '56419974993', '3276022304010010993', 'Jakarta', '2001-04-02', 'Laki-Laki', '08810243993', 'Kp.Babakan No. 993', 'Islam', 2, 1, '150000.00', 3, 'Ya', '2022-12-11 06:48:49', NULL, NULL, NULL),
(994, 3, 'P20223994', 'AprilYandi Dwi W994', '56419974994', '3276022304010010994', 'Jakarta', '2001-04-08', 'Laki-Laki', '08810243994', 'Kp.Babakan No. 994', 'Islam', 12, 10, NULL, NULL, 'Tidak', '2022-12-11 06:48:49', NULL, NULL, NULL),
(995, 3, 'P20223995', 'AprilYandi Dwi W995', '56419974995', '3276022304010010995', 'Semarang', '2001-04-08', 'Perempuan', '08810243995', 'Kp.Babakan No. 995', 'Islam', 2, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:49', NULL, NULL, NULL),
(996, 3, 'P20223996', 'AprilYandi Dwi W996', '56419974996', '3276022304010010996', 'Jakarta', '2001-04-15', 'Laki-Laki', '08810243996', 'Kp.Babakan No. 996', 'Islam', 7, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:50', NULL, NULL, NULL),
(997, 1, 'P20221997', 'AprilYandi Dwi W997', '56419974997', '3276022304010010997', 'Jakarta', '2001-04-03', 'Laki-Laki', '08810243997', 'Kp.Babakan No. 997', 'Islam', 8, 4, '150000.00', 2, 'Ya', '2022-12-11 06:48:50', NULL, NULL, NULL),
(998, 3, 'P20223998', 'AprilYandi Dwi W998', '56419974998', '3276022304010010998', 'Jakarta', '2001-04-14', 'Laki-Laki', '08810243998', 'Kp.Babakan No. 998', 'Islam', 13, 13, NULL, NULL, 'Tidak', '2022-12-11 06:48:50', NULL, NULL, NULL),
(999, 3, 'P20223999', 'AprilYandi Dwi W999', '56419974999', '3276022304010010999', 'Jakarta', '2001-04-22', 'Laki-Laki', '08810243999', 'Kp.Babakan No. 999', 'Islam', 13, 11, NULL, NULL, 'Tidak', '2022-12-11 06:48:51', NULL, NULL, NULL),
(1000, 2, 'P202221000', 'AprilYandi Dwi W1000', '564199741000', '32760223040100101000', 'Semarang', '2001-04-15', 'Perempuan', '088102431000', 'Kp.Babakan No. 1000', 'Islam', 11, 5, '150000.00', 4, 'Ya', '2022-12-11 06:48:51', NULL, NULL, NULL);

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
(1, 4, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W4', 2022, 'public/uploads/prestasi/4', '2022-12-11 06:45:21', NULL, NULL, NULL),
(2, 17, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W17', 2022, 'public/uploads/prestasi/17', '2022-12-11 06:45:22', NULL, NULL, NULL),
(3, 20, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W20', 2022, 'public/uploads/prestasi/20', '2022-12-11 06:45:22', NULL, NULL, NULL),
(4, 22, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W22', 2022, 'public/uploads/prestasi/22', '2022-12-11 06:45:22', NULL, NULL, NULL),
(5, 23, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W23', 2022, 'public/uploads/prestasi/23', '2022-12-11 06:45:22', NULL, NULL, NULL),
(6, 27, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W27', 2022, 'public/uploads/prestasi/27', '2022-12-11 06:45:22', NULL, NULL, NULL),
(7, 36, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W36', 2022, 'public/uploads/prestasi/36', '2022-12-11 06:45:22', NULL, NULL, NULL),
(8, 42, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W42', 2022, 'public/uploads/prestasi/42', '2022-12-11 06:45:23', NULL, NULL, NULL),
(9, 46, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W46', 2022, 'public/uploads/prestasi/46', '2022-12-11 06:45:23', NULL, NULL, NULL),
(10, 49, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W49', 2022, 'public/uploads/prestasi/49', '2022-12-11 06:45:23', NULL, NULL, NULL),
(11, 50, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W50', 2022, 'public/uploads/prestasi/50', '2022-12-11 06:45:23', NULL, NULL, NULL),
(12, 51, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W51', 2022, 'public/uploads/prestasi/51', '2022-12-11 06:45:23', NULL, NULL, NULL),
(13, 58, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W58', 2022, 'public/uploads/prestasi/58', '2022-12-11 06:45:24', NULL, NULL, NULL),
(14, 60, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W60', 2022, 'public/uploads/prestasi/60', '2022-12-11 06:45:24', NULL, NULL, NULL),
(15, 67, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W67', 2022, 'public/uploads/prestasi/67', '2022-12-11 06:45:24', NULL, NULL, NULL),
(16, 69, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W69', 2022, 'public/uploads/prestasi/69', '2022-12-11 06:45:24', NULL, NULL, NULL),
(17, 76, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W76', 2022, 'public/uploads/prestasi/76', '2022-12-11 06:45:25', NULL, NULL, NULL),
(18, 77, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W77', 2022, 'public/uploads/prestasi/77', '2022-12-11 06:45:25', NULL, NULL, NULL),
(19, 78, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W78', 2022, 'public/uploads/prestasi/78', '2022-12-11 06:45:25', NULL, NULL, NULL),
(20, 81, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W81', 2022, 'public/uploads/prestasi/81', '2022-12-11 06:45:25', NULL, NULL, NULL),
(21, 82, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W82', 2022, 'public/uploads/prestasi/82', '2022-12-11 06:45:25', NULL, NULL, NULL),
(22, 85, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W85', 2022, 'public/uploads/prestasi/85', '2022-12-11 06:45:25', NULL, NULL, NULL),
(23, 86, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W86', 2022, 'public/uploads/prestasi/86', '2022-12-11 06:45:25', NULL, NULL, NULL),
(24, 89, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W89', 2022, 'public/uploads/prestasi/89', '2022-12-11 06:45:26', NULL, NULL, NULL),
(25, 92, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W92', 2022, 'public/uploads/prestasi/92', '2022-12-11 06:45:26', NULL, NULL, NULL),
(26, 93, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W93', 2022, 'public/uploads/prestasi/93', '2022-12-11 06:45:26', NULL, NULL, NULL),
(27, 94, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W94', 2022, 'public/uploads/prestasi/94', '2022-12-11 06:45:26', NULL, NULL, NULL),
(28, 97, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W97', 2022, 'public/uploads/prestasi/97', '2022-12-11 06:45:26', NULL, NULL, NULL),
(29, 99, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W99', 2022, 'public/uploads/prestasi/99', '2022-12-11 06:45:27', NULL, NULL, NULL),
(30, 100, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W100', 2022, 'public/uploads/prestasi/100', '2022-12-11 06:45:27', NULL, NULL, NULL),
(31, 104, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W104', 2022, 'public/uploads/prestasi/104', '2022-12-11 06:45:27', NULL, NULL, NULL),
(32, 105, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W105', 2022, 'public/uploads/prestasi/105', '2022-12-11 06:45:27', NULL, NULL, NULL),
(33, 106, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W106', 2022, 'public/uploads/prestasi/106', '2022-12-11 06:45:27', NULL, NULL, NULL),
(34, 109, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W109', 2022, 'public/uploads/prestasi/109', '2022-12-11 06:45:27', NULL, NULL, NULL),
(35, 111, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W111', 2022, 'public/uploads/prestasi/111', '2022-12-11 06:45:28', NULL, NULL, NULL),
(36, 113, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W113', 2022, 'public/uploads/prestasi/113', '2022-12-11 06:45:28', NULL, NULL, NULL),
(37, 114, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W114', 2022, 'public/uploads/prestasi/114', '2022-12-11 06:45:28', NULL, NULL, NULL),
(38, 117, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W117', 2022, 'public/uploads/prestasi/117', '2022-12-11 06:45:28', NULL, NULL, NULL),
(39, 118, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W118', 2022, 'public/uploads/prestasi/118', '2022-12-11 06:45:28', NULL, NULL, NULL),
(40, 122, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W122', 2022, 'public/uploads/prestasi/122', '2022-12-11 06:45:28', NULL, NULL, NULL),
(41, 125, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W125', 2022, 'public/uploads/prestasi/125', '2022-12-11 06:45:29', NULL, NULL, NULL),
(42, 127, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W127', 2022, 'public/uploads/prestasi/127', '2022-12-11 06:45:29', NULL, NULL, NULL),
(43, 128, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W128', 2022, 'public/uploads/prestasi/128', '2022-12-11 06:45:29', NULL, NULL, NULL),
(44, 129, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W129', 2022, 'public/uploads/prestasi/129', '2022-12-11 06:45:29', NULL, NULL, NULL),
(45, 133, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W133', 2022, 'public/uploads/prestasi/133', '2022-12-11 06:45:29', NULL, NULL, NULL),
(46, 135, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W135', 2022, 'public/uploads/prestasi/135', '2022-12-11 06:45:29', NULL, NULL, NULL),
(47, 137, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W137', 2022, 'public/uploads/prestasi/137', '2022-12-11 06:45:29', NULL, NULL, NULL),
(48, 138, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W138', 2022, 'public/uploads/prestasi/138', '2022-12-11 06:45:29', NULL, NULL, NULL),
(49, 140, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W140', 2022, 'public/uploads/prestasi/140', '2022-12-11 06:45:30', NULL, NULL, NULL),
(50, 141, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W141', 2022, 'public/uploads/prestasi/141', '2022-12-11 06:45:30', NULL, NULL, NULL),
(51, 142, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W142', 2022, 'public/uploads/prestasi/142', '2022-12-11 06:45:30', NULL, NULL, NULL),
(52, 143, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W143', 2022, 'public/uploads/prestasi/143', '2022-12-11 06:45:30', NULL, NULL, NULL),
(53, 144, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W144', 2022, 'public/uploads/prestasi/144', '2022-12-11 06:45:30', NULL, NULL, NULL),
(54, 146, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W146', 2022, 'public/uploads/prestasi/146', '2022-12-11 06:45:31', NULL, NULL, NULL),
(55, 147, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W147', 2022, 'public/uploads/prestasi/147', '2022-12-11 06:45:31', NULL, NULL, NULL),
(56, 152, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W152', 2022, 'public/uploads/prestasi/152', '2022-12-11 06:45:31', NULL, NULL, NULL),
(57, 153, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W153', 2022, 'public/uploads/prestasi/153', '2022-12-11 06:45:32', NULL, NULL, NULL),
(58, 155, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W155', 2022, 'public/uploads/prestasi/155', '2022-12-11 06:45:32', NULL, NULL, NULL),
(59, 159, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W159', 2022, 'public/uploads/prestasi/159', '2022-12-11 06:45:33', NULL, NULL, NULL),
(60, 160, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W160', 2022, 'public/uploads/prestasi/160', '2022-12-11 06:45:34', NULL, NULL, NULL),
(61, 161, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W161', 2022, 'public/uploads/prestasi/161', '2022-12-11 06:45:34', NULL, NULL, NULL),
(62, 162, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W162', 2022, 'public/uploads/prestasi/162', '2022-12-11 06:45:34', NULL, NULL, NULL),
(63, 167, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W167', 2022, 'public/uploads/prestasi/167', '2022-12-11 06:45:34', NULL, NULL, NULL),
(64, 168, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W168', 2022, 'public/uploads/prestasi/168', '2022-12-11 06:45:34', NULL, NULL, NULL),
(65, 171, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W171', 2022, 'public/uploads/prestasi/171', '2022-12-11 06:45:35', NULL, NULL, NULL),
(66, 172, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W172', 2022, 'public/uploads/prestasi/172', '2022-12-11 06:45:35', NULL, NULL, NULL),
(67, 173, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W173', 2022, 'public/uploads/prestasi/173', '2022-12-11 06:45:35', NULL, NULL, NULL),
(68, 178, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W178', 2022, 'public/uploads/prestasi/178', '2022-12-11 06:45:36', NULL, NULL, NULL),
(69, 180, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W180', 2022, 'public/uploads/prestasi/180', '2022-12-11 06:45:36', NULL, NULL, NULL),
(70, 181, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W181', 2022, 'public/uploads/prestasi/181', '2022-12-11 06:45:36', NULL, NULL, NULL),
(71, 182, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W182', 2022, 'public/uploads/prestasi/182', '2022-12-11 06:45:36', NULL, NULL, NULL),
(72, 183, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W183', 2022, 'public/uploads/prestasi/183', '2022-12-11 06:45:36', NULL, NULL, NULL),
(73, 194, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W194', 2022, 'public/uploads/prestasi/194', '2022-12-11 06:45:39', NULL, NULL, NULL),
(74, 195, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W195', 2022, 'public/uploads/prestasi/195', '2022-12-11 06:45:39', NULL, NULL, NULL),
(75, 200, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W200', 2022, 'public/uploads/prestasi/200', '2022-12-11 06:45:41', NULL, NULL, NULL),
(76, 203, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W203', 2022, 'public/uploads/prestasi/203', '2022-12-11 06:45:42', NULL, NULL, NULL),
(77, 205, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W205', 2022, 'public/uploads/prestasi/205', '2022-12-11 06:45:42', NULL, NULL, NULL),
(78, 208, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W208', 2022, 'public/uploads/prestasi/208', '2022-12-11 06:45:43', NULL, NULL, NULL),
(79, 209, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W209', 2022, 'public/uploads/prestasi/209', '2022-12-11 06:45:44', NULL, NULL, NULL),
(80, 210, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W210', 2022, 'public/uploads/prestasi/210', '2022-12-11 06:45:45', NULL, NULL, NULL),
(81, 211, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W211', 2022, 'public/uploads/prestasi/211', '2022-12-11 06:45:45', NULL, NULL, NULL),
(82, 213, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W213', 2022, 'public/uploads/prestasi/213', '2022-12-11 06:45:46', NULL, NULL, NULL),
(83, 214, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W214', 2022, 'public/uploads/prestasi/214', '2022-12-11 06:45:46', NULL, NULL, NULL),
(84, 216, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W216', 2022, 'public/uploads/prestasi/216', '2022-12-11 06:45:46', NULL, NULL, NULL),
(85, 219, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W219', 2022, 'public/uploads/prestasi/219', '2022-12-11 06:45:47', NULL, NULL, NULL),
(86, 220, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W220', 2022, 'public/uploads/prestasi/220', '2022-12-11 06:45:47', NULL, NULL, NULL),
(87, 222, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W222', 2022, 'public/uploads/prestasi/222', '2022-12-11 06:45:47', NULL, NULL, NULL),
(88, 225, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W225', 2022, 'public/uploads/prestasi/225', '2022-12-11 06:45:48', NULL, NULL, NULL),
(89, 226, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W226', 2022, 'public/uploads/prestasi/226', '2022-12-11 06:45:48', NULL, NULL, NULL),
(90, 233, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W233', 2022, 'public/uploads/prestasi/233', '2022-12-11 06:45:50', NULL, NULL, NULL),
(91, 236, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W236', 2022, 'public/uploads/prestasi/236', '2022-12-11 06:45:50', NULL, NULL, NULL),
(92, 241, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W241', 2022, 'public/uploads/prestasi/241', '2022-12-11 06:45:51', NULL, NULL, NULL),
(93, 247, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W247', 2022, 'public/uploads/prestasi/247', '2022-12-11 06:45:51', NULL, NULL, NULL),
(94, 257, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W257', 2022, 'public/uploads/prestasi/257', '2022-12-11 06:45:51', NULL, NULL, NULL),
(95, 258, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W258', 2022, 'public/uploads/prestasi/258', '2022-12-11 06:45:52', NULL, NULL, NULL),
(96, 259, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W259', 2022, 'public/uploads/prestasi/259', '2022-12-11 06:45:52', NULL, NULL, NULL),
(97, 261, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W261', 2022, 'public/uploads/prestasi/261', '2022-12-11 06:45:52', NULL, NULL, NULL),
(98, 273, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W273', 2022, 'public/uploads/prestasi/273', '2022-12-11 06:45:53', NULL, NULL, NULL),
(99, 274, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W274', 2022, 'public/uploads/prestasi/274', '2022-12-11 06:45:53', NULL, NULL, NULL),
(100, 276, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W276', 2022, 'public/uploads/prestasi/276', '2022-12-11 06:45:53', NULL, NULL, NULL),
(101, 279, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W279', 2022, 'public/uploads/prestasi/279', '2022-12-11 06:45:53', NULL, NULL, NULL),
(102, 280, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W280', 2022, 'public/uploads/prestasi/280', '2022-12-11 06:45:53', NULL, NULL, NULL),
(103, 282, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W282', 2022, 'public/uploads/prestasi/282', '2022-12-11 06:45:53', NULL, NULL, NULL),
(104, 285, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W285', 2022, 'public/uploads/prestasi/285', '2022-12-11 06:45:54', NULL, NULL, NULL),
(105, 291, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W291', 2022, 'public/uploads/prestasi/291', '2022-12-11 06:45:54', NULL, NULL, NULL),
(106, 294, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W294', 2022, 'public/uploads/prestasi/294', '2022-12-11 06:45:54', NULL, NULL, NULL),
(107, 297, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W297', 2022, 'public/uploads/prestasi/297', '2022-12-11 06:45:54', NULL, NULL, NULL),
(108, 298, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W298', 2022, 'public/uploads/prestasi/298', '2022-12-11 06:45:54', NULL, NULL, NULL),
(109, 299, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W299', 2022, 'public/uploads/prestasi/299', '2022-12-11 06:45:54', NULL, NULL, NULL),
(110, 300, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W300', 2022, 'public/uploads/prestasi/300', '2022-12-11 06:45:54', NULL, NULL, NULL),
(111, 303, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W303', 2022, 'public/uploads/prestasi/303', '2022-12-11 06:45:55', NULL, NULL, NULL),
(112, 308, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W308', 2022, 'public/uploads/prestasi/308', '2022-12-11 06:45:56', NULL, NULL, NULL),
(113, 310, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W310', 2022, 'public/uploads/prestasi/310', '2022-12-11 06:45:56', NULL, NULL, NULL),
(114, 312, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W312', 2022, 'public/uploads/prestasi/312', '2022-12-11 06:45:56', NULL, NULL, NULL),
(115, 314, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W314', 2022, 'public/uploads/prestasi/314', '2022-12-11 06:45:56', NULL, NULL, NULL),
(116, 318, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W318', 2022, 'public/uploads/prestasi/318', '2022-12-11 06:45:56', NULL, NULL, NULL),
(117, 324, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W324', 2022, 'public/uploads/prestasi/324', '2022-12-11 06:45:57', NULL, NULL, NULL),
(118, 327, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W327', 2022, 'public/uploads/prestasi/327', '2022-12-11 06:45:57', NULL, NULL, NULL),
(119, 328, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W328', 2022, 'public/uploads/prestasi/328', '2022-12-11 06:45:57', NULL, NULL, NULL),
(120, 329, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W329', 2022, 'public/uploads/prestasi/329', '2022-12-11 06:45:57', NULL, NULL, NULL),
(121, 332, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W332', 2022, 'public/uploads/prestasi/332', '2022-12-11 06:45:58', NULL, NULL, NULL),
(122, 336, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W336', 2022, 'public/uploads/prestasi/336', '2022-12-11 06:45:58', NULL, NULL, NULL),
(123, 337, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W337', 2022, 'public/uploads/prestasi/337', '2022-12-11 06:45:58', NULL, NULL, NULL),
(124, 339, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W339', 2022, 'public/uploads/prestasi/339', '2022-12-11 06:45:58', NULL, NULL, NULL),
(125, 346, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W346', 2022, 'public/uploads/prestasi/346', '2022-12-11 06:45:59', NULL, NULL, NULL),
(126, 350, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W350', 2022, 'public/uploads/prestasi/350', '2022-12-11 06:45:59', NULL, NULL, NULL),
(127, 352, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W352', 2022, 'public/uploads/prestasi/352', '2022-12-11 06:45:59', NULL, NULL, NULL),
(128, 354, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W354', 2022, 'public/uploads/prestasi/354', '2022-12-11 06:45:59', NULL, NULL, NULL),
(129, 357, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W357', 2022, 'public/uploads/prestasi/357', '2022-12-11 06:46:00', NULL, NULL, NULL),
(130, 359, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W359', 2022, 'public/uploads/prestasi/359', '2022-12-11 06:46:00', NULL, NULL, NULL),
(131, 367, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W367', 2022, 'public/uploads/prestasi/367', '2022-12-11 06:46:01', NULL, NULL, NULL),
(132, 369, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W369', 2022, 'public/uploads/prestasi/369', '2022-12-11 06:46:04', NULL, NULL, NULL),
(133, 378, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W378', 2022, 'public/uploads/prestasi/378', '2022-12-11 06:46:13', NULL, NULL, NULL),
(134, 381, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W381', 2022, 'public/uploads/prestasi/381', '2022-12-11 06:46:14', NULL, NULL, NULL),
(135, 385, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W385', 2022, 'public/uploads/prestasi/385', '2022-12-11 06:46:16', NULL, NULL, NULL),
(136, 399, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W399', 2022, 'public/uploads/prestasi/399', '2022-12-11 06:46:20', NULL, NULL, NULL),
(137, 400, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W400', 2022, 'public/uploads/prestasi/400', '2022-12-11 06:46:20', NULL, NULL, NULL),
(138, 407, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W407', 2022, 'public/uploads/prestasi/407', '2022-12-11 06:46:24', NULL, NULL, NULL),
(139, 410, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W410', 2022, 'public/uploads/prestasi/410', '2022-12-11 06:46:25', NULL, NULL, NULL),
(140, 411, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W411', 2022, 'public/uploads/prestasi/411', '2022-12-11 06:46:26', NULL, NULL, NULL),
(141, 412, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W412', 2022, 'public/uploads/prestasi/412', '2022-12-11 06:46:26', NULL, NULL, NULL),
(142, 417, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W417', 2022, 'public/uploads/prestasi/417', '2022-12-11 06:46:27', NULL, NULL, NULL),
(143, 421, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W421', 2022, 'public/uploads/prestasi/421', '2022-12-11 06:46:28', NULL, NULL, NULL),
(144, 423, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W423', 2022, 'public/uploads/prestasi/423', '2022-12-11 06:46:28', NULL, NULL, NULL),
(145, 429, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W429', 2022, 'public/uploads/prestasi/429', '2022-12-11 06:46:29', NULL, NULL, NULL),
(146, 433, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W433', 2022, 'public/uploads/prestasi/433', '2022-12-11 06:46:30', NULL, NULL, NULL),
(147, 436, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W436', 2022, 'public/uploads/prestasi/436', '2022-12-11 06:46:32', NULL, NULL, NULL),
(148, 437, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W437', 2022, 'public/uploads/prestasi/437', '2022-12-11 06:46:33', NULL, NULL, NULL),
(149, 439, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W439', 2022, 'public/uploads/prestasi/439', '2022-12-11 06:46:35', NULL, NULL, NULL),
(150, 444, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W444', 2022, 'public/uploads/prestasi/444', '2022-12-11 06:46:36', NULL, NULL, NULL),
(151, 445, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W445', 2022, 'public/uploads/prestasi/445', '2022-12-11 06:46:36', NULL, NULL, NULL),
(152, 448, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W448', 2022, 'public/uploads/prestasi/448', '2022-12-11 06:46:37', NULL, NULL, NULL),
(153, 450, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W450', 2022, 'public/uploads/prestasi/450', '2022-12-11 06:46:37', NULL, NULL, NULL),
(154, 451, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W451', 2022, 'public/uploads/prestasi/451', '2022-12-11 06:46:37', NULL, NULL, NULL),
(155, 452, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W452', 2022, 'public/uploads/prestasi/452', '2022-12-11 06:46:38', NULL, NULL, NULL),
(156, 453, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W453', 2022, 'public/uploads/prestasi/453', '2022-12-11 06:46:38', NULL, NULL, NULL),
(157, 454, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W454', 2022, 'public/uploads/prestasi/454', '2022-12-11 06:46:39', NULL, NULL, NULL),
(158, 460, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W460', 2022, 'public/uploads/prestasi/460', '2022-12-11 06:46:39', NULL, NULL, NULL),
(159, 465, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W465', 2022, 'public/uploads/prestasi/465', '2022-12-11 06:46:41', NULL, NULL, NULL),
(160, 466, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W466', 2022, 'public/uploads/prestasi/466', '2022-12-11 06:46:41', NULL, NULL, NULL),
(161, 467, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W467', 2022, 'public/uploads/prestasi/467', '2022-12-11 06:46:42', NULL, NULL, NULL),
(162, 477, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W477', 2022, 'public/uploads/prestasi/477', '2022-12-11 06:46:45', NULL, NULL, NULL),
(163, 485, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W485', 2022, 'public/uploads/prestasi/485', '2022-12-11 06:46:47', NULL, NULL, NULL),
(164, 492, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W492', 2022, 'public/uploads/prestasi/492', '2022-12-11 06:46:48', NULL, NULL, NULL),
(165, 493, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W493', 2022, 'public/uploads/prestasi/493', '2022-12-11 06:46:49', NULL, NULL, NULL),
(166, 495, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W495', 2022, 'public/uploads/prestasi/495', '2022-12-11 06:46:49', NULL, NULL, NULL),
(167, 506, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W506', 2022, 'public/uploads/prestasi/506', '2022-12-11 06:46:51', NULL, NULL, NULL),
(168, 507, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W507', 2022, 'public/uploads/prestasi/507', '2022-12-11 06:46:52', NULL, NULL, NULL),
(169, 508, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W508', 2022, 'public/uploads/prestasi/508', '2022-12-11 06:46:52', NULL, NULL, NULL),
(170, 516, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W516', 2022, 'public/uploads/prestasi/516', '2022-12-11 06:46:53', NULL, NULL, NULL),
(171, 522, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W522', 2022, 'public/uploads/prestasi/522', '2022-12-11 06:46:54', NULL, NULL, NULL),
(172, 525, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W525', 2022, 'public/uploads/prestasi/525', '2022-12-11 06:46:55', NULL, NULL, NULL),
(173, 529, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W529', 2022, 'public/uploads/prestasi/529', '2022-12-11 06:46:55', NULL, NULL, NULL),
(174, 533, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W533', 2022, 'public/uploads/prestasi/533', '2022-12-11 06:46:56', NULL, NULL, NULL),
(175, 538, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W538', 2022, 'public/uploads/prestasi/538', '2022-12-11 06:46:57', NULL, NULL, NULL),
(176, 541, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W541', 2022, 'public/uploads/prestasi/541', '2022-12-11 06:46:57', NULL, NULL, NULL),
(177, 545, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W545', 2022, 'public/uploads/prestasi/545', '2022-12-11 06:46:57', NULL, NULL, NULL),
(178, 547, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W547', 2022, 'public/uploads/prestasi/547', '2022-12-11 06:46:58', NULL, NULL, NULL),
(179, 549, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W549', 2022, 'public/uploads/prestasi/549', '2022-12-11 06:46:58', NULL, NULL, NULL),
(180, 552, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W552', 2022, 'public/uploads/prestasi/552', '2022-12-11 06:46:59', NULL, NULL, NULL),
(181, 553, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W553', 2022, 'public/uploads/prestasi/553', '2022-12-11 06:46:59', NULL, NULL, NULL),
(182, 564, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W564', 2022, 'public/uploads/prestasi/564', '2022-12-11 06:47:00', NULL, NULL, NULL),
(183, 569, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W569', 2022, 'public/uploads/prestasi/569', '2022-12-11 06:47:01', NULL, NULL, NULL),
(184, 575, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W575', 2022, 'public/uploads/prestasi/575', '2022-12-11 06:47:02', NULL, NULL, NULL),
(185, 580, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W580', 2022, 'public/uploads/prestasi/580', '2022-12-11 06:47:03', NULL, NULL, NULL),
(186, 581, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W581', 2022, 'public/uploads/prestasi/581', '2022-12-11 06:47:04', NULL, NULL, NULL),
(187, 592, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W592', 2022, 'public/uploads/prestasi/592', '2022-12-11 06:47:07', NULL, NULL, NULL),
(188, 596, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W596', 2022, 'public/uploads/prestasi/596', '2022-12-11 06:47:07', NULL, NULL, NULL),
(189, 597, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W597', 2022, 'public/uploads/prestasi/597', '2022-12-11 06:47:08', NULL, NULL, NULL),
(190, 601, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W601', 2022, 'public/uploads/prestasi/601', '2022-12-11 06:47:09', NULL, NULL, NULL),
(191, 604, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W604', 2022, 'public/uploads/prestasi/604', '2022-12-11 06:47:09', NULL, NULL, NULL),
(192, 605, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W605', 2022, 'public/uploads/prestasi/605', '2022-12-11 06:47:09', NULL, NULL, NULL),
(193, 606, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W606', 2022, 'public/uploads/prestasi/606', '2022-12-11 06:47:10', NULL, NULL, NULL),
(194, 607, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W607', 2022, 'public/uploads/prestasi/607', '2022-12-11 06:47:10', NULL, NULL, NULL),
(195, 609, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W609', 2022, 'public/uploads/prestasi/609', '2022-12-11 06:47:11', NULL, NULL, NULL),
(196, 611, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W611', 2022, 'public/uploads/prestasi/611', '2022-12-11 06:47:11', NULL, NULL, NULL),
(197, 616, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W616', 2022, 'public/uploads/prestasi/616', '2022-12-11 06:47:12', NULL, NULL, NULL),
(198, 617, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W617', 2022, 'public/uploads/prestasi/617', '2022-12-11 06:47:12', NULL, NULL, NULL),
(199, 625, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W625', 2022, 'public/uploads/prestasi/625', '2022-12-11 06:47:15', NULL, NULL, NULL),
(200, 626, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W626', 2022, 'public/uploads/prestasi/626', '2022-12-11 06:47:15', NULL, NULL, NULL),
(201, 627, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W627', 2022, 'public/uploads/prestasi/627', '2022-12-11 06:47:15', NULL, NULL, NULL),
(202, 630, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W630', 2022, 'public/uploads/prestasi/630', '2022-12-11 06:47:16', NULL, NULL, NULL),
(203, 632, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W632', 2022, 'public/uploads/prestasi/632', '2022-12-11 06:47:16', NULL, NULL, NULL),
(204, 639, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W639', 2022, 'public/uploads/prestasi/639', '2022-12-11 06:47:18', NULL, NULL, NULL),
(205, 640, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W640', 2022, 'public/uploads/prestasi/640', '2022-12-11 06:47:18', NULL, NULL, NULL),
(206, 641, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W641', 2022, 'public/uploads/prestasi/641', '2022-12-11 06:47:18', NULL, NULL, NULL),
(207, 643, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W643', 2022, 'public/uploads/prestasi/643', '2022-12-11 06:47:18', NULL, NULL, NULL),
(208, 657, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W657', 2022, 'public/uploads/prestasi/657', '2022-12-11 06:47:21', NULL, NULL, NULL),
(209, 658, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W658', 2022, 'public/uploads/prestasi/658', '2022-12-11 06:47:21', NULL, NULL, NULL),
(210, 660, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W660', 2022, 'public/uploads/prestasi/660', '2022-12-11 06:47:22', NULL, NULL, NULL),
(211, 662, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W662', 2022, 'public/uploads/prestasi/662', '2022-12-11 06:47:22', NULL, NULL, NULL),
(212, 668, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W668', 2022, 'public/uploads/prestasi/668', '2022-12-11 06:47:23', NULL, NULL, NULL),
(213, 670, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W670', 2022, 'public/uploads/prestasi/670', '2022-12-11 06:47:23', NULL, NULL, NULL),
(214, 671, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W671', 2022, 'public/uploads/prestasi/671', '2022-12-11 06:47:24', NULL, NULL, NULL),
(215, 674, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W674', 2022, 'public/uploads/prestasi/674', '2022-12-11 06:47:24', NULL, NULL, NULL),
(216, 677, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W677', 2022, 'public/uploads/prestasi/677', '2022-12-11 06:47:25', NULL, NULL, NULL),
(217, 679, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W679', 2022, 'public/uploads/prestasi/679', '2022-12-11 06:47:25', NULL, NULL, NULL),
(218, 680, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W680', 2022, 'public/uploads/prestasi/680', '2022-12-11 06:47:25', NULL, NULL, NULL),
(219, 681, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W681', 2022, 'public/uploads/prestasi/681', '2022-12-11 06:47:26', NULL, NULL, NULL),
(220, 685, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W685', 2022, 'public/uploads/prestasi/685', '2022-12-11 06:47:26', NULL, NULL, NULL),
(221, 700, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W700', 2022, 'public/uploads/prestasi/700', '2022-12-11 06:47:28', NULL, NULL, NULL),
(222, 702, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W702', 2022, 'public/uploads/prestasi/702', '2022-12-11 06:47:29', NULL, NULL, NULL),
(223, 704, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W704', 2022, 'public/uploads/prestasi/704', '2022-12-11 06:47:29', NULL, NULL, NULL),
(224, 709, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W709', 2022, 'public/uploads/prestasi/709', '2022-12-11 06:47:29', NULL, NULL, NULL),
(225, 711, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W711', 2022, 'public/uploads/prestasi/711', '2022-12-11 06:47:30', NULL, NULL, NULL),
(226, 716, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W716', 2022, 'public/uploads/prestasi/716', '2022-12-11 06:47:31', NULL, NULL, NULL),
(227, 723, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W723', 2022, 'public/uploads/prestasi/723', '2022-12-11 06:47:33', NULL, NULL, NULL),
(228, 726, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W726', 2022, 'public/uploads/prestasi/726', '2022-12-11 06:47:33', NULL, NULL, NULL),
(229, 731, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W731', 2022, 'public/uploads/prestasi/731', '2022-12-11 06:47:34', NULL, NULL, NULL),
(230, 741, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W741', 2022, 'public/uploads/prestasi/741', '2022-12-11 06:47:38', NULL, NULL, NULL),
(231, 742, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W742', 2022, 'public/uploads/prestasi/742', '2022-12-11 06:47:38', NULL, NULL, NULL),
(232, 743, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W743', 2022, 'public/uploads/prestasi/743', '2022-12-11 06:47:38', NULL, NULL, NULL),
(233, 749, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W749', 2022, 'public/uploads/prestasi/749', '2022-12-11 06:47:40', NULL, NULL, NULL),
(234, 750, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W750', 2022, 'public/uploads/prestasi/750', '2022-12-11 06:47:41', NULL, NULL, NULL),
(235, 751, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W751', 2022, 'public/uploads/prestasi/751', '2022-12-11 06:47:41', NULL, NULL, NULL),
(236, 753, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W753', 2022, 'public/uploads/prestasi/753', '2022-12-11 06:47:42', NULL, NULL, NULL),
(237, 760, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W760', 2022, 'public/uploads/prestasi/760', '2022-12-11 06:47:44', NULL, NULL, NULL),
(238, 764, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W764', 2022, 'public/uploads/prestasi/764', '2022-12-11 06:47:45', NULL, NULL, NULL),
(239, 765, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W765', 2022, 'public/uploads/prestasi/765', '2022-12-11 06:47:45', NULL, NULL, NULL),
(240, 766, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W766', 2022, 'public/uploads/prestasi/766', '2022-12-11 06:47:46', NULL, NULL, NULL),
(241, 768, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W768', 2022, 'public/uploads/prestasi/768', '2022-12-11 06:47:47', NULL, NULL, NULL),
(242, 769, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W769', 2022, 'public/uploads/prestasi/769', '2022-12-11 06:47:49', NULL, NULL, NULL),
(243, 772, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W772', 2022, 'public/uploads/prestasi/772', '2022-12-11 06:47:53', NULL, NULL, NULL),
(244, 774, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W774', 2022, 'public/uploads/prestasi/774', '2022-12-11 06:47:54', NULL, NULL, NULL),
(245, 778, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W778', 2022, 'public/uploads/prestasi/778', '2022-12-11 06:47:56', NULL, NULL, NULL),
(246, 779, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W779', 2022, 'public/uploads/prestasi/779', '2022-12-11 06:47:57', NULL, NULL, NULL),
(247, 780, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W780', 2022, 'public/uploads/prestasi/780', '2022-12-11 06:47:57', NULL, NULL, NULL),
(248, 781, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W781', 2022, 'public/uploads/prestasi/781', '2022-12-11 06:47:57', NULL, NULL, NULL),
(249, 784, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W784', 2022, 'public/uploads/prestasi/784', '2022-12-11 06:47:59', NULL, NULL, NULL),
(250, 797, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W797', 2022, 'public/uploads/prestasi/797', '2022-12-11 06:48:11', NULL, NULL, NULL),
(251, 799, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W799', 2022, 'public/uploads/prestasi/799', '2022-12-11 06:48:12', NULL, NULL, NULL),
(252, 800, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W800', 2022, 'public/uploads/prestasi/800', '2022-12-11 06:48:12', NULL, NULL, NULL),
(253, 801, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W801', 2022, 'public/uploads/prestasi/801', '2022-12-11 06:48:13', NULL, NULL, NULL),
(254, 804, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W804', 2022, 'public/uploads/prestasi/804', '2022-12-11 06:48:13', NULL, NULL, NULL),
(255, 805, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W805', 2022, 'public/uploads/prestasi/805', '2022-12-11 06:48:14', NULL, NULL, NULL),
(256, 806, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W806', 2022, 'public/uploads/prestasi/806', '2022-12-11 06:48:14', NULL, NULL, NULL),
(257, 809, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W809', 2022, 'public/uploads/prestasi/809', '2022-12-11 06:48:18', NULL, NULL, NULL),
(258, 827, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W827', 2022, 'public/uploads/prestasi/827', '2022-12-11 06:48:22', NULL, NULL, NULL),
(259, 829, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W829', 2022, 'public/uploads/prestasi/829', '2022-12-11 06:48:22', NULL, NULL, NULL),
(260, 830, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W830', 2022, 'public/uploads/prestasi/830', '2022-12-11 06:48:22', NULL, NULL, NULL),
(261, 831, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W831', 2022, 'public/uploads/prestasi/831', '2022-12-11 06:48:22', NULL, NULL, NULL),
(262, 833, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W833', 2022, 'public/uploads/prestasi/833', '2022-12-11 06:48:23', NULL, NULL, NULL),
(263, 834, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W834', 2022, 'public/uploads/prestasi/834', '2022-12-11 06:48:23', NULL, NULL, NULL),
(264, 835, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W835', 2022, 'public/uploads/prestasi/835', '2022-12-11 06:48:24', NULL, NULL, NULL),
(265, 840, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W840', 2022, 'public/uploads/prestasi/840', '2022-12-11 06:48:24', NULL, NULL, NULL),
(266, 841, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W841', 2022, 'public/uploads/prestasi/841', '2022-12-11 06:48:25', NULL, NULL, NULL),
(267, 843, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W843', 2022, 'public/uploads/prestasi/843', '2022-12-11 06:48:25', NULL, NULL, NULL),
(268, 845, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W845', 2022, 'public/uploads/prestasi/845', '2022-12-11 06:48:25', NULL, NULL, NULL),
(269, 846, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W846', 2022, 'public/uploads/prestasi/846', '2022-12-11 06:48:25', NULL, NULL, NULL),
(270, 852, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W852', 2022, 'public/uploads/prestasi/852', '2022-12-11 06:48:26', NULL, NULL, NULL),
(271, 853, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W853', 2022, 'public/uploads/prestasi/853', '2022-12-11 06:48:27', NULL, NULL, NULL),
(272, 857, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W857', 2022, 'public/uploads/prestasi/857', '2022-12-11 06:48:27', NULL, NULL, NULL),
(273, 863, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W863', 2022, 'public/uploads/prestasi/863', '2022-12-11 06:48:28', NULL, NULL, NULL),
(274, 868, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W868', 2022, 'public/uploads/prestasi/868', '2022-12-11 06:48:29', NULL, NULL, NULL),
(275, 872, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W872', 2022, 'public/uploads/prestasi/872', '2022-12-11 06:48:29', NULL, NULL, NULL),
(276, 876, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W876', 2022, 'public/uploads/prestasi/876', '2022-12-11 06:48:30', NULL, NULL, NULL),
(277, 879, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W879', 2022, 'public/uploads/prestasi/879', '2022-12-11 06:48:30', NULL, NULL, NULL),
(278, 882, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W882', 2022, 'public/uploads/prestasi/882', '2022-12-11 06:48:30', NULL, NULL, NULL),
(279, 884, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W884', 2022, 'public/uploads/prestasi/884', '2022-12-11 06:48:31', NULL, NULL, NULL),
(280, 887, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W887', 2022, 'public/uploads/prestasi/887', '2022-12-11 06:48:31', NULL, NULL, NULL),
(281, 888, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W888', 2022, 'public/uploads/prestasi/888', '2022-12-11 06:48:31', NULL, NULL, NULL),
(282, 893, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W893', 2022, 'public/uploads/prestasi/893', '2022-12-11 06:48:32', NULL, NULL, NULL),
(283, 896, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W896', 2022, 'public/uploads/prestasi/896', '2022-12-11 06:48:32', NULL, NULL, NULL),
(284, 901, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W901', 2022, 'public/uploads/prestasi/901', '2022-12-11 06:48:32', NULL, NULL, NULL),
(285, 903, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W903', 2022, 'public/uploads/prestasi/903', '2022-12-11 06:48:34', NULL, NULL, NULL),
(286, 904, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W904', 2022, 'public/uploads/prestasi/904', '2022-12-11 06:48:34', NULL, NULL, NULL),
(287, 905, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W905', 2022, 'public/uploads/prestasi/905', '2022-12-11 06:48:34', NULL, NULL, NULL),
(288, 907, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W907', 2022, 'public/uploads/prestasi/907', '2022-12-11 06:48:35', NULL, NULL, NULL),
(289, 916, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W916', 2022, 'public/uploads/prestasi/916', '2022-12-11 06:48:36', NULL, NULL, NULL),
(290, 917, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W917', 2022, 'public/uploads/prestasi/917', '2022-12-11 06:48:37', NULL, NULL, NULL),
(291, 921, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W921', 2022, 'public/uploads/prestasi/921', '2022-12-11 06:48:37', NULL, NULL, NULL),
(292, 922, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W922', 2022, 'public/uploads/prestasi/922', '2022-12-11 06:48:37', NULL, NULL, NULL),
(293, 923, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W923', 2022, 'public/uploads/prestasi/923', '2022-12-11 06:48:37', NULL, NULL, NULL),
(294, 926, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W926', 2022, 'public/uploads/prestasi/926', '2022-12-11 06:48:38', NULL, NULL, NULL),
(295, 929, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W929', 2022, 'public/uploads/prestasi/929', '2022-12-11 06:48:39', NULL, NULL, NULL),
(296, 930, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W930', 2022, 'public/uploads/prestasi/930', '2022-12-11 06:48:39', NULL, NULL, NULL),
(297, 936, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W936', 2022, 'public/uploads/prestasi/936', '2022-12-11 06:48:39', NULL, NULL, NULL),
(298, 938, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W938', 2022, 'public/uploads/prestasi/938', '2022-12-11 06:48:40', NULL, NULL, NULL),
(299, 941, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W941', 2022, 'public/uploads/prestasi/941', '2022-12-11 06:48:41', NULL, NULL, NULL),
(300, 943, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W943', 2022, 'public/uploads/prestasi/943', '2022-12-11 06:48:41', NULL, NULL, NULL),
(301, 950, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W950', 2022, 'public/uploads/prestasi/950', '2022-12-11 06:48:42', NULL, NULL, NULL),
(302, 951, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W951', 2022, 'public/uploads/prestasi/951', '2022-12-11 06:48:42', NULL, NULL, NULL),
(303, 955, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W955', 2022, 'public/uploads/prestasi/955', '2022-12-11 06:48:43', NULL, NULL, NULL),
(304, 957, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W957', 2022, 'public/uploads/prestasi/957', '2022-12-11 06:48:43', NULL, NULL, NULL),
(305, 959, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W959', 2022, 'public/uploads/prestasi/959', '2022-12-11 06:48:43', NULL, NULL, NULL),
(306, 961, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W961', 2022, 'public/uploads/prestasi/961', '2022-12-11 06:48:44', NULL, NULL, NULL),
(307, 962, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W962', 2022, 'public/uploads/prestasi/962', '2022-12-11 06:48:44', NULL, NULL, NULL),
(308, 967, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W967', 2022, 'public/uploads/prestasi/967', '2022-12-11 06:48:44', NULL, NULL, NULL),
(309, 968, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W968', 2022, 'public/uploads/prestasi/968', '2022-12-11 06:48:45', NULL, NULL, NULL),
(310, 969, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W969', 2022, 'public/uploads/prestasi/969', '2022-12-11 06:48:45', NULL, NULL, NULL),
(311, 971, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W971', 2022, 'public/uploads/prestasi/971', '2022-12-11 06:48:45', NULL, NULL, NULL),
(312, 972, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W972', 2022, 'public/uploads/prestasi/972', '2022-12-11 06:48:45', NULL, NULL, NULL),
(313, 977, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W977', 2022, 'public/uploads/prestasi/977', '2022-12-11 06:48:46', NULL, NULL, NULL),
(314, 979, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W979', 2022, 'public/uploads/prestasi/979', '2022-12-11 06:48:46', NULL, NULL, NULL),
(315, 981, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W981', 2022, 'public/uploads/prestasi/981', '2022-12-11 06:48:46', NULL, NULL, NULL),
(316, 986, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W986', 2022, 'public/uploads/prestasi/986', '2022-12-11 06:48:47', NULL, NULL, NULL),
(317, 988, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W988', 2022, 'public/uploads/prestasi/988', '2022-12-11 06:48:48', NULL, NULL, NULL),
(318, 989, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W989', 2022, 'public/uploads/prestasi/989', '2022-12-11 06:48:48', NULL, NULL, NULL),
(319, 991, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W991', 2022, 'public/uploads/prestasi/991', '2022-12-11 06:48:48', NULL, NULL, NULL),
(320, 994, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W994', 2022, 'public/uploads/prestasi/994', '2022-12-11 06:48:49', NULL, NULL, NULL),
(321, 995, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W995', 2022, 'public/uploads/prestasi/995', '2022-12-11 06:48:50', NULL, NULL, NULL),
(322, 996, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W996', 2022, 'public/uploads/prestasi/996', '2022-12-11 06:48:50', NULL, NULL, NULL),
(323, 998, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W998', 2022, 'public/uploads/prestasi/998', '2022-12-11 06:48:51', NULL, NULL, NULL),
(324, 999, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W999', 2022, 'public/uploads/prestasi/999', '2022-12-11 06:48:51', NULL, NULL, NULL);

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
  ADD PRIMARY KEY (`id_jalur`),
  ADD KEY `nama_jalur` (`nama_jalur`);

--
-- Indexes for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id_pendaftar`),
  ADD KEY `MUL` (`id_jalur`),
  ADD KEY `id_prodi1` (`id_prodi1`),
  ADD KEY `id_prodi2` (`id_prodi2`),
  ADD KEY `id_bank` (`id_bank`),
  ADD KEY `no_pendaftar` (`no_pendaftar`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=325;

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
