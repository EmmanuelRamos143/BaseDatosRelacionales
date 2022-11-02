create or replace view PeopleWithMentalIlnessByState as
select count(*),s.name, p.gender 
	from state s 
	left join evidence e  on s.id = e.state_id 
	inner join personprofile p  on p.id = e.person_id 
	group by s.name , p.gender order by s.name 

-- Select Query	
select * from bdr.peoplewithmentalilnessbystate 	
	
create or replace view PeopleArmeWithGunByStateAndCity as
select * from (
select count( case when e.threath_level in ('asault rifle', 'armed gun', 'armed other') then 1 else 0 end) as armed_with_gun ,s.name as state_name ,c.name as city_name from 
	bdr.state s right join evidence e on s.id = e.state_id 
	inner join city c on e.city_id = c.id 
	group by s.name, c.name 
) tb1
group by tb1.state_name
	order by  tb1.armed_with_gun desc 

-- Select Query	
select * from bdr.peoplearmewithgunbystateandcity 	
	
create or replace view StateWithMostFeeAndFinesPayed as
select * from	(
select count(f.is_fee_and_fine_payed) as fee_payed, s.name as city_name from bdr.state s 
	inner join evidence e  on s.id = e.state_id 
	inner join bdr.feesandfines f on e.fees_fines_id = f.id 
	group by s.name
	) tb1  order by tb1.fee_payed desc
	
	select distinct threath_level from evidence e 
	select distinct armed from evidence
-- Select Query
select * from bdr.statewithmostfeeandfinespayed s	
-- bdr.evidence_audit definition

CREATE TABLE `evidence_audit` (
  `id`	int NOT null auto_increment,
  `id_evidence` int NOT NULL ,
  `person_id` int NOT NULL,
  `state_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `fees_fines_id` int DEFAULT NULL,
  `armed` varchar(100) DEFAULT NULL,
  `threath_level` varchar(100) DEFAULT NULL,
  `flee` varchar(255) DEFAULT NULL,
  `body_camera` bit(1) DEFAULT NULL,
  `is_geo_coding_exact` bit(1) DEFAULT NULL,
  `operation_type` varchar(50) default null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;	
	

CREATE DEFINER=`root`@`localhost` TRIGGER `evidence_AfterInsert` AFTER INSERT ON `evidence` FOR EACH ROW INSERT INTO evidence_audit 
(id_evidence, person_id, state_id, city_id, fees_fines_id, armed, threath_level, flee, body_camera, is_geo_coding_exact, operation_type)
  VALUES(NEW.id, NEW.person_id, NEW.state_id, NEW.city_id, NEW.fees_fines_id, NEW.armed, NEW.threath_level, NEW.flee, NEW.body_camera,NEW.is_geo_coding_exact,  'INSERT')
  
-- Test onInsert Trigger
insert into evidence(person_id, state_id, city_id, fees_fines_id, armed, threath_level, flee, body_camera, is_geo_coding_exact)
VALUES(1,1,1,801,1,'armed knife','flee',1,1)  


CREATE DEFINER=`root`@`localhost` TRIGGER `evidence_AfterDelete` AFTER DELETE ON `evidence` FOR EACH ROW INSERT INTO evidence_audit 
(id_evidence, person_id, state_id, city_id, fees_fines_id, armed, threath_level, flee, body_camera, is_geo_coding_exact, operation_type)
  VALUES(OLD.id, OLD.person_id, OLD.state_id, OLD.city_id, OLD.fees_fines_id, OLD.armed, OLD.threath_level, OLD.flee, OLD.body_camera,OLD.is_geo_coding_exact,  'DELETE')
   
-- Test onDelete Trigger
delete from evidence where id = 4

  