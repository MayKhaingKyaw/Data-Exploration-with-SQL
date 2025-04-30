--Checking Unique Value
select Id,count(*)
from MKK.[dbo].[DailyActivity$]
group by Id
order by Id asc;

select distinct Id
from MKK.[dbo].[DailyActivity$];

--Checking Id value which does not use the app
select  B.[ActivityDate],B.Id,A.Id
from MKK.[dbo].[DailyActivity$] B
left join (
select Id from MKK.[dbo].[DailyActivity$]
where [ActivityDate]='2016-05-12') A
on B.Id=A.Id
where [ActivityDate]='2016-04-12'

--Suppose Average Person walking Steps 2,250 per one miles
Select Id,ROUND(AVG(TotalSteps),0) as Average_Step,
	ROUND(AVG([TotalDistance]),0) as Avg_Distance_Kilometers,
	Round((AVG(TotalSteps))/2250,0) as Avg_Miles_PerID,
	ROUND(AVG([Calories]),0) as Burning_Calories,
	ROUND((AVG([SedentaryMinutes])/60),0) as Avg_Sedentary_Hours
from MKK.[dbo].[DailyActivity$]
group by  Id
order by Burning_Calories desc;
-- Daily Movements and Calories Burned 
Select Id,[TotalSteps],
	ROUND([TotalDistance],0) as Distance,
	Round(TotalSteps/2250,0) as Miles_PerID,[Calories]
from MKK.[dbo].[DailyActivity$];

--Daily Routine
SELECT A.Id,Cast(A.[ActivityDate] as Date ) as [ActivityDate],
	Round(SUM(A.[VeryActiveMinutes]+A.[FairlyActiveMinutes]+A.[LightlyActiveMinutes])/60,0) as [ActiveHours],
	A.[TotalSteps],Round((A.[SedentaryMinutes])/60,0) as [SedentaryHours],
	Round((B.[TotalMinutesAsleep])/60,0) as [TotalHoursAsleep],Round((B.[TotalTimeInBed])/60,0) as [TotalHoursInBed]
FROM MKK.[dbo].[DailyActivity$] A
left join MKK.[dbo].[SleepDay$] B
	on A.Id=B.Id and A.[ActivityDate] = B.[SleepDay]
group by A.Id,[ActivityDate],[SedentaryMinutes],[TotalSteps],[TotalMinutesAsleep],[TotalTimeInBed]
order by [ActivityDate] asc;
--Suppose Adults (18–59 years) Aim for 7,000–10,000 steps/day to maintain general health and reduce mortality risk.
Select Id,[ActivityDate],
	[TotalSteps],
	ROUND([TotalDistance],0) as Distance,
	case  
	when [TotalSteps] < 7000 then 'Low_Activity_Level'
	when [TotalSteps] between 7000 and 10000  then 'Somewhat_Active_Level'
	when [TotalSteps] between 10000 and 12000  then 'Active_Level'
	when [TotalSteps]>12000 then 'Very_Active_Level'
	end as 'Activity_Level'
from MKK.[dbo].[DailyActivity$];
--Summary One Month Activity
SELECT A.Id,Round(SUM([TotalDistance]),0) as [TotalDistance],
	Round(SUM(A.[VeryActiveMinutes]+A.[FairlyActiveMinutes]+A.[LightlyActiveMinutes])/60,0) as [ActiveHours],
	SUM(A.[TotalSteps]) as [TotalSteps],
	Round(sum((A.[SedentaryMinutes]))/60,0) as [SedentaryHours],
	Round(sum(B.[TotalMinutesAsleep])/60,0) as [TotalHoursAsleep],
	Round(sum(B.[TotalTimeInBed])/60,0) as [TotalHoursInBed]
FROM MKK.[dbo].[DailyActivity$] A
left join MKK.[dbo].[SleepDay$] B
	on A.Id=B.Id and A.[ActivityDate] = B.[SleepDay]
group by A.Id--,A.[SedentaryMinutes],A.[TotalSteps],B.[TotalMinutesAsleep],B.[TotalTimeInBed]
order by A.Id asc;
--Average Active hours by ID
SELECT A.Id,
		Round((SUM(A.[VeryActiveMinutes]+A.[FairlyActiveMinutes]+A.[LightlyActiveMinutes])/60)/31,0)
		as [ActiveHours]
FROM MKK.[dbo].[DailyActivity$] A
group by A.Id
order by A.Id asc;