-- Name: kedar Raju Pawar
-- time:10:00:00 Date:13/02/2026
-- Data Cleaning Questions — MySQL (Laptop Dataset)

--  Column Audit & Structure Fixes
show databases;
use laptop_analysis;
desc laptop_data;
-- =========================================================================================================================================================================
-- 1. There’s a column called MyUnknownColumn. How would you investigate whether it’s useful, redundant, or should be removed?
-- Answer after checks:
    -- Mostly NULL or meaningless values
    
    -- Not used in any query/view/procedure I found
    -- Dropping it shrinks table size with zero downside

-- =========================================================================================================================================================================
-- 2. Before cleaning anything, how would you quickly profile each column for:

-- nulls
select
    sum(case when company is null then 1 else 0 end) as company_null_count,
    sum(case when TypeName is null then 1 else 0 end) as typename_null_count,
    sum(case when Inches is null then 1 else 0 end) as inches_null_count,
    sum(case when ScreenResolution is null then 1 else 0 end) as screenresolution_null_count,
    sum(case when Cpu is null then 1 else 0 end) as cpu_null_count,
    sum(case when Ram is null then 1 else 0 end) as ram_null_count,
    sum(case when Memory is null then 1 else 0 end) as memory_null_count,
    sum(case when Gpu is null then 1 else 0 end) as gpu_null_count,
    sum(case when OpSys is null then 1 else 0 end) as opsys_null_count,
    sum(case when Price is null then 1 else 0 end) as price_null_count
from laptop_data;
-- conclusion: no null data available the dataset
-- =========================================================================================================================================================================
-- blanks
select
    sum(trim(company) = '') as company_blank_count,
    sum(trim(typename) = '') as typename_blank_count,
    sum(trim(screenresolution) = '') as screenresolution_blank_count,
    sum(trim(cpu) = '') as cpu_blank_count,
    sum(trim(ram) = '') as ram_blank_count,
    sum(trim(memory) = '') as memory_blank_count,
    sum(trim(gpu) = '') as gpu_blank_count,
    sum(trim(opsys) = '') as opsys_blank_count
from laptop_data;
-- conclusion: no blank data available the dataset
-- =========================================================================================================================================================================
-- strange values
	-- spelling variants, casing differences, rare one-off vendors, garbage strings. 
	-- Company Value Distribution
		select company, count(*) as cnt
		from laptop_data
		group by company
		order by cnt desc;
		--  conclusion : 
		-- Vendor names are standardized with no visible casing or spelling inconsistencies. Distribution is right-skewed with a few dominant brands 
		-- and many low-volume vendors.No immediate cleaning required, but rare vendors should be reviewed for business relevance or grouping strategy.
-- ===============================================================================================================================
	-- TypeName Distribution
		select typename, count(*) as cnt
		from laptop_data
		group by typename
		order by cnt desc;
        -- conclusion: 
        -- Product type categories are clean and well-standardized. No duplicate labels or format drift detected. 
        -- Class imbalance exists (Notebook-heavy), which should be considered during modeling or segmentation analysis.
	-- RAM Distribution
		select ram, count(*) as cnt
		from laptop_data
		group by ram
		order by cnt desc;
        -- conclusion: 
        -- RAM values are format-consistent and categorical-ready. No unit inconsistencies or malformed entries detected.
        -- Column can be safely transformed into numeric GB values for analysis.
	-- Numeric Outlier Check
		select min(inches), max(inches)
		from laptop_data;
		-- Conclusion:
        -- Screen size values fall within realistic laptop boundaries.
		-- No numeric outliers or corrupted scale values detected. Column passes sanity validation.
	-- Price Outlier Scan
		select price
		from laptop_data
		order by price desc
		limit 10;
        -- conclusion: 
		-- Price values show floating-point precision artifacts, likely from currency conversion or binary float storage.
        -- Values are numerically plausible but should be rounded to 2 decimals for reporting and dashboard use.

-- ===============================================================================================================================
-- unexpected formats?

	 -- Company Name Check:
     select company
     from laptop_data
     where company regexp '[0-9]';
     -- conclusion: result concludes that all the naming format is clean and consistent for column company
-- -----------------------------------------------------------------------------------------------------------------------

update laptop_data
set company = trim(company);

-- -----------------------------------------------------------------------------------------------------------------------
	 -- TypeName
		select Typename
		 from laptop_data
		 where Typename not like "%Book%" and
			   Typename not like "%Gaming%" and
               Typename not like "%2 in 1 convertible%" and
               Typename not like "%Workstation%";
		-- > conclusion: Laptop type categories are valid in the dataset.
-- -----------------------------------------------------------------------------------------------------------------------
	-- Inches
		select inches
        from laptop_data
        where inches not in (
							10.1,11.3,11.6,12.0,12.3,12.5,13.0,13.3,13.5, 13.9,
							14.0,14.1,15.0,15.4,15.6,
							16.0,16.1,
							17.0,17.3,18.4
							);
		-- > Conclusion: Screen size of laptop are according to standarised guidelines.
		
	-- ScreenResolution
    select ScreenResolution
    from laptop_data
    where ScreenResolution not regexp'[0-9]+x[0-9]+';
	-- > Conclusion: Screen Resolution of laptop are according to standarised guidelines.
	-- CPU
		select CPU
        from Laptop_data
        where CPU not like "%Intel%" 
        and CPU not like "%AMD%"
        and CPU not like "%Apple%"
        and CPU not like "%Samsung%";
	 -- > Conclusion: CPU enlisted in the dataset are legal from global companies and valid according to IT Standards.

    
    -- RAM
		select Ram
        from Laptop_data
		where Ram not regexp"^[0-9]+GB$";
	-- > Conclusion: Ram Enlisted in the dataset are of valid data format and are ready for numeric conversion/
	
    -- Memory
		select memory
        from laptop_Data
        where memory not regexp'[0-9]+GB'
        and memory not regexp'[0-9]+TB';
	-- > conclusion: Memory format are consistent and according to ISO Format, memory is ready for numeric format
    
    -- GPU
		select GPU
        from Laptop_data
        where GPU not like "%Intel%" 
        and gPU not like "%AMD%"
        and gPU not like "%Apple%"
        and gPU not like "%Nvidia%";
	-- > Conclusion: GPU are consistent and accurate according to iso standard except for one record suggested it to add other unknown vendor
    
    -- OpSys
		select distinct opsys
        from Laptop_data;
	-- Conclusion: 
	-- The OpSys column contains inconsistent naming and mixed granularity. For example, “macOS” and “Mac OS X” refer to the same operating system and should be standardized.
    -- Windows entries include both family and version-level labels (Windows 7, Windows 10, Windows 10 S), requiring normalization depending on analysis level. 
    -- The value “No OS” represents missing or uninstalled operating systems and should be treated separately. Non-traditional laptop systems like Android and Chrome 
    -- OS should be validated for device-type consistency.
    
    -- Price
		select price 
        from laptop_data
        where price<=0;
	-- conclusion: It contains no zero or negative price values in the dataset
-- =========================================================================================================================================================================
-- 3. Which columns should not remain as TEXT if we want to do numeric analysis later?
-- > Ram, Memory, weight
-- =========================================================================================================================================================================
-- 4. How would you create a cleaned copy of this table before transforming anything?
	-- > using the Full copy method available with all data
	-- which has syntax
		--	create new table table  as select * from og table;
        
select memory,count(*)
from cleaned_laptop_data
group by memory
-- =========================================================================================================================================================================
-- 💾 RAM & Weight — Unit Removal Tasks

-- 5. RAM is stored like "8GB" — how would you convert it into a numeric GB column safely?
	-- > First create a which specify the size(Numeric), GB/TB(text) for Ram,
	-- > then use case when and then to fill it
-- =========================================================================================================================================================================
-- 6. Some RAM values might have spaces like "16 GB" — how would you normalize first before conversion?
-- > 1st inspect the current data, if found any inconsistenies then remove the unnecessary hurdles and after that convert that column in to numeric format
-- =========================================================================================================================================================================
-- 7. Weight is stored like "2.3kg" — how would you extract usable numeric weight?
	-- > 1st inspect the current weight data, if found any inconsistencies then remove the hunnecessary hurdles after that convert that column into numeric format
-- =========================================================================================================================================================================
-- 8. How would you detect rows where RAM or Weight failed conversion?
-- > validate conversions using regex format checks and by flagging rows where the numeric cast result is NULL or zero while the original value is not.
-- =========================================================================================================================================================================
-- 🧠 Memory Column — Messy Composite Field

-- Memory examples:
-- 256GB SSD
-- 1TB HDD
-- 128GB SSD + 1TB HDD
-- =========================================================================================================================================================================
-- 9. How would you classify each row into:
-- SSD only
-- HDD only
-- Hybrid
-- Flash storage
-- > 1st create new column i.e. ssd,hdd,hybrid, Flash Storage and after that add data into each respective columns using case when then 
-- =========================================================================================================================================================================
-- 10. How would you extract SSD capacity separately from HDD capacity?

-- >I parse the memory column using pattern matching to detect SSD vs HDD, extract numeric capacity with regex, and convert TB to GB before storing them in separate fields.
-- =========================================================================================================================================================================
-- 11. How would you standardize TB and GB into a single GB metric?

-- > I detect the unit using pattern matching, extract the numeric value, convert TB to GB by multiplying by 1024, and store everything in a unified GB column.
-- =========================================================================================================================================================================
-- 12. How would you handle rows where memory format doesn’t match expected patterns?
-- > I detect non-matching memory formats using regex, flag those rows for review, attempt safe normalization fixes, and set unresolved cases to NULL instead of forcing incorrect conversions.