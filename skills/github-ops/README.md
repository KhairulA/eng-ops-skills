# GitHub EngOps Skill

High-fidelity GitHub integration for AI agents. Focused on **Governance, Hygiene, and Cross-Tool Alignment**.

## Capabilities

- **PR Triage**: Identify stagnant Pull Requests and notify authors.
- **Review Auditing**: Ensure PRs meet your organization's compliance and approval standards.
- **Source-to-Task Linking**: Extract Jira keys from PRs to maintain the EngOps Triad.
- **Repo Auditing**: Verify that repositories contain standard documentation and security files.

## Setup

### 1. Create a GitHub Token
1. Go to **Settings > Developer settings > Personal access tokens**.
2. Select **Tokens (classic)** and click **Generate new token**.
3. Select `repo` scopes.
4. Copy the token.

### 2. Configure Credentials

Add these to your environment or `.env` file:

```bash
GITHUB_TOKEN=your_generated_token_here
GITHUB_OWNER=your-org-name
```

## Installation

### As part of the EngOps Suite (Recommended)

```bash
npx skills add KhairulA/eng-ops-skills
```

### Standalone Installation

```bash
npx skills add KhairulA/eng-ops-skills/skills/github-ops
```

## Common Workflows

### The "Stale PR" Cleanup
> "Identify all PRs in the 'web-app' repo that haven't been touched in 3 days. Post a comment asking if the author needs help and link to the 'PR Process' doc in Outline."

### The "Triad Audit" (GitHub + Jira)
> "Check PR #88. Extract the Jira key from the description, then use jira-ops to check if that ticket is in 'In Progress'. If it is 'Done', ask the developer why the PR is still open."

---

For detailed API definitions, see **[SKILL.md](./SKILL.md)**.
