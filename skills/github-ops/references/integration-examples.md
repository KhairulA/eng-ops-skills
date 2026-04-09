# GitHub Integration Examples

Practical workflows for your GitHub EngOps agent.

## 1. Automated Review Chasing
Finds PRs with requested changes that have been updated by the author, but not re-reviewed by the original reviewer.

```javascript
const github = new GitHubClient();
const prs = await github.listPRs('my-org/core-api');

for (const pr of prs) {
  const reviews = await github.getReviews(pr.number);
  const requestedChanges = reviews.filter(r => r.state === 'CHANGES_REQUESTED');
  
  if (requestedChanges.length > 0 && pr.updated_at > requestedChanges[0].submitted_at) {
    await github.comment(pr.number, `@${requestedChanges[0].user.login}, the author has updated this PR. Please re-review!`);
  }
}
```

## 2. Release Note Generation
Extracts merged PR titles since the last release and formats them for the Outline Wiki.

```javascript
const merges = await github.getMergedPRsSince('v1.2.0');
const releaseNotes = merges.map(m => `- ${m.title} (#${m.number}) by @${m.user.login}`).join('\n');

// Push to Outline
await outline.createDocument(releaseCollectionId, 'Release Notes v1.3.0', releaseNotes);
```

---

*Part of the GitHub EngOps Vertical.*
