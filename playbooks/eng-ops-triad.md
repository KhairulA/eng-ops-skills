# Playbook: The EngOps Triad (Wiki + Jira + GitHub)

This playbook describes the "Closed Loop" workflow that ensures **Information**, **Tasks**, and **Code** are perfectly aligned.

## The Triad Workflow

### 1. The Code Signal (GitHub or GitLab)
The agent monitors for a **Merged PR or MR**.
- **Action**: `github-ops` or `gitlab-ops` detects a merge in the primary repository.
- **Extraction**: The agent parses the PR/MR description for a Jira key (e.g., `PROJ-99`).


### 2. The Task Update (Jira)
The agent transitions the task based on the code change.
- **Action**: `jira-ops` updates `PROJ-99` to `Done`.
- **Annotation**: The agent adds a comment to Jira: *"Automatically closed via PR #123. See merge commit: [Link]"*

### 3. The Knowledge Sync (Outline)
The agent updates the documentation to reflect reality.
- **Action**: `outline-wiki` searches for the API documentation related to the changes in PR #123.
- **Update**: The agent appends the new API changes to the "API Reference" document in Outline.
- **Status**: The documentation page is moved from `Draft` to `Published`.

---

## Example Agent Request
To automate this, prompt your agent:

> "You are an EngOps Architect. Whenever a PR is merged in the 'platform-core' repository:
> 1. Use `github-ops` to read the PR summary.
> 2. Use `jira-ops` to find the linked task and mark it as 'Done'.
> 3. Use `outline-wiki` to find our 'Deployment Log' document and add a new entry with the PR title, author, and Jira key.
> 4. Ensure you use the `pii-guard` logic if you find any environment variables in the PR description."

---

*This is the gold standard for automated Engineering Operations.*
