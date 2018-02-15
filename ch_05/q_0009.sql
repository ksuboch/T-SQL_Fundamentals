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

SELECT custid, companyname
FROM Sales.USACusts;
GO

SELECT custid, companyname, region
FROM Sales.USACusts
ORDER BY region;
GO

ALTER VIEW Sales.USACusts
AS

SELECT TOP(100) PERCENT
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
    country = N'США'
ORDER BY
    region;
GO

SELECT custid, companyname, region
FROM Sales.USACusts;
GO
