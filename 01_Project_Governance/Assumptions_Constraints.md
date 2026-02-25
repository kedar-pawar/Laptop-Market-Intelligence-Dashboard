# Assumptions & Constraints  
## Laptop Price Analytics & Value Modeling Framework

---

## 1. Purpose

This document outlines the key assumptions made during the development of the project and the practical constraints that influence analytical interpretation.

Clearly defining these factors ensures transparency and prevents overstatement of results.

---

## 2. Assumptions

The following assumptions were made during the project:

### 2.1 Data Representation

- The dataset reasonably represents a segment of the laptop market.
- The configurations included are reflective of common consumer offerings.
- Recorded prices reflect actual market positioning.

---

### 2.2 Hardware Hierarchy

- CPU and GPU tiers represent meaningful performance differences.
- Higher-tier hardware corresponds to higher performance capability.
- RAM and storage increases contribute positively to performance perception.

---

### 2.3 Pricing Logic

- Laptop price is influenced primarily by hardware specifications.
- Non-listed attributes (brand perception, marketing, warranty, build quality) are secondary and not modeled.
- Price variations reflect configuration differences rather than data entry errors (after validation).

---

### 2.4 Statistical Modeling

- Relationships between hardware features and price are sufficiently stable for regression analysis.
- Clustering can reveal meaningful segmentation patterns.
- Composite scoring weights reasonably approximate performance contribution.

---

## 3. Constraints

The following constraints limit the analysis:

### 3.1 Data Constraints

- Static dataset (no live or real-time updates).
- No external enrichment sources.
- No time-series data to analyze price trends.
- Sample size limited to provided records.

---

### 3.2 Feature Constraints

- No benchmarking scores (e.g., performance test metrics).
- No battery performance data.
- No durability or build-quality indicators.
- No customer review or demand data.

---

### 3.3 Modeling Constraints

- Regression model explains relationships but does not guarantee causation.
- Clustering results depend on selected features and scaling approach.
- Composite value scoring depends on chosen weight distribution.

---

### 3.4 Business Constraints

- Insights are analytical, not prescriptive.
- Results are based solely on dataset attributes.
- External market dynamics are not considered.

---

## 4. Risk Considerations

- Overfitting risk if too many derived features are used.
- Potential bias if dataset is not fully market-representative.
- Scoring framework subject to subjective weighting decisions.

---

## Version

Current Version: v1.0  
Last Updated: 2026-02-23