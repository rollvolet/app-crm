SET QUOTED_IDENTIFIER ON
GO

-- Create an invoiceline for each invoice, that is not a deposit invoice, with a base amount > 0.
-- As such, in the future the base amount can be calculated by taking the sum of invoicelines
INSERT INTO TblInvoiceline (OrderId, InvoiceId, VatRateId, Currency, Amount, SequenceNumber, Description)
SELECT f.OfferteID, f.FactuurId, f.BtwId, f.MuntEenheid, f.BasisBedrag, 0, 'Basisbedrag'
FROM TblFactuur f
LEFT JOIN TblVoorschotFactuur hub ON hub.VoorschotFactuurID = f.FactuurId
WHERE hub.VoorschotId IS NULL -- no deposit invoice
AND f.BasisBedrag > 0 AND f.MuntEenheid = 'EUR'
GO

-- Update description to 'Bedrag bestelling' for invoices related to an offer
UPDATE l
SET l.Description = 'Bedrag bestelling'
FROM TblInvoiceline l
WHERE l.OrderId IS NOT NULL AND l.Description = 'Basisbedrag'
GO

SET QUOTED_IDENTIFIER OFF
GO
