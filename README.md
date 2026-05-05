# 📊 Competitive Laptop Pricing Intelligence Model

### Strategic Revenue Optimization, Value Efficiency & Pricing Simulation Framework

**Author:** Kedar Raju Pawar

**Year:** 2026

---

## 🚀 Project Overview

This project develops a **decision-grade pricing intelligence framework** to analyze how laptop hardware configurations influence pricing, value perception, and revenue concentration.

It is designed to move beyond descriptive analytics into **actionable pricing strategy modeling**.

The system integrates:

* Structured data transformation (SQL)
* Statistical validation (Python)
* Regression-based price modeling
* Clustering-driven segmentation
* Composite performance scoring
* Value efficiency benchmarking
* Revenue simulation modeling
* Pricing elasticity testing
* Executive-level dashboard reporting

---

## 🧠 Business Problem

This model addresses core strategic questions:

* What actually drives laptop pricing?
* Does higher price reflect proportional performance?
* Where are pricing inefficiencies in the market?
* Which brands dominate revenue structurally?
* How sensitive is revenue to controlled pricing adjustments?

👉 The objective is to convert raw hardware specifications into **pricing intelligence and decision signals**.

---

# 🏗️ Project Architecture

```text id="arch01"
Laptop ANALYSIS/
│
├── 01_Project_Governance/
│   ├── README.md
│   ├── Project_Charter.md
│   ├── Scope_Definition.md
│   ├── Assumptions_Constraints.md
│   └── Change_Log.md
│
├── 02_Data_Management/
│   ├── 01_Raw_Data/
│   │   └── laptop_data.csv
│   │
│   ├── 02_Interim_Data/
│   │   └── Cleaned_Laptop_Data.csv
│   │
│   ├── 03_Data_Dictionary/
│   │   ├── data_dictionary_raw.xlsx
│   │   ├── data_dictionary_raw.pdf
│   │   ├── data_dictionary_Interim.pdf
│   │   └── data_dictionary_Processed.pdf
│   │
│   └── 04_Processed_Data/
│       └── analytics_dataset.csv
│
├── 03_Data_Transformation/
│   ├── Column Audit & Structure Fixes.sql
│   ├── ScreenResolution + CPU GPU Parsing.sql
│   ├── Price Validation & Standardization.sql
│   ├── Memory and RAM Parsing.sql
│   ├── Duplicate & Integrity Checks.sql
│   ├── Data Modelling.sql
│   └── Executive_Summary.md
│
├── 04_Analytics_Development/
│   ├── 00_EDA/
│   ├── 01_Statistical_Validation/
│   ├── 02_Regression_Modeling/
│   ├── 03_Clustering_Analysis/
│   ├── 04_Scoring_Methodology/
│   └── Laptop_Market_Analysis_Report.pdf
│
├── 05_Business_Analysis/
│   ├── Pricing_Strategy_Insights/
│   ├── Revenue_Modeling/
│   ├── Scenario_Simulation/
│   └── VALUE_INDEX_DESIGN/
│
├── 06_Visualization_Reporting/
│   ├── Dashboards/
│   ├── Executive_Summary/
│   └── Technical_Report/
│
├── 07_Testing_Validation/
│   ├── Data_Validation_Reports/
│   ├── Model_Performance_Reports/
│   └── qa_checklist.md
│
└── 08_Archive/
```

👉 Governance-first layered design ensures:

* Reproducibility
* Traceability
* Audit-ready analytics pipeline

---

# 🔍 Analytical Framework

## 1️⃣ Data Transformation (SQL)

* Resolution parsing (width, height)
* CPU tier classification
* GPU categorization
* Storage normalization (TB → GB)
* RAM extraction & structuring
* Price validation & standardization
* Duplicate detection & integrity flags
* Model-ready dataset creation

---

## 2️⃣ Statistical Validation

* Pearson & Spearman Correlation
* ANOVA (CPU tier pricing significance)
* Multiple Linear Regression (32 features, R² ≈ 0.53)
* Feature importance analysis
* Segment-level hypothesis testing

### ✅ Key Finding

RAM and CPU tier are dominant pricing drivers, while **brand premiums introduce systematic pricing distortion independent of performance**.

---

## 3️⃣ Regression Modeling

* Baseline Linear Regression
* Feature importance extraction
* Model evaluation metrics
* Stored artifacts:

  * `linear_model.pkl`
  * `feature_columns.pkl`
  * `model_features.pkl`

👉 Purpose: Quantify contribution of each feature to pricing.

---

## 4️⃣ Clustering Analysis

* K-Means segmentation
* Hardware-based clustering
* Market positioning clustering

Outputs:

* `hardware_clustered_laptops.csv`
* `Market_clustered_laptops.csv`

👉 Enables identification of:

* Premium clusters
* Value clusters
* Mispriced segments

---

## 5️⃣ Composite Performance Score

Weighted scoring model:

| Feature     | Weight |
| ----------- | ------ |
| CPU Tier    | 0.4    |
| Clock Speed | 0.3    |
| RAM         | 0.2    |
| SSD         | 0.1    |

* MinMax normalization applied
* Scaler stored (`performance_scaler.pkl`)

👉 Converts configurations into **comparable performance units**

---

## 6️⃣ Value Index Framework

Value Index = Performance Score / Price

Used for:

* Value segmentation
* Mispricing detection
* Competitive benchmarking

Segments:

* High Value
* Balanced
* Low Value

Outputs:

* `value_index_model_ready.csv`
* `Value_Index_Output_V0.xlsx`

---

## 7️⃣ Revenue Modeling

Revenue = Estimated Units × Price

* Total Market Revenue: **₹1.488 Trillion**
* Brand-level revenue simulation:

  * `brand_revenue_simulation_V0.xlsx`

👉 Identifies **revenue concentration and structural dominance**

---

## 8️⃣ Pricing Elasticity Simulation

* ±3% controlled pricing adjustment
* Revenue sensitivity: ~4.6%
* Elasticity ≈ -1.5

### 🔥 Strategic Interpretation

* Market shows **elastic demand behavior**
* Mid-tier segment is highly price-sensitive
* Premium segment exhibits **relative price insulation**

---

# 📈 Executive Dashboard

### Competitive Laptop Pricing Intelligence Dashboard

**KPIs:**

* Total Revenue: ₹1.488T
* Average Price: ₹68,787
* High Value Share: 31.6%
* Simulated Revenue: ₹1.444T

### Assets:

* `Pricing_Intelligence.pbix`
* `Pricing_Intelligence.pdf`
* Tableau Workbook (`.twb`)
* Market Positioning Report (PDF)

---

# 🎯 Strategic Insights

* Mid-tier laptops exhibit **pricing inefficiency**, particularly in RAM upgrades where price increases exceed performance contribution
* Premium brands maintain pricing power despite lower value index → **brand-driven demand insulation**
* High-value configurations represent **underpriced opportunities**
* Market revenue is concentrated at the premium level, but **growth potential lies in optimized mid-range pricing**
* Clustering reveals **misaligned pricing segments across similar hardware tiers**

---

# 🧠 Strategic Recommendations

If deployed in a real-world pricing environment:

* Reduce mid-tier pricing (1–3%) to capture elastic demand
* Maintain premium pricing where brand strength offsets value inefficiency
* Increase price for high-value products currently underpriced
* Use Value Index as a **continuous pricing benchmark system**
* Apply elasticity modeling for controlled pricing experiments

---

# 🧪 QA & Validation

* Cross-tool reconciliation (SQL → Python → Power BI)
* KPI validation
* Data integrity validation reports
* Value index validation
* Revenue simulation assumptions testing
* QA checklist enforcement

**Model Version:** v3.0
**Status:** Validation Complete

---

# ⚠️ Assumptions & Constraints

* Static dataset
* Units sold are estimated
* Elasticity is modeled
* No seasonality modeling
* No external enrichment data

---

# 🛠️ Tools Used

* SQL (Data Transformation)
* Python (Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn)
* Jupyter Notebook
* Power BI (Dashboard + Simulation Engine)
* DAX (KPI logic)

---

# 💼 Business Impact

This model enables:

* Identification of pricing inefficiencies
* Revenue concentration analysis
* Strategic pricing optimization
* Scenario-based revenue forecasting
* Competitive positioning analysis

Applicable in:

* Consumer electronics pricing
* Retail analytics
* Revenue optimization
* Market strategy

---

# 📌 Project Status

✔ Data Transformation Complete

✔ Statistical Modeling Complete

✔ Regression Modeling Complete

✔ Clustering & Segmentation Complete

✔ Value Index Framework Complete

✔ Revenue Simulation Complete

✔ Elasticity Modeling Complete

✔ Dashboard Integration Complete

✔ QA & Governance Complete

---

# 🧾 Purpose

This project demonstrates **pricing intelligence engineering, analytical depth, and strategic business thinking**.

It is designed to reflect **production-level analytics capability**, not just dashboard creation.

---

## ✍️ Author

Kedar Raju Pawar
Data Analytics & Pricing Strategy Enthusiast
## License
This project is licensed under the MIT License.
