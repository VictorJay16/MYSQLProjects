SELECT * 
FROM hr;

DESCRIBE hr;

CREATE TABLE `hr1` (
  `employee_id` text,
  `first_name` text,
  `last_name` text,
  `birth_date` date DEFAULT NULL,
  `gender` text,
  `race` text,
  `department` text,
  `job_title` text,
  `location` text,
  `hire_date` date DEFAULT NULL,
  `term_date` text,
  `location_city` text,
  `location_state` text,
  `age` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO hr1
SELECT *
FROM hr;

SELECT *
FROM hr1;


SELECT birthdate
FROM hr1;

UPDATE hr1
SET birth_date = CASE
	WHEN birth_date LIKE '%/%'
    THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN birth_date LIKE '%-%'
    THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr1
MODIFY birth_date DATE;

SELECT * 
FROM hr1;

UPDATE hr1
SET hire_date = CASE
	WHEN hire_date LIKE '%/%'
    THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN hire_date LIKE '%-%'
    THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr1
MODIFY hire_date DATE;

UPDATE hr1
SET term_date = DATE(STR_TO_DATE(term_date,'%Y-%m-%d %H:%i:%s UTC'))
WHERE term_date IS NOT NULL AND term_date != '';

UPDATE hr1
SET term_date = '0000-00-00'
WHERE term_date = '';

ALTER TABLE hr1
MODIFY COLUMN term_date DATE;


SELECT term_date
FROM hr1;


SELECT term_date
FROM hr1
GROUP BY 1
ORDER BY 1;

SELECT DISTINCT job_title, location, hire_date
FROM hr1
ORDER BY 1;

SELECT *
FROM hr1;

SELECT DISTINCT location_state
FROM hr1
WHERE term_date IS NOT NULL
ORDER BY 1;


UPDATE hr1
SET job_title = 'Data Coordinator'
WHERE job_title LIKE 'Data Coordiator%';

ALTER TABLE hr1
ADD COLUMN age INT;

-- Changing birthdate to age

UPDATE hr1
SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());

SELECT birth_date, age
FROM hr1
ORDER BY 1;

SELECT *
FROM hr1;


-- Portfolio Project



SELECT MIN(age) AS youngest, MAX(age) AS oldest
FROM hr1;

SELECT COUNT(*)
FROM hr1
WHERE age < 18;

SELECT DISTINCT(birthdate)
FROM hr1
GROUP BY birthdate
ORDER BY 1 ASC;

-- These are the distinct races each employee belong to

SELECT DISTINCT race
FROM hr1;

-- Looking at the age difference of all the employees

SELECT first_name, last_name, birth_date,
	CASE
    WHEN birth_date BETWEEN 1965-10-16 AND 2000-01-01 THEN 'Old'
    WHEN birth_date BETWEEN 2001-01-02 AND 2002-09-13  THEN 'Young'
    WHEN birth_date BETWEEN 2065-11-01 AND 2069-12-12 THEN 'Baby'
    ELSE 'OLD'
    END AS Age_Diff
    FROM hr1
    WHERE birth_date IS NOT NULL
    ORDER BY 3;
    
    -- Lookling at the number of Gender from the table

SELECT DISTINCT gender, COUNT(gender) AS Num_Of_Gender
FROM hr1
GROUP BY gender;

-- Looking at the demographics of HR Managers including their race, hire_date and location

SELECT employee_id, first_name, last_name, gender, race, job_title, location, hire_date, location_state
FROM hr1
WHERE job_title = 'HR Manager'
ORDER BY employee_id, hire_date;

-- Looking at the number of HR Managers

SELECT job_title, COUNT(job_title) AS HR_Managers_Count
FROM hr1
WHERE job_title = 'HR Manager';

-- Looking at HR Managers who works at the Headquarters and Remote

SELECT employee_id, first_name, last_name, gender, job_title, location
FROM hr1
WHERE job_title = 'HR Manager'
	AND location = 'Headquarters'
    ORDER BY employee_id;

SELECT employee_id, first_name, last_name, gender, job_title, location
FROM hr1
WHERE job_title = 'HR Manager'
	AND location = 'remote'
    ORDER BY employee_id;

SELECT *
FROM hr1;

-- Looking at the race of employees

SELECT employee_id, first_name, last_name, race
FROM hr1;

-- Employees who are Hispanic Or Latinos 

SELECT DISTINCT race
FROM hr1;

SELECT *
FROM hr1
WHERE race = 'Hispanic or Latino';

SELECT *
FROM hr1;






