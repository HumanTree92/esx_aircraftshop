USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_aircraftdealer','Airliner',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_aircraftdealer','Airliner',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('aircraftdealer','Airliner')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('aircraftdealer',0,'recruit','Recrue',10,'{}','{}'),
	('aircraftdealer',1,'novice','Novice',25,'{}','{}'),
	('aircraftdealer',2,'experienced','Experimente',40,'{}','{}'),
	('aircraftdealer',3,'boss','Patron',0,'{}','{}')
;

CREATE TABLE `aircraftdealer_aircrafts` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`vehicle` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `owned_aircrafts` (
	`owner` varchar(30) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `rented_aircrafts` (
	`vehicle` varchar(60) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`player_name` varchar(255) NOT NULL,
	`base_price` int(11) NOT NULL,
	`rent_price` int(11) NOT NULL,
	`owner` varchar(30) NOT NULL,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `aircraft_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `aircraft_categories` (name, label) VALUES
	('plane','Planes'),
	('heli','Helicopters')
;

CREATE TABLE `vehicles` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,
	PRIMARY KEY (`model`)
);

INSERT INTO `vehicles` (name, model, price, category) VALUES
	('Alpha Z1','alphaz1',1595000,'plane'),
	('Besra','besra',1150000,'plane'),
	('Cuban 800','cuban800',240000,'plane'),
	('Dodo','dodo',500000,'plane'),
	('Duster','duster',275000,'plane'),
	('Howard NX25','howard',975000,'plane'),
	('Luxor','luxor',1625000,'plane'),
	('Luxor Deluxe ','luxor2',10000000,'plane'),
	('Mallard','stunt',250000,'plane'),
	('Mammatus','mammatus',300000,'plane'),
	('Nimbus','nimbus',1900000,'plane'),
	('Shamal','shamal',1150000,'plane'),
	('Velum','velum2',1323350,'plane'),
	('Vestra','vestra',950000,'plane'),
	('Frogger','frogger',1300000,'heli'),
	('Maverick','maverick',780000,'heli'),
	('SuperVolito','supervolito',2113000,'heli'),
	('SuperVolito Carbon','supervolito2',3330000,'heli'),
	('Swift','swift',1500000,'heli'),
	('Swift Deluxe','swift2',5150000,'heli'),
	('Volatus','volatus',2295000,'heli')
;
