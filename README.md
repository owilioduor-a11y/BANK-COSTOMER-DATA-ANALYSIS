## **Banking Portfolio & Risk Intelligence Dashboard**.

An end-to-end data analytics project using python(pandas & numpy), PostgreSQL and Power BI. This repository features a 4-page interactive dashboard designed to monitor liquidity, assess credit risk exposure, evaluate Relationship Manager performance, and map global wealth distribution for a retail banking institution.

 **Project Overview**
An end-to-end data pipeline and BI solution designed to analyze customer liquidity, credit risk, and manager performance for a retail banking institution.
   ## Technical Stack
Data Cleaning: Python (Pandas, NumPy)
Database: PostgreSQL
Data Visualization: Power BI (DAX, Power Query)                                                               **Workflow & Implementation**
1. **Data Preprocessing (Python)**
Handling Nulls: Used Pandas to identify and impute missing values in estimated_income and credit_score.
Data Consistency: Standardized occupation and nationality strings using .str.strip() and .title().
Outlier Detection: Utilized NumPy to flag anomalies in bank_deposits and credit_card_balance using Z-scores.
Type Casting: Ensured all financial columns were converted to float64 for mathematical accuracy.

**2.Database Management (PostgreSQL)**
Schema Design: Created a structured banking schema for client demographics and financial balances.
Aggregation: Developed SQL queries using ROUND(), GROUP BY, and CAST(::numeric) for clean data ingestion.
Key Queries: Calculated average cards per person, group-level debt, and cohort-based wealth metrics.

**3. BI & Analytics (Power BI)**
Data Modeling: Established relationships between demographics and financial tables.
Calculated Columns:  Total Liquidity: [checking] + [savings]
                     Total Liabilities: [loans] + [credit_card] + [business_lending]
                     Risk Labels: Categorized risk_weighting (1-5) into "Low" to "Critical" text labels.        DAX Measures:
Debt-to-Asset Ratio: Using DIVIDE to handle zero-denominator errors.
MoM Growth %: Tracking month-over-month customer acquisition via DATEADD.

**Dashboard Structure**
Page 1:Banking customer wealth overview: High-level KPIs (AUM, Total Income, Customer Segments).
Page 2: Risk & Credit: Debt-to-Asset ratios, risk weighting distribution, and high-exposure watchlists.
Page 3: Bank staffs Performance: Client load vs. deposit volume per relationship manager.
Page 4: Global wealth Distribution: treemap of wealth density and international account (FCA) penetration.

**Repository Structure**
Cleaning/: Jupyter Notebook with Python cleaning scripts.
SQL/: Scripts for table creation and data aggregation.
Dashboard/: .pbix Power BI file.
Data/: Sample dataset (CSV format).



