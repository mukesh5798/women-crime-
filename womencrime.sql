copy womencrime
from 'F:\python data analyst\crime against women\CrimesOnWomenData.csv'
delimiter ','
csv header

-- State	State
-- Year	Year
-- Rape	No. of Rape cases
-- K&A	Kidnap And Assault
-- DD	Dowry Deaths
-- AoW	Assault against women
-- AoM	Assault against modesty of women
-- DV	Domestic violence
-- WT	Women Trafficking
	

-- How would you write a SQL query to retrieve all records from the 'CrimesOnWomenData' table where the 'CrimeType' is 'Domestic Violence'?

	select sum(dv) as Domestic_Violence from womencrime

-- write a SQL query to calculate the total number of reported cases of each crime type across all cities?
	
	select lower(state) as lower_state,sum(rape)as Rape,
	sum(dd) as dowry_deaths,sum(DV) as domestic_violence,
	sum("K&A") as Kidnap_and_Assault,sum(wt) as women_trafficking,
	sum("AoM") as Assault_against_modesty_of_women,
	sum("AoW") as assault_against_women
	from womencrime group by lower_state 
	order by dowry_deaths desc;

-- write a SQL query to identify the top 10 cities with the highest number of reported cases of 'Sexual Harassment' in the year 2022?

	-- 1
	select lower(state) as lower_state,sum(rape)as Rape
	from womencrime where year = 2021 group  by lower_state 
	order by Rape desc limit 10;

	-- 2
	select lower(state) as lower_state,sum(DV)as domestic_violence
	from womencrime where year = 2021 group  by lower_state 
	order by domestic_violence desc limit 10;

	-- 3
	select lower(state) as lower_state, sum("AoM") as Assault_against_modesty_of_women from womencrime 
	group by lower_state order by Assault_against_modesty_of_women desc limit 10

	-- 4
	select lower(state) as lower_state,sum(wt) as women_trafficking from womencrime
	group by lower_state order by women_trafficking desc limit 10

	-- 5
	select lower(state) as lower_state, sum("AoW") as assault_against_women 
	from womencrime 
	group by lower_state order by assault_against_women desc limit 10

	-- 6
	select lower(state) as lower_state, 
	sum("K&A") as Kidnap_and_Assault from womencrime
	GROUP BY lower_state 
	order by Kidnap_and_Assault DESC limit 10;

	-- 7
	select lower(state) as lower_state,sum(dd) as dowry_deaths 
	from womencrime group by lower_state 
	order by dowry_deaths desc limit 10


-- Write a SQl Query to find in which year reported rape cases
	 
	select year,sum(rape) rape from womencrime 
		group by year order by rape desc limit 10

-- Write a SQl Query to find in which year reported Kidnap_and_Assault cases
	select year,sum("K&A") as Kidnap_and_Assault  from womencrime 
		group by year order by Kidnap_and_Assault desc limit 10

-- Write a SQl Query to find in which year reported assault_against_women cases

	select year, sum("AoW") as assault_against_women 
	from womencrime 
	group by year order by assault_against_women desc limit 10

-- Write a SQl Query to find in which year reported dowry_deaths cases

	select year,sum(dd) as dowry_deaths 
	from womencrime group by year 
	order by dowry_deaths desc limit 10

-- Write a SQl Query to find in which year reported dowry_deaths cases

	select year,sum(wt) as women_trafficking from womencrime
	group by year order by women_trafficking desc limit 10

-- Write a SQl Query to find in which year reported domestic_violence cases

	select year,sum(DV)as domestic_violence
	from womencrime group  by year 
	order by domestic_violence desc limit 10;
	

-- Write a SQL Query in which year highest rape in the state

with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM(rape) AS Rape,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM(rape) DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year)
select * from cte where rnk=1 order by rape desc limit 10

-- Write a SQL Query in which year highest Kidnap And Assault in the state

with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM("K&A") AS Kidnap_and_Assault,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM("K&A") DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year)
select * from cte where rnk=1 order by Kidnap_and_Assault desc limit 10

-- Write a SQL Query in which year highest dowry_deaths in the state
	
with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM(dd) AS dowry_deaths,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM(dd) DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year)
select * from cte where rnk = 1 order by dowry_deaths desc limit 10

-- Write a SQL Query in which year highest assault_against_women in the state

with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM("AoW") AS assault_against_women,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM("AoW") DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year)
select * from cte where rnk = 1 order by assault_against_women desc limit 10

-- Write a SQL Query in which year highest Assault_against_modesty_of_women in the state

with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM("AoM") AS Assault_against_modesty_of_women,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM("AoM") DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year)
select * from cte where rnk = 1 order by Assault_against_modesty_of_women desc limit 10

-- Write a SQL Query in which year highest Domestic violence in the state

with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM(DV) AS domestic_violence,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM(DV) DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year )
select * from cte where rnk = 1 order by domestic_violence desc limit 10

-- Write a SQL Query in which year highest women_trafficking in the state

with cte as (SELECT LOWER(state) AS lower_state,
       year,
       SUM(wt) AS women_trafficking,
       RANK() OVER (PARTITION BY LOWER(state) ORDER BY SUM(DV) DESC) AS rnk
FROM womencrime
GROUP BY LOWER(state), year
ORDER BY lower_state, year)
select * from cte where rnk = 1 order by women_trafficking desc limit 10
