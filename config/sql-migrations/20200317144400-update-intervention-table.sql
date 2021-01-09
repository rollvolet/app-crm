DROP TABLE klanten.dbo.TblIntervention;

DROP INDEX IF EXISTS TblIntervention$CustomerId ON klanten.dbo.TblIntervention 
DROP INDEX IF EXISTS TblIntervention$BuildingId ON klanten.dbo.TblIntervention 
DROP INDEX IF EXISTS TblIntervention$ContactId ON klanten.dbo.TblIntervention 
DROP INDEX IF EXISTS TblIntervention$WayOfEntryId ON klanten.dbo.TblIntervention 
DROP INDEX IF EXISTS TblIntervention$FollowUpRequestId ON klanten.dbo.TblIntervention 
DROP INDEX IF EXISTS TblIntervention$PrimaryKey ON klanten.dbo.TblIntervention 

CREATE TABLE klanten.dbo.TblIntervention (
  Id int NOT NULL IDENTITY(1,1),
  CustomerId int DEFAULT (NULL),
  BuildingId int DEFAULT (NULL),
  ContactId int DEFAULT (NULL),
  WayOfEntryId int DEFAULT (NULL),
  OriginId int DEFAULT (NULL),
  EmployeeId int DEFAULT (NULL),
  Date datetime DEFAULT (NULL),
  Comment VARCHAR(MAX) DEFAULT (NULL),
  PlanningDate datetime DEFAULT (NULL),
  PlanningMsObjectId VARCHAR(250) DEFAULT (NULL),
  CancellationDate datetime DEFAULT (NULL)
)
CREATE NONCLUSTERED INDEX TblIntervention$CustomerId ON klanten.dbo.TblIntervention (CustomerId)
CREATE NONCLUSTERED INDEX TblIntervention$BuildingId ON klanten.dbo.TblIntervention (BuildingId)
CREATE NONCLUSTERED INDEX TblIntervention$ContactId ON klanten.dbo.TblIntervention (ContactId)
CREATE NONCLUSTERED INDEX TblIntervention$WayOfEntryId ON klanten.dbo.TblIntervention (WayOfEntryId)
CREATE NONCLUSTERED INDEX TblIntervention$OriginId ON klanten.dbo.TblIntervention (OriginId)
CREATE NONCLUSTERED INDEX TblIntervention$EmployeeId ON klanten.dbo.TblIntervention (EmployeeId)
CREATE UNIQUE INDEX TblIntervention$PrimaryKey ON klanten.dbo.TblIntervention (Id)


ALTER TABLE dbo.TblAanvraag ADD OriginId int DEFAULT (NULL);
CREATE NONCLUSTERED INDEX TblAanvraag$OriginId ON klanten.dbo.TblAanvraag (OriginId)
GO

