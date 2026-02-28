# REVENUE_SIMULATION_ASSUMPTIONS
**Project**: Competitive Laptop Pricing Intelligence Dashboard  
**Phase**: Testing & Validation (07)  
**Prepared By**: Kedar Raju Pawar  
**Date**: February 28, 2026  
**Dataset Reference**: analytics_master_dataset  
**Model Version**: v1.0  
**Status**: *Validation Complete

---

**Purpose:** Document assumptions behind simulated revenue logic.

---

## 🎯 Why Revenue Is Simulated

This project models strategic pricing behavior.

Revenue is estimated using:

estimated_revenue = Price × estimated_units_sold

Since real sales data is unavailable, unit volumes are simulated proportionally using:

- Brand share
- Value segment influence
- Relative competitiveness

---

# 📌 Core Assumptions

1️⃣ Higher value index → higher simulated units  
2️⃣ Premium brands can sustain lower value efficiency  
3️⃣ Portfolio breadth impacts aggregate revenue  
4️⃣ No external market shocks modeled  

---

# 🔎 Validation Checks

- Revenue totals aggregated correctly
- No negative revenue
- Segment-level revenue aligns with brand positioning
- Premium brands show revenue despite lower value index

---

# ⚠ Limitations

- No real demand elasticity
- No supply constraints
- No time-series forecasting
- No marketing spend variable

---

# ✅ Model Integrity

Simulation assumptions are transparent, documented, and logically consistent.

Revenue modeling is internally valid within defined assumptions.