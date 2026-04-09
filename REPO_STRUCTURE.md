# Repository Structure

This repository is organized as a **Monorepo of Skills** for AI agents, supported by a shared **Horizontal Core**.

## Directory Layout

```text
/
├── core/                  # [HORIZONTAL] Shared cross-skill logic
│   ├── security/          # PII filtering, secret detection
│   ├── logging/           # Standardized JSON audit logging
│   └── auth/              # Patterns for enterprise credentials
├── skills/                # [VERTICALS] Individual tool integrations
│   ├── outline-wiki/      # KnowledgeOps Vertical
│   │   ├── SKILL.md       # Primary skill definition
│   │   ├── README.md      # Skill-specific setup
│   │   └── references/    # API and architectural docs
│   ├── [next-skill]/      # Planned verticals (Jira, GitHub, etc.)
├── playbooks/             # [MULTI-SKILL] Cross-vertical workflows
├── AGENTS.md              # Overarching patterns for Paperclip/LLMs
├── CLAUDE.md              # Claude Code specific patterns
└── README.md              # Project vision and dashboard
```

## Key Components

### 1. The Core (Horizontals)
Located in `/core`. This directory contains the "Enterprise Grade" logic that distinguishes this library.
- **Goal**: Don't repeat yourself (DRY) across skills.
- **Logic**: Security, Error Handling, Logging, and Formatting.

### 2. The Skills (Verticals)
Located in `/skills`. Each subdirectory is a self-contained agent skill.
- **Goal**: High-fidelity interaction with a specific enterprise tool.
- **Rule**: Every skill must include a `SKILL.md` (for the machine) and a `README.md` (for the human).

### 3. The Playbooks
Located in `/playbooks`. These are "reciepes" for agents.
- **Goal**: Describe how to combine multiple skills to solve complex business problems.
- **Example**: "Syncing Slack transcripts to Outline via the PII Filter."

## Contributing to the Structure
- When adding a new tool, create a new directory in `skills/`.
- If you find logic that could be used by other skills, move it to `core/`.
- Keep the root simple; most of the technical depth should live in the `skills/` or `core/` folders.
