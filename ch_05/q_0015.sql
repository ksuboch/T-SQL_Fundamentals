USE TSQL2012;

-- 1-1
SELECT
    empid,
    MAX(orderdate) AS maxorderdate
FROM Sales.Orders
GROUP BY empid

-- 1-2
SELECT
    O1.empid,
    O2.orderdate,
    O2.orderid,
    O2.custid
FROM (SELECT empid, MAX(orderdate) AS maxorderdate
      FROM Sales.Orders
      GROUP BY empid) AS O1
    LEFT JOIN Sales.Orders AS O2
        ON O1.empid = O2.empid
            AND O1.maxorderdate = O2.orderdate

-- 2-1
SELECT
    orderid,
    orderdate,
    custid,
    empid,
    ROW_NUMBER() OVER (ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders;
GO

-- 2-2
WITH SOrders AS
(
    SELECT
        orderid,
        orderdate,
        custid,
        empid,
        ROW_NUMBER() OVER (ORDER BY orderdate, orderid) AS rownum
    FROM Sales.Orders
)
SELECT
    orderid,
    orderdate,
    custid,
    empid,
    rownum
FROM
    SOrders
-- ORDER BY
--     rownum
-- OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
WHERE rownum BETWEEN 11 AND 20;
GO

-- 3
WITH Emps AS
(
    SELECT
        empid,
        mgrid,
        firstname,
        lastname
    FROM HR.Employees
    WHERE
        empid = 9

    UNION ALL

    SELECT
        H.empid,
        H.mgrid,
        H.firstname,
        H.lastname
    FROM Emps AS E
        JOIN HR.Employees AS H
        ON H.empid = E.mgrid
)
SELECT * FROM Emps;

-- 4-1
IF OBJECT_ID('Sales.VEmpOrders') IS NOT NULL
    DROP VIEW Sales.VEmpOrders;
GO

CREATE VIEW Sales.VEmpOrders
AS
    SELECT
        O.empid,
        YEAR(O.orderdate) AS orderyear,
        SUM(OD.qty) AS qty
    FROM Sales.Orders AS O
        JOIN Sales.OrderDetails AS OD
            ON O.orderid = OD.orderid
    GROUP BY
        O.empid,
        YEAR(O.orderdate)
GO

SELECT * FROM Sales.VEmpOrders ORDER BY empid, orderyear;

-- 4-2
SELECT
    empid,
    orderyear,
    qty,
    (SELECT SUM(qty)
     FROM Sales.VEmpOrders AS V2
     WHERE V1.empid = V2.empid
        AND V1.orderyear >= V2.orderyear)
FROM Sales.VEmpOrders AS V1
ORDER BY empid, orderyear;

IF OBJECT_ID('Sales.VEmpOrders') IS NOT NULL
    DROP VIEW Sales.VEmpOrders;
GO

-- 5-1
IF OBJECT_ID('Production.TopProducts') IS NOT NULL
    DROP FUNCTION Production.TopProducts;
GO

CREATE FUNCTION Production.TopProducts(@supid AS INT, @n AS INT)
RETURNS TABLE
AS
RETURN
    SELECT TOP(@n)
        productid,
        productname,
        unitprice
    FROM
        Production.Products
    WHERE
        supplierid = @supid
    ORDER BY
        unitprice DESC
GO

SELECT * FROM Production.TopProducts(5, 2);

SELECT
    S.supplierid,
    S.companyname,
    P.productid,
    P.productname,
    P.unitprice
FROM
    Production.Suppliers AS S
    CROSS APPLY Production.TopProducts(S.supplierid, 2) AS P

IF OBJECT_ID('Production.TopProducts') IS NOT NULL
    DROP FUNCTION Production.TopProducts;
GO
