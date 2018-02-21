PRINT 'Первый пакет';
USE TSQL2012;
GO

PRINT 'Второй пакет';
SELECT custid FROM Sales.Customers;
SELECT orderid FRM Sales.Orders;
GO

PRINT 'Третий пакет';
SELECT empid FROM HR.Employees;
