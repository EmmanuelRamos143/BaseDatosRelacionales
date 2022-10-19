
create table if not EXISTS State(
	id int NOT NULL AUTO_INCREMENT,
  	name varchar(255),
    PRIMARY KEY (`id`)
);

CREATE TABLE IF not EXISTS City(
	id int NOT NULL AUTO_INCREMENT,
  	name varchar(255),
   PRIMARY KEY (`id`)
);

create TABLE IF not EXISTS FeesAndFines(
	id int NOT NULL AUTO_INCREMENT,
  	total int not NULL,
  	is_fee_and_fine_payed bit,
   PRIMARY KEY (`id`)
);

create table if not EXISTS Race(
	id int NOT NULL AUTO_INCREMENT,
  	name varchar(255),
    PRIMARY KEY (`id`)
);

create table if not EXISTS PersonProfile(
	id int NOT NULL AUTO_INCREMENT,
  	name varchar(255),
  	race_id int not NULL,
    age int,
  	gender varchar(255),
  	signs_of_mental_ilness bit,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_Race_PersonProfile` FOREIGN KEY (`race_id`) REFERENCES `Race` (`id`)
);




create table if not exists Evidence
(
  id int NOT NULL AUTO_INCREMENT,
  person_id int NOt NULL,
  state_id int,
  city_id int,
  fees_fines_id int,
  armed varchar(100),
  threath_level varchar(100),
  flee varchar(255),
  body_camera bit,
  is_geo_coding_exact bit,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_PersonProfile_Evidence` FOREIGN KEY (`person_id`) REFERENCES `PersonProfile` (`id`),
  CONSTRAINT `FK_State_Evidence` FOREIGN KEY (`state_id`) REFERENCES `State` (`id`),
  CONSTRAINT `FK_City_Evidence` FOREIGN KEY (`city_id`) REFERENCES `City` (`id`),
  CONSTRAINT `FK_FeesAndFines_Evidence` FOREIGN KEY (`fees_fines_id`) REFERENCES `FeesAndFines` (`id`)
);