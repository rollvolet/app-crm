# Rollvolet CRM

## Running the application
```
docker-compose up
```

## Configuration
### Migrations
Location: `./config/migrations`

Migrations to be executed in the database. The migrations need to be executed manually (see section 'Admin tasks').

### Templates
Location: `./config/templates`

Templates used by the [document generation service](https://github.com/rollvolet/document-generation-service). Names of the templates can be configured through environment variables on the service.

### Backend
Location: `./config/backend`

JSON configuration used by the [backend service providing a JSONAPI](https://github.com/rollvolet/crm-api). Default configuration is set in `./config/backend/config.json`. Environment specific settings can be configured in `./config/backend/config.override.json`.

## Admin tasks
### Executing a migration in the database container
```
docker-compose exec database /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P secret -d klanten -i /migrations/20180731182300-add-offerline-table.sql
```
