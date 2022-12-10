-- Check initial value
SELECT CustomerId, FirstName, LastName, ModifiedDate FROM DimCustomer WHERE CustomerId = 4

-- Update the record
UPDATE [dbo].[CustomerSource]
SET LastName = 'Lopez'
WHERE [CustomerId] = 4

-- Recheck value
SELECT CustomerId, FirstName, LastName, ModifiedDate FROM DimCustomer WHERE CustomerId = 4
