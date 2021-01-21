CREATE TABLE klanten.dbo.TblIntervention (
  Id int NOT NULL IDENTITY(1,1),
  CustomerId int DEFAULT (NULL),
  BuildingId int DEFAULT (NULL),
  ContactId int DEFAULT (NULL),
  WayOfEntryId int DEFAULT (NULL),
  FollowUpRequestId int DEFAULT (NULL),
  Date datetime DEFAULT (NULL),
  Comment VARCHAR(MAX) DEFAULT (NULL),
  PlanningDate datetime DEFAULT (NULL),
  PlanningMsObjectId VARCHAR(250) DEFAULT (NULL)
)
CREATE NONCLUSTERED INDEX TblIntervention$CustomerId ON klanten.dbo.TblIntervention (CustomerId)
CREATE NONCLUSTERED INDEX TblIntervention$BuildingId ON klanten.dbo.TblIntervention (BuildingId)
CREATE NONCLUSTERED INDEX TblIntervention$ContactId ON klanten.dbo.TblIntervention (ContactId)
CREATE NONCLUSTERED INDEX TblIntervention$WayOfEntryId ON klanten.dbo.TblIntervention (WayOfEntryId)
CREATE NONCLUSTERED INDEX TblIntervention$FollowUpRequestId ON klanten.dbo.TblIntervention (FollowUpRequestId)
CREATE UNIQUE INDEX TblIntervention$PrimaryKey ON klanten.dbo.TblIntervention (Id)
