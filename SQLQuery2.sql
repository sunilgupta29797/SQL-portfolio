select *
from PortfolioProject..CovidDeaths
order by 3,4


--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

--selecting data that we are going to use

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

--Total cases vs Total deaths
--Shows likelihood of dying if you contract covid in India

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%India%'
order by 1,2

--Looking at Total cases vs Population
-- Percentage of people infected by covid

select location, date, total_cases, population, (total_cases/population)*100 as InfectPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
order by 1,2

--countries with highest infetion rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as InfectPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
group by location, population
order by InfectPercentage desc

--Countries with Highest Death Count per Population
--Continent is also displayed after casting datatype

select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
group by location
order by TotalDeathCount desc

--Grouping by continent
--Continents with HighestDeathCount
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
group by continent
order by TotalDeathCount desc

--Across the continent

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
group by date
order by 1,2

--overall including all the continents
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
--group by date
order by 1,2

--looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location) --order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
 join PortfolioProject..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

--Tableau visuals
--1

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
--group by date
order by 1,2


--2

select location, sum(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is null
and location not in ('World', 'European Union', 'International', 'High income','Upper middle income', 'lower middle income','low income')
group by location
order by TotalDeathCount desc

--3

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as InfectPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
group by location, population
order by InfectPercentage desc


--4

select location, population,date, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as InfectPercentage
from PortfolioProject..CovidDeaths
--where location like '%India%'
group by location, population, date
order by InfectPercentage desc













