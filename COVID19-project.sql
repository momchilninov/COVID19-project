/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/


--Select Data that we are going to be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths
ORDER BY 1,2

	
-- Looking at Total Deaths vs Total Cases
-- Shows likelihood of dying if you get COVID19 in your country 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathRate
FROM PortfolioProject.dbo.CovidDeaths
WHERE location IN ('Spain', 'Portugal')
AND continent IS NOT NULL
ORDER BY 1,2


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid19
SELECT location, date, population, total_cases, (total_cases/population)*100 AS InfectionRate
FROM PortfolioProject.dbo.CovidDeaths
WHERE location IN ('Spain', 'Portugal') 
AND continent IS NOT NULL
ORDER BY 1,2

	
-- Looking at countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, 
	MAX((total_cases/population))*100 AS InfectionRate
FROM PortfolioProject.dbo.CovidDeaths
GROUP BY location, population
ORDER BY 4 DESC


-- Showing coutries with highest Death Count per Population
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC


-- Let's break things down by Continent
-- Showing continents with the highest Death Count 
SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- GLOBAL NUMBERS 

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths,
SUM(new_deaths)/ SUM(new_cases))*100 AS DeathPercentage
FROM CovidDeaths
WHERE location IN ('Spain')
AND continent IS NOT NULL
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
		dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS dea
FULL OUTER JOIN CovidVaccinations AS vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location = 'Spain'
ORDER BY 2, 3


-- USE CTE to perform calculation on PartitionBy in previous query
WITH PopulationVsVaccination (Continent, Location, Date, Population, NewVaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
		dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS dea
FULL OUTER JOIN CovidVaccinations AS vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location = 'Spain'
--ORDER BY 2, 3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopulationVsVaccination


-- Using Temp Table to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(Continent NVARCHAR(255),
Location NVARCHAR(255),
Date datetime, 
Population numeric,
New_vaccinations numeric, 
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
		dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS dea
FULL OUTER JOIN CovidVaccinations AS vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location = 'Spain'
ORDER BY 2, 3

SELECT *, (RollingPeopleVaccinated/Population)*100 AS RollingPercentagePeopleVaccinated
FROM #PercentPopulationVaccinated


-- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS

CREATE VIEW PercentPopulationVaccinated AS 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
		dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS dea
FULL OUTER JOIN CovidVaccinations AS vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND dea.location = 'Spain'
--ORDER BY 2, 3
