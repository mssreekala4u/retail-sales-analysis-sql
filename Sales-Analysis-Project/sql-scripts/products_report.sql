/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
CREATE VIEW report_products AS
WITH base_query AS(
select f.order_number,
       f.customer_key,
       f.order_date,
       p.product_key,
       p.product_name,
       p.category,
       p.subcategory,
       p.cost,
       f.quantity,
       f.sales_amount
  from fact_sales f join dim_products p
    on f.product_key = p.product_key
 where f.order_date is not null
    ), 
product_aggregation AS(
    select product_key,
           product_name,
           category,
           subcategory,
           cost,
           count(distinct customer_key) as total_customers,
           sum(sales_amount) as total_sales,
           count(distinct order_number) as total_orders,
           sum(quantity) as total_quantity,
           max(order_date) as last_order_date,
           floor(months_between(max(order_date), min(order_date))) as life_span
      from base_query
  group by product_key,
           product_name,
           category,
           subcategory,
           cost
    )
    select product_key,
           product_name,
           category,
           subcategory,
           cost,
           last_order_date,
           floor(months_between(sysdate, last_order_date)) as recency,
           life_span,
           total_customers,
           total_sales,
           total_orders,
           total_quantity,
           case when total_sales >= 1000000 then 'High-Performers'
                when total_sales between 50000 and 1000000 then 'Mid-Range'
                else 'Low-Performers'
           end as product_performance,
           case when total_orders = 0 then 0
                else ceil(total_sales / total_orders)
           end as avg_order_revenue,
           case when life_span = 0 then total_sales
                else ceil(total_sales / life_span )
           end as avg_monthly_revenue
      from product_aggregation 
           
           
           
           
           
    
    
    
    
    
    
    