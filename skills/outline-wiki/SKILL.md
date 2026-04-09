---
description: When the user wants to search, create, manage, or migrate documents in an Outline wiki. Use when they mention Outline, need to access wiki content, create documentation, organize knowledge bases, or integrate Outline with other tools.
related: [custom-context, search-optimization, content-migration]
---

# Outline Wiki Skill

Integrates Outline Wiki with Claude (via Claude Code, claude.ai, or Claude API) and Paperclip AI agents. Enables reading, searching, creating, and managing documents using the Outline REST API.

**Works with:** Claude Code, Claude API, claude.ai, Paperclip AI, Cursor, Windsurf, and any agent supporting the Agent Skills spec.

## Setup

### Prerequisites
- Outline Wiki instance (cloud or self-hosted)
- Outline API token with appropriate permissions
- For Paperclip AI: Paperclip instance running the integration
- For Claude users: Access to Claude Code, claude.ai, or Claude API

### Generate an API Token

To authenticate with API, supply the API key as a header (Authorization: Bearer YOUR_API_KEY) or as part of the payload using token parameter. Header-based authentication is highly recommended to help prevent accidental exposure in logs.

To create an API token:

1. Log in to your Outline wiki
2. Navigate to **Settings > API**
3. Click **Create token** (optionally set expiration and endpoint restrictions)
4. Copy the generated token (not viewable again)

### Configuration

#### For Paperclip AI

Store credentials in environment variables or Paperclip's secrets management:

```bash
OUTLINE_BASE_URL=https://your-outline-instance.com
OUTLINE_API_TOKEN=your_generated_api_token_here
```

For self-hosted Outline, update `OUTLINE_BASE_URL` to your instance root (e.g., `https://wiki.internal.yourcompany.com`).

#### For Claude (Code / API / claude.ai)

**Option A: Environment Variables (recommended)**
```bash
export OUTLINE_BASE_URL=https://your-outline-instance.com
export OUTLINE_API_TOKEN=your_generated_api_token_here
```

**Option B: .env File**
Create `.env` in your project:
```
OUTLINE_BASE_URL=https://your-outline-instance.com
OUTLINE_API_TOKEN=your_generated_api_token_here
```

**Option C: Pass as Parameters**
Include credentials directly in function calls or Claude API requests.

## API Reference

All endpoints are `POST` requests and require Bearer token authentication:
```
Authorization: Bearer YOUR_API_TOKEN
Content-Type: application/json
```

### Documents

#### `documents.search`
Search documents by keyword or content. Essential for discovery.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `query` | string | Yes | Search terms or keyword. |
| `collectionId`| string | No | Filter by specific collection UUID. |
| `statusFilter`| string | No | `draft`, `archived`, or `published`. |
| `limit` | integer | No | Max results (default 15). |
| `offset` | integer | No | Pagination offset (default 0). |

**Returns**: Array of document summaries with relevance scores.

#### `documents.list`
List all documents, optionally filtered.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `collectionId`| string | No | Filter by specific collection. |
| `statusFilter`| string | No | `draft`, `archived`, or `published`. |
| `limit` | integer | No | Max results (default 25). |

**Returns**: Paginated list of document objects (partial content).

#### `documents.info`
Retrieve a single document's full content (Markdown).

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Document UUID or `urlId`. |

**Returns**: Full document object including `text` (Markdown).

#### `documents.create`
Create a new document.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `title` | string | Yes | Document title. |
| `text` | string | No | Initial Markdown content. |
| `collectionId`| string | Yes | Target collection UUID. |
| `parentDocumentId`| string | No | Nest under another document. |
| `icon` | string | No | Emoji (🎉) or [Outline Icon](https://github.com/outline/outline-icons) name. |

**Returns**: Successfully created document object.

#### `documents.update`
Update document content or metadata.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Document UUID. |
| `title` | string | No | New title. |
| `text` | string | No | New Markdown content. |
| `editMode` | string | No | `append`, `prepend`, or `replace` (default). |

**Returns**: Updated document object.

#### `documents.delete`
Delete a document or move to trash.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Document UUID. |
| `permanent` | boolean | No | `true` for permanent, `false` to archive (default). |

### Collections

#### `collections.list`
List all accessible collections. **Use this first to navigate a new workspace.**

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `limit` | integer | No | Max results (default 25). |

**Returns**: Array of collections with `id`, `name`, and `description`.

#### `collections.info`
Retrieve collection details.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Collection UUID. |

### Data Attributes (Structured Metadata)

Required for advanced Paperclip AI tracking. See [data-attributes.md](./references/data-attributes.md) for details.

#### `dataAttributes.list`
List all custom attributes defined in the workspace.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `limit` | integer | No | Default 50. |

#### `dataAttributes.create`
Define a new metadata field.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | Yes | Attribute name (e.g. "Status"). |
| `dataType` | string | Yes | `string`, `number`, `boolean`, or `list`. |
| `options` | array | No | For `list` type: `[{ "label": "X", "value": "x" }]`. |
| `pinned` | boolean | No | Show attribute prominently. |

#### `collections.create`
Create a new organization folder.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | Yes | Collection name. |
| `description`| string | No | Markdown description. |
| `icon` | string | No | Icon name or emoji. |

#### `comments.create`
Add a comment or reply to a document.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `documentId` | string | Yes | Target document UUID. |
| `text` | string | Yes | Markdown content. |

## Best Practices

### 🔍 Discovery Workflow (Start Here)
If you are interacting with a workspace for the first time or the structure is unknown:
1.  **List Collections**: Call `collections.list` to see available areas.
2.  **Inspect Attributes**: Call `dataAttributes.list` to understand the metadata schema.
3.  **Search for Index**: Search for "README" or "Index" to find orientation guides.

### Search First
Always call `documents.search` before creating new documents to avoid duplicates. Check existing collections for similar content.

### Establish Conventions
- Use consistent Markdown formatting across documents
- Define standard data attributes upfront (Status, Owner, Category, Last Updated)
- Create index or README documents to guide users through structure
- Document your naming conventions and hierarchy

### Organize Hierarchically
Use `parentDocumentId` to create nested document structures. This creates logical hierarchies without forcing rigid folder structures.

### Use Custom Attributes
Define data attributes to track metadata (Status: Draft/Published/Archived, Owner, Last Reviewed, Priority, etc.). This enables filtering, sorting, and consistency across your wiki.

### Collaborate Effectively
Use `comments.create` for feedback, reviews, and metadata notes without editing document content. This preserves document history and enables discussion.

### Pagination Matters
All list endpoints support `limit` and `offset`. Adjust limit based on your needs (default 25 often works, but reduce for large wikis, increase for batch operations).

## Common Patterns

### Set Up a New Wiki or Knowledge Base

1. Call `collections.create` with the wiki name and description
2. Define foundational data attributes using `dataAttributes.create` (Status, Owner, Category, etc.)
3. Create an index document explaining the structure and conventions
4. Establish and document naming conventions
5. Begin populating with content using `documents.create`

### Search & Retrieve Content

1. Call `documents.search` with relevant keywords
2. Call `documents.info` on top results to get full content
3. Summarize, extract sections, or synthesize findings
4. Reference or link related documents

### Create Structured Documentation

1. Call `documents.create` in target collection with title
2. Write Markdown content following established conventions
3. Optionally call `comments.create` for metadata or review notes
4. Use data attributes to track Status, Owner, Last Reviewed, etc.
5. Link related documents via internal links or parentDocumentId

### Maintain Knowledge Bases

1. Use `documents.search` to find existing content
2. Update docs with `documents.update` when information changes
3. Use custom data attributes to track Status (Draft/Published/Archived), Owner, Last Updated
4. Pin important attributes and frequently-referenced documents
5. Create index pages with internal links to related content

### Migrate Documentation

1. Call `collections.list` to inventory all collections
2. Call `documents.list` within each collection
3. Call `documents.info` to retrieve full content and metadata
4. Transform data for target system
5. Use `documents.create` to rebuild structure in new locations

## Troubleshooting

**403 Forbidden**
- Verify API token is valid and not expired (check Settings > API)
- Confirm token has permission for the endpoint
- For self-hosted: ensure Outline API is enabled in config

**404 Not Found**
- Double-check IDs are correct (copy from URL or API response)
- Verify resource exists and hasn't been deleted
- Use `documents.search` or `collections.list` to confirm availability

**Rate Limits**
- Outline does not enforce strict API rate limits by default
- For self-hosted instances, check instance rate-limiting config
- Batch operations where possible to reduce request volume

**Duplicate Documents**
- Always call `documents.search` before `documents.create`
- Check existing collections for similar content
- Leverage `documents.update` for revisions instead of creating new docs

## Related Skills

- **[custom-context]** — Define workspace context (collections, attributes, conventions) once and reuse
- **[search-optimization]** — Improve search results quality and indexing
- **[content-migration]** — Migrate wikis to/from other platforms

## References

See detailed documentation:

- **[api-methods.md](./references/api-methods.md)** — Complete API specification with examples
- **[data-attributes.md](./references/data-attributes.md)** — Data type definitions and examples
- **[workspace-setup.md](./references/workspace-setup.md)** — Setup templates and conventions
- **[integration-examples.md](./references/integration-examples.md)** — Integration patterns with other tools

## Installation

### Option 1: CLI Install (Recommended)

```bash
# Install this skill
npx skills add KhairulA/outline-wiki-skill

# Or with specific skill
npx skills add KhairulA/outline-wiki-skill --skill outline-wiki
```

### Option 2: Manual Clone

```bash
git clone https://github.com/KhairulA/outline-wiki-skill.git
cp -r outline-wiki-skill/skills/* .agents/skills/
```

### Option 3: Git Submodule

```bash
git submodule add https://github.com/KhairulA/outline-wiki-skill.git .agents/outline-wiki
```

### Option 4: Claude Code Plugin

```
/plugin marketplace add KhairulA/outline-wiki-skill
/plugin install outline-wiki
```

---

**Version:** 1.0  
**Last Updated:** April 2026  
**Compatible with:** Claude (claude.ai, Claude Code, Claude API), Paperclip AI, Cursor, Windsurf, and Agent Skills spec  
**License:** MIT  
**Author:** [KhairulA](https://github.com/KhairulA)
