
-- =========================================================
-- Project : Laptop Dataset Cleaning
-- Author  : Kedar Raju Pawar
-- Date    : 14-02-2026
-- Time    : 00:00:01

-- 🔁 Duplicate & Integrity Checks

-- 38. How would you detect duplicate laptop records?
-- I would group by the core descriptive columns that define a laptop configuration and look for groups with count > 1. That shows true business duplicates, not just repeated IDs.
SELECT
    Company,
    laptop_type,
    screen_size_inch,
    cpu,
    Ram,
    Memory,
    gpu,
    OpSys,
    price,
    COUNT(*) AS dup_count
FROM cleaned_laptop_data
GROUP BY
    Company, laptop_type, screen_size_inch,
    cpu, Ram, Memory, gpu, OpSys, price
HAVING COUNT(*) > 1
ORDER BY dup_count DESC;
-- 39. What column combination would you use as a uniqueness key?
-- I would use a composite business key based on hardware configuration — brand + CPU + RAM + storage + GPU + screen size — because together they define the product spec better than any single column.
-- Candidate Key Columns:
-- Company, screen_size_inch, cpu, ram_gb
-- total_storage_gb, gpu, display_resolution_width, display_resolution_height
SELECT COUNT(*) total_rows,
COUNT(DISTINCT CONCAT_WS('|',
    Company, screen_size_inch, cpu,
    ram_gb, total_storage_gb, gpu
)) distinct_configs
FROM cleaned_laptop_data;
-- 40. How would you keep the best record among duplicates instead of deleting blindly?

 -- Instead of deleting duplicates randomly, I would rank them and keep the most complete record — for example, the one with fewer NULL fields or 
 -- more parsed attributes populated.
 SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
             PARTITION BY Company, cpu, ram_gb, total_storage_gb
             ORDER BY
               (cpu_model IS NOT NULL) +
               (clock_speed_ghz IS NOT NULL) +
               (panel_type IS NOT NULL) DESC
           ) AS rn
    FROM cleaned_laptop_data
) t
WHERE rn = 1;
 
-- 🧪 Data Quality Flags (Advanced Analyst Move)

-- 41. How would you create a flag column for “suspect record” where:
-- high RAM
-- very low price
-- premium CPU
-- but budget cost
-- Create a rule-based flag where specs look premium but price is abnormally low. This helps detect scraping errors or unit mistakes.
ALTER TABLE cleaned_laptop_data
ADD COLUMN suspect_flag VARCHAR(3);

UPDATE cleaned_laptop_data
SET suspect_flag =
CASE
 WHEN ram_gb >= 32
  AND cpu_tier = 'High'
  AND price < 30000
 THEN 'Yes'
 ELSE 'No'
END;

select suspect_flag,count(*)
from cleaned_laptop_data
group by suspect_flag;
SELECT company,
       cpu,
       ram_gb,
       price,
       cpu_tier
FROM cleaned_laptop_data
WHERE suspect_flag = 'Yes';
-- 42. How would you create a “data_quality_score” column based on missing fields?
-- Score each row by counting how many important fields are populated. Higher score = better record quality.
ALTER TABLE cleaned_laptop_data
ADD COLUMN data_quality_score INT;

UPDATE cleaned_laptop_data
SET data_quality_score =
    (cpu_brand IS NOT NULL) * 2 +
    (cpu_model IS NOT NULL) * 2 +
    (ram_gb IS NOT NULL) * 3 +
    (total_storage_gb IS NOT NULL) * 2 +
    (gpu_brand IS NOT NULL) * 1 +
    (display_resolution_width IS NOT NULL) * 1 +
    (price IS NOT NULL) * 3;
    
select data_quality_score,count(*)
from cleaned_laptop_data
group by data_quality_score;
-- 42. How would you measure % completeness per column?
-- Measure completeness by calculating non-NULL percentage per column relative to total rows.

SELECT
  ROUND(100 * COUNT(ram_gb) / COUNT(*),2) AS ram_completeness_pct,
  ROUND(100 * COUNT(cpu_model) / COUNT(*),2) AS cpu_model_pct,
  ROUND(100 * COUNT(total_storage_gb) / COUNT(*),2) AS storage_pct
FROM cleaned_laptop_data;
-- 🏗️ Cleaning Architecture Questions (Interview Gold)

-- 43. When should cleaning be done in SQL vs Python?
-- SQL → structural cleaning, type casting, parsing columns, deduplication, joins, aggregations

-- Python → complex logic, fuzzy matching, NLP text normalization, ML-based anomaly detection, multi-step conditional parsing
-- Rule of thumb: If it’s set-based and deterministic → SQL. If it’s algorithmic → Python

-- 44. Why keep raw table and cleaned table separate?
-- preserves source truth, enables rollback , allows audit trails

-- supports reproducibility, prevents irreversible damage

-- Raw is evidence. Cleaned is interpretation. Never mix them.

-- 45. Why should derived columns never overwrite raw columns?
-- Because parsing rules evolve. If you overwrite raw text, you destroy the ability to re-derive with improved logic. 
-- Derived columns are versioned outputs — raw columns are permanent inputs.
UPDATE cleaned_laptop_data
SET cpu_generation = REGEXP_SUBSTR(cpu, 'i[3579]-([0-9]{4})', 1, 1, NULL, 1)
WHERE cpu_brand = 'Intel' AND cpu REGEXP 'i[3579]-';

-- 46. How would you make your cleaning steps reproducible?
-- store all cleaning SQL in scripts, run in ordered steps, use version control (Git), avoid manual edits
-- parameterize thresholds , document assumptions, validate with check queries
-- Reproducible cleaning = same input → same output every run. That’s professional analytics.


ALTER TABLE cleaned_laptop_data
ADD COLUMN data_quality_category VARCHAR(20);

UPDATE cleaned_laptop_data
SET data_quality_category =
CASE
    WHEN data_quality_score >= 14 THEN 'Excellent'
    WHEN data_quality_score >= 12 THEN 'Good'
    WHEN data_quality_score >= 9 THEN 'Average'
    ELSE 'Poor'
END;
select data_quality_category,count(*)
from cleaned_laptop_data
group by data_quality_category;
select * from cleaned_laptop_data;