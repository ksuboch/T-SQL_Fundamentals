USE TSQL2012;

SELECT
    empid,
    firstname + N' ' + lastname AS fullname
FROM
    HR.Employees;

SELECT
    custid,
    country,
    region,
    city,
    country + N', ' + region + ', ' + city AS location
FROM
    Sales.Customers;

SELECT
    custid,
    country,
    region,
    city,
    country + COALESCE(N', ' + region, N'') + ', ' + city AS location
FROM
    Sales.Customers;

SELECT
    custid,
    country,
    region,
    city,
   CONCAT(country, N', ' + region, ', ' + city) AS location
FROM
    Sales.Customers;
