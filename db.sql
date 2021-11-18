DELETE FROM mysql.user WHERE User='';

CREATE DATABASE `testapp`;

USE `testapp`;

CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE USER 'testuser'@'%' IDENTIFIED BY '12345';
GRANT ALL ON `testapp`.`items` TO 'testuser';

FLUSH PRIVILEGES;

INSERT INTO `testapp`.`items`
(`price`, `name`)
VALUES(100, 'axe'),(200, 'sword');