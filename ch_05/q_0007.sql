USE TSQL2012;

WITH C1 AS
(
    SELECT YEAR(orderdate) AS orderyear, custid
    FROM Sales.Orders
),
C2 AS
(
    SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
    FROM C1
    GROUP BY orderyear
)
SELECT orderyear, numcusts
FROM C2
WHERE numcusts > 70;

WITH YearlyCount AS
(
    SELECT
        YEAR(orderdate) AS orderyear,
        COUNT(DISTINCT custid) AS numcusts
    FROM
        Sales.Orders
    GROUP BY YEAR(orderdate)
)

SELECT
    Cur.orderyear,
    Cur.numcusts AS curnumcusts,
    Prv.numcusts AS prvnumcusts,
    Cur.numcusts - Prv.numcusts AS grouth
FROM
    YearlyCount AS Cur
    LEFT OUTER JOIN YearlyCount AS Prv
        ON Cur.orderyear = Prv.orderyear + 1;
