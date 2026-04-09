# Pull Request Template

## Description
Please describe the changes in this PR and how they contribute to the **EngOps Suite**.

## Type of Change
- [ ] New Vertical (Tool Integration)
- [ ] Horizontal Enhancement (Security, Logging, etc.)
- [ ] Documentation / Playbook
- [ ] Bug Fix

## The "EngOps Parity" Checklist (Mandatory for New Skills)
To maintain our enterprise status, every new skill vertical must include:
- [ ] `SKILL.md`: Machine-readable definition.
- [ ] `README.md`: Human-readable guide with "Horizontal Integration" section.
- [ ] `package.json`: Metadata for the monorepo.
- [ ] `references/api-methods.md`: Detailed documentation.
- [ ] `references/workspace-setup.md`: Admin setup guide.
- [ ] `references/integration-examples.md`: Practical patterns.
- [ ] `references/samples/*.json`: Mock API payloads for testing.

## Validation
- [ ] I have run `./validate-skills.sh` and it passed without errors.

## Privacy & Security
- [ ] No hardcoded API tokens or PII are included in this PR.
- [ ] All new logic is compatible with the `core/security` PII Guard.

---

*Thank you for helping us automate Engineering Operations!*
