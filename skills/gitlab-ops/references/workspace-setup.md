# GitLab Workspace Setup for Agents

Optimize your GitLab Projects for autonomous and assisted agents.

## 1. Project Namespacing
- Use clear Group/Project hierarchies (e.g., `infrastructure/aws-scripts`).
- Agents work best with Project IDs or full paths (`namespace/project`).

## 2. Protected Marks & MR Approvals
- Enable **Merge Request Approvals** (Premium/Ultimate).
- Require at least 1 approval for any MR merging into a protected branch.
- Prevent Force Pushes.

## 3. Scoped Labels
Use GitLab's unique **Scoped Labels** (`key::value`) for agent state:
- `eng-ops::audit-passed`
- `eng-ops::stale`
- `eng-ops::needs-human`

## 4. Environment Variables
Agents require a **Personal Access Token (PAT)** or **Project Access Token** with `api` and `read_repository` scopes. For GitLab Ultimate, use **Group Access Tokens** to manage multiple projects at once.

---

*Foundations for GitLab Code Governance.*
