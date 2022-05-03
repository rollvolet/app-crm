SET QUOTED_IDENTIFIER ON
GO

UPDATE TblAanvraag
SET Opmerking = v.Opmerking , Bezoeker = v.Bezoeker
FROM TblAanvraag req
INNER JOIN TblBezoek v ON req.AanvraagID = v.AanvraagId
GO

SET QUOTED_IDENTIFIER OFF
GO
