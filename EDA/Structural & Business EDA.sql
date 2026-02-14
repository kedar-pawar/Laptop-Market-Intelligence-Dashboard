-- Name: kedar Raju Pawar
-- time:12:54:00 Date:14/02/2026
-- EDA Structural & Business EDA

-- # Column Audit & Structure Fixes
show databases;
use laptop_analysis;
desc cleaned_laptop_Data;

-- 

-- Q understand how big the usable dataset is after cleaning
select count(*) as total_records 
from cleaned_laptop_Data;
desc cleaned_laptop_Data;
-- > even after data cleaning and preprocessing the cleaned copy dataset still contains 1303 record.

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

-- conclusion : After cleaning and preprocessing, the dataset contains 1303 records. Using this composite spec key, I identified 681 distinct hardware configurations.
--  This shows that many rows represent repeated hardware builds, where the same core specifications appear multiple times across different brands, models, or listings. 
-- This pattern is expected in real market datasets and supports deeper analysis such as cross-brand price comparison, duplicate configuration detection, value analysis 
-- across sellers. And spec-level market segmentation.
-- see brand market share percentage by model count

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
-- CPU performance tier shows a strong positive relationship with laptop price in the dataset. High-tier CPUs have the highest average price (~85.8K),
-- while Entry-tier systems are the lowest (~18.4K), with Mid and Upper-Mid tiers forming the middle price bands. The High tier also has the widest price spread, 
-- indicating both premium consumer and ultra-high-end models. Entry tier prices are more tightly grouped, reflecting standardized budget offerings. The “Not Specified” 
-- tier shows mixed pricing behavior, suggesting inconsistent or piece-case CPU classifications.

-- Q. compare average price across gpu brands
SELECT
  GPU_Brand,
  COUNT(*) AS model_count,
  ROUND(AVG(price),2) AS avg_price,
  MIN(price) AS min_price,
  MAX(price) AS max_price
FROM cleaned_laptop_data
GROUP BY GPU_Brand;
-- > GPU brand shows a clear pricing separation across the dataset. Laptops with NVIDIA GPUs have the highest average price (~79.4K), 
-- indicating strong presence in gaming and high-performance segments. Intel integrated graphics dominate by amount and sit in the mid-price 
-- differ (~53.7K), reflecting mainstream consumer models. AMD GPUs show a lower average price (~41.3K), suggesting stronger representation 
-- in value-oriented configurations. Overall, dedicated GPUs (especially NVIDIA) are strongly associated with premium pricing.

-- Q. find price spread (min/max gap) within each brand
WITH brand_price AS (
  SELECT company,round( MIN(price),2) min,round( MAX(price),2) max
  FROM cleaned_laptop_data
  GROUP BY company
)
SELECT *,
       round(max - min,2) AS spread
FROM brand_price;
-- >Brand price spread varies significantly across the dataset, indicating different market positioning strategies. Premium-focused brands like Razer and Lenovo 
-- >show very wide price gaps, covering both high-end and ultra-premium segments. Budget-oriented brands such as Chuwi and Mediacom have make narrow spreads, 
-- >reflecting tightly priced product lines. Large spreads usually indicate broader product portfolios across performance tiers. 
-- >This metric helps tell apart specialist brands from full-differ market players.

-- detect brands that cover all price bands vs only one segment
SELECT
  company, price_band,
  COUNT( price_band) AS band_coverage
FROM cleaned_laptop_data
GROUP BY company,price_band
ORDER BY band_coverage DESC
;
-- > conclusion: The brand-by-price-band distribution shows how each company’s models are spread across Budget, Mid-Modification. 
-- >And Premium segments. Major brands like Dell, Lenovo, HP. And Asus have strong presence across multiple bands with high model counts, 
-- >indicating diversified product portfolios. Some brands are heavily concentrated in a single band, revealing focused market positioning. 
-- > This distribution view helps obtain amount strength within each price piece before brand-level coverage classification.
SELECT
  company,
  COUNT(DISTINCT price_band) AS band_coverage,
  GROUP_CONCAT(DISTINCT price_band ORDER BY price_band) AS band_list,
  CASE
    WHEN COUNT(DISTINCT price_band) >= 3 THEN 'Multi Range'
    WHEN COUNT(DISTINCT price_band) = 2 THEN 'Bi Segment'
    ELSE 'Single Segment'
  END AS segment_type
FROM cleaned_laptop_data
GROUP BY company
ORDER BY band_coverage DESC;
-- >Price band coverage analysis shows that brands such as Acer, Asus, Dell, HP, Lenovo, Samsung, and Toshiba operate across all price bands, 
-- >indicating full-range market participation. Brands like Apple, Microsoft, MSI, and Razer focus mainly on mid-to-premium segments, reflecting targeted positioning.
-- >Several smaller brands appear in only one band, showing niche or budget specialization. This segmentation clearly distinguishes full-portfolio brands from 
-- >segment-focused players and supports competitive positioning analysis.

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
-- Storage amount shows a relationship with price bands. But not a strictly linear one. Minor and medium storage configurations dominate across all price segments,
--  including Premium models, indicating that storage alone does not determine pricing. Large and highly large storage appear more often in Budget and Mid-Differ bands, 
-- likely due to high-amount HDD configurations. This suggests that storage type and performance matter more than raw amount in premium pricing.

-- check how many records are flagged as suspect or outliers
select is_price_outlier,count(is_price_outlier) as cnt
from cleaned_laptop_Data
group by is_price_outlier;
-- Outlier detection shows that 53 out of 1303 records (~4%) are flagged as price outliers. This indicates that only a minor portion of listings have unusually high or 
-- low prices relative to their specs. The low piece suggests the outlier rule is selective and not over-flagging normal models. These flagged records can be reviewed 
-- separately or excluded from statistical modeling to prevent distortion.

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
-- > Premium-model ratio ranking shows which brands are most focused on the premium piece. LG, Razer, Samsung, Google. And MSI have the highest premium piece,
--  with most of their models positioned in the Premium band. However, some top ratios come from small product counts, indicating niche premium-focused portfolios
-- rather than broad market coverage. This metric reflects brand positioning strategy more than total market amount.

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
-- >Spec-twin analysis shows that many identical hardware configurations are sold across multiple brands, with some popular builds appearing under 4–6 different companies.
--  Common CPU models like 7200U and 7700HQ with standard RAM, storage. And FHD displays are widely reused across the market. This indicates strong platform standardization 
-- in laptop manufacturing. Such duplicated specs allow fair cross-brand price and value comparisons. It also supports detecting overpricing or underpricing for the same 
-- hardware configuration

-- Q compute median price per laptop type (not average — median)
select
    laptop_type,
    avg(price) as median_price
from (
    select
        laptop_type,
        price,
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
-- > Median price by laptop type shows clear segment separation across product categories. Workstations have the highest typical price, followed by Ultrabooks and 
-- >Gaming laptops in the premium consumer range. Convertibles and standard Notebooks occupy the middle market, while Netbooks sit at the lowest median price level. 
 -- > Using median instead of average provides a more robust view by reducing the impact of extreme high-end models. This confirms strong price stratification by 
 -- > device category.
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
-- > The most common hardware bundle in the dataset is 8GB RAM with an Upper-Mid CPU tier and Intel graphics, appearing in 190 models. This indicates that the market 
-- >is heavily centered around mainstream productivity configurations rather than high-end gaming or entry-level builds. It reflects the typical consumer sweet-spot
-- > spec for general-purpose laptops. This bundle can be treated as the baseline configuration for comparative value and pricing analysis.
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
-- >Price-per-GB analysis shows clear brand positioning differences in value density. MSI and Apple rank highest, indicating premium pricing relative to storage capacity, 
-- >supported by high premium-model ratios. Toshiba, HP, Asus, and Dell occupy the mid range with balanced specs and pricing. Lenovo and Acer show lower price-per-GB values,
-- > reflecting stronger value-oriented positioning. Combining price density with RAM, weight, and premium share provides a compact brand value profile.
