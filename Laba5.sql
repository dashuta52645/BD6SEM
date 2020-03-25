create database ResourceDepartment;
go
-----------------------------------TABLES-----------------------------------------

--DROP TABLE Users;
go
CREATE TABLE Users
(
	Id              int             IDENTITY(1,1) primary key,
	[Login]         nvarchar(30)    unique,
	[Password]      nvarchar(30)    not null,
	CreationDate    date,
	UserHid         hierarchyid     unique,
	LEVEL AS UserHid.GetLevel()     persisted
);
go
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
UserId int       not null,
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
CONSTRAINT EmployeeDepartment FOREIGN KEY(DepartmentId) REFERENCES Department,
CONSTRAINT EmployeeUsers FOREIGN KEY(UserId) REFERENCES Users
);

CREATE TABLE Layoffs
(
Id int IDENTITY(1,1) primary key,
EmployeeId int not null,
DateOfLayoff date not null,
Reason nvarchar(90)
CONSTRAINT EmployeeLayoffs FOREIGN KEY(EmployeeId) REFERENCES Employee
);

-----------------------------------PROCEDURES---------------------------------------
--DROP PROCEDURE GetAllUsers;
GO
CREATE PROCEDURE GetAllUsers
AS
BEGIN
	SELECT [Login], [Password], CreationDate, UserHid.ToString() as Node, UserHid.GetLevel() as Level 
	FROM Users;
END
GO

--DROP PROCEDURE GetDescendantByLogin;
GO
CREATE PROCEDURE GetDescendantByLogin
    @parent NVARCHAR(30)
AS
BEGIN
    DECLARE @parentHid HIERARCHYID;
	
	SELECT @parentHid = UserHid 
	FROM Users 
	WHERE [Login] = @parent;
	
	SELECT [Login], [Password], CreationDate, UserHid.ToString() as Node, UserHid.GetLevel() as Level 
	FROM Users 
	WHERE UserHid.IsDescendantOf(@parentHid) = 1;
END
GO

--DROP PROCEDURE AddDescendant;
CREATE PROCEDURE AddDescendant 
    @login NVARCHAR(30),
	@password NVARCHAR(30),
	@parent NVARCHAR(30)
AS
BEGIN
	DECLARE @parentHid HIERARCHYID, @childHid HIERARCHYID, @maxChildHid HIERARCHYID;
 
	SELECT @parentHid = UserHid 
	FROM Users 
	WHERE [Login] = @parent;
 	
	SELECT @maxChildHid = MAX(UserHid) 
	FROM Users 
	WHERE UserHid.GetAncestor(1) = @parentHid;
 	
	SET @childHid = @parentHid.GetDescendant(@maxChildHid, null);
	INSERT INTO Users values(@login, @password, GETDATE(), @childHid);
END
GO

--DROP PROCEDURE ChangeParent;
CREATE PROCEDURE ChangeParent 
    @loginForChange NVARCHAR(30),
	@newParentLogin NVARCHAR(30)
AS
BEGIN
	DECLARE
    @nodeForChange AS HIERARCHYID, -- Код узла, который мы хотим переподчинить со всеми его потомками
    @newParent AS HIERARCHYID,     -- Код узла нового родителя
    @maxChildNode AS HIERARCHYID,  -- Код узла максимального потомка нового родителя
    @newChildNode AS HIERARCHYID;  -- Код узла для нового потомка нового родителя

	SELECT @nodeForChange = UserHid
	FROM Users
	WHERE [Login] = @loginForChange;

	SELECT @newParent = UserHid
	FROM Users
	WHERE [Login] = @newParentLogin;
 
	SELECT @maxChildNode = MAX(UserHid)
	FROM Users
	WHERE UserHid.GetAncestor(1) = @newParent;
 
	SET @newChildNode = @newParent.GetDescendant(@maxChildNode, null);
 
	UPDATE Users
	SET UserHid = UserHid.GetReparentedValue(@nodeForChange, @newChildNode)
	WHERE UserHid.IsDescendantOf(@nodeForChange) = 1;
END
GO


INSERT into Users values('parent', 'user1', '2010-01-03', hierarchyid::GetRoot());

exec GetAllUsers;

exec AddDescendant 'child', 'child1', 'parent';
exec AddDescendant 'child2', 'child2', 'parent';
exec AddDescendant 'grandchild', 'grandchild1', 'child';
exec AddDescendant 'grandchild2', 'grandchild2', 'child';

exec GetDescendantByLogin 'parent';
exec GetDescendantByLogin 'child';

exec ChangeParent 'child', 'child2';

delete from Users;