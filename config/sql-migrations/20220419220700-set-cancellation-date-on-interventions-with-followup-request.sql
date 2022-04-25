SET QUOTED_IDENTIFIER ON
GO

UPDATE TblIntervention
SET CancellationDate = r.Aanvraagdatum , CancellationReason = 'Nieuwe aanvraag gestart'
FROM TblIntervention i
INNER JOIN TblAanvraag r ON r.OriginId = i.Id
WHERE i.CancellationDate IS NULL
GO

SET QUOTED_IDENTIFIER OFF
GO
