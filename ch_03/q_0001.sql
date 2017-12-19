USE TSQL2012;

SELECT
    C.custid,
    E.empid
FROM
    Sales.Customers AS C
    CROSS JOIN HR.Employees AS E;

SELECT
    E1.empid, E1.firstname, E1.lastname,
    E2.empid, E2.firstname, E2.lastname
FROM
    HR.Employees AS E1
    CROSS JOIN HR.Employees AS E2;
