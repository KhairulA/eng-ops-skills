# GitHub Workspace Setup for Agents

Ensure your GitHub organization is "Agent-Ready" with these settings.

## 1. Protected Branches
Agents should **never** be allowed to push directly to `main` without a PR.
- Enable **Branch Protection Rules** for your default branch.
- Require at least **1 Approval** (which can be the Human following the agent's PR).

## 2. Standard Labels
The `github-ops` skill uses labels to prioritize triage. We recommend:
- `eng-ops:needs-review`: For PRs the agent identifies as stale or complex.
- `eng-ops:synced`: For PRs that have been successfully mapped to Jira and Outline.
- `pii-redacted`: To flag that an agent has scrubbed the PR description.

## 3. GitHub Apps vs PATs
- **GitHub App (Recommended)**: Offers better rate limits and finer permission control via granular "Repository Permissions."
- **PAT (Fine-grained)**: Use if you are running the agent locally.

## 4. CODEOWNERS
Maintain a `CODEOWNERS` file. This allows the `github-ops` agent to identify exactly who to "chase" when a PR remains unreviewed.

---

*Foundations for Code Governance.*
