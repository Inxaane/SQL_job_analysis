SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,
    COUNT(job_postings_fact.job_id) AS count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    salary_year_avg <= 200000 AND
    job_work_from_home = TRUE
GROUP BY
    skills
HAVING
    COUNT(job_postings_fact.job_id) > 25
ORDER BY
    avg_salary DESC
LIMIT 10;