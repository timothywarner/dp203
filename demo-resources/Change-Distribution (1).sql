CREATE TABLE dbo.yourTable2
WITH (
    CLUSTERED COLUMNSTORE INDEX,
    DISTRIBUTION = HASH ( yourColumn )
    )
AS
SELECT *
FROM dbo.yourTable
OPTION ( LABEL = 'CTAS: Change distribution on dbo.yourTable' );
GO

DROP TABLE dbo.yourTable
GO
RENAME OBJECT dbo.yourTable2 TO yourTable;
GO