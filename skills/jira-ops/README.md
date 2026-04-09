# Jira EngOps Skill

An Enterprise-focused Jira integration designed for **Paperclip AI** agents to handle "Hygiene and Alignment" rather than just simple ticket creation.

## Capabilities

- **Ticket Hygiene**: Automatically find and flag (or close) stale Jira tickets.
- **Project Alignment**: Sync Jira task status with project documentation (e.g., in Outline).
- **Sprint Summarization**: Generate high-level status updates based on Jira activity.
- **Metadata Management**: Update custom fields and record external links (Wiki, PRs).

## Setup

### 1. Generate an Atlassian API Token
1. Go to [Atlassian API Tokens](https://id.atlassian.com/manage-profile/security/api-tokens).
2. Click **Create API token**.
3. Label it (e.g., "EngOps Agent") and copy the token.

### 2. Configure Credentials

Add these to your environment or `.env` file:

```bash
JIRA_INSTANCE_URL=https://your-domain.atlassian.net
JIRA_USER_EMAIL=your-email@company.com
JIRA_API_TOKEN=your_token_here
```

## Installation for Paperclip AI

This skill is best installed as part of the **EngOps Suite** to maintain horizontal integration.

### Method A: The Suite Submodule (Recommended)
Add the entire suite and symlink this skill:

```bash
git submodule add https://github.com/KhairulA/eng-ops-skills.git .agents/eng-ops
ln -s eng-ops/skills/jira-ops .agents/jira-ops
```

### Method B: Single Skill Install
```bash
git submodule add https://github.com/KhairulA/eng-ops-skills.git .agents/jira-ops
```

## Common Workflows

### The "Hygiene" Sweep
> "Search project PROJ for all tickets in 'In Progress' that haven't been updated in 2 weeks. For each, add a comment asking for an update and link to the project's Outline roadmap."

### The "Status Sync"
> "Check the status of PROJ-456. If it's closed, find the corresponding document in Outline and update the 'Status' attribute to 'Published'."

## EngOps Horizontal Integration

This skill is built to the **EngOps Standard** and is fully compatible with our horizontal core:
- **[PII Guard](../../core/security)**: Auto-redacts secrets and PII before processing.
- **[Audit Logging](../../core/logging)**: All write-actions generate a standard JSON audit trail.
- **[Governance](../../core/governance)**: Supports human-in-the-loop approval gates.

---

For detailed API definitions, see **[SKILL.md](./SKILL.md)**.

