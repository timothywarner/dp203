-- Load data using CTAS
-- Reference: https://timw.info/4up

-- Create master key (once per DB)
CREATE MASTER KEY;

-- Define the location of the source data
CREATE EXTERNAL DATA SOURCE WWIStorage
WITH
(
    TYPE = Hadoop,
    LOCATION = 'wasbs://wideworldimporters@sqldwholdata.blob.core.windows.net'
);

-- Specify the formatting characteristics of the external data file
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

-- Create external file format schema
CREATE SCHEMA [ext2];
CREATE SCHEMA [wwi2];

-- Create external tables (schemas in pool, data in Azure blob storage)
CREATE EXTERNAL TABLE [ext2].[dimension_City](
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

-- Load data from staging table to production table CTAS
CREATE TABLE [wwi2].[dimension_City]
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT * FROM [ext2].[dimension_City]
OPTION (LABEL = 'CTAS : Load [wwi2].[dimension_City]')
;