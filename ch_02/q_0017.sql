USE TSQL2012;

SELECT
    empid,
    firstname,
    lastname
FROM
    HR.Employees
WHERE
    lastname = N'дэвис';

SELECT
    empid,
    firstname,
    lastname
FROM
    HR.Employees
WHERE
    lastname COLLATE Latin1_General_CS_AS  = N'дэвис';
