# Change Log  
## Laptop Price Analytics & Value Modeling Framework

- This document records significant structural, analytical, and methodological updates to the project.

- Only meaningful changes affecting transformation logic, modeling approach, scope, or architecture are documented.

---

## Version History

| Version | Date       | Description                                                                                                           | Impact Area                             |
| ------- | ---------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| v1.0    | 2026-02-13 | Initial SQL cleaning pipeline created. Raw table duplicated and structural validation performed.                      | Data Transformation                     |
| v1.1    | 2026-02-13 | Implemented resolution parsing (width, height), touchscreen flag, resolution classification.                          | Feature Engineering                     |
| v1.2    | 2026-02-14 | Added CPU brand, family, model extraction, clock speed parsing, CPU tier classification.                              | Feature Engineering                     |
| v1.3    | 2026-02-14 | Implemented storage parsing (SSD/HDD/Flash/Hybrid), TB-to-GB standardization, total_storage_gb derivation.            | Feature Engineering                     |
| v1.4    | 2026-02-15 | Added RAM normalization (ram_gb), weight extraction (weight_kg), weight_class categorization.                         | Data Normalization                      |
| v1.5    | 2026-02-15 | Introduced price_band classification and price outlier detection using ±2 STDDEV threshold.                           | Business Logic                          |
| v1.6    | 2026-02-16 | Added duplicate detection logic with composite hardware key and ROW_NUMBER ranking.                                   | Data Integrity                          |
| v1.7    | 2026-02-16 | Implemented suspect_flag and weighted data_quality_score framework.                                                   | Data Quality Engineering                |
| v1.8    | 2026-02-17 | Created analytics_master_dataset as model-ready structured table.                                                     | Data Modeling                           |
| v1.9    | 2026-02-18 | Conducted structured EDA including price-tier analysis, brand spread, and storage segmentation.                       | Exploratory Analytics                   |
| v2.0    | 2026-02-23 | Reorganized project into governance-based layered architecture (Data, Modeling, Analytics, Business).                 | Project Architecture                    |
| v2.1    | 2026-02-25 | Implemented statistical validation (Correlation + ANOVA testing of CPU tier pricing impact).                          | Statistical Validation                  |
| v2.2    | 2026-02-25 | Developed Multiple Linear Regression model (32 features, R² ≈ 0.536) with quantified hardware & brand pricing impact. | Controlled Impact Modeling              |
| v2.3    | 2026-02-25 | Implemented dual K-Means clustering (Hardware-based & Market-based segmentation, K=3).                                | Market Segmentation                     |
| v2.4    | 2026-02-26 | Designed Composite Performance Score (weighted scoring model with MinMax normalization).                              | Scoring Framework                       |
| v2.5    | 2026-02-26 | Introduced Value Index Model (Performance / Price) with percentile-based segmentation logic.                          | Value Modeling                          |
| v2.6    | 2026-02-26 | Built Recommendation Engine with budget filtering and what-if hardware upgrade simulation.                            | Decision Intelligence                   |
| v2.7    | 2026-02-27 | Implemented Revenue Simulation logic (Units ∝ Value Index) and brand-level market share modeling.                     | Revenue Modeling                        |
| v2.8    | 2026-02-28 | Developed Pricing Strategy Insights (Pricing Gap = Value Rank − Price Rank).                                          | Strategic Analytics                     |
| v2.9    | 2026-02-28 | Integrated Pricing Elasticity Simulation (±3% scenario; ~4.6% revenue sensitivity observed).                          | Scenario Simulation                     |
| v3.0    | 2026-02-28 | Completed Cross-Platform Validation (SQL, Python, Excel, Power BI) and QA framework documentation.                    | Model Validation & Production Readiness |

## Versioning Policy

- Minor transformation or feature addition → Increment minor version (v1.x).
- New analytical module or major logic expansion → Increment minor version.
- Structural redesign, scope shift, or architecture reorganization → Increment major version (v2.0).

---

## Current Version

Current Version: v2.0  
Last Updated: 2026-02-23