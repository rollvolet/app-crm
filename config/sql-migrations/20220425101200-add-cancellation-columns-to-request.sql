ALTER TABLE dbo.TblAanvraag ADD CancellationDate datetime DEFAULT (NULL);
GO

ALTER TABLE dbo.TblAanvraag ADD CancellationReason VARCHAR(4000) DEFAULT (NULL);
GO
