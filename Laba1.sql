create user Dasha with password='12345';
create database HumanResourcesDepartment;
use HumanResourcesDepartment;
CREATE TABLE Post
(
Id int IDENTITY(1,1) primary key,
PostName nvarchar(90) not null,
Salary int not null
);
CREATE TABLE Department
(
Id int IDENTITY(1,1) primary key,
DepartmentName nvarchar(90) not null,
RoomNumber int not null,
Telephone nvarchar(20)
);

CREATE TABLE Employee
(
Id int IDENTITY(1,1) primary key,
FullName nvarchar(120) not null,
Gender nvarchar(30) not null,
FamilyStatus nvarchar(90) not null,
HomeAddress nvarchar(90),
Telephone nvarchar(20),
Education nvarchar(90) ,
DateOfReceipt date not null,
DepartmentId int not null,
PostId int not null
CONSTRAINT EmployeePost FOREIGN KEY(PostId) REFERENCES Post,
CONSTRAINT EmployeeDepartment FOREIGN KEY(DepartmentId) REFERENCES Department
);

CREATE TABLE Layoffs
(
Id int IDENTITY(1,1) primary key,
EmployeeId int not null,
DateOfLayoff date not null,
Reason nvarchar(90)
CONSTRAINT EmployeeLayoffs FOREIGN KEY(EmployeeId) REFERENCES Employee
);
-----------------------------------------------------------------------------
INSERT into Post values('Уборщик',550 );
INSERT into Post values('Бухгалтер', 780);
INSERT into Post values('Менеджер', 940);
INSERT into Post values('Директор',1500);
INSERT into Post values('Заместитель директора', 1000);
INSERT into Post values('Секретарь',790);
INSERT into Post values('Юрист',1100);
INSERT into Post values('Специалист по кадрам',1100);

INSERT into Department values('Управления',125,'+375295164892' );
INSERT into Department values('Бухгалтерcкий',105,'+375291584679');
INSERT into Department values('Менеджмента', 100,'+375291482357');
INSERT into Department values('Секретариат',104,'+375331652482');
INSERT into Department values('Юридический',103,'+375294852916');
INSERT into Department values('Кадров',101,'+375334625731');

INSERT into Employee values('Федоров Василий Иванович', 'Мужской', 'Женат','ул.Первомайская д.8 кв.6','+375332486517','БГУ Юридичесикий факультет','2009-03-15',5,7);
INSERT into Employee values('Скворцова Елена Николаевна', 'Женский', 'Замужем','ул.Зеленая д.10 кв.8','+375332988425','БГУ Бухгалтерский учет', '2015-04-03',2,2);
INSERT into Employee values('Никифоров Евгений Леонович', 'Мужской', 'Женат','ул.Васнецова д.48 кв.16','+37533487515','Ак.Управл. Управленец','2009-08-19',1,4);
INSERT into Employee values('Крастенюк Анна Викторовна',  'Женский', 'Не замужем','ул.Космонавтов д.145 кв.78','+375337826491','ПТУ Швея', '2015-08-05',1,1);
INSERT into Employee values('Фролова Евгения Михайловна',  'Женский', 'Не замужем','ул.Пролетарская д.189 кв.42','+375334872651','Ак.Управл Управденец', '2015-07-10',1,5);
INSERT into Employee values('Ливнев Алексей Мячеславович', 'Мужской', 'Не женат','ул.Московская д.32 кв.52','+375334726589','БНТУ Менеджмент','2009-04-15',3,3);
INSERT into Employee values('Скотенюк Андрей Валнтинович', 'Мужской', 'Женат','ул.Гоголя д.48 кв.16','+37533487515','Ак.Управл. Управленец','2019-12-24',1,4);
INSERT into Employee values('Ягейло Валентина Феликсовна',  'Женский', 'Замужем','ул.Космонавтов д.17 кв.8','+375337486491','Базовое школьное', '2018-04-28',1,1);
INSERT into Employee values('Чехмень Алла Эдуардовна',  'Женский', 'Не замужем','ул.Пролетарская д.189 кв.42','+375334872651','Ак.Управл Управденец', '2017-06-14',1,5);
INSERT into Employee values('Коротнев Владислав Георгьевич', 'Мужской', 'Не женат','ул.Московская д.32 кв.52','+375334726589','БНТУ Менеджмент','2019-07-18',3,3);
delete from Layoffs;
INSERT into Layoffs values(3,'2019-12-04','Переезд' );
INSERT into Layoffs values(4,'2018-04-17','Семейные обстоятельства');
INSERT into Layoffs values(5,'2017-06-05','Переход в другую компанию');
INSERT into Layoffs values(6,'2019-07-10','Личные причины');
-----------------------------------VIEW-------------------------------------------
go
CREATE VIEW GetEmployees as select * from Employee;
go
CREATE VIEW GetPosts as select * from Post;
go
CREATE VIEW GetDepartments as select * from Department;
go
CREATE VIEW GetLayoffs as select * from Layoffs;
go

select * from GetEmployees;
select * from GetPosts;
select * from GetLayoffs;
select * from GetDepartments;
------------------------------------------Procedures------------------------------
--DROP PROCEDURE GetWorksEmployees;
GO
CREATE PROCEDURE GetWorksEmployees
AS
BEGIN
	SELECT E.FullName,E.Gender,E.FamilyStatus,E.HomeAddress,E.Telephone,E.Education,E.DateOfReceipt,E.DepartmentId,E.PostId FROM Employee E 
	left join Layoffs L on E.Id = L.EmployeeId where L.Id IS NULL ;

END
GO

exec GetWorksEmployees;
-----------------------------

--DROP PROCEDURE GetAllPosts;
GO
CREATE PROCEDURE GetAllPosts
AS
BEGIN
	SELECT * FROM Post;
END
GO

exec GetAllPosts;

------------------------------
--DROP PROCEDURE GetAllDepartments;
GO
CREATE PROCEDURE GetAllDepartments
AS
BEGIN
	SELECT * FROM Department;
END
GO

exec GetAllDepartments;
---------------------------------
DROP PROCEDURE GetAllEmp
GO
CREATE PROCEDURE GetAllEmp
AS
BEGIN
	select FullName,Gender,FamilyStatus,HomeAddress,Telephone,Education,DateOfReceipt,PostId,DepartmentId from Employee;
END
GO
--DROP PROCEDURE GetAllEmployees;
GO
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
	SELECT E.FullName,E.Gender,E.FamilyStatus,E.HomeAddress,E.Telephone,E.Education,E.DateOfReceipt,P.PostName,D.DepartmentName FROM Employee E 
	inner join Post P on E.PostId = P.Id
   inner join Department D on E.DepartmentId=D.Id;
END
GO

exec GetAllEmployees;
------------------------------------
--DROP PROCEDURE GetAllLayoffs;
GO
CREATE PROCEDURE GetAllLayoffs
AS
BEGIN
	SELECT L.Id,E.FullName,L.DateOfLayoff,L.Reason FROM Layoffs L 
	inner join Employee E on L.EmployeeId = E.Id;
END
GO

exec GetAllLayoffs;
------------------------------------------
--DROP PROCEDURE AddPost;
GO
CREATE PROCEDURE AddPost
    @PostName NVARCHAR(80),
	@Salary int
AS
BEGIN
	DECLARE @checkPost int;
	SELECT @checkPost = count(*) FROM Post WHERE PostName = @PostName;
	IF(@checkPost = 0)
		INSERT INTO Post values(@PostName, @Salary);
END
GO
--------------------------------------------------
--DROP PROCEDURE AddPost;
GO
CREATE PROCEDURE AddDepartment
    @DepartmentName NVARCHAR(80),
	@RoomNumber int,
	@Telephone NVARCHAR(20)
AS
BEGIN
	DECLARE @checkDep int;
	SELECT @checkDep = count(*) FROM Department WHERE DepartmentName = @DepartmentName;
	IF(@checkDep = 0)
		INSERT INTO Department values(@DepartmentName, @RoomNumber,@Telephone);
END
GO
-----------------------------------------------------------------------------
GO
CREATE PROCEDURE AddLayoffs
    @EmployeeId int,
	@DateOfLayoff date,
	@Reason NVARCHAR(70)
AS
BEGIN
		INSERT INTO Layoffs values(@EmployeeId, @DateOfLayoff,@Reason);
END
GO
-----------------------------------------------------------
drop procedure AddEmployee
GO
CREATE PROCEDURE AddEmployee
@FullName nvarchar(120),
@Gender nvarchar(30),
@FamilyStatus nvarchar(90),
@HomeAddress nvarchar(90),
@Telephone nvarchar(20),
@Education nvarchar(90) ,
@DateOfReceipt nvarchar(10),
@DepartmentId int,
@PostId int
AS
BEGIN
		INSERT INTO Employee values(@FullName, @Gender,@FamilyStatus,@HomeAddress,@Telephone,@Education,@DateOfReceipt,@DepartmentId,@PostId);
		commit;
END
GO
--------------------------------------------------------------------
drop procedure UpdateEmployee
GO
CREATE PROCEDURE UpdateEmployee
@Id int,
@FullName nvarchar(120),
@Gender nvarchar(30),
@FamilyStatus nvarchar(90),
@HomeAddress nvarchar(90),
@Telephone nvarchar(20),
@Education nvarchar(90),
@DateOfReceipt nvarchar(10),
@DepartmentId int,
@PostId int
AS
BEGIN
		UPDATE Employee set FullName=@FullName,Gender= @Gender,FamilyStatus= @FamilyStatus,HomeAddress= @HomeAddress,Telephone= @Telephone,Education= @Education,DateOfReceipt= @DateOfReceipt,DepartmentId= @DepartmentId,PostId= @PostId where Id=@Id;
END
commit;
GO
------------------------------------------------------------------------
DROP PROCEDURE DeletePost;
GO
CREATE PROCEDURE DeletePost
    @Id int
AS
BEGIN
	delete from  Post where Id=@Id;
END
GO
--------------------------------------------------
DROP PROCEDURE DeleteEmployee;
GO
CREATE PROCEDURE DeleteEmployee
    @Id int
AS
BEGIN
begin transaction
	delete from  Employee where Id=@Id;
	commit transaction
END
GO
--------------------------------------------------
DROP PROCEDURE DeleteDepartment;
GO
CREATE PROCEDURE DeleteDepartment
    @Id int
AS
BEGIN
delete from Department where Id=@Id;
END
GO
-----------------------------------------------------------------------------
GO
CREATE PROCEDURE DeleteLayoffs
    @EmployeeId int
AS
BEGIN
		delete from Layoffs where EmployeeId=@EmployeeId;
END
GO
-------------------------------FUNCTION----------------------------------------------
DROP FUNCTION IsValidId;
GO
CREATE FUNCTION IsValidId(@Id int) returns varchar(80)
BEGIN
	DECLARE @check INT,@res varchar(80);
	SELECT @check = count(*) FROM Employee WHERE Id = @Id;
	IF(@check > 0 )
	BEGIN
	set @res='This Id is exist';
	END;
	ELSE 
	set @res='This Id does not exist';
    return @res;
end
GO

--select dbo.IsValidId(7);
-----------------------------------TRIGGERS---------------------------------------
drop table CompanyNeeds;
CREATE TABLE CompanyNeeds
(
Id int IDENTITY(1,1) primary key,
[Date] date not null,
DepartmentName nvarchar(200) not null,
);
select* from CompanyNeeds;
delete from CompanyNeeds;

DROP TRIGGER AFTER_ADD_LAYOFF;
GO
CREATE TRIGGER AFTER_ADD_LAYOFF
ON Layoffs AFTER INSERT
AS
	DECLARE @id INT,@post varchar(50), @res varchar(200),@date date;
	SELECT @id =EmployeeId,@date=DateOfLayoff FROM inserted;
	Select @post=P.PostName from Employee E inner join Post P on E.PostId=P.Id where E.Id=@id; 
	set @res= 'Компания нуждается в новом сотруднике на должность:'+@post;
	insert into CompanyNeeds values(@date,@res);
RETURN ;
GO

