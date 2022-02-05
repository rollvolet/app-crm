SET QUOTED_IDENTIFIER ON
GO

UPDATE TblPersoneel
SET Aanvragen = 'B', Type = 1
WHERE Aanvragen LIKE 'A%'
GO

UPDATE TblPersoneel
SET InDienst = 0
WHERE Voornaam = '(geen)'
GO

SET QUOTED_IDENTIFIER OFF
GO
