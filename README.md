# Banking Transaction Analytics — SQL Project

## Objective
Analyze customer banking behavior, transaction trends, fraud patterns, 
and payment channel usage using a relational database built in MySQL.

---

## Tools Used
- Database: MySQL 8.0
- IDE: MySQL Workbench  
- Language: SQL (DDL, DML, Analytical Queries)
- Dataset: Mock data representing Indian banking transactions

---

## Database Schema

Three tables:

- customers — 200 records — customer name, age, city, account type
- accounts — 200 records — account balance and opening date
- transactions — 500 records — amount, channel, type, date, status

Relationships:
- customers to accounts — one to one via customer_id
- accounts to transactions — one to many via account_id

---

## Business Questions Answered

1. Who are the top 10 highest spending customers?
2. What is the month on month transaction growth trend?
3. Which cities generate the highest transaction volume?
4. Which accounts have repeated fraud flags or failed transactions?
5. What is the most used payment channel per city?
6. Which customers hold above average account balances?
7. What is the running transaction total per account over time?

---

## Key Insights from the Data

- Top 10 customers contribute approximately 58% of total debit volume
- RTGS and UPI are the most frequently used payment channels
- Flagged transactions are concentrated in high balance accounts above 2,00,000
- Peak transaction activity observed in Q3 2024 based on monthly trend
- Delhi and Bangalore lead all cities in total transaction volume

---

## SQL Concepts Used

- Multi-table JOINs across 3 tables
- GROUP BY with HAVING for conditional aggregation
- Subqueries for average balance comparison
- CTEs using WITH clause for monthly growth and channel analysis
- Window Functions: RANK(), LAG(), SUM() OVER() with PARTITION BY
- Date functions: DATE_FORMAT for monthly grouping
- Aggregate functions: SUM, COUNT, AVG, ROUND

---

## Project Structure

- schema.sql — table creation scripts
- mock_data.sql — insert statements for all 500 rows
- queries/Basic_Queries.sql — filters, counts, simple aggregations
- queries/intermediate_queries.sql — JOINs, monthly trends, city analysis
- queries/Advanced_Queries.sql — CTEs, window functions, fraud detection

---

## How to Run

1. Open MySQL Workbench and connect to local server
2. Run schema.sql to create the database and tables
3. Run mock_data.sql to load all records
4. Open any file in the queries folder and execute

---

## Author

Arunkumar Shivanand Hallad 

MBA — Finance and Business Analytics  
Acharya Bangalore B-School, Bengaluru  
SEBI Investor Certified
