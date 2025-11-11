#!/bin/bash

# Script to update API documentation from OpenAPI spec
# Downloads latest OpenAPI file and generates documentation

set -e  # Exit on error

echo "📥 Downloading OpenAPI spec from https://api.mixpeek.com/docs/openapi.json..."
curl -s https://api.mixpeek.com/docs/openapi.json -o api-reference/openapi.json

echo "✅ OpenAPI file downloaded successfully"

echo "📝 Generating API documentation with Mintlify..."
cd api-reference
npx @mintlify/scraping@latest openapi-file openapi.json --yes

echo "✨ API documentation updated successfully!"

