--Data Segmentation
--group products based on their cost range
with product_segments as(
select product_name, product_key, cost,
        case when cost<100 then 'Below 100'
             when cost between 100 and 500 then '100-500'
             when cost between 500 and 1000 then '500-1000'
             else 'Above 1000'
        end as cost_range
  from dim_products)
select cost_range, count(product_key) as total_products
  from product_segments
group by cost_range
order by total_products

--group customers based on their spending behavior
with customer_sales_behavior as(
select  c.customer_key, 
        c.first_name || c.last_name as full_name, 
        sum(sales_amount) as total_sales_amt, 
        min(order_date) as first_order_dt,
        max(order_date) as last_order_dt,
        round(months_between(max(order_date),min(order_date))) as customer_history
  from fact_sales f join dim_customers c
    on f.customer_key=c.customer_key
 where f.order_date is not null
group by c.customer_key, c.first_name || c.last_name)
select customer_type,count(customer_key)
from(
    select  customer_key,
        case when (customer_history>=12 and total_sales_amt > 5000) then 'VIP'
             when (customer_history>=12 and total_sales_amt <= 5000) then 'Regular'
             else 'New'
        end as customer_type
    from customer_sales_behavior
  )
group by customer_type

  
   



