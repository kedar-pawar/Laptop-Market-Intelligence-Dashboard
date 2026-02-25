# Statistical Validation Summary

- **Project** : Laptop Price Analytics
- **Section** : Statistical Validation
- **Author** : Kedar Pawar
- **Date** : 25 Feb 2026

## 1. Objective

- To statistically validate key price drivers and confirm whether observed pricing patterns are supported by quantitative evidence.

- Specifically:

	- Measure strength of relationship between technical specifications and price.

	- Test whether average price differs significantly across CPU tiers.

## 2. Correlation Analysis

(Source: 01_price_driver_tests.ipynb) 

	### 2.1 Variables Tested

		- Price

		- ram_gb

		- total_storage_gb

		- cpu_tier_num (ordinal encoded CPU tier)

	#### 2.2 Pearson Correlation (Linear Relationship)
		- Variable	Correlation with Price
		- ram_gb	~0.78
		- cpu_tier_num	~0.76
		- total_storage_gb	~0.24
		- Interpretation

		- RAM shows strong positive linear association with price.

		- CPU tier also shows strong positive linear association.

		- Storage capacity shows weak-to-moderate linear impact.

		- Performance components dominate pricing structure.

	### 2.3 Spearman Correlation (Monotonic Relationship)
		- Variable	Correlation with Price
		- ram_gb	~0.78
		- cpu_tier_num	~0.76
		- total_storage_gb	~0.24
		- Interpretation

		- Similar magnitude in Spearman confirms relationships are monotonic.

		- Price increases consistently with higher RAM and CPU tiers.

		- Results are structurally stable (not driven by outliers alone).

	### 2.4 Distribution Observation

		- Price distribution is right-skewed.

		- Presence of high-end premium outliers.

		- Use of Spearman correlation is justified.

## 3. Segment Significance Testing (ANOVA)

- (Source: 02_segment_significance_tests.ipynb) 

	### 3.1 Hypotheses

		- H₀: Mean price is equal across all CPU tiers.
	
		- H₁: At least one CPU tier has a significantly different mean price.

	### 3.2 Group Sizes
		- CPU Tier	Count
		- High	    455
		- Upper-Mid	151
		- Mid	        117
		- Lower-Mid	115
		- Entry	    112

- Group sizes are sufficiently distributed for ANOVA testing.

	### 3.3 ANOVA Results

		- F-statistic: ≈ 186.31

		- p-value: ≈ 3.2 × 10⁻¹¹⁹

	### 3.4 Decision Rule

		- If p-value < 0.05 → Reject H₀

		- Since p-value << 0.05:

		- Reject the null hypothesis.

  	### 3.5 Interpretation

		- There is an extremely significant difference in average prices across CPU tiers.

		- Mean prices increase in a monotonic sequence:

		- Entry < Lower-Mid < Mid < Upper-Mid < High

		- The large F-statistic indicates substantial between-group variance relative to within-group variance.

## 4. Consolidated Findings

- CPU tier significantly influences laptop pricing.

- RAM and CPU tier are dominant pricing drivers.

- Storage capacity has secondary influence.

- Pricing segmentation is statistically validated.

- Observed market structure reflects performance-based price architecture.

## 5. Final Conclusion

- Statistical validation confirms that laptop pricing in this dataset is primarily structured around processor performance tier and memory configuration.

- Both correlation analysis and ANOVA testing provide strong evidence that:

- Pricing differences are not random.

- Product segmentation is structurally consistent.

- The dataset is statistically reliable for regression modeling and predictive pricing analysis.