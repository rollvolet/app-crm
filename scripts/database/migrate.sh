#!/bin/bash
echo "Executing migration $1..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -d Klanten -i /migrations/$1
echo "Done!"
