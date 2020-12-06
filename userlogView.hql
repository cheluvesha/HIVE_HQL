
--Drop Database if it is exist

Drop database if exists fellowship cascade;

--Drop view table if already exist

Drop view if exists userloganalysis;

--create database if already exist

create schema fellowship;

--use database fellowship

use fellowship;

--Create view with username, date&time spliting time and date, keyboard, and mouse

create view fellowship.userlog_analysis as select user_name,cast(date_time as timestamp),to_date(date_time) as datelog 
,substr(date_time,12) as timelog ,keyboard,mouse from userlog.userlogs;


Describe fellowship.userlog_analysis;

--print the table

select user_name,datelog,min(timelog) from fellowship.userlog_analysis group by datelog,user_name;
