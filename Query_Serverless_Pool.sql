-- Retrieve top 100 rows
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://twdp203datalake.dfs.core.windows.net/data/sale-small/Year=2019/Quarter=Q4/Month=12/Day=20191231/sale-small-20191231-snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]

-- Modify query to perform aggregates and grouping to better understand the data
SELECT
    TransactionDate, ProductId,
        CAST(SUM(ProfitAmount) AS decimal(18,2)) AS [(sum) Profit],
        CAST(AVG(ProfitAmount) AS decimal(18,2)) AS [(avg) Profit],
        SUM(Quantity) AS [(sum) Quantity]
FROM
    OPENROWSET(
        BULK 'https://twdp203datalake.dfs.core.windows.net/data/sale-small/Year=2019/Quarter=Q4/Month=12/Day=20191231/sale-small-20191231-snappy.parquet',
        FORMAT='PARQUET'
    ) AS [r] GROUP BY r.TransactionDate, r.ProductId;

-- How many records are contained within the Parquet for all 2019
SELECT
    COUNT(*)
FROM
    OPENROWSET(
        BULK 'https://twdp203datalake.dfs.core.windows.net/data/sale-small/Year=2019/*/*/*/*',
        FORMAT='PARQUET'
    ) AS [r];

-- Instead of OPENROWSET, let's create an external table
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'data_twdp203datalake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [data_twdp203datalake_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://data@twdp203datalake.dfs.core.windows.net' 
	)
GO

USE demo
CREATE EXTERNAL TABLE All2019Sales (
	[TransactionId] nvarchar(4000),
	[CustomerId] int,
	[ProductId] smallint,
	[Quantity] smallint,
	[Price] numeric(38,18),
	[TotalAmount] numeric(38,18),
	[TransactionDate] int,
	[ProfitAmount] numeric(38,18),
	[Hour] smallint,
	[Minute] smallint,
	[StoreId] smallint
	)
	WITH (
	LOCATION = 'sale-small/Year=2019/Quarter=Q4/Month=12/Day=20191231/sale-small-20191231-snappy.parquet',
	DATA_SOURCE = [data_twdp203datalake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.All2019Sales
GO










