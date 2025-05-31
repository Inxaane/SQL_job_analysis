SELECT
    job_title AS title,
    job_location AS location,
    job_via,
    company_dim.name AS company_name,
    job_schedule_type AS type,
    salary_year_avg AS salary
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'India' AND
    job_schedule_type = 'Full-time' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;