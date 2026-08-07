import pandas as pd
import re
import os

os.makedirs("cleaned_data", exist_ok=True)
os.makedirs("reports", exist_ok=True)

# ===========================
# Load CSV Files
# ===========================

orders = pd.read_csv("data/orders.csv")
products = pd.read_csv("data/products.csv")
customers = pd.read_csv("data/customers.csv")
order_items = pd.read_csv("data/order_items.csv")

issues = []

# ===========================
# clean_orders()
# ===========================

def clean_orders():

    global orders

    # Fix NULL customer IDs
    null_count = orders["customer_id"].isna().sum()

    orders["customer_id"] = orders["customer_id"].fillna("UNKNOWN")

    issues.append(f"NULL customer IDs fixed: {null_count}")

    # Fix date formats
    fixed = 0

    def convert_date(x):
        global fixed

        try:
            return pd.to_datetime(x).strftime("%Y-%m-%d %H:%M:%S")
        except:
            try:
                fixed += 1
                return pd.to_datetime(
                    x,
                    format="%d-%m-%Y"
                ).strftime("%Y-%m-%d %H:%M:%S")
            except:
                return x

    orders["order_date"] = orders["order_date"].apply(convert_date)

    issues.append(f"Wrong date formats corrected: {fixed}")

# ===========================
# clean_products()
# ===========================

def clean_products():

    global products

    products["product_name"] = (
        products["product_name"]
        .str.strip()
        .str.title()
    )

    issues.append("Product names normalized.")

# ===========================
# validate_emails()
# ===========================

def validate_emails():

    pattern = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

    invalid = customers[
        ~customers["email"].astype(str).str.match(pattern)
    ]

    issues.append(f"Invalid emails found: {len(invalid)}")

    return invalid

# ===========================
# check_referential_integrity()
# ===========================

def check_referential_integrity():

    invalid = order_items[
        ~order_items["order_id"].isin(
            orders["order_id"]
        )
    ]

    issues.append(
        f"Broken order references: {len(invalid)}"
    )

    return invalid

# ===========================
# Run Cleaning
# ===========================

clean_orders()
clean_products()

invalid_emails = validate_emails()
bad_orders = check_referential_integrity()

# ===========================
# Save Cleaned Files
# ===========================

orders.to_csv(
    "cleaned_data/orders_cleaned.csv",
    index=False
)

products.to_csv(
    "cleaned_data/products_cleaned.csv",
    index=False
)

customers.to_csv(
    "cleaned_data/customers_cleaned.csv",
    index=False
)

order_items.to_csv(
    "cleaned_data/order_items_cleaned.csv",
    index=False
)

invalid_emails.to_csv(
    "reports/invalid_emails.csv",
    index=False
)

bad_orders.to_csv(
    "reports/broken_order_references.csv",
    index=False
)

with open("reports/issues_report.txt", "w") as f:

    for issue in issues:
        f.write(issue + "\n")

print("Cleaning completed successfully.")