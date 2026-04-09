# Jira Workspace Setup for Agents

To get the most out of the `jira-ops` skill, your Jira project should follow these "Agent-Friendly" setup patterns.

## 1. Project Naming & Keys
- Use descriptive project names and unique, predictable 3-4 letter keys (e.g., `CORE`, `API`).

## 2. Custom Fields for Alignment
We recommend adding these custom fields to your Jira issues to support cross-tool syncing:
- **`Outline Link`** (URL field): To link directly to the wiki documentation.
- **`GitHub PR`** (URL or Text field): To track the code change.
- **`Agent Status`** (Select field): `Synced`, `Out of Date`, `Needs Review`.

## 3. Workflow States
Agents work best with clear, non-ambiguous status names:
- `To Do` / `Backlog`
- `In Progress`
- `Under Review` (Critical for `github-ops` alignment)
- `Done` / `Closed`

## 4. User Account for Agent
Always create a **Service Account** for your AI agents (e.g., `ai-bot@company.com`) rather than using a personal account. This ensures that the history of changes (e.g., "Updated by ai-bot") is clearly visible in the audit trail.

---

*Optimizing Jira for the Agentic ERA.*
