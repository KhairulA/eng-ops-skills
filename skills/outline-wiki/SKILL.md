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

All endpoints require Bearer token authentication:
```
Authorization: Bearer YOUR_API_TOKEN
Content-Type: application/json
```

### Documents

#### `documents.search`
Search documents by keyword or content.

**Parameters:**
- `query` (string, required): Search terms
- `limit` (integer, optional): Max results, default 15
- `offset` (integer, optional): Pagination offset, default 0

**Returns:** Array of documents with matching content, ranked by relevance.

#### `documents.list`
List all documents, optionally filtered by collection.

**Parameters:**
- `collectionId` (string, optional): Filter by specific collection
- `limit` (integer, optional): Max results, default 25
- `offset` (integer, optional): Pagination offset

**Returns:** Paginated list of documents with metadata.

#### `documents.info`
Retrieve a single document's full content.

**Parameters:**
- `id` (string, required): Document ID

**Returns:** Document object with full Markdown content, metadata, and collaborators.

#### `documents.create`
Create a new document in a collection.

**Parameters:**
- `collectionId` (string, required): Target collection ID
- `title` (string, required): Document title
- `text` (string, optional): Initial Markdown content
- `parentDocumentId` (string, optional): Nest under another document

**Returns:** Created document object with generated ID.

#### `documents.update`
Update document content or metadata.

**Parameters:**
- `id` (string, required): Document ID
- `title` (string, optional): New title
- `text` (string, optional): New Markdown content

**Returns:** Updated document object.

#### `documents.delete`
Delete a document (or archive it).

**Parameters:**
- `id` (string, required): Document ID
- `permanent` (boolean, optional): Permanent deletion, default false (archive)

**Returns:** Success confirmation.

### Collections

#### `collections.list`
List all collections in the workspace.

**Parameters:**
- `limit` (integer, optional): Max results, default 25
- `offset` (integer, optional): Pagination offset

**Returns:** Array of collection objects with metadata.

#### `collections.info`
Retrieve collection details.

**Parameters:**
- `id` (string, required): Collection ID

**Returns:** Collection object with description, icon, documents count, and membership.

#### `collections.create`
Create a new collection.

**Parameters:**
- `name` (string, required): Collection name
- `description` (string, optional): Collection description
- `icon` (string, optional): Emoji icon for collection

**Returns:** Created collection object with ID.

### Comments

#### `comments.create`
Add a comment to a document for collaboration and feedback.

**Parameters:**
- `documentId` (string, required): Target document ID
- `data` (object, optional): ProseMirror JSON format (for rich formatting)
- `text` (string, optional): Plain text comment (simpler alternative)

**Returns:** Created comment object with ID and timestamp.

### Data Attributes

#### `dataAttributes.list`
List all custom data attributes in the workspace.

**Parameters:**
- `limit` (integer, optional): Max results, default 50
- `offset` (integer, optional): Pagination offset
- `sort` (string, optional): Sort field (name, createdAt, etc.)
- `direction` (string, optional): 'asc' or 'desc'

**Returns:** Array of attribute objects.

#### `dataAttributes.create`
Define a new custom data attribute for structured metadata.

**Parameters:**
- `name` (string, required): Attribute name
- `dataType` (string, required): Data type (text, select, date, number, checkbox, etc.)
- `description` (string, optional): Attribute description
- `options` (array, optional): Predefined options for select types
- `pinned` (boolean, optional): Pin for visibility, default false

**Returns:** Created attribute object with ID.

#### `dataAttributes.update`
Update a custom data attribute.

**Parameters:**
- `id` (string, required): Attribute ID
- `name` (string, required): Updated name
- `description` (string, optional): Updated description
- `options` (array, optional): Updated options
- `pinned` (boolean, optional): Pin status

**Returns:** Updated attribute object.

#### `dataAttributes.delete`
Remove a custom data attribute.

**Parameters:**
- `id` (string, required): Attribute ID

**Returns:** Success confirmation.

## Best Practices

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
