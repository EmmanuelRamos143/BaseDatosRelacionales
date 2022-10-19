@ECHO OFF
:: Script to import CSV file into MySQL Database.
SETLOCAL EnableExtensions EnableDelayedExpansion
SET scriptpath=%~dp0
set scriptname=%~n0
PUSHD %scriptpath:~0,-1%


:loop
IF NOT "%1"=="" (
    IF "%1"=="-dbmysql" (
        SET dbmysql=%2
        SHIFT
    )
	SHIFT
    GOTO :loop
)


IF "%dbmysql%"=="" SET dbmysql=BDR

mysql --login-path=local %dbmysql% < initial_script.sql
mysql --login-path=local %dbmysql% -e "LOAD DATA INFILE 'C:/MySQL/Uploads/State.csv' INTO TABLE State COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES"
mysql --login-path=local %dbmysql% -e "LOAD DATA INFILE 'C:/MySQL/Uploads/City.csv' INTO TABLE City COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES"
mysql --login-path=local %dbmysql% -e "LOAD DATA INFILE 'C:/MySQL/Uploads/FeesAndFines.csv' INTO TABLE FeesAndFines COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\r\n' IGNORE 1 LINES"
mysql --login-path=local %dbmysql% -e "LOAD DATA INFILE 'C:/MySQL/Uploads/Race.csv' INTO TABLE Race COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES"
mysql --login-path=local %dbmysql% -e "LOAD DATA INFILE 'C:/MySQL/Uploads/PersonProfile.csv' INTO TABLE PersonProfile COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES"
mysql --login-path=local %dbmysql% -e "LOAD DATA INFILE 'C:/MySQL/Uploads/Evidence.csv' INTO TABLE Evidence COLUMNS TERMINATED BY ','  LINES TERMINATED BY '\n' IGNORE 1 LINES"