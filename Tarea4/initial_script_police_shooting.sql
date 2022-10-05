--Script to Run in MariaDB or MySQL enginne

drop table if EXISTS Evidence
drop table if EXISTS PersonProfile
drop table if EXISTS Race
drop table if EXISTS FeesAndFines
drop table if EXISTS City
DROP table if EXISTS State





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

insert into State(id,name) VALUES(1,'Ilinois'),(2,'Iowa'),(3,'Texas');
insert into City(id,name) values (1,'Decatour'),(2,'Waterloo'),(3,'Houston'),(4,'San Antonio'),(5,'Dallas');
insert into FeesAndFines(id, total, is_fee_and_fine_payed) VALUES(1,120000, 0),(2,80000, 1),(3,45000,0),(4,300000, 0),(5,95000, 1);
INSERT INTO Race(id,name) VALUES(1,'Hispanic'),(2,'African American'),(3,'Asian'),(4,'Native Hawaian'),(5,'White'),(6,'American Indian');
INSERT into PersonProfile(id,name,race_id,age,gender,signs_of_mental_ilness) 
values
(1,'Emil',1,38,'Male',0),
(2,'Karen',1,42,'Female',1),
(3,'Mike',3,21,'Male',0),
(4,'Carl',3,32,'Male',0),
(5,'Morgan',2,33,'Male',0),
(6,'April',2,27,'Female',0),
(7,'Saul',6,28,'Male',1),
(8,'Dustin',5,19,'Male',0),
(9,'Coddie',6,23,'Male',1),
(10,'Isabell',4,18,'Female',0);

INSERt INTO Evidence(person_id,state_id,city_id,fees_fines_id,armed,threath_level,flee,body_camera,is_geo_coding_exact)
VALUES
(1,2,2,NULL,true,'road rage','highway', true,true),
(2,1,1,1,false,'speed limit','unaccurate',true,true),
(3,2,2,2,false,'robbery', 'false',true,false),
(5,3,3,3,false,'shooting', 'visible',false,false);

-- TEST Get People who have reciveved the payment to the family due the deseace
select pf.name,ev.armed,fee.total, fee.is_fee_and_fine_payed from 
	Evidence ev inner join PersonProfile pf on ev.person_id = pf.id 
    			inner join FeesAndFines fee on ev.fees_fines_id = fee.id
                where fee.id is not NULL  and fee.is_fee_and_fine_payed = 1