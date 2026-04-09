# Contributing to Outline Wiki Skill

Thanks for your interest in improving this skill! Here's how to contribute.

## Before You Start

This skill is structured following the [Agent Skills spec](https://agentskills.io) used by Claude Code, Cursor, and other AI agents. All contributions must maintain compatibility across platforms.

## Skill Structure

```
skills/outline-wiki/
├── SKILL.md                          # Main skill (keep under 500 lines)
├── references/
│   ├── api-methods.md               # Full API specs
│   ├── data-attributes.md           # Attribute type definitions
│   ├── workspace-setup.md           # Setup templates
│   └── integration-examples.md      # Integration patterns
├── scripts/                         # Optional: executable code
│   └── example-integration.js
└── assets/                          # Optional: templates, data files
    └── workspace-template.json
```

## Types of Contributions

### 1. Bug Fixes

- Open an issue describing the problem
- Fork the repo and create a branch: `git checkout -b fix/your-bug-fix`
- Make your changes and test thoroughly
- Open a PR with a clear description of the fix

### 2. New API Methods or Patterns

- If documenting a new Outline API method:
  - Add it to `references/api-methods.md` with full params and return values
  - Add an example in `references/integration-examples.md`
  - Update the quick reference in main `SKILL.md`

- If adding a new workflow pattern:
  - Add to "Common Patterns" section or create a new reference doc
  - Include step-by-step instructions
  - Provide example code if applicable

### 3. Integration Examples

- Add to `references/integration-examples.md` with:
  - Tool/platform name
  - Use case
  - Step-by-step instructions
  - Code example (if applicable)
  - Any caveats or limitations

### 4. Documentation Improvements

- Clarity: Make explanations more understandable
- Examples: Add real-world examples to confusing sections
- References: Link to related resources
- Accuracy: Fix incorrect information

## Guidelines

### Writing Skills

- **Keep main SKILL.md under 500 lines** — move detailed info to references/
- **Use clear, concise language** — avoid jargon, explain concepts
- **Provide examples** — include realistic code examples
- **Link to related content** — reference other skills and related docs
- **Test your changes** — ensure examples work and are accurate

### Markdown Style

- Use H2 (##) for main sections, H3 (###) for subsections
- Code blocks with language syntax: ` ```javascript `, ` ```bash `
- Bullet points for lists, numbered lists for procedures
- Bold for important terms, italic for emphasis
- Links to related content and official docs

### API Documentation

When documenting API methods:

```markdown
#### `endpoint.method`
Brief description.

**Parameters:**
- `param1` (type, required/optional): Description
- `param2` (type, optional): Description

**Returns:** Description of return value

**Example:**
```javascript
const result = await api.endpoint.method({
  param1: 'value',
  param2: 123
});
```
```

### Common Patterns Template

When adding a workflow:

```markdown
### Pattern Name

Clear 1-2 sentence description.

**Steps:**
1. Call `endpoint.method` with params
2. Call `endpoint.method2` with result
3. Process and return output

**Best for:** Use case description

**Example:**
```javascript
// Code example here
```

**Related:** Link to related skills or docs
```

## Before Opening a PR

1. **Run validation:**
   ```bash
   ./validate-skills.sh
   ```

2. **Check your work:**
   - Is main SKILL.md under 500 lines?
   - Are all code examples tested and working?
   - Do all links point to real files?
   - Is the language clear and concise?

3. **Test across contexts:**
   - Can Claude Code users use this?
   - Does it work in Paperclip AI?
   - Is it agnostic enough for Cursor/Windsurf?

## PR Process

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make changes following guidelines above
3. Update related documentation
4. Commit with clear messages: `feat: add X pattern` or `docs: improve Y section`
5. Open PR with:
   - Clear title (e.g., "Add n8n integration example")
   - Description of what changed and why
   - Any related issues or discussions
   - Testing notes (how did you verify this works?)

## Code of Conduct

- Be respectful and constructive
- Assume good intentions
- Help others learn
- Report abuse to maintainers

## Questions?

- 📖 Check the [README](./README.md) and existing documentation
- 💬 Open a [discussion](https://github.com/KhairulA/outline-wiki-skill/discussions)
- 🐛 For bugs, [open an issue](https://github.com/KhairulA/outline-wiki-skill/issues)

## Recognition

Contributors will be recognized in:
- GitHub Releases and Contributors list
- README (for significant contributions)

Thanks for contributing! 🙏
