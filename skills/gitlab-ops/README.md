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

---

For detailed API definitions, see **[SKILL.md](./SKILL.md)**.
