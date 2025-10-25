/*
=============================
Create Database and Schema
=============================
Script purpose:
  This script creates a new databases named 'DataWarehouse' after checking if it already exists.
  If the database exists it it dropped and recreated. Additionally, the script sets up three schemas 
  within the database: 'bronze', 'silver', and 'gold'.

Warning:
  Running this script will drop the entire 'DataWarehouse' database if it already exists.
  All the data in the database will be permanently deleted. Proceed with caution and ensure
  you have proper backup before running this script.
*/
Use master;
GO

-- Drop and recreate the 'DataWarehouse' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO
  
-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
