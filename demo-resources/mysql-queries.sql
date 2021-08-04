-- Create a database
-- DROP DATABASE IF EXISTS quickstartdb;
CREATE DATABASE quickstartdb;
USE quickstartdb;

-- Create a table and insert rows
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (id serial PRIMARY KEY, name VARCHAR(50), quantity INTEGER);
INSERT INTO inventory (name, quantity) VALUES ('banana', 150);
INSERT INTO inventory (name, quantity) VALUES ('orange', 154);
INSERT INTO inventory (name, quantity) VALUES ('apple', 100);

-- Read
SELECT * FROM inventory;

-- Update
UPDATE inventory SET quantity = 200 WHERE id = 1;
SELECT * FROM inventory;

-- Delete
DELETE FROM inventory WHERE id = 2;
SELECT * FROM inventory;