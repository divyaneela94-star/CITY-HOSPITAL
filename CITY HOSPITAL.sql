/* =========================================================
   SECTION 1: CITY HOSPITAL DATABASE – BASIC TABLE CREATION
   ========================================================= */
DROP DATABASE patientsdb;
CREATE DATABASE patientsdb;
USE patientsdb;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    AdmissionDate DATE
);

-- Insert sample data
INSERT INTO Patients VALUES
(1, 'John Doe', 45, 'Male', '2024-12-01'),
(2, 'Alice Smith', 29, 'Female', '2024-11-28'),
(3, 'Michael Brown', 60, 'Male', '2024-11-25');

-- Add DoctorAssigned column
ALTER TABLE Patients ADD DoctorAssigned VARCHAR(50);

UPDATE Patients
SET DoctorAssigned = 'Dr. Patel'
WHERE PatientID = 1;

UPDATE Patients
SET DoctorAssigned = 'Dr. Lee'
WHERE PatientID = 2;

UPDATE Patients
SET DoctorAssigned = 'Dr. Kim'
WHERE PatientID = 3;



/* =========================================================
   SECTION 2: BOOKSTORE DATABASE – CONSTRAINTS
   ========================================================= */

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150),
    Author VARCHAR(100),
    ISBN VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert sample data
INSERT INTO Books VALUES
(1, 'SQL for Beginners', 'John Author', 'ISBN123'),
(2, 'Mastering Python', 'Alice Dev', 'ISBN456'),
(3, 'Data Science Essentials', 'Mark Analyst', 'ISBN789');

INSERT INTO Orders VALUES
(101, 1, '2024-11-20', 3),
(102, 2, '2024-11-25', 2);

-- Add UNIQUE constraint to ISBN
ALTER TABLE Books ADD CONSTRAINT UQ_ISBN UNIQUE (ISBN);



/* =========================================================
   SECTION 3: UNIVERSITY DATABASE – FILTERS & CONDITIONS
   ========================================================= */

DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Employees;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Email VARCHAR(100),
    Course VARCHAR(50),
    GPA DECIMAL(3,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Amount DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO Departments VALUES
(1, 'Science'), (2, 'Arts'), (3, 'Engineering');

INSERT INTO Students VALUES
(101, 'John Carter', NULL, 'Math', 3.8),
(102, 'Alice Brown', 'alice@gmail.com', 'Physics', 3.5),
(103, 'Sam Lee', 'sam@uni.edu', 'Chemistry', 2.9);

INSERT INTO Products VALUES
(1, 'Laptop', 1200.00),
(2, 'Phone', 900.00),
(3, 'Headphones', 200.00),
(4, 'Tablet', 600.00);

INSERT INTO Sales VALUES
(1, 200.00), (2, 500.00), (3, 800.00), (4, 150.00);

INSERT INTO Employees VALUES
(1, 'John', 'Smith', 1, '2018-05-20', 55000.00),
(2, 'Alice', 'Johnson', 2, '2019-06-01', 70000.00),
(3, 'Mark', 'Lee', 3, '2021-01-10', 65000.00);



/* =========================================================
   SECTION 4: JOINS & UNION
   ========================================================= */

DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS CurrentEmployees;
DROP TABLE IF EXISTS PastEmployees;

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT
);

CREATE TABLE CurrentEmployees (
    EmployeeName VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE PastEmployees (
    EmployeeName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data
INSERT INTO Courses VALUES
(1, 'Math'), (2, 'Physics'), (3, 'Chemistry');

INSERT INTO Enrollments VALUES
(101, 1), (102, 2);

INSERT INTO CurrentEmployees VALUES
('John Smith', 'HR'),
('Alice Johnson', 'Finance');

INSERT INTO PastEmployees VALUES
('Mark Davis', 'HR'),
('John Smith', 'HR');

 SET SQL_SAFE_UPDATES = 0;


/* =========================================================
   SECTION 5: STRING & DATE FUNCTIONS
   ========================================================= */

-- Examples will run using Employees table from earlier
SELECT 
    EmployeeID,
    UPPER(FirstName) AS UpperName,
    LOWER(LastName) AS LowerName,
    SUBSTRING(FirstName, 1, 3) AS ShortName,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HireDate,
    YEAR(NOW()) - YEAR(HireDate) AS Tenure_Years,
    DATEDIFF(NOW(), HireDate)/365 AS Tenure_Approx
FROM Employees;

DELIMITER //

CREATE FUNCTION GetFullName(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END//

DELIMITER ;

SELECT GetFullName('Alice', 'Johnson') AS FullName;



/* =========================================================
   SECTION 6: STORED PROCEDURES & VIEWS
   ========================================================= */

DROP TABLE IF EXISTS Departments;  -- recreate with employee link
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments VALUES
(1, 'HR'), (2, 'Finance'), (3, 'IT');

DELIMITER //

CREATE PROCEDURE GetEmployeeDetails (IN emp_id INT)
BEGIN
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        HireDate,
        Salary
    FROM Employees
    WHERE EmployeeID = emp_id;
END//

DELIMITER ;

CALL GetEmployeeDetails(1);

CREATE VIEW EmployeeDepartmentView AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

DROP TABLE IF EXISTS Salaries;
CREATE TABLE Salaries (
    EmployeeID INT,
    BaseSalary DECIMAL(10,2),
    Bonus DECIMAL(10,2)
);

INSERT INTO Salaries VALUES
(1, 55000, 5000),
(2, 70000, 7000),
(3, 65000, 6000);

CREATE VIEW EmployeeFullInfo AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    d.DepartmentName,
    s.BaseSalary,
    s.Bonus,
    (s.BaseSalary + s.Bonus) AS TotalCompensation
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;



/* =========================================================
   SECTION 7: TRIGGERS, DCL & TCL
   ========================================================= */

DROP TABLE IF EXISTS Order_History;

CREATE TABLE Order_History (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    DeletedAt DATETIME
);

DELIMITER //

CREATE TRIGGER AfterOrderDelete
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (OrderID, CustomerID, OrderDate, DeletedAt)
    VALUES (OLD.OrderID, OLD.BookID, OLD.OrderDate, NOW());
END//

DELIMITER ;

-- Test trigger
DELETE FROM Orders WHERE OrderID = 101;

-- Check history table
SELECT * FROM Order_History;

-- DCL Commands
-- Step 1: Create the user (if it doesn’t already exist)
CREATE USER 'junior_analyst'@'localhost' IDENTIFIED BY 'Password123';

-- Step 2: Grant SELECT privilege
SELECT User, Host FROM mysql.user WHERE User='junior_analyst';
GRANT SELECT ON Sales TO 'junior_analyst'@'localhost';
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS Accounts;

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountName VARCHAR(50),
    Balance DECIMAL(10,2)
);

INSERT INTO Accounts VALUES
(1001, 'Alice', 5000.00),
(2002, 'Bob', 3000.00);

START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 500 WHERE AccountID = 1001;
UPDATE Accounts SET Balance = Balance + 500 WHERE AccountID = 2002;

SAVEPOINT before_commit;

-- Commit if no errors
COMMIT;

-- If needed:
-- ROLLBACK;
-- ROLLBACK TO before_commit;
