Varejo-Nexus: Operational Performance &amp; Logistics Intelligence.

Overview

This project provides a comprehensive operational audit of a major Brazilian multi-vendor marketplace. By architecting an end-to-end data pipeline—from BigQuery warehousing to R statistical cleaning and Tableau visualization—I transformed over 100,000 raw transactional records into actionable business intelligence. The analysis focuses on three core pillars: Logistics Efficiency, Seller Quality, and Market Demand Trends.

The Business Challenge

As the marketplace scaled, stakeholders faced three critical "blind spots":

Logistics Bottlenecks: Unclear visibility into regional "Reliability Penalties" for cross-state shipping.
Seller Performance: A lack of a standardized system to rank vendors based on both volume and customer satisfaction.
Growth Forecasting: Difficulty in tracking how seller density affects consumer freight costs over time.


Methedology


1. Data Warehousing & Engineering (SQL/BigQuery)

Constructed 9 complex relational views to denormalize the database, linking Orders, Items, Sellers, Customers, and Reviews.
Engineered custom KPIs, including On-Time Rate %, Transit Lead Time, and Estimated vs. Actual Variance.
Implemented Safe Division and Conditional Logic (CASE statements) to ensure database-level consistency across all reporting.


2. Statistical Refining & Validation (R)

Utilized the tidyverse and lubridate libraries to standardize inconsistent UTC timestamps.
Outlier Management: Identified and removed "impossible" records (e.g., delivery dates preceding purchase dates).
Applied a 60-day transit cap to filter extreme outliers and warehouse errors, ensuring the final averages were statistically representative of typical operations.


3. Interactive Visualization (Tableau)

Logistics Health: A geospatial deep-dive into state-to-state corridors.

Key Insights & Impact

The Reliability Penalty: Discovered that inter-state shipments face a 15% higher delay rate compared to intra-state fulfillment, providing a data-backed case for regional distribution hubs.

Seller Scorecard: A multi-dimensional ranking system comparing Revenue vs. Review Scores.

Strategic Demand: A time-series analysis of category growth and shipping price pressure.

Efficiency Corridors: Identified specific "Expensive yet Slow" routes using a custom Cost-per-KM metric, highlighting regions ripe for carrier renegotiation.

Vendor Tiering: Isolated the top 5% of "Power Sellers" who maintain high volume with 4.5+ star ratings, while flagging "At-Risk" high-volume vendors with high lateness scores.


Tools Used

SQL (Google BigQuery): Data modeling and feature engineering.
R (RStudio): Statistical cleaning, outlier detection, and data validation.
Tableau: Executive dashboarding and geospatial storytelling.

To provide full transparency into the data pipeline and analytical process, all project resources are available for review. I encourage you to explore the live Tableau dashboards to test the interactive filters, tooltips, and regional drill-downs.

Live Interactive Dashboards (Tableau Public):

Logistics Risk & Delivery Performance  |
( https://public.tableau.com/views/logisticsriskanddeliveryperformance/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link )— A geospatial audit of shipping reliability and regional bottlenecks.
Seller Performance & Quality Audit 
( https://public.tableau.com/views/SellerPerformanceandQualityAudit/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link ) — An operational scorecard ranking vendors by volume, revenue, and customer sentiment.
Market Strategic Growth Trends 
( https://public.tableau.com/views/ActiveSellersMonthlyTrendvsFreightCost/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link ) — A time-series analysis of seller density versus freight cost pressure.

