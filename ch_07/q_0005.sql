USE TSQL2012;

IF OBJECT_ID('dbo.EmpCustOrders', 'U') IS NOT NULL
    DROP TABLE dbo.EmpCustOrders;

CREATE TABLE dbo.EmpCloseOrders
(
    empid INT NOT NULL
        CONSTRAINT PK_EmpCustOrders PRIMARY KEY,
    A VARCHAR(5) NULL,
    B VARCHAR(5) NULL,
    C VARCHAR(5) NULL,
    D VARCHAR(5) NULL
);

INSERT INTO dbo.EmpCloseOrders
    (empid, A, B, C, D)
SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty
    FROM dbo.Orders) AS D
        PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;

SELECT *
FROM dbo.EmpCloseOrders;
