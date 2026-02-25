-- Name: kedar Raju Pawar
-- time:12:54:00 Date:14/02/2026
-- EDA Structural & Business EDA

-- # Column Audit & Structure Fixes
show databases;
use laptop_analysis;
show tables;
desc cleaned_laptop_data;

-- 

-- Q understand how big the usable dataset is after cleaning
select count(*) as total_records 
from cleaned_laptop_Data;
-- >  Result: 1,303 records retained after cleaning.

-- Q. check how many distinct hardware configurations exist (composite spec key)
-- conclusion :
-- I built the composite hardware specification key using only base hardware attributes — CPU model, RAM, total storage, GPU brand, screen size. And display resolution. 
-- I intentionally excluded derived or bucketed fields such as CPU tier, resolution class. And other calculated categories to stay away from artificial uniqueness and 
-- double-counting. This ensures the key reflects the true physical configuration of the laptop rather than analytical labels created during preprocessing.
CREATE OR REPLACE VIEW hardware_configuration AS
SELECT DISTINCT
    cpu_brand,
    cpu_family,
    cpu_model,
    ram_gb,
    total_storage_gb,
    gpu_brand,
    screen_size_inch,
    display_resolution_width,
    display_resolution_height
FROM cleaned_laptop_data;
SELECT COUNT(*) AS distinct_config_count
FROM hardware_configuration;
select * from hardware_Configuration;

-- conclusion : 
--  Result:
-- 1,303 total records
-- 669 distinct hardware configurations
-- ~51% unique builds; remainder repeated across brands/listings.
-- Duplication consistent with shared OEM hardware bundles.

-- Q. compare average price across cpu performance tiers
SELECT
  cpu_tier,
  COUNT(*) AS model_count,
  ROUND(AVG(price),2) AS avg_price,
  MIN(price) AS min_price,
  MAX(price) AS max_price
FROM cleaned_laptop_data
GROUP BY cpu_tier;

-- > conclusion:
-- Average price increases consistently from Entry to High tier.
-- High tier average is ~4.6x Entry tier.
-- Price dispersion widens at higher tiers.
-- CPU tier appears to be a primary structural pricing factor.

-- Q. compare average price across gpu brands
SELECT
  GPU_Brand,
  COUNT(*) AS model_count,
  ROUND(AVG(price),2) AS avg_price,
  MIN(price) AS min_price,
  MAX(price) AS max_price
FROM cleaned_laptop_data
GROUP BY GPU_Brand;
-- > conclusion:
-- NVIDIA systems show highest average pricing and widest dispersion.
-- Intel dominates model count, positioned in mainstream segment.
-- AMD average pricing lower relative to NVIDIA and Intel.
-- Dedicated GPUs associated with higher price bands.

-- Q. find price spread (min/max gap) within each brand
WITH brand_price AS (
  SELECT company,round( MIN(price),2) min,round( MAX(price),2) max
  FROM cleaned_laptop_data
  GROUP BY company
)
SELECT *,
       round(max - min,2) AS spread
FROM brand_price;
-- > conclusion:
-- RAZER shows the widest price range, followed by LENOVO and HP.
-- ASUS and DELL also display broad pricing coverage.
-- Smaller brands (VERO, HUAWEI, MEDIACOM, FUJITSU) show narrow spreads.
-- Wider spreads indicate multi-segment portfolios.
-- Narrow spreads suggest focused positioning.


-- detect brands that cover all price bands vs only one segment
SELECT
  company, price_band,
  COUNT( price_band) AS band_coverage
FROM cleaned_laptop_data
GROUP BY company,price_band
ORDER BY band_coverage DESC;
-- > conclusion:
-- RAZER shows the widest price range, followed by LENOVO and HP.
-- ASUS and DELL also display broad pricing coverage.
-- Smaller brands (VERO, HUAWEI, MEDIACOM, FUJITSU) show narrow spreads.
-- Wider spreads indicate multi-segment portfolios.
-- Narrow spreads suggest focused positioning.


-- Q. measure how storage size buckets relate to price bands
desc cleaned_laptop_Data;
select total_storage_gb
from cleaned_laptop_Data;
		
select  	
	case 
		when total_storage_gb <=256 then ' Small'
        when total_storage_gb between 257 and 512 then ' Medium'
		when total_storage_gb >=513 and total_storage_gb <=1024  then 'Large'
		when total_storage_gb >1024 then 'Very Large'
	 end as Storage_Bucket,
price_band,
count(*) as model_count
FROM cleaned_laptop_data
GROUP BY storage_bucket, price_band
ORDER BY storage_bucket, price_band;
-- > conclusion:
-- DELL, LENOVO, HP, and ASUS cover Budget, Mid-Range, and Premium segments.
-- ACER and TOSHIBA also span multiple bands but with lighter Premium presence.
-- MSI and RAZER are skewed toward Premium positioning.
-- MEDIACOM, CHUWI, and VERO are primarily Budget-focused.
-- Larger brands show multi-segment portfolios; smaller brands are more concentrated.

-- check how many records are flagged as suspect or outliers
select is_price_outlier,count(is_price_outlier) as cnt
from cleaned_laptop_Data
group by is_price_outlier;
-- Price outlier check

-- 53 of 1303 records flagged (~4%).
-- Small proportion relative to total dataset.
-- Flag appears selective (not over-identifying normal models).
-- Can exclude in modeling if needed.

-- Q rank top 5 brands by premium-model ratio (premium band share)
SELECT
  company,
  SUM(price_band = 'Premium') AS premium_cnt,
  COUNT(*) AS total_cnt,
  ROUND(SUM(price_band = 'Premium') / COUNT(*),4) AS premium_model_ratio
FROM cleaned_laptop_data
GROUP BY company
ORDER BY premium_model_ratio DESC
LIMIT 5;
-- > conclusion:
-- Premium model ratio by brand

-- LG shows 100% Premium concentration (small sample size).
-- RAZER heavily skewed toward Premium.
-- SAMSUNG and GOOGLE majority Premium.
-- MSI also Premium-oriented but with broader portfolio.
-- High ratios for LG and GOOGLE based on limited model counts.

-- Q find configs that appear duplicated across brands (spec twins)
desc cleaned_laptop_Data;
select
    cpu_model,
    ram_gb,
    ssd_gb,
    hdd_gb,
    hybrid_gb,
    flash_gb,
    gpu_brand,
    screen_size_inch,
    display_resolution_width,
    display_resolution_height,
    count(*) as spec_rows,
    count(distinct company) as brand_count
from cleaned_laptop_data
group by
    cpu_model,
    ram_gb,
    ssd_gb,
    hdd_gb,
    hybrid_gb,
    flash_gb,
    gpu_brand,
    screen_size_inch,
    display_resolution_width,
    display_resolution_height
having count(distinct company) > 1
order by spec_rows desc;
-- > conclusion:
-- Spec-twin analysis (identical hardware across brands)

-- Multiple configurations shared across 2–6 brands.
-- Most repeated build appears 24 times across 5 companies.
-- Common combinations: 7200U / 7700HQ, 8–16GB RAM,
-- 256GB SSD or 1TB HDD, FHD display.
-- Indicates strong hardware standardization.
-- Enables direct cross-brand price comparison for identical specs.

-- Q compute median price per laptop type (not average — median)
select
    laptop_type,
    avg(price) as median_price
from (
    select
        laptop_type,
        round(price,3) as price,
        row_number() over (
            partition by laptop_type
            order by price
        ) as rn,
        count(*) over (
            partition by laptop_type
        ) as cnt
    from cleaned_laptop_data
) t
where rn in (floor((cnt + 1)/2), floor((cnt + 2)/2))
group by laptop_type
order by median_price desc;
-- Conclusion:
-- Median price differs materially by laptop_type.
-- Workstations highest (~₹110K), followed by Ultrabook / Gaming (~₹79K).
-- 2-in-1 positioned upper mid (~₹64K).
-- Notebook (~₹36K) and Netbook (~₹18K) lowest.
-- ~₹92K gap between top and bottom categories.
-- Median used to reduce distortion from extreme premium builds.
 
-- Q find most common spec bundle (ram + cpu tier + gpu brand)
select
    ram_gb,
    cpu_tier,
    gpu_brand,
    count(*) as bundle_count
from cleaned_laptop_data
group by
    ram_gb,
    cpu_tier,
    gpu_brand
order by bundle_count desc
limit 1;
-- > -- Most common configuration:
-- 8GB RAM + Upper-Mid CPU tier + Intel GPU (190 models).
-- Indicates mainstream productivity baseline.
-- Useful reference point for relative price comparison.

-- Q. Which brands demonstrate the highest pricing density (price per GB of storage) among brands 
-- with at least 10 models, and how do RAM capacity, device weight, and premium-segment share help explain their overall market positioning?

SELECT 
    company,
    ROUND(AVG(price / NULLIF(total_storage_gb, 0)), 2) AS price_per_gb,
    COUNT(*) AS model_count,
    ROUND(AVG(ram_gb), 1) AS avg_ram,
    ROUND(AVG(weight_kg), 2) AS avg_weight,
    SUM(CASE WHEN price_band = 'Premium' THEN 1 ELSE 0 END) / COUNT(*) AS premium_ratio
FROM cleaned_laptop_data
WHERE total_storage_gb > 0
GROUP BY company
HAVING model_count >= 10
ORDER BY price_per_gb DESC
LIMIT 10;

-- > conclusion:
-- Price-per-GB varies materially by brand (min 10 models).
-- APPLE highest (~₹292/GB): low weight, moderate RAM, high premium mix.
-- TOSHIBA / HP also high density with broader portfolios.
-- LENOVO / ACER lower density → value-oriented positioning.
-- MSI lowest (~₹89/GB) despite highest avg RAM and strong premium ratio, implying larger storage allocation in performance builds.
-- Storage price density reflects bundling strategy and premium mix, not just raw capacity.