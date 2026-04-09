# Building EngOps Agents with Paperclip

EngOps agents are specialized Paperclip agents designed to reduce the "Management Tax" on engineering teams. They handle documentation, ticket hygiene, and compliance auditing.

## 1. Installation in Paperclip

Paperclip discovers skills by scanning the `.agents/` directory for folders containing a `SKILL.md`. To use the **EngOps Suite**, you must ensure the individual verticals are visible to the Paperclip scanner.

### Method A: The Suite Submodule (Recommended)
This method keeps you in sync with the entire EngOps project.

```bash
# 1. Add the suite to your paperclip project
git submodule add https://github.com/KhairulA/eng-ops-skills.git .agents/eng-ops

# 2. Expose specific skills to the Paperclip scanner via symlinks
ln -s eng-ops/skills/outline-ops .agents/outline-ops
ln -s eng-ops/skills/jira-ops .agents/jira-ops

ln -s eng-ops/skills/github-ops .agents/github-ops
ln -s eng-ops/core/security .agents/pii-guard
```

### Method B: Single Skill Install
If you only want one vertical:

```bash
git submodule add https://github.com/KhairulA/eng-ops-skills.git .agents/outline-ops
# Then update the Paperclip skill config to point to: .agents/outline-ops/skills/outline-ops
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
