import sqlite3

conn = sqlite3.connect("database/ecommerce.db")
cursor = conn.cursor()

print("=" * 50)
print("E-Commerce Analytics Reporting System")
print("=" * 50)

report_type = input("Enter report type (daily/weekly/monthly): ").lower()

start_date = input("Enter start date (YYYY-MM-DD): ")
end_date = input("Enter end date (YYYY-MM-DD): ")

print("\nGenerating Report...\n")

# Total Orders
cursor.execute("""
SELECT COUNT(*)
FROM orders
WHERE DATE(order_date) BETWEEN ? AND ?
""", (start_date, end_date))

total_orders = cursor.fetchone()[0]

# Revenue
cursor.execute("""
SELECT ROUND(SUM(quantity*unit_price*(1-discount_percent/100.0)),2)
FROM order_items oi
JOIN orders o
ON oi.order_id=o.order_id
WHERE DATE(o.order_date) BETWEEN ? AND ?
""", (start_date, end_date))

revenue = cursor.fetchone()[0]

# Unique Customers
cursor.execute("""
SELECT COUNT(DISTINCT customer_id)
FROM orders
WHERE DATE(order_date) BETWEEN ? AND ?
""", (start_date, end_date))

customers = cursor.fetchone()[0]

# Top 3 Products
cursor.execute("""
SELECT
p.product_name,
SUM(oi.quantity) total_qty

FROM order_items oi

JOIN products p

ON oi.product_id=p.product_id

JOIN orders o

ON oi.order_id=o.order_id

WHERE DATE(o.order_date) BETWEEN ? AND ?

GROUP BY p.product_name

ORDER BY total_qty DESC

LIMIT 3
""", (start_date, end_date))

top_products = cursor.fetchall()

print("=" * 40)
print(f"Report Type : {report_type.title()}")
print(f"From : {start_date}")
print(f"To   : {end_date}")
print("=" * 40)

print(f"Total Orders      : {total_orders}")
print(f"Revenue           : {revenue}")
print(f"Unique Customers  : {customers}")

print("\nTop 3 Products")

for product in top_products:
    print(f"{product[0]} --> {product[1]} sold")

# Previous Period Comparison
cursor.execute("""
SELECT ROUND(SUM(quantity*unit_price*(1-discount_percent/100.0)),2)

FROM order_items oi

JOIN orders o

ON oi.order_id=o.order_id

WHERE DATE(o.order_date)
BETWEEN DATE(?,'-30 day')
AND DATE(?,'-30 day')
""", (start_date, end_date))

previous = cursor.fetchone()[0]

if previous and revenue:
    change = ((revenue - previous) / previous) * 100
    print(f"\nRevenue Change : {change:.2f}%")
else:
    print("\nRevenue Change : Not enough previous data")

conn.close()