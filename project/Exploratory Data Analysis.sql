-- Exploratory Data Analysis

select *
from layoffs_staging6;

select *
from layoffs_staging6
where company='amazon';

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging6;

select *
from layoffs_staging6
where percentage_laid_off=1
order by total_laid_off desc;


select *
from layoffs_staging6
where percentage_laid_off=1
order by funds_raised_millions desc;

select *
from layoffs_staging6
where company='amazon';

# SUM(total_laid_off) → Adds up all layoffs for each company.
# GROUP BY company → Ensures layoffs are summed per company.
# ORDER BY 2 DESC → Sorts results from highest to lowest layoffs.

select company, sum(total_laid_off)
from layoffs_staging6
group by company
order by 2 desc;

select min(date),max(date)
from layoffs_staging6;

select industry, sum(total_laid_off)
from layoffs_staging6
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging6
group by country
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging6
where country= 'germany';

select country, sum(total_laid_off)
from layoffs_staging6
group by country
order by 2 desc;

select year(date), sum(total_laid_off)
from layoffs_staging6
group by year(date)
order by 1 desc;


select stage, sum(total_laid_off)
from layoffs_staging6
group by stage
order by 2 desc;

# SUBSTRING(date,6,2) → Extracts the month from the date column (assuming date is in YYYY-MM-DD format).
# It starts from position 6 (which is the month) and takes 2 characters.
# Example: "2024-03-15" → "03" (March).
#SUM(total_laid_off) → Calculates total layoffs for each month.
# GROUP BY Month → Groups layoffs by month so the sum is calculated for each month separately.

select substring(date,6,2) as 'Month', SUM(total_laid_off)
from layoffs_staging6
group by MONTH;

select substring(date,1,7) as 'Month', SUM(total_laid_off)
from layoffs_staging6
Where substring(date,1,7) is not null
group by substring(date,1,7)
order by 1 ASC;
 
 # Finds layoffs per month.
#Calculates the cumulative (rolling) total of layoffs over time.

 WITH Rolling_total as
 (
 select substring(date,1,7) as 'Month', SUM(total_laid_off) AS TOTAL_OFF
from layoffs_staging6
Where substring(date,1,7) is not null
group by Month
order by 1 ASC
)
select Month,TOTAL_OFF
 ,sum(total_off) over(order by Month) as rolling_total
from Rolling_total;


# LAG(TOTAL_OFF) OVER(ORDER BY Month) → Gets the previous month’s value.
# TOTAL_OFF - LAG(TOTAL_OFF) OVER(ORDER BY Month) → Finds the difference from the previous

WITH Rolling_total AS  
(  
    SELECT SUBSTRING(date,1,7) AS 'Month',  
           SUM(total_laid_off) AS TOTAL_OFF  
    FROM layoffs_staging6  
    WHERE SUBSTRING(date,1,7) IS NOT NULL  
    GROUP BY Month  
    ORDER BY 1 ASC  
)  
SELECT Month,  
       TOTAL_OFF,  
       SUM(TOTAL_OFF) OVER(ORDER BY Month) AS rolling_total,  
       TOTAL_OFF - LAG(TOTAL_OFF) OVER(ORDER BY Month) AS monthly_change  
FROM Rolling_total;



#YEAR(date) → Gets the year from the date column.
#SUM(total_laid_off) → Adds up all layoffs for each company in each year.
#GROUP BY company, YEAR(date) → Groups data by company and year.
#ORDER BY 3 DESC → Sorts results by layoffs (highest first).
#Shows how many people each company laid off per year, sorted from most to least

Select company, year(date), sum(total_laid_off)
from layoffs_staging6
group by company, year(date)
order by 3 desc;




with company_year (company,year, total_laid_off)as
(
select company, year(date), sum(total_laid_off)
from layoffs_staging6
group by company, year(date)
), company_year_rank as 
(select *,
 dense_rank() over (partition by year order by total_laid_off desc) as Ranking
from company_year
where year is not null
)
select *
from company_year_rank
where ranking <=5;