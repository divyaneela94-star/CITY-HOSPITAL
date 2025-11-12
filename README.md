# 📘 SQL Project: Multi-Domain Database Operations

# Overview

This project demonstrates practical SQL operations using multiple real-world database scenarios — including hospitals, bookstores, universities, and businesses.

Each section progressively builds SQL expertise — from table creation and constraints to joins, views, stored procedures, triggers, and transactions.

# 🏥 Section 1: City Hospital Database – Basic Table Creation

# Key Concepts:

Database and table creation (CREATE DATABASE, CREATE TABLE)

Data insertion (INSERT INTO)

Table modification (ALTER TABLE)

Record updates (UPDATE)

# Example Operations:

Created Patients table with fields like PatientID, PatientName, Age, Gender, AdmissionDate.

Added a new column DoctorAssigned and updated data.

# 📚 Section 2: Bookstore Database – Constraints

# Key Concepts:

Primary and foreign keys

Referential integrity between tables

UNIQUE constraints

# Tables:

Books (Book details)

Orders (Linked to Books using a foreign key)

# Highlight:
Added a UNIQUE constraint on ISBN to ensure no duplicate book entries.

# 🎓 Section 3: University Database – Filters & Conditions

# Key Concepts:

Multiple table creation

Data population for testing queries

Foundation for future joins and filters

# Tables:

Departments, Students, Products, Sales, Employees

# Focus Areas:

Practical examples for filtering, aggregation, and conditional queries.

# 🔗 Section 4: Joins & Union

# Key Concepts:

Understanding relationships using joins

Combining results using UNION

# Tables:

Courses, Enrollments, CurrentEmployees, PastEmployees

# Scenarios:

Students enrolled in courses

Employees comparison between current and past datasets

# 🧮 Section 5: String & Date Functions

# Key Concepts:

String manipulation (UPPER, LOWER, SUBSTRING, CONCAT)

Date operations (DATEDIFF, YEAR, NOW)

User-defined functions (CREATE FUNCTION)

# Example:
Created a reusable function GetFullName() to concatenate first and last names.

# 🧩 Section 6: Stored Procedures & Views

# Key Concepts:

CREATE PROCEDURE for reusable query logic

CREATE VIEW for simplified data access

Joining multiple tables for enriched views

# Highlights:

GetEmployeeDetails() procedure retrieves employee info dynamically.

Created EmployeeDepartmentView and EmployeeFullInfo for integrated data.

# ⚙️ Section 7: Triggers, DCL & TCL

# Key Concepts:

Automation using TRIGGER

User privileges (CREATE USER, GRANT)

Transaction management (COMMIT, ROLLBACK, SAVEPOINT)

# Highlights:

Trigger AfterOrderDelete logs deleted order data into Order_History.

Transactional updates between two accounts simulate money transfer logic.

# 🧾 Skills Demonstrated

✔ Database Design (DDL)

✔ Data Manipulation (DML)

✔ Data Constraints & Integrity

✔ Joins & Unions

✔ String & Date Functions

✔ Stored Procedures & Views

✔ Triggers & Auditing

✔ User Privileges (DCL)

✔ Transaction Control (TCL)
