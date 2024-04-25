/*data exploration of smart devices used by customers
skill used : Inner Join/group by/Aliasing/Cast/union/AVG/Round
*/
--viewing each table
select * 
from Case_Study_Project..daily_activity;

select *
from Case_Study_Project..sleep_day;
--where sleep_day='2016-04-12 00:00:00.000';

select *
from Case_Study_Project..daily_steps;

select *
from Case_Study_Project..Weight_log_info;

--sleeping_hour for each Id
select *
from Case_Study_Project..sleep_day;

--drop unwanted column

alter table Case_Study_Project..sleep_day
drop column F6,F7;

select Id
--,Count(Id)
from Case_Study_Project..daily_activity
group by Id;

select Id
--,Count(Id)
from Case_Study_Project..sleep_day
group by Id;

select Id
--,Count(Id)
from Case_Study_Project..daily_steps
group by Id;

select Id
--,Count(Id)
from Case_Study_Project..Weight_log_info
group by Id;

--viewing daily sleep hour 

select Id,CAST (Sleep_day AS Date) AS Date, ROUND (Total_Minutes_Asleep/60,2) AS Total_sleep_hr,
ROUND (Total_Time_In_Bed/60,2) AS Time_in_Bed_hr
from Case_Study_Project..sleep_day;
--where Id = 1503960366;

select Distinct(Case_Study_Project..daily_activity.Id),Cast(Sleep_Day AS Date) AS Date,ROUND (Total_Minutes_Asleep/60,2) AS Total_sleep_hr
from Case_Study_Project..daily_activity
INNER JOIN Case_Study_Project..sleep_day
ON Case_Study_Project..daily_activity.Id=Case_Study_Project..sleep_day.Id
Group by Case_Study_Project..daily_activity.Id,Sleep_Day,Total_Minutes_Asleep;


--viewing daily steps

select Id, CAST(Activity_Day AS Date) AS Date,Step_Total
from Case_Study_Project..daily_steps;

select Distinct(Id),AVG(Step_Total) AS avg_distince
from Case_Study_Project..daily_steps
group by Id
order by Id;

select Distinct(Id),AVG(Total_Steps) AS avg_distince
from Case_Study_Project..daily_activity
group by Id
order by Id;

--select Distinct(Id),Activity_Date,Total_Distance, Total_Steps
--from Case_Study_Project..daily_activity
--where Id=1503960366;

select Distinct(Case_Study_Project..daily_activity.Id),Cast(Activity_Date AS Date) AS Date,Total_Steps
from Case_Study_Project..daily_activity
INNER JOIN Case_Study_Project..daily_steps
ON Case_Study_Project..daily_activity.Id=Case_Study_Project..daily_steps.Id
--where Case_Study_Project..daily_activity.Activity_Date='2016-04-12 00:00:00.000' 
Group by Case_Study_Project..daily_activity.Id,Activity_Date,Total_steps
--order by 1,
union
select  Case_Study_Project..daily_steps.Id,Cast(Activity_Day AS Date) AS Date,Step_Total
--,(Total_Minutes_Asleep/60) AS Minutes_asleep_Hour
from Case_Study_Project..daily_steps
INNER JOIN Case_Study_Project..sleep_day
ON  Case_Study_Project..daily_steps.Id=Case_Study_Project..sleep_day.Id
group by Case_Study_Project..daily_steps.Id,Activity_Day,Step_Total;


--Joining two tables to view step total and sleep hour per day

select  Case_Study_Project..daily_steps.Id,Activity_Day,Step_Total
from Case_Study_Project..daily_steps
INNER JOIN Case_Study_Project..sleep_day
ON  Case_Study_Project..daily_steps.Id=Case_Study_Project..sleep_day.Id
group by Case_Study_Project..daily_steps.Id,Activity_Day,Step_Total
--union
select  Case_Study_Project..sleep_day.Id,sleep_day,ROUND(Total_Minutes_Asleep/60,2) AS Minutes_asleep_Hour
from Case_Study_Project..daily_steps
INNER JOIN Case_Study_Project..sleep_day
ON  Case_Study_Project..daily_steps.Id=Case_Study_Project..sleep_day.Id
group by Case_Study_Project..sleep_day.Id,sleep_day,(Total_Minutes_Asleep/60);

--viewing step total and weightlog info

select Id,Date,Weight_Lb
from Case_Study_Project..Weight_log_info;
--group by Id,Date,Weight_Lb;

 select distinct(Case_Study_Project..Weight_log_info.Id), CAST(Date AS Date)AS Date, Step_total,Round(Weight_Lb,2)
 from Case_Study_Project..Weight_log_info
 INNER Join Case_Study_Project..daily_steps
 ON Case_Study_Project..Weight_log_info.Id=Case_Study_Project..daily_steps.Id
 group by Case_Study_Project..Weight_log_info.Id,Date,Step_total,Weight_Lb;


select Distinct(Id),Activity_Date,Round(Very_Active_Distance,2) AS Very_Active_distance,Very_Active_Minutes
from Case_Study_Project..daily_activity;

--total active minutes,total calories of each Id for 30 days

select Id,sum(Very_Active_Minutes + Fairly_Active_Minutes+ Lightly_Active_Minutes+Sedentary_Minutes)/60 As Total_Active_hour,sum(Calories) As Total_calories
from Case_Study_Project..daily_activity
group by Id
order by Id;

select *
from Case_Study_Project..daily_activity;