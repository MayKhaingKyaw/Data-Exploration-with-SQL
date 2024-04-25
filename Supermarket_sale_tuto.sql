select * from Project_totorial..['supermarket_sales] 

--Which branch has the best results in the loyalty program?
select count([Customer type]) AS Customer,Branch
from Project_totorial..['supermarket_sales]
where [Customer type]='Member'
group by Branch;

--Does the membership depend on customer rating?
select count(*),[Customer type]
from Project_totorial..['supermarket_sales]
group by [Customer type];

select 
max(Rating) As max_rate,min(Rating) as min_rate,avg(Rating) as avg_rate
from Project_totorial..['supermarket_sales]
where [Customer type]='Member';

select 
max(Rating) As max_rate,min(Rating) as min_rate,avg(Rating) as avg_rate
from Project_totorial..['supermarket_sales]
where [Customer type]='Normal';

--Does gross income depend on the proportion of customers in the loyalty program? On payment method?
select [Customer type],[gross income],Payment
from Project_totorial..['supermarket_sales] ;

select [Customer type],SUM([gross income]) as Total
from Project_totorial..['supermarket_sales] 
group by [Customer type];

select Payment,SUM([gross income]) as Total
from Project_totorial..['supermarket_sales] 
group by Payment
order by Total;

--Are there any differences in indicators between men and women?
select [Product line],COUNT(*) as Total
from Project_totorial..['supermarket_sales] 
where Gender='Female'
group by [Product line]
order by Total DESC;

select [Product line],COUNT(*) as Total
from Project_totorial..['supermarket_sales] 
where Gender='Male'
group by [Product line]
order by Total DESC;

--Which product category generates the highest income?
select [Product line]
from Project_totorial..['supermarket_sales] 
where [gross income]=(select max([gross income]) 
					from Project_totorial..['supermarket_sales] );


