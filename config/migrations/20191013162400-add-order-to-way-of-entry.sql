ALTER TABLE dbo.TblAanmelding ADD Position int NULL;
GO

UPDATE dbo.TblAanmelding
SET Position = 1
WHERE AanmeldingOmschrijving='Telefoon'

UPDATE dbo.TblAanmelding
SET Position = 2
WHERE AanmeldingOmschrijving='Toonzaal'

UPDATE dbo.TblAanmelding
SET Position = 3
WHERE AanmeldingOmschrijving='E-post'

INSERT INTO dbo.TblAanmelding
VALUES ('Website', 4);

UPDATE dbo.TblAanmelding
SET Position = 5
WHERE AanmeldingOmschrijving='Mondeling'

UPDATE dbo.TblAanmelding
SET Position = 6
WHERE AanmeldingOmschrijving='Brief'

UPDATE dbo.TblAanmelding
SET Position = 7
WHERE AanmeldingOmschrijving='Fax'

UPDATE dbo.TblAanmelding
SET Position = 8
WHERE AanmeldingOmschrijving='Onbekend'

UPDATE dbo.TblAanmelding
SET Position = 9
WHERE AanmeldingOmschrijving='Te bezoeken'

