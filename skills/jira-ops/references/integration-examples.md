# Jira Integration Examples

Real-world patterns for integrating Jira into your EngOps workflows.

## 1. Automated Sprint Hygiene
This pattern finds tickets that are "In Progress" but have no assignee or haven't been updated in 5 days.

```javascript
const jira = new JiraClient();
const staleIssues = await jira.search('project = "PROJ" AND status = "In Progress" AND (assignee IS EMPTY OR updated < -5d)');

staleIssues.forEach(issue => {
  jira.addComment(issue.key, "⚠️ This ticket appears to be stale. Please update the status or assign a collaborator.");
});
```

## 2. Linear-to-Jira Sync
If you use Linear for development but Jira for enterprise reporting.

```javascript
// Pseudo-code for sync
const linearTicket = await linear.getIssue('ABC-123');
const jiraTicket = await jira.search(`"Linear Link" ~ "${linearTicket.url}"`);

if (jiraTicket.status !== linearTicket.status) {
  await jira.transition(jiraTicket.key, linearTicket.status);
}
```

---

*Part of the Jira EngOps Vertical.*
