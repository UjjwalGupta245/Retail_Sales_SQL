Select * from retail_sales
limit 10;


SELECT COUNT(*) FROM retail_sales;

Select * From retail_sales
Where transactions_id is null;

Select * From retail_sales
Where sale_date is null;

Select * From retail_sales
Where sale_time is null;

Select * From retail_sales
Where 
    transactions_id is null
    or
	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;

-- Data Cleaning	
Delete from retail_sales
Where 
    transactions_id is null
    or
	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;

--Data Exploration

--How many sales we have
SELECT COUNT(*) AS total_sale from retail_sales

--How many unique customer we have

SELECT COUNT(Distinct(customer_id)) AS num_customer from retail_sales

SELECT Distinct(category) AS num_customer from retail_sales

--Data Analysis & Bussinesss Key Problem & Answers

-- Wite a SQL query to retrieve all columns for sales made on 2022-11-09

Select * from retail_sales 
where sale_date='2022-11-05'

-- Write a SQL query to retrive all transactions where category is Clothing and the quantity is more than 4 in month of NOV 2022 

SELECT *from retail_sales
where category='Clothing'
     AND
	 TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	 AND 
	 quantiy >=4;

-- Caltulate the total sales for each category
SELECT sum(total_sale) , category , count(*) as total_count from retail_sales
group by category
	 
--Find the average age of customer who purchased items from the Beauty category	 

SELECT round(AVG(age),2) from retail_sales
WHERE category='Beauty'

--Find Transactions where the total_sales is greter than 1000

SELECT * from retail_sales
where total_sale > 1000

-- Find total number of transaction_id made by each gender in each category

select count(*), gender, category from retail_sales 
group by gender, category
Order by 3

-- Calculate the average sale for each month find out best selling month in each year
select year,
       month,
	   avg_sale from
(
SELECT Extract (Year from sale_date) as year,
       Extract (Month from sale_date) as month,
	   avg(total_sale) as avg_sale,
	   RANK() OVER(Partition by  Extract (Year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1, 2
) as ti
where rank= 1

-- find the top 5 customer based on the highest total sales
SELECT customer_id , sum(total_sale) as total_sale from retail_sales
group by customer_id
order by total_sale desc
limit 5

-- find the number of unique customer who purchased items from each category

select category , count(distinct customer_id)as no_of_customer
from retail_sales
group by category

-- Create each shift number of order (Example morning <= 12, afternoon between 12 & 17 , evening> 17)

with hourly_sale
as
(
SELECT *,
   case
       when extract(hour from sale_time)<12  then 'Morning'
	   when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	   else 'Evening'
	end as shift
from retail_sales
)
select shift,count(*) from hourly_sale
group by shift



	
select extract(hour from current_time)
	   
-- End of project

	



