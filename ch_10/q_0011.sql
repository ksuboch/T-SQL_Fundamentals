USE TSQL2012;

DECLARE @sql AS NVARCHAR(100);
SET @sql = 'PRINT ''Dynamc message'';';
EXEC(@sql);

SET @sql = N'SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderid = @orderid;';

EXEC sp_executesql
    @stmt = @sql,
    @params = N'@orderid AS INT',
    @orderid = 10248;
