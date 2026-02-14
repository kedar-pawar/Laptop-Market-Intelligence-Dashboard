-- =========================================================
-- Project : Laptop Dataset Cleaning
-- Author  : Kedar Raju Pawar
-- Date    : 13-02-2026
-- Time    : 22:43:43


show databases;
use laptop_analysis;
desc cleaned_laptop_data;
-- 💰 Price Checks — Plain Business Style

-- 20. Before using the product prices in reports, what quick checks would you do to make sure the values make sense?
-- > Check for NULL, zero, or negative prices, check minimum and maximum values, look at average and median prices. 
-- And standardize numeric precision (rounding). Also scan for obvious data-entry errors or unrealistic extremes.


-- ---------------------------------------------------------
-- Q21. Detect price outliers using IQR method
-- ---------------------------------------------------------

-- Use statistical thresholds such as say ± 2 standard deviations or IQR ranges to spot price outliers.
--  These queries flag products that are significantly higher or lower than the typical price distribution.

SELECT count( *)
FROM cleaned_laptop_data
WHERE price > (SELECT AVG(price) + 2*STDDEV(price) FROM cleaned_laptop_data)
   OR price < (SELECT AVG(price) - 2*STDDEV(price) FROM cleaned_laptop_data);
   
SELECT company, laptop_type, price
FROM cleaned_laptop_data
WHERE price > (SELECT AVG(price) + 2*STDDEV(price) FROM cleaned_laptop_data)
   OR price < (SELECT AVG(price) - 2*STDDEV(price) FROM cleaned_laptop_data)
ORDER BY price;
ALTER TABLE cleaned_laptop_data
ADD COLUMN is_price_outlier VARCHAR(3);
UPDATE cleaned_laptop_data
JOIN (
    SELECT 
        AVG(price) AS avg_p,
        STDDEV(price) AS std_p
    FROM cleaned_laptop_data
) stats
SET is_price_outlier =
    CASE
        WHEN price > avg_p + 2*std_p
          OR price < avg_p - 2*std_p
        THEN 'Yes'
        ELSE 'No'
    END;
select is_price_outlier, count(*)
from cleaned_laptop_data
group by is_price_outlier;

-- 22. If you find items listed with zero or negative price, how should those records be handled?
-- checking negative values
SELECT *
FROM cleaned_laptop_data
WHERE price <= 0; -- > exist none
-- Zero or negative prices are invalid for sales analysis. They should be investigated and either corrected, put to NULL,
--  or removed from the dataset to prevent misleading results.
-- 23. How would you group prices into ranges (like budget, mid-range, premium) so they’re easier to analyze in reports?


SELECT
    price,
    CASE
        WHEN price < 40000 THEN 'Budget'
        WHEN price BETWEEN 40000 AND 80000 THEN 'Mid-Range'
        WHEN price > 80000 THEN 'Premium'
        ELSE 'Not Specified'
    END AS price_band
FROM cleaned_laptop_data;

ALTER TABLE cleaned_laptop_data
ADD COLUMN price_band VARCHAR(20);

UPDATE cleaned_laptop_data
SET price_band =
    CASE
        WHEN price < 40000 THEN 'Budget'
        WHEN price <= 80000 THEN 'Mid-Range'
        ELSE 'Premium'
    END;
-- Make price bands using defined thresholds and assign each product to a category such as Budget, Mid-Change, or Premium. 
-- This creates a categorical feature that simplifies aggregation and reporting.
-- 🏷️ Name Cleanup — Simple Data Consistency Style

-- Q24. Brand names are written in multiple ways. How do you
-- standardize them?
-- Answer:
-- Normalize casing and spacing first, then map known spelling variations to a single standard brand name using rule-based replacement. 
-- Say a controlled reference list for brand labels.

UPDATE cleaned_laptop_data
SET company = UPPER(TRIM(company));

UPDATE cleaned_laptop_data
SET company = 'HP'
WHERE company IN ('Hewlett Packard','Hp','hp');



-- =========================================================
-- Q25. Operating system names appear in multiple formats.
-- How do you standardize them?
-- Answer:
-- Group similar OS name variants using pattern matching and map them into standardized labels 
-- (for example, all Windows variants → “Windows”, Ubuntu/Linux variants → “Linux”). This creates consistent categorical values.
-- =========================================================

UPDATE cleaned_laptop_data
SET opsys =
    CASE
        WHEN opsys REGEXP 'windows' THEN 'Windows'
        WHEN opsys REGEXP 'mac' THEN 'macOS'
        WHEN opsys REGEXP 'linux|ubuntu' THEN 'Linux'
        WHEN opsys REGEXP 'chrome' THEN 'Chrome OS'
        ELSE 'Not Specified'
    END;




-- =========================================================
-- Q26. Text fields may contain leading/trailing spaces.
-- How do you clean them across columns?
-- Answer:
-- Apply TRIM() to all text columns to remove invisible
-- leading and trailing whitespace for consistency.
-- =========================================================

UPDATE cleaned_laptop_data
SET
    company = TRIM(company),
    laptop_type = TRIM(laptop_type),
    cpu = TRIM(cpu),
    gpu = TRIM(gpu),
    opsys = TRIM(opsys),
    memory = TRIM(memory),
    ram = TRIM(ram),
    panel_type = TRIM(panel_type);

-- Apply whitespace trimming to all text columns to take away leading and trailing spaces.
--  This prevents duplicate-looking values and improves grouping and matching accuracy..