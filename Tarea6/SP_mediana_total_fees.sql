CREATE PROCEDURE bdr.mediana_total_fees()
begin
	select @lim := COUNT(f.total)/2 as tot from feesandfines f order by f.total;
	IF(@lim % 2 != 0) THEN
		set @sql := CONCAT('select total from feesandfines  order by total limit ',ROUND(@lim+1), ',1');
		prepare stmn from @sql;
		execute stmn;
		DEALLOCATE PREPARE stmn;
	elseif(@lim % 2 = 0) then
		set @str := concat('with t1 as ((select * from feesandfines  order by total limit ',ROUND(@lim), ',1)' );
		set @str2 := concat('(select * from feesandfines order by total limit ',ROUND(@lim +1), ',1))' );
		set @sql  := (CONCAT(@str,' UNION ',@str2));
		set @sql3  := CONCAT(@sql, 'select sum(total)/2 from t1');
		prepare stmn from @sql3;
		execute stmn;
		DEALLOCATE PREPARE stmn;
	end if;
	
end;