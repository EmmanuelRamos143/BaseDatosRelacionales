select (sum((Father-meanX) * (Son-meanY))) / 
	(sqrt( sum(pow(Father-meanX,2))) * sqrt( sum(pow(Son-meanY,2)))   ) from (
select  *,AVG(Father) OVER() AS meanX, AVG(Son) OVER() AS meanY from father_son_eight
) a
