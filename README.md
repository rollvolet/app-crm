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

### Watermarks
Location: `./config/watermarks`

Watermarks used by the [document generation service](https://github.com/rollvolet/document-generation-service). Names of the watermarks can be configured through environment variables on the service.

### Backend
Location: `./config/backend`

JSON configuration used by the [backend service providing a JSONAPI](https://github.com/rollvolet/crm-api). Default configuration is set in `./config/backend/config.json`. Environment specific settings can be configured in `./config/backend/config.override.json`.

## Admin tasks
### Create a backup
Execute the following script
```bash
docker-compose exec database /bin/bash /scripts/backup.sh
```
The backup is written to `./data/backups/YYMMDDThhmmss-klanten.bak`

### Restore a backup
Put the backup to be restored in `./data/backups/klanten.bak`

Execute the following script
```bash
docker-compose exec database /bin/bash /scripts/restore.sh
```

### Executing a migration
Make sure the migration is available in `./config/migrations`

Execute the following script
```bash
docker-compose exec database /bin/bash /scripts/migrate.sh name-of-the-migration.sql
```

