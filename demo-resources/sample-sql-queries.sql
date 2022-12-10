-- create sample tables
CREATE TABLE [dbo].[esqlProductSource](
       [ProductID] [int] NOT NULL,
       [Name] [varchar](50) NULL,
       [ProductNumber] [varchar](50) NULL,
       [Color] [varchar](50) NULL,
 CONSTRAINT [PK_esqlProductSource] PRIMARY KEY CLUSTERED
(
       [ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[esqlProductTarget](
       [ProductID] [int] NOT NULL,
       [Name] [varchar](50) NULL,
       [ProductNumber] [varchar](50) NULL,
       [Color] [varchar](50) NULL,
 CONSTRAINT [PK_esqlProductTarget] PRIMARY KEY CLUSTERED
(
       [ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

INSERT INTO esqlProductSource(ProductID, Name, ProductNumber, Color)
SELECT ProductID
      ,Name
      ,ProductNumber
      ,Color
  FROM Production.Product


INSERT INTO esqlProductTarget (ProductID, Name, ProductNumber, Color)
SELECT ProductID
      ,Name
      ,ProductNumber
      ,Color
  FROM Production.Product

--- make changes to source:
Update esqlProductSource
SET Color = 'Unknown'
WHERE Color is NULL

DELETE
FROM esqlPRoductSource
WHERE Name LIKE '%Tape%'

INSERT INTO esqlProductSource(ProductID, Name, ProductNumber, Color)
Values (999100, 'Crank Shaft','CS-1010','Sliver'),
       (999110, 'Super Sprocket', 'SS-1010', 'Gray')