USE TSQL2012;

DECLARE @maxid AS INT = (SELECT MAX(orderid)
                         FROM Sales.Orders);

SELECT
    orderid,
    orderdate,
    empid,
    custid
FROM Sales.Orders
WHERE orderid = @maxid;

SELECT
    orderid,
    orderdate,
    empid,
    custid
FROM Sales.Orders
WHERE orderid = (SELECT MAX(orderid)
                 FROM Sales.Orders);
