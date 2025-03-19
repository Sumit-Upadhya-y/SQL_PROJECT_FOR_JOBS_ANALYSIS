select 
skills,
count(skills_job_dim.job_id) as demand_count
from job_postings_fact as top_jobs

inner join skills_job_dim on top_jobs.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

where job_title_short ='Data Analyst'
and job_work_from_home = false
group by skills
order by demand_count desc
limit 5

