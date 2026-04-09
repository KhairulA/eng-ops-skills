---
name: hitl-governance
description: High-trust governance framework for Human-in-the-Loop (HITL) approval gates. Use this skill to evaluate risk levels and enforce approval requirements before executing high-impact or destructive actions.
metadata:
  author: KhairulA
  version: 1.0.0
license: MIT
---

# HITL Governance Skill

Defines the decision logic for when an AI agent must pause for human intervention. This skill ensures that autonomous agents operate within enterprise safety guardrails.

## Risk Assessment Logic

Before taking any action, evaluate the **Risk Level**:

| Risk Level | Action Category | Requirement |
| :--- | :--- | :--- |
| **High** | Deletion, Permission Changes, Configuration Overwrites | **Mandatory** explicit human approval. |
| **Medium** | Mass Updates (>10 items), Resource Renaming | "Safety Check" prompt with summary of changes. |
| **Low** | Creation, Commenting, Tagging | Autonomous with background logging. |
| **Zero** | Search, List, Read, Info | Fully autonomous. |

## Implementation Patterns

### 1. Requesting Approval
When a High-Risk action is identified:
- **Paperclip**: Use `paperclip.requestApproval()`.
- **CLI**: Output a "Pending Approval" summary and wait for `[y/n]` input.

### 2. Dry Run Summary
For Medium-Risk actions, always provide a **Dry Run Summary** before execution:
- "I am about to update 15 Jira tickets with the status 'Closed'. Do you wish to proceed?"

### 3. Escalation
If the agent encounters a blocked state due to a rejected approval, it should log the rejection reason and mark the task as `BLOCKED`.

---

**Horizontal Core:** EngOps Governance Pillar
