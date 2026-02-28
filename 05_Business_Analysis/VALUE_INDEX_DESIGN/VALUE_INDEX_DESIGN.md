# VALUE_INDEX_DESIGN

**Done By:** Kedar Raju Pawar  
**Date:** 28-02-2026  
**Time:** 16:00 IST  

---

## 1️⃣ Objective

To design a quantitative **Value Index Model** that evaluates laptop brands based on performance efficiency relative to price.

The goal is to move beyond raw revenue and identify:
- Which brands deliver better value?
- Which brands are overpriced?
- How brands cluster into business value segments?

---

## 2️⃣ Methodology

### Step 1: Feature Selection

Relevant features used:
- Performance Score
- Price

These variables represent product capability and customer cost respectively.

---

### Step 2: Value Index Formula

\[
Value\ Index = \frac{Performance\ Score}{Price}
\]

This ratio reflects **performance per unit price**.

Higher value_index → Better value for money  
Lower value_index → Lower efficiency relative to price  

---

## 3️⃣ Business Bucket Creation

Value index was segmented into 3 categories:

- 🔴 Low Value
- 🟡 Balanced
- 🟢 High Value

This enables business-level interpretation instead of only numerical comparison.

---

## 4️⃣ Brand-Level Insights

### Average Value Index by Brand

| Brand | Avg Value Index |
|--------|----------------|
| FUJITSU | 1.4185E-05 |
| ACER | 1.28545E-05 |
| LENOVO | 1.10062E-05 |
| HP | 1.08235E-05 |
| DELL | 1.02543E-05 |
| ASUS | 1.00052E-05 |
| TOSHIBA | 9.82079E-06 |
| XIAOMI | 9.37894E-06 |
| VERO | 9.33244E-06 |
| MSI | 7.73888E-06 |
| SAMSUNG | 7.61162E-06 |
| CHUWI | 7.50781E-06 |
| MEDIACOM | 7.40752E-06 |
| MICROSOFT | 7.3444E-06 |
| HUAWEI | 8.25015E-06 |
| LG | 6.09434E-06 |
| APPLE | 6.60013E-06 |
| GOOGLE | 5.91671E-06 |
| RAZER | 4.68517E-06 |

---

## 5️⃣ Key Observations

- FUJITSU delivers the highest value efficiency.
- ACER and LENOVO show strong value positioning.
- Premium brands like APPLE and RAZER show lower value index — indicating premium pricing strategy.
- The market shows clear stratification across value tiers.

---

## 6️⃣ Business Impact

This Value Index model helps:

- Identify underpriced high-performance brands
- Detect premium pricing strategies
- Support pricing optimization
- Enable segmentation analysis in Power BI
- Strengthen revenue modeling logic

---

## 7️⃣ Deliverables

- value_index_design.ipynb
- value_index_model_ready.csv
- Value_Index_Output_V0.xlsx
- Business bucket classification
- Brand-level performance comparison

---

## 8️⃣ Conclusion

The Value Index framework transforms raw pricing and performance data into strategic insight.

It bridges:
Data Engineering → Business Intelligence → Strategic Pricing Decisions

This model can be extended into:
- Revenue-weighted value scoring
- Market competitiveness modeling
- What-if pricing simulations
