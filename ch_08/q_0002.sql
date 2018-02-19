USE TSQL2012;

IF OBJECT_ID('Sales.usp_getorders', 'P') IS NOT NULL
    DROP PROC Sales.usp_getorders;
GO

CREATE PROC Sales.usp_getorders
    @country AS NVARCHAR(40)
AS

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE shipcountry = @country;
GO

INSERT INTO dbo.Orders(orderid, orderdate, empid, custid)
    EXEC Sales.usp_getorders @country = 'Франция';
