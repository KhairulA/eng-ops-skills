# EngOps Playbooks

Playbooks are "Strategic Recipes" for AI agents. While **Skills** describe *what* an agent can do with a tool, **Playbooks** describe *how* to orchestrate multiple tools to solve a complex engineering problem.

## What is a Playbook?

A playbook is a multi-step workflow that usually crosses the verticals of the EngOps Matrix:
- **Code Signal**: Merge Request or Pull Request (GitHub/GitLab).
- **State Change**: Task transition or comment (Jira/GitLab Issues).
- **Knowledge Sync**: Documentation update or publishing (Outline Ops/Confluence).

## Featured Playbooks

| Playbook | Verticals Involved | Goal |
| :--- | :--- | :--- |
| [**EngOps Triad**](./eng-ops-triad.md) | Code, Task, Knowledge | 100% sync from Merge to Documentation. |
| [**Jira-Outline Alignment**](./jira-outline-alignment.md) | Task, Knowledge | Ensure documentation reflects ticket status. |
| [**Closed-Loop Engine**](./automation-engine.md) | All | A conceptual code implementation of the Triad. |

## Creating New Playbooks

We encourage contributors to add playbooks for every new high-frequency workflow (e.g., "Onboarding Audit," "Security Remediation Trace," etc.).

---

*Moving from standalone skills to symphonic operations.*
