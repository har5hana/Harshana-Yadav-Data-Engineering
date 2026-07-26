from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import *
spark=SparkSession.builder.appName("employee data analysis").getOrCreate()
print("\nspark session created successfully")
df=spark.read.csv("data/employees.csv",header=True,inferSchema=True)
print("\noriginal dataset")
df.show()
print("\nschema")
df.printSchema()
schema=StructType([
    StructField("EmployeeID",IntegerType(),True),
    StructField("Name",StringType(),True),
    StructField("Age",IntegerType(),True),
    StructField("Gender",StringType(),True),
    StructField("Department",StringType(),True),
    StructField("Designation",StringType(),True),
    StructField("Experience",IntegerType(),True),
    StructField("Salary",IntegerType(),True),
    StructField("Bonus",IntegerType(),True),
    StructField("City",StringType(),True),
    StructField("PerformanceRating",DoubleType(),True)
])
manual_df=spark.read.csv("data/employees.csv",header=True,schema=schema)
print("\nmanual schema")
manual_df.printSchema()
print("\nselected columns")
df.select("Name","Department","Salary").show()
print("\nsalary greater than 70000")
high_salary=df.filter(col("Salary")>70000)
high_salary.show()
df=df.withColumnRenamed("Salary","MonthlySalary")
df=df.withColumn("Age",col("Age").cast("double"))
df=df.withColumn("AnnualSalary",col("MonthlySalary")*12)
print("\nannual salary")
df.show()
print("\nnull values filled")
filled=df.na.fill({
    "Age":0,
    "MonthlySalary":0,
    "Bonus":0
})
filled.show()
print("\ndrop null rows")
clean=df.na.drop()
clean.show()
print("\nduplicates removed")
df.dropDuplicates().show()
print("\nhighest salary")
df.orderBy(col("MonthlySalary").desc()).show()
print("\ndepartment wise employee count")
df.groupBy("Department").count().show()
print("\naverage salary")
df.groupBy("Department").agg(avg("MonthlySalary").alias("AverageSalary")).show()
print("\nmaximum salary")
df.select(max("MonthlySalary")).show()
print("\nminimum salary")
df.select(min("MonthlySalary")).show()
print("\naverage salary")
df.select(avg("MonthlySalary")).show()
lazy=df.filter(col("MonthlySalary")>70000)
print("\nlazy evaluation example")
lazy.show()
print("\nexecution plan")
lazy.select("Name","Department").explain(True)
print("\nwide transformation")
df.groupBy("City").count().show()
df.write.mode("overwrite").option("header",True).csv("output/csv")
df.write.mode("overwrite").parquet("output/parquet")
print("\nread parquet")
parquet=spark.read.parquet("output/parquet")
parquet.show()
print("\nfinal pipeline")
pipeline=(spark.read.csv("data/employees.csv",header=True,inferSchema=True)
    .na.fill({"Salary":0})
    .filter(col("Salary")>60000)
    .withColumnRenamed("Salary","MonthlySalary")
    .withColumn("AnnualSalary",col("MonthlySalary")*12)
    .select("Name","Department","MonthlySalary","AnnualSalary","PerformanceRating")
)
pipeline.show()
pipeline.write.mode("overwrite").parquet("output/final")
print("\npipeline saved successfully")
spark.stop()