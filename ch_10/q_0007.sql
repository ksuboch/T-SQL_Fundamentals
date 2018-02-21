USE TSQL2012;

IF OBJECT_ID('tempdb.dbo.#MyOrderTotalsByYear') IS NOT NULL
    DROP TABLE dbo.#MyOrderTotalsByYear;
GO

CREATE TABLE #MyOrderTotalsByYear
(
    orderyear INT NOT NULL PRIMARY KEY,
    qty INT NOT NULL
);

INSERT INTO #MyOrderTotalsByYear(orderyear, qty)
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
    FROM dbo.#MyOrderTotalsByYear AS Cur
        LEFT OUTER JOIN dbo.#MyOrderTotalsByYear AS Prv
            ON Cur.orderyear = Prv.orderyear + 1;

IF OBJECT_ID('tempdb.dbo.#MyOrderTotalsByYear') IS NOT NULL
    DROP TABLE dbo.#MyOrderTotalsByYear;
