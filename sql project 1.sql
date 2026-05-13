--SQL RETAIL ANALYSIS --
CREATE TABLE RETAIL_SALE 
(transactions_id INT PRIMARY KEY
,sale_date DATE	,
sale_time TIME ,
customer_id	INT
,gender VARCHAR(20)
,age INT,
category VARCHAR(50)
,quantiy INT	
,price_per_unit FLOAT,	
cogs FLOAT ,	
total_sale FLOAT )

select * from RETAIL_SALE;

select count(*) from RETAIL_SALE;
-- DATA CLEANING ---
select * from RETAIL_SALE
where age is null 
or  sale_time is null
or customer_id is null
or gender is null
or transactions_id is null or 	sale_date is null or category is null
or 	quantiy is null or 
price_per_unit	is null or 
cogs is null or 
 total_sale is null;
;


delete from RETAIL_SALE 
where age is null 
or  sale_time is null
or customer_id is null
or gender is null
or transactions_id is null or 	sale_date is null or category is null
or 	quantiy is null or 
price_per_unit	is null or 
cogs is null or 
 total_sale is null;
;

-- DATA EXSPLORATION --

--HOW MANY SALES DO WE HAVE --

select count(*) as  toyal_sale from RETAIL_SALE;

select count(distinct(customer_id)) as  customer_id from RETAIL_SALE;

select distinct(category) as  category from RETAIL_SALE;


--DATA ANLYSIS--

--Q1--
select * from RETAIL_SALE
where sale_date='2022-11-05';

--Q2--
select category, sum(quantiy) 
from RETAIL_SALE
where category='Clothing' and 
TO_CHAR(sale_date,'YYYY-MM')='2022-11'
and quantiy>=4
group by 1 ;
--Q3--

select distinct (category) , sum(total_sale) as total_sale from
RETAIL_SALE
group by category;

--q4 Write a SQL query to find the average age of 
--customers who purchased items from the 'Beauty' category.:
select * from RETAIL_SALE;

select  round(avg(age),2) as avg_age 
from RETAIL_SALE
where category = 'Beauty';

--q5 Write a SQL query to find all transactions where
--the total_sale is greater than 1000.:
select * from RETAIL_SALE
where total_sale >1000;

--q6Write a SQL query to find the total number of transactions
--(transaction_id) made by each gender in each category.:

select gender ,category, count(transactions_id) from RETAIL_SALE
group by gender,category;

--Q7 Write a SQL query to calculate the average sale
--for each month. Find out best selling month 
--in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM RETAIL_SALE
GROUP BY 1, 2
) as t1
WHERE rank = 1

--Q8Write a SQL query to find the top 5 customers 
--based on the highest total sales
select * from RETAIL_SALE;
select customer_id,
sum(total_sale) as total_sepend from RETAIL_SALE
group by customer_id order by total_sepend DESC
limit 5;

--q9 Write a SQL query to find the number of 
--unique customers who purchased items from each category.:
select category, count(distinct customer_id) as new_count
from RETAIL_SALE
group by category

--Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_shift
as
(select * , 
case 
when extract(hours from sale_time)<12 then 'morning'
when extract(hours from sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift
from RETAIL_SALE
)
select shift,count(*) as total_orders 
from hourly_shift
group by shift

