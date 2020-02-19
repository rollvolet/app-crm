CREATE TABLE klanten.dbo.TblInterventionTechnician (
  InterventionId int NOT NULL,
  EmployeeId int NOT NULL,
  CONSTRAINT TblInterventionTechnician$PrimaryKey PRIMARY KEY (InterventionId,EmployeeId)
)

