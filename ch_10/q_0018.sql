USE TSQL2012;

IF OBJECT_ID('dbo.ErrInsertHandler', 'P') IS NOT NULL
    DROP PROC dbo.ErrInsertHandler;
GO

CREATE PROC dbo.ErrInsertHandler
AS
SET NOCOUNT ON;

IF ERROR_NUMBER() = 2627
BEGIN
    PRINT 'Primary Key error';
END
ELSE IF ERROR_NUMBER() = 547
BEGIN
    PRINT 'Foreign Key error';
END
ELSE IF ERROR_NUMBER() = 515
BEGIN
    PRINT 'NOT NULL constraint error';
END
ELSE IF ERROR_NUMBER() = 245
BEGIN
    PRINT 'Type conversion error';
END
ELSE
BEGIN
    PRINT 'Throw error again';
END

PRINT 'Number '  + CAST(ERROR_NUMBER() AS VARCHAR(10));
PRINT 'Message ' + ERROR_MESSAGE();
PRINT 'Priority ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
PRINT 'State ' + CAST(ERROR_STATE() AS VARCHAR(10));
PRINT 'Line ' + CAST(ERROR_LINE() AS VARCHAR(10));
PRINT 'Procedure ' + COALESCE(ERROR_PROCEDURE(), 'Away of proc');
GO

BEGIN TRY

    INSERT INTO dbo.Employees(empid, empname, mgrid)
        VALUES(1, 'Emp1', NULL);

END TRY
BEGIN CATCH

    IF ERROR_NUMBER() IN (2627, 547, 515, 245)
        EXEC dbo.ErrInsertHandler;
    ELSE
        THROW;

END CATCH;
