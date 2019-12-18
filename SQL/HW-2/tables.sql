CREATE TABLE `user` (
  `phone_number` varchar(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  PRIMARY KEY (`phone_number`)
);

CREATE TABLE `request` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `State` enum('rejected','accepted','checking','') NOT NULL DEFAULT 'checking',
  `shorten_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `set_timeout` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `qa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `text` text NOT NULL,
   PRIMARY KEY (`id`)
  );
  
 CREATE TABLE `special_links` (
  `shorten_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `set_timeout` datetime DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  `access_inside` int(11) NOT NULL DEFAULT 0,
  `access_outside` int(11) NOT NULL DEFAULT 0,
  `made_time` datetime NOT NULL DEFAULT current_timestamp(),
  `disabled_time` datetime DEFAULT NULL,
  PRIMARY KEY (`shorten_url`)
);


CREATE TABLE `simple_links` (
  `shorten_url` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL,
  `access_inside` tinyint(1) NOT NULL DEFAULT 0,
  `access_outside` tinyint(1) NOT NULL DEFAULT 0,
  `made_time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`shorten_url`)
);


CREATE TABLE `factor` (
  `id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
   PRIMARY KEY (`id`),
  `id_foreign` FOREIGN KEY (`id`) REFERENCES `request` (`ID`)
) ;

CREATE TABLE `reply` (
  `question` int(11) NOT NULL,
  `answer` int(11) NOT NULL,
   PRIMARY KEY (`answer`),
  `reply_ibfk_1` FOREIGN KEY (`answer`) REFERENCES `qa` (`id`),
  `reply_ibfk_2` FOREIGN KEY (`question`) REFERENCES `qa` (`id`)
);



CREATE TABLE `req_link` (
  `ID` int(11) NOT NULL,
  `shorten_url` varchar(200) NOT NULL,
   PRIMARY KEY (`ID`),
   `id_fore` FOREIGN KEY (`ID`) REFERENCES `request` (`ID`),
   `shorten_url_foreign` FOREIGN KEY (`shorten_url`) REFERENCES `special_links` (`shorten_url`)
);



CREATE TABLE `user_qa` (
  `phone_number` varchar(11) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  `user_qa_ibfk_2` FOREIGN KEY (`id`) REFERENCES `qa` (`id`),
  `user_qa_ibfk_3` FOREIGN KEY (`phone_number`) REFERENCES `user` (`phone_number`)
);

CREATE TABLE `user_req` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(11) NOT NULL,
   PRIMARY KEY (`id`),
   `phone` FOREIGN KEY (`phone_number`) REFERENCES `user` (`phone_number`),
   `user_req_ibfk_1` FOREIGN KEY (`id`) REFERENCES `request` (`ID`)
);







