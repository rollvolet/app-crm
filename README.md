# Rollvolet CRM

## Running the application
```
docker-compose up
```

## Configuration
### Templates
Location: `./config/templates`

Templates used by the [document generation service](https://github.com/rollvolet/document-generation-service). Names of the templates can be configured through environment variables on the service.

### Watermarks
Location: `./config/watermarks`

Watermarks used by the [document generation service](https://github.com/rollvolet/document-generation-service). Names of the watermarks can be configured through environment variables on the service.
