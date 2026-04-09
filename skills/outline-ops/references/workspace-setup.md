# Outline Ops Workspace Setup

Best practices and templates for organizing a new Outline workspace for maximum AI compatibility.

## Recommended Collection Structure

We recommend organizing collections by "Accessibility" or "Purpose":

| Collection | Icon | Purpose |
| :--- | :--- | :--- |
| **Engineering** | `Code` | Technical docs, API specs, diagrams. |
| **Product** | `BuildingBlocks` | Requirements, roadmaps, research findings. |
| **Operations** | `Settings` | Internal processes, onboarding, HR. |
| **Archive** | `Archive` | Outdated documentation for historical reference. |

## Standard Data Attributes
To make your wiki "Agent-ready," create these attributes immediately:

1. **Status** (`list`): `Draft`, `In Review`, `Published`, `Archived`.
2. **Owner** (`string`): The person or agent responsible for the content.
3. **Review Date** (`string`): Use YYYY-MM-DD format for consistency.
4. **Context Level** (`list`): `Internal`, `Public`, `Board-Only`.

## Naming Conventions
- **Document Titles**: Use descriptive titles. Avoid "V1", "Final". Use "Project X - Technical Requirement Specification".
- **Internal Links**: Use the `[[Title]]` or `[Title](doc-uuid)` syntax to link related documents. Agents should proactively link new docs to the "Index" or "README" of a collection.

## The "Index" Pattern
Every collection should have a document titled `_Index` or `0-README` pinned at the top. This document should:
1. Explain the purpose of the collection.
2. Link to key sub-documents.
3. Define any collection-specific conventions.

---

Return to [SKILL.md](../SKILL.md).
