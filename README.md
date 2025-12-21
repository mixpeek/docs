# Mixpeek Documentation

This repository contains the Mintlify documentation for Mixpeek.

## Installation

Install the Mintlify CLI globally:

```bash
npm i -g mintlify
```

**Note:** Requires Node.js v19 or higher. If using nvm:

```bash
nvm use 20.19.3
```

## Development

Run the local development server:

```bash
mintlify dev
```

The documentation will be available at `http://localhost:3000` by default. Use `--port` to specify a custom port:

```bash
mintlify dev --port 3333
```

## Generating API Reference from OpenAPI

To generate API reference documentation from the OpenAPI specification:

```bash
npx @mintlify/scraping@latest openapi-file openapi.json
```

This will automatically create API reference pages in the `api-reference/` directory based on your OpenAPI spec.

## Additional Commands

- `mintlify broken-links` - Check for broken internal links
- `mintlify openapi-check api-reference/openapi.json` - Validate your OpenAPI file
- `mintlify update` - Update to the latest Mintlify CLI version
