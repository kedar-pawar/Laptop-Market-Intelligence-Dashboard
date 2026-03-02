# 📊 Competitive Laptop Pricing Intelligence Model

### Strategic Revenue, Value Efficiency & Pricing Simulation Framework  
**Author:** Kedar Raju Pawar  
**Year:** 2026  

---

## 🚀 Project Overview

This project develops a structured, data-driven pricing intelligence framework to analyze how laptop hardware specifications influence market pricing and revenue concentration.

The model integrates:

- Structured data transformation
- Statistical validation
- Composite performance scoring
- Value efficiency benchmarking
- Revenue simulation
- Pricing elasticity testing
- Executive-level dashboard reporting

The objective is not just analysis — but strategic pricing intelligence.

---

## 🧠 Core Problem Addressed

- What truly drives laptop pricing?
- Does higher price always mean higher performance value?
- Which brands dominate revenue structurally?
- Are some brands underpriced or overpriced relative to value?
- How sensitive is revenue to controlled pricing adjustments?

This framework converts raw specifications into structured decision intelligence.

---

# 🏗️ Project Architecture
```text
Laptop-Price-Analytics/
│
├── 01_Project_Governance/
│   ├── README.md
│   ├── Project_Charter.md
│   ├── Scope_Definition.md
│   ├── Assumptions_Constraints.md
│   └── Change_Log.md
│
├── 02_Data_Management/
│   ├── Raw_Data/
│   │   └── laptop_data.csv
│   │
│   ├── Interim_Data/
│   │   └── sql_cleaned_output.csv
│   │
│   ├── Processed_Data/
│   │   └── model_ready_dataset.csv
│   │
│   └── Data_Dictionary/
│       └── data_dictionary.xlsx
│
├── 03_Data_Transformation/
│   ├── 01_column_audit.sql
│   ├── 02_resolution_cpu_gpu_parsing.sql
│   ├── 03_memory_ram_parsing.sql
│   ├── 04_price_validation.sql
│   └── 05_duplicate_integrity_checks.sql
│   └── 06_data_modelling.sql
│
├── 04_Analytics_Development/
│   ├── EDA/
│   │   ├── statistical_modeling_eda.ipynb
│   │   └── structural_business_eda.sql
│   │
│   ├── Statistical_Validation/
│   ├── Regression_Modeling/
│   ├── Clustering_Analysis/
│   └── Scoring_Methodology/
│
├── 05_Business_Analysis/
│   ├── Revenue_Modeling/
│   ├── Value_Index_Design/
│   ├── Scenario_Simulation/
│   └── Pricing_Strategy_Insights/
│
├── 06_Visualization_Reporting/
│   ├── Dashboards/
│   ├── Executive_Summary/
│   └── Technical_Report/
│
├── 07_Testing_Validation/
│   ├── Data_Validation_Reports/
│   ├── Model_Performance_Reports/
│   └── QA_Checklists/
│
└── 08_Archive/
```
Governance-first layered architecture ensures reproducibility and traceability.

---

# 🔍 Analytical Components

## 1️⃣ Data Transformation (SQL)

- Resolution parsing (width, height)
- CPU tier classification
- Storage standardization (TB → GB)
- Duplicate detection
- Outlier validation
- Model-ready dataset creation

---

## 2️⃣ Statistical Validation

- Pearson & Spearman Correlation
- ANOVA (CPU tier pricing significance)
- Multiple Linear Regression (32 features, R² ≈ 0.53)
- K-Means Clustering (Hardware vs Market segmentation)

Confirmed:
- RAM & CPU tier are dominant pricing drivers
- Brand premiums significantly influence pricing structure

---

## 3️⃣ Composite Performance Score

Weighted Scoring Model:

| Feature | Weight |
|----------|--------|
| CPU Tier | 0.4 |
| Clock Speed | 0.3 |
| RAM | 0.2 |
| SSD | 0.1 |

MinMax normalization applied.

Performance Score enables objective configuration comparison.

---

## 4️⃣ Value Index Framework

Value Index = Performance Score / Price

Products segmented into:
- High Value
- Balanced
- Low Value

Used for:
- Value ranking
- Pricing gap detection
- Strategic repositioning insights

---

## 5️⃣ Revenue Modeling

Revenue = Estimated Units × Price

Total Market Revenue Observed:
**₹1.488 Trillion**

Brand revenue concentration analysis identifies structural leaders.

---

## 6️⃣ Pricing Elasticity Simulation

Dynamic Pricing Simulator:

- ±3% pricing adjustment
- Observed ~4.6% revenue sensitivity
- Implied elasticity ≈ -1.5

This models demand sensitivity under controlled adjustments.

---

# 📈 Executive Dashboard (Power BI)

### Competitive Laptop Pricing Intelligence Dashboard

**Key KPIs:**
- Total Revenue: ₹1.488T
- Average Price: ₹68,787
- High Value Share: 31.6%
- Simulated Revenue under 3% adjustment: ₹1.444T

### 📄 Dashboard Report

[Click here to view full PDF report](06_Visualization_Reporting/Dashboards/Pricing_Intelligence.pdf)
[Live Tableau Dashboard](https://public.tableau.com/app/profile/kedar.pawar/viz/MarketPositioningAnalysisD4/StrategicRecommendations4?publish=yes)

---
## Strategic Market Positioning Framework

### Brands classified into:

- Premium Leaders

- Value Volume Leaders

- Weak Premium

- Low Impact Players

### Based on:

- Average Price (X-axis)

- Total Revenue (Y-axis)

- Supports structured pricing strategy recommendations.

---
## QA & Governance

### Enterprise-style validation performed:

- Cross-tool reconciliation (SQL → Python → Power BI)

- KPI validation

- Simulation stress testing

- Risk documentation

- Version control tracking

#### Model Version: v3.0
#### Status: Validation Complete

---
## Assumptions & Constraints

### Static dataset

- Estimated units (not transactional sales)

- Elasticity modeled assumption

- No seasonality or external benchmarking data

---

#### Transparency maintained in documentation.

## Tools Used

### SQL (Data Parsing & Transformation)

- Python (Numpy, Pandas, Matplot, seaborn, Scikit-Learn)

- Jupyter Notebook

- Power BI (Dashboard & Simulation Engine)

- DAX (KPI & Scenario Logic)

## Business Impact

### This model enables:

- Detection of underpriced high-value opportunities

- Brand-level revenue concentration analysis

- Structured premium pricing defense

- Controlled scenario-based revenue testing

- Data-backed pricing intelligence

### Applicable in:

- Consumer electronics pricing strategy

- Retail analytics

- Competitive positioning analysis

- Revenue optimization modeling

## Repository Structure
data/
notebooks/
sql/
dashboard/
docs/

### Each analytical layer is version-controlled and documented.

## Limitations

- Static dataset (no real-time feed)
- Units sold are estimated
- Elasticity is modeled assumption-based
- No seasonality modeling
- No external enrichment data

---

## Author

Kedar Raju Pawar  
Data Analytics & Pricing Strategy Enthusiast  

---

## Project Status

✔ Data Transformation Complete  
✔ Statistical Modeling Complete  
✔ Clustering & Segmentation Complete  
✔ Value Scoring Framework Complete  
✔ Revenue Simulation Complete  
✔ Elasticity Simulation Complete  
✔ Dashboard Integrated  
✔ QA Governance Documented  

---

## Purpose

This project demonstrates structured analytical thinking, business interpretation, and model governance — not just dashboard creation.


It reflects production-style pricing intelligence architecture adapted for portfolio demonstration.

