--create user and password and hive permission to the user
create user c##data_analytics identified by mypassword;
grant connect,resource,dba to c##data_analytics;

--connect to the database
connect c##data_analytics/mypassword;


CREATE TABLE dim_customers(
	customer_key number(5),
	customer_id number(5),
	customer_number nvarchar2(50),
	first_name nvarchar2(50),
	last_name nvarchar2(50),
	country nvarchar2(50),
	marital_status nvarchar2(50),
	gender nvarchar2(50),
	birthdate date,
	create_date date
);


CREATE TABLE dim_products(
	product_key number(5) ,
	product_id number(5) ,
	product_number nvarchar2(50) ,
	product_name nvarchar2(50) ,
	category_id nvarchar2(50) ,
	category nvarchar2(50) ,
	subcategory nvarchar2(50) ,
	maintenance nvarchar2(50) ,
	cost number(5),
	product_line nvarchar2(50),
	start_date date 
);


CREATE TABLE fact_sales(
	order_number nvarchar2(50),
	product_key number(5),
	customer_key number(5),
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount number(5),
	quantity number(5),
	price number(5) 
);
