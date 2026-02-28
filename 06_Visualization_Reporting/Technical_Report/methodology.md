# Pricing Intelligence Model – Technical Methodology

**Project:** Competitive Laptop Pricing Intelligence Model  
**Author:** Kedar Raju Pawar  
**Year:** 2026  

---

## 1. Project Objective

To develop a structured, data-driven pricing intelligence framework capable of:

- Measuring brand-level revenue concentration
- Quantifying product-level value efficiency
- Classifying strategic pricing positions
- Simulating revenue sensitivity under controlled pricing adjustments

---

## 2. Data Architecture

### 2.1 Source Dataset

The dataset consists of multi-brand laptop product records including:

- Brand
- Model Name
- Price (₹)
- Estimated Units Sold
- Processor Benchmark Score
- RAM Capacity (GB)
- Storage Type
- Graphics Specification

The dataset was used in Power BI for analytical modeling and Tableau for strategic narrative visualization.

---

### 2.2 Data Preparation

The following preprocessing steps were performed:

- Null value validation
- Outlier inspection for extreme price distortions
- Standardization of numeric price fields
- Revenue validation against aggregated brand totals
- Creation of calculated columns and measures

---

## 3. Revenue Modeling Framework

### 3.1 Product-Level Revenue

Revenue was calculated as:

Revenue = Estimated Units Sold × Price

Brand-level revenue was derived through aggregation.

**Total Market Revenue Observed:** ₹1.488 Trillion

---

### 3.2 Market Share Calculation

Market Share (%) = Brand Revenue / Total Market Revenue

This enabled revenue concentration and dominance analysis.

---

## 4. Performance Scoring Model

A weighted composite performance score was developed to quantify product capability.

### 4.1 Performance Components

- Processor Benchmark Score
- RAM Capacity
- Storage Configuration (SSD/HDD weighting)
- Graphics Capability

Each component was weighted proportionally to reflect relative impact on consumer purchasing decisions.

---

### 4.2 Performance Score Formula

Performance Score =  
(W1 × Processor) +  
(W2 × RAM) +  
(W3 × Storage) +  
(W4 × Graphics)

Weights were normalized for comparability across products.

---

## 5. Value Index Computation

Value Index = Performance Score / Price

This metric measures performance delivered per unit price.

Products were segmented into:

- High Value
- Balanced
- Low Value

Segmentation thresholds were derived using percentile-based distribution logic.

**High Value Share Observed:** 31.6% of product portfolio.

---

## 6. Strategic Market Positioning Framework

Brand positioning was determined using a two-dimensional competitive matrix:

- **X-axis:** Average Price
- **Y-axis:** Total Revenue

Median reference lines were applied to classify brands into four quadrants.

### 6.1 Quadrant Definitions

| Quadrant | Interpretation |
|-----------|----------------|
| Premium Leaders | High Price + High Revenue |
| Value Volume Leaders | Lower Price + High Revenue |
| Weak Premium | High Price + Low Revenue |
| Low Impact | Low Revenue + Low Price |

This classification supports structured pricing interpretation.

---

## 7. Pricing Elasticity Simulation

A dynamic pricing simulator was implemented to evaluate revenue sensitivity under controlled price adjustments.

### 7.1 Adjustment Scenario

- ±3% pricing variation applied
- Unit adjustments modeled using elasticity assumptions

### 7.2 Simulation Logic

Adjusted Price = Price × (1 + Adjustment %)

Adjusted Units = Units × (1 + Elasticity × Adjustment %)

Adjusted Revenue = Adjusted Price × Adjusted Units

### 7.3 Observed Impact

At +3% price adjustment:

- Simulated Revenue ≈ ₹1.444 Trillion
- Revenue Variation ≈ -4.6%

Implied elasticity coefficient ≈ -1.5 (moderately elastic demand).

---

## 8. Dashboard KPIs Implemented

The analytical model included the following KPIs:

- Total Revenue
- Average Selling Price
- Market Share (%)
- High Value Share (%)
- Average Value Index
- Simulated Revenue
- Revenue Impact (%)

These KPIs supported executive-level strategic interpretation.

---

## 9. Limitations

- Units sold are modeled estimates, not transactional sales data.
- Elasticity coefficient is assumption-based.
- Regional segmentation was not included.
- Seasonality and promotional effects were excluded.

---

## 10. Tools Used

- Power BI (Analytical engine & scenario modeling)
- DAX (KPI and simulation logic)
- Tableau (Strategic narrative visualization)
- CSV dataset processing

---

## 11. Strategic Application

The Pricing Intelligence Model enables:

- Revenue concentration detection
- Identification of underpriced high-value opportunities
- Premium pricing sustainability analysis
- Data-backed pricing experimentation

This framework provides a structured foundation for pricing optimization and competitive strategy modeling.