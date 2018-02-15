USE TSQL2012;

IF OBJECT_ID('Sales.USACusts') IS NOT NULL
    DROP VIEW Sales.USACusts;
GO

CREATE VIEW Sales.USACusts
AS
SELECT
    custid,
    companyname,
    contactname,
    contacttitle,
    address,
    city,
    region,
    postalcode,
    country,
    phone,
    fax
FROM
    Sales.Customers
WHERE
    country = N'США';
GO

ALTER VIEW Sales.USACusts WITH SCHEMABINDING
AS
SELECT
    custid,
    companyname,
    contactname,
    contacttitle,
    address,
    city,
    region,
    postalcode,
    country,
    phone,
    fax
FROM
    Sales.Customers
WHERE
    country = N'США';
GO

ALTER TABLE Sales.Customers DROP COLUMN address;
