# Documentation Patterns & Best Practices

This document defines patterns, conventions, and best practices for the Mixpeek documentation.

## Critical Architectural Boundaries

### 🚫 STRICT CONTENT BOUNDARIES

**RULE 1: Never Manually Edit API Reference Files**

```bash
# ❌ FORBIDDEN - manually editing auto-generated files
docs/api-reference/retrievers/create.mdx  # Auto-generated!

# ✅ CORRECT - update OpenAPI spec in server instead
server/api/retrievers/controllers.py  # Update docstrings here
```

**Why:** API reference is auto-generated from the OpenAPI spec. Manual edits will be overwritten.

**RULE 2: Keep Assets Organized by Section**

```bash
# ❌ BAD - mixing assets in root
docs/assets/diagram1.svg
docs/assets/screenshot.png
docs/assets/icon.svg

# ✅ GOOD - organized by feature
docs/assets/extractors/multimodal-flow.svg
docs/assets/retrievers/pipeline-diagram.svg
docs/assets/tutorials/quickstart-screenshot.png
```

**RULE 3: One Concept Per Page**

```mdx
<!-- ❌ BAD - cramming multiple concepts -->
# Collections, Buckets, and Namespaces

Collections are...
Buckets are...
Namespaces are...

<!-- ✅ GOOD - separate pages -->
# collections.mdx
# Collections
Collections are...

# buckets.mdx
# Buckets
Buckets are...

# namespaces.mdx
# Namespaces
Namespaces are...
```

**RULE 4: Use Relative Links Within Docs**

```mdx
<!-- ❌ BAD - absolute external URLs -->
[Retrievers](https://docs.mixpeek.com/retrieval/retrievers)

<!-- ✅ GOOD - relative internal links -->
[Retrievers](/retrieval/retrievers)
```

## File Naming Conventions

### MDX Files

**Use kebab-case:**
```bash
✅ semantic-search.mdx
✅ api-configuration.mdx
✅ getting-started.mdx

❌ SemanticSearch.mdx
❌ api_configuration.mdx
❌ Getting Started.mdx
```

**Descriptive names:**
```bash
✅ multimodal-feature-extractor.mdx
✅ keyword-search-stage.mdx

❌ extractor1.mdx
❌ stage.mdx
```

### Assets

**Descriptive names with context:**
```bash
✅ assets/retrievers/semantic-search-flow.svg
✅ assets/tutorials/quickstart-step1.png

❌ assets/diagram.svg
❌ assets/image1.png
```

## Content Structure Patterns

### Standard Page Template

```mdx
---
title: "Descriptive Title"
description: "SEO-friendly description under 160 characters"
---

## Overview

Brief 2-3 sentence introduction to the feature/concept.

## How It Works

Explain the mechanism or workflow.

<Frame>
  <img src="/assets/section/concept-diagram.svg" alt="Diagram showing workflow" />
</Frame>

## Configuration

<ParamField path="param_name" type="string" required>
  Clear description of what this parameter does
</ParamField>

## Example

<CodeGroup>
```python Python
# Working example with realistic data
```

```javascript JavaScript
// Same example in JavaScript
```

```bash cURL
# Same example with cURL
```
</CodeGroup>

## Use Cases

- **Use case 1:** When you need to...
- **Use case 2:** For scenarios where...
- **Use case 3:** If you want to...

## Best Practices

<Tip>
  Pro tip for optimal usage
</Tip>

<Warning>
  Common pitfall to avoid
</Warning>

## Related

- [Related Concept 1](/path/to/concept1)
- [Related Concept 2](/path/to/concept2)
```

### Tutorial Page Template

```mdx
---
title: "Tutorial: Build [X]"
description: "Step-by-step guide to building [X] with Mixpeek"
---

## What You'll Build

Describe the end result with a screenshot or demo.

## Prerequisites

- Requirement 1 with [link to setup](/path/to/setup)
- Requirement 2
- Estimated time: X minutes

## Architecture

<Frame>
  <img src="/assets/tutorials/architecture-diagram.svg" alt="Architecture" />
</Frame>

<Steps>
  <Step title="Step 1: Setup">
    Detailed instructions for step 1.

    ```python
    # Code example
    ```
  </Step>

  <Step title="Step 2: Implementation">
    Detailed instructions for step 2.

    ```python
    # Code example
    ```
  </Step>

  <Step title="Step 3: Testing">
    How to verify it works.

    ```python
    # Test code
    ```
  </Step>
</Steps>

## Complete Code

<CodeGroup>
```python Python
# Full working implementation
```

```javascript JavaScript
// Full working implementation
```
</CodeGroup>

## Next Steps

- Try [enhancement 1](/path/to/enhancement1)
- Explore [advanced feature](/path/to/advanced)
- Join our [community](https://community.mixpeek.com)
```

### API Endpoint Documentation Pattern

```mdx
---
title: "Endpoint Name"
description: "Brief description of what this endpoint does"
api: "POST /path/to/endpoint"
---

Brief 1-sentence description.

## Authentication

<Note>
  Requires authentication via Bearer token in `Authorization` header.
</Note>

## Request

### Headers

<ParamField header="X-Namespace" type="string" required>
  The namespace to operate in
</ParamField>

### Body Parameters

<ParamField body="name" type="string" required>
  Descriptive name for the resource
</ParamField>

<ParamField body="config" type="object">
  Optional configuration object

  <Expandable title="config properties">
    <ParamField body="config.option1" type="string">
      Description of option1
    </ParamField>

    <ParamField body="config.option2" type="number" default={10}>
      Description of option2
    </ParamField>
  </Expandable>
</ParamField>

## Response

<ResponseField name="id" type="string">
  Unique identifier for the created resource
</ResponseField>

<ResponseField name="created_at" type="string">
  ISO 8601 timestamp
</ResponseField>

## Example Request

<CodeGroup>
```python Python
from mixpeek import Mixpeek

client = Mixpeek(api_key="your-api-key")
response = client.endpoint.create(
    name="example",
    config={"option1": "value"}
)
```

```javascript JavaScript
import { Mixpeek } from 'mixpeek-sdk'

const client = new Mixpeek({ apiKey: 'your-api-key' })
const response = await client.endpoint.create({
  name: 'example',
  config: { option1: 'value' }
})
```

```bash cURL
curl -X POST https://api.mixpeek.com/endpoint \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "X-Namespace: your-namespace" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "example",
    "config": {
      "option1": "value"
    }
  }'
```
</CodeGroup>

## Example Response

```json
{
  "id": "res_1234567890",
  "name": "example",
  "config": {
    "option1": "value"
  },
  "created_at": "2024-01-15T10:30:00Z"
}
```

## Error Responses

<ResponseExample>
```json 400 Bad Request
{
  "error": "Invalid parameter",
  "message": "Name is required"
}
```

```json 401 Unauthorized
{
  "error": "Unauthorized",
  "message": "Invalid or missing API key"
}
```

```json 404 Not Found
{
  "error": "Not found",
  "message": "Resource not found"
}
```
</ResponseExample>
```

## Component Usage Patterns

### Callout Boxes

**Use cases:**
```mdx
<Note>
  General information or context
</Note>

<Info>
  Helpful tips or additional details
</Info>

<Tip>
  Pro tips or best practices
</Tip>

<Warning>
  Important warnings or cautionary notes
</Warning>

<Check>
  Confirmation or success indicators
</Check>
```

**Anti-patterns:**
```mdx
<!-- ❌ BAD - overusing callouts -->
<Note>
  This is important
</Note>

<Warning>
  Be careful here
</Warning>

<Tip>
  Try this approach
</Tip>

<!-- Every paragraph is in a box! Too much! -->

<!-- ✅ GOOD - use sparingly -->
Main content flows naturally with regular paragraphs.

<Warning>
  Critical warning only where truly needed
</Warning>

More regular content continues here.
```

### Code Examples

**Always use CodeGroup for multi-language:**
```mdx
<!-- ❌ BAD - single language only -->
```python
client.create_retriever(name="test")
```

<!-- ✅ GOOD - multiple languages -->
<CodeGroup>
```python Python
client.create_retriever(name="test")
```

```javascript JavaScript
await client.createRetriever({ name: "test" })
```

```bash cURL
curl -X POST https://api.mixpeek.com/retrievers
```
</CodeGroup>
```

**Use realistic examples:**
```mdx
<!-- ❌ BAD - generic placeholder data -->
```python
foo = client.create_thing(
    bar="baz",
    qux=123
)
```

<!-- ✅ GOOD - realistic, meaningful data -->
```python
product_search = client.create_retriever(
    name="ecommerce-product-search",
    stages=[
        {
            "type": "semantic_search",
            "config": {
                "query": "{{INPUT.user_query}}",
                "top_k": 20
            }
        }
    ]
)
```
```

**Include comments for clarity:**
```mdx
<CodeGroup>
```python Python
from mixpeek import Mixpeek

# Initialize the client with your API key
client = Mixpeek(api_key="your-api-key")

# Create a semantic search retriever
retriever = client.retrievers.create(
    name="product-search",
    stages=[
        {
            "type": "semantic_search",
            "config": {
                "query": "{{INPUT.query}}",  # Placeholder for user input
                "top_k": 20,                  # Number of results to return
                "threshold": 0.7              # Minimum similarity score
            }
        }
    ]
)

# Print the retriever ID
print(f"Created: {retriever.id}")
```
</CodeGroup>
```

### Images and Diagrams

**Always use Frame component:**
```mdx
<!-- ❌ BAD - raw img tag -->
![Architecture](/assets/architecture.svg)

<!-- ✅ GOOD - Frame with descriptive alt text -->
<Frame>
  <img src="/assets/architecture.svg" alt="Mixpeek architecture showing data flow from ingestion through processing to retrieval" />
</Frame>

<!-- ✅ BETTER - Frame with caption -->
<Frame caption="Mixpeek data processing pipeline">
  <img src="/assets/pipeline-diagram.svg" alt="Pipeline diagram" />
</Frame>
```

**Diagram best practices:**
```mdx
<!-- Include diagrams for: -->
- Architecture overviews
- Data flow diagrams
- Process workflows
- Complex configurations

<!-- Use SVG when possible for: -->
- Scalability
- File size
- Crispness at any resolution

<!-- Use PNG for: -->
- Screenshots
- Photos
- Complex images with many colors
```

### Parameter Documentation

**Complete parameter docs:**
```mdx
<ParamField path="config" type="object" required>
  Configuration object for the retriever stage

  <Expandable title="config properties">
    <ParamField path="config.query" type="string" required>
      The search query. Use `{{INPUT.query}}` to reference user input.

      **Example:** `"{{INPUT.user_search}}"`
    </ParamField>

    <ParamField path="config.top_k" type="integer" default={10}>
      Number of results to return. Must be between 1 and 100.

      **Default:** `10`
    </ParamField>

    <ParamField path="config.threshold" type="number">
      Minimum similarity score (0-1). Results below this score are filtered out.

      **Example:** `0.75`
    </ParamField>
  </Expandable>
</ParamField>
```

**Include all important details:**
- Type (string, number, object, array)
- Required vs optional
- Default values
- Valid ranges/formats
- Example values
- Related parameters

## Writing Style Guide

### Voice and Tone

**Use active voice:**
```mdx
❌ "A retriever can be created using the API"
✅ "Create a retriever using the API"

❌ "The query will be processed by the system"
✅ "Mixpeek processes your query"
```

**Use present tense:**
```mdx
❌ "The API will return a response"
✅ "The API returns a response"

❌ "You would call this endpoint"
✅ "Call this endpoint"
```

**Address the reader directly:**
```mdx
❌ "Users should configure their API key"
✅ "Configure your API key"

❌ "One can create a retriever by..."
✅ "You can create a retriever by..."
```

### Clarity and Conciseness

**Be direct:**
```mdx
❌ "It is possible to configure the system in such a way that..."
✅ "Configure the system to..."

❌ "In order to create a retriever, you need to..."
✅ "To create a retriever:"
```

**Avoid jargon:**
```mdx
❌ "Leverage the vectorized embeddings for optimal retrieval performance"
✅ "Use embeddings to improve search accuracy"

❌ "Utilize the proprietary algorithmic approach"
✅ "Use Mixpeek's search algorithm"
```

**Explain acronyms on first use:**
```mdx
✅ "Vector databases like Qdrant store embeddings (numerical representations of data) for fast similarity search."
```

### Technical Accuracy

**Be precise:**
```mdx
❌ "The API is really fast"
✅ "The API typically responds in under 100ms"

❌ "Supports lots of file formats"
✅ "Supports MP4, AVI, MOV, and MKV video formats"
```

**Provide context:**
```mdx
❌ "Set top_k to a good value"
✅ "Set top_k to 10-20 for most use cases. Higher values (50+) may impact performance."
```

## Navigation Patterns

### Organizing Content

**Logical grouping:**
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
      "group": "Core Features",
      "pages": [
        "ingestion/overview",
        "processing/overview",
        "retrieval/overview"
      ]
    }
  ]
}
```

**Progressive disclosure:**
```json
{
  "group": "Search & Retrieve",
  "pages": [
    "retrieval/retrievers",        // Start with overview
    "retrieval/quickstart",        // Then quickstart
    {
      "group": "Stages",           // Then dive into details
      "pages": [
        "retrieval/stages/overview",
        "retrieval/stages/semantic-search",
        "retrieval/stages/keyword-search"
      ]
    }
  ]
}
```

**Consistent structure:**
- Each major section has an overview page
- Concepts before implementation
- Simple before advanced
- Related features grouped together

## SEO Best Practices

### Meta Information

**Optimal title length:**
```yaml
---
# ❌ TOO LONG (68 characters)
title: "How to Create and Configure Semantic Search Retrievers with Mixpeek"

# ✅ GOOD (53 characters)
title: "Semantic Search Retrievers | Mixpeek Docs"
---
```

**Descriptive descriptions:**
```yaml
---
# ❌ BAD - generic
description: "Documentation for Mixpeek"

# ✅ GOOD - specific, under 160 chars
description: "Learn how to implement semantic search with Mixpeek retrievers using dense vector embeddings for meaning-based search."
---
```

### Internal Linking

**Link to related concepts:**
```mdx
Semantic search works by comparing [vector embeddings](/processing/extractors/multimodal)
generated from your data. For best results, use [reranking](/retrieval/stages/rerank)
to refine your results.

Learn more about [configuring retrievers](/retrieval/retrievers).
```

**Link context:**
```mdx
<!-- ❌ BAD - no context -->
Read more [here](/link).
Click [this](/link).

<!-- ✅ GOOD - descriptive link text -->
Learn more about [semantic search stages](/retrieval/stages/semantic-search).
See the [API reference for retrievers](/api-reference/retrievers).
```

## Version Control Patterns

### Commit Messages

**Standard format:**
```bash
# Feature docs
docs: add semantic search tutorial
docs: update retriever configuration examples

# Fixes
docs: fix broken link in quickstart
docs: correct parameter type in API reference

# Updates
docs: update embeddings documentation for v2
docs: revise best practices for caching

# Assets
docs: add architecture diagram for processing pipeline
docs: update screenshot for dashboard UI
```

### File Organization

**Keep related files together:**
```bash
retrieval/
├── retrievers.mdx              # Main concept
├── quickstart.mdx              # Getting started
├── configuration.mdx           # Configuration guide
└── stages/                     # Related subconcept
    ├── overview.mdx
    ├── semantic-search.mdx
    └── keyword-search.mdx
```

## Common Anti-Patterns

### ❌ DON'T: Duplicate Content

```mdx
<!-- ❌ BAD - repeating same info in multiple places -->
<!-- In retrievers.mdx -->
Retrievers use stages to process queries. Stages include semantic search...

<!-- In semantic-search.mdx -->
Retrievers use stages to process queries. Semantic search is a stage that...

<!-- ✅ GOOD - link to canonical source -->
<!-- In retrievers.mdx -->
Retrievers use [stages](/retrieval/stages) to process queries.

<!-- In semantic-search.mdx -->
Semantic search is a [retriever stage](/retrieval/stages) that finds results by meaning.
```

### ❌ DON'T: Wall of Text

```mdx
<!-- ❌ BAD - huge paragraph -->
Semantic search is a powerful retrieval method that uses vector embeddings to find results based on meaning rather than exact keyword matches. It works by first converting your query into a numerical vector representation using the same embedding model that was used to process your data during ingestion. Then it performs a similarity search in the vector database to find items with similar embeddings. This approach is particularly effective for natural language queries where users might phrase things differently than how the content is worded...

<!-- ✅ GOOD - broken into digestible sections -->
## What is Semantic Search?

Semantic search finds results based on meaning, not just keywords.

## How It Works

1. **Query embedding:** Your query is converted to a vector using the same model that processed your data
2. **Similarity search:** Mixpeek finds items with similar vectors
3. **Results:** Returns the most semantically similar items

## When to Use It

Semantic search excels when:
- Users phrase queries differently than your content
- You need to understand intent, not just keywords
- Exact matching isn't sufficient
```

### ❌ DON'T: Missing Prerequisites

```mdx
<!-- ❌ BAD - jumping straight to advanced concepts -->
# Building a Multi-Stage Retriever

Configure your retriever with reranking and filters:

```python
# Complex example with no setup
```

<!-- ✅ GOOD - establish prerequisites -->
# Building a Multi-Stage Retriever

Before you begin, make sure you have:
- [Created a namespace](/ingestion/namespaces)
- [Ingested data](/ingestion/collections)
- [Generated embeddings](/processing/extractors)

See our [quickstart guide](/overview/quickstart) if you're new to Mixpeek.
```

## Quality Checklist

Before publishing documentation:

- [ ] Frontmatter has title and description
- [ ] Code examples in Python, JavaScript, and cURL
- [ ] Code examples are tested and work
- [ ] Images/diagrams have descriptive alt text
- [ ] Internal links use correct relative paths
- [ ] No broken links (run `mintlify broken-links`)
- [ ] Consistent formatting and style
- [ ] Technical accuracy verified
- [ ] SEO-friendly title and description
- [ ] Page added to mint.json navigation
- [ ] Related pages linked
- [ ] Prerequisites clearly stated
- [ ] Callouts used sparingly and appropriately
- [ ] No duplicate content
- [ ] Spelling and grammar checked
