# Policy-as-Code (EngOps Core)

This horizontal layer allows enterprises to define **Machine-Readable Rules** that AI agents must validate before taking any action. This moves governance from "Instructions" to "Assertions."

## How it Works

An EngOps agent loads policy files from this directory and runs an **Internal Audit** before calling any tool API.

## Example Policy: `jira-link-required.json`

This policy ensures that no PR is merged or Wiki doc is published without a corresponding Jira ticket reference.

```json
{
  "policy_id": "PR_JIRA_LINK_REQ",
  "name": "Mandatory Jira Linking",
  "vertical": "github-ops",
  "trigger": "prs.push",
  "assertions": [
    {
      "target": "pr.description",
      "regex": "[A-Z]{2,10}-[0-9]+",
      "error_message": "Action Blocked: Pull Request must contain a Jira Issue Key (e.g., PROJ-123)."
    }
  ]
}
```

## Running the Policy Engine

When using the suite, the agent should perform a check like this:

```javascript
import { validatePolicy } from 'core/governance/policy-engine';

const prData = { description: "Added new login feature." };
const report = validatePolicy('PR_JIRA_LINK_REQ', prData);

if (!report.valid) {
  throw new Error(report.error_message);
}
```

## Policy Library

- **`outline-attribution.json`**: All Wiki docs must have an `Owner` data attribute.
- **`stale-pr-threshold.json`**: Flag any PR unupdated for more than 48 hours as `eng-ops:stale`.

---

*Moving from Human-in-the-loop to Policy-as-Code.*
