# Outline Ops Skill

Integrates Outline Ops with Claude (via Claude Code, claude.ai, or Claude API) and Paperclip AI agents. Enables reading, searching, creating, and managing documents using the Outline REST API.

**Works with:** Claude Code, Claude API, claude.ai, Paperclip AI, Cursor, Windsurf, and any agent supporting the Agent Skills spec.

## Quick Start

### Option 1: CLI Install (Single Skill)

```bash
# Install only this specific skill from the EngOps suite
npx skills add KhairulA/eng-ops-skills/skills/outline-ops
```

### Option 2: Full Suite (Recommended for EngOps)

If you want the full suite including the shared PII filters and audit loggers:

```bash
npx skills add KhairulA/eng-ops-skills
```


## Setup

### Generate an Outline API Token

1. Log in to your Outline wiki
2. Navigate to **Settings > API**
3. Click **Create token** (optionally set expiration and endpoint restrictions)
4. Copy the token (not viewable again)

### Configure Credentials

**For Paperclip AI:**
```bash
OUTLINE_BASE_URL=https://your-outline-instance.com
OUTLINE_API_TOKEN=your_generated_api_token_here
```

**For Claude (Code / API / claude.ai):**
```bash
export OUTLINE_BASE_URL=https://your-outline-instance.com
export OUTLINE_API_TOKEN=your_generated_api_token_here
```

Or create a `.env` file:
```
OUTLINE_BASE_URL=https://your-outline-instance.com
OUTLINE_API_TOKEN=your_generated_api_token_here
```

## Usage

Once installed, just ask your agent to help with wiki tasks:

```
"Search my wiki for information about onboarding"
→ Uses documents.search

"Create a new document about our API"
→ Uses documents.create

"Organize these docs into collections"
→ Uses collections.create and documents.update

"Find all drafts and mark them as published"
→ Uses documents.search, documents.update, dataAttributes
```

You can also invoke the skill directly:

```
/outline-ops
```

## What This Skill Does

- **Search** documents by keyword or content
- **Create** new documents and collections
- **Update** and organize existing documentation
- **Manage** custom data attributes (Status, Owner, Category, etc.)
- **Collaborate** via comments and feedback threads
- **Migrate** wikis to/from other platforms
- **Integrate** Outline with other tools and workflows

## Common Workflows

### Search & Retrieve Documentation

```
1. Call documents.search with keywords
2. Call documents.info to get full content
3. Summarize or extract key sections
```

### Create Structured Documentation

```
1. Call documents.create in target collection
2. Write Markdown content
3. Use dataAttributes to track Status, Owner, etc.
4. Link related documents
```

### Maintain a Knowledge Base

```
1. Use documents.search to find existing content
2. Update with documents.update when info changes
3. Track Status (Draft/Published/Archived)
4. Pin important documents and attributes
5. Create index pages with internal links
```

### Migrate Documentation

```
1. Call collections.list to inventory all collections
2. Call documents.list to find all documents
3. Call documents.info to retrieve full content
4. Transform and restructure as needed
5. Use documents.create to rebuild in new location
```

## API Reference

All endpoints require Bearer token authentication:

```
Authorization: Bearer YOUR_API_TOKEN
Content-Type: application/json
```

### Documents

- `documents.search(query, limit, offset)` — Search documents by keyword
- `documents.list(collectionId, limit, offset)` — List documents in collection
- `documents.info(id)` — Retrieve full document content
- `documents.create(collectionId, title, text, parentDocumentId)` — Create document
- `documents.update(id, title, text)` — Update document
- `documents.delete(id, permanent)` — Delete or archive document

### Collections

- `collections.list(limit, offset)` — List all collections
- `collections.info(id)` — Get collection details
- `collections.create(name, description, icon)` — Create collection

### Comments

- `comments.create(documentId, data, text)` — Add comment to document

### Data Attributes

- `dataAttributes.list(limit, offset, sort, direction)` — List custom attributes
- `dataAttributes.create(name, dataType, description, options, pinned)` — Create attribute
- `dataAttributes.update(id, name, description, options, pinned)` — Update attribute
- `dataAttributes.delete(id)` — Delete attribute

For complete API documentation, see [skills/outline-ops/references/api-methods.md](./skills/outline-ops/references/api-methods.md).

## Best Practices

1. **Search first** — Always call `documents.search` before creating new documents
2. **Establish conventions** — Define standard data attributes upfront
3. **Use hierarchies** — Organize documents with `parentDocumentId`
4. **Track metadata** — Use custom attributes for Status, Owner, Category, etc.
5. **Collaborate via comments** — Use comments for feedback without editing document content
6. **Paginate efficiently** — Adjust `limit` based on your needs

## Documentation

- **[SKILL.md](./skills/outline-ops/SKILL.md)** — Main skill definition
- **[API Methods](./skills/outline-ops/references/api-methods.md)** — Complete API specification
- **[Data Attributes](./skills/outline-ops/references/data-attributes.md)** — Attribute type definitions
- **[Workspace Setup](./skills/outline-ops/references/workspace-setup.md)** — Setup templates and conventions
- **[Integration Examples](./skills/outline-ops/references/integration-examples.md)** — Examples with n8n, Paperclip, etc.
- **[CLAUDE.md](./CLAUDE.md)** — Claude Code-specific patterns
- **[AGENTS.md](./AGENTS.md)** — Paperclip AI-specific patterns

## Contributing

Found a way to improve this skill? Have a new pattern or integration example to add? PRs and issues welcome!

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## Installation Methods Supported

✅ npx skills (CLI)  
✅ Claude Code plugin marketplace  
✅ Manual clone  
✅ Git submodule  
✅ Fork and customize  
✅ SkillKit (multi-agent install)

## Compatibility

| Platform | Support |
| --- | --- |
| Claude Code | ✅ Full |
| claude.ai | ✅ Full |
| Claude API | ✅ Full |
| Paperclip AI | ✅ Full |
| Cursor | ✅ Full |
| Windsurf | ✅ Full |
| Codex / Copilot | ✅ Partial |

## License

MIT — Use this however you want. See [LICENSE](./LICENSE).

## Related Projects

- [Outline Ops](https://github.com/outline/outline) — Open source wiki & knowledge base
- [Agent Skills Spec](https://agentskills.io) — Standard for AI agent skills

## Support

- 📖 [Official Outline Docs](https://docs.getoutline.com)
- 💬 [GitHub Issues](https://github.com/KhairulA/outline-ops-skill/issues)
- 🤝 [Discussions](https://github.com/KhairulA/outline-ops-skill/discussions)

---

**Version:** 1.0  
**Last Updated:** April 2026  
**Author:** [KhairulA](https://github.com/KhairulA)  
**License:** MIT
