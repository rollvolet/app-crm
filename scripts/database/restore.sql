ALTER DATABASE [klanten]
SET offline WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [klanten] FROM DISK = N'/backups/klanten.bak' WITH MOVE 'klanten' TO '/var/opt/mssql/data/Klanten.mdf', MOVE 'Klanten_log' TO '/var/opt/mssql/data/Klanten_log.ldf', FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [klanten]
SET ONLINE
GO
