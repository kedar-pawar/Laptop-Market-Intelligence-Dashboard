# Scope Definition  
## Laptop Price Analytics & Value Modeling Framework

---

## 1. Scope Purpose

This document defines the boundaries of the Laptop Price Analytics project to ensure clarity of objectives, controlled execution, and focused analytical development.

It outlines what is included in the project and what is intentionally excluded.

---

## 2. In Scope

The following components are included within the project scope:

### 2.1 Data Management

- Use of provided laptop configuration dataset.
- Preservation of raw dataset for traceability.
- Creation of structured interim dataset via SQL transformation.
- Generation of model-ready processed dataset.

---

### 2.2 Data Transformation

- Column auditing and structural validation.
- Parsing of CPU, GPU, RAM, storage, and display attributes.
- Price validation and integrity checks.
- Duplicate detection and quality control.

---

### 2.3 Feature Engineering

- Creation of numeric hardware attributes.
- Tier classification (CPU tier, GPU tier, storage tier).
- Computation of derived metrics (e.g., total storage).
- Development of composite value scoring framework.

---

### 2.4 Statistical & Analytical Modeling

- Exploratory Data Analysis (EDA).
- Regression modeling to identify price drivers.
- Clustering analysis for segmentation.
- Hypothesis-driven validation of pricing relationships.

---

### 2.5 Business Analysis

- Identification of budget vs premium segments.
- Value ranking of configurations.
- Scenario-based budget optimization analysis.
- Strategic price vs performance positioning insights.

---

### 2.6 Reporting & Visualization

- Executive-level summary insights.
- Technical documentation of methodology.
- Dashboard-based visual analysis (if applicable).

---

## 3. Out of Scope

The following are explicitly excluded from this project:

- Real-time data ingestion or streaming.
- External market benchmarking or competitor data.
- Time-series trend modeling.
- Consumer behavior or demand modeling.
- Deployment as a live web application or API.
- Automated production pipelines.

---

## 4. Boundaries & Limitations

- Analysis is limited to attributes present in the dataset.
- Market representation depends on dataset completeness.
- Insights are static and not dynamically updated.
- No external performance benchmarking metrics are used.

---

## 5. Scope Control

Any major expansion of:
- Data sources,
- Modeling approach,
- Deployment strategy, or
- Business objective

would require formal scope revision and version update.

---

## Version

Current Version: v1.0  
Last Updated: 2026-02-23