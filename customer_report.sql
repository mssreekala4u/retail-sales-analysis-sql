/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: report_customers
-- =============================================================================
/*-----------------------------------------------------------------------------------------
1)This is the base query for fetching all orders and the corresponding customer info
----------------------------------------------------------------------------------------*/
CREATE VIEW report_customers AS
WITH base_query AS(
select  f.order_number,
        f.order_date,
        f.customer_key,
        f.product_key,
        f.quantity,
        f.sales_amount,
        c.first_name||c.last_name as full_name,
        floor(months_between(sysdate,c.birthdate)/12) as age
from fact_sales f join dim_customers c
  on f.customer_key=c.customer_key
where f.order_date is not null
), cust_aggregated_sales AS(
/*---------------------------------------------------------------------
2)Customer aggregations :summarizes sales data at the customer level
-----------------------------------------------------------------------*/
select customer_key,
        full_name,
        age,
        count(distinct order_number) as total_orders,
        sum(sales_amount) as total_sales,
        count(distinct product_key) as total_products,
        sum(quantity) as total_quantity,
        max(order_date) as last_order_date,
        min(order_date) as first_order_date,
        floor(months_between(max(order_date),min(order_date))) as life_span
  from base_query
group by customer_key,
         full_name,
         age
)
select customer_key,
        full_name,
        age,
        case when age<20 then 'Under 20'
             when age between 20 and 29 then '20-29'
             when age between 30 and 39 then '30-39'
             when age between 40 and 49 then '40-49'
             else 'Above 50'
        end as age_category,
        case when life_span >= 12 and total_sales >5000 then 'VIP'
            when life_span >= 12 and total_sales <5000 then 'Regular'
            else 'New'
        end as customer_type,
        last_order_date,
        floor(months_between(sysdate,last_order_date)) as recency,
        life_span,
        total_orders,
        total_sales,
        total_products,
        total_quantity,
        case when total_orders = 0 then 0
             else ceil(total_sales/total_orders)
        end as avg_sales,
        case when life_span =0 then total_sales
             else ceil(total_sales/life_span)
        end as avg_monthly_spend
  from cust_aggregated_sales
         
        
        











