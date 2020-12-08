
--Drop Database if it is exist

Drop database if exists fellowship cascade;

--create database if already exist

create schema fellowship;

--use database fellowship

use fellowship;

--Create view with username, date&time spliting time and date, keyboard, and mouse

create view fellowship.userlog_analysis as select user_name,cast(date_time as timestamp),to_date(date_time) as datelog 
,substr(date_time,12) as timelog ,keyboard,mouse from userlog.userlogs;


--create view by grouping the data for login time

create view fellowship.userlog_login as select split(user_name,'@')[0] as username,
datelog,min(timelog) as login from fellowship.userlog_analysis group by datelog,user_name;

--create view by grouping the data for logout time

create view fellowship.userlog_logout as select split(user_name,'@')[0] as username,datelog,max(timelog) as logout from fellowship.userlog_analysis group by datelog,user_name;


--create view with finding working time

create view fellowship.avghour as SELECT t1.username,unix_timestamp(t2.logout,'HH:mm:ss')-unix_timestamp(t1.login,'HH:mm:ss') as seconds
FROM fellowship.userlog_login t1, fellowship.userlog_logout t2
WHERE t1.username=t2.username and t1.datelog=t2.datelog;

--creating view with group by users

create view fellowship.final_avg_hour as select username,((sum(seconds) / 60)/60)/6 as low_avg_hour from fellowship.avghour group by username;


--creating the view with rounding the values


create view fellowship.userlog_avg_hour as select username,round(low_avg_hour,2) as hours from final_avg_hour;


