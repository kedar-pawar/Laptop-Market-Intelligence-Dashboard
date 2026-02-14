-- =========================================================
-- Project : Laptop Dataset Cleaning
-- Author  : Kedar Raju Pawar
-- Date    : 13-02-2026
-- Time    : 23:15:23


-- Memory & RAM — Data Cleaning Questions (Text Answers Only)
-- Q27. RAM values are stored as text like “8GB” or “16 GB”. How would you make them usable for analysis?
-- RAM is stored as text with units, which prevents numeric analysis. I would extract the numeric portion and store it in a new numeric column (like ram_gb).
--  This allows aggregation, filtering, and statistical calculations.
show databases;
use laptop_analysis;
desc cleaned_laptop_data;
ALTER TABLE cleaned_laptop_data ADD COLUMN ram_gb TINYINT UNSIGNED;

UPDATE cleaned_laptop_data
SET ram_gb = CAST(REGEXP_REPLACE(TRIM(Ram), '[^0-9]+', '') AS UNSIGNED);

SELECT 
    ram_gb, COUNT(*) AS cnt,
    GROUP_CONCAT(DISTINCT Ram) AS examples
FROM cleaned_laptop_data
GROUP BY ram_gb
ORDER BY ram_gb;


-- Q28. RAM entries may use inconsistent formats (like GB, Gb, gb, spaces). How would you standardize them?
-- I would normalize the text by trimming spaces and converting to a consistent case, then extract the number using a regex. 
-- Since all variants represent gigabytes, unit text can be ignored after numeric extraction.
-- Normalize RAM text first
UPDATE cleaned_laptop_data
SET Ram = UPPER(TRIM(Ram));

-- Remove internal spaces like "16 GB"
UPDATE cleaned_laptop_data
SET Ram = REPLACE(Ram, ' ', '');

-- Re-extract safely
UPDATE cleaned_laptop_data
SET ram_gb =
    CAST(REGEXP_SUBSTR(Ram, '[0-9]+') AS UNSIGNED);

-- Q29. Storage (memory) fields often contain multiple drives like “256GB SSD + 1TB HDD”. How would you clean this?
-- Storage fields may contain multiple drives and types in one string. I would parse each component using pattern extraction, 
-- convert capacities into a standard unit, and create structured columns like ssd_gb and hdd_gb.

ALTER TABLE cleaned_laptop_data
ADD COLUMN ssd_gb INT DEFAULT 0,
ADD COLUMN hdd_gb INT DEFAULT 0,
ADD COLUMN flash_gb INT DEFAULT 0,
ADD COLUMN hybrid_gb INT DEFAULT 0,
ADD COLUMN total_storage_gb INT;


    
-- show suspicious parses
SELECT Memory, ssd_gb, hdd_gb, flash_gb, hybrid_gb, total_storage_gb
FROM cleaned_laptop_data
WHERE total_storage_gb = 0;



-- Q30. Storage sizes may appear in both GB and TB. How would you make them comparable?
-- TB conversion check
-- All storage sizes should be converted to a single base unit (GB). TB values are multiplied by 1024 so totals and comparisons are consistent.
UPDATE cleaned_laptop_data
SET ssd_gb =
CASE
 WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'SSD'
 THEN
   CASE
     WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'TB'
     THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9.]+') AS DECIMAL(6,2)) * 1024
     ELSE CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+') AS UNSIGNED)
   END
 ELSE ssd_gb
END;

UPDATE cleaned_laptop_data
SET hdd_gb =
CASE
 WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'HDD'
 THEN
   CASE
     WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'TB'
     THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9.]+') AS DECIMAL(6,2)) * 1024
     ELSE CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+') AS UNSIGNED)
   END
 ELSE hdd_gb
END;

UPDATE cleaned_laptop_data
SET flash_gb =
CASE
 WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'FLASH'
 THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+') AS UNSIGNED)
 ELSE flash_gb
END;


UPDATE cleaned_laptop_data
SET hybrid_gb =
CASE
 WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'HYBRID'
 THEN
   CASE
     WHEN SUBSTRING_INDEX(Memory,'+',1) REGEXP 'TB'
     THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9.]+') AS DECIMAL(6,2)) * 1024
     ELSE CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+') AS UNSIGNED)
   END
 ELSE hybrid_gb
END;

UPDATE cleaned_laptop_data
SET ssd_gb = ssd_gb +
CASE
 WHEN Memory REGEXP '\\+.*SSD'
 THEN
   CASE
     WHEN SUBSTRING_INDEX(Memory,'+',-1) REGEXP 'TB'
     THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9.]+') AS DECIMAL(6,2)) * 1024
     ELSE CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') AS UNSIGNED)
   END
 ELSE 0
END;


UPDATE cleaned_laptop_data
SET hdd_gb = hdd_gb +
CASE
 WHEN Memory REGEXP '\\+.*HDD'
 THEN
   CASE
     WHEN SUBSTRING_INDEX(Memory,'+',-1) REGEXP 'TB'
     THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9.]+') AS DECIMAL(6,2)) * 1024
     ELSE CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') AS UNSIGNED)
   END
 ELSE 0
END;


UPDATE cleaned_laptop_data
SET flash_gb = flash_gb +
CASE
 WHEN Memory REGEXP '\\+.*FLASH'
 THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') AS UNSIGNED)
 ELSE 0
END;


UPDATE cleaned_laptop_data
SET hybrid_gb = hybrid_gb +
CASE
 WHEN Memory REGEXP '\\+.*HYBRID'
 THEN
   CASE
     WHEN SUBSTRING_INDEX(Memory,'+',-1) REGEXP 'TB'
     THEN CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9.]+') AS DECIMAL(6,2)) * 1024
     ELSE CAST(REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') AS UNSIGNED)
   END
 ELSE 0
END;

SELECT Memory, total_storage_gb
FROM cleaned_laptop_data
WHERE Memory REGEXP 'TB';
-- Convert all storage values to a single unit (usually GB). For example, convert TB to GB using a consistent multiplier, so totals and comparisons are accurate across all records.

-- Q31. How would you calculate total storage when multiple drives are listed?
-- After extracting each drive capacity into numeric columns, I would sum them into a derived total_storage_gb column for reporting and modeling.
UPDATE cleaned_laptop_data
SET total_storage_gb =
    COALESCE(ssd_gb,0) +
    COALESCE(hdd_gb,0) +
    COALESCE(flash_gb,0);

-- validation
SELECT Memory, ssd_gb, hdd_gb, total_storage_gb
FROM cleaned_laptop_data;

-- Extract each storage component, convert them to the same unit, and sum them into a derived total storage column. This creates a single numeric feature for reporting and modeling.

-- Q32. Why is it better to split RAM and storage into numeric columns instead of keeping them as text?

-- Keeping RAM and storage as text blocks analysis. Numeric columns allow: sorting, filtering, aggregation, and statistical analysis. Text fields prevent correct numeric comparison and make reporting, grouping, and modeling less reliable.

-- Weight — STD Level Questions (With Simple SQL)
-- ✅ Q33 — Weight is stored as text like “1.25kg”. How would you make it usable for analysis?

-- Answer (simple):
-- Extract the numeric part and store it in a new numeric column (weight_kg) so we can calculate averages and comparisons.

ALTER TABLE cleaned_laptop_data
ADD COLUMN weight_kg DECIMAL(4,2);

UPDATE cleaned_laptop_data
SET weight_kg =
  CAST(
    TRIM(
      REPLACE(LOWER(weight), 'kg', '')
    ) AS DECIMAL(5,2)
  );

select weight_kg, count(*)
from cleaned_laptop_data
group by weight_kg;
-- ✅ Q34 — Some weight values may contain spaces like “1.5 kg”. How would you standardize them?

-- Answer (simple):
-- Remove spaces and normalize format before extracting numbers.

UPDATE cleaned_laptop_data
SET Weight = LOWER(TRIM(Weight));

UPDATE cleaned_laptop_data
SET Weight = REPLACE(Weight,' ','');
-- ✅ Q35 — How would you find invalid or suspicious weight values?

-- Answer (simple):
-- Filter rows where parsed weight is too low or too high for a laptop.

-- (India consumer laptop range ≈ 0.8 kg – 5 kg)

SELECT Company, laptop_type, Weight, weight_kg
FROM cleaned_laptop_data
WHERE weight_kg < 0.8
   OR weight_kg > 5;
-- ✅ Q36 — How would you create weight categories (Light / Medium / Heavy)?

-- Answer (simple):
-- Create a derived category column using a CASE rule.

ALTER TABLE cleaned_laptop_data
ADD COLUMN weight_class VARCHAR(10);

UPDATE cleaned_laptop_data
SET weight_class =
CASE
 WHEN weight_kg < 1.3 THEN 'Light'
 WHEN weight_kg < 2.2 THEN 'Medium'
 ELSE 'Heavy'
END;
-- ✅ Q37 — How would you check average laptop weight by type?

-- Answer (simple):
-- Group by laptop type and calculate average numeric weight.

SELECT
  laptop_type,
  ROUND(AVG(weight_kg),2) AS avg_weight
FROM cleaned_laptop_data
GROUP BY laptop_type
ORDER BY avg_weight;