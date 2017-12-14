USE tsql2012;

IF OBJECT_ID('dbo.Orders') IS NOT NULL
    DROP TABLE dbo.Orders;

CREATE TABLE dbo.Orders
(
    orderid INT         NOT NULL,
    empid   INT         NOT NULL,
    custid  VARCHAR(10) NOT NULL,
    orderts DATETIME2   NOT NULL,
    qty     INT         NOT NULL,
    CONSTRAINT PK_Orders
        PRIMARY KEY(orderid)
);

ALTER TABLE dbo.Orders
    ADD CONSTRAINT FK_Orders_Employees
    FOREIGN KEY(empid)
    REFERENCES dbo.Employees(empid);

ALTER TABLE dbo.Orders
    ADD CONSTRAINT DEF_Orders_orderts
    DEFAULT(SYSDATETIME()) FOR orderts;
