# Security Policy

## Supported Versions

Only the latest `main` branch of this repository is supported for security updates.

| Version | Supported |
| ------- | --------- |
| 1.0.x   | ✅         |
| < 1.0   | ❌         |

## Reporting a Vulnerability

We take the security of our EngOps skills seriously. If you find a vulnerability (e.g., a way to bypass the PII Guard or a credential leak pattern), please do not open a public issue.

Instead, please send an email to **security@khairul.io** (or your designated security contact).

You can expect a response within **48 hours**. We use coordinated disclosure and will credit researchers for their findings.

## Our Security Commitments

1.  **Dependency Auditing**: We scan our integration examples and scripts for insecure dependencies.
2.  **Auth Hardening**: We only recommend token-based or OAuth2-based authentication.
3.  **Data Isolation**: None of the skills in this repo "call home" or transmit data to third-party endpoints other than the APIs you configure (Jira, GitHub, Outline).
4.  **PII-First Design**: Security is not an afterthought; it is a "Horizontal Core" of the project.

---

*Securing the workspace, one skill at a time.*
