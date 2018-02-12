USE TSQL2012;

IF OBJECT_ID('Sales.MyShippers', 'U') IS NOT NULL
    DROP TABLE Sales.MyShippers;

CREATE TABLE Sales.MyShippers
(
    shipper_id INT NOT NULL,
    companyname NVARCHAR(40) NOT NULL,
    phone NVARCHAR(24) NOT NULL,
    CONSTRAINT PK_MyShippers PRIMARY KEY(shipper_id)
);

INSERT INTO Sales.MyShippers(shipper_id, companyname, phone)
    VALUES  (1, N'Поставщик GVSUA', N'(503) 555-0137'),
            (2, N'Поставщик ETYNR', N'(425) 555-0136'),
            (3, N'Поставщик ZHISN', N'(415) 555-0138');

SELECT
    shipper_id,
    companyname
FROM
    Sales.MyShippers
WHERE
    shipper_id IN
    (SELECT O.shipperid
     FROM Sales.Orders AS O
     WHERE O.custid = 43);

IF OBJECT_ID('Sales.MyShippers', 'U') IS NOT NULL
    DROP TABLE Sales.MyShippers;
