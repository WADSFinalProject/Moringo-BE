-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2024 at 02:33 PM
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
-- Table structure for table `centra_drying_results`
--

CREATE TABLE `centra_drying_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_dried` date NOT NULL,
  `weight_dried` float NOT NULL,
  `exp_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_drying_results`
--

INSERT INTO `centra_drying_results` (`id`, `user_id`, `date_dried`, `weight_dried`, `exp_date`) VALUES
(1, 8, '2024-07-07', 8, '2024-08-08'),
(2, 9, '2024-06-17', 12, '2024-06-27');

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
-- Table structure for table `centra_machine_status`
--

CREATE TABLE `centra_machine_status` (
  `id` int(11) NOT NULL,
  `current_weight` float DEFAULT 0,
  `last_started` datetime DEFAULT NULL,
  `is_processing` tinyint(1) DEFAULT 0,
  `remaining_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_machine_status`
--

INSERT INTO `centra_machine_status` (`id`, `current_weight`, `last_started`, `is_processing`, `remaining_time`) VALUES
(0, 0, '2024-05-25 09:36:53', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `centra_moringa_batches`
--

CREATE TABLE `centra_moringa_batches` (
  `batch_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_received` date DEFAULT NULL,
  `weight_received` float DEFAULT NULL,
  `expiry_time` datetime DEFAULT NULL,
  `processing_state` tinyint(1) DEFAULT 0,
  `time_received` time DEFAULT curtime(),
  `accepted_weight` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `centra_powder`
--

CREATE TABLE `centra_powder` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_recorded` date NOT NULL,
  `powder_weight` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `centra_powder`
--

INSERT INTO `centra_powder` (`id`, `user_id`, `date_recorded`, `powder_weight`) VALUES
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
-- Indexes for table `centra_machine_status`
--
ALTER TABLE `centra_machine_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `centra_moringa_batches`
--
ALTER TABLE `centra_moringa_batches`
  ADD PRIMARY KEY (`batch_id`);

--
-- Indexes for table `centra_powder`
--
ALTER TABLE `centra_powder`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `centra_expeditions`
--
ALTER TABLE `centra_expeditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `centra_moringa_batches`
--
ALTER TABLE `centra_moringa_batches`
  MODIFY `batch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `centra_powder`
--
ALTER TABLE `centra_powder`
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
