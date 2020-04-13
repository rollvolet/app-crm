CREATE TABLE klanten.dbo.TblInvoiceline (
  Id int NOT NULL IDENTITY(1,1),
  OrderId int DEFAULT (NULL),
  InvoiceId int DEFAULT (NULL),
  VatRateId int DEFAULT (NULL),
  Currency VARCHAR(3),
  Amount float DEFAULT ((0)),
  SequenceNumber int DEFAULT ((0)),
  Description VARCHAR(8000)
)
CREATE INDEX TblInvoiceline$Amount ON klanten.dbo.TblInvoiceline (Amount)
CREATE INDEX TblInvoiceline$VatRateId ON klanten.dbo.TblInvoiceline (VatRateId)
CREATE INDEX TblInvoiceline$OrderId ON klanten.dbo.TblInvoiceline (OrderId)
CREATE INDEX TblInvoiceline$InvoiceId ON klanten.dbo.TblInvoiceline (InvoiceId)
CREATE UNIQUE INDEX TblInvoiceline$PrimaryKey ON klanten.dbo.TblInvoiceline (Id)
