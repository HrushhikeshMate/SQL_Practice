-- 
CREATE TABLE suppliers ( 
supplier_id INT PRIMARY KEY, 
supplier_name VARCHAR(100) 
); 

drop table if exists products; 
CREATE TABLE products ( 
product_id INT PRIMARY KEY, 
product_name VARCHAR(100), 
category VARCHAR(50), 
supplier_id INT 
); 
INSERT INTO suppliers VALUES 
(1, 'Supplier A'), 
(2, 'Supplier B'); 
SELECT * from suppliers; 
INSERT INTO products VALUES 
(1, 'Smartphone', 'Electronics', 1), 
(2, 'Washing Machine', 'Appliances', 2);

-- Q.21 Find all suppliers who provide products in the Electronics category.
SELECT DISTINCT s.supplier_name
from suppliers s 
join products p on p.supplier_id = s.supplier_id
where category = 'Electronics';

-------------------------------------------------------------------------------------------------

CREATE TABLE orders1 ( 
order_id INT PRIMARY KEY, 
order_date DATE 
); 
INSERT INTO orders1 VALUES  
(2, '2024-01-15'), 
(3, '2023-02-10'),
(1, '2024-01-05'); 

-- Q 23 Get the number of unique orders placed in January 2024. 

select count(distinct order_id) as unique_orders
from orders1
where order_date between '2024-01-01' and '2024-01-31';

-------------------------------------------------------------------------------------------------
-- Q 25  46
--  Q 26
-- Q 29
-- Q 31
--Q 32
--Q 36
-- Q 38
-- Q 39

-- Q 40 65
