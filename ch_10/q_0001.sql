USE TSQL2012;

DECLARE @i AS INT;
SET @i = 10;

DECLARE @j AS INT = 10;

SELECT
    @i AS i,
    @j AS j;

DECLARE @empname AS NVARCHAR(31);

SET @empname = (SELECT firstname + N' ' + lastname
                FROM HR.Employees
                WHERE empid = 3);

SELECT @empname AS empname;

DECLARE @firstname AS NVARCHAR(10), @lastname AS NVARCHAR(20);

SET @firstname = (SELECT firstname
                    FROM HR.Employees
                    WHERE empid = 3);

SET @lastname = (SELECT lastname
                    FROM HR.Employees
                    WHERE empid = 3);

SELECT @firstname AS firstname, @lastname AS lastname;

SELECT
    @firstname = firstname,
    @lastname  = lastname
FROM HR.Employees
WHERE empid = 4;

SELECT @firstname AS firstname, @lastname AS lastname;
