select 
	job_title_short as title,
	job_location as location,
	job_posted_date as date
from 
	job_postings_fact
	limit 5;

select 
	job_title_short as title,
	job_location as location,
	job_posted_date::DATE as date
from 
	job_postings_fact
	limit 5;


select 
	job_title_short as title,
	job_location as location,
	job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date
from 
	job_postings_fact
	limit 5;

select 
	job_title_short as title,
	job_location as location,
	job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date,
	extract(month from job_posted_date) as Months,
	extract(Year from job_posted_date) as Years
from 
	job_postings_fact
	limit 5;

select * from job_postings_fact
where salary_year_avg is NOT NULL;


SELECT 
count(job_id) as jobs,
CASE 
WHEN salary_year_avg < 50000 then 'Low Salary'
WHEN salary_year_avg >= 50000 AND salary_year_avg < 80000 then 'Standard Salary'
ELSE 'High Salary'
END as salary_category
from job_postings_fact
where salary_year_avg is NOT NULL
GROUP BY salary_category
order by jobs DESC
;


SELECT *
FROM (
SELECT *
FROM job_postings_fact
WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) AS January_jobs;

WITH january_jobs AS(
SELECT *
FROM job_postings_fact
WHERE EXTRACT (MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;



with company_names AS(
select 
company_id,
count(job_title_short) as job_opening 
from job_postings_fact
group by company_id
order by company_id ASC
)
SELECT company_dim.company_id as ID, company_dim.name as Names, company_names.job_opening as Jobs
FROM company_names
left join company_dim
on company_names.company_id=company_dim.company_id
order by jobs DESC
;



--Identify the top 5 skills that are most frequently mentioned in job postings. 
--Use a subquery to find the skill IDs with the highest counts in the skills_job_dim 
--table and then join this result with the skills_dim table to get the skill names.

SELECT * FROM skills_job_dim
SELECT * FROM skills_dim

with skill_type as(
select 
	skill_id,
	count (*) as skill_counts
	from skills_job_dim
	group by skill_id
)
select skill_type.skill_id, skill_type.skill_counts, skills_dim.skills
from skill_type
Inner join skills_dim on skill_type.skill_id = skills_dim.skill_id
limit 5;



select*from job_postings_fact
select*from company_dim

select 
count(job_id) as job_counts,
case 
when count(job_title_short) < 1000 then 'Small Company'
when count(job_title_short) >= 1000 and count(job_title_short) <3000 then 'Medimum Company' 
else 'Large Company'
end as Company_category
from job_postings_fact
group by company_id
order by job_counts DESC
;

	
	
from job_postings_fact
group by company_id
order by job_counts DESC;


SELECT 
count(job_id) as jobs,
CASE 
WHEN salary_year_avg < 50000 then 'Low Salary'
WHEN salary_year_avg >= 50000 AND salary_year_avg < 80000 then 'Standard Salary'
ELSE 'High Salary'
END as salary_category
from job_postings_fact
where salary_year_avg is NOT NULL
GROUP BY salary_category
order by jobs DESC
;

Select * from job_postings_fact
Select * from skills_job_dim

Select * from skills_dim

with top_skills as (
	select 
	count(*) as Job_count,
	skills_job_dim.skill_id
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
where job_postings_fact.job_work_from_home = true and
job_postings_fact.job_title_short ='Data Analyst'
group by skills_job_dim.skill_id
)
select top_skills.skill_id,
	job_count,
	skills_dim.skills as name
	from top_skills
	inner join skills_dim on  skills_dim.skill_id = top_skills.skill_id
	order by job_count DESC
	limit 5;


select 
	job_title_short,
	salary_year_avg
from job_postings_fact
where salary_year_avg > 70000
order by salary_year_avg;

select 
quter_job_postings.job_title_short,
quter_job_postings.job_location,
quter_job_postings.job_via,
quter_job_postings.job_posted_date::DATE,
quter_job_postings.salary_year_avg
from
(
	select * from january_job_postings
	union all
	select * from february_job_postings
	union all
	select * from march_job_postings
) as quter_job_postings
where quter_job_postings.salary_year_avg > 70000 and
quter_job_postings.job_title_short ='Data Analyst'
order by quter_job_postings.salary_year_avg DESC



