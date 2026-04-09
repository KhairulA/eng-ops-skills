# GitLab API Methods & MR Auditing

Detailed reference for the `gitlab-ops` vertical, focusing on Merge Request (MR) auditing and project-level hygiene.

## Key API Endpoints

### 1. Merge Requests
- **List MRs**: `GET /projects/:id/merge_requests`
- **Audit MR Approvals**: `GET /projects/:id/merge_requests/:mr_id/approvals`
- **MR Comments**: `POST /projects/:id/merge_requests/:mr_id/notes`

### 2. Issues (ExecutionOps)
- **List Issues**: `GET /projects/:id/issues`
- **Update Issue**: `PUT /projects/:id/issues/:issue_id` (Add labels, change state).

### 3. CI/CD Pipelines
- **List Pipelines**: `GET /projects/:id/pipelines` (Filter by MR).

## MR Auditing Logic

When an agent "Audits an MR," it should verify these criteria:

1.  **Approval Rules**: Use the `/approvals` endpoint to check `approvals_left == 0`.
2.  **Assignees**: Ensure the MR has at least one active assignee.
3.  **CI Success**: Check the pipeline status for the `SHA` of the head commit.
4.  **Issue Link**: Verify the MR description contains a link or reference to a GitLab Issue or Jira ticket.

---

*Part of the GitLab EngOps Vertical.*
