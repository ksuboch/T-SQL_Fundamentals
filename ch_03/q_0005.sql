USE TSQL2012;

SELECT
    E1.empid,
    E1.firstname,
    E1.lastname,
    E2.empid,
    E2.firstname,
    E2.lastname
FROM HR.Employees AS E1
    JOIN HR.Employees AS E2
        ON E1.empid < E2.empid;
