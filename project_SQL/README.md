# Introduction
In this project, we explore 2023's Data Analyst job postings in India to uncover insights such as:

- 💵Highest paying Data Analyst roles
- 🧠Skills required for the top paying jobs
- 📈Most in-demand skills for Data Analysts
- 💹Highest paying skills for Data Analysts
- 🖥️Optimal skills to learn for aspiring Data Analysts

The goal is to help job seekers identify valuable skills and trends in Indian data job market using real-world job data.
# Tools I Used
- **SQL :** To query the data efficiently
- **PostgreSQL :** Chosen Data Management system to main the job_postings data
- **Visual Studio Code :** One of my favourite code editor for writing and managing .sql files
- **Markdown :** For documenting my work in Readme.md file
- **Git & GitHub :** For version control and project sharing

# Analysis
Each query in this project is aimed at investingating definitive aspects for Data Analyst roles in India. Here is my approach:

### 1_Top_paying_Data_Analyst_roles
To identify the Highest-paying Data Analyst roles in India here's my approach:

- 🧹**Data Clean Up :** Removed repeated job postings from a same company by using combination of distinct values

- 🥅**Data Filtering :** focused on
>>- **1 -** Data Analyst role
>>- **2 -** Job postings from India
>>- **3 -** Job type 'Full-time'
>>- **4 -** salary less than 300k to exclude outliers

- 💻**Query Optimization with CTE & Join :** Used CTE for better readability and used LEFT JOIN to incorporate the company names into the CTE.

- 🔄️**SORTING :** Sorted the table in descending order based on the salary



```sql
WITH data_jobs AS (
    SELECT DISTINCT ON 
        (job_postings_fact.job_title,
        company_dim.name,
        job_postings_fact.salary_year_avg)

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
        salary_year_avg < 300000
)

SELECT *
FROM data_jobs
ORDER BY
    salary DESC
LIMIT
    25;
```

# Insight
Here are the insights from the Highest paying Data Analyst jobs in Inidan job market 2023:

- **Salary Range :** Data Analyst roles in India offer competitive salaries, ranging from $110K to $170K per year, making it a financially reliable career choice for aspiring analysts.

- **Top Hiring Company :** The Bosch Group had the highest number of job postings, positioning it as one of the top employers for Data Analyst roles in India.

- **Reliable Job Source :** AI-jobs.net emerged as a prominent and trustworthy platform for finding Data-related job opportunities.

- **Title & Employer Diversity :** There's a wide range of companies hiring under various job titles, highlighting India’s diverse and growing demand for Data Analyst professionals.

### 2_In_demand_skills

Analyzing the most in-demand skills for Data Aanlyst in India data market and here's my approach:
 - **🥅Filtering :** Based on
>>- **1 -** Data Analyst role
>>- **2 -** Job postings from India
>>- **3 -** Job type 'Full-time'

- **📼Joining Tables :** Used 'INNER JOIN' to combine the necessary tables to retrieve the skills data in relation to the job postings.
- **Aggregation :** Used aggregation function 'COUNT()' to count the total number of skills associated with the job postings.

- **💻Group by :** Grouped by skills column to get the individual skill count

- **➡️Order by :** Ordered the result table in descending order by skill_count

```sql
SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_postings_fact.job_country = 'India' AND
    job_postings_fact.job_schedule_type = 'Full-time'
GROUP BY
    skills
ORDER BY
    skill_count DESC
LIMIT 10;
```

# Insight
Here are the insights fro the most In-demand skills for Data Analyst in the Indian data market:

- **Top skills :**
For a Analyst in Indian data market the top most required skills are SQL, Python, Excel and tableau.

- **Technical skills focus :** Strong emphasis on SQL shows the importance of querying data in Analyst roles and Python indicates the need for automation, data wrangling and scripting skills.

### 3_high_paying_skills
Analyzing the highest paying skills in Indian data job market and here's my approach:

- **Filtering :** Based on
>>- **1 -** Data Analyst role
>>- **2 -** Job postings from India
>>- **3 -** Job type 'Full-time'
>>- **4 -** Salary is not null

- **Aggregation :** Used aggregation function 'AVG()' to find the average salary and 'ROUND()' function to remove the decimal values from the average salary.

- **Joining Tables :** Used 'INNER JOIN' to effectively join tables to retrieve the skills data in relation with the job postings table.

- **Group by :** Grouped by skills.

- **Sorting :** Sorted in descending order by average salary.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'India' AND
    job_schedule_type = 'Full-time' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;
```

# Insight
Here are the insights for high_paying_skills in Indian data job market:

- **1. Backend and Data Engineering Skills Dominate :**
Skills such as PostgreSQL, MySQL, PySpark, and Linux top the list with an average salary of $165,000, indicating that data analysts with knowledge in data infrastructure and engineering tools are highly valued.

### 4_optimal_skills
Aanlyzing the optimal skills for Data Aanlyst role in Indian data job market and here's my approach:

- **Filtering :** Based on
>>- **1 -** Data Analyst role
>>- **2 -** Job postings from India
>>- **3 -** Job type 'Full-time'
>>- **4 -** Salary is not null

- **Aggregation :** Used aggregation function 'AVG()' to find the average salary and 'ROUND()' and 'COUNT()' functions to find the skill_count and remove the decimal values from the average salary.

- **Joining Tables :** Used 'INNER JOIN' to effectively join tables to retrieve the skills data in relation with the job postings table.

- **Group by :** Grouped by skills.

- **Sorting :** Sorted in descending order by average salary.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,
    COUNT(job_postings_fact.job_id) AS skill_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'India' AND
    job_schedule_type = 'Full-time' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
HAVING
    COUNT(job_postings_fact.job_id) > 10
ORDER BY
    avg_salary DESC
LIMIT 10;
```

# Insight
Here are the insights on optimal skills for Data Analyst in Indian data job market:

- **optimal skills for high pay :** spark, Power Bi and Oracle are the most prominent high paying skills

- **Consistent paying skills :** Python, SQL and Excel offers a consistent job oppertunity with the salary range of $88,000 - $96,000.