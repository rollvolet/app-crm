# Rollvolet CRM

## Running the application
```
docker-compose up
```

## Admin tasks
### Executing a migration in the database container
```
docker-compose exec database /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P secret -d klanten -i /migrations/20180731182300-add-offerline-table.sql
```
