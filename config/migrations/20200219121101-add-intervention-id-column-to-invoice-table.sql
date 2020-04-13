ALTER TABLE dbo.TblFactuur ADD InterventionId int DEFAULT (NULL);
CREATE NONCLUSTERED INDEX TblFactuur$InterventionId ON klanten.dbo.TblFactuur (InterventionId)

