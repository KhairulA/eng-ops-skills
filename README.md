# EngOps Agent Skills for Paperclip AI

[![Paperclip](https://img.shields.io/badge/Platform-Paperclip%20AI-blueviolet)](https://paperclip.ai)
[![EngOps](https://img.shields.io/badge/Domain-Engineering%20Operations-blue)](https://github.com/KhairulA/eng-ops-skills)

A curated suite of enterprise-grade AI agent skills optimized for **Paperclip AI**. Build your next-gen **Engineering Operations (EngOps)** company with high-trust vertical integrations. This library provides the security, compliance, and tool-logic layers necessary for AI agents to operate safely within professional engineering organizations.

## The EngOps Matrix

Our skills are organized into three primary verticals supported by a high-trust horizontal core.

| | **KnowledgeOps** | **ExecutionOps** | **QualityOps** |
| :--- | :--- | :--- | :--- |
| **Pillar Tools** | Outline, Confluence | Jira, GitLab Issues | GitHub, GitLab MRs |
| **Goal** | Single Source of Truth | Task & Velocity | Trust & Compliance |

## Current Skills

| Skill | Category | Status | Description |
| :--- | :--- | :--- | :--- |
| [**Outline Ops**](./skills/outline-ops) | KnowledgeOps | ✅ Production | Deep integration with Outline docs and data attributes. |
| [**Confluence Ops**](./skills/confluence-ops) | KnowledgeOps | 🏗️ Planned | Enterprise documentation management in Confluence. |
| [**Notion Ops**](#) | KnowledgeOps | 🏗️  Planned | Documentation and project management in Notion. |
| [**Jira EngOps**](./skills/jira-ops) | ExecutionOps | 🧪 Beta | Task hygiene, status auditing, and project alignment. |
| [**GitHub EngOps**](./skills/github-ops) | QualityOps | 🧪 Beta | PR auditing, repo hygiene, and code governance. |
| [**GitLab EngOps**](./skills/gitlab-ops) | QualityOps | 🧪 Beta | MR auditing, issues management, and CI/CD monitoring. |


## Documentation

- **[Architecture](./ARCHITECTURE.md)**: The "EngOps Matrix" model (Verticals vs. Horizontals).
- **[Playbooks](./playbooks)**: Multi-skill workflows like the "EngOps Triad."
- **[Paperclip Setup](./AGENTS.md)**: Best practices and symlinking for Paperclip AI.
- **[Paperclip Agent Template](./templates/paperclip-agent.json)**: A copy-pasteable JSON configuration.
- **[Claude Code Setup](./CLAUDE.md)**: Patterns for the Claude Code terminal.

- **[Security Policy](./SECURITY.md)**: Vulnerability reporting and safety commitments.
- **[Code of Conduct](./CODE_OF_CONDUCT.md)**: Community participation standards.

## Why "EngOps" Skills?

General-purpose agent skills often lack the context and security required for enterprise environments. EngOps skills are built differently:

1.  **Audit-Ready**: Every action is logged in a standardized format for security review.
2.  **PII & Secret Aware**: Built-in filters to prevent agents from leaking sensitive data.
3.  **Cross-Tool Logic**: Designed to work together (e.g., an agent checking Jira status before updating a Wiki page).
4.  **Governance First**: Human-in-the-loop (HITL) patterns for destructive or high-impact actions.

## Built for the Paperclip AI Ecosystem

If you are building an AI company or scaling internal productivity with **Paperclip AI**, this repository is your foundational skill-set.

- **Native Discovery**: All skills include `SKILL.md` files, perfectly formatted for Paperclip's automatic tool discovery.
- **Enterprise-Ready**: Skip the "management tax" of building your own Jira/GitHub integrations.
- **Compliance-First**: Inherit enterprise-grade PII masking and audit logging from day one.
- **Scalable**: Start with a single skill and expand into the full "EngOps Triad" as your company grows.

## Installation

### 1. Ecosystem Standard (Rapid Install)
The recommended way to add these skills to your agent (Claude Code, Cursor, etc.) is using the **[skills.sh](https://skills.sh)** CLI:

```bash
# Add the full EngOps suite
npx skills add KhairulA/eng-ops-skills

# Add a specific vertical (e.g. Outline KnowledgeOps)
npx skills add KhairulA/eng-ops-skills/skills/outline-ops
```

### 2. Native for Paperclip AI
If you are building a company on **Paperclip AI**, you have two direct integration options:

#### Option A: Remote Injection (Dashboard / Cloud)
Paste the **Raw URL** of a `SKILL.md` into your agent's configuration:
- **Outline Ops**: `https://raw.githubusercontent.com/KhairulA/eng-ops-skills/main/skills/outline-ops/SKILL.md`
- **Jira EngOps**: `https://raw.githubusercontent.com/KhairulA/eng-ops-skills/main/skills/jira-ops/SKILL.md`

#### Option B: Local Discovery (Development / CLI)
Point your Paperclip instance to the `skills/` folder to natively discover all verticals:
```bash
npx paperclipai run --skills ./path/to/eng-ops-skills/skills
```

For advanced multi-skill orchestration, submodule patterns, and environment variable setup, see **[AGENTS.md](./AGENTS.md)**.

### For Developers

We provide **[Sample Payloads](./skills/outline-ops/references/samples)** for each skill to enable rapid testing and mocking without live API tokens.

## Horizontal Core

The `core/` directory contains shared modules used across all skills to ensure consistency:

- **[Security](./core/security)**: PII masking and secret detection (includes `SKILL.md` for native agent discovery).
- **[Logging](./core/logging)**: Standardized JSON audit logging for agent actions.
- **[Governance](./core/governance)**: Human-in-the-loop (HITL) and approval gate patterns.
- **[Authentication](./core/auth)**: Enterprise-grade credential management patterns.

## Coming Soon (Roadmap)

We are actively expanding the EngOps Matrix into new domains:

- [ ] **KnowledgeOps Expansion**: Confluence & Notion verticals to support diverse documentation stacks.
- [ ] **Communications Vertical**: Slack & Microsoft Teams integration for automated status reporting.
- [ ] **Incident Vertical**: PagerDuty & Opsgenie skills for SRE "Incident Shadowing" and post-mortem drafting.
- [ ] **FinOps Vertical**: AWS/GCP Cost Explorer integration for cloud spend auditing.
- [ ] **Advanced Policy Engine**: Executable Policy-as-Code for real-time agent validation.



## Contributing

We welcome contributions that follow our "Enterprise-Grade" standard. See **[CONTRIBUTING.md](./CONTRIBUTING.md)**.

---

**Built for the Agentic Era.**  
Maintainer: [KhairulA](https://github.com/KhairulA) | License: MIT
