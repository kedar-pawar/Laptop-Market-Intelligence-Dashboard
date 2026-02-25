# Regression Modeling Summary

# Project: Laptop Price Analytics
- Phase: Controlled Impact Analysis
- Author: Kedar Pawar
- Date: 25 Feb 2026

## 1. Objective

    - To quantify the controlled numerical impact of hardware specifications and brand positioning on laptop prices using multiple linear regression.

    - Core Question:

        - Holding all other variables constant, which features increase laptop price — and by how much?

## 2. Model Specification

    -  Algorithm: Multiple Linear Regression

    - Target Variable: Price

    - Total Features Used: 32

    - Dataset Size: 1000 observations

    - Train/Test Split: 80/20

    - Categorical variables (e.g., Brand) were one-hot encoded.
    - CPU tier treated as numeric ordinal.

## 3. Model Performance

    - (From 03_model_evaluation_metrics.ipynb) 


    - Test Set Metrics

    - R² ≈ 0.536

    - MAE ≈ ₹14,869

    - RMSE ≈ ₹22,086

    - Interpretation

    - The model explains approximately 53% of variation in laptop prices using hardware and brand features.

    - On average, predictions deviate by ₹14,869 from actual market price.

    - Larger pricing errors (captured by RMSE) indicate presence of premium outliers or brand-driven price gaps not fully explained by technical specifications.

    - The model demonstrates moderate explanatory power and captures structural pricing drivers, though brand premiums introduce complexity.

## 4. Feature Impact Analysis

    - (From 02_feature_importance_analysis.ipynb) 


    - Below are the most influential coefficients (sorted by magnitude).

## 4.1 Strong Positive Brand Premiums
    - Feature	Coefficient (₹)	Interpretation
        - Company_RAZER	+89,490	Extremely strong premium positioning
        - Company_LG	+35,672	High brand premium
        - Company_MICROSOFT	+25,058	Significant premium
        - Company_MSI	+21,256	Gaming/performance premium
        - Company_APPLE	+20,177	Premium brand positioning

    - Interpretation:

        - Certain brands command substantial price premiums independent of hardware specifications.

## 4.2 Core Hardware Drivers
    - Feature	Coefficient	Interpretation
    - cpu_tier	+5,910	Each tier increase raises price by ~₹5,910
    - ram_gb	+2,844	Each additional 1GB RAM increases price by ~₹2,844
    - is_touchscreen	+3,774	Touchscreen models command ~₹3,774 premium
    - weight_kg	+14,152	Heavier systems associated with higher pricing
    - clock_speed_ghz	+2,519	Faster CPU clocks moderately increase price

    - These variables represent structural performance-based pricing drivers.

## 4.3 Secondary or Minor Effects
    - Feature	Coefficient	Interpretation
    - total_storage_gb	+17	Marginal storage impact (overlapping variables present)
    - ssd_gb	+19	Small incremental SSD impact
    - display_resolution_width	+15	Minor resolution impact
    - display_resolution_height	-2	Negligible effect
    - hdd_gb	-20	Slight negative impact (possible budget storage effect)

    - Storage-related variables show diluted impact due to multicollinearity among total, SSD, HDD, flash, and hybrid storage fields.

## 4.4 Negative Brand Effects (Budget Positioning)
    - Feature	Coefficient	Interpretation
    - Company_CHUWI	-6,599	Discount brand positioning
    - Company_XIAOMI	-938	Slight discount relative to baseline

    - Indicates structured budget segmentation in the market.

## 5. Structural Observations

    - Brand positioning is the dominant controlled pricing factor.

    - CPU tier and RAM are primary technical drivers.

    - Touchscreen adds moderate premium.

    - Storage effects are fragmented due to overlapping feature inclusion.

    - Model captures core market logic but does not fully explain luxury-tier brand premiums.

## 6. Final Conclusion

    - The regression model successfully quantifies controlled price impacts.

    - Key findings:

    - Premium brands significantly increase laptop prices independent of hardware.

    - Each CPU tier upgrade increases price by approximately ₹5,910.

    - Each additional 1GB RAM increases price by approximately ₹2,844.

    - The model explains 53% of total price variation.

    - This confirms that laptop pricing follows a structured combination of:

    - Brand equity

    - Performance architecture

    - Feature-level enhancements

    - The regression phase upgrades statistical validation ("Is it significant?") into quantified business insight ("How much does it move price?").