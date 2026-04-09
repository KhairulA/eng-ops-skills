# Outline Wiki Skill - Repository Structure

Complete repository structure for your public GitHub project.

```
outline-wiki-skill/
│
├── README.md                          # Main project readme (17.4k stars style)
├── CONTRIBUTING.md                    # Guidelines for contributors
├── CLAUDE.md                          # Claude Code-specific patterns
├── AGENTS.md                          # Paperclip AI integration patterns
├── LICENSE                            # MIT license
│
├── .github/
│   └── workflows/                     # CI/CD workflows
│       └── validate-skills.yml        # Validate skill format on PR
│
├── .claude-plugin/
│   └── manifest.json                  # Claude Code marketplace integration
│
├── skills/
│   └── outline-wiki/
│       ├── SKILL.md                   # Main skill (350-400 lines)
│       │
│       ├── references/
│       │   ├── api-methods.md         # Complete API specification
│       │   ├── data-attributes.md     # Attribute type definitions
│       │   ├── workspace-setup.md     # Setup templates and conventions
│       │   └── integration-examples.md # Real-world integration patterns
│       │
│       ├── scripts/
│       │   ├── test-connection.sh     # Test Outline API connectivity
│       │   └── generate-client.js     # Generate API client boilerplate
│       │
│       └── assets/
│           ├── workspace-template.json # Example workspace config
│           └── attributes-template.json # Recommended data attributes
│
├── validate-skills.sh                 # Local validation script
│
└── .gitignore
```

## Key Features of This Structure

### 1. Main SKILL.md (350-400 lines)
- Frontmatter with description and related skills
- Setup instructions
- Quick API reference (summaries only)
- Best practices and common patterns
- Troubleshooting section
- References to detailed docs

### 2. References/ Subdirectory
- `api-methods.md` — Full API specs with all parameters
- `data-attributes.md` — All attribute types with examples
- `workspace-setup.md` — Setup templates for different use cases
- `integration-examples.md` — n8n, Slack, Zapier, etc.

### 3. Supporting Documentation
- **CLAUDE.md** — Claude Code-specific features and patterns
- **AGENTS.md** — Paperclip AI integration and workflows
- **CONTRIBUTING.md** — How to improve the skill
- **README.md** — Quick start and overview

### 4. Scripts/ and Assets/
- Test connectivity without running full code
- Generate boilerplate API client
- Example workspace configs (copy and customize)
- Recommended data attribute templates

## Comparison to marketingskills

Your structure follows the proven marketingskills pattern:

| Aspect | marketingskills | outline-wiki-skill |
| --- | --- | --- |
| Main SKILL.md size | <500 lines | ~350-400 lines |
| API docs | In references/ | api-methods.md |
| Examples | In references/ | integration-examples.md |
| Context injection | Product context | Outline context |
| Cross-references | 30+ skills linked | skill dependencies |
| Installation methods | 6 methods | 6 methods |
| Stars | 17.4k | Starting point |

## Installation This Supports

```bash
# CLI
npx skills add KhairulA/outline-wiki-skill

# Claude Code plugin
/plugin marketplace add KhairulA/outline-wiki-skill

# Manual
git clone https://github.com/KhairulA/outline-wiki-skill.git

# Submodule
git submodule add https://github.com/KhairulA/outline-wiki-skill.git

# SkillKit (multi-agent)
npx skillkit install KhairulA/outline-wiki-skill
```

## Files Ready for Review

I've created all the core files:

1. ✅ **README.md** — Overview, setup, quick start
2. ✅ **SKILL.md** — Main skill definition (refactored)
3. ✅ **CLAUDE.md** — Claude Code patterns and examples
4. ✅ **AGENTS.md** — Paperclip AI integration guide
5. ✅ **CONTRIBUTING.md** — Contribution guidelines

Still needed (you can create):

6. 🔲 `skills/outline-wiki/references/api-methods.md` — Full API specs
7. 🔲 `skills/outline-wiki/references/data-attributes.md` — Attribute definitions
8. 🔲 `skills/outline-wiki/references/workspace-setup.md` — Setup templates
9. 🔲 `skills/outline-wiki/references/integration-examples.md` — Integration patterns
10. 🔲 `.claude-plugin/manifest.json` — Marketplace integration
11. 🔲 `validate-skills.sh` — Validation script

## How to Use These Files

1. **Download** all files I've created
2. **Organize** into the folder structure above
3. **Review** content - especially the generalized language
4. **Customize** as needed:
   - Replace placeholder GitHub URLs with your actual URLs
   - Add your personal links/contacts
   - Adjust tone if desired
5. **Push** to GitHub
6. **Test** installation with `npx skills add KhairulA/outline-wiki-skill`
