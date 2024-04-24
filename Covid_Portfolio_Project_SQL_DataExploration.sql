SELECT *
FROM Portfolioproject..CovidDeaths
ORDER By 3,4

--SELECT *
--FROM Portfolioproject..CovidVaccinations
--ORDER By 3,4
--Select data that we are going to be using

SELECT location,date,total_cases, new_cases,total_deaths,population
FROM Portfolioproject..CovidDeaths
ORDER By 1,2

-- looking at total cases vs total deaths
-- Show likelihood of dying if you contract covid in your country

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM Portfolioproject..CovidDeaths
WHERE location LIKE '%Myanmar%'
ORDER By 1,2;

-- looking tootal cases vs population
-- Show waht percentage of population got Covid

SELECT location,date,population,total_cases,(total_cases/population)*100 AS Percentpopulationinfected
FROM Portfolioproject..CovidDeaths
-- WHERE location LIKE '%Myanmar%'
ORDER By 1,2

-- looking at countries with highest infection rate compared to population

SELECT location,population,MAX(total_cases) AS HighestinfectionCount,MAX((total_cases/population))*100 AS Percentpopulationinfected
FROM Portfolioproject..CovidDeaths
-- WHERE location LIKE '%Myanmar%'
GROUP By location,population
ORDER By Percentpopulationinfected DESC

--Showing countries with highest death count per population

SELECT location,MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM Portfolioproject..CovidDeaths
-- WHERE location LIKE '%Myanmar%'
WHERE continent is NOT NULL
GROUP By location
ORDER By TotalDeathCount DESC

-- Lets break things down by continent

SELECT continent,MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM Portfolioproject..CovidDeaths
-- WHERE location LIKE '%Myanmar%'
WHERE continent is NOT NULL
GROUP By continent
ORDER By TotalDeathCount DESC

--Showing continents with the highest death count per population

SELECT continent,MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM Portfolioproject..CovidDeaths
-- WHERE location LIKE '%Myanmar%'
WHERE continent is NOT NULL
GROUP By continent
ORDER By TotalDeathCount DESC

--Global Numbers

SELECT SUM(new_cases) AS total_cases,SUM(cast(new_deaths as int)) AS total_deaths, (SUM(cast(new_deaths as int))/SUM(new_cases))*100 AS deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is NOT NULL
--GROUP BY date
ORDER BY 1,2


SELECT * 
FROM PortfolioProject..CovidVaccinations

--Looking at Totalvaccination vs Population

SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS Rollingpeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is NOT NULL
ORDER BY 2,3

--Using CTE

WITH PopvsVac (continent,location,date,population,new_vaccinations,Rollingpeoplevaccinated)
AS (
SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS Rollingpeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is NOT NULL
)
SELECT *, (Rollingpeoplevaccinated/population)*100
FROM PopvsVac

-- TEMP Table
DROP TABLE IF EXISTS #Percentpopulationvaccinated
CREATE TABLE #Percentpopulationvaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
Rollingpeoplevaccinated numeric
)
INSERT INTO #Percentpopulationvaccinated
SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS Rollingpeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
--WHERE dea.continent is NOT NULL
--ORDER BY 2,3
SELECT *, (Rollingpeoplevaccinated/population)*100
FROM #Percentpopulationvaccinated


--Creating View to store data for later Visualzation

CREATE VIEW Percentpopulationvaccinated AS
SELECT dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS Rollingpeoplevaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is NOT NULL
--ORDER BY 2,3

SELECT *
FROM Percentpopulationvaccinated