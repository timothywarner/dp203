# DP-203 Table of Contents

## DAY 1

### Design and Implement Data Storage

* Blob storage
* Data Lake storage
  * Blob access tiering
    * Lifecycle management
    * File format choice (Avro, CSV, Parquet, ORC)
* HDInsight
* Databricks
  * Premium SKU for cluster autoscaling
  * Cluster type (high concurrency)
  * Load into data frame, transform, write to DLS
* Synapse
  * SQL Pool
    * Distributions
      * Partitioning T-SQL
    * Partition swi5tch and drop
    * Slowly changing dimensions
      * Types
  * Spark Pool

### Design and Implement Data Security

* At-rest data encryption
  * TDE
  * Key Vaults
* Write encrypted data to tables or Parquet files
* Dynamic Data Masking
* Data Classification
* Row-level security
* Data retention / purge
* RBAC
  * Managed identities
  * Resources (Synapse Studio > Manage > Access Ctrl)
  * DLS POSIX ACLs
* SQL Server and database firewall rules
* Automatic tuning (server, db level)

AZURE POLICY FOR DATABRICKS AND SYNAPSE

## DAY 2

### Design and Develop Data Processing

* ELT Data Transformations
  * Spark / Databricks
  * Data Factory
  * Synapse pipelines
* Streaming Data Processing
  * Streaming Units
  * Event Hub/IoT Hub
  * Stream Analytics
    * Windowing aggregates
    * DATEDIFF, LAST, LAG and LIMIT DURATION functions
    * Protobuff deserializer as input
    * Power BI output
* Batch processing solutions
  * PolyBase
  * Data Factory
    * Copy activity
    * Conditional split and sink transformations
    * View flow source code
    * Runtimes
    * Triggers

### Monitor and Optimize Data Storage and Data Processing

* Azure Monitor metrics, logs, alerts
* Monitoring pipelines
  * ADF run data 45 min; Log Analytics for 2 years
* Measure query / cluster performance
* Spark DAG
* Power BI output

### DP-203 Exam Strategy

* Item types & techniques
* Online testing process
  * Grievances/problem resolution
* After the exam (dashboard, badge)
* Renewals
* Practice exams/questions
* Hands-on labs





=================

* Security
  * Lifecycle management policy
  * TDE for storage, SQL, Synapse
  * DDM
  * Databricks / ScalaAgape112mic
  *

* Batch Processing / Automation
  * ADF copy activity
  * Synapse SCD example

* Stream Processing
  * Event Hub / IoT Hub
  * Stream Analytics
  * Cosmos
  * Windowing aggregates
  * DATEDIFF, LAST, LAG and LIMIT DURATION functions
  * Protobuff deserializer as input
  * Streaming units

* Monitoring
  * Log Analytics
  * Insights

* Exam Stuff
  * Online testing tips
  * Whizlabs practice questions



AZURE POLICY RESOURCES


















