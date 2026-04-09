# Claude Code: EngOps Patterns

This document details advanced patterns for using the **EngOps Agent Skills** suite specifically within Claude Code.

## Multi-Skill Shell Integration

Claude Code excels at orchestrating multiple tools via the shell. You can use the `!`command`` syntax in your project-specific `SKILL.md` to inject real-time context from all three verticals.

### The "Triad Context" Injector
```markdown
# Current EngOps Context

- **Jira Status**: !`jira-ops issues search "project = CORE AND status = 'In Progress'"`
- **Recent PRs**: !`github-ops prs list-pending --repo backend-api`
- **Wiki Index**: !`outline-ops collections list --limit 5`
```

## Interactive EngOps Workflows

Claude Code can execute complex JS scripts that span across verticals.

### Example: The "Daily Alignment" Script
This script (which Claude can generate and run) checks if any 'Done' Jira tickets are missing Wiki updates.

```javascript
// alignment-audit.js
const { execSync } = require('child_process');

// 1. Get Done items from Jira
const jiraDone = JSON.parse(execSync('npx skills run jira-ops issues.search "status = Done"'));

// 2. Cross-reference with Outline
jiraDone.issues.forEach(issue => {
  const wikiMatch = execSync(`npx skills run outline-ops documents.search "${issue.key}"`);
  if (!wikiMatch.includes(issue.key)) {
    console.log(`⚠️ ALIGNMENT GAP: ${issue.key} is Done in Jira but missing from Outline.`);
  }
});
```

## Secure Command Execution

When using Claude Code, always leverage the `core/security` PII guard instructions in your shell prompts:

> "Claude, run a sweep of the last 10 GH commits. Before showing me the diffs, apply the `core/security/pii-guard.md` rules to redact any hardcoded tokens you find."

## Helpful Claude Code Aliases

Add these to your `.clauderc` or local shell alias:

```bash
# Rapid Hygiene Check
alias eng-audit="npx skills run jira-ops hygiene.find_stale --days 7"

# Rapid PR Review
alias pr-audit="npx skills run github-ops prs.audit_reviews --repo platform"
```

---

*Maximizing efficiency in the Claude Code terminal.*
