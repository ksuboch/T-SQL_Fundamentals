USE TSQL2012;

IF OBJECT_ID('dbo.AuditDDLEvents', 'U') IS NOT NULL
    DROP TABLE dbo.AuditDDLEvents;

CREATE TABLE dbo.AuditDDLEvents
(
    audit_lsn           INT      NOT NULL IDENTITY,
    posttime            DATETIME NOT NULL,
    eventtype           SYSNAME  NOT NULL,
    loginname           SYSNAME  NOT NULL,
    schemaname          SYSNAME  NOT NULL,
    objectname          SYSNAME  NOT NULL,
    targetobjectname    SYSNAME  NULL,
    eventdata           XML      NOT NULL,
    CONSTRAINT PK_AuditDDLEvents PRIMARY KEY(audit_lsn)
);
GO

CREATE TRIGGER trg_audit_ddl_events
    ON DATABASE FOR DDL_DATABASE_LEVEL_EVENTS
AS
SET NOCOUNT ON;

DECLARE @eventdata AS XML = eventdata();

INSERT INTO dbo.AuditDDLEvents(
    posttime, eventtype, loginname, schemaname,
    objectname, targetobjectname, eventdata
) VALUES (
    @eventdata.value('(/EVENT_INSTANCE/PostTime)[1]', 'VARCHAR(23)'),
    @eventdata.value('(/EVENT_INSTANCE/EventType)[1]', 'SYSNAME'),
    @eventdata.value('(/EVENT_INSTANCE/LoginName)[1]', 'SYSNAME'),
    @eventdata.value('(/EVENT_INSTANCE/SchemaName)[1]', 'SYSNAME'),
    @eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]', 'SYSNAME'),
    @eventdata.value('(/EVENT_INSTANCE/TargetObjectName)[1]', 'SYSNAME'),
    @eventdata);
GO

CREATE TABLE dbo.T1(col1 INT NOT NULL PRIMARY KEY);
ALTER TABLE dbo.T1 ADD col2 INT NULL;
ALTER TABLE dbo.T1 ALTER COLUMN col2 INT NOT NULL;
CREATE NONCLUSTERED INDEX idx1 ON dbo.T1(col2);

SELECT * FROM dbo.AuditDDLEvents;

DROP TRIGGER trg_audit_ddl_events ON DATABASE;
DROP TABLE dbo.AuditDDLEvents;
