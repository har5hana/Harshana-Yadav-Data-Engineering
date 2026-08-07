import pandas as pd

orders = pd.read_csv("cleaned_data/orders_cleaned.csv")
order_items = pd.read_csv("cleaned_data/order_items_cleaned.csv")

print("=" * 50)
print("EDGE CASE TESTS")
print("=" * 50)

# Test 1
print("\nTest 1: Invalid Order IDs")

invalid = order_items[
    ~order_items["order_id"].isin(orders["order_id"])
]

print("Invalid References:", len(invalid))

# Test 2
print("\nTest 2: Discount > 100")

bad_discount = order_items[
    order_items["discount_percent"] > 100
]

print("Rows:", len(bad_discount))

# Test 3
print("\nTest 3: Quantity = 0")

zero_qty = order_items[
    order_items["quantity"] == 0
]

print("Rows:", len(zero_qty))

# Test 4
print("\nTest 4: Future Dates")

today = pd.Timestamp.today()

future = pd.to_datetime(
    orders["order_date"],
    errors="coerce"
)

future = future[future > today]

print("Future Orders:", len(future))

print("\nAll tests completed.")