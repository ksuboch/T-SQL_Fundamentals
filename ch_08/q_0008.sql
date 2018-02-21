USE TSQL2012;

IF OBJECT_ID('dbo.OrdersDetails', 'U') IS NOT NULL
    DROP TABLE dbo.OrdersDetails;

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
    DROP TABLE dbo.Orders;

CREATE TABLE dbo.Orders
(
  orderid        INT          NOT NULL,
  custid         INT          NULL,
  empid          INT          NOT NULL,
  orderdate      DATETIME     NOT NULL,
  requireddate   DATETIME     NOT NULL,
  shippeddate    DATETIME     NULL,
  shipperid      INT          NOT NULL,
  freight        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_freight DEFAULT(0),
  shipname       NVARCHAR(40) NOT NULL,
  shipaddress    NVARCHAR(60) NOT NULL,
  shipcity       NVARCHAR(25) NOT NULL,
  shipregion     NVARCHAR(15) NULL,
  shippostalcode NVARCHAR(10) NULL,
  shipcountry    NVARCHAR(15) NOT NULL,
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

CREATE TABLE dbo.OrderDetails
(
  orderid   INT           NOT NULL,
  productid INT           NOT NULL,
  unitprice MONEY         NOT NULL
    CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
  qty       SMALLINT      NOT NULL
    CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
  discount  NUMERIC(4, 3) NOT NULL
    CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
  CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
  CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid)
    REFERENCES dbo.Orders(orderid),
  CONSTRAINT CHK_discount  CHECK (discount BETWEEN 0 AND 1),
  CONSTRAINT CHK_qty  CHECK (qty > 0),
  CONSTRAINT CHK_unitprice CHECK (unitprice >= 0)
);
GO

INSERT INTO dbo.Orders SELECT * FROM Sales.Orders;
INSERT INTO dbo.OrderDetails SELECT * FROM Sales.OrderDetails;

UPDATE dbo.OrderDetails
    SET discount += 0.05
WHERE productid = 51;

-- UPDATE dbo.T1
--     SET col1 = col2, col2 = col1;

UPDATE OD
    SET discount += 0.05
FROM dbo.OrderDetails AS OD
    JOIN dbo.Orders AS O
        ON OD.orderid = O.orderid
WHERE O.custid = 1;

UPDATE dbo.OrderDetails
    SET discount += 0.05
WHERE EXISTS
    (SELECT * FROM dbo.Orders AS O
     WHERE O.orderid = OrderDetails.orderid
        AND O.custid = 1);

-- UPDATE T1
--     SET col1 = T2.col1,
--         col2 = T2.col2,
--         col3 = T2.col3
-- FROM dbo.T1 JOIN dbo.T2
--     ON T2.keycol = T1.keycol
-- WHERE T2.col4 = 'ABC';

-- UPDATE dbo.T1
--     SET col1 = (SELECT col1
--                 FROM dbo.T2
--                 WHERE T2.keycol = T1.keycol),

--         col2 = (SELECT col2
--                 FROM dbo.T2
--                 WHERE T2.keycol = T1.keycol),

--         col3 = (SELECT col3
--                 FROM dbo.T2
--                 WHERE T2.keycol = T1.keycol)
-- WHERE EXISTS
--     (SELECT *
--     FROM dbo.T2
--     WHERE T2.keycol = T1.keycol
--         AND T2.col4 = 'ABC');
