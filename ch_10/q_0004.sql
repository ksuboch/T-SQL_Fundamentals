USE TSQL2012;

IF YEAR(SYSDATETIME()) <> YEAR(DATEADD(day, 1, SYSDATETIME()))
    PRINT 'Last day of the year'
ELSE
    PRINT 'Not last day';

IF DAY(SYSDATETIME()) = 1
    BEGIN
        PRINT 'First day of month';
        PRINT '...';
    END
ELSE
    BEGIN
        PRINT 'Not a first day';
        PRINT '...';
    END
