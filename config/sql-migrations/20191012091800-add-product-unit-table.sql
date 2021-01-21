CREATE TABLE klanten.dbo.TblProductUnit (
  Id int IDENTITY(1,1) NOT NULL,
  Code VARCHAR(100) DEFAULT (NULL),
  NameNed VARCHAR(500) DEFAULT (NULL),
  NameFra VARCHAR(500) DEFAULT (NULL)
)
CREATE INDEX TblProductUnitCode ON klanten.dbo.TblProductUnit (Code)
CREATE UNIQUE INDEX TblProductUnitPrimaryKey ON klanten.dbo.TblProductUnit (Id)
