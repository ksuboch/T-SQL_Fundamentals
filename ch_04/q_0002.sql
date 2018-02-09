USE TSQL2012;

SELECT orderid
FROM Sales.Orders
WHERE empid IN
    (SELECT E.empid
     FROM HR.Employees AS E
     WHERE E.lastname LIKE N'Д%');

SELECT
    custid,
    orderid,
    orderdate,
    empid
FROM Sales.Orders
WHERE custid IN
    (SELECT C.custid
     FROM Sales.Customers AS C
     WHERE C.country = N'США')

SELECT
    custid,
    companyname
FROM
    Sales.Customers
WHERE custid NOT IN
    (SELECT O.custid
     FROM Sales.Orders AS O);

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
CREATE TABLE dbo.Orders(orderid INT NOT NULL CONSTRAINT PK_Orders PRIMARY KEY);

INSERT INTO dbo.Orders(orderid)
    SELECT orderid
    FROM Sales.Orders
    WHERE orderid % 2 = 0;

SELECT n
FROM dbo.Nums
WHERE n BETWEEN (SELECT MIN(O.orderid) FROM dbo.Orders AS O)
            AND (SELECT MAX(O.orderid) FROM dbo.Orders AS O)
    AND n  NOT IN (SELECT O.orderid FROM dbo.Orders AS O);

DROP TABLE dbo.Orders;
