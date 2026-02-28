# Revenue Modeling & Market Share Analysis


**Done By:** Kedar Raju Pawar  
**Date:** 2026-02-25  
**Time:** 17:56:00  

---

## Objective of This Section

This section focuses specifically on **Revenue Simulation and Brand
Contribution Analysis**.\
It does not cover the full project lifecycle --- only the revenue
modeling logic and insights derived from it.

------------------------------------------------------------------------

## 1. Volume Simulation

Estimated unit sales were simulated to model realistic sales
distribution across laptop brands.

Purpose: - Create scalable revenue estimation - Compare brand
performance under uniform simulation logic - Enable contribution
analysis

------------------------------------------------------------------------

## 2. Dataset Summary

The dataset contains the following attributes:

- **Company**
- **Estimated Units Sold**
- **Estimated Revenue (₹)**
- **Market Share (%)**
- **High Value %**
- **Average Value Index %**

------------------------------------------------------------------------

## 3. Revenue Estimation Logic

Revenue was calculated using:

    Estimated Revenue = Estimated Units Sold × Price

Simulated volume was used to estimate units sold for each brand.

------------------------------------------------------------------------

## 4. Brand Revenue Summary

  Brand    Estimated Units Sold   Estimated Revenue (₹)    Market Share
  -------- ---------------------- ------------------------ --------------
  ACER     2,334,016              ₹ 75,75,80,07,788.77     9.24%
  APPLE    383,626                ₹ 32,35,71,82,211.68     1.52%
  ASUS     3,206,028              ₹ 1,71,19,22,92,608.27   12.69%
  DELL     5,850,990              ₹ 3,54,74,30,97,426.25   23.16%
  HP       4,764,519              ₹ 2,43,23,75,55,512.25   18.86%
  LENOVO   5,864,160              ₹ 3,06,95,32,04,816.85   23.22%

*Top Market Leaders:* Lenovo and Dell dominate overall revenue share.

------------------------------------------------------------------------

## 5. High Value Segment Analysis

Brands with notable High Value percentage:

- FUJITSU -- 100%
- ACER -- 63.10%
- LENOVO -- 40.87%
- DELL -- 34.18%
- HP -- 31.89%
- ASUS -- 26.98%

Insight: Premium positioning does not always correlate directly with
total revenue dominance.

------------------------------------------------------------------------

## 6. Key Insights

1.  Lenovo holds the highest overall market share.
2.  Dell closely follows with strong revenue generation.
3.  HP and ASUS maintain strong mid-to-high positioning.
4.  Fujitsu shows 100% high-value positioning but lower total volume.
5.  Apple shows premium revenue but lower volume contribution compared
    to leaders.

------------------------------------------------------------------------

## 7. Tools & Technologies

- Python (Revenue simulation)
- Pandas (Data manipulation)
- Power BI (Visualization & KPI dashboards)
- DAX (KPI calculations)
- Market share modeling techniques

------------------------------------------------------------------------

## 8. Business Conclusion

The revenue modeling demonstrates that: - Volume leadership
significantly impacts total revenue share. - Premium-only positioning
(e.g., Fujitsu) limits overall market dominance. - Balanced strategy
(volume + value) drives sustainable competitive advantage.

This analysis can support pricing strategy, portfolio optimization, and
competitive benchmarking.

------------------------------------------------------------------------

End of Technical Report
