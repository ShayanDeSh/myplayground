CREATE TABLE `drivers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0,
  `phone` VARCHAR(11) NOT NULL UNIQUE,
  PRIMARY KEY (`id`));

CREATE TABLE `passengers`
 ( `id` INT NOT NULL AUTO_INCREMENT, `first_name` VARCHAR(45) NOT NULL,
 `last_name` VARCHAR(45) NOT NULL, `phone` VARCHAR(11) NOT NULL, PRIMARY KEY (`id`), 
 FOREIGN KEY (`phone`) REFERENCES `drivers` (`phone`))


CREATE TABLE `discounts` (
  `code` VARCHAR(88) NOT NULL,
  `passenger` INT NOT NULL,
  `availables` INT UNSIGNED NOT NULL,
  `discount` INT(2) NOT NULL,
  PRIMARY KEY (`code`, `passenger`),
    FOREIGN KEY (`passenger`)
    REFERENCES `passengers` (`id`));

CREATE TABLE `rides` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `driver` INT(11) NOT NULL,
  `passanger` INT(11) NOT NULL,
  `source_lat` FLOAT NOT NULL,
  `source_lng` FLOAT NOT NULL,
  `destination_lat` FLOAT NOT NULL,
  `destination_lng` FLOAT NOT NULL,
  `second_destination_lat` FLOAT NULL DEFAULT NULL,
  `second_destination_lng` FLOAT NULL DEFAULT NULL,
  `total_price` INT(10) UNSIGNED NOT NULL,
  `final_price` INT(10) UNSIGNED NOT NULL,
  `discount` VARCHAR(88) NULL DEFAULT NULL,
  `start_time` DATETIME NOT NULL,
  `finish_time` DATETIME NULL DEFAULT NULL,
  `score` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`passanger` , `discount`)
    REFERENCES `discounts` (`passenger` , `code`),
    FOREIGN KEY (`driver`)
    REFERENCES  drivers` (`id`),
    FOREIGN KEY (`passanger`)
    REFERENCES `passengers` (`id`)
);



