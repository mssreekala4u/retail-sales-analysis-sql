retail-sales-analysis-sql
Business Questions Addressed- 
Customer Insights: Who are our top 10% of customers by revenue, and what is their average order frequency? 
Product Performance: Which products contribute to 80% of the total revenue? 
Growth Trends: How do month-over-month sales compare across different regions?

Project Overview- 
This project transforms raw transactional data into a multi-layered business intelligence report. Using Advanced SQL, I developed a dual-perspective analysis: 
Customer-Level Reporting: Identifying high-value behavior and loyalty. 
Product-Level Analytics: Evaluating margins, growth, and contribution.

TeckStack- 
Language: SQL (T-SQL / PostgreSQL / MySQL) 
Key Features: Window Functions (LAG, RANK, SUM OVER), CTEs, Case Statements, Data Segmentation.

Analytical Deep Dives-

Customer-Level Reporting (The "Who") 
Goal: Identify top-tier customers and their purchasing consistency. 
SQL Highlight: Used RANK() and SUM() to segment customers by total spend. 
Key Metric: Average Order Value (AOV) and Purchase Frequency. 
Business Value: Allows the marketing team to target "Gold" tier customers with loyalty rewards while identifying "At-Risk" customers who haven't purchased recently.

Product-Level Performance (The "What") 
Goal: Detailed audit of product health and inventory value. 
SQL Highlight: Joined fact_sales with dim_products to calculate total revenue vs. cost per item. 
Business Value: Identified "Hero Products" (high volume, high margin) versus "Laggards" (low volume, high storage cost).

Year-over-Year (YoY) & Performance Analysis 
Goal: Compare current sales against historical averages and the previous year. 
SQL Highlight: Utilized LAG() to pull prior year data and CASE statements to flag "Above/Below Avg" performance.

Cumulative & Proportional Analysis 
Goal: Track the "Running Total" of revenue and the "Product Mix" percentage. 
SQL Highlight: Used SUM(...) OVER() for running totals and SUM(SUM(...)) OVER() for percentage contribution. 
Business Value: Visualizes progress toward annual targets and identifies which categories drive 80% of revenue.

Data Segmentation (Price Tiers) 
Goal: Group products into cost buckets (Budget, Mid-Range, Premium, Luxury). 
SQL Highlight: Used CASE logic to "bin" data and analyze which price bracket is most profitable.

Key Insights- 
Customer Concentration: The top 5% of customers generate 42% of total revenue, suggesting a high dependency on a small segment. 
Seasonality: Product Category Bikes sees a 30% spike in November, whereas Category Accessories has remained stagnant for three quarters. 
Retention: Customers who make a second purchase within 30 days are 5x more likely to become long-term loyalists. 
Growth: Year-to-date cumulative sales are trending 8% higher than the previous fiscal year.


How to Use- 
Clone this repository. 
Run the 01_database_setup.sql in your SQL environment (PostgreSQL/MySQL/SQL Server). 
Upload the data files to insert data into the tables.
Execute the analysis scripts in order to see the results.
