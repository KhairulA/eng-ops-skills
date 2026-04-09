# EngOps Agent Skills

A curated suite of enterprise-grade AI agent skills focused on **Engineering Operations (EngOps)**. This library provides the "Horizontal" security and compliance layers and "Vertical" tool integrations necessary for agents to operate safely and effectively within professional engineering organizations.

## The EngOps Matrix

Our skills are organized into three primary verticals supported by a high-trust horizontal core.

| | **KnowledgeOps** | **ExecutionOps** | **GovernanceOps** |
| :--- | :--- | :--- | :--- |
| **Pillar Tools** | Outline, Confluence | Jira, Linear | GitHub Audit, Snyk |
| **Goal** | Single Source of Truth | Task & Velocity | Trust & Compliance |

## Current Skills

| Skill | Category | Status | Description |
| :--- | :--- | :--- | :--- |
| [**Outline Wiki**](./skills/outline-wiki) | KnowledgeOps | ✅ Production | Deep integration with Outline for docs and data attributes. |
| **Jira Alignment** | ExecutionOps | 🏗️ Planned | Syncing tasks with documentation and PRs. |
| **Access Auditor** | GovernanceOps | 🏗️ Planned | Auditing tool permissions for least-privilege agents. |

## Why "EngOps" Skills?

General-purpose agent skills often lack the context and security required for enterprise environments. EngOps skills are built differently:

1.  **Audit-Ready**: Every action is logged in a standardized format for security review.
2.  **PII & Secret Aware**: Built-in filters to prevent agents from leaking sensitive data.
3.  **Cross-Tool Logic**: Designed to work together (e.g., an agent checking Jira status before updating a Wiki page).
4.  **Policy-Driven**: Can be constrained by corporate policies defined in code.

## Getting Started

### Installation

Choose the individual skills you need for your agent:

```bash
# Add the Outline Wiki skill
npx skills add KhairulA/eng-ops-skills/skills/outline-wiki
```

### For Paperclip AI Agents

Configure your `.agents/` directory to include the skills:

```bash
git submodule add https://github.com/KhairulA/eng-ops-skills.git
```

## Horizontal Core

The `core/` directory contains shared modules used across all skills to ensure consistency:

- **`core/security`**: PII masking and secret detection.
- **`core/logging`**: Standardized JSON audit logging for agent actions.
- **`core/auth`**: Enterprise-grade credential management patterns.

## Roadmap

- [x] **Q1 2026**: Knowledge Vertical (Outline)
- [ ] **Q2 2026**: Execution Vertical (Jira/Linear) & Alignment Bridge
- [ ] **Q3 2026**: Quality & Security Vertical (GitHub PR Audit)
- [ ] **Q4 2026**: Horizontal Governance Layer (Policy-as-Code)

## Contributing

We welcome contributions that follow our "Enterprise-Grade" standard. See [CONTRIBUTING.md](./CONTRIBUTING.md).

---

**Built for the Agentic Era.**  
Maintainer: [KhairulA](https://github.com/KhairulA) | License: MIT
