# E-Commerce Order Analytics System

## Internship Mini Project

**Student Name:** Harshana Yadav  
**Course:** Master of Computer Applications (MCA)  
**Technology Stack:** Python, SQLite, Pandas, Faker  
**Development Environment:** Visual Studio Code

---

# Project Overview

The **E-Commerce Order Analytics System** is an end-to-end data analytics project that simulates a real-world e-commerce environment. The project focuses on generating realistic order datasets, introducing intentional inconsistencies, cleaning and validating the data, storing it in a SQLite database, and performing business analysis using SQL.

The system demonstrates the complete data analytics workflow from raw data generation to business reporting.

---

# Objectives

- Generate realistic e-commerce datasets.
- Introduce intentional data inconsistencies.
- Clean and validate data using Python.
- Store cleaned data in SQLite.
- Perform SQL-based business analysis.
- Generate dynamic reports.
- Handle common edge cases.

---

# Technology Stack

- **Programming Language:** Python 3
- **Database:** SQLite
- **Libraries:**
  - Pandas
  - Faker
  - sqlite3
  - datetime
  - random
- **IDE:** Visual Studio Code

---

# Project Architecture

```
Fake Data Generation
        │
        ▼
    CSV Files
        │
        ▼
Data Cleaning & Validation
        │
        ▼
 Cleaned CSV Files
        │
        ▼
 SQLite Database
        │
        ▼
   SQL Analysis
        │
        ▼
 Business Reports
```

---

# Project Structure

```
ECommerceAnalytics/
│
├── cleaned_data/
│   ├── customers_cleaned.csv
│   ├── orders_cleaned.csv
│   ├── products_cleaned.csv
│   └── order_items_cleaned.csv
│
├── data/
│   ├── customers.csv
│   ├── orders.csv
│   ├── products.csv
│   └── order_items.csv
│
├── database/
│   └── ecommerce.db
│
├── reports/
│   ├── invalid_emails.csv
│   ├── broken_order_references.csv
│   └── issues_report.txt
│
├── generate_data.py
├── clean_data.py
├── load_database.py
├── report.py
├── sql_queries.sql
├── test_cases.py
└── README.md
```

---

# Dataset Description

The project generates four datasets.

## Customers

Contains customer information.

| Column |
|---------|
| customer_id |
| customer_name |
| email |
| registration_date |
| customer_type |

---

## Products

Contains product information.

| Column |
|---------|
| product_id |
| product_name |
| category |
| subcategory |
| cost_price |

---

## Orders

Contains order details.

| Column |
|---------|
| order_id |
| customer_id |
| order_date |
| status |
| region_code |

---

## Order Items

Contains product-level order information.

| Column |
|---------|
| item_id |
| order_id |
| product_id |
| quantity |
| unit_price |
| discount_percent |

---

# Features

- Generate realistic fake datasets
- Create 500+ records for each dataset
- Introduce intentional data inconsistencies
- Clean and standardize datasets
- Validate email addresses
- Check referential integrity
- Load data into SQLite
- Execute advanced SQL queries
- Generate business reports
- Perform edge case testing

---

# Data Generation

The system automatically generates:

- 500 Customers
- 500 Products
- 500 Orders
- 1000 Order Items

Intentional inconsistencies include:

- 5% NULL customer IDs
- 3% Negative quantities
- Incorrect date formats
- Invalid email addresses
- Product names with extra spaces
- Mixed-case product names

---

# Data Cleaning

The project performs the following cleaning operations:

### Orders

- Standardize date format
- Replace missing customer IDs

### Products

- Remove extra spaces
- Convert names to Title Case

### Customers

- Validate email addresses

### Order Items

- Verify referential integrity

---

# Database

The cleaned datasets are loaded into a SQLite database containing four tables:

- customers
- products
- orders
- order_items

---

# SQL Analysis

The project includes the following SQL reports:

### Basic Queries

- Total Revenue by Category
- Top 10 Customers
- Monthly Order Count

### Intermediate Queries

- Customers Without Delivered Orders
- Products With More Returns Than Purchases
- Return Rate by Category

### Advanced Queries

- Running Revenue Totals
- Product Ranking using DENSE_RANK
- Customer Purchase Gap using LAG
- Monthly Revenue Segmentation
- Customer Quartile Analysis
- Year-over-Year Revenue Comparison
- Cohort Analysis
- Frequently Bought Together Products

---

# Reporting System

The command-line reporting tool allows users to generate reports by selecting:

- Daily Report
- Weekly Report
- Monthly Report

The generated report displays:

- Total Orders
- Total Revenue
- Unique Customers
- Top 3 Products
- Revenue Comparison with Previous Period

---

# Edge Case Testing

The project validates several important scenarios:

- Invalid order references
- Discount percentage greater than 100
- Zero quantity orders
- Future order dates

---

# Future Enhancements

- Interactive Dashboard using Power BI
- Web Application using Flask or Django
- Real-time Order Tracking
- Machine Learning Sales Forecasting
- Product Recommendation Engine
- Cloud Database Integration
- REST API Support

---

# Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/ECommerceAnalytics.git
```

Move into the project directory:

```bash
cd ECommerceAnalytics
```

Create a virtual environment:

```bash
python -m venv venv
```

Activate the environment:

**Windows**

```bash
venv\Scripts\activate
```

Install dependencies:

```bash
pip install pandas faker
```

---

# Running the Project

Generate data:

```bash
python generate_data.py
```

Clean data:

```bash
python clean_data.py
```

Load data into SQLite:

```bash
python load_database.py
```

Execute SQL queries from:

```
sql_queries.sql
```

Generate reports:

```bash
python report.py
```

Run edge case tests:

```bash
python test_cases.py
```

---

# Sample Outputs

The project generates:

- Raw CSV datasets
- Cleaned CSV datasets
- SQLite database
- Invalid email report
- Referential integrity report
- Business analytics reports

---

# Conclusion

The E-Commerce Order Analytics System demonstrates a complete data analytics workflow by combining Python, SQLite, and SQL. It covers realistic data generation, data cleaning, validation, database management, analytical querying, reporting, and edge case handling. The project highlights practical skills in data engineering, SQL analytics, and business intelligence while following a modular and scalable project structure.

---

## Author

**Harshana Yadav**
