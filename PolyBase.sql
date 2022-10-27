CREATE MASTER KEY;

-- Where's the blob?
CREATE EXTERNAL DATA SOURCE WWIStorage
WITH
(
    TYPE = Hadoop,
    LOCATION = 'wasbs://wideworldimporters@sqldwholdata.blob.core.windows.net'
);

-- What's the file format?
CREATE EXTERNAL FILE FORMAT TextFileFormat
WITH
(
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS
    (
        FIELD_TERMINATOR = '|',
        USE_TYPE_DEFAULT = FALSE
    )
);

-- Create schema for extenal file format
CREATE SCHEMA ext;
GO
CREATE SCHEMA wwi;

-- Create the external tables
CREATE EXTERNAL TABLE [ext].[dimension_City](
    [City Key] [int] NOT NULL,
    [WWI City ID] [int] NOT NULL,
    [City] [nvarchar](50) NOT NULL,
    [State Province] [nvarchar](50) NOT NULL,
    [Country] [nvarchar](60) NOT NULL,
    [Continent] [nvarchar](30) NOT NULL,
    [Sales Territory] [nvarchar](50) NOT NULL,
    [Region] [nvarchar](30) NOT NULL,
    [Subregion] [nvarchar](30) NOT NULL,
    [Location] [nvarchar](76) NULL,
    [Latest Recorded Population] [bigint] NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH (LOCATION='/v1/dimension_City/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[dimension_Customer] (
    [Customer Key] [int] NOT NULL,
    [WWI Customer ID] [int] NOT NULL,
    [Customer] [nvarchar](100) NOT NULL,
    [Bill To Customer] [nvarchar](100) NOT NULL,
       [Category] [nvarchar](50) NOT NULL,
    [Buying Group] [nvarchar](50) NOT NULL,
    [Primary Contact] [nvarchar](50) NOT NULL,
    [Postal Code] [nvarchar](10) NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH (LOCATION='/v1/dimension_Customer/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[dimension_Employee] (
    [Employee Key] [int] NOT NULL,
    [WWI Employee ID] [int] NOT NULL,
    [Employee] [nvarchar](50) NOT NULL,
    [Preferred Name] [nvarchar](50) NOT NULL,
    [Is Salesperson] [bit] NOT NULL,
    [Photo] [varbinary](300) NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION='/v1/dimension_Employee/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[dimension_PaymentMethod] (
    [Payment Method Key] [int] NOT NULL,
    [WWI Payment Method ID] [int] NOT NULL,
    [Payment Method] [nvarchar](50) NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/dimension_PaymentMethod/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[dimension_StockItem](
    [Stock Item Key] [int] NOT NULL,
    [WWI Stock Item ID] [int] NOT NULL,
    [Stock Item] [nvarchar](100) NOT NULL,
    [Color] [nvarchar](20) NOT NULL,
    [Selling Package] [nvarchar](50) NOT NULL,
    [Buying Package] [nvarchar](50) NOT NULL,
    [Brand] [nvarchar](50) NOT NULL,
    [Size] [nvarchar](20) NOT NULL,
    [Lead Time Days] [int] NOT NULL,
    [Quantity Per Outer] [int] NOT NULL,
    [Is Chiller Stock] [bit] NOT NULL,
    [Barcode] [nvarchar](50) NULL,
    [Tax Rate] [decimal](18, 3) NOT NULL,
    [Unit Price] [decimal](18, 2) NOT NULL,
    [Recommended Retail Price] [decimal](18, 2) NULL,
    [Typical Weight Per Unit] [decimal](18, 3) NOT NULL,
    [Photo] [varbinary](300) NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/dimension_StockItem/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[dimension_Supplier](
    [Supplier Key] [int] NOT NULL,
    [WWI Supplier ID] [int] NOT NULL,
    [Supplier] [nvarchar](100) NOT NULL,
    [Category] [nvarchar](50) NOT NULL,
    [Primary Contact] [nvarchar](50) NOT NULL,
    [Supplier Reference] [nvarchar](20) NULL,
    [Payment Days] [int] NOT NULL,
    [Postal Code] [nvarchar](10) NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/dimension_Supplier/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[dimension_TransactionType](
    [Transaction Type Key] [int] NOT NULL,
    [WWI Transaction Type ID] [int] NOT NULL,
    [Transaction Type] [nvarchar](50) NOT NULL,
    [Valid From] [datetime2](7) NOT NULL,
    [Valid To] [datetime2](7) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/dimension_TransactionType/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[fact_Movement] (
    [Movement Key] [bigint] NOT NULL,
    [Date Key] [date] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Customer Key] [int] NULL,
    [Supplier Key] [int] NULL,
    [Transaction Type Key] [int] NOT NULL,
    [WWI Stock Item Transaction ID] [int] NOT NULL,
    [WWI Invoice ID] [int] NULL,
    [WWI Purchase Order ID] [int] NULL,
    [Quantity] [int] NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/fact_Movement/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[fact_Order] (
    [Order Key] [bigint] NOT NULL,
    [City Key] [int] NOT NULL,
    [Customer Key] [int] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Order Date Key] [date] NOT NULL,
    [Picked Date Key] [date] NULL,
    [Salesperson Key] [int] NOT NULL,
    [Picker Key] [int] NULL,
    [WWI Order ID] [int] NOT NULL,
    [WWI Backorder ID] [int] NULL,
    [Description] [nvarchar](100) NOT NULL,
    [Package] [nvarchar](50) NOT NULL,
    [Quantity] [int] NOT NULL,
    [Unit Price] [decimal](18, 2) NOT NULL,
    [Tax Rate] [decimal](18, 3) NOT NULL,
    [Total Excluding Tax] [decimal](18, 2) NOT NULL,
    [Tax Amount] [decimal](18, 2) NOT NULL,
    [Total Including Tax] [decimal](18, 2) NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/fact_Order/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[fact_Purchase] (
    [Purchase Key] [bigint] NOT NULL,
    [Date Key] [date] NOT NULL,
    [Supplier Key] [int] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [WWI Purchase Order ID] [int] NULL,
    [Ordered Outers] [int] NOT NULL,
    [Ordered Quantity] [int] NOT NULL,
    [Received Outers] [int] NOT NULL,
    [Package] [nvarchar](50) NOT NULL,
    [Is Order Finalized] [bit] NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/fact_Purchase/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[fact_Sale] (
    [Sale Key] [bigint] NOT NULL,
    [City Key] [int] NOT NULL,
    [Customer Key] [int] NOT NULL,
    [Bill To Customer Key] [int] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Invoice Date Key] [date] NOT NULL,
    [Delivery Date Key] [date] NULL,
    [Salesperson Key] [int] NOT NULL,
    [WWI Invoice ID] [int] NOT NULL,
    [Description] [nvarchar](100) NOT NULL,
    [Package] [nvarchar](50) NOT NULL,
    [Quantity] [int] NOT NULL,
    [Unit Price] [decimal](18, 2) NOT NULL,
    [Tax Rate] [decimal](18, 3) NOT NULL,
    [Total Excluding Tax] [decimal](18, 2) NOT NULL,
    [Tax Amount] [decimal](18, 2) NOT NULL,
    [Profit] [decimal](18, 2) NOT NULL,
    [Total Including Tax] [decimal](18, 2) NOT NULL,
    [Total Dry Items] [int] NOT NULL,
    [Total Chiller Items] [int] NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/fact_Sale/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[fact_StockHolding] (
    [Stock Holding Key] [bigint] NOT NULL,
    [Stock Item Key] [int] NOT NULL,
    [Quantity On Hand] [int] NOT NULL,
    [Bin Location] [nvarchar](20) NOT NULL,
    [Last Stocktake Quantity] [int] NOT NULL,
    [Last Cost Price] [decimal](18, 2) NOT NULL,
    [Reorder Level] [int] NOT NULL,
    [Target Stock Level] [int] NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/fact_StockHolding/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
CREATE EXTERNAL TABLE [ext].[fact_Transaction] (
    [Transaction Key] [bigint] NOT NULL,
    [Date Key] [date] NOT NULL,
    [Customer Key] [int] NULL,
    [Bill To Customer Key] [int] NULL,
    [Supplier Key] [int] NULL,
    [Transaction Type Key] [int] NOT NULL,
    [Payment Method Key] [int] NULL,
    [WWI Customer Transaction ID] [int] NULL,
    [WWI Supplier Transaction ID] [int] NULL,
    [WWI Invoice ID] [int] NULL,
    [WWI Purchase Order ID] [int] NULL,
    [Supplier Invoice Number] [nvarchar](20) NULL,
    [Total Excluding Tax] [decimal](18, 2) NOT NULL,
    [Tax Amount] [decimal](18, 2) NOT NULL,
    [Total Including Tax] [decimal](18, 2) NOT NULL,
    [Outstanding Balance] [decimal](18, 2) NOT NULL,
    [Is Finalized] [bit] NOT NULL,
    [Lineage Key] [int] NOT NULL
)
WITH ( LOCATION ='/v1/fact_Transaction/',
    DATA_SOURCE = WWIStorage,
    FILE_FORMAT = TextFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);



-- Load the data into new tables with CTAS
CREATE TABLE [wwi].[dimension_City]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_City]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_City]')
;

CREATE TABLE [wwi].[dimension_Customer]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_Customer]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_Customer]')
;

CREATE TABLE [wwi].[dimension_Employee]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_Employee]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_Employee]')
;

CREATE TABLE [wwi].[dimension_PaymentMethod]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_PaymentMethod]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_PaymentMethod]')
;

CREATE TABLE [wwi].[dimension_StockItem]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_StockItem]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_StockItem]')
;

CREATE TABLE [wwi].[dimension_Supplier]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_Supplier]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_Supplier]')
;

CREATE TABLE [wwi].[dimension_TransactionType]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[dimension_TransactionType]
OPTION (LABEL = 'CTAS : Load [wwi].[dimension_TransactionType]')
;

CREATE TABLE [wwi].[fact_Movement]
WITH
(
    DISTRIBUTION = HASH([Movement Key]),
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[fact_Movement]
OPTION (LABEL = 'CTAS : Load [wwi].[fact_Movement]')
;

CREATE TABLE [wwi].[fact_Order]
WITH
(
    DISTRIBUTION = HASH([Order Key]),
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[fact_Order]
OPTION (LABEL = 'CTAS : Load [wwi].[fact_Order]')
;

CREATE TABLE [wwi].[fact_Purchase]
WITH
(
    DISTRIBUTION = HASH([Purchase Key]),
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[fact_Purchase]
OPTION (LABEL = 'CTAS : Load [wwi].[fact_Purchase]')
;

CREATE TABLE [wwi].[seed_Sale]
WITH
(
    DISTRIBUTION = HASH([WWI Invoice ID]),
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[fact_Sale]
OPTION (LABEL = 'CTAS : Load [wwi].[seed_Sale]')
;

CREATE TABLE [wwi].[fact_StockHolding]
WITH
(
    DISTRIBUTION = HASH([Stock Holding Key]),
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[fact_StockHolding]
OPTION (LABEL = 'CTAS : Load [wwi].[fact_StockHolding]')
;

CREATE TABLE [wwi].[fact_Transaction]
WITH
(
    DISTRIBUTION = HASH([Transaction Key]),
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext].[fact_Transaction]
OPTION (LABEL = 'CTAS : Load [wwi].[fact_Transaction]')
;




-- Watch data load progress
SELECT
    r.command,
    s.request_id,
    r.status,
    count(distinct input_name) as nbr_files,
    sum(s.bytes_processed)/1024/1024/1024 as gb_processed
FROM
    sys.dm_pdw_exec_requests r
    INNER JOIN sys.dm_pdw_dms_external_work s
    ON r.request_id = s.request_id
WHERE
    r.[label] = 'CTAS : Load [wwi].[dimension_City]' OR
    r.[label] = 'CTAS : Load [wwi].[dimension_Customer]' OR
    r.[label] = 'CTAS : Load [wwi].[dimension_Employee]' OR
    r.[label] = 'CTAS : Load [wwi].[dimension_PaymentMethod]' OR
    r.[label] = 'CTAS : Load [wwi].[dimension_StockItem]' OR
    r.[label] = 'CTAS : Load [wwi].[dimension_Supplier]' OR
    r.[label] = 'CTAS : Load [wwi].[dimension_TransactionType]' OR
    r.[label] = 'CTAS : Load [wwi].[fact_Movement]' OR
    r.[label] = 'CTAS : Load [wwi].[fact_Order]' OR
    r.[label] = 'CTAS : Load [wwi].[fact_Purchase]' OR
    r.[label] = 'CTAS : Load [wwi].[fact_StockHolding]' OR
    r.[label] = 'CTAS : Load [wwi].[fact_Transaction]'
GROUP BY
    r.command,
    s.request_id,
    r.status
ORDER BY
    nbr_files desc,
    gb_processed desc;





-- View all system queries
SELECT * FROM sys.dm_pdw_exec_requests;






















