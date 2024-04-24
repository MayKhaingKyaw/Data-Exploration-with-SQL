select top 10 * 
from Project_totorial..comments

select top 10 * 
from Project_totorial..[videos-stats]

--What are the most commented-upon videos? Or the most liked?

select vd.[Video ID], count(vd.Comments) as max_cmt,count(vd.Likes) as max_Like
from Project_totorial..comments cmt
join Project_totorial..[videos-stats] vd 
on cmt.[Video ID]=vd.[Video ID]
group by vd.[Video ID]
order by max_cmt desc

--How many total views does each category have? How many likes?
select [Keyword],sum(views) as sum_view,sum(Likes) as total_like
from Project_totorial..[videos-stats]
group by keyword
order by sum_view desc
select top 10 * 
from Project_totorial..comments


--What are the most-liked comments?

select [Video ID], Comment,Likes
from Project_totorial..comments
order by Likes desc

--What is the ratio of views/likes per video? Per each category?
select Keyword, [Video ID], 
iif (Likes!=0,Views/Likes,Likes)as ratio
from Project_totorial..[videos-stats]

--select Keyword,count( Views),count(Likes)
--from Project_totorial..[videos-stats]
--group by Keyword

--What is the average sentiment score in each keyword category?

select vd.Keyword,avg(Sentiment) as Avg_Sentiment
from Project_totorial..comments cmt
join Project_totorial..[videos-stats] vd 
on cmt.[Video ID]=vd.[Video ID]
group by vd.Keyword

--How many times do company names (i.e., Apple or Samsung) appear in each keyword category?

SELECT count(*) 
FROM Project_totorial..[videos-stats]
WHERE CHARINDEX('Apple', Title, 0) > 0 

SELECT count(*) 
FROM Project_totorial..[videos-stats]
where CHARINDEX('Samsung', Title, 0) > 0 
--SELECT 
--case
--when CHARINDEX('Samsung', Title, 0) > 0 then 'A'
--when CHARINDEX('Apple', Title, 0) > 0 then 'B'
--else 'N'
--end as Name,
--count(*) as No
--FROM Project_totorial..[videos-stats]
--group by Title
----WHERE CHARINDEX('Samsung', Title, 0) > 0 


SELECT count(*)
FROM Project_totorial..[videos-stats]
where Title Like '%Apple%' or Title Like '%Samsumg%'
or Title Like '%Twitter%' or Title Like 'Facebook';

SELECT count(Title),Title
FROM Project_totorial..[videos-stats]
where Title Like '%Apple%' or Title Like '%Samsumg%'
or Title Like '%Twitter%' or Title Like '%Facebook%'
or Title Like '%Sony%' or Title Like '%Instagram%'
or Title Like '%Amazon%' or Title Like '%Microsoft%'
or Title Like '%Youtube%' or Title Like '%Netflix%'
or Title Like '%Disney%'
group by Title
;