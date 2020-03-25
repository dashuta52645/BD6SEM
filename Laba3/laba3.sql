use HumanResourcesDepartment;
go

EXEC sys.sp_configure N'show advanced options', N'1';
RECONFIGURE WITH OVERRIDE;
EXEC sys.sp_configure N'clr strict security', N'0';
RECONFIGURE WITH OVERRIDE;
EXEC sys.sp_configure N'show advanced options', N'0';
RECONFIGURE WITH OVERRIDE;
GO

create assembly GetEmployees
	from 'E:\3курс2сем\бд\лабы\Laba3\lab3\bin\Debug\lab3.dll'
	with permission_set = safe;

--drop assembly GetEmployees
--drop procedure GetEmployeesFromC
go
create procedure GetEmployeesFromC (@dateStart datetime, @dateEnd datetime)
	as external name GetEmployees.StoredProcedures.GetEmployees
go

exec GetEmployeesFromC '2009-03-15','2019-12-24';

create assembly GetEmp
	from 'E:\3курс2сем\бд\лабы\Laba3\Database\bin\Debug\Database.dll'
	with permission_set = safe;
--drop assembly GetEmp
--drop type Employee
create type Employee
external name GetEmp.Employee;
go 

declare @str Employee;
set @str = '20,+375336206527';
select @str.Telephone;
