from pyspark.sql import SparkSession
from pyspark.sql.functions import col, count, sum, avg, min, max

# Create Spark session
spark = SparkSession.builder \
    .appName("Employee Data Processing") \
    .getOrCreate()

# Load dataset
employees = spark.read.csv(
    "data/employees.csv",
    header=True,
    inferSchema=True
)

print("\nOriginal Dataset")
employees.show()

print("\nSchema Information")
employees.printSchema()

# Remove duplicate records
clean_data = employees.dropDuplicates()

print("\nAfter Removing Duplicates")
clean_data.show()

# Handle missing values
clean_data = clean_data.fillna({
    "age": 0,
    "salary": 0,
    "department": "Unknown",
    "region": "Unknown"
})

print("\nAfter Handling Missing Values")
clean_data.show()

# Rename department column
clean_data = clean_data.withColumnRenamed(
    "department",
    "department_name"
)

# Convert salary to double type
clean_data = clean_data.withColumn(
    "salary",
    col("salary").cast("double")
)

print("\nEmployees Between Age 25 and 40")
clean_data.filter(
    (col("age") >= 25) &
    (col("age") <= 40)
).show()

print("\nIT Department Employees")
clean_data.filter(
    col("department_name") == "IT"
).show()

print("\nEmployees From North Region")
clean_data.filter(
    col("region") == "North"
).show()

print("\nAggregate Statistics")

clean_data.select(
    count("*").alias("total_employees")
).show()

clean_data.select(
    sum("salary").alias("total_salary")
).show()

clean_data.select(
    avg("salary").alias("average_salary")
).show()

clean_data.select(
    min("salary").alias("minimum_salary")
).show()

clean_data.select(
    max("salary").alias("maximum_salary")
).show()

print("\nDepartment Wise Summary")

department_summary = clean_data.groupBy(
    "department_name"
).agg(
    count("*").alias("employee_count"),
    avg("salary").alias("average_salary"),
    sum("salary").alias("total_salary")
)

department_summary.show()

print("\nDepartments Having More Than One Employee")

department_summary.filter(
    col("employee_count") > 1
).show()

print("\nFinal Processing Pipeline")

final_result = (
    employees
    .dropDuplicates()
    .fillna({
        "age": 0,
        "salary": 0,
        "department": "Unknown",
        "region": "Unknown"
    })
    .withColumnRenamed("department", "department_name")
    .groupBy("department_name")
    .agg(
        count("*").alias("employee_count"),
        avg("salary").alias("average_salary")
    )
)

final_result.show()

spark.stop()