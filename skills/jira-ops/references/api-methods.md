# Jira API Methods & JQL Examples

This document provides a deep dive into the Jira API used by the `jira-ops` skill, specifically focusing on advanced querying and status auditing.

## Common JQL (Jira Query Language) Patterns

EngOps agents should use these patterns to identify hygiene issues.

### 1. Stale Tickets
Finds tickets in "In Progress" that haven't been touched in 7 days.
```jql
project = "PROJ" AND status = "In Progress" AND updated < -7d
```

### 2. High Priority Debt
Finds "Critical" or "Highest" priority tickets that are still open.
```jql
project = "PROJ" AND priority IN (Highest, Critical) AND resolution = Unresolved
```

### 3. Missing Done Date
Finds tickets closed without a resolution (bad hygiene).
```jql
status = Done AND resolution IS EMPTY
```

## API Methods

### `issues.search`
- **Method**: `GET /rest/api/3/search`
- **Recommended Fields**: `summary, status, assignee, updated, resolution, labels`.

### `issues.update` (Transitions)
To change a status, you must use the `/transitions` endpoint.
- **Workflow**: 
  1. Call `GET /rest/api/3/issue/{id}/transitions`.
  2. Find the ID of the target status (e.g., "Done").
  3. Call `POST /rest/api/3/issue/{id}/transitions` with that ID.

---

*Part of the Jira EngOps Vertical.*
