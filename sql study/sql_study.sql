--  https://chatgpt.com/share/6897d4d6-3140-800e-a7d5-c64c540af50b
-- DROP DATABASE IF EXISTS sql_study;
-- CREATE DATABASE sql_study;
-- USE sql_study;

-- DEpartment TABLE
CREATE TABLE Departments (
    DepartmentID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	-- EmpID INT PRIMARY KEY AUTO_INCREMENT, use in MYSQL
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

-- Employees Table
CREATE TABLE Employees (
    EmpID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


-- Projects Table
CREATE TABLE Projects (
    ProjectID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

-- EmployeeProjects (Many-to-Many Relation)
CREATE TABLE EmployeeProjects (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- =============================================
-- PART 2: INSERT SAMPLE DATA (Extended)
-- =============================================

-- Departments
INSERT into Departments (Departmentname,Location) VALUES
('IT', 'New York'),
('HR', 'London'),
('Finance', 'Tokyo'),
('Marketing', 'Paris'),
('Operations', 'Berlin');

select * from Departments;

-- Employees
INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, HireDate) VALUES
('John', 'Doe', 1, 75000, '2020-03-15'),
('Jane', 'Smith', 2, 60000, '2019-07-01'),
('Mike', 'Brown', 1, 80000, '2021-01-20'),
('Emily', 'Davis', 3, 72000, '2018-11-30'),
('David', 'Wilson', 1, 90000, '2022-05-10'),
('Sara', 'Miller', 2, 65000, '2023-08-01'),
('Robert', 'Taylor', 4, 58000, '2021-06-14'),
('Olivia', 'Anderson', 5, 62000, '2020-10-21'),
('Liam', 'Martinez', 4, 61000, '2022-02-05'),
('Sophia', 'Hernandez', 3, 83000, '2019-09-17'),
('Mason', 'Clark', 1, 77000, '2021-04-30'),
('Isabella', 'Lewis', 5, 54000, '2020-07-12'),
('Ethan', 'Walker', 1, 96000, '2018-05-25'),
('Ava', 'Hall', 4, 69000, '2023-01-03'),
('Noah', 'Allen', 3, 81000, '2019-11-19');

select * from Employees;

-- Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES
('Website Redesign', '2023-01-01', '2023-06-30'),
('Employee Onboarding', '2022-09-01', '2023-03-31'),
('Financial Audit', '2023-04-01', '2023-12-31'),
('Social Media Campaign', '2023-05-01', '2023-09-30'),
('ERP Implementation', '2022-07-15', '2023-07-15'),
('Product Launch', '2023-02-01', '2023-08-01'),
('Data Migration', '2023-06-10', '2023-10-10');

select * from Projects;

-- EmployeeProjects
INSERT INTO EmployeeProjects (EmpID, ProjectID, HoursWorked) VALUES
(1, 1, 120), (1, 5, 90),
(2, 2, 80),
(3, 1, 150), (3, 7, 60),
(4, 3, 100), (4, 7, 50),
(5, 1, 200), (5, 3, 50),
(6, 2, 110),
(7, 4, 95), (7, 6, 85),
(8, 5, 75), (8, 4, 65),
(9, 4, 130), (9, 6, 100),
(10, 3, 140), (10, 5, 90),
(11, 7, 110), (11, 1, 70),
(12, 4, 120),
(13, 5, 200), (13, 7, 150),
(14, 6, 85),
(15, 3, 100), (15, 5, 110);

select * from EmployeeProjects;
-- =============================================
-- PART 3: BASIC SQL
-- =============================================

-- Select all columns
SELECT * FROM Employees;

-- Select specific columns
SELECT FirstName, LastName, Salary 
FROM Employees;

-- Filtering with WHERE
SELECT * FROM Employees 
WHERE Salary > 75000;

-- ORDER BY
SELECT * FROM Employees 
ORDER BY Salary DESC;

-- LIMIT
SELECT * FROM Employees 
ORDER BY Salary DESC 
LIMIT 3;

-- =============================================
-- PART 4: JOINS
-- =============================================

-- INNER JOIN
SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- LEFT JOIN
SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmpID = ep.EmpID
LEFT JOIN Projects p ON ep.ProjectID = p.ProjectID;

-- RIGHT JOIN
SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employees e
RIGHT JOIN EmployeeProjects ep ON e.EmpID = ep.EmpID
RIGHT JOIN Projects p ON ep.ProjectID = p.ProjectID;

-- FULL JOIN (simulate in MySQL using UNION)
SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmpID = ep.EmpID
LEFT JOIN Projects p ON ep.ProjectID = p.ProjectID
UNION
SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employees e
RIGHT JOIN EmployeeProjects ep ON e.EmpID = ep.EmpID
RIGHT JOIN Projects p ON ep.ProjectID = p.ProjectID;

-- SELF JOIN Example
SELECT e1.FirstName AS Emp1, e2.FirstName AS Emp2
FROM Employees e1
JOIN Employees e2 ON e1.DepartmentID = e2.DepartmentID
WHERE e1.EmpID <> e2.EmpID;

-- =============================================
-- PART 5: AGGREGATES & GROUPING
-- =============================================

SELECT DepartmentID, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID;

SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 2;

-- =============================================
-- PART 6: SUBQUERIES
-- =============================================

-- Employees with salary above company average
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- =============================================
-- PART 7: DATA MODIFICATION
-- =============================================

-- Insert
INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES ('Lucas', 'White', 2, 67000, '2024-01-15');

-- Update
UPDATE Employees SET Salary = Salary * 1.10 WHERE DepartmentID = 1;

-- Delete
DELETE FROM Employees WHERE EmpID = 16;

-- =============================================
-- PART 8: CONSTRAINTS & KEYS
-- =============================================

ALTER TABLE Employees
ADD CONSTRAINT unique_name UNIQUE (FirstName, LastName);

ALTER TABLE Employees
ADD CONSTRAINT check_salary CHECK (Salary >= 30000);

-- =============================================
-- PART 9: VIEWS
-- =============================================

CREATE VIEW HighPaidEmployees AS
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 80000;

SELECT * FROM HighPaidEmployees;

-- =============================================
-- PART 10: INDEXES
-- =============================================

CREATE INDEX idx_salary ON Employees(Salary);

SELECT * from Employees;

-- =============================================
-- PART 11: ADVANCED TOPICS
-- =============================================

-- CTE (Common Table Expression)
WITH DeptAvg AS (
    SELECT DepartmentID, AVG(Salary) AS AvgSal
    FROM Employees
    GROUP BY DepartmentID
)
SELECT e.FirstName, e.LastName, e.Salary, d.AvgSal
FROM Employees e
JOIN DeptAvg d ON e.DepartmentID = d.DepartmentID;

-- Window Functions
SELECT FirstName, LastName, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;
