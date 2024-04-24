SELECT TOP 10 *
FROM PortfolioProject..Y_2017;

SELECT TOP 11*--Entity--,[Oranges_Production_(tonnes)]
FROM PortfolioProject..Y_2017
--WHERE Code is not null
order by [Oranges_Production_(tonnes)] DESC;

DELETE FROM PortfolioProject..Y_2017
WHERE Code is NULL;
SELECT TOP 11*
FROM PortfolioProject..Y_2017
order by [Oranges_Production_(tonnes)] DESC;

--Orange production in the year 2018
SELECT TOP 10 *
FROM PortfolioProject..Y_2018;
DELETE FROM PortfolioProject..Y_2018
WHERE Code is NULL;
SELECT TOP 11*
FROM PortfolioProject..Y_2018
order by [Oranges | 00000490 || Production | 005510 || tonnes] DESC;
SELECT Entity,([Oranges | 00000490 || Production | 005510 || tonnes])/1000000 AS Max_Prod_2018
FROM PortfolioProject..Y_2018
--GROUP BY Entity
ORDER BY Max_Prod_2018 DESC;

SELECT MAX([Oranges | 00000490 || Production | 005510 || tonnes]) AS Max_Prod_2018
FROM PortfolioProject..Y_2018;

SELECT AVG([Oranges | 00000490 || Production | 005510 || tonnes]) AS AVG_Prod_2018
FROM PortfolioProject..Y_2018;

SELECT SUM([Oranges | 00000490 || Production | 005510 || tonnes]) AS SUM_Prod_2018
FROM PortfolioProject..Y_2018;
--Orange production in the year 2019
SELECT TOP 10 *
FROM PortfolioProject..Y_2019
ORDER BY [Oranges | 00000490 || Production | 005510 || tonnes] DESC;
DELETE FROM PortfolioProject..Y_2019
WHERE Code is NULL;
SELECT AVG([Oranges | 00000490 || Production | 005510 || tonnes]) AS AVG_Prod_2019
FROM PortfolioProject..Y_2019;
SELECT SUM([Oranges | 00000490 || Production | 005510 || tonnes]) AS SUM_Prod_2019
FROM PortfolioProject..Y_2019;

--Orange production in the year 2020
SELECT TOP 10 *
FROM PortfolioProject..Y_2020
ORDER BY [Oranges | 00000490 || Production | 005510 || tonnes] DESC;
DELETE FROM PortfolioProject..Y_2020
WHERE Code is NULL;
SELECT AVG([Oranges | 00000490 || Production | 005510 || tonnes]) AS AVG_Prod_2020
FROM PortfolioProject..Y_2020;
SELECT SUM([Oranges | 00000490 || Production | 005510 || tonnes]) AS SUM_Prod_2020
FROM PortfolioProject..Y_2020;

--Orange production in the year 2021
SELECT TOP 10 *
FROM PortfolioProject..Y_2021
ORDER BY [Oranges | 00000490 || Production | 005510 || tonnes] DESC;
DELETE FROM PortfolioProject..Y_2021
WHERE Code is NULL;
SELECT AVG([Oranges | 00000490 || Production | 005510 || tonnes]) AS AVG_Prod_2021
FROM PortfolioProject..Y_2021;
SELECT SUM([Oranges | 00000490 || Production | 005510 || tonnes]) AS SUM_Prod_2021
FROM PortfolioProject..Y_2021;

--Orange production in the year 2022
SELECT TOP 10 *
FROM PortfolioProject..Y_2022
ORDER BY [Oranges | 00000490 || Production | 005510 || tonnes] DESC;
DELETE FROM PortfolioProject..Y_2022
WHERE Code is NULL;
SELECT AVG([Oranges | 00000490 || Production | 005510 || tonnes]) AS AVG_Prod_2022
FROM PortfolioProject..Y_2022;
SELECT SUM([Oranges | 00000490 || Production | 005510 || tonnes]) AS SUM_Prod_2022
FROM PortfolioProject..Y_2022;

SELECT DISTINCT Entity
FROM PortfolioProject..Y_2022;
SELECT COUNT( Entity)
FROM PortfolioProject..Y_2019;

SELECT TOP 10*
FROM PortfolioProject..Y_2017
UNION 
SELECT TOP 10*
FROM PortfolioProject..Y_2018;

--Joining all Tables to compare production by year

DROP Table If Exists #temp_orange
CREATE TABLE #temp_orange(
 Year FLOAT,
 Entity VARCHAR(100),
 Country_Code VARCHAR(100),
 Orange_Prod FLOAT)
  
INSERT INTO #temp_orange
SELECT *
FROM PortfolioProject..Y_2017 Y1
UNION 
SELECT *
FROM PortfolioProject..Y_2018
UNION 
SELECT *
FROM PortfolioProject..Y_2019
UNION 
SELECT *
FROM PortfolioProject..Y_2020
UNION 
SELECT *
FROM PortfolioProject..Y_2021
UNION 
SELECT *
FROM PortfolioProject..Y_2022

SELECT * 
FROM #temp_orange

SELECT Entity,MAX(Orange_Prod) AS MAX_Pd
FROM #temp_orange
GROUP BY Entity
ORDER BY  MAX_Pd DESC;

SELECT Entity,Year,Orange_Prod
FROM #temp_orange
WHERE  Entity='Brazil'
ORDER BY  Orange_Prod DESC;

SELECT Entity,Year,Orange_Prod
FROM #temp_orange
WHERE  Entity='China'
ORDER BY  Orange_Prod DESC;

SELECT Entity,Year,Orange_Prod
FROM #temp_orange
WHERE  Entity='United States'
ORDER BY  Orange_Prod DESC;

SELECT Entity,Year,Orange_Prod
FROM #temp_orange
WHERE  Entity='Mexico'
ORDER BY  Orange_Prod DESC;

