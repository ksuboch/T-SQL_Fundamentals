USE TSQL2012;

SELECT
    E.empid,
    E.firstname,
    E.lastname,
    O.orderid
FROM HR.Employees AS E
    JOIN Sales.Orders AS O
        ON E.empid = O.empid;

SELECT
    E.empid,
    E.firstname,
    E.lastname,
    O.orderid
FROM
    HR.Employees AS E,
    Sales.Orders AS O
WHERE
    E.empid = O.empid;
