# GitLab Integration Examples

Practical automation patterns for your GitLab EngOps agent.

## 1. Automated MR Chasing
Finds MRs that are ready to merge (PII check passed, CI passed, approved) but still open.

```javascript
const gitlab = new GitLabClient();
const openMRs = await gitlab.getOpenMRs('my-org/core-api');

for (const mr of openMRs) {
    const approvals = await gitlab.getMRApprovals(mr.iid);
    if (approvals.approvals_left === 0) {
        await gitlab.addMRComment(mr.iid, "🤖 This MR is fully approved and CI has passed. Merging now...");
        await gitlab.mergeMR(mr.iid);
    }
}
```

## 2. Issue-to-Wiki Document
Generates a "Feature Spec" in Outline Ops whenever a GitLab issue is labeled `eng-ops:draft-spec`.

```javascript
const issue = await gitlab.getIssue(project_id, issue_id);
const specContent = `# Spec for ${issue.title}\n\n${issue.description}`;

// Use outline-ops to create the doc
await outline.createDocument(specCollectionId, issue.title, specContent);
```

---

*Part of the GitLab EngOps Vertical.*
