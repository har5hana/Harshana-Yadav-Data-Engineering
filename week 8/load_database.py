import sqlite3
import pandas as pd
import os

# Create database folder if it doesn't exist
os.makedirs("database", exist_ok=True)

# Connect to SQLite database
conn = sqlite3.connect("database/ecommerce.db")

print("Connected to SQLite Database")

# Read cleaned CSV files
customers = pd.read_csv("cleaned_data/customers_cleaned.csv")
products = pd.read_csv("cleaned_data/products_cleaned.csv")
orders = pd.read_csv("cleaned_data/orders_cleaned.csv")
order_items = pd.read_csv("cleaned_data/order_items_cleaned.csv")

# Load data into SQLite tables
customers.to_sql("customers", conn, if_exists="replace", index=False)
products.to_sql("products", conn, if_exists="replace", index=False)
orders.to_sql("orders", conn, if_exists="replace", index=False)
order_items.to_sql("order_items", conn, if_exists="replace", index=False)

print("Customers table created")
print("Products table created")
print("Orders table created")
print("Order Items table created")

# Verify row counts
tables = ["customers", "products", "orders", "order_items"]

print("\nRow Counts:")
for table in tables:
    count = pd.read_sql(f"SELECT COUNT(*) AS total FROM {table}", conn)
    print(f"{table}: {count.iloc[0]['total']} rows")

conn.commit()
conn.close()

print("\nDatabase created successfully!")