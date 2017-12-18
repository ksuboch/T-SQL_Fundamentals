USE TSQL2012;

SELECT
    SCHEMA_NAME(schema_id) AS table_schema_name,
    name AS table_schema_name
FROM sys.tables;

SELECT
    name AS column_name,
    TYPE_NAME(system_type_id) AS column_type,
    max_length,
    collation_name,
    is_nullable
FROM sys.columns
WHERE object_id = OBJECT_ID('Sales.Orders');

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    COLLATION_NAME,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'Sales'
  AND TABLE_NAME   = N'Orders';

EXEC sys.sp_tables;

EXEC sys.sp_help
    @objname = N'Sales.Orders';

EXEC sys.sp_columns
    @table_name = N'Orders',
    @table_owner = N'Sales';

EXEC sys.sp_helpconstraint
    @objname = N'Sales.Orders';
