# Building EngOps Agents with Paperclip

EngOps agents are specialized Paperclip agents designed to reduce the "Management Tax" on engineering teams. They handle documentation, ticket hygiene, and compliance auditing.

## 1. Installation in Paperclip
 
### Option 1: Remote Injection (Native)
Paperclip supports loading skills directly from GitHub URLs. Use the raw `SKILL.md` links for production environments to avoid managing local files.

### Option 2: Local Discovery (Development)
Paperclip natively discovers skills by scanning configured directories. For this monorepo, we recommend pointing Paperclip directly to the `skills/` folder:

```bash
npx paperclipai run --skills ./path/to/eng-ops-skills/skills
```

### Option 3: Submodule Pattern (Managed)
If you prefer to maintain the skills within your project's version control:

```bash
# 1. Add the suite as a submodule
git submodule add https://github.com/KhairulA/eng-ops-skills.git .agents/eng-ops

# 2. Symlink core horizontals (optional)
ln -s eng-ops/core/security .agents/pii-guard
```

---

## 2. Configuration (`.env`)

Paperclip loads these variables automatically for your agents. Add your enterprise tokens here:

```bash
# Knowledge (Outline)
OUTLINE_BASE_URL=https://wiki.your-org.com
OUTLINE_API_TOKEN=your_token

# Execution (Jira)
JIRA_INSTANCE_URL=https://your-org.atlassian.net
JIRA_USER_EMAIL=bot@your-org.com
JIRA_API_TOKEN=your_token

# Quality (GitHub)
GITHUB_TOKEN=your_token
GITHUB_OWNER=your-org
```

---

## 3. Sample Agent: `EngOps-Architect.json`

Create this file in your Paperclip `agents/` directory. It uses all three pillars of the suite.

```json
{
  "name": "EngOps Architect",
  "role": "Operational Alignment",
  "description": "Aligns Jira tickets, GitHub PRs, and Outline documentation.",
  "skills": [
    "outline-ops",
    "jira-ops",
    "github-ops",
    "pii-guard"
  ],
  "instructions": "You are a governance-first architect. Always apply the 'pii-guard' safety check before updating any public wiki document. When a PR is merged, update the corresponding Jira ticket and Outline doc."
}
```

---

## 4. Multi-Skill Workflow Pattern

In your Paperclip task definitions, you can now orchestrate these skills:

```javascript
{
  "task": "Perform Friday Audit",
  "steps": [
    "search jira-ops for 'Done' tickets from the last 7 days",
    "search github-ops for merged PRs matching those Jira keys",
    "search outline-ops for corresponding technical specs",
    "if gap found: update outline-ops doc and post summary to Slack"
  ]
}
```

---

*For detailed vertical documentation, see the [skills/](./skills) directory.*
