# Claude Code Specific Patterns

This document contains Claude Code-only patterns and advanced features not available in other agents.

## Auto-Inject Outline Context

Claude Code supports embedding shell commands in SKILL.md using `!`command`` syntax. When the skill is invoked, Claude Code runs the command and injects the output inline.

Use this to auto-inject your Outline context configuration:

```markdown
# Outline Wiki Skill

Outline context: !`cat .agents/outline-context.md 2>/dev/null || echo "No Outline context file found — ask the user about their Outline instance before proceeding."`
```

This makes context available immediately without any file-reading step.

## Claude Code Shell Integration

When using Claude Code, you can execute shell commands directly to:
- Test API connectivity
- Generate API tokens
- Validate JSON payloads
- Fetch real-time data from your Outline instance

Example Claude Code snippet:

```javascript
const { execSync } = require('child_process');

// Test Outline connection
const result = execSync(`
  curl -s -X POST "${process.env.OUTLINE_BASE_URL}/api/documents.list" \\
    -H "Authorization: Bearer ${process.env.OUTLINE_API_TOKEN}" \\
    -H "Content-Type: application/json" \\
    -d '{"limit": 1}'
`, { encoding: 'utf-8' });

console.log(JSON.parse(result));
```

## Creating an Outline API Client

Claude Code can generate a reusable API client module:

```javascript
// outline-api-client.js
const https = require('https');

class OutlineClient {
  constructor(baseUrl, apiToken) {
    this.baseUrl = baseUrl;
    this.apiToken = apiToken;
  }

  async request(method, endpoint, data = {}) {
    const url = new URL(`${this.baseUrl}/api/${endpoint}`);
    
    const options = {
      method,
      headers: {
        'Authorization': `Bearer ${this.apiToken}`,
        'Content-Type': 'application/json',
      },
    };

    return new Promise((resolve, reject) => {
      const req = https.request(url, options, (res) => {
        let body = '';
        res.on('data', chunk => body += chunk);
        res.on('end', () => resolve(JSON.parse(body)));
      });
      
      req.on('error', reject);
      if (data) req.write(JSON.stringify(data));
      req.end();
    });
  }

  async searchDocuments(query, limit = 15) {
    return this.request('POST', 'documents.search', { query, limit });
  }

  async listDocuments(collectionId, limit = 25) {
    return this.request('POST', 'documents.list', { collectionId, limit });
  }

  async getDocument(id) {
    return this.request('POST', 'documents.info', { id });
  }

  async createDocument(collectionId, title, text = '', parentDocumentId = null) {
    return this.request('POST', 'documents.create', {
      collectionId,
      title,
      text,
      parentDocumentId,
    });
  }

  async updateDocument(id, title = null, text = null) {
    const data = {};
    if (title) data.title = title;
    if (text) data.text = text;
    return this.request('POST', 'documents.update', { id, ...data });
  }

  async listCollections(limit = 25) {
    return this.request('POST', 'collections.list', { limit });
  }

  async createCollection(name, description = '', icon = null) {
    return this.request('POST', 'collections.create', {
      name,
      description,
      icon,
    });
  }
}

module.exports = OutlineClient;
```

## Helpful Claude Code Commands

When using this skill in Claude Code, try these commands:

```
# Test Outline connection
/test-outline-connection

# List available collections
/list-collections

# Search all documents
/search-documents "keyword"

# Create a new document
/create-document "My Document" "Initial content here"

# Show skill info
/skill info outline-wiki
```

## Interactive Workflows

Claude Code's `codeForMakersKit` allows building interactive workflows. Example:

```javascript
const OutlineClient = require('./outline-api-client');

async function interactiveDocumentSearch() {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  // List all collections first
  const collections = await client.listCollections();
  console.log('Available collections:');
  collections.data.forEach((col, i) => {
    console.log(`${i + 1}. ${col.name} (${col.id})`);
  });

  // User can then select and search
  const selectedId = collections.data[0].id; // In real use, prompt user
  
  const docs = await client.listDocuments(selectedId);
  console.log(`\nDocuments in ${collections.data[0].name}:`);
  docs.data.forEach(doc => {
    console.log(`- ${doc.title}`);
  });
}

interactiveDocumentSearch().catch(console.error);
```

## File-Based Workflows

Claude Code can read/write files for batch operations:

```javascript
const fs = require('fs');
const OutlineClient = require('./outline-api-client');

async function importDocumentsFromCSV(csvPath, collectionId) {
  const client = new OutlineClient(
    process.env.OUTLINE_BASE_URL,
    process.env.OUTLINE_API_TOKEN
  );

  const csvContent = fs.readFileSync(csvPath, 'utf-8');
  const rows = csvContent.split('\n').slice(1); // Skip header

  for (const row of rows) {
    const [title, content] = row.split(',');
    if (title && content) {
      const result = await client.createDocument(
        collectionId,
        title.trim(),
        content.trim()
      );
      console.log(`Created: ${result.data.title}`);
    }
  }
}

importDocumentsFromCSV('./documents.csv', 'collection-id');
```

## Debugging and Logging

Claude Code has excellent debugging. Use these patterns:

```javascript
// Detailed request logging
class OutlineClient {
  async request(method, endpoint, data) {
    console.log(`[Outline] ${method} ${endpoint}`);
    console.log('[Outline] Payload:', JSON.stringify(data, null, 2));
    
    // ... make request ...
    
    console.log('[Outline] Response:', JSON.stringify(result, null, 2));
    return result;
  }
}

// Error handling with context
try {
  await client.searchDocuments('query');
} catch (error) {
  console.error('[Outline] API Error:', error.message);
  console.error('[Outline] Full error:', error);
  throw error;
}
```

## Performance Tips for Claude Code

1. **Batch requests** — Fetch multiple items together instead of in loops
2. **Cache results** — Store API responses in variables/files to avoid re-fetching
3. **Use pagination** — Specify `limit` and `offset` for large result sets
4. **Parallel requests** — Use Promise.all() for independent API calls

```javascript
// ✅ Good: Parallel requests
const [collections, docs] = await Promise.all([
  client.listCollections(),
  client.listDocuments(someId),
]);

// ❌ Avoid: Sequential requests when independent
const collections = await client.listCollections();
const docs = await client.listDocuments(someId); // Waits for above to finish
```

## Integration with Claude Code Features

### Code Execution

The skill works seamlessly with Claude Code's code execution:

```javascript
// Claude Code will execute this and show results
const OutlineClient = require('./outline-api-client');
const client = new OutlineClient(
  process.env.OUTLINE_BASE_URL,
  process.env.OUTLINE_API_TOKEN
);

client.searchDocuments('onboarding').then(results => {
  console.log(`Found ${results.data.length} documents`);
  results.data.forEach(doc => console.log(`- ${doc.document.title}`));
});
```

### File Creation

Claude Code can create files for you to download:

```javascript
const fs = require('fs');

// Generate a workspace setup guide
const guide = `
# Outline Workspace Setup

## Collections
- Main Documentation
- Reference Materials
- Archived

## Data Attributes
- Status (Draft, Published, Archived)
- Owner
- Last Updated
- Category
`;

fs.writeFileSync('WORKSPACE_SETUP.md', guide);
console.log('Setup guide created: WORKSPACE_SETUP.md');
```

---

For general skill usage, see [SKILL.md](./skills/outline-wiki/SKILL.md). For Paperclip-specific patterns, see [AGENTS.md](./AGENTS.md).
