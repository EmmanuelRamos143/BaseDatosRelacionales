CREATE DEFINER=`root`@`localhost` PROCEDURE `bdr`.`calulcate_correlation`(tableName varchar(255), 
columnX varchar(255), 
columnY varchar(255))
BEGIN
set @queryStr = concat_ws(char(13),
	'select (sum((',columnX,
	'-meanX) * (',
	 columnY,
	'-meanY))) /',
	'(sqrt( sum(pow(',
	columnX,
	'-meanX,2))) * sqrt( sum(pow(',
	columnY,
	'-meanY,2)))   ) from (',
	'select  *,AVG(',
	columnX,
	') OVER() AS meanX, AVG(',
	columnY,
	') OVER() AS meanY from ',
	tableName,
	') a');

PREPARE stmt FROM @queryStr;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END