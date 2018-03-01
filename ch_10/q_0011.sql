USE TSQL2012;

DECLARE @sql AS NVARCHAR(100);
SET @sql = 'PRINT ''Dynamc message'';';
EXEC(@sql);
GO

DECLARE @sql AS NVARCHAR(100);
SET @sql = N'SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderid = @orderid;';

EXEC sp_executesql
    @stmt = @sql,
    @params = N'@orderid AS INT',
    @orderid = 10248;
GO

SELECT *
FROM (SELECT shipperid, YEAR(orderdate) AS orderyear, freight FROM Sales.Orders) AS D
    PIVOT(SUM(freight) FOR orderyear IN([2006], [2007], [2008])) AS P;

DECLARE
    @sql        AS NVARCHAR(1000),
    @orderyear  AS INT,
    @first      AS INT;

DECLARE C CURSOR FAST_FORWARD FOR
    SELECT DISTINCT(YEAR(orderdate)) AS orderyear
    FROM Sales.Orders
    ORDER BY orderyear;

SET @first = 1;

SET @sql = N'SELECT *
FROM  (SELECT shipperid, YEAR(orderdate) AS orderyear, freight
        FROM Sales.Orders) AS D
    PIVOT(SUM(freight) FOR orderyear IN (';

OPEN C;

FETCH NEXT FROM C INTO @orderyear;

WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @first = 0
            SET @sql = @sql + N','
        ELSE
            SET @first = 0;

        SET @sql = @sql + QUOTENAME(@orderyear);

        FETCH NEXT FROM C INTO @orderyear;
    END

CLOSE C;

DEALLOCATE C;

SET @sql = @sql + N')) AS P;';

EXEC sp_executesql @stmt = @sql;
