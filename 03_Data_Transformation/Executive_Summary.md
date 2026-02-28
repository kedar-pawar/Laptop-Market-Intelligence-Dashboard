# 03_DATA_TRANSFORMATION

**Project:** Laptop Dataset Cleaning  
**Done By:** Kedar Raju Pawar  
**Date** February 23, 2026  
**Time :** 10:50 AM  

---

## 📌 Overview

This phase focuses on transforming raw laptop dataset records into a structured, analysis-ready master dataset.

The transformation process includes:

- Structural column fixes  
- Text-to-numeric parsing  
- Feature engineering  
- Standardization of categorical values  
- Data quality validation  
- Outlier detection  
- Deduplication logic  
- Analytical dataset creation  

The objective is to convert raw scraped-style data into a reliable analytics foundation.

---

# 1️⃣ Column Audit & Structural Fixes

### Actions Performed:
- Created working copy (`cleaned_laptop_data`)
- Renamed ambiguous columns
- Dropped non-analytical fields
- Split screen resolution into:
  - `display_resolution_width`
  - `display_resolution_height`
- Extracted:
  - `panel_type`
  - `is_touchscreen`
  - `resolution_class`

### Impact:
Enabled structured numeric resolution analysis and device segmentation.

---

# 2️⃣ CPU & GPU Parsing

### CPU Features Extracted:
- `cpu_brand`
- `cpu_family`
- `cpu_model`
- `cpu_generation`
- `clock_speed_ghz`
- `cpu_tier` (Entry / Mid / Upper-Mid / High)

### GPU Standardization:
Normalized GPU vendors into:
- NVIDIA
- AMD
- Intel

### Impact:
Transformed unstructured processor strings into usable analytical dimensions.

---

# 3️⃣ RAM & Memory Transformation

## RAM Cleaning
- Normalized inconsistent formats (8GB / 16 GB / gb variants)
- Created numeric column:
  - `ram_gb`

## Storage Parsing
From composite memory strings like:
- `256GB SSD`
- `1TB HDD`
- `128GB SSD + 1TB HDD`

Created structured columns:
- `ssd_gb`
- `hdd_gb`
- `flash_gb`
- `hybrid_gb`
- `total_storage_gb`

Converted all TB values into GB for consistency.

### Impact:
Enabled aggregation, filtering, segmentation, and modeling.

---

# 4️⃣ Weight Standardization

Converted:
- `1.25kg`
- `1.5 kg`

Into numeric:
- `weight_kg`

Created classification:
- Light
- Medium
- Heavy

### Impact:
Enabled ergonomic and portability analysis.

---

# 5️⃣ Price Validation & Standardization

### Performed:
- Outlier detection (±2 STDDEV method)
- Created `is_price_outlier`
- Categorized into `price_band`:
  - Budget
  - Mid-Range
  - Premium

### Impact:
Prepared dataset for pricing strategy modeling.

---

# 6️⃣ Data Quality Engineering

## Duplicate Detection
- Used composite business key logic
- Applied ROW_NUMBER ranking
- Retained most complete records

## Suspect Flag
Flagged records where:
- High specs
- Abnormally low price

## Data Quality Score
Weighted scoring based on:
- CPU details
- RAM
- Storage
- Resolution
- Price

Generated:
- `data_quality_score`
- `data_quality_category`

### Impact:
Elevated dataset reliability to professional-grade standards.

---

# 7️⃣ Analytics Master Dataset Creation

Final structured table:
`analytics_master_dataset`

Includes:
- Structured numeric specs
- Cleaned categorical variables
- Derived pricing bands
- Outlier flags
- Storage metrics
- CPU tier segmentation

This table serves as:

> The single source of truth for visualization, modeling, and strategic analysis.

---

# 🔎 Architecture Philosophy

- Raw table preserved
- Cleaned table versioned
- Derived columns never overwrite raw fields
- Cleaning logic fully scripted and reproducible
- Deterministic logic handled in SQL
- Algorithmic logic reserved for Python

---

# 🎯 Business Outcome

This transformation layer converts:

Raw Scraped Dataset  
→ Structured Analytical Model  
→ Strategic Decision Foundation  

It enables:
- Revenue Modeling
- Value Index Design
- Pricing Strategy Insights
- Market Segmentation
- Competitive Benchmarking

---

# ✅ Status

✔ Structural Cleaning Completed  
✔ Feature Engineering Completed  
✔ Data Quality Validation Implemented  
✔ Master Dataset Generated  

Ready for:
- Visualization Layer
- Strategic Modeling
- Executive Reporting
