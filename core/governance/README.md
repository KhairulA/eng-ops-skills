# Human-in-the-Loop (HITL) Governance

In the enterprise, AI agents must not be allowed to perform destructive or high-impact actions without explicit human approval. This horizontal layer defines the governance guardrails for the EngOps Suite.

## The Approval Threshold

We categorize actions by "Risk Level". Any action in the **High Risk** category should trigger a `requestApproval` call in platforms like Paperclip or a "Confirm before proceeding" prompt in CLI tools.

| Risk Level | Action Type | Example | Requirement |
| :--- | :--- | :--- | :--- |
| **High** | Deletion | `documents.delete`, `repo.delete` | Mandatory Human Approval |
| **High** | Permission Change | `dataAttributes.delete`, `repo.update_protection` | Mandatory Human Approval |
| **Medium** | Mass Update | More than 10 documents or tickets at once | "Safety Check" Prompt |
| **Low** | Creation | `documents.create`, `issues.comment` | Autonomous or "Log and Proceed" |
| **Low** | Retrieval | `search`, `list`, `info` | Fully Autonomous |

## Integration Patterns

### 1. Paperclip `requestApproval`
Skills should be configured to use Paperclip's built-in governance gate:

```javascript
if (action === 'delete') {
  const approved = await paperclip.requestApproval({
    title: "Document Deletion Request",
    description: `Agent ${agentId} wants to delete document ${docId}.`,
    role: "Admin"
  });
  if (!approved) return "Action cancelled by user.";
}
```

### 2. The "Dry Run" Horizontal
Before every mass update, agents are encouraged to output a "Dry Run Summary" to the console/chat and wait for a "Go" signal.

## Policy-as-Code
For advanced enterprises, governance rules can be mirrored in GitHub Codeowners or Jira Workflow transition permissions, ensuring that even if the agent tries to call the API, the tool provider blocks it.

---

*Because trust is built on guardrails.*
