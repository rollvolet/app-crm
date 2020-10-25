CREATE TABLE klanten.dbo.TblOrderTechnician (
  OrderId int NOT NULL,
  EmployeeId int NOT NULL,
  CONSTRAINT TblOrderTechnician$PrimaryKey PRIMARY KEY (OrderId,EmployeeId)
)
CREATE UNIQUE NONCLUSTERED INDEX TblOrderTechnician$CompoundKey ON klanten.dbo.TblOrderTechnician (OrderId, EmployeeId);
