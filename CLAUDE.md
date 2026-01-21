# CLAUDE.md - Documentation Context

This document provides essential context for Claude Code when working on the Mixpeek documentation codebase.

## Project Overview

Mixpeek Docs is a **Mintlify-powered documentation site** featuring:
- **477+ MDX files** with interactive documentation
- **Auto-generated API reference** from OpenAPI spec
- **Mintlify framework** for beautiful, fast docs
- **Multi-section navigation** (Docs, API, Tutorials, Studio, Integrations)
- **Interactive components** (diagrams, code examples, callouts)

## Tech Stack

- **Framework:** Mintlify (React + Next.js based)
- **Content Format:** MDX (Markdown + JSX)
- **Configuration:** `mint.json`
- **Package Manager:** npm
- **Dev Server:** `mintlify dev` (port 3000)
- **API Docs:** Auto-generated from OpenAPI at `https://api.mixpeek.com/docs/openapi.json`

## Directory Structure

```
docs/
├── api-reference/              # Auto-generated API docs (50+ endpoints)
│   ├── buckets/
│   ├── collections/
│   ├── retrievers/
│   ├── taxonomies/
│   └── [other endpoints...]
│
├── overview/                   # Getting started (6 files)
│   ├── introduction.mdx
│   ├── quickstart.mdx
│   ├── concepts.mdx
│   ├── architecture.mdx
│   └── data-model.mdx
│
├── ingestion/                  # Data ingestion guides (7 files)
│   ├── objects.mdx
│   ├── uploads.mdx
│   ├── buckets.mdx
│   └── collections.mdx
│
├── processing/                 # Feature extraction (9+ files)
│   ├── extractors/
│   │   ├── multimodal.mdx
│   │   ├── audio.mdx
│   │   ├── image.mdx
│   │   ├── video.mdx
│   │   └── [other extractors...]
│   └── plugins/
│
├── retrieval/                  # Search & retrieval (35+ files)
│   ├── retrievers.mdx
│   ├── filters.mdx
│   └── stages/                 # 30+ retriever stage types
│       ├── semantic-search.mdx
│       ├── keyword-search.mdx
│       ├── rerank.mdx
│       └── [other stages...]
│
├── enrichment/                 # Taxonomies & enrichment (2 files)
│   ├── taxonomies.mdx
│   └── clusters.mdx
│
├── operations/                 # Production operations (5+ files)
│   ├── security.mdx
│   ├── webhooks.mdx
│   └── manifests.mdx
│
├── best-practices/             # Optimization guides (4 files)
│   ├── schema-design.mdx
│   ├── feature-selection.mdx
│   ├── caching.mdx
│   └── cost-optimization.mdx
│
├── troubleshoot/               # Troubleshooting (4 files)
│   ├── errors.mdx
│   ├── limits.mdx
│   └── faq.mdx
│
├── integrations/               # Third-party integrations
│   ├── object-storage/         # S3, GCS, Azure, etc.
│   └── developer-tools/        # CLI, SDKs, MCP
│
├── studio/                     # UI documentation (8 files)
│   ├── dashboard.mdx
│   ├── collections.mdx
│   └── retrievers.mdx
│
├── tutorials/                  # Step-by-step guides
│   └── [tutorial files...]
│
├── assets/                     # SVG diagrams and images
│   ├── extractors/
│   ├── plugins/
│   ├── retrievers/
│   └── tutorials/
│
├── mint.json                   # Mintlify configuration
├── package.json                # npm dependencies
└── update-api-docs.sh          # Script to regenerate API docs
```

## Writing Documentation

### MDX File Structure

**Standard document:**
```mdx
---
title: "Feature Name"
description: "Brief description for SEO and previews"
---

# Main heading (auto-generated from title, don't repeat)

Brief introduction to the feature.

## Section 1

Content with examples.

## Section 2

More content.
```

**Frontmatter fields:**
```yaml
---
title: "Page Title"                    # Required
description: "SEO description"         # Required
icon: "icon-name"                      # Optional: Mintlify icon
iconType: "solid"                      # Optional: solid, regular, light
---
```

### Mintlify Components

**Callout boxes:**
```mdx
<Note>
  This is important information.
</Note>

<Info>
  Helpful tip or additional context.
</Info>

<Warning>
  Caution: be careful with this.
</Warning>

<Tip>
  Pro tip for advanced users.
</Tip>
```

**Code blocks:**
```mdx
```python
# Single language code block
retriever = client.create_retriever(
    name="my-retriever",
    stages=[...]
)
```

<CodeGroup>
```python Python
# Multi-language code example
client.create_retriever(name="test")
```

```javascript JavaScript
// Same example in JavaScript
client.createRetriever({ name: "test" })
```

```bash cURL
# Same example with cURL
curl -X POST https://api.mixpeek.com/retrievers \
  -H "Authorization: Bearer $TOKEN"
```
</CodeGroup>
```

**Tabs:**
```mdx
<Tabs>
  <Tab title="Option 1">
    Content for option 1
  </Tab>
  <Tab title="Option 2">
    Content for option 2
  </Tab>
</Tabs>
```

**Cards:**
```mdx
<CardGroup cols={2}>
  <Card title="Feature 1" icon="rocket" href="/path/to/feature1">
    Description of feature 1
  </Card>
  <Card title="Feature 2" icon="star" href="/path/to/feature2">
    Description of feature 2
  </Card>
</CardGroup>
```

**Steps:**
```mdx
<Steps>
  <Step title="First Step">
    Do this first
  </Step>
  <Step title="Second Step">
    Then do this
  </Step>
  <Step title="Third Step">
    Finally, do this
  </Step>
</Steps>
```

**Images:**
```mdx
<Frame>
  <img src="/assets/diagram.svg" alt="Architecture diagram" />
</Frame>

<Frame caption="This is a caption">
  <img src="/images/screenshot.png" alt="Screenshot" />
</Frame>
```

**Accordions:**
```mdx
<AccordionGroup>
  <Accordion title="Question 1">
    Answer to question 1
  </Accordion>
  <Accordion title="Question 2">
    Answer to question 2
  </Accordion>
</AccordionGroup>
```

**Parameter tables:**
```mdx
<ParamField path="name" type="string" required>
  The name of the resource
</ParamField>

<ParamField path="config" type="object">
  Optional configuration object
</ParamField>
```

### Code Examples

**Best practices:**
```mdx
## Creating a Retriever

Here's how to create a retriever with semantic search:

<CodeGroup>
```python Python
from mixpeek import Mixpeek

client = Mixpeek(api_key="your-api-key")

retriever = client.retrievers.create(
    name="semantic-search",
    stages=[
        {
            "type": "semantic_search",
            "config": {
                "query": "{{INPUT.query}}",
                "top_k": 10
            }
        }
    ]
)
```

```javascript JavaScript
import { Mixpeek } from 'mixpeek-sdk'

const client = new Mixpeek({ apiKey: 'your-api-key' })

const retriever = await client.retrievers.create({
  name: 'semantic-search',
  stages: [
    {
      type: 'semantic_search',
      config: {
        query: '{{INPUT.query}}',
        top_k: 10
      }
    }
  ]
})
```

```bash cURL
curl -X POST https://api.mixpeek.com/retrievers \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "semantic-search",
    "stages": [
      {
        "type": "semantic_search",
        "config": {
          "query": "{{INPUT.query}}",
          "top_k": 10
        }
      }
    ]
  }'
```
</CodeGroup>

<Note>
  Replace `your-api-key` with your actual API key.
</Note>
```

## Configuration (mint.json)

### Navigation Structure

**Main sections:**
```json
{
  "tabs": [
    { "name": "Documentation", "url": "overview" },
    { "name": "API Reference", "url": "api-reference" },
    { "name": "Tutorials", "url": "tutorials" },
    { "name": "Studio", "url": "studio" },
    { "name": "Integrations", "url": "integrations" }
  ]
}
```

**Sidebar navigation:**
```json
{
  "navigation": [
    {
      "group": "Getting Started",
      "pages": [
        "overview/introduction",
        "overview/quickstart",
        "overview/concepts"
      ]
    },
    {
      "group": "Ingest Data",
      "pages": [
        "ingestion/objects",
        "ingestion/uploads",
        "ingestion/buckets"
      ]
    }
  ]
}
```

**Adding a new page:**
1. Create the MDX file in the appropriate directory
2. Add the file path to `mint.json` navigation
3. Use forward slashes, omit `.mdx` extension

```json
{
  "group": "My Section",
  "pages": [
    "my-section/page1",      // Points to my-section/page1.mdx
    "my-section/page2"       // Points to my-section/page2.mdx
  ]
}
```

**Nested groups:**
```json
{
  "group": "Search & Retrieve",
  "pages": [
    "retrieval/retrievers",
    {
      "group": "Stages",
      "pages": [
        "retrieval/stages/semantic-search",
        "retrieval/stages/keyword-search",
        "retrieval/stages/rerank"
      ]
    }
  ]
}
```

### Branding

```json
{
  "name": "Mixpeek",
  "logo": {
    "dark": "/logo/dark.png",
    "light": "/logo/light.png"
  },
  "colors": {
    "primary": "#FC5185",
    "dark": "#364F6B",
    "ultraDark": "#18283A"
  },
  "favicon": "/favicon.png"
}
```

### API Configuration

```json
{
  "api": {
    "baseUrl": "https://api.mixpeek.com",
    "auth": {
      "method": "bearer",
      "name": "Authorization"
    }
  },
  "openapi": "https://api.mixpeek.com/docs/openapi.json"
}
```

## Development Workflow

### Running Locally

```bash
# Start dev server
mintlify dev

# Start on custom port
mintlify dev --port 3333

# Check for broken links
mintlify broken-links

# Update Mintlify CLI
mintlify update
```

### Regenerating API Docs

```bash
# Run the update script
./update-api-docs.sh

# Or manually
npx @mintlify/scraping@latest openapi-file openapi.json
```

**What this does:**
1. Downloads OpenAPI spec from `https://api.mixpeek.com/docs/openapi.json`
2. Generates MDX files for each endpoint in `api-reference/`
3. Updates navigation in `mint.json`

### Adding New Documentation

**For features:**
1. Create MDX file in appropriate section (e.g., `processing/extractors/my-new-extractor.mdx`)
2. Add frontmatter with title and description
3. Write content using Mintlify components
4. Add file to `mint.json` navigation
5. Add code examples in multiple languages
6. Include diagrams/images in `/assets` if needed

**For API endpoints:**
- Auto-generated from OpenAPI spec
- Don't manually edit files in `api-reference/`
- Update OpenAPI spec in server instead

### Adding Assets

**Images and diagrams:**
```bash
# Add to appropriate assets directory
docs/assets/extractors/my-diagram.svg
docs/assets/tutorials/screenshot.png

# Reference in MDX
<Frame>
  <img src="/assets/extractors/my-diagram.svg" alt="Diagram" />
</Frame>
```

**SVG diagrams:**
- Preferred for architecture/flow diagrams
- Use consistent Mixpeek colors (#FC5185, #364F6B)
- Export from Figma/Excalidraw as SVG
- Optimize with SVGO

## Content Guidelines

### Writing Style

- **Clear and concise:** Get to the point quickly
- **Active voice:** "Create a retriever" not "A retriever can be created"
- **Present tense:** "The API returns a response" not "The API will return"
- **Second person:** Address the reader as "you"
- **Technical but accessible:** Explain complex concepts simply

**Example:**
```mdx
❌ BAD: "The retriever resource can be created by making a POST request to the endpoint."

✅ GOOD: "Create a retriever by sending a POST request to `/retrievers`."
```

### Code Example Guidelines

- **Always include multiple languages** (Python, JavaScript, cURL minimum)
- **Show complete, runnable examples**
- **Use realistic data** (not `foo`, `bar`, `test123`)
- **Include error handling** where appropriate
- **Highlight important parts** with comments

**Example:**
```mdx
<CodeGroup>
```python Python
from mixpeek import Mixpeek

# Initialize client with your API key
client = Mixpeek(api_key="your-api-key")

# Create a semantic search retriever
retriever = client.retrievers.create(
    name="product-search",
    stages=[
        {
            "type": "semantic_search",
            "config": {
                "query": "{{INPUT.query}}",  # User's search query
                "top_k": 20,                  # Return top 20 results
                "threshold": 0.7              # Minimum similarity score
            }
        }
    ]
)

print(f"Created retriever: {retriever.id}")
```
</CodeGroup>
```

### API Documentation Pattern

**Endpoint page structure:**
```mdx
---
title: "Create Retriever"
description: "Create a new retriever with custom stages"
api: "POST /retrievers"
---

# Create Retriever

Creates a new retriever with the specified configuration.

## Request

<ParamField path="name" type="string" required>
  Unique name for the retriever
</ParamField>

<ParamField path="stages" type="array" required>
  Array of stage objects defining the retrieval pipeline
</ParamField>

<ParamField path="metadata" type="object">
  Optional metadata key-value pairs
</ParamField>

## Response

Returns the created retriever object.

<ResponseField name="id" type="string">
  Unique identifier for the retriever
</ResponseField>

<ResponseField name="name" type="string">
  Name of the retriever
</ResponseField>

<ResponseField name="created_at" type="string">
  ISO 8601 timestamp of creation
</ResponseField>

## Example Request

<CodeGroup>
```python Python
retriever = client.retrievers.create(
    name="my-retriever",
    stages=[...]
)
```
</CodeGroup>

## Example Response

```json
{
  "id": "retr_1234567890",
  "name": "my-retriever",
  "stages": [...],
  "created_at": "2024-01-15T10:30:00Z"
}
```
```

## Common Patterns

### Feature Documentation Template

```mdx
---
title: "Feature Name"
description: "Brief description of the feature"
---

## Overview

What is this feature and why would you use it?

## How It Works

Explain the underlying mechanism.

## Configuration

<ParamField path="param1" type="string" required>
  Description of parameter 1
</ParamField>

<ParamField path="param2" type="number">
  Description of parameter 2
</ParamField>

## Example

<CodeGroup>
```python Python
# Complete example
```
```javascript JavaScript
// Complete example
```
</CodeGroup>

## Use Cases

When to use this feature:
- Use case 1
- Use case 2
- Use case 3

## Best Practices

<Tip>
  Helpful tip for using this feature effectively
</Tip>

<Warning>
  Common pitfall to avoid
</Warning>

## Related

- [Related Feature 1](/path/to/feature1)
- [Related Feature 2](/path/to/feature2)
```

### Tutorial Template

```mdx
---
title: "Tutorial: Build X"
description: "Step-by-step guide to building X"
---

## What You'll Build

Brief description and screenshot/demo of final result.

## Prerequisites

- Requirement 1
- Requirement 2

## Step 1: Setup

<Steps>
  <Step title="Install dependencies">
    ```bash
    npm install mixpeek-sdk
    ```
  </Step>

  <Step title="Initialize client">
    ```javascript
    const client = new Mixpeek({ apiKey: 'your-key' })
    ```
  </Step>
</Steps>

## Step 2: Implementation

Detailed implementation with code examples.

## Step 3: Testing

How to test and verify it works.

## Next Steps

What to do next:
- Enhancement 1
- Enhancement 2

## Complete Code

Full working code example.
```

## SEO and Discoverability

### Meta Tags

**Always include:**
- `title`: Descriptive, under 60 characters
- `description`: SEO description, under 160 characters

**Example:**
```yaml
---
title: "Semantic Search | Mixpeek Docs"
description: "Learn how to implement semantic search with Mixpeek retrievers using dense vector embeddings for meaning-based search."
---
```

### Internal Linking

**Link to related content:**
```mdx
For more information, see [Retriever Stages](/retrieval/stages).

Learn about [Taxonomies](/enrichment/taxonomies) for classification.
```

### Structured Navigation

- Organize content logically by user journey
- Use clear, descriptive group names
- Progressive disclosure: basics → advanced

## Common Issues

### Broken Links
```bash
# Check for broken links
mintlify broken-links

# Fix absolute vs relative paths
/path/to/page     # ✅ Correct
./path/to/page    # ❌ Wrong
path/to/page      # ❌ Wrong
```

### Images Not Loading
```mdx
# ✅ Correct - absolute path from public/
<img src="/assets/diagram.svg" />

# ❌ Wrong - relative path
<img src="./assets/diagram.svg" />

# ❌ Wrong - missing leading slash
<img src="assets/diagram.svg" />
```

### Navigation Not Updating
- Restart dev server after editing `mint.json`
- Check for JSON syntax errors in `mint.json`
- Ensure file paths in navigation match actual file locations

## Pre-commit Checklist

Before committing documentation changes:

- [ ] MDX files have proper frontmatter (title, description)
- [ ] Code examples work and are tested
- [ ] Multi-language examples provided
- [ ] Images/diagrams referenced correctly
- [ ] Internal links use correct paths
- [ ] New pages added to `mint.json` navigation
- [ ] No broken links (`mintlify broken-links`)
- [ ] Dev server runs without errors
- [ ] Spelling and grammar checked
