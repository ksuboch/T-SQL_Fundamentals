USE TSQL2012;

WITH EmpCTE AS
(
    SELECT
        empid,
        mgrid,
        firstname,
        lastname
    FROM
        HR.Employees
    WHERE empid = 2

    UNION ALL

    SELECT
        C.empid,
        C.mgrid,
        C.firstname,
        C.lastname
    FROM EmpCTE AS P
        JOIN HR.Employees AS C
            ON C.mgrid = P.empid
)
SELECT
    empid,
    mgrid,
    firstname,
    lastname
FROM
    EmpCTE;
