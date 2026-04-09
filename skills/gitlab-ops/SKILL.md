---
description: When the user wants to audit GitLab Merge Requests (MRs), manage issues, check project hygiene, or sync code activity with Jira and Outline. Use when GitLab, MRs, projects, or GitLab reviews are mentioned.
related: [jira-ops, outline-ops]
---

# GitLab EngOps Skill

Integrates GitLab with AI agents to automate code operations and governance. This skill focuses on Merge Request (MR) hygiene, review auditing, and namespace/project management.

## Setup

### Prerequisites
- GitLab Personal Access Token (PAT).
- Scopes: `api`, `read_repository`.

### Configuration

Set the following environment variables:

```bash
GITLAB_URL=https://gitlab.com (or your instance URL)
GITLAB_TOKEN=your_token_here
```

## API Reference

### Merge Requests

#### `mrs.list_pending`
Find open MRs that need attention or have been stale.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `project_id`| string | Yes | The PID or namespaced path (e.g. `org/repo`). |
| `state` | string | No | `opened` (default), `merged`, `closed`. |

#### `mrs.audit_approvals`
Check if an MR meets the configured approval rules (e.g. at least 1 approval).

#### `mrs.comment`
Post a comment on a Merge Request. Use this to link task keys or documentation.

### Issues (ExecutionOps)

#### `issues.search`
Find issues within a project or group. Useful for status auditing.
- **Project PID**: Required.
- **Labels**: Optional filter (e.g. `eng-ops:done`).

#### `issues.update`
Change the status, labels, or milestone of an issue.

#### `issues.comment`
Add internal notes or status updates to an issue.

### Project Hygiene


#### `project.audit_files`
Checks for standard files like `README.md` and `LICENSE` in the repository root.

## Best Practices

### 1. Identify the Jira Link
Like GitHub, agents should search for Jira keys in MR titles or descriptions.

### 2. CI/CD Pipeline Context
GitLab is heavily integrated with its own CI. This skill can be used to query pipeline status: `GET /projects/:id/merge_requests/:mr_id/pipelines`.

### 3. Automated Documentation
When an MR is merged, extract the "Changelog" label or MR description to update your Outline Ops.

## Related Skills
- **[jira-ops](../jira-ops/SKILL.md)**: Link Merge Requests to Jira issues.
- **[outline-ops](../outline-ops/SKILL.md)**: Sync MR summaries to technical docs.

---

**Version:** 0.1 (Experimental)  
**Author:** [KhairulA](https://github.com/KhairulA)
