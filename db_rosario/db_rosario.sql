-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2025 at 07:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_rosario`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `Booking_ID` int(11) NOT NULL,
  `Booking_Type` varchar(20) DEFAULT NULL,
  `Room_ID` int(11) DEFAULT NULL,
  `Room_Count` int(11) DEFAULT 1,
  `Adults` int(11) DEFAULT 1,
  `Children` int(11) DEFAULT 0,
  `Customer_ID` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `Date` date NOT NULL,
  `CheckIn_Date` date DEFAULT NULL,
  `CheckOut_Date` date DEFAULT NULL,
  `Time` time NOT NULL,
  `Status` enum('Pending','Confirmed','Cancelled') NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`Booking_ID`, `Booking_Type`, `Room_ID`, `Room_Count`, `Adults`, `Children`, `Customer_ID`, `user_id`, `Date`, `CheckIn_Date`, `CheckOut_Date`, `Time`, `Status`) VALUES
(20, 'online', 1, 2, 1, 1, 4, 4, '2025-07-15', '2025-07-15', '2025-07-23', '06:14:33', 'Pending'),
(21, 'online', 1, 2, 4, 4, 4, 4, '2025-07-15', '2025-07-15', '2025-07-23', '13:03:00', 'Pending'),
(22, 'online', 1, 1, 2, 1, 4, 4, '2025-07-15', '2025-07-23', '2025-07-31', '14:33:39', 'Pending'),
(37, 'online', 1, 1, 4, 2, 5, 14, '2025-07-15', '2025-07-16', '2025-07-30', '17:03:07', 'Pending'),
(45, 'online', 1, 1, 3, 2, 5, 14, '2025-07-15', '2025-07-16', '2025-07-30', '17:48:23', 'Pending'),
(53, 'online', 1, 2, 1, 4, 5, 14, '2025-07-15', '2025-07-16', '2025-07-30', '18:43:49', 'Pending'),
(59, 'online', 1, 2, 2, 4, 5, 14, '2025-07-15', '2025-07-16', '2025-07-30', '19:12:29', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `Customer_ID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Contact_number` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`Customer_ID`, `Name`, `Contact_number`, `Email`, `user_id`) VALUES
(4, 'JANNA PEARLENE PLATA', NULL, '22-31099@g.batstate-u.edu.ph', 4),
(5, 'Janna Plata', '09637338381', 'jannajaplos09@gmail.com', 14);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `Notification_ID` int(11) NOT NULL,
  `Booking_ID` int(11) DEFAULT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `recipient_type` enum('user','staff') DEFAULT NULL,
  `Message` text DEFAULT NULL,
  `Date` datetime DEFAULT current_timestamp(),
  `Status` varchar(20) DEFAULT 'unread'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `Room_ID` int(11) NOT NULL,
  `Room_Name` varchar(100) DEFAULT NULL,
  `Capacity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Status` enum('Available','Booked','Maintenance') DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`Room_ID`, `Room_Name`, `Capacity`, `Price`, `Status`) VALUES
(1, 'Deluxe Suite Room', 4, 450.00, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Role` enum('Admin','Staff') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` text DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `verification_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password`, `created_at`, `photo`, `reset_token`, `reset_expires`, `verified`, `verification_token`) VALUES
(2, 'Janna Japlos', 'janna09@gmail.com', '09123674312', '$2y$10$uis1CXwwRPumGAG6P26gWO0o1nHZRUQcQEW3VkkfWmFce8d.fRBSC', '2025-07-05 12:24:11', NULL, NULL, NULL, 0, NULL),
(4, 'JANNA PEARLENE PLATA', '22-31099@g.batstate-u.edu.ph', NULL, '', '2025-07-11 13:31:45', '', NULL, NULL, 0, NULL),
(5, 'fdafsadsa', 'dsadsa@gmail.com', '091231231321', '$2y$10$n.cBo4FBmJ0exnUg/VLB9ezww88gNz0DgYPNDIZd7ep3CAPBR4GUS', '2025-07-13 14:14:27', NULL, NULL, NULL, 0, NULL),
(6, 'ewqeqwewq', '3211321@gmail.com', '3213213213', '$2y$10$U1hejUU/SywVwkeSNNkTDueKmXVtA26qUWP3dbxf2B.7fwHpn0RO6', '2025-07-13 14:27:17', NULL, NULL, NULL, 0, NULL),
(7, 'jed estor', 'jedestor@gmail.com', '09123213123', '$2y$10$qZtVq8KLaGjXysxHOm22kuyXzg6exOD43rIXuEu/W3sPiK/cflTB6', '2025-07-13 15:40:50', NULL, NULL, NULL, 0, NULL),
(8, 'Janna Japlos', 'jnplrn@gmail.com', '09782636162', '$2y$10$PZWWKhxblKxq7vhw5bX17eHTkw/6yWIjZEwOrzj3JVO7jrncqZZce', '2025-07-14 16:38:38', NULL, '48597c37872452d720f7a5f9c9aced5b', '2025-07-14 18:47:51', 0, NULL),
(9, 'Janna Japlos Plata', 'wuther22@gmail.com', '09876352671', '$2y$10$pf0OjLq.nleWLkLGMZOCu.U3vsx2GiW.QlfWlpRJpJmsFNP0f9QpW', '2025-07-14 16:49:01', NULL, NULL, NULL, 0, NULL),
(14, 'Janna Plata', 'jannajaplos09@gmail.com', '09637338381', '$2y$10$o4O2h/uGXtYlTaN/8C8Cg.wH4jT5VWCCIOLisYp7h/l2geS7vgqLW', '2025-07-15 14:12:33', NULL, NULL, NULL, 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`Booking_ID`),
  ADD KEY `Room_ID` (`Room_ID`),
  ADD KEY `Customer_ID` (`Customer_ID`),
  ADD KEY `User_ID` (`user_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`Customer_ID`),
  ADD KEY `fk_user_customer` (`user_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`Notification_ID`),
  ADD KEY `Booking_ID` (`Booking_ID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`Room_ID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `Booking_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `Customer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `Notification_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `Room_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`),
  ADD CONSTRAINT `fk_user_id_in_bookings` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
