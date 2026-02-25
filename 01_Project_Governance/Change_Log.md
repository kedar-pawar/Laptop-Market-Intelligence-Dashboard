# Change Log  
## Laptop Price Analytics & Value Modeling Framework

This document records significant structural, analytical, and methodological updates to the project.

Only meaningful changes affecting transformation logic, modeling approach, scope, or architecture are documented.

---

## Version History

| Version | Date | Description | Impact Area |
|----------|------------|-------------|-------------|
| v1.0 | 2026-02-13 | Initial SQL cleaning pipeline created. Raw table duplicated and structural validation performed. | Data Transformation |
| v1.1 | 2026-02-13 | Implemented resolution parsing (width, height), touchscreen flag, resolution classification. | Feature Engineering |
| v1.2 | 2026-02-14 | Added CPU brand, family, model extraction, clock speed parsing, CPU tier classification. | Feature Engineering |
| v1.3 | 2026-02-14 | Implemented storage parsing (SSD/HDD/Flash/Hybrid), TB-to-GB standardization, total_storage_gb derivation. | Feature Engineering |
| v1.4 | 2026-02-15 | Added RAM normalization (ram_gb), weight extraction (weight_kg), weight_class categorization. | Data Normalization |
| v1.5 | 2026-02-15 | Introduced price_band classification and price outlier detection using statistical thresholds. | Business Logic |
| v1.6 | 2026-02-16 | Added duplicate detection logic and composite hardware specification key. | Data Integrity |
| v1.7 | 2026-02-16 | Implemented suspect_flag and data_quality_score framework. | Data Quality |
| v1.8 | 2026-02-17 | Created New Processed Dataset from cleaned laptop dataset. | Data modelling |
| v1.9 | 2026-02-17 | Conducted structured EDA including price-tier analysis, brand spread, storage buckets, and segmentation insights. | Analytics Development |
| v2.0 | 2026-02-23 | Reorganized project into governance-based layered architecture (Data Management, Transformation, Analytics, Business). | Project Architecture |

---

## Versioning Policy

- Minor transformation or feature addition → Increment minor version (v1.x).
- New analytical module or major logic expansion → Increment minor version.
- Structural redesign, scope shift, or architecture reorganization → Increment major version (v2.0).

---

## Current Version

Current Version: v2.0  
Last Updated: 2026-02-23