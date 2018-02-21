USE TSQL2012;

DECLARE @MyOrderTotalsByYear TABLE
(
    orderyear INT NOT NULL PRIMARY KEY,
    qty INT NOT NULL
);

INSERT INTO @MyOrderTotalsByYear
    (orderyear, qty)
SELECT
    YEAR(O.orderdate) AS orderyear,
    SUM(OD.qty) AS qty
FROM Sales.Orders AS O
    JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid
GROUP BY YEAR(O.orderdate);

SELECT
    Cur.orderyear,
    Cur.qty AS curyearqty,
    Prv.qty AS prvyearqty
FROM @MyOrderTotalsByYear AS Cur
    LEFT OUTER JOIN @MyOrderTotalsByYear AS Prv
    ON Cur.orderyear = Prv.orderyear + 1;

SELECT
    orderyear,
    qty AS curyearqty,
    LAG(qty) OVER (ORDER BY orderyear) AS prvyearqty
FROM @MyOrderTotalsByYear;
