# Playbook: Documentation Alignment (Jira + Outline)

This playbook describes how to use the EngOps Agent Skills suite to ensure your technical documentation stays in sync with your actual project execution in Jira.

## The Problem
Development happens in Jira, but documentation lives in Outline. Information becomes stale the moment a ticket is closed but the corresponding Wiki page isn't updated.

## The Agent Workflow

### Step 1: Inventory Recently Completed Work
The agent searches Jira for tickets completed in the last 7 days.
```
"Use jira-ops to find all tickets in project PROJ that moved to 'Done' this week."
```

### Step 2: Identify Corresponding Documentation
For each completed ticket, the agent searches Outline for mentions of the feature or ticket key.
```
"Use outline-ops to search for documents related to 'Feature X' or 'PROJ-123'."
```

### Step 3: Propose or Apply Updates
The agent reads the document and compares it to the "Resolution" or "Comments" in the Jira ticket. If they conflict or the doc is missing info, the agent updates the doc.
```
"Update the Outline document 'API Specs' with the changes described in PROJ-123."
```

### Step 4: Close the Loop
The agent adds a comment to the Jira ticket linking to the updated documentation.
```
"Add a comment to Jira PROJ-123: 'Documentation updated in Outline: [Link]'"
```

## Configured Agent Prompt
To run this automatically, give your Paperclip agent these instructions:

> "You are an EngOps Architect. Every Friday, your task is to audit our JIRA project 'CORE' against our Outline Ops collection 'Project Roadmaps'. 
> 1. Find all 'Done' tickets from the week.
> 2. Ensure their corresponding docs in Outline are updated.
> 3. Use the `pii-filter` from our core skills if you extract log data from Jira comments.
> 4. Summarize your actions in our `#eng-ops-audit` Slack channel."

---

*Part of the EngOps Agent Skills Suite.*
