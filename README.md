# 💻 Laptop Market Intelligence Dashboard — SQL, Python & Power BI

## 📌 Project Overview
This project is an end-to-end Data Analyst pipeline built on a real laptop specifications dataset (1300+ records).  
The goal is to transform raw product data into decision-ready insights using SQL, Python, Excel, and Power BI.

The project demonstrates real analyst workflow:
Database ingestion → SQL cleaning → Python feature engineering → Excel QA → Power BI dashboarding.

---

## 🎯 Objectives
- Clean and standardize messy product specification data
- Extract structured features from text fields (CPU, Memory, RAM, Weight)
- Engineer performance and price segmentation metrics
- Analyze brand, hardware, and pricing patterns
- Build an interactive decision dashboard

---

## 🧰 Tech Stack

- **MySQL** — raw data storage & SQL transformations
- **Python (pandas, numpy, matplotlib)** — parsing & feature engineering
- **Excel** — validation & quick QA checks
- **Power BI** — interactive dashboard & KPI modeling

---

## 📂 Dataset Features

Columns included:

- Company
- TypeName
- Screen Size (Inches)
- Screen Resolution
- CPU
- RAM
- Memory (SSD/HDD mixed text)
- GPU
- Operating System
- Weight
- Price

Records: **1300+ laptops**

---

## 🧹 Data Cleaning Performed

### SQL Cleaning
- Removed unit text from RAM and Weight
- Created derived fields:
  - CPU_Brand
  - CPU_Tier
- Built cleaned table separate from raw table

### Python Processing
- Parsed Memory column into:
  - SSD size
  - HDD size
  - Storage flags
- Extracted CPU tiers from CPU text
- Converted TB → GB where required
- Built derived metrics:
  - Price Segment (Budget / Mid / Premium)
  - Performance Score

### Excel QA
- Duplicate checks
- Null scans
- Spot validation using Pivot Tables

---

## 🧠 Feature Engineering

Created analytical columns:

- CPU_Brand (Intel / AMD)
- CPU_Tier (i3 / i5 / i7 / Ryzen etc.)
- Has_SSD / Has_HDD
- Storage_GB_Total
- Price_Segment
- Performance_Score

---

## 📊 Analysis Questions Answered

- Which brands dominate each price segment?
- Do higher RAM laptops always cost more?
- SSD vs HDD — price impact
- Gaming vs Ultrabook — price comparison
- Brand value vs performance score
- Weight vs screen size tradeoffs
- Best value laptops by price/performance ratio

---

## 📈 Dashboard KPIs

- Average Price
- Average RAM
- Model Count
- SSD Share %
- Price Segment Distribution
- Brand Avg Price
- CPU Tier Distribution

---

## 🎛️ Dashboard Features (Power BI)

- Brand comparison visuals
- Price vs Performance scatter
- Category share charts
- CPU tier distribution
- OS market share
- Interactive slicers:
  - Brand
  - Type
  - RAM
  - CPU Tier
  - Price Segment

---

## 🏗️ Project Pipeline

Raw CSV  
→ MySQL Raw Table  
→ SQL Cleaning & Derived Columns  
→ Python Parsing & Feature Engineering  
→ Excel Validation  
→ Power BI Dashboard

---

## 🚀 Key Learning Outcomes

- Text-to-structured feature extraction
- SQL + Python hybrid cleaning workflow
- Derived metric engineering
- Analyst-style KPI modeling
- Dashboard usability design
- Decision-oriented visualization

---

## 🔮 Future Improvements

- Add live e-commerce price feeds
- Time-series price tracking
- ML price prediction model
- Automated ETL pipeline

---

## 📬 Author
Kedar Raju Pawar
Data Analyst | SQL | Python | Power BI

## 📄 License
This project is released under the MIT License.
