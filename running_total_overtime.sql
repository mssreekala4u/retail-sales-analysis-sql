--Cumulative Analysis
--calculate total sales per month and running total of sales over time
select order_dt,total_sales_amt,
sum(total_sales_amt)over(order by to_date(order_dt,'mon-yyyy')) running_total_sales
from(
select to_char(order_date,'mon-yyyy') order_dt,sum(sales_amount) total_sales_amt
from fact_sales
where order_date is not null
group by to_char(order_date,'mon-yyyy')
)

--calculate running total of months for each year
select order_dt,total_sales,
sum(total_sales)over(partition by trunc(order_dt,'yy') order by order_dt) as running_total_month
from(
select trunc(order_date,'mm') order_dt,sum(sales_amount) total_sales
from fact_sales
where order_date is not null
group by trunc(order_date,'mm')
)
--calculate running total and moving avg of sales over years
select order_dt,total_sales,
sum(total_sales)over(order by order_dt) as running_total_year,
round(avg(avg_price)over(order by order_dt),2) as moving_avg_price
from(
select trunc(order_date,'yy') order_dt, sum(sales_amount) total_sales, avg(price) as avg_price
from fact_sales
where order_date is not null
group by trunc(order_date,'yy')
)

