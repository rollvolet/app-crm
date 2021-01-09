INSERT INTO dbo.TblInvoiceline (OrderId, InvoiceId, VatRateId, Currency, Amount, SequenceNumber, Description)
SELECT OfferId, NULL, VatRateId, Currency, Amount, SequenceNumber, Description
FROM dbo.TblOfferline as [o]
WHERE o.IsOrdered = 1


UPDATE dbo.TblInvoiceline
SET InvoiceId = fac.FactuurId
FROM dbo.TblInvoiceline AS [line]
LEFT JOIN dbo.TblFactuur AS [fac] ON line.OrderId = fac.OfferteID
