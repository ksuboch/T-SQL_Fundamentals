USE TSQL2012;

SELECT              --5
    empid,
    YEAR(orderdate) AS orderyear,
    COUNT(*) AS numorders
FROM Sales.Orders   --1
WHERE custid = 71   --2
GROUP BY            --3
    empid,
    YEAR(orderdate)
HAVING              --4
    COUNT(*) > 1
ORDER BY            --6
    empid,
    orderyear;
