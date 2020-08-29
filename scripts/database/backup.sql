DECLARE @MyFileName varchar(1000)
SELECT @MyFileName = (SELECT '/backups/' + REPLACE(REPLACE(CONVERT(varchar(500),GetDate(),126),':',''), '.', '') + '-klanten-db.bak')
BACKUP DATABASE [klanten] TO DISK=@MyFileName WITH FORMAT;
GO
