USE TSQL2012;

BEGIN TRY
    PRINT 10/2;
    PRINT 'No errors';
END TRY
BEGIN CATCH
    PRINT 'Error';
END CATCH;

BEGIN TRY
    PRINT 10/0;
    PRINT 'No errors';
END TRY
BEGIN CATCH
    PRINT 'Error';
END CATCH;