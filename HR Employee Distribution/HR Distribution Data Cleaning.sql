-- Remove Duplicates
-- Standardize Data
-- Populate/Remove Null Or Blank Values
-- Remove Columns


-- Removing Duplicates

SELECT * 
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, 
location, industry, total_laid_off,
 percentage_laid_off, 'date', stage,
 country, funds_raised_millions) row_num
 FROM layoffs_staging;
 
 WITH duplicate_cte AS
 (
 SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, 
location, industry, total_laid_off,
 percentage_laid_off, 'date', stage,
 country, funds_raised_millions) row_num
 FROM layoffs_staging
 )
 SELECT *
 FROM duplicate_cte
 WHERE row_num > 1;
 
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 INSERT INTO layoffs_staging2
 SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, 
location, industry, total_laid_off,
 percentage_laid_off, 'date', stage,
 country, funds_raised_millions) row_num
 FROM layoffs_staging;
 
 SELECT *
FROM layoffs_staging2
WHERE row_num >1;

DELETE
FROM layoffs_staging2
WHERE row_num >1;
 
SELECT *
FROM layoffs_staging2;

-- Standardizing Data

SELECT DISTINCT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

SELECT *
FROM layoffs_staging2;

SELECT DISTINCT country
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

SELECT DISTINCT `date`
FROM layoffs_staging2;

SELECT DISTINCT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY `date` DATE;

-- Populating Data

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Airbnb%';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    WHERE t1.industry IS NULL OR t1.industry = ''
    AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
	SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- Removing Columns And Rows

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


