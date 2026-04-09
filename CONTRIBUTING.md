# Contributing to EngOps Agent Skills

Thanks for your interest in improving the EngOps suite! Here's how to contribute to our mission of automating engineering operations with high trust.

## The EngOps Philosophy

This isn't just a collection of scripts. We follow the **"Matrix Model"**:
1.  **Verticals**: Solve problems for a specific tool (Outline, Jira, GitHub).
2.  **Horizontals**: Provide shared security, logging, and governance (Core).

## Repository Structure

```
├── core/                         # Shared horizontal logic (Safety, Audit)
├── skills/                       # Individual tool verticals
│   └── [tool-name]/
│       ├── SKILL.md              # Main bot definition (Under 500 lines)
│       └── README.md             # Human setup guide
├── playbooks/                    # Cross-skill workflows
└── validate-skills.sh            # Global compliance checker
```

## Contribution Guidelines

### 1. Vertical Standards (New Skills)
- Every new skill directory must be placed in `skills/`.
- Must contain a `SKILL.md` (for the bot) and `README.md` (for the human).
- **Mandatory**: The `SKILL.md` must mention the use of `core/security` PII guarding in its "Best Practices" or "Safety" section.

### 2. Horizontal Standards (Core Logic)
- Improvements to `core/` should benefit multiple skills.
- Focus on security, compliance, and enterprise interoperability.

### 3. Playbook Standards
- Playbooks should demonstrate **Cross-Skill Synergy** (e.g., using both Jira and Outline).
- Must focus on a high-value operational outcome (Onboarding, Auditing, Automated Release Notes).

## Development Process

1. **Run Validation Often**:
   ```bash
   ./validate-skills.sh
   ```
2. **Follow least privilege**: Skills should only request the minimum required API scopes.
3. **Audit-Ready**: Ensure your skill actions can be logged in the standard format defined in `core/logging`.

## PR Process

1. Create a feature branch: `git checkout -b feat/add-linear-vertical`.
2. Ensure your changes follow the [Agent Skills spec](https://agentskills.io).
3. Update root documentation if adding a new vertical.
4. Open a PR with a description of the "EngOps Value" your change adds.

---

*Thank you for helping us automate the Engineering Management Tax!* 🙏
