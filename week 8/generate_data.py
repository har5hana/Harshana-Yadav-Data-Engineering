import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os

fake = Faker()

# ==========================
# Configuration
# ==========================

NUM_CUSTOMERS = 500
NUM_PRODUCTS = 500
NUM_ORDERS = 500
NUM_ORDER_ITEMS = 1000

os.makedirs("data", exist_ok=True)

# ==========================
# Generate Customers
# ==========================

customers = []

customer_types = ["REGULAR", "PREMIUM", "VIP"]

for i in range(1, NUM_CUSTOMERS + 1):

    customer_id = f"C{i:04d}"
    name = fake.name()

    email = fake.email()

    # 2% invalid emails
    if random.random() < 0.02:
        email = email.replace("@", "")

    registration_date = fake.date_between(
        start_date="-3y",
        end_date="today"
    )

    customer_type = random.choice(customer_types)

    customers.append([
        customer_id,
        name,
        email,
        registration_date,
        customer_type
    ])

customers_df = pd.DataFrame(
    customers,
    columns=[
        "customer_id",
        "customer_name",
        "email",
        "registration_date",
        "customer_type"
    ]
)

customers_df.to_csv("data/customers.csv", index=False)

print("customers.csv created")

# ==========================
# Generate Products
# ==========================

categories = {
    "Electronics": [
        "Laptop",
        "Mobile",
        "Keyboard",
        "Mouse",
        "Headphones"
    ],
    "Clothing": [
        "T-Shirt",
        "Jeans",
        "Jacket",
        "Shoes",
        "Cap"
    ],
    "Books": [
        "Python Book",
        "SQL Guide",
        "Data Science",
        "AI Basics",
        "Algorithms"
    ],
    "Home": [
        "Chair",
        "Table",
        "Lamp",
        "Bottle",
        "Sofa"
    ]
}

products = []

product_number = 1

for category in categories:

    for sub in categories[category]:

        for j in range(25):

            product_id = f"P{product_number:04d}"

            name = sub

            if random.random() < 0.05:
                name = "  " + name.upper() + "  "

            cost_price = random.randint(100, 50000)

            products.append([
                product_id,
                name,
                category,
                sub,
                cost_price
            ])

            product_number += 1

while len(products) < NUM_PRODUCTS:

    category = random.choice(list(categories.keys()))
    sub = random.choice(categories[category])

    product_id = f"P{product_number:04d}"

    name = sub

    cost_price = random.randint(100, 50000)

    products.append([
        product_id,
        name,
        category,
        sub,
        cost_price
    ])

    product_number += 1

products_df = pd.DataFrame(
    products,
    columns=[
        "product_id",
        "product_name",
        "category",
        "subcategory",
        "cost_price"
    ]
)

products_df.to_csv("data/products.csv", index=False)

print("products.csv created")

# ==========================
# Generate Orders
# ==========================

statuses = [
    "PLACED",
    "SHIPPED",
    "DELIVERED",
    "CANCELLED",
    "RETURNED"
]

regions = [
    "NORTH",
    "SOUTH",
    "EAST",
    "WEST"
]

orders = []

for i in range(1, NUM_ORDERS + 1):

    order_id = f"O{i:04d}"

    customer_id = f"C{random.randint(1, NUM_CUSTOMERS):04d}"

    # 5% NULL customer IDs
    if random.random() < 0.05:
        customer_id = ""

    order_date = fake.date_time_between(
        start_date="-2y",
        end_date="now"
    )

    # Wrong date format
    if random.random() < 0.05:
        order_date = order_date.strftime("%d-%m-%Y")
    else:
        order_date = order_date.strftime("%Y-%m-%d %H:%M:%S")

    status = random.choice(statuses)

    region = random.choice(regions)

    orders.append([
        order_id,
        customer_id,
        order_date,
        status,
        region
    ])

orders_df = pd.DataFrame(
    orders,
    columns=[
        "order_id",
        "customer_id",
        "order_date",
        "status",
        "region_code"
    ]
)

orders_df.to_csv("data/orders.csv", index=False)

print("orders.csv created")

# ==========================
# Generate Order Items
# ==========================

order_items = []

for i in range(1, NUM_ORDER_ITEMS + 1):

    item_id = f"I{i:05d}"

    order_id = f"O{random.randint(1, NUM_ORDERS):04d}"

    product_id = f"P{random.randint(1, NUM_PRODUCTS):04d}"

    quantity = random.randint(1, 5)

    # 3% negative quantity
    if random.random() < 0.03:
        quantity *= -1

    unit_price = random.randint(100, 50000)

    discount = random.randint(0, 40)

    order_items.append([
        item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        discount
    ])

order_items_df = pd.DataFrame(
    order_items,
    columns=[
        "item_id",
        "order_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount_percent"
    ]
)

order_items_df.to_csv("data/order_items.csv", index=False)

print("order_items.csv created")

print("\nAll CSV files generated successfully.")