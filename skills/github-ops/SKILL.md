---
description: When the user wants to audit PRs, manage GitHub issues, check repository hygiene, or sync code activity with Jira and Outline. Use when GitHub, pull requests, repos, or PR reviews are mentioned.
related: [jira-ops, outline-ops]
---

# GitHub EngOps Skill

Integrates GitHub with AI agents to automate the "Source of Truth" in the code vertical. This skill focuses on Pull Request (PR) hygiene, review auditing, and repository governance.

## Setup

### Prerequisites
- GitHub Personal Access Token (PAT) or GitHub App credentials.
- `repo` scope (for private repos) or `public_repo` scope.

### Configuration

Set the following environment variables:

```bash
GITHUB_TOKEN=your_token_here
GITHUB_OWNER=your-org-or-username
```

## API Reference

### Pull Requests

#### `prs.list_pending`
Find PRs that are open and need attention (e.g., stale or unreviewed).

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `repo` | string | Yes | The repository name. |
| `state` | string | No | `open` (default) or `closed`. |
| `stale_days`| integer | No | Filter PRs unupdated for X days. |

#### `prs.audit_reviews`
Check the review status of a PR. Ensures it meets "Governance" standards (e.g., at least 1 approval, no blocked status).

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `repo` | string | Yes | The repository name. |
| `pull_number`| integer | Yes | The PR number. |

#### `prs.comment`
Add an automated comment to a PR. Use this to link Jira tickets or Wiki docs.

### Repository Governance

#### `repo.audit_hygiene`
Checks for the presence of mission-critical files (`README.md`, `LICENSE`, `.gitignore`) and branch protection rules.

#### `repo.list_branches`
Check for stale branches that haven't been merged or touched.

## Best Practices

### 1. Identify the Jira Link
Every PR should ideally reference a Jira key in the title or description (e.g., `[PROJ-123]`). This skill is programmed to extract these keys for use with `jira-ops`.

### 2. Review Hygiene
Agents should look for "Reviewer Fatigue."
```
"Check PR #45. It has been open for 4 days with 3 requested changes but no new activity. Ping the author."
```

### 3. Automated Release Notes
When a PR is merged, use this skill to extract the PR summary and feed it to the `outline-ops` skill to draft release notes.

## Related Skills
- **[jira-ops](../jira-ops/SKILL.md)**: Link PRs to development tasks.
- **[outline-ops](../outline-ops/SKILL.md)**: Generate documentation from merged code.

---

**Version:** 0.1 (Experimental)  
**Author:** [KhairulA](https://github.com/KhairulA)
