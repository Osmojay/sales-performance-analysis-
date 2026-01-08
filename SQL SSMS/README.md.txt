📦 Customer & Load Performance Analysis (SQL Server)
📌 Project Overview

This project demonstrates end-to-end SQL data analysis using Microsoft SQL Server (SSMS).
I designed the database schema, created the data manually, and performed analytical queries to answer real-world business questions related to customer performance, shipment volume, and revenue impact.

The project simulates a logistics / transportation business with customer accounts and shipment (load) transactions.

🛠 Tools & Technologies

Microsoft SQL Server (SSMS)

SQL (DDL, DML, Joins, Aggregations)

GitHub (portfolio documentation)

🧱 Database Design

The database contains two related tables:

1️⃣ Customers Table

Stores customer-level and contract information.

Key fields:

customer_id (Primary Key)

customer_name

customer_type (Contract, Spot, Dedicated)

credit_terms_days

account_status

contract_start_date

annual_revenue_potential

2️⃣ Loads Table

Stores transactional shipment data.

Key fields:

load_id (Primary Key)

customer_id (Foreign Key)

load_date

load_type

revenue

fuel_surcharge

accessorial_charges

load_status (Completed / Cancelled)

booking_type

A one-to-many relationship exists between customers and loads.

🧪 Data Creation

All data used in this project was created and inserted manually using SQL scripts.

Included:

Table creation (DDL)

Primary & foreign key relationships

Sample customer data

Sample load transactions

This ensures full ownership of the data and allows realistic analytical scenarios.

📄 Script: 00_data_creation.sql

📊 Analysis Performed

The project focuses on answering business-driven questions, including:

🔹 Aggregations

Total revenue by customer

Load volume by booking type

Monthly shipment trends

Average revenue per load

🔹 Filtering

WHERE, IN, NOT IN

LIKE for pattern matching

Status-based filtering (Completed vs Cancelled)

🔹 JOIN Analysis

Customer performance analysis

Revenue contribution per customer

Customers with no load activity

Top-performing customers

🔹 Advanced SQL

Common Table Expressions (CTEs)

Subqueries

Window functions (RANK, ROW_NUMBER, running totals)

Conditional aggregation using CASE WHEN