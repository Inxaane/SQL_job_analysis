WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title AS title,
        job_location AS location,
        job_via AS source,
        company_dim.name AS company_name,
        job_schedule_type AS type,
        salary_year_avg AS salary
    FROM
        job_postings_fact
    INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_country = 'India' AND
        job_schedule_type = 'Full-time' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)

SELECT
    title,
    location,
    source,
    company_name,
    skills,
    top_paying_jobs.type,
    salary
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id