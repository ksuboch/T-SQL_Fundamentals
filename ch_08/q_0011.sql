USE TSQL2012;

WITH C AS
(
    SELECT custid, OD.orderid,
        productid, discount, discount + 0.05 AS newdiscount
    FROM dbo.OrderDetails AS OD
        JOIN dbo.Orders AS O
            ON OD.orderid = O.orderid
    WHERE O.custid = 1
)
UPDATE C
    SET discount = newdiscount;

UPDATE D
    SET discount = newdiscount
FROM ( SELECT custid, OD.orderid,
        productid, discount, discount + 0.05 AS newdiscount
        FROM dbo.OrderDetails AS OD
            JOIN dbo.Orders AS O
                ON OD.orderid = O.orderid
        WHERE O.custid = 1) AS D;

IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL
    DROP TABLE dbo.T1;
CREATE TABLE dbo.T1(col1 INT, col2 INT);
GO

INSERT INTO dbo.T1(col1) VALUES(10), (20), (30);

SELECT * FROM dbo.T1;

WITH C AS
(
    SELECT col1, col2, ROW_NUMBER() OVER(ORDER BY col1) AS rownum
    FROM dbo.T1
)
UPDATE C
    SET col2 = rownum;

SELECT * FROM dbo.T1;
