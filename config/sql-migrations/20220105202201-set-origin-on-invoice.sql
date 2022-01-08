SET QUOTED_IDENTIFIER ON
GO

-- All invoices without a base amount are not created in Access
UPDATE TblFactuur
SET Origin = 'RKB'
WHERE BasisBedrag IS NULL
GO

-- All invoices with at least 1 invoiceline are created in RKB
UPDATE f
SET Origin = 'RKB'
FROM TblFactuur f
INNER JOIN TblInvoiceline l ON f.FactuurId = l.InvoiceId
GO

-- All invoices that have a base amount are created in Access
-- Note: all deposit-invoices will also be marked as 'Access' now
-- We will correct that in the next step
UPDATE TblFactuur
SET Origin = 'Access'
WHERE BasisBedrag > 0
GO

-- All deposit-invoices that are linked to an offer created in RKB (o.BestelTotaal IS NULL) after 2019
-- are created in RKB
UPDATE f
SET f.Origin = 'RKB'
FROM TblFactuur f
INNER JOIN TblVoorschotFactuur hub ON hub.VoorschotFactuurID = f.FactuurId
LEFT JOIN tblOfferte o ON hub.OfferteID = o.OfferteID
WHERE o.BestelTotaal IS NULL AND f.Datum > '2019-01-01 00:00:00.000'
GO

-- All invoices created before 2019 must be created in Access since RKB didn't exist yet
UPDATE f
SET f.Origin = 'Access'
FROM TblFactuur f
WHERE f.Datum < '2019-01-01 00:00:00.000'
GO

SET QUOTED_IDENTIFIER OFF
GO
