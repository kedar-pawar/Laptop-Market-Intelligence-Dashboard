-- =========================================================
-- Project : Laptop Dataset Cleaning
-- Author  : Kedar Raju Pawar
-- Date    : 17-02-2026
-- Time    : 00:00:01

use laptop_analysis;

DROP TABLE IF EXISTS analytics_dataset;



DROP TABLE IF EXISTS analytics_master_dataset;

CREATE TABLE analytics_master_dataset AS
SELECT 
Company, laptop_type,
screen_size_inch, 
display_resolution_width, 
display_resolution_height, 
panel_type,
is_touchscreen, 
resolution_class,
cpu_brand, 
cpu_family,
cpu_generation, 
clock_speed_ghz,
cpu_tier, 
gpu_brand,
ram_gb, 
ssd_gb,
hdd_gb, 
flash_gb,
hybrid_gb, 
total_storage_gb,
weight_kg, 
weight_class,
price_band, 
Price,
is_price_outlier
FROM cleaned_laptop_data;
select  * from analytics_master_dataset;
