USE TSQL2012;

IF OBJECT_ID('Sales.OrderDetailsAudit', 'U') IS NOT NULL
    DROP TABLE Sales.OrderDetailsAudit;
CREATE TABLE Sales.OrderDetailsAudit
(
    lsn INT NOT NULL IDENTITY,
    orderid INT NOT NULL,
    productid INT NOT NULL,
    dt DATETIME NOT NULL,
    loginname sysname NOT NULL,
    columnname sysname NOT NULL,
    oldval SQL_VARIANT,
    newval SQL_VARIANT,
    CONSTRAINT PK_OrderDetailsAudit PRIMARY KEY(lsn),
    CONSTRAINT FK_OrderDetailsAudit_OrderDetails
        FOREIGN KEY(orderid, productid)
        REFERENCES Sales.OrderDetails(orderid, productid)
);

SELECT
    OD.orderid,
    OD.productid,
    OD.qty,
    ODA.dt,
    ODA.loginname,
    ODA.oldval,
    ODA.newval
FROM
    Sales.OrderDetails AS OD
    JOIN Sales.OrderDetailsAudit AS ODA
      ON OD.orderid = ODA.orderid
      AND OD.productid = ODA.productid
WHERE
    ODA.columnname = N'qty';
