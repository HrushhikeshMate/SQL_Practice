--  https://www.youtube.com/watch?v=HeP2kd5Tzo8&ab_channel=ZeroAnalyst
-- creating employees table
-- DROP TABLE IF EXISTS (table name);


CREATE TABLE employees (
						employee_id int,
						name varchar(25),
						department varchar(25),
						salary DECIMAL(10,2),
						hiredate date
						);

INSERT INTO employees (employee_id, name, department, salary, hiredate)
VALUES 
    (1, 'John Doe', 'IT', 50000, '2020-01-15'),
    (2, 'Jane Smith', 'HR', 55000, '2019-08-20'),
    (3, 'Michael Lee', 'Marketing', 60000, '2020-03-10'),
    (4, 'Emily Brown', 'Finance', 65000, '2018-11-05'),
    (5, 'David Wilson', 'IT', 52000, '2021-02-28');
SELECT * FROM employees;

-- creating product table
CREATE TABLE products (
						product_id INT,
						product_name VARCHAR(100),
						category varchar(100),
						price decimal(10,2),
						quantity_in_stock INT);

-- inserting records into products table 

INSERT INTO products (product_id, product_name, category, price, quantity_in_stock)
VALUES 
    (101, 'Laptop', 'Electronics', 1200, 50),
    (102, 'Smartphone', 'Electronics', 800, 100),
    (103, 'Headphones', 'Electronics', 100, 200),
    (104, 'T-shirt', 'Clothing', 20, 300),
    (105, 'Jeans', 'Clothing', 50, 150);
--  creating customers table

CREATE TABLE customers( customer_id INT,
					    customer_name VARCHAR(100),
					    email VARCHAR(100),
					    phone_number VARCHAR(20),
					    city VARCHAR(100)
						);

-- inserting data into customers table 

INSERT INTO customers (customer_id, customer_name, email, phone_number, city)
VALUES 
    (201, 'Alice Johnson', 'alice@example.com', '1234567890', 'New York'),
    (202, 'Bob Smith', 'bob@example.com', '9876543210', 'Los Angeles'),
    (203, 'Emma Davis', 'emma@example.com', '4567890123', 'Chicago'),
    (204, 'Jack Brown', 'jack@example.com', '7890123456', 'Houston'),
    (205, 'Olivia Wilson', 'olivia@example.com', '2345678901', 'Miami');
 
--  creating order table
CREATE TABLE orders (  order_id INT ,
					    customer_id INT,
					    product_id INT,
					    order_date DATE,
					    quantity_ordered INT);

-- inserting data into orders 
INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity_ordered)
VALUES 
    (301, 201, 101, '2022-03-15', 2),
    (302, 202, 103, '2022-03-16', 3),
    (303, 203, 104, '2022-03-17', 1),
    (304, 204, 102, '2022-03-18', 2),
    (305, 205, 105, '2022-03-19', 1);


-- PRIMARY KEY (t_id cannot be empty, cannot be duplicate, it has be unique)

CREATE TABLE transaction(transaction_id INT PRIMARY KEY,
					    customer_id INT,
					    amount DECIMAL(10, 2),
					    transaction_date DATE,
					    payment_method VARCHAR(50)
						) ;
-- inserting records into transactions
INSERT INTO transaction (transaction_id, customer_id, amount, transaction_date, payment_method)
VALUES 
    (401, 201, 1200, '2022-03-15', 'Credit Card'),
    (402, 202, 1000, '2022-03-16', 'PayPal'),
    (403, 203, 800, '2022-03-17', 'Cash'),
    (404, 204, 1500, '2022-03-18', 'Debit Card'),
    (405, 205, 600, '2022-03-19', 'PayPal');
						

SELECT * FROM customers ;
SELECT * FROM orders ;
SELECT * FROM products ;
SELECT * FROM transaction ;

-- -----------------------------------------------
-- Your Task Business Problems & Answers 
-- -----------------------------------------------



-- Employee Queries:

-- Q.1 Find the employee with the highest salary.
 SELECT * FROM employees ;
 select * from employees
 order by salary  desc
 limit 1; -- using order by and limit

-- or using a subquery
select * 
from employees
where salary = (select max(salary) from employees);
-- select max(salary) from employees;

-- Q.2 List employees hired after January 1, 2021.
select * from employees
where hiredate > '2021-01-01';

-- Q.3 Calculate the average salary of employees in each department.
select department, avg(salary) as avg_salary
from employees
group by department
order by avg_salary desc;

-- Q.4 Update the salary of employee with ID 3 to 62000.
update employees
set salary = 62000
where employee_id=3;

-- updating salary to 55000 and department to 'it' for zara

UPDATE employees
SET department = 'it', salary = 55000
WHERE name = 'zara'

	
SELECT * FROM employees
WHERE name = 'zara'

select * from employees;
-- Q.5 Delete the employee with the lowest salary.
delete from employees
where salary = (select min(salary) from employees);


-- Product Queries:
-- Q.6 Find the total value of products in stock for each category.
select * from products;

select * , (price*quantity_in_stock) as total_value
from products;

select category , sum(price*quantity_in_stock) as total_value
from products
group by category; -- correct one

-- Q.7 Identify products with a quantity in stock less than 50.
select * from products
where quantity_in_stock < 50;
-- Q.8 Calculate total number of product we have.
select sum(quantity_in_stock ) as total_product
from products;

-- Q.9 Update the price of all products in the 'Clothing' category to 10% higher.

update products
set price = price*1.10
where category = 'Clothing';

-- Q.10 Delete products with a price less than 50.
DELETE FROM products
WHERE price < 50;


-- Customer Queries:
-- Q.11 Count the number of customers in each city.

SELECT * FROM customers ;

select city , count(city) as customer_count
from customers
group by city;

-- Q.12 Identify customers who have made transactions using PayPal.
SELECT * FROM transaction ;

select * from transaction
where payment_method = 'PayPal';

SELECT DISTINCT c.*, t.payment_method
FROM customers c
JOIN transaction t ON c.customer_id = t.customer_id
WHERE t.payment_method = 'PayPal';

-- Q.13 Calculate the total amount spent by each customer.
SELECT * FROM customers ;

SELECT customer_id, SUM(amount) AS total_spent
FROM transaction
GROUP BY customer_id
order by total_spent desc;


-- Q.14 Update the email of customer with ID 204 to 'new_email@example.com'.
update customers
set email='new_email@example.com'
where customer_id = 204;

select * from customers
where customer_id = 204;
-- Q.15 Delete customers who have not made any transactions.
SELECT * FROM transaction;

select * from customers
where customer_id not in (select distinct customer_id from transaction);
-- Order Queries:
-- Q.16. Find the total number of orders placed on each date.
SELECT * FROM orders;

select order_date , count(*) as total_order
from orders
group by order_date;
-- Q.17 Identify orders with a quantity_ordered greater than 3.
select * from orders
where quantity_ordered > 2;
-- Q.18 Calculate the total sale amount for each product.
select * from products;
select * from orders;
select product_name , (price*quantity_in_stock) as total_sale
from products;

SELECT p.product_id, SUM(quantity_ordered * p.price) AS total_sale
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id;

-- Q.19 Update the order_date of order with ID 304 to '2022-03-20'.
UPDATE orders
SET order_date = '2022-03-20'
WHERE order_id = 304;


-- Q.20 Delete orders placed before January 1, 2022.

select *  FROM orders
WHERE order_date < '2022-01-01';

DELETE FROM orders
WHERE order_date < '2022-01-01';

-- Transaction Queries:
-- Q.21. Find the average transaction amount for each payment method.
SELECT payment_method, AVG(amount) AS avg_transaction
FROM transaction
GROUP BY payment_method;

-- Q.22 Identify transactions made on March 15,
SELECT * FROM transaction
WHERE transaction_date = '2022-03-15';




-- Your TASK

-- Insertion Tasks:
-- 1. Insert a new employee with the following details: EmployeeID = 101, Name = 'John Doe', Department = 'Marketing', Salary = 60000, HireDate = '2022-04-01'.

INSERT INTO employees (employee_id, name, department, salary, hiredate)
VALUES (101, 'John Doe', 'Marketing', 60000, '2022-04-01');


-- 2. Add a new product with the following details: ProductID = 11, Name = 'Smartphone', Category = 'Electronics', Price = 799.99, Quantity = 100.

INSERT INTO products (product_id, product_name, category, price, quantity_in_stock)
VALUES (11, 'Smartphone', 'Electronics', 799.99, 100);


-- Update Tasks:
-- 1. Increase the salary of all employees in the 'Sales' department by 10%.

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'Sales';

-- Update the price of the product with ProductID = 3 to 99.99.
UPDATE products
SET price = 99.99
WHERE product_id = 3;


-- Deletion Tasks:
-- 1. Delete the employee with EmployeeID = 102.
-- Remove all products with a Quantity less than 10.

						