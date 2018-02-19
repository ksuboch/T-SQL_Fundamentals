USE TSQL2012;

SELECT empid, custid, SUM(qty) AS sqmqty
FROM dbo.Orders
GROUP BY empid, custid;

SELECT empid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY empid;

SELECT custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY custid;

SELECT SUM(qty) AS sumqty
FROM dbo.Orders;

    SELECT empid, custid, SUM(qty) AS sqmqty
    FROM dbo.Orders
    GROUP BY empid, custid

UNION ALL

    SELECT empid, NULL, SUM(qty) AS sumqty
    FROM dbo.Orders
    GROUP BY empid

UNION ALL

    SELECT NULL, custid, SUM(qty) AS sumqty
    FROM dbo.Orders
    GROUP BY custid

UNION ALL

    SELECT NULL, NULL, SUM(qty) AS sumqty
    FROM dbo.Orders;

SElECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY
    GROUPING SETS
    (
        (empid, custid),
        (empid),
        (custid),
        ()
    );

SELECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY CUBE(empid, custid);
