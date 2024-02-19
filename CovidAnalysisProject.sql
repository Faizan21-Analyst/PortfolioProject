SELECT * FROM `covid-project`.coviddeaths1;
-- select the data that we going to use
select location,date,total_cases,total_deaths,new_cases,population
from `covid-project`.coviddeaths1
where continent is not null
order by 1,2;



-- looking at total death vs total case
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
from `covid-project`.coviddeaths1
order by 1,2;


-- country wise checking 
select location,date,population,new_cases
from `covid-project`.coviddeaths1
where location like "%India%"
order by 1,2;


-- liklihood and rough but accurate percentage
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
from `covid-project`.coviddeaths1 where location like "%India%"
order by 1,2;

-- looking at population vs total cases

select location,date,population,total_cases (total_cases/population)*100 as Deathpercentage
from `covid-project`.coviddeaths1 where location like "%India%"
order by 1,2;

-- looking at which country have highest infaction rate compare to populatuion

select location,population,max(total_cases) as Highest_count, 
max((total_cases/population))*100 as infaction_rate from `covid-project`.coviddeaths1
 -- where location like "%India%"
group by location,population
order by 1,2 desc;

-- looking at highest death cases as per populaton

SELECT location,MAX(total_deaths ) AS HighestDeath_count
from `covid-project`.coviddeaths1
where continent is not null
GROUP BY 
    location
ORDER BY 
   HighestDeath_count DESC;
   
--  looking the continent having highest death count
SELECT continent,MAX(total_deaths ) AS HighestDeath_count
from `covid-project`.coviddeaths1
where continent is not null
GROUP BY 
    continent
ORDER BY 
   HighestDeath_count DESC;
   
-- Global number
select sum(new_cases) as total_cases,sum(new_deaths) as total_deaths,
sum(new_deaths)/sum(new_cases) as DeathPercentage
from `covid-project`.coviddeaths1
where continent is not null
order by DeathPercentage;

select * from `covid-project`.covidvacination2;

-- looking for total population vc new vacination
 
select dea.continent,dea.location ,dea.date,dea.population,vac.new_vaccinations from `covid-project`.coviddeaths1 dea
join `covid-project`.covidvacination2 vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3;


-- looking for how many people vacinated 
select dea.continent,dea.location ,dea.date,dea.population,vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location) as peopleVacinated
from `covid-project`.coviddeaths1 dea
join `covid-project`.covidvacination2 vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3;	

-- creating a view

create view prestoring as
select dea.continent,dea.location ,dea.date,dea.population,vac.new_vaccinations from `covid-project`.coviddeaths1 dea
join `covid-project`.covidvacination2 vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3;

