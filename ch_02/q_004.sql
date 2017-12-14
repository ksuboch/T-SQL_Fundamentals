USE TSQL2012;

SELECT
    empid,
    YEAR(orderdate) AS orderyear
FROM
    Sales.Orders
WHERE
    custid = 71
GROUP BY
    empid,
    YEAR(orderdate);
