-- ==========================================================
-- Project : Laptop Dataset Cleaning
-- Author  : Kedar Raju Pawar
-- Date    : 13-02-2026
-- Time    : 15:38
--
-- What this script does:
-- I’m creating a safe working copy of the raw laptop dataset
-- and starting the first round of cleanup. Nothing fancy yet —
-- just structural fixes so later analysis becomes easier.
--
-- Plan here:
--   • Copy the raw table so the original stays untouched
--   • Rename confusing column names
--   • Remove junk / unknown columns
--   • Prepare new columns for parsed values
--   • Split resolution into usable numeric parts
-- ==========================================================


-- =========================================================
-- STEP 1 — Make a Working Copy
-- I never clean directly on raw data. One mistake and it’s gone.
-- So this creates a duplicate table to experiment safely.
-- =========================================================

SHOW DATABASES;
USE laptop_analysis;

DESC laptop_data;

CREATE TABLE cleaned_laptop_data AS
SELECT *
FROM laptop_data;



-- =========================================================
-- STEP 2 — Quick Structure Check
-- Just confirming columns and datatypes before changing anything.
-- =========================================================

DESC cleaned_laptop_data;



-- =========================================================
-- STEP 3 — Rename Columns
-- Some original names are awkward for querying.
-- Renaming them to something cleaner and easier to read.
-- =========================================================

ALTER TABLE cleaned_laptop_data
CHANGE COLUMN TypeName laptop_type TEXT,
CHANGE COLUMN Inches screen_size_inch DOUBLE,
CHANGE COLUMN ScreenResolution display_resolution TEXT;



-- =========================================================
-- STEP 4 — Drop Useless Columns
-- This column looks system-generated and has no analytical value.
-- Removing it to keep the table clean.
-- =========================================================

-- ALTER TABLE cleaned_laptop_data
-- DROP COLUMN IF EXISTS MyUnknownColumn;



-- =========================================================
-- STEP 5 — Add New Columns for Parsed Values
-- > as in dataset the resolution, paneltype and touchscreen are bombarded in one column so to separate it 
-- we create new columns
-- =========================================================

ALTER TABLE cleaned_laptop_data
ADD COLUMN display_resolution_width  INT,
ADD COLUMN display_resolution_height INT,
ADD COLUMN panel_type                VARCHAR(50),
ADD COLUMN is_touchscreen            VARCHAR(3),
ADD COLUMN resolution_class          VARCHAR(15);



-- ---------------------------------------------------------
-- Extract resolution width
-- ---------------------------------------------------------

UPDATE cleaned_laptop_data
SET display_resolution_width =
    CAST(
        SUBSTRING_INDEX(
            REGEXP_SUBSTR(display_resolution,'[0-9]+x[0-9]+',1,1),
            'x',1
        ) AS UNSIGNED
    )
WHERE display_resolution REGEXP '[0-9]+x[0-9]+';



-- ---------------------------------------------------------
-- Extract resolution height
-- ---------------------------------------------------------

UPDATE cleaned_laptop_data
SET display_resolution_height =
    CAST(
        SUBSTRING_INDEX(
            REGEXP_SUBSTR(display_resolution,'[0-9]+x[0-9]+',1,1),
            'x',-1
        ) AS UNSIGNED
    )
WHERE display_resolution REGEXP '[0-9]+x[0-9]+';


SELECT *
FROM cleaned_laptop_data
WHERE display_resolution REGEXP '[0-9]+x[0-9]+'
AND (display_resolution_width IS NULL
     OR display_resolution_height IS NULL);

-- ---------------------------------------------------------
-- Extract panel type
-- ---------------------------------------------------------
SELECT cpu, cpu_model
FROM cleaned_laptop_data
WHERE cpu_model = 'Not Specified'
AND cpu REGEXP 'Ryzen|Core|Atom|Celeron'
LIMIT 20;
UPDATE cleaned_laptop_data
SET cpu_model =
    CASE

        -- Standard Intel/AMD SKU patterns (7200U, 8250U, 7700HQ, N3350)
        WHEN cpu REGEXP '[0-9]{4,5}[A-Z]{0,2}'
        THEN REGEXP_SUBSTR(cpu, '[0-9]{4,5}[A-Z]{0,2}')

        -- Core M / m3 style chips
        WHEN cpu REGEXP 'm3|m5|m7|Core M'
        THEN REGEXP_SUBSTR(cpu, 'm3|m5|m7')

        -- Fallback when nothing structured found
        ELSE 'No Dedicated SKU'
    END;
-- 🔍 VALIDATION — see what didn’t match
SELECT cpu, cpu_model
FROM cleaned_laptop_data
WHERE cpu_model IN ('No Dedicated SKU')
LIMIT 20;

-- ---------------------------------------------------------
-- Detect touchscreen flag
-- ---------------------------------------------------------

UPDATE cleaned_laptop_data
SET is_touchscreen =
    CASE
        WHEN REGEXP_LIKE(display_resolution,'touch','i')
        THEN 'Yes'
        ELSE 'No'
    END;



-- ---------------------------------------------------------
-- Resolution class buckets
-- ---------------------------------------------------------

UPDATE cleaned_laptop_data
SET resolution_class =
    CASE
        WHEN display_resolution REGEXP '1366x768'  THEN 'HD'
        WHEN display_resolution REGEXP '1920x1080' THEN 'Full HD'
        WHEN display_resolution REGEXP '2560x1440' THEN 'Quad HD'
        WHEN display_resolution REGEXP '3200x1800' THEN 'Quad HD+'
        WHEN display_resolution REGEXP '3840x2160' THEN 'UHD'
        ELSE 'Not Specified'
    END;



-- ---------------------------------------------------------
-- Validation checks
-- ---------------------------------------------------------

SELECT resolution_class, COUNT(*)
FROM cleaned_laptop_data
GROUP BY resolution_class;

SELECT is_touchscreen, COUNT(*)
FROM cleaned_laptop_data
GROUP BY is_touchscreen;



-- 14. Some screen size entries may be written incorrectly. How would you quickly spot the ones that don’t follow the normal pattern?

SELECT display_resolution, COUNT(*) AS cnt
FROM cleaned_laptop_data
WHERE display_resolution NOT REGEXP '[0-9]+x[0-9]+'
GROUP BY display_resolution;



-- Q15. Since resolution_class already categorizes screen quality,
-- there is no need to create a separate column. A Yes/No
-- high-resolution flag can be derived directly using CASE.

SELECT
    resolution_class,
    CASE
        WHEN resolution_class IN ('Quad HD','Quad HD+','UHD')
        THEN 'Yes'
        ELSE 'No'
    END AS is_high_resolution,
    COUNT(*) AS cnt
FROM cleaned_laptop_data
GROUP BY resolution_class;



-- ⚙️ Processor & Graphics —

-- 16. Processor names are long and messy. How would you reliably figure out which company made the processor from that text?
-- separated into respective columns

ALTER TABLE cleaned_laptop_data
ADD COLUMN cpu_brand varchar(15),
ADD COLUMN cpu_family varchar(30),
ADD COLUMN cpu_model varchar(30),
ADD COLUMN cpu_generation varchar(10),
ADD COLUMN clock_speed_ghz DECIMAL(4,2);



-- ==============================CPU_Brand====================================================

UPDATE cleaned_laptop_data
SET cpu_brand =
    COALESCE(
        REGEXP_SUBSTR(cpu,'Intel|AMD|Samsung|Apple',1,1,'i'),
        'Not Specified'
    );



-- ==============================CPU_Family====================================================

UPDATE cleaned_laptop_data
SET cpu_family =
    COALESCE(
        REGEXP_SUBSTR(
            cpu,
            'Core M|M3|m3|i3|i5|i7|i9|Ryzen 3|Ryzen 5|Ryzen 7|Celeron|Pentium|Xeon|Atom',
            1,1,'i'
        ),
        'Not Specified'
    );

-- validation
SELECT cpu, cpu_family
FROM cleaned_laptop_data
WHERE cpu LIKE '%Core M%';


-- ============================== CPU_Model =============================

UPDATE cleaned_laptop_data
SET cpu_model =
    COALESCE(
        REGEXP_SUBSTR(
            cpu,
            '[0-9][A-Z][0-9]{2,3}|[0-9]{4,5}[A-Z]{0,2}'
        ),
        'Not Specified'
    );

-- validation
SELECT cpu, cpu_model
FROM cleaned_laptop_data
WHERE cpu LIKE '%6Y30%';

SELECT cpu, cpu_model
FROM cleaned_laptop_data
WHERE cpu_model = 'Not Specified'
LIMIT 25;

-- ============================== clock_speed_ghz =============================

UPDATE cleaned_laptop_data
SET clock_speed_ghz =
    CAST(REGEXP_SUBSTR(cpu,'[0-9.]+(?=GHz)') AS DECIMAL(4,2));



-- 17. From processor names, how would you group them into simple performance levels like entry, mid, and high tier?

ALTER TABLE cleaned_laptop_data
ADD COLUMN cpu_tier varchar(30);

UPDATE cleaned_laptop_data
SET cpu_tier =
    CASE
        WHEN cpu_family IN ('Atom','Celeron','Pentium')
            THEN 'Entry'

        WHEN cpu_family IN ('Core M','M3','m3','i3','Ryzen 3')
            THEN 'Mid'

        WHEN cpu_family IN ('i5','Ryzen 5')
            THEN 'Upper-Mid'

        WHEN cpu_family IN ('i7','i9','Ryzen 7','Xeon')
            THEN 'High'

        ELSE 'Not Specified'
    END;

SELECT
    cpu,
    cpu_family,
    cpu_model,
    cpu_tier
FROM cleaned_laptop_data
WHERE cpu LIKE '%6Y30%';

SELECT display_resolution, display_resolution_width, display_resolution_height
FROM cleaned_laptop_data
WHERE display_resolution REGEXP '[0-9]+x[0-9]+.*[0-9]+x[0-9]+'
LIMIT 10;
-- 18. Sometimes processor names include a generation number.
-- How would you pull that number out when it appears?

UPDATE cleaned_laptop_data
SET cpu_generation =
    CASE
        -- Intel Core i-series
        WHEN cpu REGEXP 'i[3579]'
            THEN LEFT(REGEXP_SUBSTR(cpu, '[0-9]{4,5}'), 1)

        -- AMD Ryzen series
        WHEN cpu REGEXP 'Ryzen'
            THEN LEFT(REGEXP_SUBSTR(cpu, '[0-9]{4}'), 1)

        ELSE NULL
    END;
-- 🔍 VALIDATION — show suspicious generations
SELECT cpu, cpu_generation
FROM cleaned_laptop_data
WHERE cpu_brand='Intel'
AND cpu_generation IS NULL
LIMIT 25;


UPDATE cleaned_laptop_data
SET clock_speed_ghz =
    CASE
        WHEN cpu REGEXP '[0-9.]+GHz'
        THEN CAST(REGEXP_SUBSTR(cpu,'[0-9.]+(?=GHz)') AS DECIMAL(4,2))
        ELSE NULL
    END;


-- 🔍 VALIDATION — impossible speeds
SELECT *
FROM cleaned_laptop_data
WHERE clock_speed_ghz > 6
   OR clock_speed_ghz < 0.5;
-- 19. Graphics card names come in many writing styles.
-- How would you standardize them into clean, consistent brand labels?

ALTER TABLE cleaned_laptop_data
ADD COLUMN gpu_brand VARCHAR(20);

UPDATE cleaned_laptop_data
SET gpu_brand =
    CASE
        WHEN gpu REGEXP 'nvidia' THEN 'NVIDIA'
        WHEN gpu REGEXP 'amd'    THEN 'AMD'
        WHEN gpu REGEXP 'intel'  THEN 'Intel'
        ELSE 'Not Specified'
    END;
SELECT gpu_brand, COUNT(*)
FROM cleaned_laptop_data
GROUP BY gpu_brand;
-- Final post-clean sanity check
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN display_resolution_width IS NULL AND display_resolution REGEXP '[0-9]+x[0-9]+' THEN 1 ELSE 0 END) AS failed_res_width,
    SUM(CASE WHEN cpu_model = 'No Dedicated SKU' THEN 1 ELSE 0 END) AS no_sku_cpus,
    COUNT(DISTINCT cpu_tier) AS unique_tiers,
    AVG(clock_speed_ghz) AS avg_clock_ghz
FROM cleaned_laptop_data;


