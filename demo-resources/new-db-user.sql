CREATE LOGIN melissa WITH password='xxxxx';
-- grant public master access
CREATE USER melissa FROM LOGIN melissa;


use aworks; -- CAN'T DO WITH WITH AZURE SQL
CREATE USER melissa FROM LOGIN melissa;
EXEC sp_addrolemember 'db_datareader', 'melissa';
