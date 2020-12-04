#Create DataBase:

create database test;

#Show DataBases:

show databases;

#DB with Properties

create  database test
WITH DBPROPERTIES ('creator' = 'CHELUVESHA', 'date' = '2020-12-03');

#Describe DB 

describe database extended test;
#OK
#test		hdfs://localhost:54310/user/hive/warehouse/test.db	cheluvesha	USER	{date=2020-12-03, creator=CHELUVESHA}
#Time taken: 0.079 seconds, Fetched: 1 row(s)

#Drop Database

drop database demo;

#create database if not exists demo;

create database if not exists demo;

#drop database if exists demo;

drop database if exists demo;

#In Hive, it is not allowed to drop the database that contains the tables directly. In such a case, 
#we can drop the database either by dropping tables first or use Cascade keyword with the command.

#This command automatically drops the tables present in the database first.

drop database if exists demo cascade;  

#n Hive, we can create a table by using the conventions similar to the SQL.
#It supports a wide range of flexibility where the data files for tables are stored. It provides two types of table: 

Internal table
External table

#Create Table 

create table demo.employee(Id int, Name string, salary float)
row format delimited
fields terminated by ',';

#Describe Table

describe demo.employee;
-OK
id                  	int                 	                    
name                	string              	                    
salary              	float               

#While creating a table, we can add the comments to the columns and can also define the table properties.

create table demo.new_employee(id int comment 'Employee ID', name string comment 'Employee Name' , salary float comment 'Employee Salary')
comment 'Table Description'
TBLProperties ('creator'='CHELUVESHA', 'created_at' = '2020-12-03'); 


describe demo.new_employee;

#Hive allows creating a new table by using the schema of an existing table.

create table if not exists demo.copy_employee 
like demo.employee;

#External queries

hdfs dfs -mkdir /HiveDirectory


CREATE EXTERNAL TABLE world_population (
    > world_rank INT,
    > country STRING,
    > population BIGINT,
    > world DOUBLE,
    > extra_data STRING )
    > ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    > STORED AS TEXTFILE
    > LOCATION '/HiveDirectory';

#load data into hdfs by using below command:

load data local inpath "/home/cheluvesha/Documents/worldpopulation.csv" into table world_population;

#insert data into table

insert into world_population values (197,'test c1',900,0.01,'xyz');


Select * from world_population;


select population from world_population where country = 'India';


#Alter

ALTER TABLE name RENAME TO new_name
ALTER TABLE name ADD COLUMNS (col_spec[, col_spec ...])
ALTER TABLE name DROP [COLUMN] column_name
ALTER TABLE name CHANGE column_name new_name new_type
ALTER TABLE name REPLACE COLUMNS (col_spec[, col_spec ...])


ALTER table world_population RENAME to WorldPopulation;

#DROP

DROP TABLE IF EXISTS employee;


