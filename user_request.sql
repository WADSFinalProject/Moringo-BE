-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2024 at 12:27 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `user_request`
--

-- --------------------------------------------------------

--
-- Table structure for table `centras`
--

CREATE TABLE `centras` (
  `centra_id` int(100) NOT NULL,
  `centra_name` varchar(100) NOT NULL,
  `centra_address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centras`
--

INSERT INTO `centras` (`centra_id`, `centra_name`, `centra_address`) VALUES
(1, 'Jakarta', 'Jl. Sudirman No. 1, Jakarta'),
(2, 'Surabaya', 'Jl. Gubernur Suryo No. 15, Surabaya'),
(3, 'Bandung', 'Jl. Asia Afrika No. 99, Bandung'),
(4, 'Medan', 'Jl. Diponegoro No. 21, Medan'),
(5, 'Semarang', 'Jl. Pahlawan No. 45, Semarang'),
(6, 'Makassar', 'Jl. Urip Sumoharjo No. 10, Makassar'),
(7, 'Palembang', 'Jl. Mayor Zen No. 30, Palembang'),
(8, 'Depok', 'Jl. Margonda Raya No. 28, Depok'),
(9, 'Tangerang', 'Jl. Jenderal Sudirman No. 50, Tangerang'),
(10, 'Bekasi', 'Jl. Ir. H. Juanda No. 80, Bekasi'),
(11, 'Bandar Lampung', 'Jl. Zainal Abidin Pagar Alam No. 5, Bandar Lampung'),
(12, 'Padang', 'Jl. Hayam Wuruk No. 70, Padang'),
(13, 'Malang', 'Jl. Soekarno-Hatta No. 35, Malang'),
(14, 'Bogor', 'Jl. Raya Pajajaran No. 25, Bogor'),
(15, 'Yogyakarta', 'Jl. Malioboro No. 15, Yogyakarta'),
(16, 'Pontianak', 'Jl. Ahmad Yani No. 18, Pontianak'),
(17, 'Banjarmasin', 'Jl. A. Yani No. 28, Banjarmasin'),
(18, 'Serang', 'Jl. Raya Serang No. 10, Serang'),
(19, 'Denpasar', 'Jl. Gatot Subroto No. 21, Denpasar'),
(20, 'Samarinda', 'Jl. Pahlawan No. 17, Samarinda'),
(21, 'Cimahi', 'Jl. Jendral Sudirman No. 42, Cimahi'),
(22, 'Mataram', 'Jl. Pejanggik No. 80, Mataram'),
(23, 'Pekanbaru', 'Jl. Sudirman No. 9, Pekanbaru'),
(24, 'Balikpapan', 'Jl. Jendral Sudirman No. 3, Balikpapan'),
(25, 'Jambi', 'Jl. Soekarno-Hatta No. 11, Jambi'),
(26, 'Sukabumi', 'Jl. Pahlawan No. 67, Sukabumi'),
(27, 'Banda Aceh', 'Jl. T. Iskandar No. 22, Banda Aceh'),
(28, 'Cilegon', 'Jl. Merdeka No. 40, Cilegon'),
(29, 'Padang Panjang', 'Jl. Hayam Wuruk No. 23, Padang Panjang'),
(30, 'Magelang', 'Jl. Pemuda No. 6, Magelang'),
(31, 'Tegal', 'Jl. Ahmad Yani No. 33, Tegal'),
(32, 'Probolinggo', 'Jl. Dr. Soetomo No. 19, Probolinggo'),
(33, 'Purwokerto', 'Jl. Suryakencana No. 14, Purwokerto'),
(34, 'Tarakan', 'Jl. A. Yani No. 8, Tarakan'),
(35, 'Pasuruan', 'Jl. Pahlawan No. 2, Pasuruan'),
(36, 'Bukittinggi', 'Jl. A. Yani No. 51, Bukittinggi');

-- --------------------------------------------------------

--
-- Table structure for table `centra_drying_results`
--

CREATE TABLE `centra_drying_results` (
  `id` int(11) NOT NULL,
  `centra_name` varchar(100) NOT NULL,
  `date_dried` date NOT NULL,
  `weight_dried` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_drying_results`
--

INSERT INTO `centra_drying_results` (`id`, `centra_name`, `date_dried`, `weight_dried`) VALUES
(3, 'Puncak', '2024-06-16', 30);

-- --------------------------------------------------------

--
-- Table structure for table `centra_expeditions`
--

CREATE TABLE `centra_expeditions` (
  `id` int(11) NOT NULL,
  `expedition_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_expeditions`
--

INSERT INTO `centra_expeditions` (`id`, `expedition_name`) VALUES
(3, 'SiCepat');

-- --------------------------------------------------------

--
-- Table structure for table `centra_machine_drying_status`
--

CREATE TABLE `centra_machine_drying_status` (
  `machine_id` int(11) NOT NULL,
  `current_weight` float DEFAULT 0,
  `last_started` datetime DEFAULT NULL,
  `is_processing` tinyint(1) DEFAULT 0,
  `remaining_time` int(11) DEFAULT 0,
  `centra_name` varchar(100) NOT NULL,
  `finished_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_machine_drying_status`
--

INSERT INTO `centra_machine_drying_status` (`machine_id`, `current_weight`, `last_started`, `is_processing`, `remaining_time`, `centra_name`, `finished_time`) VALUES
(1, 20, '2024-06-15 20:07:15', 1, 0, 'Jakarta', '2024-06-15 21:20:41.180341'),
(2, 25, '2024-06-15 19:18:25', 1, 0, 'Surabaya', '2024-06-15 21:20:41.180341'),
(3, 0, '2024-06-15 19:20:30', 1, 0, 'Bandung', '2024-06-15 21:20:41.180341'),
(4, 0, '2024-06-15 19:21:38', 1, 0, 'Medan', '2024-06-15 21:20:41.180341'),
(5, 0, '2024-06-15 19:55:28', 1, 0, 'Semarang', '2024-06-15 21:20:41.180341'),
(6, 0, NULL, 0, 0, 'Makassar', '2024-06-15 21:20:41.180341'),
(7, 0, NULL, 0, 0, 'Palembang', '2024-06-15 21:20:41.180341'),
(8, 0, NULL, 0, 0, 'Depok', '2024-06-15 21:20:41.180341'),
(9, 0, NULL, 0, 0, 'Tangerang', '2024-06-15 21:20:41.180341'),
(10, 0, NULL, 0, 0, 'Bekasi', '2024-06-15 21:20:41.180341'),
(11, 0, NULL, 0, 0, 'Bandar Lampung', '2024-06-15 21:20:41.180341'),
(12, 0, NULL, 0, 0, 'Padang', '2024-06-15 21:20:41.180341'),
(13, 0, NULL, 0, 0, 'Malang', '2024-06-15 21:20:41.180341'),
(14, 0, NULL, 0, 0, 'Bogor', '2024-06-15 21:20:41.180341'),
(15, 0, NULL, 0, 0, 'Yogyakarta', '2024-06-15 21:20:41.180341'),
(16, 0, NULL, 0, 0, 'Pontianak', '2024-06-15 21:20:41.180341'),
(17, 0, NULL, 0, 0, 'Banjarmasin', '2024-06-15 21:20:41.180341'),
(18, 0, NULL, 0, 0, 'Serang', '2024-06-15 21:20:41.180341'),
(19, 0, NULL, 0, 0, 'Denpasar', '2024-06-15 21:20:41.180341'),
(20, 0, NULL, 0, 0, 'Samarinda', '2024-06-15 21:20:41.180341'),
(21, 0, NULL, 0, 0, 'Cimahi', '2024-06-15 21:20:41.180341'),
(22, 0, NULL, 0, 0, 'Mataram', '2024-06-15 21:20:41.180341'),
(23, 0, NULL, 0, 0, 'Pekanbaru', '2024-06-15 21:20:41.180341'),
(24, 0, NULL, 0, 0, 'Balikpapan', '2024-06-15 21:20:41.180341'),
(25, 0, NULL, 0, 0, 'Jambi', '2024-06-15 21:20:41.180341'),
(26, 0, NULL, 0, 0, 'Sukabumi', '2024-06-15 21:20:41.180341'),
(27, 0, NULL, 0, 0, 'Banda Aceh', '2024-06-15 21:20:41.180341'),
(28, 0, NULL, 0, 0, 'Cilegon', '2024-06-15 21:20:41.180341'),
(29, 0, NULL, 0, 0, 'Padang Panjang', '2024-06-15 21:20:41.180341'),
(30, 0, NULL, 0, 0, 'Magelang', '2024-06-15 21:20:41.180341'),
(31, 0, NULL, 0, 0, 'Tegal', '2024-06-15 21:20:41.180341'),
(32, 0, NULL, 0, 0, 'Probolinggo', '2024-06-15 21:20:41.180341'),
(33, 0, NULL, 0, 0, 'Purwokerto', '2024-06-15 21:20:41.180341'),
(34, 0, NULL, 0, 0, 'Tarakan', '2024-06-15 21:20:41.180341'),
(35, 0, NULL, 0, 0, 'Pasuruan', '2024-06-15 21:20:41.180341'),
(36, 0, NULL, 0, 0, 'Bukittinggi', '2024-06-15 21:20:41.180341');

-- --------------------------------------------------------

--
-- Table structure for table `centra_machine_powder_status`
--

CREATE TABLE `centra_machine_powder_status` (
  `machine_id` int(11) NOT NULL,
  `current_weight` float DEFAULT 0,
  `last_started` datetime DEFAULT NULL,
  `is_processing` tinyint(1) DEFAULT 0,
  `remaining_time` int(11) DEFAULT 0,
  `centra_name` varchar(100) NOT NULL,
  `finished_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_machine_powder_status`
--

INSERT INTO `centra_machine_powder_status` (`machine_id`, `current_weight`, `last_started`, `is_processing`, `remaining_time`, `centra_name`, `finished_time`) VALUES
(1, 0, '2024-06-15 20:07:15', 0, 0, 'Jakarta', '2024-06-15 14:20:41.180341'),
(2, 0, '2024-06-15 19:18:25', 0, 0, 'Surabaya', '2024-06-15 14:20:41.180341'),
(3, 0, '2024-06-15 19:20:30', 0, 0, 'Bandung', '2024-06-15 14:20:41.180341'),
(4, 0, '2024-06-15 19:21:38', 0, 0, 'Medan', '2024-06-15 14:20:41.180341'),
(5, 0, '2024-06-15 19:55:28', 0, 0, 'Semarang', '2024-06-15 14:20:41.180341'),
(6, 0, NULL, 0, 0, 'Makassar', '2024-06-15 14:20:41.180341'),
(7, 0, NULL, 0, 0, 'Palembang', '2024-06-15 14:20:41.180341'),
(8, 0, NULL, 0, 0, 'Depok', '2024-06-15 14:20:41.180341'),
(9, 0, NULL, 0, 0, 'Tangerang', '2024-06-15 14:20:41.180341'),
(10, 0, NULL, 0, 0, 'Bekasi', '2024-06-15 14:20:41.180341'),
(11, 0, NULL, 0, 0, 'Bandar Lampung', '2024-06-15 14:20:41.180341'),
(12, 0, NULL, 0, 0, 'Padang', '2024-06-15 14:20:41.180341'),
(13, 0, NULL, 0, 0, 'Malang', '2024-06-15 14:20:41.180341'),
(14, 0, NULL, 0, 0, 'Bogor', '2024-06-15 14:20:41.180341'),
(15, 0, NULL, 0, 0, 'Yogyakarta', '2024-06-15 14:20:41.180341'),
(16, 0, NULL, 0, 0, 'Pontianak', '2024-06-15 14:20:41.180341'),
(17, 0, NULL, 0, 0, 'Banjarmasin', '2024-06-15 14:20:41.180341'),
(18, 0, NULL, 0, 0, 'Serang', '2024-06-15 14:20:41.180341'),
(19, 0, NULL, 0, 0, 'Denpasar', '2024-06-15 14:20:41.180341'),
(20, 0, NULL, 0, 0, 'Samarinda', '2024-06-15 14:20:41.180341'),
(21, 0, NULL, 0, 0, 'Cimahi', '2024-06-15 14:20:41.180341'),
(22, 0, NULL, 0, 0, 'Mataram', '2024-06-15 14:20:41.180341'),
(23, 0, NULL, 0, 0, 'Pekanbaru', '2024-06-15 14:20:41.180341'),
(24, 0, NULL, 0, 0, 'Balikpapan', '2024-06-15 14:20:41.180341'),
(25, 0, NULL, 0, 0, 'Jambi', '2024-06-15 14:20:41.180341'),
(26, 0, NULL, 0, 0, 'Sukabumi', '2024-06-15 14:20:41.180341'),
(27, 0, NULL, 0, 0, 'Banda Aceh', '2024-06-15 14:20:41.180341'),
(28, 0, NULL, 0, 0, 'Cilegon', '2024-06-15 14:20:41.180341'),
(29, 0, NULL, 0, 0, 'Padang Panjang', '2024-06-15 14:20:41.180341'),
(30, 0, NULL, 0, 0, 'Magelang', '2024-06-15 14:20:41.180341'),
(31, 0, NULL, 0, 0, 'Tegal', '2024-06-15 14:20:41.180341'),
(32, 0, NULL, 0, 0, 'Probolinggo', '2024-06-15 14:20:41.180341'),
(33, 0, NULL, 0, 0, 'Purwokerto', '2024-06-15 14:20:41.180341'),
(34, 0, NULL, 0, 0, 'Tarakan', '2024-06-15 14:20:41.180341'),
(35, 0, NULL, 0, 0, 'Pasuruan', '2024-06-15 14:20:41.180341'),
(36, 0, NULL, 0, 0, 'Bukittinggi', '2024-06-15 14:20:41.180341');

-- --------------------------------------------------------

--
-- Table structure for table `centra_moringa_batches`
--

CREATE TABLE `centra_moringa_batches` (
  `id` int(11) NOT NULL,
  `centra_name` varchar(100) NOT NULL,
  `entryDate` date NOT NULL,
  `entryTime` time NOT NULL,
  `weight_received` float NOT NULL,
  `expiry_time` datetime NOT NULL,
  `processing_state` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `centra_powder_batches`
--

CREATE TABLE `centra_powder_batches` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_recorded` date NOT NULL,
  `powder_weight` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_powder_batches`
--

INSERT INTO `centra_powder_batches` (`id`, `user_id`, `date_recorded`, `powder_weight`) VALUES
(4, 6, '2024-05-22', 25),
(5, 6, '2024-06-26', 3);

-- --------------------------------------------------------

--
-- Table structure for table `centra_rescaled_weights`
--

CREATE TABLE `centra_rescaled_weights` (
  `id` int(11) NOT NULL,
  `shipment_id` int(11) NOT NULL,
  `original_weight` float NOT NULL,
  `rescaled_weight` float NOT NULL,
  `date_rescaled` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `centra_shipments`
--

CREATE TABLE `centra_shipments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_shipped` date NOT NULL,
  `expedition` varchar(255) NOT NULL,
  `total_package` int(11) NOT NULL,
  `package_weight` float NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `expedition_id` int(11) DEFAULT NULL,
  `is_Delivered` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_shipments`
--

INSERT INTO `centra_shipments` (`id`, `user_id`, `date_shipped`, `expedition`, `total_package`, `package_weight`, `barcode`, `expedition_id`, `is_Delivered`) VALUES
(8, 8, '2024-05-18', 'SiCepat', 7, 5, 'barcodedirectory\\barcode_2024-05-18_SiCepat_7.png', 3, 0);

--
-- Triggers `centra_shipments`
--
DELIMITER $$
CREATE TRIGGER `before_insert_centra_shipments` BEFORE INSERT ON `centra_shipments` FOR EACH ROW BEGIN
    DECLARE expedition_id INT;
    
    -- Check if the expedition exists in centra_expeditions
    SELECT id INTO expedition_id
    FROM centra_expeditions
    WHERE expedition_name = NEW.expedition;
    
    -- If the expedition does not exist, insert it into centra_expeditions
    IF expedition_id IS NULL THEN
        INSERT INTO centra_expeditions (expedition_name) VALUES (NEW.expedition);
        SET expedition_id = LAST_INSERT_ID();
    END IF;
    
    -- Set the expedition_id in the centra_shipments table
    SET NEW.expedition_id = expedition_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `document_receipts`
--

CREATE TABLE `document_receipts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_received` date NOT NULL,
  `document_type` varchar(255) NOT NULL,
  `document_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_signups`
--

CREATE TABLE `user_signups` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `user_role` enum('Centra','XYZ','Harbor') NOT NULL,
  `country_code` varchar(10) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `branch` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_signups`
--

INSERT INTO `user_signups` (`id`, `username`, `email`, `password`, `status`, `user_role`, `country_code`, `phone_number`, `first_name`, `last_name`, `branch`) VALUES
(4, 'something', 'something@gmail.com', 'somepassword', 'approved', 'XYZ', NULL, NULL, '', '', NULL),
(5, 'centrauserrenamed', 'centrauser@gmail.com', 'centra', 'approved', 'Centra', NULL, '911', 'test', 'test', 'Puncak'),
(6, 'centra2', 'centra2@gmail.com', 'centra2', 'approved', 'Centra', NULL, NULL, '', '', NULL),
(8, 'centra55', 'centra55@gmail.com', 'centra', 'approved', 'Harbor', NULL, '911', 'changed', 'name', 'syria'),
(9, 'centra5', 'centra5@gmail.com', 'centra', 'approved', 'Centra', '+62', '089616376969', 'centra', '5', NULL),
(11, 'test2', 'test2@gmail.com', 'test2', 'approved', 'Centra', '+62', '1111111', 'test', '2', 'Bandung');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `centra_drying_results`
--
ALTER TABLE `centra_drying_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `centra_expeditions`
--
ALTER TABLE `centra_expeditions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `expedition_name` (`expedition_name`);

--
-- Indexes for table `centra_machine_drying_status`
--
ALTER TABLE `centra_machine_drying_status`
  ADD PRIMARY KEY (`machine_id`);

--
-- Indexes for table `centra_machine_powder_status`
--
ALTER TABLE `centra_machine_powder_status`
  ADD PRIMARY KEY (`machine_id`);

--
-- Indexes for table `centra_moringa_batches`
--
ALTER TABLE `centra_moringa_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `centra_powder_batches`
--
ALTER TABLE `centra_powder_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `centra_rescaled_weights`
--
ALTER TABLE `centra_rescaled_weights`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `centra_shipments`
--
ALTER TABLE `centra_shipments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_expedition` (`expedition_id`);

--
-- Indexes for table `document_receipts`
--
ALTER TABLE `document_receipts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_signups`
--
ALTER TABLE `user_signups`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `centra_drying_results`
--
ALTER TABLE `centra_drying_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `centra_expeditions`
--
ALTER TABLE `centra_expeditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `centra_machine_powder_status`
--
ALTER TABLE `centra_machine_powder_status`
  MODIFY `machine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `centra_moringa_batches`
--
ALTER TABLE `centra_moringa_batches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `centra_powder_batches`
--
ALTER TABLE `centra_powder_batches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `centra_rescaled_weights`
--
ALTER TABLE `centra_rescaled_weights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `centra_shipments`
--
ALTER TABLE `centra_shipments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `document_receipts`
--
ALTER TABLE `document_receipts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_signups`
--
ALTER TABLE `user_signups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
