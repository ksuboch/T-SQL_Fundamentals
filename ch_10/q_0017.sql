USE TSQL2012;

IF OBJECT_ID('dbo.Employees') IS NOT NULL
    DROP TABLE dbo.Employees;

CREATE TABLE dbo.Employees
(
    empid INT NOT NULL,
    empname VARCHAR(25) NOT NULL,
    mgrid INT NULL,
    CONSTRAINT PK_Employees PRIMARY KEY(empid),
    CONSTRAINT CHK_Employees_empid CHECK(empid > 0),
    CONSTRAINT FK_Employees_Employees
        FOREIGN KEY(mgrid) REFERENCES dbo.Employees(empid)
);

BEGIN TRY

    --INSERT INTO dbo.Employees(empid, empname, mgrid) VALUES(1, 'Emp1', NULL);
    --INSERT INTO dbo.Employees(empid, empname, mgrid) VALUES(0, 'Emp1', NULL);
    --INSERT INTO dbo.Employees(empid, empname, mgrid) VALUES('A', 'Emp1', NULL);
    INSERT INTO dbo.Employees(empid, empname, mgrid) VALUES(NULL, 'Emp1', NULL);

END TRY
BEGIN CATCH

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
        THROW;
    END

    PRINT 'Number '  + CAST(ERROR_NUMBER() AS VARCHAR(10));
    PRINT 'Message ' + ERROR_MESSAGE();
    PRINT 'Priority ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
    PRINT 'State ' + CAST(ERROR_STATE() AS VARCHAR(10));
    PRINT 'Line ' + CAST(ERROR_LINE() AS VARCHAR(10));
    PRINT 'Procedure ' + COALESCE(ERROR_PROCEDURE(), 'Away of proc');

END CATCH;
