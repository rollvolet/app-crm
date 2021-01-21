CREATE TABLE klanten.dbo.TblInterventionTechnician (
  InterventionId int NOT NULL,
  EmployeeId int NOT NULL,
  CONSTRAINT TblInterventionTechnician$PrimaryKey PRIMARY KEY (InterventionId,EmployeeId)
)
CREATE UNIQUE NONCLUSTERED INDEX TblInterventionTechnician$CompoundKey ON klanten.dbo.TblInterventionTechnician (InterventionId, EmployeeId);
