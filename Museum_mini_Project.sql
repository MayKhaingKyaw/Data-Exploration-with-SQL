select top 10 * from PortfolioProject..museums 

--Which state has the museums with the highest average revenue? Highest expenses?

select [Museum Name],Max(Revenue) as Max_revenue
from PortfolioProject..museums 
Group by [Museum Name]
Order by Max_revenue DESC;

select [Museum Name],avg(Revenue) as avg_revenue
from PortfolioProject..museums 
Group by [Museum Name]
Order by avg_revenue DESC;
--"Total Expenses = Net Revenue - Net Income"

select top 10 (Revenue - Income) as Expense
from PortfolioProject..museums 
order by Expense DESC;

--How many museums belong to universities?

select [Museum Name], [Institution Name]
from PortfolioProject..museums 
where [Institution Name] is not null;

select count([Museum Name]),[Institution Name]
from PortfolioProject..museums 
where [Institution Name] like '%UNIVERSITY%'
group by [Institution Name];

select count([Museum Name])
from PortfolioProject..museums 
where [Institution Name] like '%UNIVERSITY%';

select count([Museum Name])
from PortfolioProject..museums 
where [Institution Name] like '%COLLEGE%';

--which regions possess the most museums per capita?

select top 10 * from PortfolioProject.[dbo].[State Populations];

select M.[State (Administrative Location)],State,Population_2018
from PortfolioProject..museums as M
join PortfolioProject.[dbo].[State Populations] as P
on M.[State (Administrative Location)]=P.[State (Administrative Location)]
group by M.[State (Administrative Location)]
--order by Population_2018 DESC

select M.[State (Administrative Location)], Count( M.[Museum Name]) as No_Museum,P.Population_2018
from PortfolioProject..museums as M
join PortfolioProject.[dbo].[State Populations] as P
on M.[State (Administrative Location)]=P.[State (Administrative Location)]
group by M.[State (Administrative Location)],P.Population_2018
order by No_Museum DESC;


select top 10 Population_2018 
from PortfolioProject.[dbo].[State Populations];

select distinct count( [City (Administrative Location)])
from PortfolioProject..museums ;