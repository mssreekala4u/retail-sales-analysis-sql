--Performance Analysis
--Analyse performance by comparing current year sales with avg sales val and prev year sales value

with yearly_product_sales as
(
select d.product_name, 
        trunc(f.order_date,'yy') order_dt, 
        sum(sales_amount) current_sales
from fact_sales f join dim_products d
  on f.product_key=d.product_key
where f.order_date is not null
group by d.product_name, trunc(f.order_date,'yy')
)
select product_name, 
        order_dt, current_sales,
        round(avg(current_sales)over(partition by product_name),0) avg_pdt_sales_amt,
        current_sales-round(avg(current_sales)over(partition by product_name),0) as diff,
        case when current_sales-round(avg(current_sales)over(partition by product_name),0)>0 then 'Above avg'
            when current_sales-round(avg(current_sales)over(partition by product_name),0)<0 then 'Below Avg'
            else 'Avg'
        end as performance,
        lag(current_sales)over(partition by product_name order by order_dt) as prev_yr,
        case when current_sales-lag(current_sales)over(partition by product_name order by order_dt)>0 then 'Increase'
            when current_sales-lag(current_sales)over(partition by product_name order by order_dt)<0 then 'Decrease'
            else 'No Change'
        end as prev_yr_change
from yearly_product_sales
order by product_name, order_dt