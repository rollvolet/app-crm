SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

ALTER TABLE dbo.TblFactuurExtra ADD EenheidId int NULL;
GO

UPDATE dbo.TblFactuurExtra
SET EenheidId = 1
WHERE Eenheid='stuk(s)'

UPDATE dbo.TblFactuurExtra
SET EenheidId = 2
WHERE Eenheid='m'

UPDATE dbo.TblFactuurExtra
SET EenheidId = 3
WHERE Eenheid='m2'

ALTER TABLE dbo.TblFactuurExtra DROP COLUMN Eenheid;
