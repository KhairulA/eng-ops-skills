# PII & Secret Filter (Core Horizontal)

This core module provides strategies for agents to filter sensitive data (PII) and secrets (API Keys) before transmitting data to an LLM or an external service.

## Why this is a Core Horizontal
Every Enterprise skill (Outline, Jira, GitHub) deals with sensitive corporate data. By centralizing the filtering logic here, we ensure consistent data protection across the entire EngOps suite.

## Filtering Strategy

1.  **Regex Identification**: Scanning for patterns like `sk-...`, `Bearer ...`, or Email/Phone patterns.
2.  **Entity Recognition**: Identifying names, organizations, and addresses.
3.  **Redaction vs Masking**:
    -   *Redaction*: Completely removing the data (e.g., `[REDACTED]`).
    -   *Masking*: Replacing with a placeholder (e.g., `[USER_EMAIL]`).

## Shared Utility Concept

Skills can import this logic:

```javascript
// Pseudo-code for a skill action
import { filterPII } from '../../core/security/pii-filter';

async function createDocument(content) {
  const safeContent = filterPII(content);
  return await outline.documents.create({ text: safeContent });
}
```

## Policy Settings
You can define the "Strictness" of the horizontal layer in your environment:

- `ENGOPS_FILTER_STRICTNESS=high` (Mask all names, emails, and entities)
- `ENGOPS_FILTER_STRICTNESS=medium` (Mask only secrets and emails)
- `ENGOPS_FILTER_STRICTNESS=off` (No filtering - use for internal-only proxies)

---

*This is a foundational component of the EngOps Agent Skills suite.*
