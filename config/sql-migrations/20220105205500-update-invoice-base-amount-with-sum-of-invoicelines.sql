SET QUOTED_IDENTIFIER ON
GO

UPDATE f
SET f.BasisBedrag = COALESCE(Invoicelines.BestelTotaalNetto, 0)
FROM TblFactuur f
LEFT JOIN TblVoorschotFactuur hub ON hub.VoorschotFactuurID = f.FactuurId
LEFT JOIN (
  SELECT l.InvoiceId as InvoiceId, SUM(l.Amount) as BestelTotaalNetto
  FROM TblInvoiceline l
  GROUP BY l.InvoiceId
) as Invoicelines ON Invoicelines.InvoiceId = f.FactuurId
WHERE f.Origin = 'RKB' AND hub.VoorschotId IS NULL
GO

SET QUOTED_IDENTIFIER OFF
GO
