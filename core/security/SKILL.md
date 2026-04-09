---
name: pii-guard
description: High-trust PII masking and secret detection. Use this core rule set before every write action to internal documentation or public logs to ensure compliance.
metadata:
  author: KhairulA
  version: 1.0.0
license: MIT
related: [outline-ops, jira-ops, github-ops]
---

# PII Guard Skill

A high-trust horizontal skill designed to protect sensitive data across the EngOps suite. This skill identifies and redacts patterns matching PII, API tokens, and internal secrets.

## Usage

Agents should be instructed to "run pii-guard rules" before any write action to internal documentation or public logs.

## Redaction Patterns

- **API Tokens**: Redacts Bearer tokens, GitHub PATs, and Jira tokens.
- **Identifiers**: Redacts emails, phone numbers, and IP addresses.
- **Secrets**: Redacts common password patterns and private keys.

## Implementation Pattern

When using this skill, the agent will:
1. Scan the input text for sensitive patterns.
2. Replace them with standard labels (e.g., `[REDACTED_EMAIL]`).
3. Return the sanitized text for further processing.

---

**Version:** 1.0  
**Core Module:** EngOps Horizontal Suite
