USE TSQL2012;

SELECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY CUBE(empid, custid);

SELECT
    GROUPING(empid) AS grpemp,
    GROUPING(custid) AS grpcust,
    empid,
    custid,
    SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY CUBE(empid, custid);

SELECT
    GROUPING_ID(empid, custid) AS groupingset,
    empid,
    custid,
    SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY CUBE(empid, custid);
