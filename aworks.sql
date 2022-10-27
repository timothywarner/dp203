SELECT CompanyName
  FROM SalesLT.Customer
 WHERE FirstName='James'
   AND MiddleName='D.'
   AND LastName='Kramer'

SELECT CompanyName,AddressType,AddressLine1
  FROM SalesLT.Customer JOIN SalesLT.CustomerAddress
    ON (SalesLT.Customer.CustomerID=CustomerAddress.CustomerID)
                  JOIN SalesLT.Address
    ON (SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID)
 WHERE CompanyName='Modular Cycle Systems'

 CREATE TABLE dbo.account
( account_id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_account PRIMARY KEY CLUSTERED,
  account_name VARCHAR(100) NOT NULL,
  account_start_date DATE NOT NULL,
  account_address VARCHAR(1000) NOT NULL,
  account_type VARCHAR(10) NOT NULL,
  account_create_timestamp DATETIME NOT NULL,
    account_notes VARCHAR(500) NULL,
  is_active BIT NOT NULL);

INSERT INTO dbo.account
  (account_name, account_start_date, account_address, account_type, account_create_timestamp, account_notes, is_active)
VALUES
  ('Ed''s Account',
   '5/1/2019',
   'Ed''s Address',
   'TEST',
   GETUTCDATE(),
   'This is a test account to model this data.',
   0);

ALTER TABLE dbo.account ADD CONSTRAINT DF_account_account_notes DEFAULT ('NONE PROVIDED') FOR account_notes;

DELETE FROM SalesLT.Customer WHERE SalesLT.Customer.LastName ='Futterkiste';

UPDATE SalesLT.SalesPerson  
SET Bonus = 6000, CommissionPct = .10, SalesQuota = NULL;  
GO  

USE AdventureWorks2012 ;  
GO  
UPDATE Production.Product  
SET ListPrice = ListPrice * 2;  
GO  








