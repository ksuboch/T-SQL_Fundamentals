USE TSQL2012;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T11;

CREATE TABLE dbo.T1(col1 INT IDENTITY);
GO

SET NOCOUNT ON;

INSERT INTO dbo.T1 DEFAULT VALUES;
-- GO 100

SELECT * FROM dbo.T1;
