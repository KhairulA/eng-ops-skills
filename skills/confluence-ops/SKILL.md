---
description: When the user wants to manage documentation in Confluence. Use when Confluence, pages, spaces, or Atlassian documentation is mentioned.
related: [jira-ops, outline-ops]
---

# Confluence EngOps Skill (DRAFT)

Integrates Confluence with AI agents for enterprise documentation management.

## Setup

### Prerequisites
- Atlassian API Token.
- Confluence Cloud Instance URL.

## API Reference (Planned)

### Pages
- **`pages.search`**: Find pages across spaces using CQL (Confluence Query Language).
- **`pages.create`**: Create a new page under a specific parent or space.
- **`pages.update`**: Edit page content (ADF or Storage format).

### Spaces
- **`spaces.list`**: Filter by space category or key.

## Implementation Pattern
This skill follows the same interface as `outline-ops`, allowing you to swap knowledge providers with minimal agent re-instruction.

---

**Status:** 🏗️ Planned / Draft  
**Author:** [KhairulA](https://github.com/KhairulA)
