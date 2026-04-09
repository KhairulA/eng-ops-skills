# GitHub API Methods & Auditing Patterns

Detailed reference for the `github-ops` vertical, focusing on Pull Request (PR) auditing and repository metadata.

## Key API Endpoints

### 1. Pull Requests
- **List PRs**: `GET /repos/{owner}/{repo}/pulls`
- **Audit PR Reviews**: `GET /repos/{owner}/{repo}/pulls/{pull_number}/reviews`
- **PR Comments**: `POST /repos/{owner}/{repo}/issues/{pull_number}/comments` (GitHub uses the 'issue' endpoint for PR comments).

### 2. Repository Metadata
- **Read Content**: `GET /repos/{owner}/{repo}/contents/{path}` (Use this to check for `LICENSE` or `README`).
- **List Branches**: `GET /repos/{owner}/{repo}/branches`.

## PR Auditing Logic

When an agent "Audits a PR," it should check these criteria:

1.  **Approval Count**: Is `approvals >= 1`?
2.  **Reviewer Coverage**: Is there at least one reviewer from the "Core Maintainers" team?
3.  **CI/CD Status**: Check `GET /repos/{owner}/{repo}/commits/{ref}/status` to ensure builds passed.
4.  **Linked Issues**: Search the PR description for tickets in the `jira-ops` vertical.

## Rate Limits

Be aware that GitHub Cloud has a primary rate limit (typically 5,000 requests per hour for PATs). Agents should cache results where possible and avoid looping over hundreds of repos in a single run.

---

*Part of the GitHub EngOps Vertical.*
