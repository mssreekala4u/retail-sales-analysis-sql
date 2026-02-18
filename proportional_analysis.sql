--Proportional Analysis
with category_sales as
 (select d.category as pdt_category,sum(f.sales_amount) as sales_amount 
 from fact_sales f join dim_products d
   on f.product_key=d.product_key
  group by d.category
)
select pdt_category,sales_amount,
       sum(sales_amount)over() as total_sales_amt,
       round((sales_amount/sum(sales_amount)over()),4)*100 || '%' as percent_total
   from category_sales
order by sales_amount desc