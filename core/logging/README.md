# Standardized Audit Logging

The EngOps Suite requires a unified audit trail to ensure accountability and traceability in the Engineering Operations pipeline.

## Log Format (JSON)

Every change-action (create, update, delete) should produce a log entry in this format:

```json
{
  "timestamp": "ISO8601",
  "skill": "vertical-name (e.g., outline-wiki)",
  "action": "action-name (e.g., documents.create)",
  "agent_id": "optional-id",
  "resource_id": "uuid-or-key",
  "metadata": {
    "title": "Document/Ticket Title",
    "reason": "Why the agent took this action"
  }
}
```

## Storage Strategy

1.  **Local Append**: Write to `.agents/logs/eng-ops.audit.log`.
2.  **Centralized**: If configured, post log summaries to a specific "Ops Audit" Slack channel or Datadog/Splunk via an HTTP endpoint.

## Guidelines for Skills

- **Quiet by Default**: Read-only actions (search, list) should NOT be logged unless debugging.
- **Rich Context**: The `metadata.reason` field is the most important part of the log. It should explain the "Alignment Logic" (e.g., "Updating Outline because Jira status changed to Done").

---

*Accountability for the Agentic Era.*
