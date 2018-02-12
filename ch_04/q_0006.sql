USE TSQL2012;

SELECT
    orderyear,
    qty
FROM
    Sales.OrderTotalsByYear;

SELECT
    orderyear,
    qty,
    (SELECT SUM(O2.qty)
     FROM Sales.OrderTotalsByYear AS O2
     WHERE O2.orderyear <= O1.orderyear) AS runqty
FROM
    Sales.OrderTotalsByYear AS O1
ORDER BY
    orderyear;
