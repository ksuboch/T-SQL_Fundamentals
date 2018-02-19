USE TSQL2012;

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL
        CONSTRAINT PK_Orders PRIMARY KEY,
    orderdate DATE NOT NULL
        CONSTRAINT DFT_orderdate DEFAULT(SYSDATETIME()),
    empid INT NOT NULL,
    custid VARCHAR(10) NOT NULL
)

INSERT INTO dbo.Orders(orderid, orderdate, empid, custid)
    VALUES(10001, '20090212', 3, 'A');

INSERT INTO dbo.Orders(orderid, empid, custid)
    VALUES(10002, 5, 'B');

INSERT INTO dbo.Orders
    (orderid, orderdate, empid, custid)
VALUES
    (10003, '20090213', 4, 'B'),
    (10004, '20090214', 1, 'A'),
    (10005, '20090213', 1, 'C'),
    (10006, '20090215', 3, 'C');

SELECT *
FROM ( VALUES
        (10003, '20090213', 4, 'B'),
        (10004, '20090214', 1, 'A'),
        (10005, '20090213', 1, 'C'),
        (10006, '20090215', 3, 'C') )
    AS O(orderid, orderdate, empid, custid);

INSERT INTO dbo.Orders(orderid, orderdate, empid, custid)
    SELECT orderid, orderdate, empid, custid
    FROM Sales.Orders
    WHERE shipcountry = 'Великобритания';

SELECT * FROM dbo.Orders;
