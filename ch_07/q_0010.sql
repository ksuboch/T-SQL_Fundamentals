USE TSQL2012;

-- 1
SELECT
    custid,
    orderid,
    qty,
    RANK() OVER(PARTITION BY custid ORDER BY qty) AS rnk,
    DENSE_RANK() OVER(PARTITION BY custid ORDER BY qty) AS drnk
FROM
    dbo.Orders
ORDER BY
    custid, qty;

-- 2
SELECT
    custid,
    orderid,
    qty,
    qty - LAG(qty) OVER(PARTITION BY custid ORDER BY orderdate, orderid),
    qty - LEAD(qty) OVER(PARTITION BY custid ORDER BY orderdate, orderid)
FROM
    dbo.Orders
ORDER BY
    custid,
    orderdate;

-- 3
SELECT
    empid AS empid,
    [2007] AS cnt2007,
    [2008] AS cnt2008,
    [2009] AS cnt2009
FROM
    (SELECT
        empid,
        YEAR(orderdate) AS orderyear
    FROM dbo.Orders) AS Src
PIVOT(
    COUNT(orderyear)
    FOR orderyear IN ([2007], [2008], [2009])
) AS Pvt
ORDER BY
    empid;

-- 4
IF OBJECT_ID('dbo.EmpYearOrders', 'U')
    IS NOT NULL DROP TABLE dbo.EmpYearOrders;

CREATE TABLE dbo.EmpYearOrders
(
    empid INT NOT NULL
        CONSTRAINT PK__EmpYearOrders PRIMARY KEY,
    cnt2007 INT NULL,
    cnt2008 INT NULL,
    cnt2009 INT NULL
);

INSERT INTO dbo.EmpYearOrders
    (empid, cnt2007, cnt2008, cnt2009)
SELECT
    empid AS empid,
    [2007] AS cnt2007,
    [2008] AS cnt2008,
    [2009] AS cnt2009
FROM
    (SELECT
        empid,
        orderid,
        YEAR(orderdate) AS orderyear
    FROM dbo.Orders) AS Src
PIVOT(
    COUNT(orderid)
    FOR orderyear IN ([2007], [2008], [2009])
) AS Pvt;

SELECT *
FROM dbo.EmpYearOrders;

SELECT
    empid, orderyear, numorders
FROM
    (SELECT
        empid,
        cnt2007 AS [2007],
        cnt2008 AS [2008],
        cnt2009 AS [2009]
    FROM dbo.EmpYearOrders) AS Src
    UNPIVOT
        (numorders FOR orderyear IN
            ([2007], [2008], [2009])) AS Unpvt
WHERE numorders > 0
ORDER BY empid, orderyear;

-- 5
SELECT
    GROUPING_ID(empid, custid, YEAR(orderdate)) AS groupindex,
    empid,
    custid,
    YEAR(orderdate),
    SUM(qty)
FROM dbo.Orders
GROUP BY CUBE(empid, custid, YEAR(orderdate))
HAVING GROUPING_ID(empid, custid, YEAR(orderdate)) IN (4, 2, 0);

SELECT
    GROUPING_ID(empid, custid, YEAR(orderdate)) AS groupindex,
    empid,
    custid,
    YEAR(orderdate),
    SUM(qty)
FROM dbo.Orders
GROUP BY
    GROUPING SETS
(
    (empid, custid, YEAR(orderdate)),
    (empid, YEAR(orderdate)),
    (custid, YEAR(orderdate))
);

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;
