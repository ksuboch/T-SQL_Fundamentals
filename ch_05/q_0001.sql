USE TSQL2012;

SELECT *
FROM (SELECT custid, companyname
      FROM Sales.Customers
      WHERE country = 'США') AS USACusts;
