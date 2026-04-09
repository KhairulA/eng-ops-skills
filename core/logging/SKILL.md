---
name: audit-logging
description: Standardized JSON audit logging for agent actions. Use this skill to record the "Who, What, When, and Why" of every mutation command to ensure enterprise accountability.
metadata:
  author: KhairulA
  version: 1.0.0
license: MIT
---

# Audit Logging Skill

Ensures all mutations within the EngOps suite produce a traceable, searchable audit trail. 

## Log Entry Requirements

Every mutation (create, update, delete) must generate a JSON log entry with the following context:

- **skill**: Identifier of the vertical (e.g., `outline-ops`).
- **action**: The specific API call or function executed.
- **resource_id**: The unique key of the modified item.
- **metadata.reason**: A concise string explaining the logic behind the action (e.g., "Closing Jira ticket because the Outline tech spec was archived").

## Logging Strategy

1.  **Immutability**: Logs should be append-only.
2.  **Privacy**: Ensure [pii-guard](../security/SKILL.md) filters are applied to log metadata before writing.
3.  **Frequency**: Log every mutation. Read actions do not require logging.

## Example Payload

```json
{
  "timestamp": "2026-04-09T12:00:00Z",
  "skill": "jira-ops",
  "action": "issues.update",
  "resource_id": "OPS-123",
  "metadata": {
    "reason": "Aligning status with merged PR #45."
  }
}
```

---

**Horizontal Core:** EngOps Logging Pillar
