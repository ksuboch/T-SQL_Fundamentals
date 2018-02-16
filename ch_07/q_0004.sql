USE TSQL2012;

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

CREATE TABLE dbo.Orders
(
    orderid   INT        NOT NULL,
    orderdate DATE       NOT NULL,
    empid     INT        NOT NULL,
    custid    VARCHAR(5) NOT NULL,
    qty       INT        NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

INSERT INTO dbo.Orders(orderid, orderdate, empid, custid, qty)
VALUES
    (30001, '20070802', 3, 'A', 10),
    (10001, '20071224', 2, 'A', 12),
    (10005, '20071224', 1, 'B', 20),
    (40001, '20080109', 2, 'A', 40),
    (10006, '20080118', 1, 'C', 14),
    (20001, '20080212', 2, 'B', 12),
    (40005, '20090212', 3, 'A', 10),
    (20002, '20090216', 1, 'C', 20),
    (30003, '20090418', 2, 'B', 15),
    (30004, '20070418', 3, 'C', 22),
    (30007, '20090907', 3, 'D', 30);

SELECT * FROM dbo.Orders;

SELECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY empid, custid;

SELECT empid,
    SUM(CASE WHEN custid = 'A' THEN qty END) AS A,
    SUM(CASE WHEN custid = 'B' THEN qty END) AS B,
    SUM(CASE WHEN custid = 'C' THEN qty END) AS C,
    SUM(CASE WHEN custid = 'D' THEN qty END) AS D
FROM dbo.Orders
GROUP BY empid;

SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty
        FROM dbo.Orders) AS D
    PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;

SELECT empid, A, B, C, D
    FROM dbo.Orders
        PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;

SELECT custid, [1], [2], [3]
FROM (SELECT empid, custid, qty
        FROM dbo.Orders) AS D
    PIVOT(SUM(qty) FOR empid IN([1], [2], [3])) AS P;
