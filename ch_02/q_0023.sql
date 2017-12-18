USE TSQL2012;

SELECT
    SERVERPROPERTY('ProductLevel');

SELECT
    DATABASEPROPERTYEX(N'TSQL2012', 'Collation');

SELECT
    OBJECTPROPERTY(OBJECT_ID(N'Sales.Orders'), 'TableHasPrimaryKey');

SELECT
    COLUMNPROPERTY(OBJECT_ID(N'Sales.Orders'), N'shipcountry', 'AllowsNull');
