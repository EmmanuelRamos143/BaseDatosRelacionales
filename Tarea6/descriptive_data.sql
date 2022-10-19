--- Mode
select total from feesandfines group by total order by count(*) desc limit 1

-- Min and max
select min(f.total),max(f.total)  from personprofile p inner join evidence e on p.id = e.person_id inner join feesandfines f on f.id = e.fees_fines_id 
group by p.gender 


--Window Function using max and count, work example
select * from (
 select Identifier,SourceValue, TargetValue, InsertDate,count(*) over(PARTITION BY SourceValue,TargetValue) as cont, MAX(InsertDate) over(PARTITION BY SourceValue,TargetValue) as max_insert from linq.WipAttributeMaps
 ) t1
 where t1.cont > 1 and t1.InsertDate = t1.max_insert
 
-- Mean grouped by gender 
select p.gender , avg(f.total) from personprofile p inner join evidence e on p.id = e.person_id inner join feesandfines f on f.id = e.fees_fines_id 
group by p.gender 