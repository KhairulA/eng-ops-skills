# GitLab EngOps Skill

High-fidelity GitLab integration for AI agents. Focused on **Merge Request (MR) Governance and Hygiene**.

## Capabilities

- **MR Triage**: Find stagnant Merge Requests and notify owners.
- **Approval Auditing**: Ensure MRs meet internal compliance standards.
- **CI/CD Integration**: Monitor pipeline status associated with merge requests.
- **Triad Linking**: Connect GitLab MRs to Jira tasks and Outline documentation.

## Setup

### 1. Create a GitLab Token
1. Go to your **Profile Settings > Access Tokens**.
2. Create a token with the `api` and `read_repository` scopes.
3. Copy the token.

### 2. Configure Credentials

Add these to your environment or `.env` file:

```bash
GITLAB_URL=https://gitlab.your-company.com
GITLAB_TOKEN=your_token_here
```

## Installation

### As part of the EngOps Suite (Recommended)

```bash
npx skills add KhairulA/eng-ops-skills
```

### Standalone Installation

```bash
npx skills add KhairulA/eng-ops-skills/skills/gitlab-ops
```

## Common Workflows

### The "Stale MR" Follow-up
> "Find all opened MRs in the 'api-gateway' project that haven't had a comment in 2 days. Ping the reviewers and link to the 'Review Policy' in Outline."

### The "Cross-Platform" Triad
> "Check the status of GitLab MR #202. If it is merged, use jira-ops to close the linked ticket and update the 'API Reference' doc in Outline."

## EngOps Horizontal Integration

This skill is built to the **EngOps Standard** and is fully compatible with our horizontal core:
- **[PII Guard](../../core/security)**: Auto-redacts secrets and PII before processing.
- **[Audit Logging](../../core/logging)**: All write-actions generate a standard JSON audit trail.
- **[Governance](../../core/governance)**: Supports human-in-the-loop approval gates.

---


For detailed API definitions, see **[SKILL.md](./SKILL.md)**.
