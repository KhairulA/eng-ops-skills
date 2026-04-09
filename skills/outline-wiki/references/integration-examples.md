# Outline Wiki Integration Examples

Patterns for integrating Outline with common developer tools and workflows.

## 1. Paperclip AI Integration
See [AGENTS.md](../../AGENTS.md) for the full Paperclip guide.

**Workflow: Automated Tech Spec Review**
1. Developer creates a document in "Engineering" collection.
2. Paperclip agent detects "In Review" status (via periodic `documents.list` check).
3. Agent reads content with `documents.info`.
4. Agent performs analysis and adds a `comments.create` with feedback.
5. If clean, agent calls `documents.update` to change status to "Published".

## 2. Slack / Discord Notifications
**Workflow: New Document Alerts**
1. Use an n8n or Zapier webhook to monitor `documents.create` events (if webhooks are enabled in your Outline instance).
2. Format a message: `📖 New Wiki Entry: *[Title](URL)* in [Collection]`.
3. Post to relevant channel.

## 3. GitHub Actions Sync
**Workflow: Markdown to Wiki**
Sync repository documentation folder to Outline on every merge to `main`.
1. Use `documents.search` to find if a doc with the filename exists.
2. If yes, `documents.update`.
3. If no, `documents.create`.
4. Use the `editMode: "replace"` parameter to ensure the wiki match the repo code.

## 4. Onboarding Automation
**Workflow: Personalized Onboarding Doc**
1. Trigger: New user added to workspace.
2. Agent calls `documents.create` with a "Welcome [Name]" title.
3. Content is generated from a template + specific team info.
4. Document is nested under the team's "Onboarding" parent doc using `parentDocumentId`.

---

See [SKILL.md](../SKILL.md) for core commands.
