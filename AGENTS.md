# Building EngOps Agents with Paperclip

EngOps agents are specialized Paperclip agents designed to reduce the "Management Tax" on engineering teams. They handle documentation, ticket hygiene, and compliance auditing.

## The EngOps Agent Persona

When configuring your Paperclip agent, define its role around "Operational Excellence":

```json
{
  "name": "EngOps Architect",
  "role": "Operational Alignment",
  "description": "Ensures that our knowledge base, tasks, and code remain in sync and compliant.",
  "skills": [
    "outline-wiki",
    "jira-ops",
    "pii-guard"
  ]
}
```

## Cross-Skill Workflows

The power of this repo lies in combining skills to solve high-friction problems.

### Workflow: The Sync Audit
**Goal:** Ensure technical documentation reflects current project reality.

1.  **Step 1:** Use `jira-ops` to list all tasks completed this week.
2.  **Step 2:** Use `outline-wiki` to find the "Release Notes" or "Project Update" document.
3.  **Step 3:** Agent compares the two and appends missing features to the document.

### Workflow: The Security Gate
**Goal:** Prevent sensitive information from entering public documentation.

1.  **Step 1:** Agent drafts a document from a Slack conversation.
2.  **Step 2:** Agent runs the text through the `pii-guard` horizontal skill.
3.  **Step 3:** If clean, agent calls `outline-wiki.documents.create`.

## Enterprise Controls

### Standardized Audit Trails
All EngOps skills are designed to produce an audit log. Configure your agent to write these logs to a persistent location:

```bash
# Example agent instruction
"Whenever you perform a write action, record the metadata (timestamp, user, document_id) in the /audits/eng-ops.log file."
```

### Shared Multi-Skill Setup
To use multiple skills in one Paperclip project:

```bash
git submodule add https://github.com/KhairulA/eng-ops-skills.git .agents/eng-ops
```

In your task definitions, you can now reference skills from different verticals:

```javascript
// Complex Task
{
  "task": "Align our Roadmap with Jira",
  "steps": [
    "search linear for 'Q3 Roadmap'",
    "search outline for 'Strategy 2026'",
    "propose edits to outline doc"
  ]
}
```

## Best Practices
1.  **Least Privilege**: Give agents specific API tokens for specific collections.
2.  **Human-in-the-Loop**: Use Paperclip's `requestApproval` feature for any `delete` or `update` actions on core documentation.
3.  **Governance First**: Always include the `pii-guard` skill if the agent processes external data (e.g., meeting transcripts).

---

For specific skill documentation, see:
- [Outline Wiki Skill](./skills/outline-wiki)
- [Governance Patterns](./core/security)
