-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2025 at 02:45 PM
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
  `User_ID` int(11) DEFAULT NULL,
  `Date` date NOT NULL,
  `CheckIn_Date` date DEFAULT NULL,
  `CheckOut_Date` date DEFAULT NULL,
  `Time` time NOT NULL,
  `Status` enum('Pending','Confirmed','Cancelled') NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `Customer_ID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Contact_number` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `User_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `Notification_ID` int(11) NOT NULL,
  `Booking_ID` int(11) DEFAULT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Message` text DEFAULT NULL,
  `Date` datetime DEFAULT current_timestamp(),
  `Status` enum('Unread','Read') DEFAULT 'Unread'
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
  `User_ID` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `created_at`, `photo`) VALUES
(1, 'Janna plata', 'jannajaplos09@gmail.com', '0987263241', '$2y$10$35iJwbZ39z93fyFL0yl8hObVvK5cTE0xWbOdydAQvC6DnVdcBW17i', '2025-07-05 07:14:53', NULL),
(2, 'Janna Japlos', 'janna09@gmail.com', '09123674312', '$2y$10$uis1CXwwRPumGAG6P26gWO0o1nHZRUQcQEW3VkkfWmFce8d.fRBSC', '2025-07-05 12:24:11', NULL),
(3, 'janna plata', 'jannaplata09@gmail.com', '09162748321', '$2y$10$TY7aZb3zobthHtEC.oruqeKrAHJYcysbAkM2rg6neglhKRl2pOjui', '2025-07-05 12:29:07', NULL),
(4, 'JANNA PEARLENE PLATA', '22-31099@g.batstate-u.edu.ph', NULL, '', '2025-07-11 13:31:45', ''),
(5, 'fdafsadsa', 'dsadsa@gmail.com', '091231231321', '$2y$10$n.cBo4FBmJ0exnUg/VLB9ezww88gNz0DgYPNDIZd7ep3CAPBR4GUS', '2025-07-13 14:14:27', NULL),
(6, 'ewqeqwewq', '3211321@gmail.com', '3213213213', '$2y$10$U1hejUU/SywVwkeSNNkTDueKmXVtA26qUWP3dbxf2B.7fwHpn0RO6', '2025-07-13 14:27:17', NULL),
(7, 'jed estor', 'jedestor@gmail.com', '09123213123', '$2y$10$qZtVq8KLaGjXysxHOm22kuyXzg6exOD43rIXuEu/W3sPiK/cflTB6', '2025-07-13 15:40:50', NULL);

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
  ADD KEY `User_ID` (`User_ID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`Customer_ID`),
  ADD KEY `fk_user_customer` (`User_ID`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`Notification_ID`),
  ADD KEY `Booking_ID` (`Booking_ID`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`Room_ID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`User_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `Booking_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `Customer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
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
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`User_ID`) REFERENCES `staff` (`User_ID`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_user_customer` FOREIGN KEY (`User_ID`) REFERENCES `users` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `bookings` (`Booking_ID`),
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `staff` (`User_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
