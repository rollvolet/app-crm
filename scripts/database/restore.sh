#!/bin/bash
echo "Restoring database backup..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -i /scripts/restore.sql
echo "Done!"
echo "Don't forget to execute outstanding migrations"
