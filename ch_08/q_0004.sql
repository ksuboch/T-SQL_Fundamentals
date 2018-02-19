USE TSQL2012;

BULK INSERT dbo.Orders FROM 'c:\temp\orders.txt'
    WITH
    (
        DATAFILENAME = 'char',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    );
