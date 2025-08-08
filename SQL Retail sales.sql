 -- SQL reetail sales analysis


 -- Create table
 Drop table if exists retail_sales;
 CREATE TABLE retail_sales
 		(
			transactions_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(20) ,
			age INT,
			category VARCHAR(20),
			quantity INT,
			price_per_unit FLOAT,
			cogs FLOAT ,
			total_sale FLOAT
 		);

Select * 
from retail_sales
limit 10;

Select count(*) 
from retail_sales;

-- DATA Cleaning

SELECT * from retail_sales
where 
	transactions_id is NULL
	OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- 

DELETE FROM retail_sales
WHERE
	transactions_id is NULL
	OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

Select * from retail_sales;

Select count(*) from retail_sales;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

--  How many unique customers we have ?
SELECT count(DISTINCT customer_id) as total_customer FROM retail_sales;

SELECT DISTINCT customer_id as total_customer FROM retail_sales;

SELECT DISTINCT category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
where sale_date = '2022-11-05';

/*
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
the quantity sold is more than 10 in the month of Nov-2022 
*/

select * from retail_sales
where 
	category = 'Clothing'
	and
	to_char(sale_date, 'YYYY-MM') = '2022-11'
	and
	quantity >= 4;



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , 
		sum(total_sale) as net_sale,
from retail_sales
group by 1;

select category , 
		sum(total_sale) as net_sale,
		COUNT(*) as total_orders
from retail_sales
group by 1;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
	ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

SELECT
	ROUND(AVG(age),2) as avg_age,
	COUNT(*) as total_customers
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * 
FROM retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender, count(*) as total_trans
FROM retail_sales
group by category,
		 gender
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

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
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
	   count(Distinct customer_id) as uniq_cus
FROM retail_sales
GROUP by category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- End of project