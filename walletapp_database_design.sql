-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2023 at 02:17 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `walletapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_payment_methods`
--

CREATE TABLE `audit_payment_methods` (
  `audit_id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL DEFAULT 'payment_methods',
  `operation` varchar(255) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `user_id_old` int(11) DEFAULT NULL,
  `user_id_new` int(11) DEFAULT NULL,
  `type_old` varchar(255) DEFAULT NULL,
  `type_new` varchar(255) DEFAULT NULL,
  `card_number_old` varchar(255) DEFAULT NULL,
  `card_number_new` varchar(255) DEFAULT NULL,
  `expiration_date_old` varchar(255) DEFAULT NULL,
  `expiration_date_new` varchar(255) DEFAULT NULL,
  `cvv_old` varchar(255) DEFAULT NULL,
  `cvv_new` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `audit_users`
--

CREATE TABLE `audit_users` (
  `audit_id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL DEFAULT 'users',
  `operation` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email_old` varchar(255) DEFAULT NULL,
  `email_new` varchar(255) DEFAULT NULL,
  `password_old` varchar(255) DEFAULT NULL,
  `password_new` varchar(255) DEFAULT NULL,
  `created_at_old` datetime DEFAULT NULL,
  `created_at_new` datetime DEFAULT NULL,
  `updated_at_old` datetime DEFAULT NULL,
  `updated_at_new` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `audit_users`
--

INSERT INTO `audit_users` (`audit_id`, `table_name`, `operation`, `user_id`, `email_old`, `email_new`, `password_old`, `password_new`, `created_at_old`, `created_at_new`, `updated_at_old`, `updated_at_new`) VALUES
(1, 'users', 'update', 6, 'r7334680@gmail.com', 'r7334680@gmail.com', '$2y$10$M4Nbg6BuvMjEylsqCTvszOwc9K4RfMNy0LkoJxOPKlmkhT9zYy/Xy', '$2y$10$UBkFwbn2n/CAQqujDGTtSOBCtLQ/7CXMhH1bZ/Q6wuJUfR563axQ6', '2023-11-25 23:45:42', '2023-11-25 23:45:42', '2023-11-25 23:45:42', '2023-11-26 00:58:09'),
(2, 'users', 'update', 6, 'r7334680@gmail.com', 'r7334680@gmail.com', '$2y$10$UBkFwbn2n/CAQqujDGTtSOBCtLQ/7CXMhH1bZ/Q6wuJUfR563axQ6', '1221', '2023-11-25 23:45:42', '2023-11-25 23:45:42', '2023-11-26 00:58:09', '2023-11-26 01:16:33');

-- --------------------------------------------------------

--
-- Table structure for table `audit_wallets`
--

CREATE TABLE `audit_wallets` (
  `audit_id` int(11) NOT NULL,
  `table_name` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `balance_old` decimal(10,2) DEFAULT NULL,
  `balance_new` decimal(10,2) DEFAULT NULL,
  `currency_old` varchar(255) DEFAULT NULL,
  `currency_new` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `fee_id` int(11) NOT NULL,
  `transaction_type` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `errors_masseges` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Active` tinyint(1) DEFAULT NULL,
  `table_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `expiration_date` varchar(255) DEFAULT NULL,
  `cvv` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payouts`
--

CREATE TABLE `payouts` (
  `payout_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `transfer_id` int(11) NOT NULL,
  `sender_wallet_id` int(11) NOT NULL,
  `receiver_wallet_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`transfer_id`, `sender_wallet_id`, `receiver_wallet_id`, `amount`, `status`, `created_at`, `updated_at`, `Active`) VALUES
(1, 1, 2, '100.00', 'Completed', '2023-11-27 00:09:54', '2023-11-27 00:09:54', NULL),
(2, 1, 2, '100.00', 'Completed', '2023-11-27 00:21:28', '2023-11-27 00:21:28', NULL),
(3, 1, 2, '100.00', 'Completed', '2023-11-27 00:27:19', '2023-11-27 00:27:19', NULL),
(4, 1, 2, '5.00', 'Completed', '2023-11-27 02:59:06', '2023-11-27 02:59:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `country`, `created_at`, `update_at`) VALUES
(6, 'ahmad', 'r7334680@gmail.com', '1221', 'Pakistan', '2023-11-25 23:45:42', '2023-11-25 20:16:33'),
(8, 'faraz', 'pdfeditingwork@gmail.com', '$2y$10$WAAgXdJCH7sWF9ClBE9gxOJRPxia6RiWaWU6WY3CLqhFVv072AbIy', 'Pakistan', '2023-11-26 01:18:35', '2023-11-25 20:18:35'),
(9, 'Hussain', 'chahmad2004@gmai.com', '$2y$10$/UZHpiRnq/MSDNm40UXQjelqUiovdDjZ5rgOFuYh7GRMnEsH3mmiS', 'Pakistan', '2023-11-26 23:23:28', '2023-11-26 18:23:28');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `after_users_update` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    INSERT INTO audit_users (
        table_name,
        operation,
        user_id,
        email_old,
        email_new,
        password_old,
        password_new,
        created_at_old,
        created_at_new,
        updated_at_old,
        updated_at_new
    ) VALUES (
        'users',
        'update',
        OLD.user_id,
        OLD.email,
        NEW.email,
        OLD.password,
        NEW.password,
        OLD.created_at,
        NEW.created_at,
        OLD.update_at,
        NEW.update_at
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `wallet_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`wallet_id`, `user_id`, `balance`, `currency`, `created_at`, `updated_at`) VALUES
(1, 8, '1395.00', 'pak', '2023-11-26 02:44:12', '2023-11-27 02:59:06'),
(2, 9, '3305.00', 'pak', '2023-11-26 23:28:08', '2023-11-27 02:59:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_payment_methods`
--
ALTER TABLE `audit_payment_methods`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `audit_users`
--
ALTER TABLE `audit_users`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `audit_wallets`
--
ALTER TABLE `audit_wallets`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexes for table `fees`
--
ALTER TABLE `fees`
  ADD PRIMARY KEY (`fee_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_method_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payouts`
--
ALTER TABLE `payouts`
  ADD PRIMARY KEY (`payout_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `payment_method_id` (`payment_method_id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`transfer_id`),
  ADD KEY `sender_wallet_id` (`sender_wallet_id`),
  ADD KEY `receiver_wallet_id` (`receiver_wallet_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`wallet_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_payment_methods`
--
ALTER TABLE `audit_payment_methods`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_users`
--
ALTER TABLE `audit_users`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `audit_wallets`
--
ALTER TABLE `audit_wallets`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees`
--
ALTER TABLE `fees`
  MODIFY `fee_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payouts`
--
ALTER TABLE `payouts`
  MODIFY `payout_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `transfer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `wallet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_users`
--
ALTER TABLE `audit_users`
  ADD CONSTRAINT `audit_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD CONSTRAINT `payment_methods_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `payouts`
--
ALTER TABLE `payouts`
  ADD CONSTRAINT `payouts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `payouts_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`);

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_ibfk_1` FOREIGN KEY (`sender_wallet_id`) REFERENCES `wallets` (`wallet_id`),
  ADD CONSTRAINT `transfers_ibfk_2` FOREIGN KEY (`receiver_wallet_id`) REFERENCES `wallets` (`wallet_id`);

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
