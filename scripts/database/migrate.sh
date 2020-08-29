#!/bin/bash
echo "Executing migration $1..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -i /migrations/$1
echo "Done!"
