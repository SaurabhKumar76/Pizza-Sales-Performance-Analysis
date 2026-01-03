SELECT * FROM PIZZA_SALES;


SELECT sum(total_price) as Total_Revenue
from pizza_sales;

select sum(total_price)/count(distinct order_id) as Average_order_value
from pizza_sales;

SELECT SUM(quantity) as Total_pizzas_sold
from pizza_sales;

select count(distinct order_id) as Total_orders
from pizza_sales;

select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_per_order
from pizza_sales;

--HOURLY TREND FOR TOTAL PIZZAS SOLD
select datepart(hour, order_time) as order_hour, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by datepart(hour, order_time)
order by order_hour;

--WEEKLY TREND FOR TOTAL ORDERS
select datepart(iso_week, order_date) as week_number, year(order_date) as order_year, count(distinct order_id) as Total_orders
from pizza_sales
group by datepart(iso_week, order_date), year(order_date)
order by datepart(iso_week, order_date), year(order_date);

--PERCENTAGE OF SALES BY PIZZA CATEGORY
select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100/ (select sum(total_price) from pizza_sales) as Percentage_Total_sales
from pizza_sales
where month(order_date) = 6
group by pizza_category;

select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100/ (select sum(total_price) from pizza_sales where month(order_date) = 1) as Percentage_Total_sales
from pizza_sales
where month(order_date) = 1
group by pizza_category;

--PERCENTAGE OF SALES BY PIZZA SIZE
select pizza_size, sum(total_price) as Total_sales, sum(total_price) * 100/ (select sum(total_price) from pizza_sales) as Percentage_total_sales
from pizza_sales
group by pizza_size;

select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price) * 100/ (select sum(total_price) from pizza_sales) as decimal(10,2)) as Percentage_total_sales
from pizza_sales
group by pizza_size
order by Percentage_total_sales;

select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price) * 100/ (select sum(total_price) from pizza_sales where datepart(quarter, order_date) = 1) as decimal(10,2)) as Percentage_total_sales
from pizza_sales
where datepart(quarter, order_date) = 1
group by pizza_size
order by Percentage_total_sales;

--TOP 5 PIZZAS BY REVENUE
select top 5 pizza_name, sum(total_price) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue desc;

--BOTTOM 5 PIZZAS BY REVENUE
select top 5 pizza_name, sum(total_price) as Total_revenue
from pizza_sales
group by pizza_name
order by Total_revenue;

--TOP 5 PIZZAS BY QUANTITY
select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity desc;

--BOTTOM 5 PIZZAS BY QUANTITY
select top 5 pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity;