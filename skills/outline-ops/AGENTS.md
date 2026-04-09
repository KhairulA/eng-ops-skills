# Paperclip AI Integration

This document covers Paperclip AI-specific patterns and best practices for using the Outline Ops Skill with Paperclip agents.

## Overview

Outline Ops Skill integrates seamlessly with Paperclip AI agents as a core knowledge management tool. Agents can:
- Search company wikis and knowledge bases
- Create and update documentation automatically
- Organize information with custom attributes
- Collaborate via comments and feedback
- Export and migrate documentation

## Setup in Paperclip

### 1. Add Skill to Paperclip Configuration

In your Paperclip `.agents/` directory:

```bash
git submodule add https://github.com/KhairulA/outline-ops-skill.git .agents/outline-ops-skill
```

### 2. Configure Environment Variables

In your Paperclip `.env` or secrets management:

```bash
OUTLINE_BASE_URL=https://your-outline-instance.com
OUTLINE_API_TOKEN=your_generated_api_token_here
```

### 3. Reference in Agent Configuration

In your agent's configuration (e.g., `agents/researcher.json`):

```json
{
  "name": "Researcher",
  "role": "Research and Documentation",
  "description": "Searches wiki, creates research summaries, organizes findings",
  "model": "claude-opus-4-6",
  "skills": [
    "outline-ops",
    "web-search",
    "analytics"
  ],
  "budget": {
    "monthly": "$100",
    "tokens": 1000000
  }
}
```

## Common Paperclip Workflows

### Workflow 1: Daily Report from Wiki Data

Agent goal: Compile daily status reports from wiki updates.

```javascript
// In Paperclip heartbeat task
async function generateDailyReport() {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  // Search for recent updates
  const docs = await client.searchDocuments('status update', 50);
  
  // Create report document
  const report = docs.data
    .filter(d => isToday(d.document.updatedAt))
    .map(d => `- ${d.document.title}: ${d.context}`)
    .join('\n');

  await client.createDocument(
    'daily-reports-collection-id',
    `Daily Report - ${new Date().toLocaleDateString()}`,
    `# Daily Status\n\n${report}`
  );
}
```

### Workflow 2: Auto-Categorize and Tag Documents

Agent goal: Keep wiki organized by automatically categorizing new documents.

```javascript
async function categorizeNewDocuments() {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  // List recent uncategorized documents
  const docs = await client.listDocuments(null, 50);
  
  for (const doc of docs.data) {
    if (!doc.category) {
      // Use Claude to infer category from title and content
      const inference = await inferCategory(doc.title);
      
      // Update document with category attribute
      await client.updateDocument(doc.id, {
        attributes: { category: inference }
      });
    }
  }
}
```

### Workflow 3: Wiki-Based Agent Memory

Use Outline as persistent agent memory/context.

```javascript
async function loadAgentContext() {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  // Load agent's context document
  const contextDoc = await client.getDocument('agent-context-doc-id');
  
  // Parse and use as system context
  return {
    goals: parseSection(contextDoc.text, '# Goals'),
    constraints: parseSection(contextDoc.text, '# Constraints'),
    recentDecisions: parseSection(contextDoc.text, '# Recent Decisions'),
  };
}

// Use in agent system prompt
const agentContext = await loadAgentContext();
const systemPrompt = `
You are an agent working toward these goals:
${agentContext.goals}

Constraints:
${agentContext.constraints}

Recent decisions made:
${agentContext.recentDecisions}
`;
```

### Workflow 4: Document Audit Trail

Create audit records of all document changes.

```javascript
async function logDocumentChange(docId, changeType, details) {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  // Append to audit trail collection
  const auditEntry = {
    timestamp: new Date().toISOString(),
    documentId: docId,
    changeType: changeType,
    details: details,
    agentId: process.env.AGENT_ID,
  };

  // Create a comment (immutable record)
  await client.createComment(docId, JSON.stringify(auditEntry, null, 2));
}
```

### Workflow 5: Wiki Sync with External Systems

Sync Outline with other tools (Slack, email, databases).

```javascript
async function syncWikiToSlack() {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  // Find documents marked "publish to slack"
  const docs = await client.searchDocuments('slack');
  
  for (const doc of docs.data) {
    if (doc.attributes?.publishToSlack) {
      // Format and send to Slack
      await slackClient.postMessage('#announcements', {
        text: `📖 *${doc.document.title}*`,
        blocks: formatAsSlackBlocks(doc),
      });
      
      // Mark as published
      await client.updateDocument(doc.id, {
        attributes: { publishedToSlack: true }
      });
    }
  }
}
```

## Integration with Paperclip Features

### Goal Alignment

Link Outline documents to Paperclip goals:

```javascript
// In Paperclip task definition
{
  "title": "Update project documentation",
  "goal": "Keep knowledge base current and accurate",
  "task": {
    "type": "outline-ops",
    "action": "update-docs",
    "searchQuery": "project-name",
    "attributes": {
      "lastReviewedBy": "agent-name",
      "reviewStatus": "approved"
    }
  }
}
```

### Budget Tracking

Each wiki operation costs tokens. Monitor in Paperclip:

```javascript
// Log API usage for Paperclip cost tracking
async function callOutlineWithLogging(method, endpoint, data) {
  const startTime = Date.now();
  const result = await makeRequest(method, endpoint, data);
  const duration = Date.now() - startTime;
  
  logUsage({
    agent: process.env.AGENT_ID,
    action: `outline.${endpoint}`,
    duration: duration,
    tokens: estimateTokens(JSON.stringify(data) + JSON.stringify(result)),
  });
  
  return result;
}
```

### Heartbeat Integration

Outline operations work well with Paperclip heartbeats:

```json
{
  "agent": "Documentation Manager",
  "heartbeat": {
    "schedule": "0 */6 * * *",
    "tasks": [
      {
        "title": "Review and organize wiki",
        "skill": "outline-ops",
        "actions": [
          "list_collections",
          "search_uncategorized",
          "apply_tags_and_attributes"
        ]
      }
    ],
    "budget": 50000
  }
}
```

### Governance & Oversight

Paperclip's governance layer works with wiki operations:

```javascript
// Require board approval for major wiki changes
if (changeType === 'delete') {
  const approval = await paperclip.requestApproval({
    title: `Delete document: ${docTitle}`,
    description: `Request approval to delete "${docTitle}". This cannot be undone.`,
    requiredRole: 'board',
    documentLink: `https://outline.yourcompany.com/doc/${docId}`,
  });
  
  if (!approval.approved) {
    throw new Error('Document deletion requires board approval');
  }
}
```

## Data Attributes for Paperclip

Recommended custom attributes for Paperclip integration:

```javascript
const recommendedAttributes = [
  {
    name: 'Status',
    dataType: 'select',
    options: ['Draft', 'In Review', 'Published', 'Archived'],
    pinned: true,
  },
  {
    name: 'Owner',
    dataType: 'text',
    description: 'Agent or team responsible for maintaining this doc',
    pinned: true,
  },
  {
    name: 'Last Updated',
    dataType: 'date',
    pinned: true,
  },
  {
    name: 'Relevant Goals',
    dataType: 'select',
    description: 'Which Paperclip goals does this doc support?',
  },
  {
    name: 'Access Level',
    dataType: 'select',
    options: ['Public', 'Team', 'Board', 'Private'],
  },
  {
    name: 'Review Frequency',
    dataType: 'select',
    options: ['Weekly', 'Monthly', 'Quarterly', 'Annually'],
  },
];
```

## Monitoring & Alerts

Set up Paperclip monitoring for wiki health:

```javascript
async function monitorWikiHealth() {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  const collections = await client.listCollections();
  
  for (const col of collections.data) {
    const docs = await client.listDocuments(col.id, 100);
    
    // Find stale documents
    const stale = docs.data.filter(d => {
      const daysOld = daysSince(d.updatedAt);
      return daysOld > 90; // More than 90 days old
    });
    
    if (stale.length > 0) {
      await paperclip.notifyBoard({
        title: `Stale documents in ${col.name}`,
        description: `${stale.length} documents haven't been updated in 90+ days`,
        severity: 'warning',
        documents: stale.map(d => d.title),
      });
    }
  }
}
```

## Best Practices for Paperclip

1. **Use consistent data attributes** — Makes filtering and automation easier
2. **Document agent decisions** — Create comments explaining why docs were changed
3. **Track ownership** — Use Owner attribute to assign accountability
4. **Regular reviews** — Set Review Frequency attribute and monitor stale docs
5. **Audit trails** — Use comments for immutable change records
6. **Sync with goals** — Link wiki organization to Paperclip company goals
7. **Monitor costs** — Track API usage against agent budgets
8. **Governance** — Use Paperclip's approval gates for major changes

## Troubleshooting in Paperclip

### Agent Can't Find Documents

Check:
- API token is valid and in Paperclip secrets
- `OUTLINE_BASE_URL` is correct (no trailing slash usually)
- Search query is specific enough
- Collection IDs are correct

### Rate Limiting

Paperclip agents hitting rate limits:
- Reduce batch sizes (use `limit: 10` instead of `limit: 50`)
- Add delays between requests
- Cache frequently-accessed data

### Token Budget Issues

If wiki operations consume too many tokens:
- Batch related operations together
- Cache search results
- Use pagination to fetch only needed data
- Consider moving large exports to background tasks

---

For general skill usage, see [SKILL.md](./skills/outline-ops/SKILL.md). For Claude Code patterns, see [CLAUDE.md](./CLAUDE.md).
