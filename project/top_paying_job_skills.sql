	
with top_jobs as (Select 
		job_id,
		company_dim.name as Company_name,
		job_title,
		salary_year_avg
	from
		job_postings_fact
	left join company_dim on job_postings_fact.company_id = company_dim.company_id
	
	where job_title_short = 'Data Analyst' and job_location = 'Anywhere' and salary_year_avg is not null
	order by salary_year_avg DESC
	limit 10)
	
select 
	top_jobs.*, 
	skills

from top_jobs
inner join skills_job_dim on top_jobs.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order by salary_year_avg DESC
