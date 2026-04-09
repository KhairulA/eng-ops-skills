---
description: When the user wants to manage Jira issues, search for task status, audit stale tickets, or sync engineering tasks with external documentation. Use when Jira, tickets, issues, sprints, or task status are mentioned.
related: [outline-wiki, sync-auditor]
---

# Jira EngOps Skill

Integrates Jira with AI agents to automate the "Management Tax" of engineering task tracking. This skill focuses on high-fidelity task management, status auditing, and cross-tool alignment.

## Setup

### Prerequisites
- Jira Cloud or Data Center instance.
- API Token (for Cloud) or Personal Access Token (for Data Center).
- Appropriate permissions to read/write issues in the target projects.

### Configuration

Set the following environment variables:

```bash
JIRA_INSTANCE_URL=https://your-company.atlassian.net
JIRA_USER_EMAIL=you@example.com
JIRA_API_TOKEN=your_token_here
```

## API Reference

### Issues

#### `issues.search`
Search for issues using JQL (Jira Query Language) or simple keywords.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `jql` | string | Yes | The JQL query (e.g., `project = PROJ AND status = "To Do"`). |
| `maxResults` | integer | No | Maximum issues to return (default 50). |
| `fields` | array | No | Specific fields to retrieve (e.g., `summary`, `status`, `description`). |

#### `issues.info`
Retrieve full details for a specific issue.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `issueIdOrKey` | string | Yes | The issue key (e.g., `PROJ-123`). |

#### `issues.update`
Update status, summary, or fields of an issue. Use this for hygiene (e.g., moving stale tickets to 'Closed').

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `issueIdOrKey` | string | Yes | The issue key (e.g., `PROJ-123`). |
| `update` | object | Yes | The Jira update object (e.g., `{"fields": {"status": {"name": "Done"}}}`). |

#### `issues.comment`
Add a comment to an issue. Useful for agents to record their actions or link to related Wiki documents.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `issueIdOrKey` | string | Yes | The issue key (e.g., `PROJ-123`). |
| `body` | string | Yes | The comment text in Markdown or Jira format. |

### Auditing & Hygiene

#### `hygiene.find_stale`
Custom logic to find tickets that haven't been touched in X days.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `days` | integer | Yes | Number of days since last update. |
| `project` | string | No | Filter by project key. |

## Best Practices

### 1. The "Read-Only" Audit First
Before updating any tickets, always run a search to understand the project landscape.
```
"Find all tickets in the PROJ-A project that are 'In Progress' but haven't been updated in 7 days."
```

### 2. Document the Link
Whenever an agent updates a Jira ticket based on information found in a Wiki (Outline), it **must** add a comment with the source URL.
```
"I've updated this ticket status to 'Done' based on the release notes found here: [Link to Outline]"
```

### 3. JQL Safety
Encourage the agent to use simple JQL. Highly complex queries should be double-checked or generated iteratively.

## Related Skills
- **[outline-wiki](../outline-wiki/SKILL.md)**: Use together to sync task status with documentation.
- **[pii-filter](../../core/security/README.md)**: Filter ticket descriptions before processing if they contain sensitive system logs.

---

**Version:** 0.1 (Experimental)  
**Author:** [KhairulA](https://github.com/KhairulA)
