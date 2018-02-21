USE TSQL2012;

IF TYPE_ID('dbo.OrderTotalByYear') IS NOT NULL
    DROP TYPE dbo.OrderTotalByYear;

CREATE TYPE dbo.OrderTotalByYear AS TABLE
(
    orderyear INT NOT NULL PRIMARY KEY,
    qty INT NOT NULL
);
GO

DECLARE @MyOrderTotalByYear AS dbo.OrderTotalByYear;

INSERT INTO @MyOrderTotalByYear
    (orderyear, qty)
SELECT
    YEAR(O.orderdate) AS orderyear,
    SUM(OD.qty) AS qty
FROM Sales.Orders AS O
    JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid
GROUP BY YEAR(O.orderdate);

SELECT orderyear, qty FROM @MyOrderTotalByYear;
