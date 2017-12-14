USE tsql2012;

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
	DROP TABLE dbo.Employees

CREATE TABLE dbo.Employees
(
	empid	  INT		  NOT NULL,
	firstname VARCHAR(30) NOT NULL,
	leatname  VARCHAR(30) NOT NULL,
	hiredate  DATE		  NOT NULL,
	mgrid	  INT		  NULL,
	ssn		  VARCHAR(20) NOT NULL,
	salary	  MONEY		  NOT NULL
);

ALTER TABLE dbo.Employees
	ADD CONSTRAINT PK_Employees
	PRIMARY KEY(empid);

ALTER TABLE dbo.Employees
	ADD CONSTRAINT UNQ_Employees_ssn
	UNIQUE(ssn);

ALTER TABLE dbo.Employees
	ADD CONSTRAINT FK_Emloyees_Employees
	FOREIGN KEY(mgrid)
	REFERENCES dbo.Employees(empid);

ALTER TABLE dbo.Employees
	ADD CONSTRAINT CHK_Emplloyees_salary
	CHECK(salary > 0.00);
