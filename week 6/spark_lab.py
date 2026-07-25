from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import *

# -----------------------------------
# Create Spark Session
# -----------------------------------

spark = SparkSession.builder \
    .appName("Employee Data Analysis") \
    .getOrCreate()

print("\nSpark Session Created Successfully")

# -----------------------------------
# Read CSV
# -----------------------------------

df = spark.read.csv(
    "data/employees.csv",
    header=True,
    inferSchema=True
)

print("\nOriginal Dataset")
df.show()

# -----------------------------------
# Display Schema
# -----------------------------------

print("\nSchema")
df.printSchema()

# -----------------------------------
# Manual Schema
# -----------------------------------

schema = StructType([
    StructField("EmployeeID", IntegerType(), True),
    StructField("Name", StringType(), True),
    StructField("Age", IntegerType(), True),
    StructField("Gender", StringType(), True),
    StructField("Department", StringType(), True),
    StructField("Designation", StringType(), True),
    StructField("Experience", IntegerType(), True),
    StructField("Salary", IntegerType(), True),
    StructField("Bonus", IntegerType(), True),
    StructField("City", StringType(), True),
    StructField("PerformanceRating", DoubleType(), True)
])

manual_df = spark.read.csv(
    "data/employees.csv",
    header=True,
    schema=schema
)

print("\nManual Schema")
manual_df.printSchema()

# -----------------------------------
# Select Columns
# -----------------------------------

print("\nSelected Columns")
df.select(
    "Name",
    "Department",
    "Salary"
).show()

# -----------------------------------
# Filter Employees
# -----------------------------------

print("\nSalary Greater Than 70000")

high_salary = df.filter(
    col("Salary") > 70000
)

high_salary.show()

# -----------------------------------
# Rename Column
# -----------------------------------

df = df.withColumnRenamed(
    "Salary",
    "MonthlySalary"
)

# -----------------------------------
# Cast Age
# -----------------------------------

df = df.withColumn(
    "Age",
    col("Age").cast("double")
)

# -----------------------------------
# Add Annual Salary
# -----------------------------------

df = df.withColumn(
    "AnnualSalary",
    col("MonthlySalary") * 12
)

print("\nAnnual Salary")
df.show()

# -----------------------------------
# Handle Null Values
# -----------------------------------

print("\nNull Values Filled")

filled = df.na.fill({
    "Age":0,
    "MonthlySalary":0,
    "Bonus":0
})

filled.show()

print("\nDrop Null Rows")

clean = df.na.drop()

clean.show()

# -----------------------------------
# Remove Duplicates
# -----------------------------------

print("\nDuplicates Removed")

df.dropDuplicates().show()

# -----------------------------------
# Sort
# -----------------------------------

print("\nHighest Salary")

df.orderBy(
    col("MonthlySalary").desc()
).show()

# -----------------------------------
# Group By
# -----------------------------------

print("\nDepartment Wise Employee Count")

df.groupBy(
    "Department"
).count().show()

print("\nAverage Salary")

df.groupBy(
    "Department"
).agg(
    avg("MonthlySalary").alias("AverageSalary")
).show()

# -----------------------------------
# Aggregations
# -----------------------------------

print("\nMaximum Salary")

df.select(
    max("MonthlySalary")
).show()

print("\nMinimum Salary")

df.select(
    min("MonthlySalary")
).show()

print("\nAverage Salary")

df.select(
    avg("MonthlySalary")
).show()

# -----------------------------------
# Lazy Evaluation
# -----------------------------------

lazy = df.filter(
    col("MonthlySalary") > 70000
)

print("\nLazy Evaluation Example")

lazy.show()

# -----------------------------------
# DAG
# -----------------------------------

print("\nExecution Plan")

lazy.select(
    "Name",
    "Department"
).explain(True)

# -----------------------------------
# Wide Transformation
# -----------------------------------

print("\nWide Transformation")

df.groupBy(
    "City"
).count().show()

# -----------------------------------
# Save CSV
# -----------------------------------

df.write.mode(
    "overwrite"
).option(
    "header",
    True
).csv(
    "output/csv"
)

# -----------------------------------
# Save Parquet
# -----------------------------------

df.write.mode(
    "overwrite"
).parquet(
    "output/parquet"
)

# -----------------------------------
# Read Parquet
# -----------------------------------

print("\nRead Parquet")

parquet = spark.read.parquet(
    "output/parquet"
)

parquet.show()

# -----------------------------------
# Complete Pipeline
# -----------------------------------

print("\nFinal Pipeline")

pipeline = (
    spark.read.csv(
        "data/employees.csv",
        header=True,
        inferSchema=True
    )
    .na.fill({"Salary":0})
    .filter(col("Salary") > 60000)
    .withColumnRenamed(
        "Salary",
        "MonthlySalary"
    )
    .withColumn(
        "AnnualSalary",
        col("MonthlySalary") * 12
    )
    .select(
        "Name",
        "Department",
        "MonthlySalary",
        "AnnualSalary",
        "PerformanceRating"
    )
)

pipeline.show()

pipeline.write.mode(
    "overwrite"
).parquet(
    "output/final"
)

print("\nPipeline Saved Successfully")

spark.stop()