SET QUOTED_IDENTIFIER ON
GO

-- Update the base amount of all invoices, that are not deposit-invoices,
-- to the sum of its invoicelines
UPDATE f
SET f.BasisBedrag = COALESCE(Invoicelines.BestelTotaalNetto, 0)
FROM TblFactuur f
LEFT JOIN TblVoorschotFactuur hub ON hub.VoorschotFactuurID = f.FactuurId
LEFT JOIN (
  SELECT l.InvoiceId as InvoiceId, SUM(l.Amount) as BestelTotaalNetto
  FROM TblInvoiceline l
  GROUP BY l.InvoiceId
) as Invoicelines ON Invoicelines.InvoiceId = f.FactuurId
WHERE f.MuntEenheid = 'EUR' AND hub.VoorschotId IS NULL
GO

-- No need to recalculate the amount of the invoice
-- which is the sum of the base-amount + invoicelines + supplements - deposit-invoices
-- The total sum stays the same

SET QUOTED_IDENTIFIER OFF
GO
