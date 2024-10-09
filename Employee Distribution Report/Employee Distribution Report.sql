SELECT * FROM projects.employee_demographics;


ALTER TABLE employee_demographics
CHANGE COLUMN Experience_In_CurrentDomain Experience_In_Current_Domain varchar(50) NOT NULL;

-- 1. What is the distribution of educational qualifications among employees?
 
SELECT Education, COUNT(*) AS Qualification_Count
FROM employee_demographics
GROUP BY 1;

-- 2. How does the length of service (Joining Year) vary across different cities?

SELECT City, ROUND(AVG(YEAR(CURDATE()) - Joining_Year)) AS Avg_length_of_service
FROM employee_demographics
GROUP BY City
ORDER BY Avg_length_of_service;

-- 3. Is there a correlation between payment Tier and Experience in Current Domain?

SELECT Payment_Tier, ROUND(AVG(Experience_In_Current_Domain))  AS correlation_P_T
FROM employee_demographics
GROUP BY 1
ORDER BY 1 DESC;


-- 4. What is the gender distribution within the workforce?

SELECT gender, COUNT(*)
FROM employee_demographics
GROUP BY gender;

-- 5. Are there any patterns in leave-taking behavior among employees?

SELECT Leave_Or_Not, COUNT(*)
FROM employee_demographics
GROUP BY 1;

SELECT DISTINCT Education, Joining_Year, Age,Gender, COUNT(Gender) Gender_Count, Experience_In_Current_Domain, Leave_Or_Not
FROM employee_demographics
GROUP BY 1,2,3,4,6,7;

SELECT *
FROM employee_demographics

