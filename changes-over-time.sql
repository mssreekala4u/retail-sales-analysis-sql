--Analyse changes in data over time
--aggregate sales amount by date
select order_date,sum(sales_amount) 
from fact_sales
where order_date is not null
group by order_date
order by order_date desc

--aggregate sales amount, no of customers by year
select extract(year from order_date) order_yr,sum(sales_amount),count(distinct customer_key) tot_customers
from fact_sales
where order_date is not null
group by extract(year from order_date)
order by extract(year from order_date) desc

--aggregate sales amount, no of customers by month-year
select to_char(order_date,'yyyy-mon') order_dt,sum(sales_amount),count(distinct customer_key) tot_customers
from fact_sales
where order_date is not null
group by to_char(order_date,'yyyy-mon')
order by min(order_date) 