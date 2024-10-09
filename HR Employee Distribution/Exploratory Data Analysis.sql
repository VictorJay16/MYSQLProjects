SELECT * FROM human_resources.hr1;

-- 1. What is the gender breakdown of employees in the company?

SELECT gender, COUNT(*) AS count
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of the company?

SELECT race, COUNT(*) AS coubt
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY race
ORDER BY COUNT(*) DESC;

-- 3. What is the age distribution of the company?

SELECT MIN(age) AS youngest, MAX(age) AS oldest
FROM hr1
WHERE age >= 18 AND term_date IS NULL;

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender, COUNT(*) AS count
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY age_group, gender
ORDER BY age_group, gender;
        
-- 4. How many employees works at headquarters versus remote locations?

SELECT location, COUNT(*) AS count
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?

SELECT
ROUND(AVG(DATEDIFF(term_date, hire_date))/365,0) avg_length_employment
FROM hr1
WHERE term_date <= CURDATE() 
AND term_date IS NOT NULL 
AND age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department, gender, COUNT(*) AS count
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT job_title, COUNT(*) AS count
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY job_title
ORDER BY job_title DESC;

-- 8. Which departmen has the highest turnover?

SELECT department,
total_count,
terminated_count,
terminated_count/total_count AS termination_rate
FROM(
SELECT department,
COUNT(*) AS total_count,
SUM(CASE WHEN term_date IS NOT NULL 
AND term_date <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
FROM hr1
WHERE age >=18
GROUP BY department
) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state, COUNT(*) AS count
FROM hr1
WHERE age >= 18 AND term_date IS NULL
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT
year,
hires,
terminations,
hires-terminations AS net_change,
ROUND((hires-terminations)/hires * 100,2) AS net_change_percent
FROM(
	SELECT YEAR(hire_date) AS year,
    COUNT(*) AS hires,
    SUM(CASE WHEN term_date IS NOT NULL 
    AND term_date <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM hr1
    WHERE age >=18
    GROUP BY YEAR(hire_date)
    ) AS subquery
    ORDER BY year ASC;
    
    -- 11. What is the tenure distribution for each department?
    
    SELECT department, ROUND(AVG(DATEDIFF(term_date,hire_date)/365),0) AS avg_tenure
    FROM hr1
    WHERE term_date <= CURDATE() AND term_date IS NOT NULL AND age >= 18
    GROUP BY department;
