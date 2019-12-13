-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 13, 2019 at 10:31 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hw2`
--

-- --------------------------------------------------------

--
-- Table structure for table `factor`
--

CREATE TABLE `factor` (
  `id` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `factor`
--

INSERT INTO `factor` (`id`, `price`) VALUES
(2, 1500);

--
-- Triggers `factor`
--
DELIMITER $$
CREATE TRIGGER `accept_req` BEFORE INSERT ON `factor` FOR EACH ROW BEGIN
	UPDATE request
    SET request.State = 'accepted'
    WHERE request.ID = new.id and request.State = 'checking';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qa`
--

CREATE TABLE `qa` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qa`
--

INSERT INTO `qa` (`id`, `name`, `text`) VALUES
(1, 'shayan', 'hello how are you?'),
(2, 'dennis', 'thank you man');

-- --------------------------------------------------------

--
-- Table structure for table `reply`
--

CREATE TABLE `reply` (
  `question` int(11) NOT NULL,
  `answer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reply`
--

INSERT INTO `reply` (`question`, `answer`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `ID` int(11) NOT NULL,
  `State` enum('rejected','accepted','checking','') NOT NULL DEFAULT 'checking',
  `shorten_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `set_timeout` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`ID`, `State`, `shorten_url`, `url`, `set_timeout`) VALUES
(2, 'accepted', 'happynewyear', 'https://www.happynewyear.com/?id=5', '0000-00-00 00:00:00');

--
-- Triggers `request`
--
DELIMITER $$
CREATE TRIGGER `create_link` AFTER UPDATE ON `request` FOR EACH ROW BEGIN
	IF NEW.state = 'accepted' THEN
        INSERT INTO special_links 
        VALUES(NEW.shorten_url, NEW.url, NEW.set_timeout,1,0,0, CURRENT_TIMESTAMP(),NULL);
        INSERT INTO req_link 
        VALUES(new.ID, NEW.shorten_url);
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `req_link`
--

CREATE TABLE `req_link` (
  `ID` int(11) NOT NULL,
  `shorten_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `req_link`
--

INSERT INTO `req_link` (`ID`, `shorten_url`) VALUES
(2, 'happynewyear');

-- --------------------------------------------------------

--
-- Table structure for table `simple_links`
--

CREATE TABLE `simple_links` (
  `shorten_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `access_inside` tinyint(1) NOT NULL DEFAULT 0,
  `access_outside` tinyint(1) NOT NULL DEFAULT 0,
  `made_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `simple_links`
--

INSERT INTO `simple_links` (`shorten_url`, `url`, `access_inside`, `access_outside`, `made_time`) VALUES
('ramezanmobarak', 'https://www.ramezan.ir/mobarak?color=black', 3, 0, '2019-12-13 23:31:53');

-- --------------------------------------------------------

--
-- Table structure for table `special_links`
--

CREATE TABLE `special_links` (
  `shorten_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `set_timeout` datetime DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  `access_inside` int(11) NOT NULL DEFAULT 0,
  `access_outside` int(11) NOT NULL DEFAULT 0,
  `made_time` datetime NOT NULL DEFAULT current_timestamp(),
  `disabled_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `special_links`
--

INSERT INTO `special_links` (`shorten_url`, `url`, `set_timeout`, `valid`, `access_inside`, `access_outside`, `made_time`, `disabled_time`) VALUES
('happynewyear', 'https://www.happynewyear.com/?id=5', '0000-00-00 00:00:00', 1, 0, 0, '2019-12-13 23:23:20', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `phone_number` varchar(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`phone_number`, `name`, `last_name`) VALUES
('09129121212', 'shayan', 'shafaghi'),
('09199191919', 'dennis', 'ritchie');

-- --------------------------------------------------------

--
-- Table structure for table `user_qa`
--

CREATE TABLE `user_qa` (
  `phone_number` varchar(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_qa`
--

INSERT INTO `user_qa` (`phone_number`, `id`) VALUES
('09129121212', 1),
('09199191919', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_req`
--

CREATE TABLE `user_req` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_req`
--

INSERT INTO `user_req` (`id`, `phone_number`) VALUES
(2, '09129121212');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `factor`
--
ALTER TABLE `factor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qa`
--
ALTER TABLE `qa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reply`
--
ALTER TABLE `reply`
  ADD PRIMARY KEY (`answer`),
  ADD KEY `question` (`question`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `req_link`
--
ALTER TABLE `req_link`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `shorten_url_foreign` (`shorten_url`);

--
-- Indexes for table `simple_links`
--
ALTER TABLE `simple_links`
  ADD PRIMARY KEY (`shorten_url`);

--
-- Indexes for table `special_links`
--
ALTER TABLE `special_links`
  ADD PRIMARY KEY (`shorten_url`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`phone_number`);

--
-- Indexes for table `user_qa`
--
ALTER TABLE `user_qa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Indexes for table `user_req`
--
ALTER TABLE `user_req`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone` (`phone_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `qa`
--
ALTER TABLE `qa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `factor`
--
ALTER TABLE `factor`
  ADD CONSTRAINT `id_foreign` FOREIGN KEY (`id`) REFERENCES `request` (`ID`);

--
-- Constraints for table `reply`
--
ALTER TABLE `reply`
  ADD CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`answer`) REFERENCES `qa` (`id`),
  ADD CONSTRAINT `reply_ibfk_2` FOREIGN KEY (`question`) REFERENCES `qa` (`id`);

--
-- Constraints for table `req_link`
--
ALTER TABLE `req_link`
  ADD CONSTRAINT `id_fore` FOREIGN KEY (`ID`) REFERENCES `request` (`ID`),
  ADD CONSTRAINT `shorten_url_foreign` FOREIGN KEY (`shorten_url`) REFERENCES `special_links` (`shorten_url`);

--
-- Constraints for table `user_qa`
--
ALTER TABLE `user_qa`
  ADD CONSTRAINT `user_qa_ibfk_2` FOREIGN KEY (`id`) REFERENCES `qa` (`id`),
  ADD CONSTRAINT `user_qa_ibfk_3` FOREIGN KEY (`phone_number`) REFERENCES `user` (`phone_number`);

--
-- Constraints for table `user_req`
--
ALTER TABLE `user_req`
  ADD CONSTRAINT `phone` FOREIGN KEY (`phone_number`) REFERENCES `user` (`phone_number`),
  ADD CONSTRAINT `user_req_ibfk_1` FOREIGN KEY (`id`) REFERENCES `request` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
