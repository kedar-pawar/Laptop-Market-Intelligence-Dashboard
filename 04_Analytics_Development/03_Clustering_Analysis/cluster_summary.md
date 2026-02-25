# Cluster Summary Report

- **Project**: Laptop Price & Market Analytics
- **Module**: Clustering Analysis
- **Author**: Kedar Raju Pawar
- **Date**: 25-Feb-2026

## 1️ Objective

- The goal of clustering analysis was to:

- Identify natural product segments based on hardware specifications

- Evaluate whether pricing aligns with technical capabilities

- Compare hardware-based vs market-based segmentation

- Extract actionable business insights

- Two clustering strategies were applied:

- Hardware-Based Clustering (Excluding Price)

- Market-Based Clustering (Including Price)

## 2️ Methodology
- Preprocessing

- Converted CPU tier into ordered numeric scale

- Encoded touchscreen as binary

- Created SSD indicator variable

- Standardized features using StandardScaler

- Model Used

- KMeans Clustering

- Optimal K selected using:

- Elbow Method

- Silhouette Score

- Final selection: K = 3 Clusters

## 3 Hardware-Based Clustering (Technical Segmentation)

- Price excluded
- Focus: Raw specifications only

- Features Used:

    - RAM (GB)

    - Total Storage (GB)

    - CPU Tier (numeric)

    - SSD Indicator

    - Screen Size

    - Weight

    - Touchscreen

##  Cluster Profiles (Hardware Perspective)
### Cluster 0 – Premium Touch Ultrabooks

- High CPU Tier

- Balanced RAM

- SSD-dominant

- 100% Touchscreen penetration

- Lightweight design

- Interpretation:
- Premium ultrabooks emphasizing portability + user experience + high-end performance.

### Cluster 1 – Storage-Focused Productivity

- Highest average storage capacity

- Strong CPU tier

- Moderate RAM

- Minimal touchscreen presence

- Interpretation:
- Performance laptops optimized for storage-heavy workloads (developers, analysts, business users).

### Cluster 2 – Entry-Level Budget

- Lowest RAM

- Lowest CPU tier

- Moderate storage

- No touchscreen presence

- Interpretation:
- Cost-sensitive segment prioritizing affordability over premium features.

### 4️ Market-Based Clustering (Price-Driven Segmentation)

- Price included
-  Focus: Market positioning

- Market Segment Profiles
- Premium Segment

- Highest average price (~₹76K)

- Strong CPU tier

- Balanced RAM

- 100% touchscreen ratio

- Insight:
    - Premium pricing strongly correlates with touchscreen capability and brand positioning — not just raw hardware.

#### Mid-Range Segment

- Moderate average price (~₹67K)

- Strong CPU tier

- Highest storage

- Very low touchscreen penetration

- Insight:
    - Performance-focused laptops priced competitively.

#### Budget Segment

- Lowest average price (~₹49K)

- Low RAM & CPU tier

- No touchscreen presence

- Insight:
    - Pure value-driven segment targeting cost-conscious buyers.

### 5️ Hardware vs Market Segmentation Comparison

- Cross-tabulation analysis shows:

- Hardware identity ≠ Perfect price alignment

- Some similar hardware configurations exist across different price tiers

- Design features (touchscreen, portability) significantly influence pricing

- Key Observation:

    - Market clustering shows strong price separation.
    - Hardware clustering reveals deeper technical differentiation.

- This indicates that:

    - Pricing is influenced by:

        - Brand value

        - User experience features

        - Design positioning

        - Perceived premium quality

        - Not only by raw hardware specifications.

### 6️ Strategic Business Insights
 - The laptop market is structured into clear economic tiers.
 - Premium pricing is experience-driven, not purely spec-driven.
 - Storage-heavy machines are positioned in mid-range productivity space.
 - Entry-level machines compete primarily on affordability.
### 7️ Final Conclusion

- Both clustering approaches together provide:

    - A technical understanding of product differentiation

    - A market positioning perspective

    - A holistic view of how hardware translates into pricing

- This dual-clustering framework enables:

    - Smarter product positioning

    - Competitive benchmarking

    - Better pricing strategy decisions

    - Feature prioritization based on market demand