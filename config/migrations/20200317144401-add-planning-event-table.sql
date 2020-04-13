ALTER TABLE dbo.TblIntervention DROP COLUMN PlanningDate;
ALTER TABLE dbo.TblIntervention DROP COLUMN PlanningMsObjectId;

CREATE TABLE klanten.dbo.TblPlanningEvent (
  Id int NOT NULL IDENTITY(1,1),
  InterventionId int DEFAULT (NULL),
  OrderId int DEFAULT (NULL),
  Date datetime DEFAULT (NULL),
  MsObjectId VARCHAR(250) DEFAULT (NULL),
  Subject VARCHAR(-1) DEFAULT (NULL)
)
CREATE NONCLUSTERED INDEX TblPlanningEvent$InterventionId ON klanten.dbo.TblPlanningEvent (InterventionId)
CREATE NONCLUSTERED INDEX TblPlanningEvent$OrderId ON klanten.dbo.TblPlanningEvent (OrderId)
CREATE UNIQUE INDEX TblPlanningEvent$PrimaryKey ON klanten.dbo.TblPlanningEvent (Id)
