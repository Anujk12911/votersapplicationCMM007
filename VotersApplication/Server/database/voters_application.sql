-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2024 at 07:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `voters_application`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('voter','election_officer') NOT NULL DEFAULT 'voter',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'voter', 'test@voter', 'voter', '2024-07-16 09:57:29'),
(2, 'officer', 'test@officer', 'election_officer', '2024-07-16 09:57:29'),
(3, '', '$2y$10$ERh2P4raYNTPfj4Np/hkW.3H9LmhXRJUp3FrW8FRg0qOU1aKsJv2i', '', '2024-07-16 10:07:54'),
(4, '', '$2y$10$vxa6cZn8z3L9c9dd/fzpZeI1fuBNh2xbb1K6MrUI0R2zVsJffyip2', '', '2024-07-18 00:31:39'),
(5, 'user1234', '$2y$10$6vucAsBlHv6D2bXcK.cPT.FYYW9YLT0U/bbNgiThA4pOD7Uo5cdlq', 'voter', '2024-07-18 08:32:13'),
(6, 'voter_test', '$2y$10$JDilbMC17S9D1xPVFCksjeFfeEiGaVbUWs2D4ATWdIgGelCwMt3vq', 'voter', '2024-07-18 08:33:33'),
(7, 'officer_test', '$2y$10$c48EoBCLjGkoqeTnT5nSfOl5TIIuxEP3fJxqcqI28jX48TZri8FJm', 'election_officer', '2024-07-18 08:33:51');

-- --------------------------------------------------------

--
-- Table structure for table `voters`
--

CREATE TABLE `voters` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `image` longblob DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `council` varchar(100) NOT NULL,
  `polling_station` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `voters`
--

INSERT INTO `voters` (`id`, `user_id`, `name`, `date_of_birth`, `image`, `address`, `council`, `polling_station`, `created_at`, `updated_at`) VALUES
(1, 1, 'John Doe', '1980-01-15', NULL, '123 Main St', 'Council A', 'Station 1', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(2, 1, 'Jane Smith', '1990-02-20', NULL, '456 Elm St', 'Council B', 'Station 2', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(3, 1, 'Michael Johnson', '1975-03-25', NULL, '789 Oak St', 'Council A', 'Station 1', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(4, 1, 'Emily Davis', '1985-04-30', NULL, '101 Maple St', 'Council C', 'Station 3', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(5, 1, 'David Miller', '1995-05-05', NULL, '202 Pine St', 'Council A', 'Station 2', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(6, 1, 'Sarah Wilson', '2000-06-10', NULL, '303 Birch St', 'Council B', 'Station 3', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(7, 1, 'James Brown', '1983-07-15', NULL, '404 Cedar St', 'Council C', 'Station 1', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(8, 1, 'Linda Taylor', '1998-08-20', NULL, '505 Spruce St', 'Council A', 'Station 3', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(9, 1, 'Robert Anderson', '1972-09-25', NULL, '606 Aspen St', 'Council B', 'Station 1', '2024-07-16 09:57:29', '2024-07-16 09:57:29'),
(10, 1, 'Patricia Thomas', '1968-10-30', NULL, '707 Walnut St', 'Council C', 'Station 2', '2024-07-16 09:57:29', '2024-07-16 09:57:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voters`
--
ALTER TABLE `voters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `voters`
--
ALTER TABLE `voters`
  ADD CONSTRAINT `voters_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
