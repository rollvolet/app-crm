SET QUOTED_IDENTIFIER ON
GO

UPDATE TblFactuur
SET Origin = 'Access'
WHERE BasisBedrag IS NOT NULL
GO

UPDATE TblFactuur
SET Origin = 'RKB'
WHERE BasisBedrag IS NULL
GO

UPDATE f
SET f.Origin = 'RKB'
FROM TblFactuur f
INNER JOIN TblVoorschotFactuur hub ON hub.VoorschotFactuurID = f.FactuurId
LEFT JOIN tblOfferte o ON hub.OfferteID = o.OfferteID
WHERE o.BestelTotaal IS NULL AND f.Datum > '2019-01-01 00:00:00.000'
GO

UPDATE f
SET f.Origin = 'Access'
FROM TblFactuur f
WHERE f.Datum < '2019-01-01 00:00:00.000'
GO

SET QUOTED_IDENTIFIER OFF
GO
